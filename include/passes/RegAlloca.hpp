#pragma once

#include "PassManager.hpp"
#include "Instruction.hpp"
#include "Value.hpp"
#include "ActiveVar.hpp"

// #define INT_REG (8-2)
// #define FP_REG (15-2)

#define INT_REG 1
#define FP_REG 1

class RegAlloca : public Pass
{
public:
    RegAlloca(Module *m) : Pass(m) {}
    void run();
    void live_interval(Function *f);
    void add_range(Value* val,int start,int end);
    void alloca_reg(Function* f);
    void build_unhandle(Function* f);
    void expire_old(Value* val);
    void spill(Value* val);
    int get_start(Value* val){return interval_[val].start;}
    int get_end(Value* val){return interval_[val].end;}
private:
    struct time{
        int start = -1;
        int end = -1;
    };
    std::list<Value*> unhandle_;
    std::list<Value*> ractive_;
    std::list<Value*> factive_;
    std::map<Value*,int> handle_;
    std::set<int> free_greg;
    std::set<int> free_freg;
    std::map<Value*,struct time> interval_;
    std::unique_ptr<ActiveVar> activevar_;
    Value* ffun;
};