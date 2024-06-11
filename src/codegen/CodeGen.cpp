#include "CodeGen.hpp"

#include "CodeGenUtil.hpp"

void CodeGen::allocate() {
    // 备份 $ra $fp
    unsigned offset = PROLOGUE_OFFSET_BASE;

    // 为每个参数分配栈空间
    for (auto &arg : context.func->get_args()) {
        auto size = arg.get_type()->get_size();
        offset = ALIGN(offset + size, size);
        context.offset_map[&arg] = -static_cast<int>(offset);
    }

    // 为指令结果分配栈空间
    for (auto &bb : context.func->get_basic_blocks()) {
        for (auto &instr : bb.get_instructions()) {
            // 每个非 void 的定值都分配栈空间
            if (not instr.is_void()) {
                auto size = instr.get_type()->get_size();
                offset = ALIGN(offset + size, size);
                context.offset_map[&instr] = -static_cast<int>(offset);
            }
            // alloca 的副作用：分配额外空间
            if (instr.is_alloca()) {
                auto *alloca_inst = static_cast<AllocaInst *>(&instr);
                auto alloc_size = alloca_inst->get_alloca_type()->get_size();
                offset += alloc_size;
            }
        }
    }

    // 分配栈空间，需要是 16 的整数倍
    context.frame_size = ALIGN(offset, PROLOGUE_ALIGN);
}

void CodeGen::load_to_greg(Value *val, const Reg &reg) {
    assert(val->get_type()->is_integer_type() ||
           val->get_type()->is_pointer_type());

    if (auto *constant = dynamic_cast<ConstantInt *>(val)) {
        int32_t val = constant->get_value();
        if (IS_IMM_12(val)) {
            append_inst(ADDI WORD, {reg.print(), "$zero", std::to_string(val)});
        } else {
            load_large_int32(val, reg);
        }
    } else if (auto *global = dynamic_cast<GlobalVariable *>(val)) {
        append_inst(LOAD_ADDR, {reg.print(), global->get_name()});
    } else {
        load_from_stack_to_greg(val, reg);
    }
}

void CodeGen::load_large_int32(int32_t val, const Reg &reg) {
    int32_t high_20 = val >> 12; // si20
    uint32_t low_12 = val & LOW_12_MASK;
    append_inst(LU12I_W, {reg.print(), std::to_string(high_20)});
    append_inst(ORI, {reg.print(), reg.print(), std::to_string(low_12)});
}

void CodeGen::load_large_int64(int64_t val, const Reg &reg) {
    auto low_32 = static_cast<int32_t>(val & LOW_32_MASK);
    load_large_int32(low_32, reg);

    auto high_32 = static_cast<int32_t>(val >> 32);
    int32_t high_32_low_20 = (high_32 << 12) >> 12; // si20
    int32_t high_32_high_12 = high_32 >> 20;        // si12
    append_inst(LU32I_D, {reg.print(), std::to_string(high_32_low_20)});
    append_inst(LU52I_D,
                {reg.print(), reg.print(), std::to_string(high_32_high_12)});
}

void CodeGen::load_from_stack_to_greg(Value *val, const Reg &reg) {
    auto offset = context.offset_map.at(val);
    auto offset_str = std::to_string(offset);
    auto *type = val->get_type();
    if (IS_IMM_12(offset)) {
        if (type->is_int1_type()) {
            append_inst(LOAD BYTE, {reg.print(), "$fp", offset_str});
        } else if (type->is_int32_type()) {
            append_inst(LOAD WORD, {reg.print(), "$fp", offset_str});
        } else { // Pointer
            append_inst(LOAD DOUBLE, {reg.print(), "$fp", offset_str});
        }
    } else {
        load_large_int64(offset, reg);
        append_inst(ADD DOUBLE, {reg.print(), "$fp", reg.print()});
        if (type->is_int1_type()) {
            append_inst(LOAD BYTE, {reg.print(), reg.print(), "0"});
        } else if (type->is_int32_type()) {
            append_inst(LOAD WORD, {reg.print(), reg.print(), "0"});
        } else { // Pointer
            append_inst(LOAD DOUBLE, {reg.print(), reg.print(), "0"});
        }
    }
}

void CodeGen::store_from_greg(Value *val, const Reg &reg) {
    auto offset = context.offset_map.at(val);
    auto offset_str = std::to_string(offset);
    auto *type = val->get_type();
    if (IS_IMM_12(offset)) {
        if (type->is_int1_type()) {
            append_inst(STORE BYTE, {reg.print(), "$fp", offset_str});
        } else if (type->is_int32_type()) {
            append_inst(STORE WORD, {reg.print(), "$fp", offset_str});
        } else { // Pointer
            append_inst(STORE DOUBLE, {reg.print(), "$fp", offset_str});
        }
    } else {
        auto addr = Reg::t(8);
        load_large_int64(offset, addr);
        append_inst(ADD DOUBLE, {addr.print(), "$fp", addr.print()});
        if (type->is_int1_type()) {
            append_inst(STORE BYTE, {reg.print(), addr.print(), "0"});
        } else if (type->is_int32_type()) {
            append_inst(STORE WORD, {reg.print(), addr.print(), "0"});
        } else { // Pointer
            append_inst(STORE DOUBLE, {reg.print(), addr.print(), "0"});
        }
    }
}

void CodeGen::load_to_freg(Value *val, const FReg &freg) {
    assert(val->get_type()->is_float_type());
    if (auto *constant = dynamic_cast<ConstantFP *>(val)) {
        float val = constant->get_value();
        load_float_imm(val, freg);
    } else {
        auto offset = context.offset_map.at(val);
        auto offset_str = std::to_string(offset);
        if (IS_IMM_12(offset)) {
            append_inst(FLOAD SINGLE, {freg.print(), "$fp", offset_str});
        } else {
            auto addr = Reg::t(8);
            load_large_int64(offset, addr);
            append_inst(ADD DOUBLE, {addr.print(), "$fp", addr.print()});
            append_inst(FLOAD SINGLE, {freg.print(), addr.print(), "0"});
        }
    }
}

void CodeGen::load_float_imm(float val, const FReg &r) {
    int32_t bytes = *reinterpret_cast<int32_t *>(&val);
    load_large_int32(bytes, Reg::t(8));
    append_inst(GR2FR WORD, {r.print(), Reg::t(8).print()});
}

void CodeGen::store_from_freg(Value *val, const FReg &r) {
    auto offset = context.offset_map.at(val);
    if (IS_IMM_12(offset)) {
        auto offset_str = std::to_string(offset);
        append_inst(FSTORE SINGLE, {r.print(), "$fp", offset_str});
    } else {
        auto addr = Reg::t(8);
        load_large_int64(offset, addr);
        append_inst(ADD DOUBLE, {addr.print(), "$fp", addr.print()});
        append_inst(FSTORE SINGLE, {r.print(), addr.print(), "0"});
    }
}

void CodeGen::gen_prologue() {
    // 寄存器备份及栈帧设置
    if (IS_IMM_12(-static_cast<int>(context.frame_size))) {
        append_inst("st.d $ra, $sp, -8");
        append_inst("st.d $fp, $sp, -16");
        append_inst("addi.d $fp, $sp, 0");
        append_inst("addi.d $sp, $sp, " +
                    std::to_string(-static_cast<int>(context.frame_size)));
    } else {
        load_large_int64(context.frame_size, Reg::t(0));
        append_inst("st.d $ra, $sp, -8");
        append_inst("st.d $fp, $sp, -16");
        append_inst("sub.d $sp, $sp, $t0");
        append_inst("add.d $fp, $sp, $t0");
    }

    // 将函数参数转移到栈帧上
    int garg_cnt = 0;
    int farg_cnt = 0;
    for (auto &arg : context.func->get_args()) {
        if (arg.get_type()->is_float_type()) {
            if(m->get_handle(&arg)!=-1){
                append_inst("movgr2fr.w $ft14, $zero");
                append_inst("fadd.s",{FReg::ft(m->get_handle(&arg)).print(),FReg::fa(garg_cnt++).print(),FReg::ft(14).print()});
            }
            else
                store_from_freg(&arg, FReg::fa(farg_cnt++));
        } else { // int or pointer
            if(m->get_handle(&arg)!=-1)
                append_inst("add.d",{Reg::t(m->get_handle(&arg)).print(),Reg::a(garg_cnt++).print(),"$zero"});
            else
                store_from_greg(&arg, Reg::a(garg_cnt++));
        }
    }
}

void CodeGen::gen_epilogue() {
    // TODO 根据你的理解设定函数的 epilogue
    output.emplace_back(context.func->get_name() + "_exit", ASMInstruction::Label);
    if (IS_IMM_12(-static_cast<int>(context.frame_size))) {
        append_inst("addi.d $sp, $sp, " +
                    std::to_string(static_cast<int>(context.frame_size)));
        append_inst("ld.d $ra, $sp, -8");
        append_inst("ld.d $fp, $sp, -16");   
    } else {
        load_large_int64(context.frame_size, Reg::t(0));
        append_inst("add.d $sp, $sp, $t0");
        append_inst("ld.d $ra, $sp, -8");
        append_inst("ld.d $fp, $sp, -16");
    }
    append_inst("jr $ra");
    //throw not_implemented_error{__FUNCTION__};
}

void CodeGen::gen_ret() {
    // TODO 函数返回，思考如何处理返回值、寄存器备份，如何返回调用者地址
    auto *returnInst = static_cast<ReturnInst *>(context.inst);
    if(returnInst->is_void_ret()){
        output.emplace_back("addi.w $a0, $zero, 0");
    }
    else if(returnInst->get_operand(0)->get_type()->is_float_type()){
        if(m->get_handle(returnInst->get_operand(0))!=-1){
            output.emplace_back("movgr2fr.w $ft14, $zero");
            append_inst("fadd.s",{FReg::fa(0).print(),
                FReg::ft(m->get_handle(returnInst->get_operand(0))).print(),FReg::ft(14).print()});
        }
        else
            load_to_freg(returnInst->get_operand(0), FReg::fa(0));
    }
    else{
        if(m->get_handle(returnInst->get_operand(0))!=-1)
            append_inst("add.w",{Reg::a(0).print(),
                Reg::t(m->get_handle(returnInst->get_operand(0))).print(),"$zero"});
        else
            load_to_greg(returnInst->get_operand(0), Reg::a(0));
    }
    output.emplace_back("b " + context.func->get_name() + "_exit");
    //throw not_implemented_error{__FUNCTION__};
}

void CodeGen::gen_br() {
    auto *branchInst = static_cast<BranchInst *>(context.inst);
    if (branchInst->is_cond_br()) {
        // TODO 补全条件跳转的情况
        if(m->get_handle(branchInst->get_operand(0))!=-1){
            auto *branchbb_true = static_cast<BasicBlock *>(branchInst->get_operand(1));
            auto *branchbb_false = static_cast<BasicBlock *>(branchInst->get_operand(2));
            if(!is_change(context.inst->get_parent(),branchbb_true,branchInst->get_operand(0))){
                phi_resort(context.inst->get_parent());
                move_data(true_val_move);
                append_inst("bnez",{Reg::t(m->get_handle(branchInst->get_operand(0))).print(),
                    label_name(branchbb_true)});
                move_data(false_val_move);
                output.emplace_back("b " + label_name(branchbb_false));
            }
            else{
                store_from_greg(branchInst->get_operand(0),Reg::t(m->get_handle(branchInst->get_operand(0))));
                phi_resort(context.inst->get_parent());
                move_data(true_val_move);
                load_to_greg(branchInst->get_operand(0),Reg::t(7));
                append_inst("bnez",{Reg::t(7).print(),
                    label_name(branchbb_true)});
                move_data(false_val_move);
                output.emplace_back("b " + label_name(branchbb_false));
            }       
        }
        else{
            auto *branchbb_true = static_cast<BasicBlock *>(branchInst->get_operand(1));
            auto *branchbb_false = static_cast<BasicBlock *>(branchInst->get_operand(2));
            phi_resort(context.inst->get_parent());
            move_data(true_val_move);
            load_to_greg(branchInst->get_operand(0), Reg::t(7));
            append_inst("bnez",{Reg::t(7).print(),
                label_name(branchbb_true)});
            move_data(false_val_move);
            output.emplace_back("b " + label_name(branchbb_false));
            // throw not_implemented_error{__FUNCTION__};
        }
    } else {
        auto *branchbb = static_cast<BasicBlock *>(branchInst->get_operand(0));
        phi_resort(context.inst->get_parent());
        move_data(true_val_move);
        output.emplace_back("b " + label_name(branchbb));
    }
}

