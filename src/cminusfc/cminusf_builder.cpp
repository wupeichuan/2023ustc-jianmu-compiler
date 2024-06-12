#include "cminusf_builder.hpp"

#define CONST_FP(num) ConstantFP::get((float)num, module.get())
#define CONST_INT(num) ConstantInt::get(num, module.get())

// types
Type *VOID_T;
Type *INT1_T;
Type *INT32_T;
Type *INT32PTR_T;
Type *FLOAT_T;
Type *FLOATPTR_T;

/*
 * use CMinusfBuilder::Scope to construct scopes
 * scope.enter: enter a new scope
 * scope.exit: exit current scope
 * scope.push: add a new binding to current scope
 * scope.find: find and return the value bound to the name
 */

Value* CminusfBuilder::visit(ASTProgram &node) {
    VOID_T = module->get_void_type();
    INT1_T = module->get_int1_type();
    INT32_T = module->get_int32_type();
    INT32PTR_T = module->get_int32_ptr_type();
    FLOAT_T = module->get_float_type();
    FLOATPTR_T = module->get_float_ptr_type();

    Value *ret_val = nullptr;
    for (auto &decl : node.declarations) {
        ret_val = decl->accept(*this);
    }
    return ret_val;
}

Value* CminusfBuilder::visit(ASTNum &node) {
    // TODO: This function is empty now.
    // Add some code here.
    if(node.type==TYPE_INT)
        return(ConstantInt::get(node.i_val,module.get()));
    else
        return(ConstantFP::get(node.f_val,module.get()));
}

Value* CminusfBuilder::visit(ASTVarDeclaration &node) {
    // TODO: This function is empty now.
    // Add some code here.
    Type *var_type;
    if (node.type == TYPE_INT){
        if(node.num==nullptr)
            var_type = INT32_T;
        else
            var_type = ArrayType::get(INT32_T,node.num->i_val);
    }
    else{
        if(node.num==nullptr)
            var_type = FLOAT_T;
        else
            var_type = ArrayType::get(FLOAT_T,node.num->i_val);
    }
    if(scope.in_global()){
        auto initializer = ConstantZero::get(var_type, module.get());
        auto glovarAlloca = GlobalVariable::create(node.id, module.get(), var_type, false, initializer);
        scope.push(node.id,glovarAlloca);
    }
    else{
        auto varAlloca = builder->create_alloca(var_type);
        scope.push(node.id,varAlloca);
    }
    return nullptr;
}

Value* CminusfBuilder::visit(ASTFunDeclaration &node) {
    FunctionType *fun_type;
    Type *ret_type;
    std::vector<Type *> param_types;
    if (node.type == TYPE_INT)
        ret_type = INT32_T;
    else if (node.type == TYPE_FLOAT)
        ret_type = FLOAT_T;
    else
        ret_type = VOID_T;

    for (auto &param : node.params) {
        // TODO: Please accomplish param_types.
        if(!param->isarray){
            if (param->type == TYPE_INT)
                param_types.push_back(INT32_T);
            else
                param_types.push_back(FLOAT_T);
        }
        else{
            if (param->type == TYPE_INT)
                param_types.push_back(INT32PTR_T);
            else
                param_types.push_back(FLOATPTR_T);            
        }
    }

    fun_type = FunctionType::get(ret_type, param_types);
    auto func = Function::create(fun_type, node.id, module.get());
    scope.push(node.id, func);
    context.func = func;
    auto funBB = BasicBlock::create(module.get(), "entry", func);
    builder->set_insert_point(funBB);
    scope.enter();
    std::vector<Value *> args;
    for (auto &arg : func->get_args()) {
        args.push_back(&arg);
    }
    for (long unsigned int i = 0; i < node.params.size(); ++i) {
        // TODO: You need to deal with params and store them in the scope.
        auto paramAlloca = builder->create_alloca(param_types[i]);
        builder->create_store(args[i],paramAlloca);
        scope.push(node.params[i]->id,paramAlloca);
    }
    node.compound_stmt->accept(*this);
    if (not builder->get_insert_block()->is_terminated())
    {
        if (context.func->get_return_type()->is_void_type())
            builder->create_void_ret();
        else if (context.func->get_return_type()->is_float_type())
            builder->create_ret(CONST_FP(0.));
        else
            builder->create_ret(CONST_INT(0));
    }
    scope.exit();
    return nullptr;
}

