; ModuleID = 'cminus'
source_filename = "/home/hzw/桌面/2023ustc-jianmu-compiler/tests/3-codegen/autogen/testcases/13-complex.cminus"

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
  %op4 = alloca i32
  %op5 = load i32, i32* %op3
  %op6 = icmp sle i32 %op5, 0
  br i1 %op6, label %label7, label %label8
label7:                                                ; preds = %label_entry
  ret i32 0
label8:                                                ; preds = %label_entry
  %op9 = load i32, i32* %op2
  %op10 = icmp eq i32 %op9, 0
  br i1 %op10, label %label11, label %label12
label11:                                                ; preds = %label8
  ret i32 0
label12:                                                ; preds = %label8
  %op13 = load i32, i32* %op3
  %op14 = load i32, i32* %op2
  %op15 = mul i32 %op14, 11
  %op16 = add i32 %op15, %op13
  %op17 = icmp sge i32 %op16, 0
  br i1 %op17, label %label18, label %label21
label18:                                                ; preds = %label12
  %op19 = getelementptr [66 x i32], [66 x i32]* @dp, i32 0, i32 %op16
  %op20 = load i32, i32* %op19
  br label %label22
label21:                                                ; preds = %label12
  call void @neg_idx_except()
  br label %label22
label22:                                                ; preds = %label18, %label21
  %op23 = icmp sge i32 %op20, 0
  br i1 %op23, label %label24, label %label30
label24:                                                ; preds = %label22
  %op25 = load i32, i32* %op3
  %op26 = load i32, i32* %op2
  %op27 = mul i32 %op26, 11
  %op28 = add i32 %op27, %op25
  %op29 = icmp sge i32 %op28, 0
  br i1 %op29, label %label35, label %label38
label30:                                                ; preds = %label22
  %op31 = load i32, i32* %op3
  %op32 = load i32, i32* %op2
  %op33 = sub i32 %op32, 1
  %op34 = icmp sge i32 %op33, 0
  br i1 %op34, label %label40, label %label43
label35:                                                ; preds = %label24
  %op36 = getelementptr [66 x i32], [66 x i32]* @dp, i32 0, i32 %op28
  %op37 = load i32, i32* %op36
  br label %label39
label38:                                                ; preds = %label24
  call void @neg_idx_except()
  br label %label39
label39:                                                ; preds = %label35, %label38
  ret i32 %op37
label40:                                                ; preds = %label30
  %op41 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 %op33
  %op42 = load i32, i32* %op41
  br label %label44
label43:                                                ; preds = %label30
  call void @neg_idx_except()
  br label %label44
label44:                                                ; preds = %label40, %label43
  %op45 = icmp slt i32 %op31, %op42
  br i1 %op45, label %label46, label %label51
label46:                                                ; preds = %label44
  %op47 = load i32, i32* %op2
  %op48 = sub i32 %op47, 1
  %op49 = load i32, i32* %op3
  %op50 = call i32 @knapsack(i32 %op48, i32 %op49)
  store i32 %op50, i32* %op4
  br label %label59
label51:                                                ; preds = %label44
  %op52 = load i32, i32* %op2
  %op53 = sub i32 %op52, 1
  %op54 = load i32, i32* %op3
  %op55 = call i32 @knapsack(i32 %op53, i32 %op54)
  %op56 = load i32, i32* %op2
  %op57 = sub i32 %op56, 1
  %op58 = icmp sge i32 %op57, 0
  br i1 %op58, label %label65, label %label68
label59:                                                ; preds = %label46, %label79
  %op60 = load i32, i32* %op3
  %op61 = load i32, i32* %op2
  %op62 = mul i32 %op61, 11
  %op63 = add i32 %op62, %op60
  %op64 = icmp sge i32 %op63, 0
  br i1 %op64, label %label85, label %label87
label65:                                                ; preds = %label51
  %op66 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 %op57
  %op67 = load i32, i32* %op66
  br label %label69
label68:                                                ; preds = %label51
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
  %op84 = call i32 @max(i32 %op55, i32 %op83)
  store i32 %op84, i32* %op4
  br label %label59
label85:                                                ; preds = %label59
  %op86 = getelementptr [66 x i32], [66 x i32]* @dp, i32 0, i32 %op63
  br label %label88
label87:                                                ; preds = %label59
  call void @neg_idx_except()
  br label %label88