void CodeGen::gen_binary() {
    // 分别将左右操作数加载到 $t0 $t1
    if(m->get_handle(context.inst)!=-1){
        if(m->get_handle(context.inst->get_operand(0))!=-1&&m->get_handle(context.inst->get_operand(1))!=-1){
            switch (context.inst->get_instr_type()) {
            case Instruction::add:
                append_inst("add.w",{Reg::t(m->get_handle(context.inst)).print(),
                    Reg::t(m->get_handle(context.inst->get_operand(0))).print(),
                    Reg::t(m->get_handle(context.inst->get_operand(1))).print()});
                break;
            case Instruction::sub:
                append_inst("sub.w",{Reg::t(m->get_handle(context.inst)).print(),
                    Reg::t(m->get_handle(context.inst->get_operand(0))).print(),
                    Reg::t(m->get_handle(context.inst->get_operand(1))).print()});
                break;
            case Instruction::mul:
                append_inst("mul.w",{Reg::t(m->get_handle(context.inst)).print(),
                    Reg::t(m->get_handle(context.inst->get_operand(0))).print(),
                    Reg::t(m->get_handle(context.inst->get_operand(1))).print()});
                break;
            case Instruction::sdiv:
                append_inst("div.w",{Reg::t(m->get_handle(context.inst)).print(),
                    Reg::t(m->get_handle(context.inst->get_operand(0))).print(),
                    Reg::t(m->get_handle(context.inst->get_operand(1))).print()});
                break;
            default:
                assert(false);
            }
        }
        else if(m->get_handle(context.inst->get_operand(0))==-1&&m->get_handle(context.inst->get_operand(1))!=-1){
            load_to_greg(context.inst->get_operand(0), Reg::t(7));
            switch (context.inst->get_instr_type()) {
            case Instruction::add:
                append_inst("add.w",{Reg::t(m->get_handle(context.inst)).print(),
                    Reg::t(7).print(),
                    Reg::t(m->get_handle(context.inst->get_operand(1))).print()});
                break;
            case Instruction::sub:
                append_inst("sub.w",{Reg::t(m->get_handle(context.inst)).print(),
                    Reg::t(7).print(),
                    Reg::t(m->get_handle(context.inst->get_operand(1))).print()});
                break;
            case Instruction::mul:
                append_inst("mul.w",{Reg::t(m->get_handle(context.inst)).print(),
                    Reg::t(7).print(),
                    Reg::t(m->get_handle(context.inst->get_operand(1))).print()});
                break;
            case Instruction::sdiv:
                append_inst("div.w",{Reg::t(m->get_handle(context.inst)).print(),
                    Reg::t(7).print(),
                    Reg::t(m->get_handle(context.inst->get_operand(1))).print()});
                break;
            default:
                assert(false);
            }
        }
        else if(m->get_handle(context.inst->get_operand(0))!=-1&&m->get_handle(context.inst->get_operand(1))==-1){
            load_to_greg(context.inst->get_operand(1), Reg::t(8));
            switch (context.inst->get_instr_type()) {
            case Instruction::add:
                append_inst("add.w",{Reg::t(m->get_handle(context.inst)).print(),
                    Reg::t(m->get_handle(context.inst->get_operand(0))).print(),
                    Reg::t(8).print()});
                break;
            case Instruction::sub:
                append_inst("sub.w",{Reg::t(m->get_handle(context.inst)).print(),
                    Reg::t(m->get_handle(context.inst->get_operand(0))).print(),
                    Reg::t(8).print()});
                break;
            case Instruction::mul:
                append_inst("mul.w",{Reg::t(m->get_handle(context.inst)).print(),
                    Reg::t(m->get_handle(context.inst->get_operand(0))).print(),
                    Reg::t(8).print()});
                break;
            case Instruction::sdiv:
                append_inst("div.w",{Reg::t(m->get_handle(context.inst)).print(),
                    Reg::t(m->get_handle(context.inst->get_operand(0))).print(),
                    Reg::t(8).print()});
                break;
            default:
                assert(false);
            }
        }
        else{
            load_to_greg(context.inst->get_operand(0), Reg::t(7));
            load_to_greg(context.inst->get_operand(1), Reg::t(8));
            switch (context.inst->get_instr_type()) {
            case Instruction::add:
                append_inst("add.w",{Reg::t(m->get_handle(context.inst)).print(),
                    Reg::t(7).print(),
                    Reg::t(8).print()});
                break;
            case Instruction::sub:
                append_inst("sub.w",{Reg::t(m->get_handle(context.inst)).print(),
                    Reg::t(7).print(),
                    Reg::t(8).print()});
                break;
            case Instruction::mul:
                append_inst("mul.w",{Reg::t(m->get_handle(context.inst)).print(),
                    Reg::t(7).print(),
                    Reg::t(8).print()});
                break;
            case Instruction::sdiv:
                append_inst("div.w",{Reg::t(m->get_handle(context.inst)).print(),
                    Reg::t(7).print(),
                    Reg::t(8).print()});
                break;
            default:
                assert(false);
            }
        }
    }
    else{
        if(m->get_handle(context.inst->get_operand(0))!=-1&&m->get_handle(context.inst->get_operand(1))!=-1){
            switch (context.inst->get_instr_type()) {
            case Instruction::add:
                append_inst("add.w",{Reg::t(7).print(),
                    Reg::t(m->get_handle(context.inst->get_operand(0))).print(),
                    Reg::t(m->get_handle(context.inst->get_operand(1))).print()});
                break;
            case Instruction::sub:
                append_inst("sub.w",{Reg::t(7).print(),
                    Reg::t(m->get_handle(context.inst->get_operand(0))).print(),
                    Reg::t(m->get_handle(context.inst->get_operand(1))).print()});
                break;
            case Instruction::mul:
                append_inst("mul.w",{Reg::t(7).print(),
                    Reg::t(m->get_handle(context.inst->get_operand(0))).print(),
                    Reg::t(m->get_handle(context.inst->get_operand(1))).print()});
                break;
            case Instruction::sdiv:
                append_inst("div.w",{Reg::t(7).print(),
                    Reg::t(m->get_handle(context.inst->get_operand(0))).print(),
                    Reg::t(m->get_handle(context.inst->get_operand(1))).print()});
                break;
            default:
                assert(false);
            }
            store_from_greg(context.inst, Reg::t(7));
        }
        else if(m->get_handle(context.inst->get_operand(0))==-1&&m->get_handle(context.inst->get_operand(1))!=-1){
            load_to_greg(context.inst->get_operand(0), Reg::t(7));
            switch (context.inst->get_instr_type()) {
            case Instruction::add:
                append_inst("add.w",{Reg::t(7).print(),
                    Reg::t(7).print(),
                    Reg::t(m->get_handle(context.inst->get_operand(1))).print()});
                break;
            case Instruction::sub:
                append_inst("sub.w",{Reg::t(7).print(),
                    Reg::t(7).print(),
                    Reg::t(m->get_handle(context.inst->get_operand(1))).print()});
                break;
            case Instruction::mul:
                append_inst("mul.w",{Reg::t(7).print(),
                    Reg::t(7).print(),
                    Reg::t(m->get_handle(context.inst->get_operand(1))).print()});
                break;
            case Instruction::sdiv:
                append_inst("div.w",{Reg::t(7).print(),
                    Reg::t(7).print(),
                    Reg::t(m->get_handle(context.inst->get_operand(1))).print()});
                break;
            default:
                assert(false);
            }
            store_from_greg(context.inst, Reg::t(7));
        }
        else if(m->get_handle(context.inst->get_operand(0))!=-1&&m->get_handle(context.inst->get_operand(1))==-1){
            load_to_greg(context.inst->get_operand(1), Reg::t(7));
            switch (context.inst->get_instr_type()) {
            case Instruction::add:
                append_inst("add.w",{Reg::t(7).print(),
                    Reg::t(m->get_handle(context.inst->get_operand(0))).print(),
                    Reg::t(7).print()});
                break;
            case Instruction::sub:
                append_inst("sub.w",{Reg::t(7).print(),
                    Reg::t(m->get_handle(context.inst->get_operand(0))).print(),
                    Reg::t(7).print()});
                break;
            case Instruction::mul:
                append_inst("mul.w",{Reg::t(7).print(),
                    Reg::t(m->get_handle(context.inst->get_operand(0))).print(),
                    Reg::t(7).print()});
                break;
            case Instruction::sdiv:
                append_inst("div.w",{Reg::t(7).print(),
                    Reg::t(m->get_handle(context.inst->get_operand(0))).print(),
                    Reg::t(7).print()});
                break;
            default:
                assert(false);
            }
            store_from_greg(context.inst, Reg::t(7));
        }
        else{
            load_to_greg(context.inst->get_operand(0), Reg::t(7));
            load_to_greg(context.inst->get_operand(1), Reg::t(8));
            switch (context.inst->get_instr_type()) {
            case Instruction::add:
                append_inst("add.w",{Reg::t(7).print(),
                    Reg::t(7).print(),
                    Reg::t(8).print()});
                break;
            case Instruction::sub:
                append_inst("sub.w",{Reg::t(7).print(),
                    Reg::t(7).print(),
                    Reg::t(8).print()});
                break;
            case Instruction::mul:
                append_inst("mul.w",{Reg::t(7).print(),
                    Reg::t(7).print(),
                    Reg::t(8).print()});
                break;
            case Instruction::sdiv:
                append_inst("div.w",{Reg::t(7).print(),
                    Reg::t(7).print(),
                    Reg::t(8).print()});
                break;
            default:
                assert(false);
            }
            store_from_greg(context.inst, Reg::t(7));
        }
    }
}