Value* CminusfBuilder::visit(ASTParam &node) {
    // TODO: This function is empty now.
    // Add some code here.
    return nullptr;
}

Value* CminusfBuilder::visit(ASTCompoundStmt &node) {
    // TODO: This function is not complete.
    // You may need to add some code here
    // to deal with complex statements.
    scope.enter();
    for (auto &decl : node.local_declarations) {
        decl->accept(*this);
    }

    for (auto &stmt : node.statement_list) {
        stmt->accept(*this);
        if (builder->get_insert_block()->is_terminated())
            break;
    }
    scope.exit();
    return nullptr;
}

Value* CminusfBuilder::visit(ASTExpressionStmt &node) {
    // TODO: This function is empty now.
    // Add some code here.
    auto pressionLoad = node.expression->accept(*this);
    return pressionLoad;                        
    //must remove the $PATH cminusfc
}

Value* CminusfBuilder::visit(ASTSelectionStmt &node) {
    // TODO: This function is empty now.
    // Add some code here.
    auto expressionLoad = node.expression->accept(*this);
    if(expressionLoad->get_type()->is_float_type())
        expressionLoad = builder->create_fcmp_ne(expressionLoad,ConstantFP::get(0,module.get()));
    else if(expressionLoad->get_type()->is_int32_type())
        expressionLoad = builder->create_icmp_ne(expressionLoad,ConstantInt::get(0,module.get()));
    if(node.else_statement!=nullptr){
        auto trueBB = BasicBlock::create(module.get(), "", context.func);
        auto falseBB = BasicBlock::create(module.get(), "", context.func);
        auto brBB = BasicBlock::create(module.get(), "", context.func);
        builder->create_cond_br(expressionLoad,trueBB,falseBB);
        builder->set_insert_point(trueBB);
        scope.enter();
        node.if_statement->accept(*this);
        if(builder->get_insert_block()->is_terminated()==false)
            builder->create_br(brBB);
        scope.exit();
        builder->set_insert_point(falseBB);
        scope.enter();
        node.else_statement->accept(*this);  
        if(builder->get_insert_block()->is_terminated()==false)
            builder->create_br(brBB); 
        scope.exit();
        builder->set_insert_point(brBB);    
    }
    else{
        auto trueBB = BasicBlock::create(module.get(), "", context.func);
        auto brBB = BasicBlock::create(module.get(), "", context.func);
        builder->create_cond_br(expressionLoad,trueBB,brBB);
        builder->set_insert_point(trueBB);
        scope.enter();
        node.if_statement->accept(*this);
        if(builder->get_insert_block()->is_terminated()==false)
            builder->create_br(brBB);
        scope.exit();
        builder->set_insert_point(brBB); 
    }
    return nullptr;
}

Value* CminusfBuilder::visit(ASTIterationStmt &node) {
    // TODO: This function is empty now.
    // Add some code here.
    auto expressionLoad = node.expression->accept(*this);
    if(expressionLoad->get_type()->is_float_type())
        expressionLoad = builder->create_fcmp_ne(expressionLoad,ConstantFP::get(0,module.get()));
    else if(expressionLoad->get_type()->is_int32_type())
        expressionLoad = builder->create_icmp_ne(expressionLoad,ConstantInt::get(0,module.get()));
    auto trueBB = BasicBlock::create(module.get(), "", context.func);
    auto brBB = BasicBlock::create(module.get(), "", context.func);
    builder->create_cond_br(expressionLoad,trueBB,brBB);
    builder->set_insert_point(trueBB);
    scope.enter();
    node.statement->accept(*this);
    scope.exit();
    if(builder->get_insert_block()->is_terminated()==false){
        expressionLoad = node.expression->accept(*this);
        if(expressionLoad->get_type()->is_float_type())
            expressionLoad = builder->create_fcmp_ne(expressionLoad,ConstantFP::get(0,module.get()));
        else if(expressionLoad->get_type()->is_int32_type())
            expressionLoad = builder->create_icmp_ne(expressionLoad,ConstantInt::get(0,module.get()));
        builder->create_cond_br(expressionLoad,trueBB,brBB);
    }
    builder->set_insert_point(brBB);
    return nullptr;
}

