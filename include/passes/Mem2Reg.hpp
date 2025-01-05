#pragma once

#include "Dominators.hpp"
#include "Instruction.hpp"
#include "Value.hpp"

#include <map>
#include <memory>

class Mem2Reg : public Pass {
 private:
  Function *func_;
  std::unique_ptr<Dominators> dominators_;
  // TODO 添加需要的变量
  using BBSet = std::set<BasicBlock *>;
  std::map<Value *, std::vector<Value *>> stack_;
  std::map<PhiInst *, Value *> phi_value;
  std::set<BasicBlock *> mark_;
  std::set<Value *> arg_alloca;

 public:
  Mem2Reg(Module *m) : Pass(m) {}
  ~Mem2Reg() = default;

  void run() override;

  void generate_phi();
  void rename(BasicBlock *bb);
  void delete_alloca();

  static inline bool is_global_variable(Value *l_val) { return dynamic_cast<GlobalVariable *>(l_val) != nullptr; }
  static inline bool is_gep_instr(Value *l_val) { return dynamic_cast<GetElementPtrInst *>(l_val) != nullptr; }

  static inline bool is_valid_ptr(Value *l_val) { return not is_global_variable(l_val) and not is_gep_instr(l_val); }
};