void CodeGen::gen_float_binary() {
    // TODO 浮点类型的二元指令
    // 分别将左右操作数加载到 $t0 $t1
    if(m->get_handle(context.inst)!=-1){
        if(m->get_handle(context.inst->get_operand(0))!=-1&&m->get_handle(context.inst->get_operand(1))!=-1){
            switch (context.inst->get_instr_type()) {
            case Instruction::fadd:
                append_inst("fadd.s",{FReg::ft(m->get_handle(context.inst)).print(),
                FReg::ft(m->get_handle(context.inst->get_operand(0))).print(),
                FReg::ft(m->get_handle(context.inst->get_operand(1))).print()});
                break;
            case Instruction::fsub:
                append_inst("fsub.s",{FReg::ft(m->get_handle(context.inst)).print(),
                FReg::ft(m->get_handle(context.inst->get_operand(0))).print(),
                FReg::ft(m->get_handle(context.inst->get_operand(1))).print()});
                break;
            case Instruction::fmul:
                append_inst("fmul.s",{FReg::ft(m->get_handle(context.inst)).print(),
                FReg::ft(m->get_handle(context.inst->get_operand(0))).print(),
                FReg::ft(m->get_handle(context.inst->get_operand(1))).print()});
                break;
            case Instruction::fdiv:
                append_inst("fdiv.s",{FReg::ft(m->get_handle(context.inst)).print(),
                FReg::ft(m->get_handle(context.inst->get_operand(0))).print(),
                FReg::ft(m->get_handle(context.inst->get_operand(1))).print()});
                break;
            default:
                assert(false);
            }
        }
        else if(m->get_handle(context.inst->get_operand(0))==-1&&m->get_handle(context.inst->get_operand(1))!=-1){
            load_to_freg(context.inst->get_operand(0), FReg::ft(14));
            switch (context.inst->get_instr_type()){
            case Instruction::fadd:
                append_inst("fadd.s",{FReg::ft(m->get_handle(context.inst)).print(),
                FReg::ft(14).print(),
                FReg::ft(m->get_handle(context.inst->get_operand(1))).print()});
                break;
            case Instruction::fsub:
                append_inst("fsub.s",{FReg::ft(m->get_handle(context.inst)).print(),
                FReg::ft(14).print(),
                FReg::ft(m->get_handle(context.inst->get_operand(1))).print()});
                break;
            case Instruction::fmul:
                append_inst("fmul.s",{FReg::ft(m->get_handle(context.inst)).print(),
                FReg::ft(14).print(),
                FReg::ft(m->get_handle(context.inst->get_operand(1))).print()});
                break;
            case Instruction::fdiv:
                append_inst("fdiv.s",{FReg::ft(m->get_handle(context.inst)).print(),
                FReg::ft(14).print(),
                FReg::ft(m->get_handle(context.inst->get_operand(1))).print()});
                break;
            default:
                assert(false);
            }
        }
        else if(m->get_handle(context.inst->get_operand(0))!=-1&&m->get_handle(context.inst->get_operand(1))==-1){
            load_to_freg(context.inst->get_operand(1), FReg::ft(14));
            switch (context.inst->get_instr_type()){
            case Instruction::fadd:
                append_inst("fadd.s",{FReg::ft(m->get_handle(context.inst)).print(),
                FReg::ft(m->get_handle(context.inst->get_operand(0))).print(),
                FReg::ft(14).print()});
                break;
            case Instruction::fsub:
                append_inst("fsub.s",{FReg::ft(m->get_handle(context.inst)).print(),
                FReg::ft(m->get_handle(context.inst->get_operand(0))).print(),
                FReg::ft(14).print()});
                break;
            case Instruction::fmul:
                append_inst("fmul.s",{FReg::ft(m->get_handle(context.inst)).print(),
                FReg::ft(m->get_handle(context.inst->get_operand(0))).print(),
                FReg::ft(14).print()});
                break;
            case Instruction::fdiv:
                append_inst("fdiv.s",{FReg::ft(m->get_handle(context.inst)).print(),
                FReg::ft(m->get_handle(context.inst->get_operand(0))).print(),
                FReg::ft(14).print()});
                break;
            default:
                assert(false);
            }
        }
        else{
            load_to_freg(context.inst->get_operand(0), FReg::ft(14));
            load_to_freg(context.inst->get_operand(1), FReg::ft(15));
            switch (context.inst->get_instr_type()){
            case Instruction::fadd:
                append_inst("fadd.s",{FReg::ft(m->get_handle(context.inst)).print(),
                FReg::ft(14).print(),
                FReg::ft(15).print()});
                break;
            case Instruction::fsub:
                append_inst("fsub.s",{FReg::ft(m->get_handle(context.inst)).print(),
                FReg::ft(14).print(),
                FReg::ft(15).print()});
                break;
            case Instruction::fmul:
                append_inst("fmul.s",{FReg::ft(m->get_handle(context.inst)).print(),
                FReg::ft(14).print(),
                FReg::ft(15).print()});
                break;
            case Instruction::fdiv:
                append_inst("fdiv.s",{FReg::ft(m->get_handle(context.inst)).print(),
                FReg::ft(14).print(),
                FReg::ft(15).print()});
                break;
            default:
                assert(false);
            }
        }
    }
    else{
        if(m->get_handle(context.inst->get_operand(0))!=-1&&m->get_handle(context.inst->get_operand(1))!=-1){
            switch (context.inst->get_instr_type()) {
            case Instruction::fadd:
                append_inst("fadd.s",{FReg::ft(14).print(),
                FReg::ft(m->get_handle(context.inst->get_operand(0))).print(),
                FReg::ft(m->get_handle(context.inst->get_operand(1))).print()});
                break;
            case Instruction::fsub:
                append_inst("fsub.s",{FReg::ft(14).print(),
                FReg::ft(m->get_handle(context.inst->get_operand(0))).print(),
                FReg::ft(m->get_handle(context.inst->get_operand(1))).print()});
                break;
            case Instruction::fmul:
                append_inst("fmul.s",{FReg::ft(14).print(),
                FReg::ft(m->get_handle(context.inst->get_operand(0))).print(),
                FReg::ft(m->get_handle(context.inst->get_operand(1))).print()});
                break;
            case Instruction::fdiv:
                append_inst("fdiv.s",{FReg::ft(14).print(),
                FReg::ft(m->get_handle(context.inst->get_operand(0))).print(),
                FReg::ft(m->get_handle(context.inst->get_operand(1))).print()});
                break;
            default:
                assert(false);
            }
            store_from_freg(context.inst, FReg::ft(14));
        }
        else if(m->get_handle(context.inst->get_operand(0))==-1&&m->get_handle(context.inst->get_operand(1))!=-1){
            load_to_freg(context.inst->get_operand(0), FReg::ft(14));
            switch (context.inst->get_instr_type()){
            case Instruction::fadd:
                append_inst("fadd.s",{FReg::ft(14).print(),
                FReg::ft(14).print(),
                FReg::ft(m->get_handle(context.inst->get_operand(1))).print()});
                break;
            case Instruction::fsub:
                append_inst("fsub.s",{FReg::ft(14).print(),
                FReg::ft(14).print(),
                FReg::ft(m->get_handle(context.inst->get_operand(1))).print()});
                break;
            case Instruction::fmul:
                append_inst("fmul.s",{FReg::ft(14).print(),
                FReg::ft(14).print(),
                FReg::ft(m->get_handle(context.inst->get_operand(1))).print()});
                break;
            case Instruction::fdiv:
                append_inst("fdiv.s",{FReg::ft(14).print(),
                FReg::ft(14).print(),
                FReg::ft(m->get_handle(context.inst->get_operand(1))).print()});
                break;
            default:
                assert(false);
            }
            store_from_freg(context.inst, FReg::ft(14));
        }
        else if(m->get_handle(context.inst->get_operand(0))==-1&&m->get_handle(context.inst->get_operand(1))!=-1){
            load_to_freg(context.inst->get_operand(1), FReg::ft(14));
            switch (context.inst->get_instr_type()){
            case Instruction::fadd:
                append_inst("fadd.s",{FReg::ft(14).print(),
                FReg::ft(m->get_handle(context.inst->get_operand(0))).print(),
                FReg::ft(14).print()});
                break;
            case Instruction::fsub:
                append_inst("fsub.s",{FReg::ft(14).print(),
                FReg::ft(m->get_handle(context.inst->get_operand(0))).print(),
                FReg::ft(14).print()});
                break;
            case Instruction::fmul:
                append_inst("fmul.s",{FReg::ft(14).print(),
                FReg::ft(m->get_handle(context.inst->get_operand(0))).print(),
                FReg::ft(14).print()});
                break;
            case Instruction::fdiv:
                append_inst("fdiv.s",{FReg::ft(14).print(),
                FReg::ft(m->get_handle(context.inst->get_operand(0))).print(),
                FReg::ft(14).print()});
                break;
            default:
                assert(false);
            }
            store_from_freg(context.inst, FReg::ft(14));
        }
        else{
            load_to_freg(context.inst->get_operand(0), FReg::ft(14));
            load_to_freg(context.inst->get_operand(1), FReg::ft(15));
            switch (context.inst->get_instr_type()){
            case Instruction::fadd:
                append_inst("fadd.s",{FReg::ft(14).print(),
                FReg::ft(14).print(),
                FReg::ft(15).print()});
                break;
            case Instruction::fsub:
                append_inst("fsub.s",{FReg::ft(14).print(),
                FReg::ft(14).print(),
                FReg::ft(15).print()});
                break;
            case Instruction::fmul:
                append_inst("fmul.s",{FReg::ft(14).print(),
                FReg::ft(14).print(),
                FReg::ft(15).print()});
                break;
            case Instruction::fdiv:
                append_inst("fdiv.s",{FReg::ft(14).print(),
                FReg::ft(14).print(),
                FReg::ft(15).print()});
                break;
            default:
                assert(false);
            }
            store_from_freg(context.inst, FReg::ft(14));
        }
    }
    //throw not_implemented_error{__FUNCTION__};
}

void CodeGen::gen_alloca() {
    /* 我们已经为 alloca 的内容分配空间，在此我们还需保存 alloca
     * 指令自身产生的定值，即指向 alloca 空间起始地址的指针
     */
    // TODO 将 alloca 出空间的起始地址保存在栈帧上
    
    auto offset = context.offset_map.at(context.inst);
    auto *alloca_inst = static_cast<AllocaInst *>(context.inst);
    auto alloc_size = alloca_inst->get_alloca_type()->get_size();
    int size = (int)alloc_size;
    if(m->get_handle(alloca_inst)==-1){
        if(IS_IMM_12(offset - size)){
            append_inst("addi.d $t8, $fp, " + std::to_string(offset - size));
        } 
        else{
            auto addr8 = Reg::t(8);
            load_large_int64(offset - size, addr8);
            append_inst("add.d $t8, $fp, $t8");
        }
        if(IS_IMM_12(offset)){
            append_inst("addi.d $t7, $fp, " + std::to_string(offset));
        } 
        else{
            auto addr7 = Reg::t(7);
            load_large_int64(offset, addr7);
            append_inst("add.d $t7, $fp, $t7");
        }
        append_inst("st.d $t8, $t7, 0");
    }
    else{
        if(IS_IMM_12(offset - size)){
            append_inst("addi.d",{Reg::t(m->get_handle(alloca_inst)).print(),"$fp",std::to_string(offset - size)});
        } 
        else{
            auto addr8 = Reg::t(8);
            load_large_int64(offset - size, addr8);
            append_inst("add.d",{Reg::t(m->get_handle(alloca_inst)).print(),"$fp",Reg::t(8).print()});
        }
    }
    //throw not_implemented_error{__FUNCTION__};
}

void CodeGen::gen_load() {
    auto *type = context.inst->get_type();
    if(m->get_handle(context.inst)!=-1){
        if(m->get_handle(context.inst->get_operand(0))!=-1){
            if (type->is_float_type()) {
                append_inst("fld.s", {FReg::ft(m->get_handle(context.inst)).print(),
                    Reg::t(m->get_handle(context.inst->get_operand(0))).print(),"0"});
            } 
            // the code below should distinguish "ld.w" and "ld.d"
            else if(type->is_int32_type()){
                // TODO load 整数类型的数据
                append_inst("ld.w", {Reg::t(m->get_handle(context.inst)).print(),
                    Reg::t(m->get_handle(context.inst->get_operand(0))).print(),"0"});
                //throw not_implemented_error{__FUNCTION__};
            }
            else{
                append_inst("ld.d", {Reg::t(m->get_handle(context.inst)).print(),
                    Reg::t(m->get_handle(context.inst->get_operand(0))).print(),"0"});
            }
        }
        else{
            if (type->is_float_type()) {
                load_to_greg(context.inst->get_operand(0), Reg::t(8));
                append_inst("fld.s", {FReg::ft(m->get_handle(context.inst)).print(),
                    Reg::t(8).print(),"0"});
            } 
            // the code below should distinguish "ld.w" and "ld.d"
            else if(type->is_int32_type()){
                // TODO load 整数类型的数据
                load_to_greg(context.inst->get_operand(0), Reg::t(8));
                append_inst("ld.w", {Reg::t(m->get_handle(context.inst)).print(),
                    Reg::t(8).print(),"0"});
            }
            else{
                load_to_greg(context.inst->get_operand(0), Reg::t(8));
                append_inst("ld.d", {Reg::t(m->get_handle(context.inst)).print(),
                    Reg::t(8).print(),"0"});
            }
        }
    }
    else{
        if(m->get_handle(context.inst->get_operand(0))!=-1){
            if (type->is_float_type()) {
                append_inst("fld.s", {FReg::ft(14).print(),
                    Reg::t(m->get_handle(context.inst->get_operand(0))).print(),"0"});
                store_from_freg(context.inst, FReg::ft(14));
            } 
            // the code below should distinguish "ld.w" and "ld.d"
            else if(type->is_int32_type()){
                // TODO load 整数类型的数据
                append_inst("ld.w", {Reg::t(7).print(),
                    Reg::t(m->get_handle(context.inst->get_operand(0))).print(),"0"});
                store_from_greg(context.inst, Reg::t(7));
                //throw not_implemented_error{__FUNCTION__};
            }
            else{
                append_inst("ld.d", {Reg::t(7).print(),
                    Reg::t(m->get_handle(context.inst->get_operand(0))).print(),"0"});
                store_from_greg(context.inst, Reg::t(7));
            }
        }
        else{
            if (type->is_float_type()) {
                load_to_greg(context.inst->get_operand(0), Reg::t(8));
                append_inst("fld.s", {FReg::ft(14).print(),
                    Reg::t(8).print(),"0"});
                store_from_freg(context.inst, FReg::ft(14));
            } 
            // the code below should distinguish "ld.w" and "ld.d"
            else if(type->is_int32_type()){
                // TODO load 整数类型的数据
                load_to_greg(context.inst->get_operand(0), Reg::t(8));
                append_inst("ld.w", {Reg::t(7).print(),
                    Reg::t(8).print(),"0"});
                store_from_greg(context.inst, Reg::t(7));
                //throw not_implemented_error{__FUNCTION__};
            }
            else{
                load_to_greg(context.inst->get_operand(0), Reg::t(8));
                append_inst("ld.d", {Reg::t(7).print(),
                    Reg::t(8).print(),"0"});
                store_from_greg(context.inst, Reg::t(7));
            }
        }
    }
}