Value* CminusfBuilder::visit(ASTReturnStmt &node) {
    if (node.expression == nullptr) {
        builder->create_void_ret();
        return nullptr;
    } 
    else {
        // TODO: The given code is incomplete.
        // You need to solve other return cases (e.g. return an integer).
        auto expressionLoad = node.expression->accept(*this);
        if(context.func->get_return_type()->is_integer_type()&&expressionLoad->get_type()->is_float_type())
            expressionLoad = builder->create_fptosi(expressionLoad,INT32_T);
        else if(context.func->get_return_type()->is_float_type()&&expressionLoad->get_type()->is_integer_type())
            expressionLoad = builder->create_sitofp(expressionLoad,FLOAT_T);
        else{}
        builder->create_ret(expressionLoad);
        return nullptr;
    }
    
}

Value* CminusfBuilder::visit(ASTVar &node) {
    // TODO: This function is empty now.
    // Add some code here.
    if(node.expression==nullptr){
        auto varAlloca = scope.find(node.id);
        if(context._varstate[context._varstate.size()-1]==context.alloca)
            return varAlloca;
        else if(varAlloca->get_type()->get_pointer_element_type()->is_array_type()){
            return varAlloca;
        }
        else{
            auto varLoad = builder->create_load(varAlloca);
            return varLoad;
        }
    }
    else{
        auto index = node.expression->accept(*this);
        auto varAlloca = scope.find(node.id);
        if(index->get_type()->is_float_type())
            index = builder->create_fptosi(index,INT32_T);
        else if(index->get_type()->is_int1_type())
            index = builder->create_zext(index,INT32_T);
        else{}
        auto normalBB = BasicBlock::create(module.get(),"",context.func);
        auto errorBB = BasicBlock::create(module.get(),"",context.func);
        auto brBB = BasicBlock::create(module.get(),"",context.func);
        auto icmp = builder->create_icmp_ge(index,ConstantInt::get(0,module.get()));
        builder->create_cond_br(icmp,normalBB,errorBB);
        builder->set_insert_point(normalBB);
        Value *vargep;
        Value *varLoad;
        if(varAlloca->get_type()->get_pointer_element_type()->is_array_type())
            vargep = builder->create_gep(varAlloca,{ConstantInt::get(0,module.get()),index});
        else{
            varLoad = builder->create_load(varAlloca);
            vargep = builder->create_gep(varLoad,{index});
        }
        int flag = 0;
        if(context._varstate[context._varstate.size()-1]==context.load){
            varLoad = builder->create_load(vargep);
            flag = 1;
        }
        builder->create_br(brBB);
        builder->set_insert_point(errorBB);
        auto func = scope.find("neg_idx_except");
        auto call = builder->create_call(func,{});
        call->set_name("neg_idx_except");
        builder->create_br(brBB);
        builder->set_insert_point(brBB);
        if(flag == 0)
            return vargep;   
        else 
            return varLoad; 
    }
}

Value* CminusfBuilder::visit(ASTAssignExpression &node) {
    // TODO: This function is empty now.
    // Add some code here.
    context._varstate.push_back(context.alloca);
    auto varAlloca = node.var->accept(*this);
    context._varstate.pop_back();
    auto expressionLoad = node.expression->accept(*this);
    if(varAlloca->get_type()->get_pointer_element_type()->is_float_type()&&expressionLoad->get_type()->is_integer_type())
        expressionLoad = builder->create_sitofp(expressionLoad,FLOAT_T);
    else if(varAlloca->get_type()->get_pointer_element_type()->is_integer_type()&&expressionLoad->get_type()->is_float_type()){
        if(varAlloca->get_type()->get_pointer_element_type()->is_int1_type()) expressionLoad = builder->create_fcmp_ne(expressionLoad,ConstantFP::get(0,module.get()));
        else expressionLoad = builder->create_fptosi(expressionLoad,INT32_T);
    }
    else if(varAlloca->get_type()->get_pointer_element_type()->is_integer_type()&&expressionLoad->get_type()->is_integer_type()){
        if(varAlloca->get_type()->get_pointer_element_type()->is_int1_type()&&expressionLoad->get_type()->is_int32_type()) expressionLoad = builder->create_icmp_ne(expressionLoad,ConstantInt::get(0,module.get()));
        else if(varAlloca->get_type()->get_pointer_element_type()->is_int32_type()&&expressionLoad->get_type()->is_int1_type()) expressionLoad = builder->create_zext(expressionLoad,INT32_T);
    }
    else{}
    builder->create_store(expressionLoad,varAlloca);
    return expressionLoad;
}