label88:                                                ; preds = %label85, %label87
  %op89 = load i32, i32* %op4
  store i32 %op89, i32* %op86
  %op90 = load i32, i32* %op4
  ret i32 %op90
}
define i32 @main() {
label_entry:
  %op0 = alloca i32
  store i32 0, i32* %op0
  store i32 5, i32* @n
  store i32 10, i32* @m
  %op1 = icmp sge i32 0, 0
  br i1 %op1, label %label2, label %label4
label2:                                                ; preds = %label_entry
  %op3 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 0
  br label %label5
label4:                                                ; preds = %label_entry
  call void @neg_idx_except()
  br label %label5
label5:                                                ; preds = %label2, %label4
  store i32 2, i32* %op3
  %op6 = icmp sge i32 1, 0
  br i1 %op6, label %label7, label %label9
label7:                                                ; preds = %label5
  %op8 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 1
  br label %label10
label9:                                                ; preds = %label5
  call void @neg_idx_except()
  br label %label10
label10:                                                ; preds = %label7, %label9
  store i32 2, i32* %op8
  %op11 = icmp sge i32 2, 0
  br i1 %op11, label %label12, label %label14
label12:                                                ; preds = %label10
  %op13 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 2
  br label %label15
label14:                                                ; preds = %label10
  call void @neg_idx_except()
  br label %label15
label15:                                                ; preds = %label12, %label14
  store i32 6, i32* %op13
  %op16 = icmp sge i32 3, 0
  br i1 %op16, label %label17, label %label19
label17:                                                ; preds = %label15
  %op18 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 3
  br label %label20
label19:                                                ; preds = %label15
  call void @neg_idx_except()
  br label %label20
label20:                                                ; preds = %label17, %label19
  store i32 5, i32* %op18
  %op21 = icmp sge i32 4, 0
  br i1 %op21, label %label22, label %label24
label22:                                                ; preds = %label20
  %op23 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 4
  br label %label25
label24:                                                ; preds = %label20
  call void @neg_idx_except()
  br label %label25
label25:                                                ; preds = %label22, %label24
  store i32 4, i32* %op23
  %op26 = icmp sge i32 0, 0
  br i1 %op26, label %label27, label %label29
label27:                                                ; preds = %label25
  %op28 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 0
  br label %label30
label29:                                                ; preds = %label25
  call void @neg_idx_except()
  br label %label30
label30:                                                ; preds = %label27, %label29
  store i32 6, i32* %op28
  %op31 = icmp sge i32 1, 0
  br i1 %op31, label %label32, label %label34
label32:                                                ; preds = %label30
  %op33 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 1
  br label %label35
label34:                                                ; preds = %label30
  call void @neg_idx_except()
  br label %label35
label35:                                                ; preds = %label32, %label34
  store i32 3, i32* %op33
  %op36 = icmp sge i32 2, 0
  br i1 %op36, label %label37, label %label39
label37:                                                ; preds = %label35
  %op38 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 2
  br label %label40
label39:                                                ; preds = %label35
  call void @neg_idx_except()
  br label %label40
label40:                                                ; preds = %label37, %label39
  store i32 5, i32* %op38
  %op41 = icmp sge i32 3, 0
  br i1 %op41, label %label42, label %label44
label42:                                                ; preds = %label40
  %op43 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 3
  br label %label45
label44:                                                ; preds = %label40
  call void @neg_idx_except()
  br label %label45
label45:                                                ; preds = %label42, %label44
  store i32 4, i32* %op43
  %op46 = icmp sge i32 4, 0
  br i1 %op46, label %label47, label %label49
label47:                                                ; preds = %label45
  %op48 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 4
  br label %label50
label49:                                                ; preds = %label45
  call void @neg_idx_except()
  br label %label50
label50:                                                ; preds = %label47, %label49
  store i32 6, i32* %op48
  %op51 = load i32, i32* %op0
  %op52 = icmp slt i32 %op51, 66
  br i1 %op52, label %label53, label %label56
label53:                                                ; preds = %label50, %label63
  %op54 = load i32, i32* %op0
  %op55 = icmp sge i32 %op54, 0
  br i1 %op55, label %label60, label %label62
label56:                                                ; preds = %label50, %label63
  %op57 = load i32, i32* @n
  %op58 = load i32, i32* @m
  %op59 = call i32 @knapsack(i32 %op57, i32 %op58)
  call void @output(i32 %op59)
  ret i32 0
label60:                                                ; preds = %label53
  %op61 = getelementptr [66 x i32], [66 x i32]* @dp, i32 0, i32 %op54
  br label %label63
label62:                                                ; preds = %label53
  call void @neg_idx_except()
  br label %label63
label63:                                                ; preds = %label60, %label62
  %op64 = sub i32 0, 1
  store i32 %op64, i32* %op61
  %op65 = load i32, i32* %op0
  %op66 = add i32 %op65, 1
  store i32 %op66, i32* %op0
  %op67 = load i32, i32* %op0
  %op68 = icmp slt i32 %op67, 66
  br i1 %op68, label %label53, label %label56
}
