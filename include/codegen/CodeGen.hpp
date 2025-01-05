#pragma once

#include <memory>
#include <unordered_set>
#include "ASMInstruction.hpp"
#include "Module.hpp"
#include "Register.hpp"
struct Node {
  std::unordered_set<Value *> val;
  std::unordered_set<std::shared_ptr<struct Node>> succ;
  std::unordered_set<std::shared_ptr<struct Node>> pre;
  std::map<std::shared_ptr<struct Node>, std::vector<std::vector<Value *>>> pair;
};

class CodeGen {
 public:
  explicit CodeGen(Module *module) : m(module) {}

  std::string print() const;

  void run();

  template <class... Args>
  void append_inst(Args... arg) {
    output.emplace_back(arg...);
  }

  void append_inst(const char *inst, std::initializer_list<std::string> args,
                   ASMInstruction::InstType ty = ASMInstruction::Instruction) {
    auto content = std::string(inst) + " ";
    for (const auto &arg : args) {
      content += arg + ", ";
    }
    content.pop_back();
    content.pop_back();
    output.emplace_back(content, ty);
  }

 private:
  void allocate();

  // 向寄存器中装载数据
  void load_to_greg(Value *, const Reg &);
  void load_to_freg(Value *, const FReg &);
  void load_from_stack_to_greg(Value *, const Reg &);

  // 向寄存器中加载立即数
  void load_large_int32(int32_t, const Reg &);
  void load_large_int64(int64_t, const Reg &);
  void load_float_imm(float, const FReg &);

  // 将寄存器中的数据保存回栈上
  void store_from_greg(Value *, const Reg &);
  void store_from_freg(Value *, const FReg &);

