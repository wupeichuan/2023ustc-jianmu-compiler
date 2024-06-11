; ModuleID = 'cminus'
source_filename = "/home/hzw/桌面/2023ustc-jianmu-compiler/tests/4-mem2reg/functional-cases/13-complex.cminus"

@n = global i32 zeroinitializer
@m = global i32 zeroinitializer
@w = global [5 x i32] zeroinitializer
@v = global [5 x i32] zeroinitializer
@dp = global [66 x i32] zeroinitializer
declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define i32 @max(i32 %arg0, i32 %arg1) {
label_entry:
  %op2 = alloca i32
  store i32 %arg0, i32* %op2
  %op3 = alloca i32
  store i32 %arg1, i32* %op3
  %op4 = load i32, i32* %op2
  %op5 = load i32, i32* %op3
  %op6 = icmp sgt i32 %op4, %op5
  br i1 %op6, label %label7, label %label9
label7:                                                ; preds = %label_entry
  %op8 = load i32, i32* %op2
  ret i32 %op8
label9:                                                ; preds = %label_entry
  %op10 = load i32, i32* %op3
  ret i32 %op10
label11:
  ret i32 0
}
define i32 @knapsack(i32 %arg0, i32 %arg1) {
label_entry:
  %op2 = alloca i32
  store i32 %arg0, i32* %op2
  %op3 = alloca i32
  store i32 %arg1, i32* %op3
  %op4 = load i32, i32* %op3
  %op5 = icmp sle i32 %op4, 0
  br i1 %op5, label %label6, label %label7
label6:                                                ; preds = %label_entry
  ret i32 0
label7:                                                ; preds = %label_entry
  %op8 = load i32, i32* %op2
  %op9 = icmp eq i32 %op8, 0
  br i1 %op9, label %label10, label %label11
label10:                                                ; preds = %label7
  ret i32 0
label11:                                                ; preds = %label7
  %op12 = load i32, i32* %op3
  %op13 = load i32, i32* %op2
  %op14 = mul i32 %op13, 11
  %op15 = add i32 %op14, %op12
  %op16 = icmp sge i32 %op15, 0
  br i1 %op16, label %label17, label %label20
label17:                                                ; preds = %label11
  %op18 = getelementptr [66 x i32], [66 x i32]* @dp, i32 0, i32 %op15
  %op19 = load i32, i32* %op18
  br label %label21
label20:                                                ; preds = %label11
  call void @neg_idx_except()
  br label %label21
label21:                                                ; preds = %label17, %label20
  %op22 = icmp sge i32 %op19, 0
  br i1 %op22, label %label23, label %label29
label23:                                                ; preds = %label21
  %op24 = load i32, i32* %op3
  %op25 = load i32, i32* %op2
  %op26 = mul i32 %op25, 11
  %op27 = add i32 %op26, %op24
  %op28 = icmp sge i32 %op27, 0
  br i1 %op28, label %label34, label %label37
label29:                                                ; preds = %label21
  %op30 = load i32, i32* %op3
  %op31 = load i32, i32* %op2
  %op32 = sub i32 %op31, 1
  %op33 = icmp sge i32 %op32, 0
  br i1 %op33, label %label39, label %label42
label34:                                                ; preds = %label23
  %op35 = getelementptr [66 x i32], [66 x i32]* @dp, i32 0, i32 %op27
  %op36 = load i32, i32* %op35
  br label %label38
label37:                                                ; preds = %label23
  call void @neg_idx_except()
  br label %label38
label38:                                                ; preds = %label34, %label37
  ret i32 %op36
label39:                                                ; preds = %label29
  %op40 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 %op32
  %op41 = load i32, i32* %op40
  br label %label43
label42:                                                ; preds = %label29
  call void @neg_idx_except()
  br label %label43
label43:                                                ; preds = %label39, %label42
  %op44 = icmp slt i32 %op30, %op41
  br i1 %op44, label %label45, label %label50
label45:                                                ; preds = %label43
  %op46 = load i32, i32* %op2
  %op47 = sub i32 %op46, 1
  %op48 = load i32, i32* %op3
  %op49 = call i32 @knapsack(i32 %op47, i32 %op48)
  br label %label58
label50:                                                ; preds = %label43
  %op51 = load i32, i32* %op2
  %op52 = sub i32 %op51, 1
  %op53 = load i32, i32* %op3
  %op54 = call i32 @knapsack(i32 %op52, i32 %op53)
  %op55 = load i32, i32* %op2
  %op56 = sub i32 %op55, 1
  %op57 = icmp sge i32 %op56, 0
  br i1 %op57, label %label65, label %label68
label58:                                                ; preds = %label45, %label79
  %op59 = phi i32 [ %op49, %label45 ], [ %op84, %label79 ]
  %op60 = load i32, i32* %op3
  %op61 = load i32, i32* %op2
  %op62 = mul i32 %op61, 11
  %op63 = add i32 %op62, %op60
  %op64 = icmp sge i32 %op63, 0
  br i1 %op64, label %label85, label %label87
label65:                                                ; preds = %label50
  %op66 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 %op56
  %op67 = load i32, i32* %op66
  br label %label69
label68:                                                ; preds = %label50
  call void @neg_idx_except()
  br label %label69
label69:                                                ; preds = %label65, %label68
  %op70 = load i32, i32* %op2
  %op71 = sub i32 %op70, 1
  %op72 = load i32, i32* %op2
  %op73 = sub i32 %op72, 1
  %op74 = icmp sge i32 %op73, 0
  br i1 %op74, label %label75, label %label78
label75:                                                ; preds = %label69
  %op76 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 %op73
  %op77 = load i32, i32* %op76
  br label %label79
label78:                                                ; preds = %label69
  call void @neg_idx_except()
  br label %label79
label79:                                                ; preds = %label75, %label78
  %op80 = load i32, i32* %op3
  %op81 = sub i32 %op80, %op77
  %op82 = call i32 @knapsack(i32 %op71, i32 %op81)
  %op83 = add i32 %op82, %op67
  %op84 = call i32 @max(i32 %op54, i32 %op83)
  br label %label58
label85:                                                ; preds = %label58
  %op86 = getelementptr [66 x i32], [66 x i32]* @dp, i32 0, i32 %op63
  br label %label88
label87:                                                ; preds = %label58
  call void @neg_idx_except()
  br label %label88
label88:                                                ; preds = %label85, %label87
  store i32 %op59, i32* %op86
  ret i32 %op59
}
define i32 @main() {
label_entry:
  store i32 5, i32* @n
  store i32 10, i32* @m
  %op0 = icmp sge i32 0, 0
  br i1 %op0, label %label1, label %label3
label1:                                                ; preds = %label_entry
  %op2 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 0
  br label %label4
label3:                                                ; preds = %label_entry
  call void @neg_idx_except()
  br label %label4
label4:                                                ; preds = %label1, %label3
  store i32 2, i32* %op2
  %op5 = icmp sge i32 1, 0
  br i1 %op5, label %label6, label %label8
label6:                                                ; preds = %label4
  %op7 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 1
  br label %label9
label8:                                                ; preds = %label4
  call void @neg_idx_except()
  br label %label9
label9:                                                ; preds = %label6, %label8
  store i32 2, i32* %op7
  %op10 = icmp sge i32 2, 0
  br i1 %op10, label %label11, label %label13
label11:                                                ; preds = %label9
  %op12 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 2
  br label %label14
label13:                                                ; preds = %label9
  call void @neg_idx_except()
  br label %label14
label14:                                                ; preds = %label11, %label13
  store i32 6, i32* %op12
  %op15 = icmp sge i32 3, 0
  br i1 %op15, label %label16, label %label18
label16:                                                ; preds = %label14
  %op17 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 3
  br label %label19
label18:                                                ; preds = %label14
  call void @neg_idx_except()
  br label %label19
label19:                                                ; preds = %label16, %label18
  store i32 5, i32* %op17
  %op20 = icmp sge i32 4, 0
  br i1 %op20, label %label21, label %label23
label21:                                                ; preds = %label19
  %op22 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 4
  br label %label24
label23:                                                ; preds = %label19
  call void @neg_idx_except()
  br label %label24
label24:                                                ; preds = %label21, %label23
  store i32 4, i32* %op22
  %op25 = icmp sge i32 0, 0
  br i1 %op25, label %label26, label %label28
label26:                                                ; preds = %label24
  %op27 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 0
  br label %label29
label28:                                                ; preds = %label24
  call void @neg_idx_except()
  br label %label29
label29:                                                ; preds = %label26, %label28
  store i32 6, i32* %op27
  %op30 = icmp sge i32 1, 0
  br i1 %op30, label %label31, label %label33
label31:                                                ; preds = %label29
  %op32 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 1
  br label %label34
label33:                                                ; preds = %label29
  call void @neg_idx_except()
  br label %label34
label34:                                                ; preds = %label31, %label33
  store i32 3, i32* %op32
  %op35 = icmp sge i32 2, 0
  br i1 %op35, label %label36, label %label38
label36:                                                ; preds = %label34
  %op37 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 2
  br label %label39
label38:                                                ; preds = %label34
  call void @neg_idx_except()
  br label %label39
label39:                                                ; preds = %label36, %label38
  store i32 5, i32* %op37
  %op40 = icmp sge i32 3, 0
  br i1 %op40, label %label41, label %label43
label41:                                                ; preds = %label39
  %op42 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 3
  br label %label44
label43:                                                ; preds = %label39
  call void @neg_idx_except()
  br label %label44
label44:                                                ; preds = %label41, %label43
  store i32 4, i32* %op42
  %op45 = icmp sge i32 4, 0
  br i1 %op45, label %label46, label %label48
label46:                                                ; preds = %label44
  %op47 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 4
  br label %label49
label48:                                                ; preds = %label44
  call void @neg_idx_except()
  br label %label49
label49:                                                ; preds = %label46, %label48
  store i32 6, i32* %op47
  %op50 = icmp slt i32 0, 66
  br i1 %op50, label %label51, label %label54
label51:                                                ; preds = %label49, %label61
  %op52 = phi i32 [ 0, %label49 ], [ %op63, %label61 ]
  %op53 = icmp sge i32 %op52, 0
  br i1 %op53, label %label58, label %label60
label54:                                                ; preds = %label49, %label61
  %op55 = load i32, i32* @n
  %op56 = load i32, i32* @m
  %op57 = call i32 @knapsack(i32 %op55, i32 %op56)
  call void @output(i32 %op57)
  ret i32 0
label58:                                                ; preds = %label51
  %op59 = getelementptr [66 x i32], [66 x i32]* @dp, i32 0, i32 %op52
  br label %label61
label60:                                                ; preds = %label51
  call void @neg_idx_except()
  br label %label61
label61:                                                ; preds = %label58, %label60
  %op62 = sub i32 0, 1
  store i32 %op62, i32* %op59
  %op63 = add i32 %op52, 1
  %op64 = icmp slt i32 %op63, 66
  br i1 %op64, label %label51, label %label54
}