void CodeGen::gen_store() {
    // TODO 翻译 store 指令
    auto *type = context.inst->get_operand(0)->get_type();
    if(m->get_handle(context.inst->get_operand(1))!=-1){
        if(m->get_handle(context.inst->get_operand(0))!=-1){
            if(type->is_float_type()){
                append_inst("fst.s",{FReg::ft(m->get_handle(context.inst->get_operand(0))).print(), 
                    Reg::t(m->get_handle(context.inst->get_operand(1))).print(),"0"});
            }
            // the code below should distinguish "st.w" and "st.d"
            else if(type->is_int32_type()){ 
                append_inst("st.w",{Reg::t(m->get_handle(context.inst->get_operand(0))).print(), 
                    Reg::t(m->get_handle(context.inst->get_operand(1))).print(),"0"});
            }
            else{
                append_inst("st.d",{Reg::t(m->get_handle(context.inst->get_operand(0))).print(), 
                    Reg::t(m->get_handle(context.inst->get_operand(1))).print(),"0"});
            }
        }
        else{
            if(type->is_float_type()){
                load_to_freg(context.inst->get_operand(0), FReg::ft(14));
                append_inst("fst.s",{FReg::ft(14).print(), 
                    Reg::t(m->get_handle(context.inst->get_operand(1))).print(),"0"});
            }
            // the code below should distinguish "st.w" and "st.d"
            else if(type->is_int32_type()){ 
                load_to_greg(context.inst->get_operand(0), Reg::t(7));
                append_inst("st.w",{Reg::t(7).print(), 
                    Reg::t(m->get_handle(context.inst->get_operand(1))).print(),"0"});
            }
            else{
                load_to_greg(context.inst->get_operand(0), Reg::t(7));
                append_inst("st.d",{Reg::t(7).print(), 
                    Reg::t(m->get_handle(context.inst->get_operand(1))).print(),"0"});
            }
        }
    }
    else{
        if(m->get_handle(context.inst->get_operand(0))!=-1){
            if(type->is_float_type()){
                load_to_greg(context.inst->get_operand(1), Reg::t(7));
                append_inst("fst.s",{FReg::ft(m->get_handle(context.inst->get_operand(0))).print(), 
                    Reg::t(7).print(),"0"});
            }
            // the code below should distinguish "st.w" and "st.d"
            else if(type->is_int32_type()){ 
                load_to_greg(context.inst->get_operand(1), Reg::t(7));
                append_inst("st.w",{Reg::t(m->get_handle(context.inst->get_operand(0))).print(), 
                    Reg::t(7).print(),"0"});
            }
            else{
                load_to_greg(context.inst->get_operand(1), Reg::t(7));
                append_inst("st.d",{Reg::t(m->get_handle(context.inst->get_operand(0))).print(), 
                    Reg::t(7).print(),"0"});
            }
        }
        else{
            if(type->is_float_type()){
                load_to_freg(context.inst->get_operand(0), FReg::ft(14));
                load_to_greg(context.inst->get_operand(1), Reg::t(7));
                append_inst("fst.s",{FReg::ft(14).print(), 
                    Reg::t(7).print(),"0"});
            }
            // the code below should distinguish "st.w" and "st.d"
            else if(type->is_int32_type()){ 
                load_to_greg(context.inst->get_operand(0), Reg::t(7));
                load_to_greg(context.inst->get_operand(1), Reg::t(8));
                append_inst("st.w",{Reg::t(7).print(), 
                    Reg::t(8).print(),"0"});
            }
            else{
                load_to_greg(context.inst->get_operand(0), Reg::t(7));
                load_to_greg(context.inst->get_operand(1), Reg::t(8));
                append_inst("st.d",{Reg::t(7).print(), 
                    Reg::t(8).print(),"0"});
            }
        }
    }
    //throw not_implemented_error{__FUNCTION__};
}

