#include "BasicBlock.hpp"
#include "Constant.hpp"
#include "Function.hpp"
#include "IRBuilder.hpp"
#include "Module.hpp"
#include "Type.hpp"

#include <iostream>
#include <memory>

//this program is not proper
int main() {
    auto module = new Module();
    auto builder = new IRBuilder(nullptr,module);
    Type *Int32Type = module->get_int32_type();
    Type *FloatType = module->get_float_type();
    auto mainFun = Function::create(FunctionType::get(Int32Type,{}),"main",module);
    auto bb = BasicBlock::create(module,"entry",mainFun);
    builder->set_insert_point(bb);
    auto aAlloca = builder->create_alloca(FloatType);
    builder->create_store(ConstantFP::get(5.555,module),aAlloca);

    auto conAlloca = builder->create_alloca(FloatType);
    builder->create_store(ConstantFP::get(1,module),conAlloca);
    auto conLoad = builder->create_load(conAlloca);
    
    auto aLoad = builder->create_load(aAlloca);

    auto icmp = builder->create_fcmp_gt(aLoad, conLoad);

    auto trueBB = BasicBlock::create(module, "trueBB", mainFun);
    auto falseBB = BasicBlock::create(module, "falseBB", mainFun);
    builder->create_cond_br(icmp,trueBB,falseBB);
    
    builder->set_insert_point(trueBB);
    builder->create_ret(ConstantInt::get(233,module));
    
    builder->set_insert_point(falseBB);
    builder->create_ret(ConstantInt::get(0,module));
    
    std::cout << module->print();
    delete module;
    return 0; 
}