  void gen_prologue();
  void gen_ret();
  void gen_br();
  void gen_binary();
  void gen_float_binary();
  void gen_alloca();
  void gen_load();
  void gen_store();
  void gen_icmp();
  void gen_fcmp();
  void gen_zext();
  void gen_call();
  void gen_gep();
  void gen_sitofp();
  void gen_fptosi();
  void gen_epilogue();
  bool is_change(BasicBlock *start, BasicBlock *end, Value *val);
  void phi_resort(BasicBlock *bb);
  void create_graph(BasicBlock *bb);
  std::shared_ptr<struct Node> find(Value *val);
  void move_data(std::vector<std::vector<Value *>> val_move);
  bool in_store(Value *val) {
    if (val->get_type()->is_integer_type() || val->get_type()->is_pointer_type()) {
      if (true2true_greg.count(m->get_handle(val)) > 0 && true2true_greg[m->get_handle(val)] == true)
        return true;
      else if (true2false_greg.count(m->get_handle(val)) > 0 && true2false_greg[m->get_handle(val)] == true)
        return true;
      else if (false2false_greg.count(m->get_handle(val)) > 0 && false2false_greg[m->get_handle(val)] == true)
        return true;
      else
        return false;
    } else {
      if (true2true_freg.count(m->get_handle(val)) > 0 && true2true_freg[m->get_handle(val)] == true)
        return true;
      else if (true2false_freg.count(m->get_handle(val)) > 0 && true2false_freg[m->get_handle(val)] == true)
        return true;
      else if (false2false_freg.count(m->get_handle(val)) > 0 && false2false_freg[m->get_handle(val)] == true)
        return true;
      else
        return false;
    }
  }
  void insert_true2false(Value *val) {
    if (val->get_type()->is_integer_type() || val->get_type()->is_pointer_type()) {
      if (m->get_handle(val) != -1) true2false_greg.insert({m->get_handle(val), false});
    } else if (m->get_handle(val) != -1)
      true2false_freg.insert({m->get_handle(val), false});
  }
  void insert_false2false(Value *val) {
    if (val->get_type()->is_integer_type() || val->get_type()->is_pointer_type()) {
      if (m->get_handle(val) != -1) false2false_greg.insert({m->get_handle(val), false});
    } else if (m->get_handle(val) != -1)
      false2false_freg.insert({m->get_handle(val), false});
  }
  void insert_true2true(Value *val) {
    if (val->get_type()->is_integer_type() || val->get_type()->is_pointer_type()) {
      if (m->get_handle(val) != -1) true2true_greg.insert({m->get_handle(val), false});
    } else if (m->get_handle(val) != -1)
      true2true_freg.insert({m->get_handle(val), false});
  }
  void insert_val(Value *val) {
    if (val->get_type()->is_integer_type() || val->get_type()->is_pointer_type()) {
      if (m->get_handle(val) != -1) gval[m->get_handle(val)] = val;
    } else if (m->get_handle(val) != -1)
      fval[m->get_handle(val)] = val;
  }
  Value *get_val(Value *val) {
    if (val->get_type()->is_integer_type() || val->get_type()->is_pointer_type()) {
      if (m->get_handle(val) != -1)
        return gval[m->get_handle(val)];
      else
        return NULL;
    } else if (m->get_handle(val) != -1)
      return fval[m->get_handle(val)];
    else
      return NULL;
  }
  bool is_need_store(Value *val, std::vector<std::vector<Value *>> val_move) {
    if (val->get_type()->is_integer_type() || val->get_type()->is_pointer_type()) {
      if (m->get_handle(val) != -1) {
        if (true2true_greg.count(m->get_handle(val)) > 0 && val_move == true_val_move && !in_store(val)) {
          true2true_greg[m->get_handle(val)] = true;
          return true;
        } else if (val_move == true_val_move && true2false_greg.count(m->get_handle(val)) > 0 && !in_store(val)) {
          true2false_greg[m->get_handle(val)] = true;
          return true;
        } else if (val_move == false_val_move && false2false_greg.count(m->get_handle(val) > 0 && !in_store(val))) {
          false2false_greg[m->get_handle(val)] = true;
          return true;
        } else
          return false;
      } else
        return false;
    } else {
      if (m->get_handle(val) != -1) {
        if (true2true_freg.count(m->get_handle(val)) > 0 && val_move == true_val_move && !in_store(val)) {
          true2true_freg[m->get_handle(val)] = true;
          return true;
        } else if (val_move == true_val_move && true2false_freg.count(m->get_handle(val)) > 0 && !in_store(val)) {
          true2false_freg[m->get_handle(val)] = true;
          return true;
        } else if (val_move == false_val_move && false2false_freg.count(m->get_handle(val)) > 0 && !in_store(val)) {
          false2false_freg[m->get_handle(val)] = true;
          return true;
        } else
          return false;
      } else
        return false;
    }
  }
  bool is_need_load(Value *val, std::vector<std::vector<Value *>> val_move) {
    if (val->get_type()->is_integer_type() || val->get_type()->is_pointer_type()) {
      if (m->get_handle(val) != -1) {
        if (true2true_greg.count(m->get_handle(val)) > 0 && true2true_greg[m->get_handle(val)] == true) {
          return true;
        } else if (val_move == false_val_move && true2false_greg.count(m->get_handle(val)) > 0 &&
                   true2false_greg[m->get_handle(val)] == true) {
          return true;
        } else if (val_move == false_val_move && false2false_greg.count(m->get_handle(val)) > 0 &&
                   false2false_greg[m->get_handle(val)] == true) {
          return true;
        } else
          return false;
      } else
        return false;
    } else {
      if (m->get_handle(val) != -1) {
        if (true2true_freg.count(m->get_handle(val)) > 0 && true2true_freg[m->get_handle(val)] == true) {
          return true;
        } else if (val_move == false_val_move && true2false_freg.count(m->get_handle(val)) > 0 &&
                   true2false_freg[m->get_handle(val)] == true) {
          return true;
        } else if (val_move == false_val_move && false2false_freg.count(m->get_handle(val)) > 0 &&
                   false2false_freg[m->get_handle(val)] == true) {
          return true;
        } else
          return false;
      } else
        return false;
    }
  }
  static std::string label_name(BasicBlock *bb) { return "." + bb->get_parent()->get_name() + "_" + bb->get_name(); }

  struct {
    /* 随着ir遍历设置 */
    Function *func{nullptr};     // 当前函数
    Instruction *inst{nullptr};  // 当前指令
    /* 在allocate()中设置 */
    unsigned frame_size{0};                         // 当前函数的栈帧大小
    std::unordered_map<Value *, int> offset_map{};  // 指针相对 fp 的偏移

    void clear() {
      func = nullptr;
      inst = nullptr;
      frame_size = 0;
      offset_map.clear();
    }

  } context;

  Module *m;
  std::list<ASMInstruction> output;

  std::shared_ptr<struct Node> graph_start;
  std::vector<std::vector<Value *>> true_val_move;
  std::vector<std::vector<Value *>> false_val_move;
  std::set<std::shared_ptr<struct Node>> true2false_node;
  std::map<int, bool> true2false_greg;
  std::map<int, bool> true2false_freg;
  std::map<int, bool> false2false_greg;
  std::map<int, bool> false2false_freg;
  std::map<int, bool> true2true_greg;
  std::map<int, bool> true2true_freg;
  std::map<int, Value *> gval;
  std::map<int, Value *> fval;
};
