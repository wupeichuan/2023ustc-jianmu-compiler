#include "BasicBlock.hpp"
#include "Constant.hpp"
#include "Function.hpp"
#include "IRBuilder.hpp"
#include "Module.hpp"
#include "Type.hpp"

#include <iostream>
#include <memory>

int main() {
    auto module = new Module();
    auto builder = new IRBuilder(nullptr,module);
    Type *Int32Type = module->get_int32_type();
    auto mainFun = Function::create(FunctionType::get(Int32Type,{}),"main",module);
    auto bb = BasicBlock::create(module,"entry",mainFun);
    builder->set_insert_point(bb);

    auto aAlloca = builder->create_alloca(Int32Type);
    auto iAlloca = builder->create_alloca(Int32Type);
    builder->create_store(ConstantInt::get(10,module),aAlloca);
    builder->create_store(ConstantInt::get(0,module),iAlloca);

    auto trueBB = BasicBlock::create(module,"trueBB",mainFun);
    auto falseBB = BasicBlock::create(module,"falseBB",mainFun);
    auto iLoad = builder->create_load(iAlloca);  
    auto icmp = builder->create_icmp_lt(iLoad, ConstantInt::get(10,module));
    builder->create_cond_br(icmp,trueBB,falseBB);

    builder->set_insert_point(trueBB);
    iLoad = builder->create_load(iAlloca); 
    auto add = builder->create_iadd(iLoad,ConstantInt::get(1,module));
    builder->create_store(add,iAlloca);

    auto aLoad = builder->create_load(aAlloca); 
    iLoad = builder->create_load(iAlloca); 
    add = builder->create_iadd(aLoad,iLoad);
    builder->create_store(add,aAlloca);   

    icmp = builder->create_icmp_lt(iLoad, ConstantInt::get(10,module));
    builder->create_cond_br(icmp,trueBB,falseBB);

    builder->set_insert_point(falseBB);
    aLoad = builder->create_load(aAlloca); 
    builder->create_ret(aLoad);

    std::cout << module->print();
    delete module;
    return 0; 
}