Value* CminusfBuilder::visit(ASTSimpleExpression &node) {
    // TODO: This function is empty now.
    // Add some code here.
    auto ladd = node.additive_expression_l->accept(*this);
    if(node.additive_expression_r == nullptr){
        return ladd;
    }
    else{
        auto radd = node.additive_expression_r->accept(*this);

        if(node.op==OP_LE){
            if(ladd->get_type()->is_integer_type()&&radd->get_type()->is_integer_type()){
                if(ladd->get_type()->is_int1_type()) ladd = builder->create_zext(ladd,INT32_T);
                if(radd->get_type()->is_int1_type()) radd = builder->create_zext(radd,INT32_T);
                auto cmp = builder->create_icmp_le(ladd,radd);
                return cmp;
            }
            else if(ladd->get_type()->is_float_type()&&radd->get_type()->is_integer_type()){
                radd = builder->create_sitofp(radd,FLOAT_T);
                auto cmp = builder->create_fcmp_le(ladd,radd);
                return cmp;
            }
            else if(ladd->get_type()->is_integer_type()&&radd->get_type()->is_float_type()){
                ladd = builder->create_sitofp(ladd,FLOAT_T);
                auto cmp = builder->create_fcmp_le(ladd,radd);
                return cmp;
            }
            else{
                auto cmp = builder->create_fcmp_le(ladd,radd);
                return cmp;
            }
        }
        else if(node.op==OP_LT){
            if(ladd->get_type()->is_integer_type()&&radd->get_type()->is_integer_type()){
                if(ladd->get_type()->is_int1_type()) ladd = builder->create_zext(ladd,INT32_T);
                if(radd->get_type()->is_int1_type()) radd = builder->create_zext(radd,INT32_T);
                auto cmp = builder->create_icmp_lt(ladd,radd);
                return cmp;
            }
            else if(ladd->get_type()->is_float_type()&&radd->get_type()->is_integer_type()){
                radd = builder->create_sitofp(radd,FLOAT_T);
                auto cmp = builder->create_fcmp_lt(ladd,radd);
                return cmp;
            }
            else if(ladd->get_type()->is_integer_type()&&radd->get_type()->is_float_type()){
                ladd = builder->create_sitofp(ladd,FLOAT_T);
                auto cmp = builder->create_fcmp_lt(ladd,radd);
                return cmp;
            }
            else{
                auto cmp = builder->create_fcmp_lt(ladd,radd);
                return cmp;
            }
        }
        else if(node.op==OP_GT){
            if(ladd->get_type()->is_integer_type()&&radd->get_type()->is_integer_type()){
                if(ladd->get_type()->is_int1_type()) ladd = builder->create_zext(ladd,INT32_T);
                if(radd->get_type()->is_int1_type()) radd = builder->create_zext(radd,INT32_T);
                auto cmp = builder->create_icmp_gt(ladd,radd);
                return cmp;
            }
            else if(ladd->get_type()->is_float_type()&&radd->get_type()->is_integer_type()){
                radd = builder->create_sitofp(radd,FLOAT_T);
                auto cmp = builder->create_fcmp_gt(ladd,radd);
                return cmp;
            }
            else if(ladd->get_type()->is_integer_type()&&radd->get_type()->is_float_type()){
                ladd = builder->create_sitofp(ladd,FLOAT_T);
                auto cmp = builder->create_fcmp_gt(ladd,radd);
                return cmp;
            }
            else{
                auto cmp = builder->create_fcmp_gt(ladd,radd);
                return cmp;
            }
        }
        else if(node.op==OP_GE){
            if(ladd->get_type()->is_integer_type()&&radd->get_type()->is_integer_type()){
                if(ladd->get_type()->is_int1_type()) ladd = builder->create_zext(ladd,INT32_T);
                if(radd->get_type()->is_int1_type()) radd = builder->create_zext(radd,INT32_T);
                auto cmp = builder->create_icmp_ge(ladd,radd);
                return cmp;
            }
            else if(ladd->get_type()->is_float_type()&&radd->get_type()->is_integer_type()){
                radd = builder->create_sitofp(radd,FLOAT_T);
                auto cmp = builder->create_fcmp_ge(ladd,radd);
                return cmp;
            }
            else if(ladd->get_type()->is_integer_type()&&radd->get_type()->is_float_type()){
                ladd = builder->create_sitofp(ladd,FLOAT_T);
                auto cmp = builder->create_fcmp_ge(ladd,radd);
                return cmp;
            }
            else{
                auto cmp = builder->create_fcmp_ge(ladd,radd);
                return cmp;
            }
        }
        else if(node.op==OP_EQ){
            if(ladd->get_type()->is_integer_type()&&radd->get_type()->is_integer_type()){
                if(ladd->get_type()->is_int1_type()) ladd = builder->create_zext(ladd,INT32_T);
                if(radd->get_type()->is_int1_type()) radd = builder->create_zext(radd,INT32_T);
                auto cmp = builder->create_icmp_eq(ladd,radd);
                return cmp;
            }
            else if(ladd->get_type()->is_float_type()&&radd->get_type()->is_integer_type()){
                radd = builder->create_sitofp(radd,FLOAT_T);
                auto cmp = builder->create_fcmp_eq(ladd,radd);
                return cmp;
            }
            else if(ladd->get_type()->is_integer_type()&&radd->get_type()->is_float_type()){
                ladd = builder->create_sitofp(ladd,FLOAT_T);
                auto cmp = builder->create_fcmp_eq(ladd,radd);
                return cmp;
            }
            else{
                auto cmp = builder->create_fcmp_eq(ladd,radd);
                return cmp;
            }
        }
        else{
            if(ladd->get_type()->is_integer_type()&&radd->get_type()->is_integer_type()){
                if(ladd->get_type()->is_int1_type()) ladd = builder->create_zext(ladd,INT32_T);
                if(radd->get_type()->is_int1_type()) radd = builder->create_zext(radd,INT32_T);
                auto cmp = builder->create_icmp_ne(ladd,radd);
                return cmp;
            }
            else if(ladd->get_type()->is_float_type()&&radd->get_type()->is_integer_type()){
                radd = builder->create_sitofp(radd,FLOAT_T);
                auto cmp = builder->create_fcmp_ne(ladd,radd);
                return cmp;
            }
            else if(ladd->get_type()->is_integer_type()&&radd->get_type()->is_float_type()){
                ladd = builder->create_sitofp(ladd,FLOAT_T);
                auto cmp = builder->create_fcmp_ne(ladd,radd);
                return cmp;
            }
            else{
                auto cmp = builder->create_fcmp_ne(ladd,radd);
                return cmp;
            }
        }
    }
}

