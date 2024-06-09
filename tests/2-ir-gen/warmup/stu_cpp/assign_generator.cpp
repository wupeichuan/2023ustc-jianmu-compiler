#include "BasicBlock.hpp"
#include "Constant.hpp"
#include "Function.hpp"
#include "IRBuilder.hpp"
#include "Module.hpp"
#include "Type.hpp"

#include <iostream>
#include <memory>



int main(){
    auto module = new Module();
    auto builder = new IRBuilder(nullptr,module);
    Type *Int32Type = module->get_int32_type();
    auto *ArrayType = ArrayType::get(Int32Type,10);
    auto mainFun = Function::create(FunctionType::get(Int32Type,{}),"main",module);
    auto bb = BasicBlock::create(module,"entry",mainFun);
    builder->set_insert_point(bb);
    
    auto aAlloca = builder->create_alloca(ArrayType);
    
    auto a0GEP = builder->create_gep(aAlloca,{ConstantInt::get(0,module),ConstantInt::get(0,module)});
    builder->create_store(ConstantInt::get(10,module),a0GEP);
    
    auto conAlloca = builder->create_alloca(Int32Type);
    builder->create_store(ConstantInt::get(2,module),conAlloca);
    a0GEP = builder->create_gep(aAlloca,{ConstantInt::get(0,module),ConstantInt::get(0,module)});
    auto conLoad = builder->create_load(conAlloca);
    auto a0Load = builder->create_load(a0GEP);
    auto mul = builder->create_imul(a0Load,conLoad);
    auto a1GEP = builder->create_gep(aAlloca,{ConstantInt::get(0,module),ConstantInt::get(1,module)});
    builder->create_store(mul,a1GEP);

    auto a1Load = builder->create_load(a1GEP);
    builder->create_ret(a1Load);

    std::cout << module->print();
    delete module;
    return 0;
}
