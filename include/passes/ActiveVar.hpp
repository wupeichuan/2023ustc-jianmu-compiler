#pragma once

#include "Instruction.hpp"
#include "PassManager.hpp"
#include "Value.hpp"

class ActiveVar : public Pass {
 public:
  ActiveVar(Module *m) : Pass(m) {}
  void run();
  void create_activevar(Function *f);
  const std::set<Value *> &get_in(BasicBlock *bb) { return live_in.at(bb); }
  const std::set<Value *> &get_out(BasicBlock *bb) { return live_out.at(bb); }

 private:
  std::map<BasicBlock *, std::set<Value *>> live_in, live_out;
};