Value* CminusfBuilder::visit(ASTAdditiveExpression &node) {
    // TODO: This function is empty now.
    // Add some code here.
    context._varstate.push_back(context.load);
    auto termLoad = node.term->accept(*this);
    context._varstate.pop_back();
    if(node.additive_expression==nullptr){
        return termLoad;
    }
    else{
        auto addLoad = node.additive_expression->accept(*this);
        if(node.op==OP_PLUS){
            if(addLoad->get_type()->is_integer_type()&&termLoad->get_type()->is_integer_type()){
                auto add = builder->create_iadd(addLoad,termLoad);
                return add;
            }
            else if(addLoad->get_type()->is_float_type()&&termLoad->get_type()->is_integer_type()){
                termLoad = builder->create_sitofp(termLoad,FLOAT_T);
                auto add = builder->create_fadd(addLoad,termLoad);
                
                return add;                
            }  
            else if(addLoad->get_type()->is_integer_type()&&termLoad->get_type()->is_float_type()){
                addLoad = builder->create_sitofp(addLoad,FLOAT_T);
                auto add = builder->create_fadd(addLoad,termLoad);
                return add;                
            }     
            else{
                auto add = builder->create_fadd(addLoad,termLoad);
                return add; 
            }        
        }
        else{
            if(addLoad->get_type()->is_integer_type()&&termLoad->get_type()->is_integer_type()){
                auto add = builder->create_isub(addLoad,termLoad);
                return add;
            }
            else if(addLoad->get_type()->is_float_type()&&termLoad->get_type()->is_integer_type()){
                termLoad = builder->create_sitofp(termLoad,FLOAT_T);
                auto add = builder->create_fsub(addLoad,termLoad);
                return add;                
            }  
            else if(addLoad->get_type()->is_integer_type()&&termLoad->get_type()->is_float_type()){
                addLoad = builder->create_sitofp(addLoad,FLOAT_T);
                auto add = builder->create_fsub(addLoad,termLoad);
                return add;                
            }     
            else{
                auto add = builder->create_fsub(addLoad,termLoad);
                return add; 
            }        
        }
    }
}