void CodeGen::gen_icmp() {
    // TODO 处理各种整数比较的情况
    if(m->get_handle(context.inst->get_operand(0))!=-1&&m->get_handle(context.inst->get_operand(1))!=-1){
        switch (context.inst->get_instr_type()) {
        case Instruction::ge:
            append_inst("slt",{Reg::t(7).print(),
                Reg::t(m->get_handle(context.inst->get_operand(1))).print(),
                Reg::t(m->get_handle(context.inst->get_operand(0))).print()});
            append_inst("xor",{Reg::t(8).print(),
                Reg::t(m->get_handle(context.inst->get_operand(1))).print(),
                Reg::t(m->get_handle(context.inst->get_operand(0))).print()});
            append_inst("sltu",{Reg::t(8).print(),"$zero",
                Reg::t(8).print()});
            append_inst("xori",{Reg::t(8).print(),
                Reg::t(8).print(),"1"});
            if(m->get_handle(context.inst)!=-1)
                append_inst("or",{Reg::t(m->get_handle(context.inst)).print(),
                    Reg::t(7).print(),Reg::t(8).print()});
            else{
                append_inst("or",{Reg::t(7).print(),
                    Reg::t(7).print(),Reg::t(8).print()});
                store_from_greg(context.inst, Reg::t(7));
            }
            break;
        case Instruction::gt:
            if(m->get_handle(context.inst)!=-1)
                append_inst("slt",{Reg::t(m->get_handle(context.inst)).print(),
                    Reg::t(m->get_handle(context.inst->get_operand(1))).print(),
                    Reg::t(m->get_handle(context.inst->get_operand(0))).print()});
            else{
                append_inst("slt",{Reg::t(7).print(),
                    Reg::t(m->get_handle(context.inst->get_operand(1))).print(),
                    Reg::t(m->get_handle(context.inst->get_operand(0))).print()});
                store_from_greg(context.inst, Reg::t(7));
            }
            break;
        case Instruction::le:
            append_inst("slt",{Reg::t(7).print(),
                Reg::t(m->get_handle(context.inst->get_operand(0))).print(),
                Reg::t(m->get_handle(context.inst->get_operand(1))).print()});
            append_inst("xor",{Reg::t(8).print(),
                Reg::t(m->get_handle(context.inst->get_operand(0))).print(),
                Reg::t(m->get_handle(context.inst->get_operand(1))).print()});
            append_inst("sltu",{Reg::t(8).print(),"$zero",
                Reg::t(8).print()});
            append_inst("xori",{Reg::t(8).print(),
                Reg::t(8).print(),"1"});
            if(m->get_handle(context.inst)!=-1)
                append_inst("or",{Reg::t(m->get_handle(context.inst)).print(),
                    Reg::t(7).print(),Reg::t(8).print()});
            else{
                append_inst("or",{Reg::t(7).print(),
                    Reg::t(7).print(),Reg::t(8).print()});
                store_from_greg(context.inst, Reg::t(7));
            }
            break;
        case Instruction::lt:
            if(m->get_handle(context.inst)!=-1)
                append_inst("slt",{Reg::t(m->get_handle(context.inst)).print(),
                    Reg::t(m->get_handle(context.inst->get_operand(0))).print(),
                    Reg::t(m->get_handle(context.inst->get_operand(1))).print()});
            else{
                append_inst("slt",{Reg::t(7).print(),
                    Reg::t(m->get_handle(context.inst->get_operand(0))).print(),
                    Reg::t(m->get_handle(context.inst->get_operand(1))).print()});
                store_from_greg(context.inst, Reg::t(7));
            }
            break;
        case Instruction::eq:
            append_inst("xor",{Reg::t(7).print(),
                Reg::t(m->get_handle(context.inst->get_operand(0))).print(),
                Reg::t(m->get_handle(context.inst->get_operand(1))).print()});
            append_inst("sltu",{Reg::t(7).print(),"$zero",
                Reg::t(7).print()});
            if(m->get_handle(context.inst)!=-1)
                append_inst("xori",{Reg::t(m->get_handle(context.inst)).print(),
                    Reg::t(7).print(),"1"});
            else{
                append_inst("xori",{Reg::t(7).print(),
                    Reg::t(7).print(),"1"});
                store_from_greg(context.inst, Reg::t(7));
            }
            break;
        case Instruction::ne:
            append_inst("xor",{Reg::t(7).print(),
                Reg::t(m->get_handle(context.inst->get_operand(0))).print(),
                Reg::t(m->get_handle(context.inst->get_operand(1))).print()});
            if(m->get_handle(context.inst)!=-1)
                append_inst("sltu",{Reg::t(m->get_handle(context.inst)).print(),"$zero",
                    Reg::t(7).print()});
            else{
                append_inst("sltu",{Reg::t(7).print(),"$zero",
                    Reg::t(7).print()});
                store_from_greg(context.inst, Reg::t(7));
            }
            break;
        default:
            assert(false);
        }
    }
    else if(m->get_handle(context.inst->get_operand(0))==-1&&m->get_handle(context.inst->get_operand(1))!=-1){
        load_to_greg(context.inst->get_operand(0), Reg::t(8));
        switch (context.inst->get_instr_type()) {
        case Instruction::ge:
            append_inst("slt",{Reg::t(7).print(),
                Reg::t(m->get_handle(context.inst->get_operand(1))).print(),
                Reg::t(8).print()});
            append_inst("xor",{Reg::t(8).print(),
                Reg::t(m->get_handle(context.inst->get_operand(1))).print(),
                Reg::t(8).print()});
            append_inst("sltu",{Reg::t(8).print(),"$zero",
                Reg::t(8).print()});
            append_inst("xori",{Reg::t(8).print(),
                Reg::t(8).print(),"1"});
            if(m->get_handle(context.inst)!=-1)
                append_inst("or",{Reg::t(m->get_handle(context.inst)).print(),
                    Reg::t(7).print(),Reg::t(8).print()});
            else{
                append_inst("or",{Reg::t(7).print(),
                    Reg::t(7).print(),Reg::t(8).print()});
                store_from_greg(context.inst, Reg::t(7));
            }
            break;
        case Instruction::gt:
            if(m->get_handle(context.inst)!=-1)
                append_inst("slt",{Reg::t(m->get_handle(context.inst)).print(),
                    Reg::t(m->get_handle(context.inst->get_operand(1))).print(),
                    Reg::t(8).print()});
            else{
                append_inst("slt",{Reg::t(7).print(),
                    Reg::t(m->get_handle(context.inst->get_operand(1))).print(),
                    Reg::t(8).print()});
                store_from_greg(context.inst, Reg::t(7));
            }
            break;
        case Instruction::le:
            append_inst("slt",{Reg::t(7).print(),
                Reg::t(8).print(),
                Reg::t(m->get_handle(context.inst->get_operand(1))).print()});
            append_inst("xor",{Reg::t(8).print(),
                Reg::t(8).print(),
                Reg::t(m->get_handle(context.inst->get_operand(1))).print()});
            append_inst("sltu",{Reg::t(8).print(),"$zero",
                Reg::t(8).print()});
            append_inst("xori",{Reg::t(8).print(),
                Reg::t(8).print(),"1"});
            if(m->get_handle(context.inst)!=-1)
                append_inst("or",{Reg::t(m->get_handle(context.inst)).print(),
                    Reg::t(7).print(),Reg::t(8).print()});
            else{
                append_inst("or",{Reg::t(7).print(),
                    Reg::t(7).print(),Reg::t(8).print()});
                store_from_greg(context.inst, Reg::t(7));
            }
            break;
        case Instruction::lt:
            if(m->get_handle(context.inst)!=-1)
                append_inst("slt",{Reg::t(m->get_handle(context.inst)).print(),
                    Reg::t(8).print(),
                    Reg::t(m->get_handle(context.inst->get_operand(1))).print()});
            else{
                append_inst("slt",{Reg::t(7).print(),
                    Reg::t(8).print(),
                    Reg::t(m->get_handle(context.inst->get_operand(1))).print()});
                store_from_greg(context.inst, Reg::t(7));
            }
            break;
        case Instruction::eq:
            append_inst("xor",{Reg::t(7).print(),
                Reg::t(8).print(),
                Reg::t(m->get_handle(context.inst->get_operand(1))).print()});
            append_inst("sltu",{Reg::t(7).print(),"$zero",
                Reg::t(7).print()});
            if(m->get_handle(context.inst)!=-1)
                append_inst("xori",{Reg::t(m->get_handle(context.inst)).print(),
                    Reg::t(7).print(),"1"});
            else{
                append_inst("xori",{Reg::t(7).print(),
                    Reg::t(7).print(),"1"});
                store_from_greg(context.inst, Reg::t(7));
            }
            break;
        case Instruction::ne:
            append_inst("xor",{Reg::t(7).print(),
                Reg::t(8).print(),
                Reg::t(m->get_handle(context.inst->get_operand(1))).print()});
            if(m->get_handle(context.inst)!=-1)
                append_inst("sltu",{Reg::t(m->get_handle(context.inst)).print(),"$zero",
                    Reg::t(7).print()});
            else{
                append_inst("sltu",{Reg::t(7).print(),"$zero",
                    Reg::t(7).print()});
                store_from_greg(context.inst, Reg::t(7));
            }
            break;
        default:
            assert(false);
        }
    }
    else if(m->get_handle(context.inst->get_operand(0))!=-1&&m->get_handle(context.inst->get_operand(1))==-1){
        load_to_greg(context.inst->get_operand(1), Reg::t(8));
        switch (context.inst->get_instr_type()) {
        case Instruction::ge:
            append_inst("slt",{Reg::t(7).print(),
                Reg::t(8).print(),
                Reg::t(m->get_handle(context.inst->get_operand(0))).print()});
            append_inst("xor",{Reg::t(8).print(),
                Reg::t(8).print(),
                Reg::t(m->get_handle(context.inst->get_operand(0))).print()});
            append_inst("sltu",{Reg::t(8).print(),"$zero",
                Reg::t(8).print()});
            append_inst("xori",{Reg::t(8).print(),
                Reg::t(8).print(),"1"});
            if(m->get_handle(context.inst)!=-1)
                append_inst("or",{Reg::t(m->get_handle(context.inst)).print(),
                    Reg::t(7).print(),Reg::t(8).print()});
            else{
                append_inst("or",{Reg::t(7).print(),
                    Reg::t(7).print(),Reg::t(8).print()});
                store_from_greg(context.inst, Reg::t(7));
            }
            break;
        case Instruction::gt:
            if(m->get_handle(context.inst)!=-1)
                append_inst("slt",{Reg::t(m->get_handle(context.inst)).print(),
                    Reg::t(8).print(),
                    Reg::t(m->get_handle(context.inst->get_operand(0))).print()});
            else{
                append_inst("slt",{Reg::t(7).print(),
                    Reg::t(8).print(),
                    Reg::t(m->get_handle(context.inst->get_operand(0))).print()});
                store_from_greg(context.inst, Reg::t(7));
            }
            break;
        case Instruction::le:
            append_inst("slt",{Reg::t(7).print(),
                Reg::t(m->get_handle(context.inst->get_operand(0))).print(),
                Reg::t(8).print()});
            append_inst("xor",{Reg::t(8).print(),
                Reg::t(m->get_handle(context.inst->get_operand(0))).print(),
                Reg::t(8).print()});
            append_inst("sltu",{Reg::t(8).print(),"$zero",
                Reg::t(8).print()});
            append_inst("xori",{Reg::t(8).print(),
                Reg::t(8).print(),"1"});
            if(m->get_handle(context.inst)!=-1)
                append_inst("or",{Reg::t(m->get_handle(context.inst)).print(),
                    Reg::t(7).print(),Reg::t(8).print()});
            else{
                append_inst("or",{Reg::t(7).print(),
                    Reg::t(7).print(),Reg::t(8).print()});
                store_from_greg(context.inst, Reg::t(7));
            }
            break;
        case Instruction::lt:
            if(m->get_handle(context.inst)!=-1)
                append_inst("slt",{Reg::t(m->get_handle(context.inst)).print(),
                    Reg::t(m->get_handle(context.inst->get_operand(0))).print(),
                    Reg::t(8).print()});
            else{
                append_inst("slt",{Reg::t(7).print(),
                    Reg::t(m->get_handle(context.inst->get_operand(0))).print(),
                    Reg::t(8).print()});
                store_from_greg(context.inst, Reg::t(7));
            }
            break;
        case Instruction::eq:
            append_inst("xor",{Reg::t(7).print(),
                Reg::t(m->get_handle(context.inst->get_operand(0))).print(),
                Reg::t(8).print()});
            append_inst("sltu",{Reg::t(7).print(),"$zero",
                Reg::t(7).print()});
            if(m->get_handle(context.inst)!=-1)
                append_inst("xori",{Reg::t(m->get_handle(context.inst)).print(),
                    Reg::t(7).print(),"1"});
            else{
                append_inst("xori",{Reg::t(7).print(),
                    Reg::t(7).print(),"1"});
                store_from_greg(context.inst, Reg::t(7));
            }
            break;
        case Instruction::ne:
            append_inst("xor",{Reg::t(7).print(),
                Reg::t(m->get_handle(context.inst->get_operand(0))).print(),
                Reg::t(8).print()});
            if(m->get_handle(context.inst)!=-1)
                append_inst("sltu",{Reg::t(m->get_handle(context.inst)).print(),"$zero",
                    Reg::t(7).print()});
            else{
                append_inst("sltu",{Reg::t(7).print(),"$zero",
                    Reg::t(7).print()});
                store_from_greg(context.inst, Reg::t(7));
            }
            break;
        default:
            assert(false);
        }
    }
    else{
        load_to_greg(context.inst->get_operand(0), Reg::t(7));
        load_to_greg(context.inst->get_operand(1), Reg::t(8));
        if(m->get_handle(context.inst)!=-1){
            switch (context.inst->get_instr_type()) {
            case Instruction::ge:
                append_inst("slt",{Reg::t(m->get_handle(context.inst)).print(),
                    Reg::t(8).print(),
                    Reg::t(7).print()});
                append_inst("xor",{Reg::t(8).print(),
                    Reg::t(8).print(),
                    Reg::t(7).print()});
                append_inst("sltu",{Reg::t(8).print(),"$zero",
                    Reg::t(8).print()});
                append_inst("xori",{Reg::t(8).print(),
                    Reg::t(8).print(),"1"});
                append_inst("or",{Reg::t(m->get_handle(context.inst)).print(),
                    Reg::t(m->get_handle(context.inst)).print(),Reg::t(8).print()});
                break;
            case Instruction::gt:
                append_inst("slt",{Reg::t(m->get_handle(context.inst)).print(),
                    Reg::t(8).print(),
                    Reg::t(7).print()});
                break;
            case Instruction::le:
                append_inst("slt",{Reg::t(m->get_handle(context.inst)).print(),
                    Reg::t(7).print(),
                    Reg::t(8).print()});
                append_inst("xor",{Reg::t(8).print(),
                    Reg::t(8).print(),
                    Reg::t(7).print()});
                append_inst("sltu",{Reg::t(8).print(),"$zero",
                    Reg::t(8).print()});
                append_inst("xori",{Reg::t(8).print(),
                    Reg::t(8).print(),"1"});
                append_inst("or",{Reg::t(m->get_handle(context.inst)).print(),
                    Reg::t(m->get_handle(context.inst)).print(),Reg::t(8).print()});
                break;
            case Instruction::lt:
                append_inst("slt",{Reg::t(m->get_handle(context.inst)).print(),
                    Reg::t(7).print(),
                    Reg::t(8).print()});
                break;
            case Instruction::eq:
                append_inst("xor",{Reg::t(7).print(),
                    Reg::t(7).print(),
                    Reg::t(8).print()});
                append_inst("sltu",{Reg::t(7).print(),"$zero",
                    Reg::t(7).print()});
                append_inst("xori",{Reg::t(m->get_handle(context.inst)).print(),
                    Reg::t(7).print(),"1"});
                break;
            case Instruction::ne:
                append_inst("xor",{Reg::t(7).print(),
                    Reg::t(7).print(),
                    Reg::t(8).print()});
                append_inst("sltu",{Reg::t(m->get_handle(context.inst)).print(),"$zero",
                    Reg::t(7).print()});
                break;
            default:
                assert(false);
            }
        }
        else{
            switch (context.inst->get_instr_type()) {
            case Instruction::ge:
                append_inst("slt",{Reg::t(7).print(),
                    Reg::t(8).print(),
                    Reg::t(7).print()});
                store_from_greg(context.inst,Reg::t(7));
                load_to_greg(context.inst->get_operand(0),Reg::t(7));
                append_inst("xor",{Reg::t(8).print(),
                    Reg::t(8).print(),
                    Reg::t(7).print()});
                append_inst("sltu",{Reg::t(8).print(),"$zero",
                    Reg::t(8).print()});
                append_inst("xori",{Reg::t(8).print(),
                    Reg::t(8).print(),"1"});
                load_to_greg(context.inst,Reg::t(7));
                append_inst("or",{Reg::t(7).print(),
                    Reg::t(7).print(),Reg::t(8).print()});
                store_from_greg(context.inst,Reg::t(7));
                break;
            case Instruction::gt:
                append_inst("slt",{Reg::t(7).print(),
                    Reg::t(8).print(),
                    Reg::t(7).print()});
                store_from_greg(context.inst,Reg::t(7));
                break;
            case Instruction::le:
                append_inst("slt",{Reg::t(7).print(),
                    Reg::t(7).print(),
                    Reg::t(8).print()});
                store_from_greg(context.inst,Reg::t(7));
                load_to_greg(context.inst->get_operand(0),Reg::t(7));
                append_inst("xor",{Reg::t(8).print(),
                    Reg::t(8).print(),
                    Reg::t(7).print()});
                append_inst("sltu",{Reg::t(8).print(),"$zero",
                    Reg::t(8).print()});
                append_inst("xori",{Reg::t(8).print(),
                    Reg::t(8).print(),"1"});
                load_to_greg(context.inst,Reg::t(7));
                append_inst("or",{Reg::t(7).print(),
                    Reg::t(7).print(),Reg::t(8).print()});
                store_from_greg(context.inst,Reg::t(7));
                break;
            case Instruction::lt:
                append_inst("slt",{Reg::t(7).print(),
                    Reg::t(7).print(),
                    Reg::t(8).print()});
                store_from_greg(context.inst,Reg::t(7));
                break;
            case Instruction::eq:
                append_inst("xor",{Reg::t(7).print(),
                    Reg::t(7).print(),
                    Reg::t(8).print()});
                append_inst("sltu",{Reg::t(7).print(),"$zero",
                    Reg::t(7).print()});
                append_inst("xori",{Reg::t(7).print(),
                    Reg::t(7).print(),"1"});
                store_from_greg(context.inst,Reg::t(7));
                break;
            case Instruction::ne:
                append_inst("xor",{Reg::t(7).print(),
                    Reg::t(7).print(),
                    Reg::t(8).print()});
                append_inst("sltu",{Reg::t(7).print(),"$zero",
                    Reg::t(7).print()});
                store_from_greg(context.inst,Reg::t(7));
                break;
            default:
                assert(false);
            }
        }
    }
    //throw not_implemented_error{__FUNCTION__};
}

