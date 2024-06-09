#include "IRBuilder.hpp"
#include "Value.hpp"
#include "RegAlloca.hpp"

void RegAlloca::run(){
    activevar_ = std::make_unique<ActiveVar>(m_);
    activevar_ ->run();
    for(auto &f : m_->get_functions()){
        if (f.is_declaration()) continue;
        interval_.clear();
        unhandle_.clear();
        ractive_.clear();
        factive_.clear();
        auto func_ = &f;
        live_interval(func_);
        alloca_reg(func_);
    }
    m_->set_handle(handle_);
}
void RegAlloca::live_interval(Function *f){
    std::map<BasicBlock *, bool> marked;
    for (auto &bb : f->get_basic_blocks()) {
        marked.insert({&bb, false});
    }
    std::vector<BasicBlock *> postorder;
    std::vector<BasicBlock *> r_postorder;
    std::vector<BasicBlock *> stack;
    stack.push_back(f->get_entry_block());
    marked[f->get_entry_block()]=true;
    while(!stack.empty()){
        bool changed = false;
        for(auto &bb1 : stack.back()->get_succ_basic_blocks()){
            if(marked[bb1]==false){
                stack.push_back(bb1);
                marked[bb1]=true;
                changed=true;
            }
        }
        if(changed==false){
            postorder.insert(postorder.begin(),stack.back());
            r_postorder.insert(r_postorder.end(),stack.back());
            stack.pop_back();
        }
    }

    std::map<Instruction*,int> inst_id;
    int id = 0;
    for(auto bb : postorder){
        for(auto &inst : bb->get_instructions()){
            inst_id.insert({&inst,id});
            id = id + 2;
        }
    }

    for(auto bb : postorder){
        int bb_from = inst_id[&(bb->get_instructions().front())];
        int bb_to = inst_id[&(bb->get_instructions().back())]+1;
        for(auto val : activevar_->get_out(bb))
            add_range(val,bb_from,bb_to);
    }

    for(auto bb : r_postorder){
        auto iter = bb->get_instructions().end();
        while(iter!=bb->get_instructions().begin()){
            iter--;
            auto ir = &(*iter);
            if(ir->is_add()||ir->is_sub()||ir->is_mul()||ir->is_div()
                ||ir->is_fadd()||ir->is_fsub()||ir->is_fmul()||ir->is_fdiv()
                ||ir->is_cmp()||ir->is_fcmp()
                ||ir->is_fp2si()||ir->is_si2fp()||ir->is_zext()){
                for(auto val : ir->get_operands()){
                    if(!dynamic_cast<ConstantInt *>(val)&&!dynamic_cast<ConstantFP *>(val)){
                        add_range(val,-1,inst_id[ir]);
                    }
                }
                add_range(ir,inst_id[ir]+1,-1);
            }
            else if(ir->is_store()){
                auto val_1 = ir->get_operand(0);
                auto val_2 = ir->get_operand(1);
                if(!dynamic_cast<ConstantInt *>(val_1)&&!dynamic_cast<ConstantFP *>(val_1)){
                    add_range(val_1,-1,inst_id[ir]);
                }
                add_range(val_2,inst_id[ir]+1,-1);
            }
            else if(ir->is_load()){
                auto val_1 = ir->get_operand(0);
                if(!dynamic_cast<ConstantInt *>(val_1)&&!dynamic_cast<ConstantFP *>(val_1)){
                    add_range(val_1,-1,inst_id[ir]);
                }
                add_range(ir,inst_id[ir]+1,-1);
            }
            else if(ir->is_br()){
                auto _ir = dynamic_cast<BranchInst *>(ir);
                if(_ir->is_cond_br()){
                    auto val = _ir->get_operand(0);
                    if(!dynamic_cast<ConstantInt *>(val)&&!dynamic_cast<ConstantFP *>(val)){
                        add_range(val,-1,inst_id[ir]);
                    }
                }
            }
            else if(ir->is_call()){
                for(auto val : ir->get_operands()){
                    if(val->get_type()->is_function_type()){
                        add_range(val,inst_id[ir],inst_id[ir]+1);
                    }
                    else if(!dynamic_cast<ConstantInt *>(val)&&!dynamic_cast<ConstantFP *>(val)){
                        add_range(val,-1,inst_id[ir]);
                    }
                }
                if(!ir->is_void()){
                    add_range(ir,inst_id[ir]+1,-1);
                }
            }
            else if(ir->is_ret()){
                if(!ir->is_void()){
                    auto val = ir->get_operand(0);
                    if(!dynamic_cast<ConstantInt *>(val)&&!dynamic_cast<ConstantFP *>(val)){
                        add_range(val,-1,inst_id[ir]);
                    }
                }
            }
            else if(ir->is_phi()){
                for(long unsigned int i=0; i<ir->get_num_operand()/2; i++){
                    auto val = ir->get_operand(2*i);
                    if(!dynamic_cast<ConstantInt *>(val)&&!dynamic_cast<ConstantFP *>(val)){
                        add_range(val,-1,inst_id[ir]);     
                    }
                }
                add_range(ir,inst_id[&(bb->get_instructions().front())],-1);
            }
            else if(ir->is_gep()){
                for(auto val : ir->get_operands()){
                    if(!dynamic_cast<ConstantInt *>(val)&&!dynamic_cast<ConstantFP *>(val)){
                        add_range(val,-1,inst_id[ir]);
                    }
                }
                add_range(ir,inst_id[ir]+1,-1);
            }
            else if(ir->is_alloca()){
                add_range(ir,inst_id[ir]+1,-1);
            }
        }
    }
}
void RegAlloca::add_range(Value* val,int start,int end){
    if(start==-1){
        if(interval_[val].end==-1||interval_[val].end<end)
            interval_[val].end = end;
    }
    else if(end==-1){
        interval_[val].start = start;
    }
    else{
        if(interval_[val].start==-1)
            interval_[val].start = start;
        if(interval_[val].end==-1||interval_[val].end<end)
            interval_[val].end = end;
    }
}
void RegAlloca::alloca_reg(Function* f){
    for(int i=0;i<=INT_REG;i++) free_greg.insert(i);
    for(int i=0;i<=FP_REG;i++) free_freg.insert(i);
    build_unhandle(f);
    for(auto iter=unhandle_.begin();iter!=unhandle_.end();iter++){
        auto val=*iter;
        expire_old(val);
        if(val->get_type()->is_integer_type()||val->get_type()->is_pointer_type()){
            if(free_greg.size()==0){
                spill(val);
            }
            else{
                handle_[val]=*(free_greg.begin());
                free_greg.erase(free_greg.begin());
                auto iiter = ractive_.begin();
                for(;iiter!=ractive_.end();iiter++){
                    if(get_end(val)<get_end(*iiter)){
                        ractive_.insert(iiter,val);
                        break;
                    }
                }
                if(iiter==ractive_.end()){
                    ractive_.insert(ractive_.end(),val);
                }
            }
        }
        else if(val->get_type()->is_function_type()){
            for(auto iiter=ractive_.begin();iiter!=ractive_.end();iiter++){
                auto temp = *iiter;
                handle_.erase(temp);
            }
            for(auto iiter=factive_.begin();iiter!=factive_.end();iiter++){
                auto temp = *iiter;
                handle_.erase(temp);
            }
            ractive_.clear();
            factive_.clear();
        }
        else{
            if(free_freg.size()==0){
                spill(val);
            }
            else{
                handle_[val]=*(free_freg.begin());
                free_freg.erase(free_freg.begin());
                auto iiter = factive_.begin();
                for(;iiter!=factive_.end();iiter++){
                    if(get_end(val)<get_end(*iiter)){
                        factive_.insert(iiter,val);
                        break;
                    }
                }
                if(iiter==factive_.end()){
                    factive_.insert(factive_.end(),val);
                }
            }
        }
    }
}
void RegAlloca::build_unhandle(Function* f){
    for(auto &iter : interval_){
        auto val = iter.first;
        if(unhandle_.size()==0){
            unhandle_.insert(unhandle_.end(),val);
        }
        else{
            auto iiter = unhandle_.begin();
            for(;iiter!=unhandle_.end();iiter++){
                if(get_start(val)<get_start(*iiter)){
                    unhandle_.insert(iiter,val);
                    break;
                }
            }
            if(iiter==unhandle_.end()){
                unhandle_.insert(unhandle_.end(),val);
            }
        }
    }
}
void RegAlloca::expire_old(Value* val){
    if(val->get_type()->is_function_type()){
        auto iiter=ractive_.begin();
        while(iiter!=ractive_.end()){
            auto vval=*iiter;
            if(get_end(vval)>get_start(val)){
                return;
            }
            ractive_.erase(iiter);
            free_greg.insert(handle_[vval]);
            iiter=ractive_.begin();
        }
        auto iiter2=factive_.begin();
        while(iiter2!=factive_.end()){
            auto vval=*iiter2;
            if(get_end(vval)>get_start(val)){
                return;
            }
            factive_.erase(iiter2);
            free_greg.insert(handle_[vval]);
            iiter2=factive_.begin();
        }
    }
    else if(val->get_type()->is_integer_type()||val->get_type()->is_pointer_type()){
        auto iiter2=ractive_.begin();
        while(iiter2!=ractive_.end()){
            auto vval=*iiter2;
            if(get_end(vval)>get_start(val)){
                return;
            }
            ractive_.erase(iiter2);
            free_greg.insert(handle_[vval]);
            iiter2=ractive_.begin();
        }
    }
    else{
        auto iiter2=factive_.begin();
        while(iiter2!=factive_.end()){
            auto vval=*iiter2;
            if(get_end(vval)>get_start(val)){
                return;
            }
            factive_.erase(iiter2);
            free_greg.insert(handle_[vval]);
            iiter2=factive_.begin();
        }
    }
}
void RegAlloca::spill(Value* val){
    if(val->get_type()->is_integer_type()||val->get_type()->is_pointer_type()){
        auto iter = ractive_.end();
        iter--;
        auto vval = *iter;
        if(get_end(vval)>=get_end(val)){
            handle_[val] = handle_[vval];
            handle_.erase(vval);
            ractive_.erase(iter);
            auto iiter=ractive_.begin();
            for(;iiter!=ractive_.end();iiter++){
                auto vvval=*iiter;
                if(get_end(val)<get_end(vvval)){
                    ractive_.insert(iiter,val);
                    break;
                }
            }
            if(iiter==ractive_.end()){
                ractive_.insert(ractive_.end(),val);
            }
        }
    }
    else{
        auto iter = factive_.end();
        auto vval = *iter;
        if(get_end(vval)>=get_end(val)){
            handle_[val] = handle_[vval];
            handle_.erase(vval);
            factive_.erase(iter);
            auto iiter=factive_.begin();
            for(;iiter!=factive_.end();iiter++){
                auto vvval=*iiter;
                if(get_end(val)<get_end(vvval)){
                    factive_.insert(iiter,val);
                    break;
                }
            }
            if(iiter==factive_.end()){
                factive_.insert(factive_.end(),val);
            }
        }
    }
}