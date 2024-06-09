#include "Dominators.hpp"

void Dominators::run() {
    for (auto &f1 : m_->get_functions()) {
        auto f = &f1;
        if (f->get_basic_blocks().size() == 0)
            continue;
        for (auto &bb1 : f->get_basic_blocks()) {
            auto bb = &bb1;
            idom_.insert({bb, {}});
            dom_frontier_.insert({bb, {}});
            dom_tree_succ_blocks_.insert({bb, {}});
        }

        create_idom(f);
        create_dominance_frontier(f);
        create_dom_tree_succ(f);
    }
}

void Dominators::create_idom(Function *f) {
    // TODO 分析得到 f 中各个基本块的 idom
    // First: get the reverse postorder
    std::map<BasicBlock *, bool> marked;
    for (auto &bb : f->get_basic_blocks()) {
        marked.insert({&bb, false});
    }
    std::vector<BasicBlock *> stack;
    std::vector<BasicBlock *> postorder;
    stack.push_back(f->get_entry_block());
    marked[f->get_entry_block()]=true;
    while(!stack.empty()){
        bool changed = false;
        for(auto &bb1 : stack.back()->get_succ_basic_blocks()){
            if(marked[bb1]==false){
                stack.push_back(bb1);
                marked[bb1]=true;
                changed=true;
            }
        }
        if(changed==false){
            postorder.insert(postorder.begin(),stack.back());
            stack.pop_back();
        }
    }
    std::map<BasicBlock *, int> postorder_num;
    for(long unsigned int i=0; i<postorder.size(); i++){
        postorder_num.insert({postorder[i],i});
    }
    postorder.erase(postorder.begin());

    // Second: idom
    idom_[f->get_entry_block()]=f->get_entry_block();
    bool changed = true;
    while(changed){
        changed = false;
        for(auto bb2: postorder){
            auto pre_list = (bb2)->get_pre_basic_blocks();
            auto new_idom = pre_list.front();
            pre_list.erase(pre_list.begin());
            for(auto &bb3: pre_list){
                if(get_idom(bb3)!= nullptr){
                    auto finger1 = new_idom;
                    auto finger2 = bb3;
                    while(postorder_num.at(finger1)!=postorder_num.at(finger2)){
                        while(postorder_num.at(finger1)>postorder_num.at(finger2)){
                            finger1 = get_idom(finger1);
                        }
                        while(postorder_num.at(finger1)<postorder_num.at(finger2)){
                            finger2 = get_idom(finger2);
                        }
                    }
                    new_idom = finger1;
                }
            }
            if(get_idom(bb2)!=new_idom){
                idom_[bb2] = new_idom;
                changed = true;
            }
        }
    }
}

void Dominators::create_dominance_frontier(Function *f) {
    // TODO 分析得到 f 中各个基本块的支配边界集合
    for(auto &bb : f->get_basic_blocks()){
        if((&bb)==f->get_entry_block()) continue;
        auto pre_list = (&bb)->get_pre_basic_blocks();
        if(pre_list.size()>=2){
            for(auto bb1 : pre_list){
                auto runner = bb1;
                while(runner!=get_idom(&bb)){
                    dom_frontier_[runner].insert(&bb);
                    runner = get_idom(runner);
                }
            }
        }
    }
}

void Dominators::create_dom_tree_succ(Function *f) {
    // TODO 分析得到 f 中各个基本块的支配树后继
    for(auto &bb : f->get_basic_blocks()){
        if((&bb) == f->get_entry_block()) continue;
        auto pre = get_idom(&bb);
        dom_tree_succ_blocks_[pre].insert(&bb);
    }
}