void CodeGen::gen_fcmp() {
    // TODO 处理各种浮点数比较的情况
    int reg0,reg1;
    if(m->get_handle(context.inst->get_operand(0))!=-1&&m->get_handle(context.inst->get_operand(1))!=-1){
        reg0 = m->get_handle(context.inst->get_operand(0));
        reg1 = m->get_handle(context.inst->get_operand(1));
    }
    else if(m->get_handle(context.inst->get_operand(0))==-1&&m->get_handle(context.inst->get_operand(1))!=-1){
        load_to_freg(context.inst->get_operand(0), FReg::ft(14));
        reg0 = 14;
        reg1 = m->get_handle(context.inst->get_operand(1));
    }
    else if(m->get_handle(context.inst->get_operand(0))==-1&&m->get_handle(context.inst->get_operand(1))!=-1){
        load_to_freg(context.inst->get_operand(1), FReg::ft(15));
        reg0 = m->get_handle(context.inst->get_operand(0));
        reg1 = 15;
    }
    else{
        load_to_freg(context.inst->get_operand(0), FReg::ft(14));
        load_to_freg(context.inst->get_operand(1), FReg::ft(15));
        reg0 = 14;
        reg1 = 15;
    }
    switch (context.inst->get_instr_type()) {
    case Instruction::fge:
        append_inst("fcmp.sle.s",{"$fcc0",FReg::ft(reg0).print(),FReg::ft(reg1).print()});
        if(m->get_handle(context.inst)!=-1){
            append_inst("bcnez $fcc0, 8");
            append_inst("b 12");
            append_inst("addi.w",{Reg::t(m->get_handle(context.inst)).print(),"$zero","1"});
            append_inst("b 12");
            append_inst("addi.w",{Reg::t(m->get_handle(context.inst)).print(),"$zero","1"});
            append_inst("b 4");
        }
        else{
            append_inst("bcnez $fcc0, 8");
            append_inst("b 12");
            append_inst("addi.w",{Reg::t(7).print(),"$zero","1"});
            append_inst("b 12");
            append_inst("addi.w",{Reg::t(7).print(),"$zero","1"});
            append_inst("b 4");
            store_from_greg(context.inst, Reg::t(7));
        }
        break;
    case Instruction::fgt:
        append_inst("fcmp.slt.s",{"$fcc0",FReg::ft(reg1).print(),FReg::ft(reg0).print()});
        if(m->get_handle(context.inst)!=-1){
            append_inst("bcnez $fcc0, 8");
            append_inst("b 12");
            append_inst("addi.w",{Reg::t(m->get_handle(context.inst)).print(),"$zero","1"});
            append_inst("b 12");
            append_inst("addi.w",{Reg::t(m->get_handle(context.inst)).print(),"$zero","1"});
            append_inst("b 4");
        }
        else{
            append_inst("bcnez $fcc0, 8");
            append_inst("b 12");
            append_inst("addi.w",{Reg::t(7).print(),"$zero","1"});
            append_inst("b 12");
            append_inst("addi.w",{Reg::t(7).print(),"$zero","1"});
            append_inst("b 4");
            store_from_greg(context.inst, Reg::t(7));
        }
        break;
    case Instruction::fle:
        append_inst("fcmp.sle.s",{"$fcc0",FReg::ft(reg0).print(),FReg::ft(reg1).print()});
        if(m->get_handle(context.inst)!=-1){
            append_inst("bcnez $fcc0, 8");
            append_inst("b 12");
            append_inst("addi.w",{Reg::t(m->get_handle(context.inst)).print(),"$zero","1"});
            append_inst("b 12");
            append_inst("addi.w",{Reg::t(m->get_handle(context.inst)).print(),"$zero","1"});
            append_inst("b 4");
        }
        else{
            append_inst("bcnez $fcc0, 8");
            append_inst("b 12");
            append_inst("addi.w",{Reg::t(7).print(),"$zero","1"});
            append_inst("b 12");
            append_inst("addi.w",{Reg::t(7).print(),"$zero","1"});
            append_inst("b 4");
            store_from_greg(context.inst, Reg::t(7));
        }
        break;
    case Instruction::flt:
        append_inst("fcmp.slt.s",{"$fcc0",FReg::ft(reg0).print(),FReg::ft(reg1).print()});
        if(m->get_handle(context.inst)!=-1){
            append_inst("bcnez $fcc0, 8");
            append_inst("b 12");
            append_inst("addi.w",{Reg::t(m->get_handle(context.inst)).print(),"$zero","1"});
            append_inst("b 12");
            append_inst("addi.w",{Reg::t(m->get_handle(context.inst)).print(),"$zero","1"});
            append_inst("b 4");
        }
        else{
            append_inst("bcnez $fcc0, 8");
            append_inst("b 12");
            append_inst("addi.w",{Reg::t(7).print(),"$zero","1"});
            append_inst("b 12");
            append_inst("addi.w",{Reg::t(7).print(),"$zero","1"});
            append_inst("b 4");
            store_from_greg(context.inst, Reg::t(7));
        }
        break;
    case Instruction::feq:
        append_inst("fcmp.seq.s",{"$fcc0",FReg::ft(reg1).print(),FReg::ft(reg0).print()});
        if(m->get_handle(context.inst)!=-1){
            append_inst("bcnez $fcc0, 8");
            append_inst("b 12");
            append_inst("addi.w",{Reg::t(m->get_handle(context.inst)).print(),"$zero","1"});
            append_inst("b 12");
            append_inst("addi.w",{Reg::t(m->get_handle(context.inst)).print(),"$zero","1"});
            append_inst("b 4");
        }
        else{
            append_inst("bcnez $fcc0, 8");
            append_inst("b 12");
            append_inst("addi.w",{Reg::t(7).print(),"$zero","1"});
            append_inst("b 12");
            append_inst("addi.w",{Reg::t(7).print(),"$zero","1"});
            append_inst("b 4");
            store_from_greg(context.inst, Reg::t(7));
        }
        break;
    case Instruction::fne:
        append_inst("fcmp.sne.s",{"$fcc0",FReg::ft(reg1).print(),FReg::ft(reg0).print()});
        if(m->get_handle(context.inst)!=-1){
            append_inst("bcnez $fcc0, 8");
            append_inst("b 12");
            append_inst("addi.w",{Reg::t(m->get_handle(context.inst)).print(),"$zero","1"});
            append_inst("b 12");
            append_inst("addi.w",{Reg::t(m->get_handle(context.inst)).print(),"$zero","1"});
            append_inst("b 4");
        }
        else{
            append_inst("bcnez $fcc0, 8");
            append_inst("b 12");
            append_inst("addi.w",{Reg::t(7).print(),"$zero","1"});
            append_inst("b 12");
            append_inst("addi.w",{Reg::t(7).print(),"$zero","1"});
            append_inst("b 4");
            store_from_greg(context.inst, Reg::t(7));
        }
        break;
    default:
        assert(false);
    }
    //throw not_implemented_error{__FUNCTION__};
}

void CodeGen::gen_zext() {
    // TODO 将窄位宽的整数数据进行零扩展
    if(m->get_handle(context.inst)!=1){
        if(m->get_handle(context.inst->get_operand(0))!=-1){
            append_inst("add.w",{Reg::t(m->get_handle(context.inst)).print(),
                Reg::t(m->get_handle(context.inst->get_operand(0))).print(),"$zero"});
        }
        else{
            load_to_greg(context.inst->get_operand(0), Reg::t(m->get_handle(context.inst)));
        }
    }
    else{
        if(m->get_handle(context.inst->get_operand(0))!=-1){
            append_inst("add.w",{Reg::t(7).print(),
                Reg::t(m->get_handle(context.inst->get_operand(0))).print(),"$zero"});
            store_from_greg(context.inst, Reg::t(7));
        }
        else{
            load_to_greg(context.inst->get_operand(0), Reg::t(8));
            append_inst("add.w",{Reg::t(7).print(),
                Reg::t(8).print(),"$zero"});
            store_from_greg(context.inst, Reg::t(7));
        }
    }
    //throw not_implemented_error{__FUNCTION__};
}

void CodeGen::gen_call() {
    // TODO 函数调用，注意我们只需要通过寄存器传递参数，即不需考虑栈上传参的情况
    int farg_cnt = 0;
    int garg_cnt = 0;
    auto *fun = static_cast<Function *>(context.inst->get_operand(0));
    for (unsigned int i=1; i<context.inst->get_num_operand(); i++) {
        auto *type = context.inst->get_operand(i)->get_type();
        if(m->get_handle(context.inst->get_operand(i))!=-1){
            if (type->is_float_type()) {
                output.emplace_back("movgr2fr.w $ft14, $zero");
                append_inst("fadd.s",{FReg::fa(farg_cnt++).print(),
                    FReg::ft(m->get_handle(context.inst->get_operand(i))).print(),FReg::ft(14).print()});
            } else { // int or pointer
                append_inst("add.d",{Reg::a(garg_cnt++).print(),
                    Reg::t(m->get_handle(context.inst->get_operand(i))).print(),"$zero"});
            }
        }
        else{
            if (type->is_float_type()) {
                load_to_freg(context.inst->get_operand(i), FReg::fa(farg_cnt++));
            } else { // int or pointer
                load_to_greg(context.inst->get_operand(i), Reg::a(garg_cnt++));
            }
        }
    }
    output.emplace_back("bl " + fun->get_name());
    if(fun->get_return_type()->is_void_type()){}
    else if(fun->get_return_type()->is_float_type()){
        if(m->get_handle(context.inst)!=-1){
            output.emplace_back("movgr2fr.w $ft14, $zero");
            append_inst("fadd.s",{FReg::ft(m->get_handle(context.inst)).print(),
            FReg::fa(0).print(),FReg::ft(14).print()});
        }
        else
            store_from_freg(context.inst, FReg::fa(0));
    }
    else{
        if(m->get_handle(context.inst)!=-1){
            append_inst("add.w",{Reg::t(m->get_handle(context.inst)).print(),
            Reg::a(0).print(),"$zero"});
        }
        else
            store_from_greg(context.inst, Reg::a(0));
    }
    //throw not_implemented_error{__FUNCTION__};
}

void CodeGen::gen_gep() {
    // TODO 计算内存地址
    int point;
    if(context.inst->get_operand(0)->get_type()->get_pointer_element_type()->is_array_type()){
        point = 2;
    }
    else{
        point = 1;
    }
    if(m->get_handle(context.inst->get_operand(0))!=-1&&m->get_handle(context.inst->get_operand(point))!=-1){
        append_inst("addi.w $t7, $zero, 4");
        append_inst("mul.w",{Reg::t(7).print(),Reg::t(m->get_handle(context.inst->get_operand(point))).print(),Reg::t(7).print()});
        if(m->get_handle(context.inst)!=-1)
            append_inst("add.d",{Reg::t(m->get_handle(context.inst)).print(),
                Reg::t(m->get_handle(context.inst->get_operand(0))).print(),Reg::t(7).print()});
        else{
            append_inst("add.d",{Reg::t(7).print(),Reg::t(m->get_handle(context.inst->get_operand(0))).print(),Reg::t(7).print()});
            store_from_greg(context.inst, Reg::t(7));
        }
    }
    else if(m->get_handle(context.inst->get_operand(0))==-1&&m->get_handle(context.inst->get_operand(point))!=-1){
        load_to_greg(context.inst->get_operand(0), Reg::t(8));
        append_inst("addi.w $t7, $zero, 4");
        append_inst("mul.w",{Reg::t(7).print(),Reg::t(m->get_handle(context.inst->get_operand(point))).print(),Reg::t(7).print()});
        if(m->get_handle(context.inst)!=-1)
            append_inst("add.d",{Reg::t(m->get_handle(context.inst)).print(),
                Reg::t(8).print(),Reg::t(7).print()});
        else{
            append_inst("add.d",{Reg::t(7).print(),Reg::t(8).print(),Reg::t(7).print()});
            store_from_greg(context.inst, Reg::t(7));
        }
    }
    else if(m->get_handle(context.inst->get_operand(0))!=-1&&m->get_handle(context.inst->get_operand(point))==-1){
        load_to_greg(context.inst->get_operand(point), Reg::t(8));
        append_inst("addi.w $t7, $zero, 4");
        append_inst("mul.w",{Reg::t(7).print(),Reg::t(8).print(),Reg::t(7).print()});
        if(m->get_handle(context.inst)!=-1)
            append_inst("add.d",{Reg::t(m->get_handle(context.inst)).print(),
                Reg::t(m->get_handle(context.inst->get_operand(0))).print(),Reg::t(7).print()});
        else{
            append_inst("add.d",{Reg::t(7).print(),Reg::t(m->get_handle(context.inst->get_operand(0))).print(),Reg::t(7).print()});
            store_from_greg(context.inst, Reg::t(7));
        }
    }
    else{
        load_to_greg(context.inst->get_operand(point), Reg::t(8));
        append_inst("addi.w $t7, $zero, 4");
        append_inst("mul.w",{Reg::t(7).print(),Reg::t(8).print(),Reg::t(7).print()});
        load_to_greg(context.inst->get_operand(0), Reg::t(8));
        if(m->get_handle(context.inst)!=-1)
            append_inst("add.d",{Reg::t(m->get_handle(context.inst)).print(),
                Reg::t(8).print(),Reg::t(7).print()});
        else{
            append_inst("add.d",{Reg::t(7).print(),Reg::t(8).print(),Reg::t(7).print()});
            store_from_greg(context.inst, Reg::t(7));
        }
    }
    //throw not_implemented_error{__FUNCTION__};
}

