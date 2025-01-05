#include "Mem2Reg.hpp"
#include "IRBuilder.hpp"
#include "Value.hpp"

#include <memory>

void Mem2Reg::run() {
  // 创建支配树分析 Pass 的实例
  dominators_ = std::make_unique<Dominators>(m_);
  // 建立支配树
  dominators_->run();
  // 以函数为单元遍历实现 Mem2Reg 算法
  for (auto &f : m_->get_functions()) {
    if (f.is_declaration()) continue;
    func_ = &f;
    if (func_->get_basic_blocks().size() >= 1) {
      // 对应伪代码中 phi 指令插入的阶段
      generate_phi();
      // 对应伪代码中重命名阶段
      auto bb = func_->get_entry_block();
      rename(bb);
    }
    delete_alloca();
    // 后续 DeadCode 将移除冗余的局部变量的分配空间
  }
}

void Mem2Reg::generate_phi() {
  // TODO
  // 步骤一：找到活跃在多个 block 的全局名字集合，以及它们所属的 bb 块
  std::map<Value *, BBSet> globalname_map;
  std::set<Value *> globalname;
  for (auto &bb : func_->get_basic_blocks()) {
    for (auto &inst : (&bb)->get_instructions()) {
      if ((&inst)->is_store()) {
        auto val = (&inst)->get_operand(1);
        if (is_valid_ptr(val)) {
          globalname_map[val].insert(&bb);
          globalname.insert(val);
        }
      }
    }
  }

  std::set<Value *> new_globalname;
  for (auto val : globalname) {
    if (globalname_map[val].size() < 2)
      globalname_map.erase(val);
    else
      new_globalname.insert(val);
  }

  // 步骤二：从支配树获取支配边界信息，并在对应位置插入 phi 指令
  for (auto val : new_globalname) {
    BBSet F;
    BBSet W;
    W = globalname_map[val];
    while (W.size() > 0) {
      BasicBlock *X = *(W.cbegin());
      W.erase(W.begin());
      for (auto bb1 : dominators_->get_dominance_frontier(X)) {
        if (F.count(bb1) == 0) {
          if ((val)->get_type()->get_pointer_element_type()->is_integer_type()) {
            auto inst = PhiInst::create_phi((bb1)->get_module()->get_int32_type(), bb1);
            (bb1)->add_instr_begin(inst);
            phi_value.insert({inst, val});
          } else {
            auto inst = PhiInst::create_phi((bb1)->get_module()->get_float_type(), bb1);
            (bb1)->add_instr_begin(inst);
            phi_value.insert({inst, val});
          }
          F.insert(bb1);
          if (globalname_map[val].count(bb1) == 0) W.insert(bb1);
        }
      }
    }
  }
}

void Mem2Reg::rename(BasicBlock *bb) {
  // TODO
  // 步骤三：将 phi 指令作为 lval 的最新定值，lval 即是为局部变量 alloca 出的地址空间
  // 步骤四：用 lval 最新的定值替代对应的load指令
  // 步骤五：将 store 指令的 rval，也即被存入内存的值，作为 lval 的最新定值
  // 步骤六：为 lval 对应的 phi 指令参数补充完整
  // 步骤七：对 bb 在支配树上的所有后继节点，递归执行 re_name 操作
  // 步骤八：pop出 lval 的最新定值
  // 步骤九：清除冗余的指令
  if (mark_.count(bb) == 0) {
    std::set<Instruction *> delete_list;
    mark_.insert(bb);
    for (auto &inst : bb->get_instructions()) {
      if ((&inst)->is_phi()) {
        auto ist = static_cast<PhiInst *>(&inst);
        auto val = phi_value[ist];
        auto load = static_cast<Value *>(&inst);
        stack_[val].push_back(load);
      } else if ((&inst)->is_store()) {
        auto val = (&inst)->get_operand(1);
        auto load = (&inst)->get_operand(0);
        if (is_valid_ptr(val)) {
          bool flag = false;
          for (auto &args : func_->get_args()) {
            if (&args == load) {
              flag = true;
              arg_alloca.insert(val);
              break;
            }
          }
          if (flag == false) {
            stack_[val].push_back(load);
            delete_list.insert((&inst));
          }
        }
      } else if ((&inst)->is_load()) {
        if (stack_[(&inst)->get_operand(0)].size() > 0) {
          auto load = static_cast<Value *>(&inst);
          auto val = stack_[(&inst)->get_operand(0)].back();
          if (is_valid_ptr(val)) {
            auto list = load->get_use_list();
            for (auto _list : list) {
              _list.val_->set_operand(_list.arg_no_, val);
            }
            delete_list.insert((&inst));
          }
        }
      }
    }
    for (auto &bb1 : bb->get_succ_basic_blocks()) {
      for (auto &inst : (bb1)->get_instructions()) {
        if ((&inst)->is_phi()) {
          auto ist = static_cast<PhiInst *>(&inst);
          if (stack_[phi_value[ist]].size() > 0) {  // if not, it will make bug
            auto val = stack_[phi_value[ist]].back();
            ist->add_phi_pair_operand(val, bb);
          }
        }
      }
    }
    for (auto &bb1 : bb->get_succ_basic_blocks()) rename(bb1);

    for (auto &inst : bb->get_instructions()) {
      if ((&inst)->is_phi()) {
        auto ist = static_cast<PhiInst *>(&inst);
        auto val = phi_value[ist];
        stack_[val].pop_back();
      } else if ((&inst)->is_store()) {
        auto val = (&inst)->get_operand(1);
        stack_[val].pop_back();
      }
    }

    for (auto &inst : delete_list) {
      bb->erase_instr(inst);
    }
  }
}
void Mem2Reg::delete_alloca() {
  for (auto &bb : func_->get_basic_blocks()) {
    std::set<Instruction *> wait_delete;
    for (auto &inst : (&bb)->get_instructions()) {
      if (dynamic_cast<AllocaInst *>(&inst)) {
        bool is_int = (&inst)->get_type()->get_pointer_element_type()->is_integer_type();
        bool is_float = (&inst)->get_type()->get_pointer_element_type()->is_float_type();
        if (is_int || is_float) {
          if (arg_alloca.count(&inst) == 0) wait_delete.insert(&inst);
        }
      }
    }
    for (auto inst : wait_delete) {
      (&bb)->erase_instr(inst);
    }
  }
}