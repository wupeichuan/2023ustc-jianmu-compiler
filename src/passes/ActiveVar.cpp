#include "ActiveVar.hpp"
#include "IRBuilder.hpp"
#include "Value.hpp"

void ActiveVar::run(){
    for(auto &f : m_->get_functions()){
        if (f.is_declaration()) continue;
        auto func_ = &f;
        for(auto &bb1 : func_->get_basic_blocks()) {
            auto bb = &bb1;
            live_in.insert({bb,{}});
            live_out.insert({bb,{}});
        }
        create_activevar(func_);
    }
}
void ActiveVar::create_activevar(Function *f){
    std::map<BasicBlock *, std::set<Value *>> use_bb, def_bb;
    for(auto &bb1 : f->get_basic_blocks()){
        for(auto &inst : (&bb1)->get_instructions()){
            auto ir = &inst;
            if(ir->is_add()||ir->is_sub()||ir->is_mul()||ir->is_div()
                ||ir->is_fadd()||ir->is_fsub()||ir->is_fmul()||ir->is_fdiv()
                ||ir->is_cmp()||ir->is_fcmp()
                ||ir->is_fp2si()||ir->is_si2fp()||ir->is_zext()){
                for(auto val : ir->get_operands()){
                    if(!dynamic_cast<ConstantInt *>(val)&&!dynamic_cast<ConstantFP *>(val)){
                        if(use_bb[&bb1].count(val)==0&&def_bb[&bb1].count(val)==0)
                            use_bb[&bb1].insert(val);
                    }
                }
                if(use_bb[&bb1].count(ir)==0&&def_bb[&bb1].count(ir)==0)
                    def_bb[&bb1].insert(ir);
            }
            else if(ir->is_store()){
                auto val_1 = ir->get_operand(0);
                auto val_2 = ir->get_operand(1);
                if(!dynamic_cast<ConstantInt *>(val_1)&&!dynamic_cast<ConstantFP *>(val_1)){
                    if(use_bb[&bb1].count(val_1)==0&&def_bb[&bb1].count(val_1)==0)
                            use_bb[&bb1].insert(val_1);
                }
                if(use_bb[&bb1].count(val_2)==0&&def_bb[&bb1].count(val_2)==0)
                    def_bb[&bb1].insert(val_2);
            }
            else if(ir->is_load()){
                auto val_1 = ir->get_operand(0);
                if(!dynamic_cast<ConstantInt *>(val_1)&&!dynamic_cast<ConstantFP *>(val_1)){
                    if(use_bb[&bb1].count(val_1)==0&&def_bb[&bb1].count(val_1)==0)
                            use_bb[&bb1].insert(val_1);
                }
                if(use_bb[&bb1].count(ir)==0&&def_bb[&bb1].count(ir)==0)
                    def_bb[&bb1].insert(ir);
            }
            else if(ir->is_br()){
                auto _ir = dynamic_cast<BranchInst *>(ir);
                if(_ir->is_cond_br()){
                    auto val = _ir->get_operand(0);
                    if(!dynamic_cast<ConstantInt *>(val)&&!dynamic_cast<ConstantFP *>(val)){
                        if(use_bb[&bb1].count(val)==0&&def_bb[&bb1].count(val)==0)
                                use_bb[&bb1].insert(val);
                    }
                }
            }
            else if(ir->is_call()){
                for(auto val : ir->get_operands()){
                    if(val->get_type()->is_function_type()) continue;
                    if(!dynamic_cast<ConstantInt *>(val)&&!dynamic_cast<ConstantFP *>(val)){
                        if(use_bb[&bb1].count(val)==0&&def_bb[&bb1].count(val)==0)
                                use_bb[&bb1].insert(val);
                    }
                }
                if(!ir->is_void()){
                    if(use_bb[&bb1].count(ir)==0&&def_bb[&bb1].count(ir)==0)
                        def_bb[&bb1].insert(ir);
                }
            }
            else if(ir->is_ret()){
                if(!ir->is_void()){
                    auto val = ir->get_operand(0);
                    if(!dynamic_cast<ConstantInt *>(val)&&!dynamic_cast<ConstantFP *>(val)){
                        if(use_bb[&bb1].count(val)==0&&def_bb[&bb1].count(val)==0)
                                use_bb[&bb1].insert(val);
                    }
                }
            }
            else if(ir->is_phi()){
                for(long unsigned int i=0; i<ir->get_num_operand()/2; i++){
                    auto val = ir->get_operand(2*i);
                    if(!dynamic_cast<ConstantInt *>(val)&&!dynamic_cast<ConstantFP *>(val)){
                        if(use_bb[&bb1].count(val)==0&&def_bb[&bb1].count(val)==0)
                            use_bb[&bb1].insert(val);
                    }
                }
                if(use_bb[&bb1].count(ir)==0&&def_bb[&bb1].count(ir)==0)
                    def_bb[&bb1].insert(ir);
            }
            else if(ir->is_gep()){
                for(auto val : ir->get_operands()){
                    if(!dynamic_cast<ConstantInt *>(val)&&!dynamic_cast<ConstantFP *>(val)){
                        if(use_bb[&bb1].count(val)==0&&def_bb[&bb1].count(val)==0)
                                use_bb[&bb1].insert(val);
                    }
                }
                if(use_bb[&bb1].count(ir)==0&&def_bb[&bb1].count(ir)==0)
                    def_bb[&bb1].insert(ir);
            }
            else if(ir->is_alloca()){
                if(def_bb[&bb1].count(ir)==0&&def_bb[&bb1].count(ir)==0)
                    def_bb[&bb1].insert(ir);
            }
        }
    }

    bool changed = true;
    while(changed){
        changed = false;
        for(auto &bb1 : f->get_basic_blocks()){
            std::set<Value *> succ_union;
            for(auto succ : (&bb1)->get_succ_basic_blocks()){
                std::set_union(live_in[succ].begin(),live_in[succ].end(),
                    succ_union.begin(),succ_union.end(),std::inserter(succ_union,succ_union.end()));
            }
            live_out[&bb1] = succ_union;
            std::set<Value*> diff;
            std::set_difference(live_out[&bb1].begin(),live_out[&bb1].end(),
                def_bb[&bb1].begin(),def_bb[&bb1].end(),std::inserter(diff,diff.end()));
            auto record = live_in[&bb1];
            std::set_union(use_bb[&bb1].begin(),use_bb[&bb1].end(),
                diff.begin(),diff.end(),std::inserter(live_in[&bb1],live_in[&bb1].end()));
            if(record!=live_in[&bb1])
                changed = true;
        }
    }
}