void CodeGen::gen_sitofp() {
    // TODO 整数转向浮点数
    if(m->get_handle(context.inst)!=-1&&m->get_handle(context.inst->get_operand(0))!=-1){
        append_inst("movgr2fr.w",{FReg::ft(14).print(),Reg::t(m->get_handle(context.inst->get_operand(0))).print()});
        append_inst("ffint.s.w",{FReg::ft(m->get_handle(context.inst)).print(),FReg::ft(14).print()});
    }
    else if(m->get_handle(context.inst)==-1&&m->get_handle(context.inst->get_operand(0))!=-1){
        append_inst("movgr2fr.w",{FReg::ft(14).print(),Reg::t(m->get_handle(context.inst->get_operand(0))).print()});
        append_inst("ffint.s.w",{FReg::ft(15).print(),FReg::ft(14).print()});
        store_from_freg(context.inst, FReg::ft(15));
    }
    else if(m->get_handle(context.inst)!=-1&&m->get_handle(context.inst->get_operand(0))==-1){
        load_to_greg(context.inst->get_operand(0), Reg::t(7));
        append_inst("movgr2fr.w",{FReg::ft(14).print(),Reg::t(7).print()});
        append_inst("ffint.s.w",{FReg::ft(m->get_handle(context.inst)).print(),FReg::ft(14).print()});
    }
    else{
        load_to_greg(context.inst->get_operand(0), Reg::t(7));
        append_inst("movgr2fr.w",{FReg::ft(14).print(),Reg::t(7).print()});
        append_inst("ffint.s.w",{FReg::ft(15).print(),FReg::ft(14).print()});
        store_from_freg(context.inst, FReg::ft(15));
    }
    //throw not_implemented_error{__FUNCTION__};
}

void CodeGen::gen_fptosi() {
    // TODO 浮点数转向整数，注意向下取整(round to zero)
    if(m->get_handle(context.inst)!=-1&&m->get_handle(context.inst->get_operand(0))!=-1){
        append_inst("ftintrz.w.s",{FReg::ft(14).print(),FReg::ft(m->get_handle(context.inst->get_operand(0))).print()});
        append_inst("movfr2gr.s",{Reg::t(m->get_handle(context.inst)).print(),FReg::ft(14).print()});
    }
    else if(m->get_handle(context.inst)==-1&&m->get_handle(context.inst->get_operand(0))!=-1){
        append_inst("ftintrz.w.s",{FReg::ft(14).print(),FReg::ft(m->get_handle(context.inst->get_operand(0))).print()});
        append_inst("movfr2gr.s",{Reg::t(7).print(),FReg::ft(14).print()});
        store_from_greg(context.inst, Reg::t(7));
    }
    else if(m->get_handle(context.inst)!=-1&&m->get_handle(context.inst->get_operand(0))==-1){
        load_to_freg(context.inst->get_operand(0), FReg::ft(14));
        append_inst("ftintrz.w.s",{FReg::ft(15).print(),FReg::ft(14).print()});
        append_inst("movfr2gr.s",{Reg::t(m->get_handle(context.inst)).print(),FReg::ft(15).print()});
    }
    else{
        load_to_freg(context.inst->get_operand(0), FReg::ft(14));
        append_inst("ftintrz.w.s",{FReg::ft(15).print(),FReg::ft(14).print()});
        append_inst("movfr2gr.s",{Reg::t(7).print(),FReg::ft(15).print()});
        store_from_greg(context.inst, Reg::t(7));
    }
    //throw not_implemented_error{__FUNCTION__};
}
void CodeGen::run() {
    // 确保每个函数中基本块的名字都被设置好
    // 想一想：为什么？
    m->set_print_name();

    /* 使用 GNU 伪指令为全局变量分配空间
     * 你可以使用 `la.local` 指令将标签 (全局变量) 的地址载入寄存器中, 比如
     * 要将 `a` 的地址载入 $t0, 只需要 `la.local $t0, a`
     */
    if (!m->get_global_variable().empty()) {
        append_inst("Global variables", ASMInstruction::Comment);
        /* 虽然下面两条伪指令可以简化为一条 `.bss` 伪指令, 但是我们还是选择使用
         * `.section` 将全局变量放到可执行文件的 BSS 段, 原因如下:
         * - 尽可能对齐交叉编译器 loongarch64-unknown-linux-gnu-gcc 的行为
         * - 支持更旧版本的 GNU 汇编器, 因为 `.bss` 伪指令是应该相对较新的指令,
         *   GNU 汇编器在 2023 年 2 月的 2.37 版本才将其引入
         */
        append_inst(".text", ASMInstruction::Atrribute);
        append_inst(".section", {".bss", "\"aw\"", "@nobits"},
                    ASMInstruction::Atrribute);
        for (auto &global : m->get_global_variable()) {
            auto size =
                global.get_type()->get_pointer_element_type()->get_size();
            append_inst(".globl", {global.get_name()},
                        ASMInstruction::Atrribute);
            append_inst(".type", {global.get_name(), "@object"},
                        ASMInstruction::Atrribute);
            append_inst(".size", {global.get_name(), std::to_string(size)},
                        ASMInstruction::Atrribute);
            append_inst(global.get_name(), ASMInstruction::Label);
            append_inst(".space", {std::to_string(size)},
                        ASMInstruction::Atrribute);
        }
    }

    // 函数代码段
    output.emplace_back(".text", ASMInstruction::Atrribute);
    for (auto &func : m->get_functions()) {
        if (not func.is_declaration()) {
            // 更新 context
            context.clear();
            context.func = &func;

            // 函数信息
            append_inst(".globl", {func.get_name()}, ASMInstruction::Atrribute);
            append_inst(".type", {func.get_name(), "@function"},
                        ASMInstruction::Atrribute);
            append_inst(func.get_name(), ASMInstruction::Label);

            // 分配函数栈帧
            allocate();
            // 生成 prologue
            gen_prologue();

            for (auto &bb : func.get_basic_blocks()) {
                append_inst(label_name(&bb), ASMInstruction::Label);
                for (auto &instr : bb.get_instructions()) {
                    // For debug
                    append_inst(instr.print(), ASMInstruction::Comment);
                    context.inst = &instr; // 更新 context
                    switch (instr.get_instr_type()) {
                    case Instruction::ret:
                        gen_ret();
                        break;
                    case Instruction::br:
                        gen_br();
                        break;
                    case Instruction::add:
                    case Instruction::sub:
                    case Instruction::mul:
                    case Instruction::sdiv:
                        gen_binary();
                        break;
                    case Instruction::fadd:
                    case Instruction::fsub:
                    case Instruction::fmul:
                    case Instruction::fdiv:
                        gen_float_binary();
                        break;
                    case Instruction::alloca:
                        gen_alloca();
                        break;
                    case Instruction::load:
                        gen_load();
                        break;
                    case Instruction::store:
                        gen_store();
                        break;
                    case Instruction::ge:
                    case Instruction::gt:
                    case Instruction::le:
                    case Instruction::lt:
                    case Instruction::eq:
                    case Instruction::ne:
                        gen_icmp();
                        break;
                    case Instruction::fge:
                    case Instruction::fgt:
                    case Instruction::fle:
                    case Instruction::flt:
                    case Instruction::feq:
                    case Instruction::fne:
                        gen_fcmp();
                        break;
                    case Instruction::phi:
                        break;
                    case Instruction::call:
                        gen_call();
                        break;
                    case Instruction::getelementptr:
                        gen_gep();
                        break;
                    case Instruction::zext:
                        gen_zext();
                        break;
                    case Instruction::fptosi:
                        gen_fptosi();
                        break;
                    case Instruction::sitofp:
                        gen_sitofp();
                        break;
                    }
                }
            }
            // 生成 epilogue
            gen_epilogue();
        }
    }
}

std::string CodeGen::print() const {
    std::string result;
    for (const auto &inst : output) {
        result += inst.format();
    }
    return result;
}