Value* CminusfBuilder::visit(ASTTerm &node) {
    // TODO: This function is empty now.
    // Add some code here.
    auto factorLoad = node.factor->accept(*this);
    if(node.term==nullptr){
        return factorLoad;
    }
    else{
        auto termLoad = node.term->accept(*this);
        if(node.op==OP_MUL){
            if(termLoad->get_type()->is_integer_type()&&factorLoad->get_type()->is_integer_type()){
                auto mul = builder->create_imul(termLoad,factorLoad);
                return mul;
            }
            else if(termLoad->get_type()->is_float_type()&&factorLoad->get_type()->is_integer_type()){
                factorLoad = builder->create_sitofp(factorLoad,FLOAT_T);
                auto mul = builder->create_fmul(termLoad,factorLoad);
                return mul;                
            }
            else if(termLoad->get_type()->is_integer_type()&&factorLoad->get_type()->is_float_type()){
                termLoad = builder->create_sitofp(termLoad,FLOAT_T);
                auto mul = builder->create_fmul(termLoad,factorLoad);
                return mul;                
            }
            else{
                auto mul = builder->create_fmul(termLoad,factorLoad);
                return mul; 
            }
        }
        else{
            if(termLoad->get_type()->is_integer_type()&&factorLoad->get_type()->is_integer_type()){
                auto mul = builder->create_isdiv(termLoad,factorLoad);
                return mul;
            }
            else if(termLoad->get_type()->is_float_type()&&factorLoad->get_type()->is_integer_type()){
                factorLoad = builder->create_sitofp(factorLoad,FLOAT_T);
                auto mul = builder->create_fdiv(termLoad,factorLoad);
                return mul;                
            }
            else if(termLoad->get_type()->is_integer_type()&&factorLoad->get_type()->is_float_type()){
                termLoad = builder->create_sitofp(termLoad,FLOAT_T);
                auto mul = builder->create_fdiv(termLoad,factorLoad);
                return mul;                
            }
            else{
                auto mul = builder->create_fdiv(termLoad,factorLoad);
                return mul; 
            }
        }
    }
}

Value* CminusfBuilder::visit(ASTCall &node) {
    // TODO: This function is empty now.
    // Add some code here.
    std::vector<Value*> args;
    auto func = scope.find(node.id);
    auto callfun = static_cast<FunctionType*>(func->get_type());
    
    for(long unsigned int i = 0; i < node.args.size(); ++i){
        auto arg = node.args[i]->accept(*this);
        if(callfun->get_param_type(i)->is_integer_type()&&arg->get_type()->is_float_type()){
            arg = builder->create_fptosi(arg,INT32_T);
        }
        else if(callfun->get_param_type(i)->is_float_type()&&arg->get_type()->is_integer_type()){
            arg = builder->create_sitofp(arg,FLOAT_T);
        }
        else if(callfun->get_param_type(i)->is_integer_type()&&arg->get_type()->is_integer_type()){
            if(arg->get_type()->is_int1_type()) arg = builder->create_zext(arg,INT32_T);
        }
        else if(callfun->get_param_type(i)->is_pointer_type()&&arg->get_type()->get_pointer_element_type()->is_array_type()){
            //it is so hard "arg->get_type()->get_pointer_element_type()->is_array_type()"
            arg = builder->create_gep(arg,{ConstantInt::get(0,module.get()),ConstantInt::get(0,module.get())});
        }
        else{}
        args.push_back(arg);
    }
    auto call = builder->create_call(func,args);
    return call;
}
