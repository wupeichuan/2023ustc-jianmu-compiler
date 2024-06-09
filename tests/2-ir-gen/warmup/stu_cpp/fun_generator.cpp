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
    auto calleeFun = Function::create(FunctionType::get(Int32Type,{Int32Type}),"callee",module);
    auto bb = BasicBlock::create(module,"entry",calleeFun);
    builder->set_insert_point(bb);
    std::vector<Value *> args;
    for (auto &arg: calleeFun->get_args()) {
        args.push_back(&arg);
    }
    auto aAlloca = builder->create_alloca(Int32Type);
    builder->create_store(args[0],aAlloca);
    auto aLoad = builder->create_load(aAlloca);
    auto conAlloca = builder->create_alloca(Int32Type);
    builder->create_store(ConstantInt::get(2,module),conAlloca);
    auto conLoad = builder->create_load(conAlloca);
    auto mul = builder->create_imul(conLoad,aLoad);
    builder->create_ret(mul);

    auto mainFun = Function::create(FunctionType::get(Int32Type,{}),"main",module);
    bb = BasicBlock::create(module,"entry",mainFun);
    builder->set_insert_point(bb);
    auto cAlloca = builder->create_alloca(Int32Type);
    builder->create_store(ConstantInt::get(110,module),cAlloca);
    auto cLoad = builder->create_load(cAlloca);

    auto call = builder->create_call(calleeFun,{cLoad});
    builder->create_ret(call);

    std::cout << module->print();
    delete module;
    return 0;
}