bool CodeGen::is_change(BasicBlock* start,BasicBlock* end,Value* val){
    bool is_change=false;
    for(auto &inst : end->get_instructions()){
        if((&inst)->is_phi()){
            for(long unsigned int i=0;i<(&inst)->get_num_operand()/2;i++){
                if((&inst)->get_operand(2*i+1)==start){
                    if(m->get_handle(&inst)==m->get_handle(val)&&(&inst)->get_type()->is_integer_type())
                        is_change=true;
                }
            }
        }
    }
    return is_change;
}
std::shared_ptr<struct Node> CodeGen::find(Value* val){
    std::vector<std::shared_ptr<struct Node>> stack;
    std::set<std::shared_ptr<struct Node>> marked;
    stack.push_back(graph_start);
    marked.insert(graph_start);
    while(!stack.empty()){
        bool changed = false;
        for(auto next_node : stack.back()->succ){
            if(marked.count(next_node)==0){
                auto next_val = *(next_node->val.begin());
                bool next_is_int = next_val->get_type()->is_integer_type();
                bool val_is_int = val->get_type()->is_integer_type();
                bool is_same_type = (next_is_int&&val_is_int)||(!next_is_int&&!val_is_int);
                if((val==next_val)||(is_same_type&&(m->get_handle(val)!=-1)&&(m->get_handle(val)==m->get_handle(next_val))))
                    return next_node;
                stack.push_back(next_node);
                marked.insert(next_node);
                changed=true;
            }
        }
        if(changed==false){
            stack.pop_back();
        }
    }
    return nullptr;
}
void CodeGen::create_graph(BasicBlock* bb){
    graph_start = std::make_shared<struct Node>();
    for(auto &bb1 : bb->get_succ_basic_blocks()){
        for(auto &inst : (bb1)->get_instructions()){
            if((&inst)->is_phi()){
                for(long unsigned int i=0;i<(&inst)->get_num_operand()/2;i++){
                    if((&inst)->get_operand(2*i+1)==bb){
                        std::shared_ptr<struct Node> node_from = find((&inst)->get_operand(2*i));
                        std::shared_ptr<struct Node> node_to = find(&inst);
                        if(node_from==nullptr&&node_to==nullptr){
                            node_from = std::make_shared<struct Node>();
                            node_from->val.insert((&inst)->get_operand(2*i));
                            graph_start->succ.insert(node_from);
                            if(find(&inst)!=node_from){
                                node_to = std::make_shared<struct Node>();
                                node_to->val.insert(&inst);
                                node_from->succ.insert(node_to);
                                node_to->pre.insert(node_from);
                                node_from->pair[node_to].push_back({(&inst)->get_operand(2*i),&inst});
                            }
                            else{
                                node_from->succ.insert(node_from);
                                node_from->pre.insert(node_from);
                                node_from->pair[node_from].push_back({(&inst)->get_operand(2*i),&inst});
                            }
                        }
                        else if(node_from!=nullptr&&node_to==nullptr){
                            node_from->val.insert((&inst)->get_operand(2*i));
                            node_to = std::make_shared<struct Node>();
                            node_to->val.insert(&inst);
                            node_from->succ.insert(node_to);
                            node_to->pre.insert(node_from);
                            node_from->pair[node_to].push_back({(&inst)->get_operand(2*i),&inst});
                        }
                        else if(node_from==nullptr&&node_to!=nullptr){
                            node_from = std::make_shared<struct Node>();
                            node_from->val.insert((&inst)->get_operand(2*i));
                            node_to->val.insert(&inst);
                            graph_start->succ.insert(node_from);
                            node_from->succ.insert(node_to);
                            node_to->pre.insert(node_from);
                            node_from->pair[node_to].push_back({(&inst)->get_operand(2*i),&inst});
                            if(graph_start->succ.count(node_to)>0){
                                graph_start->succ.erase(node_to);
                            }
                        }
                        else{
                            node_from->val.insert((&inst)->get_operand(2*i));
                            node_to->val.insert(&inst);
                            node_from->pair[node_to].push_back({(&inst)->get_operand(2*i),&inst});
                            if(node_from->succ.count(node_to)==0){
                                node_from->succ.insert(node_to);
                                node_to->pre.insert(node_from);
                            }
                        }
                    }
                }
            }
        }
    }
}
void CodeGen::phi_resort(BasicBlock* bb){
    true_val_move.clear();
    false_val_move.clear();
    save_val.clear();
    false_val.clear();
    create_graph(bb);
    std::vector<std::shared_ptr<struct Node>> stack;
    std::set<std::shared_ptr<struct Node>> marked;
    BasicBlock* bb_true;
    if(context.inst->get_num_operand()==1) bb_true = dynamic_cast<BasicBlock*>(context.inst->get_operand(0));
    else bb_true = dynamic_cast<BasicBlock*>(context.inst->get_operand(1));
    for(auto node : graph_start->succ){
        marked.insert(node);
        stack.push_back(node);
    }
    while(!stack.empty()){
        if(stack.back()->succ.size()==0){
            if(stack.back()->pre.size()==0){ 
                stack.pop_back(); 
                continue; 
            }
            else if(stack.back()->pre.size()==1){
                auto pre_node = *(stack.back()->pre.begin());
                auto succ_node = stack.back();
                Value* pre_val;
                Value* succ_val;
                auto iter = pre_node->pair[succ_node].begin();
                if(pre_node->pair[succ_node].size()>1){
                    for(; iter!=pre_node->pair[succ_node].end(); iter++){
                        auto iiter = (*iter).begin();
                        iiter++;
                        auto iter_val = dynamic_cast<Instruction*>(*iiter);
                        if(iter_val->get_parent()==bb_true){
                            pre_val = *((*iter).begin());
                            succ_val = iter_val;
                        }
                    }
                }
                else{
                    pre_val = *(*iter).begin();
                    auto iiter = (*iter).begin(); iiter++;
                    succ_val = *iiter;
                }
                auto iter_val = dynamic_cast<Instruction*>(succ_val);
                if(iter_val->get_parent()==bb_true){
                    if(false_val.count(succ_val)>0) true_val_move.push_back({succ_val,NULL});
                    true_val_move.push_back({pre_val,succ_val});
                }
                else{
                    false_val.insert(pre_val);
                    false_val_move.push_back({pre_val,succ_val});
                }
                succ_node->pre.erase(pre_node);
                pre_node->succ.erase(succ_node);
                pre_node->pair.erase(succ_node);
            }
            else{
                auto pre_node_1 = *(stack.back()->pre.begin());
                auto iter = stack.back()->pre.begin();iter++;
                auto pre_node_2 = *iter;
                auto succ_node = stack.back();
                Value* pre_val_1 = *(*pre_node_1->pair[succ_node].begin()).begin();
                auto iter_1 = (*pre_node_1->pair[succ_node].begin()).begin();iter_1++;
                Value* succ_val_1 = *iter_1;
                Value* pre_val_2 = *(*pre_node_2->pair[succ_node].begin()).begin();
                auto iter_2 = (*pre_node_2->pair[succ_node].begin()).begin();iter_2++;
                Value* succ_val_2= *iter_2;
                auto iter_val = dynamic_cast<Instruction*>(succ_val_1);
                if(iter_val->get_parent()==bb_true){
                    if(false_val.count(succ_val_1)>0) true_val_move.push_back({succ_val_1,NULL});
                    true_val_move.push_back({pre_val_1,succ_val_1});
                    false_val.insert(pre_val_2);
                    false_val_move.push_back({pre_val_2,succ_val_2});
                }
                else{
                    if(false_val.count(succ_val_2)>0) true_val_move.push_back({succ_val_2,NULL});
                    true_val_move.push_back({pre_val_2,succ_val_2});
                    false_val.insert(pre_val_1);
                    false_val_move.push_back({pre_val_1,succ_val_1});
                }
                succ_node->pre.erase(pre_node_1);
                succ_node->pre.erase(pre_node_2);
                pre_node_1->succ.erase(succ_node);
                pre_node_1->pair.erase(succ_node);
                pre_node_2->succ.erase(succ_node);
                pre_node_2->pair.erase(succ_node);
            }
        }
        else{
            if(marked.count(*(stack.back()->succ.begin()))==0){
                stack.push_back(*(stack.back()->succ.begin()));
                marked.insert(stack.back());
            }
            else if(*(stack.back()->succ.begin())==stack.back()){
                if(stack.back()->succ.size()>1){
                    stack.back()->succ.erase(stack.back()->succ.begin());
                    stack.back()->succ.insert(stack.back()->succ.end(),stack.back());
                    continue;
                }
                else{
                    auto node = stack.back();
                    Value* pre_val;
                    Value* succ_val;
                    auto iter = node->pair[node].begin();
                    if(node->pair[node].size()>1){
                        for(; iter!=node->pair[node].end(); iter++){
                            auto iiter = (*iter).begin();
                            iiter++;
                            auto iter_val = dynamic_cast<Instruction*>(*iiter);
                            if(iter_val->get_parent()==bb_true){
                                pre_val = *((*iter).begin());
                                succ_val = iter_val;
                            }
                        }
                    }
                    else{
                        pre_val = *(*iter).begin();
                        auto iiter = (*iter).begin();iiter++;
                        succ_val = *iiter;
                    }
                    auto iter_val = dynamic_cast<Instruction*>(succ_val);
                    if(iter_val->get_parent()==bb_true){
                        if(false_val.count(succ_val)>0) true_val_move.push_back({succ_val,NULL});
                        true_val_move.push_back({pre_val,succ_val});
                    }
                    else{
                        false_val.insert(pre_val);
                        false_val_move.push_back({pre_val,succ_val});
                    }
                    node->pre.erase(node);
                    node->succ.erase(node);
                    node->pair.erase(node);
                }
            }
            else{
                auto pre_node = stack.back();
                auto succ_node = *(stack.back()->succ.begin());
                Value* pre_val; 
                Value* succ_val;
                auto iter = pre_node->pair[succ_node].begin();
                if(pre_node->pair[pre_node].size()>1){
                    for(; iter!=pre_node->pair[pre_node].end(); iter++){
                        auto iiter = (*iter).begin();
                        iiter++;
                        auto iter_val = dynamic_cast<Instruction*>(*iiter);
                        if(iter_val->get_parent()==bb_true){
                            pre_val = *((*iter).begin());
                            succ_val = iter_val;
                        }
                    }
                }
                else{
                    pre_val = *(*iter).begin();
                    auto iiter = (*iter).begin();iiter++;
                    succ_val = *iiter;
                }
                auto iter_val = dynamic_cast<Instruction*>(succ_val);
                if(iter_val->get_parent()==bb_true){
                    true_val_move.push_back({succ_val,NULL});
                    true_val_move.push_back({pre_val,succ_val});
                }
                else{
                    false_val_move.push_back({succ_val,NULL});
                    false_val_move.push_back({pre_val,succ_val});
                }
                succ_node->pre.erase(pre_node);
                pre_node->succ.erase(succ_node);
                pre_node->pair.erase(succ_node);
            }
        }
    }
}
void CodeGen::move_data(std::vector<std::set<Value*>> val_move){
    for(auto move_set : val_move){
        Value* val_from = *move_set.begin();
        auto it = move_set.begin(); it++;
        Value* val_to = *it;
        if(val_to==NULL){
            save_val.insert(val_from);
            if(val_from->get_type()->is_integer_type()){
                store_from_greg(val_from,Reg::t(m->get_handle(val_from)));
            }
            else{
                store_from_freg(val_from,FReg::ft(m->get_handle(val_from)));
            }
        }
        else{
            auto inst = dynamic_cast<Instruction*>(val_to);
            append_inst(inst->print(), ASMInstruction::Comment);
            if(m->get_handle(val_from)!=-1&&m->get_handle(val_to)!=-1){
                if((val_to)->get_type()->is_integer_type()){
                    if(save_val.count(val_from)>0){
                        load_to_greg(val_from,Reg::t(7));
                        append_inst("add.d",{Reg::t(m->get_handle(val_to)).print(),
                            Reg::t(7).print(),"$zero"});
                    }
                    else{
                        append_inst("add.d",{Reg::t(m->get_handle(val_to)).print(),
                            Reg::t(m->get_handle(val_from)).print(),"$zero"});
                    }
                }
                else{
                    if(save_val.count(val_from)>0){
                        load_to_freg(val_from,FReg::ft(15));
                        append_inst("movgr2fr.w",{FReg::ft(14).print(),"$zero"});
                        append_inst("fadd.s",{FReg::ft(m->get_handle(val_to)).print(),
                            FReg::ft(15).print(),FReg::ft(14).print()});
                    }
                    else{
                        append_inst("movgr2fr.w",{FReg::ft(14).print(),"$zero"});
                        append_inst("fadd.s",{FReg::ft(m->get_handle(val_to)).print(),
                            FReg::ft(m->get_handle(val_from)).print(),FReg::ft(14).print()});
                    }
                }
            }
            else if(m->get_handle(val_from)!=-1&&m->get_handle(val_to)==-1){
                if((val_to)->get_type()->is_integer_type()){
                    if(save_val.count(val_from)>0){
                        load_to_greg(val_from,Reg::t(7));
                        append_inst("add.d",{Reg::t(7).print(),
                            Reg::t(7).print(),"$zero"});
                        store_from_greg(val_to,Reg::t(7));
                    }
                    else{
                        append_inst("add.d",{Reg::t(7).print(),
                            Reg::t(m->get_handle(val_from)).print(),"$zero"});
                        store_from_greg(val_to,Reg::t(7));
                    }
                }
                else{
                    if(save_val.count(val_from)>0){
                        load_to_freg(val_from,FReg::ft(15));
                        append_inst("movgr2fr.w",{FReg::ft(14).print(),"$zero"});
                        append_inst("fadd.s",{FReg::ft(15).print(),
                            FReg::ft(15).print(),FReg::ft(14).print()});
                        store_from_freg(val_to,FReg::ft(15));
                    }
                    else{
                        append_inst("movgr2fr.w",{FReg::ft(14).print(),"$zero"});
                        append_inst("fadd.s",{FReg::ft(15).print(),
                            FReg::ft(m->get_handle(val_from)).print(),FReg::ft(14).print()});
                        store_from_freg(val_to,FReg::ft(15));
                    }
                }
            }
            else if(m->get_handle(val_from)==-1&&m->get_handle(val_to)!=-1){
                if((val_to)->get_type()->is_integer_type()){
                    load_to_greg(val_from,Reg::t(7));
                    append_inst("add.d",{Reg::t(m->get_handle(val_to)).print(),
                        Reg::t(7).print(),"$zero"});
                }
                else{
                    load_to_freg(val_from,FReg::ft(15));
                    append_inst("movgr2fr.w",{FReg::ft(14).print(),"$zero"});
                    append_inst("fadd.s",{FReg::ft(m->get_handle(val_to)).print(),
                        FReg::ft(15).print(),FReg::ft(14).print()});
                }
            }
            else{
                if((val_to)->get_type()->is_integer_type()){
                    load_to_greg(val_from,Reg::t(7));
                    append_inst("add.d",{Reg::t(7).print(),
                        Reg::t(7).print(),"$zero"});
                    store_from_greg(val_to,Reg::t(7));
                }
                else{
                    load_to_freg(val_from,FReg::ft(15));
                    append_inst("movgr2fr.w",{FReg::ft(14).print(),"$zero"});
                    append_inst("fadd.s",{FReg::ft(15).print(),
                        FReg::ft(15).print(),FReg::ft(14).print()});
                    store_from_freg(val_to,FReg::ft(15));
                }
            }
        }
    }
}
