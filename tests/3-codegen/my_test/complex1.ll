; ModuleID = 'cminus'
source_filename = "/home/hzw/桌面/2023ustc-jianmu-compiler/tests/3-codegen/my_test/complex1.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define i32 @mod(i32 %arg0, i32 %arg1) {
label_entry:
  %op2 = alloca i32
  store i32 %arg0, i32* %op2
  %op3 = alloca i32
  store i32 %arg1, i32* %op3
  %op4 = load i32, i32* %op3
  %op5 = load i32, i32* %op3
  %op6 = load i32, i32* %op2
  %op7 = sdiv i32 %op6, %op5
  %op8 = mul i32 %op7, %op4
  %op9 = load i32, i32* %op2
  %op10 = sub i32 %op9, %op8
  ret i32 %op10
}
define void @printfour(i32 %arg0) {
label_entry:
  %op1 = alloca i32
  store i32 %arg0, i32* %op1
  %op2 = alloca i32
  %op3 = alloca i32
  %op4 = alloca i32
  %op5 = alloca i32
  %op6 = load i32, i32* %op1
  %op7 = call i32 @mod(i32 %op6, i32 10000)
  store i32 %op7, i32* %op1
  %op8 = load i32, i32* %op1
  %op9 = call i32 @mod(i32 %op8, i32 10)
  store i32 %op9, i32* %op5
  %op10 = load i32, i32* %op1
  %op11 = sdiv i32 %op10, 10
  store i32 %op11, i32* %op1
  %op12 = load i32, i32* %op1
  %op13 = call i32 @mod(i32 %op12, i32 10)
  store i32 %op13, i32* %op4
  %op14 = load i32, i32* %op1
  %op15 = sdiv i32 %op14, 10
  store i32 %op15, i32* %op1
  %op16 = load i32, i32* %op1
  %op17 = call i32 @mod(i32 %op16, i32 10)
  store i32 %op17, i32* %op3
  %op18 = load i32, i32* %op1
  %op19 = sdiv i32 %op18, 10
  store i32 %op19, i32* %op1
  %op20 = load i32, i32* %op1
  store i32 %op20, i32* %op2
  %op21 = load i32, i32* %op2
  call void @output(i32 %op21)
  %op22 = load i32, i32* %op3
  call void @output(i32 %op22)
  %op23 = load i32, i32* %op4
  call void @output(i32 %op23)
  %op24 = load i32, i32* %op5
  call void @output(i32 %op24)
  ret void
}
define void @main() {
label_entry:
  %op0 = alloca [2801 x i32]
  %op1 = alloca i32
  %op2 = alloca i32
  %op3 = alloca i32
  %op4 = alloca i32
  %op5 = alloca i32
  store i32 0, i32* %op5
  store i32 1234, i32* %op4
  %op6 = alloca i32
  store i32 0, i32* %op6
  %op7 = load i32, i32* %op6
  %op8 = icmp slt i32 %op7, 2800
  br i1 %op8, label %label9, label %label12
label9:                                                ; preds = %label_entry, %label18
  %op10 = load i32, i32* %op6
  %op11 = icmp sge i32 %op10, 0
  br i1 %op11, label %label15, label %label17
label12:                                                ; preds = %label_entry, %label18
  store i32 2800, i32* %op2
  %op13 = load i32, i32* %op2
  %op14 = icmp ne i32 %op13, 0
  br i1 %op14, label %label23, label %label28
label15:                                                ; preds = %label9
  %op16 = getelementptr [2801 x i32], [2801 x i32]* %op0, i32 0, i32 %op10
  br label %label18
label17:                                                ; preds = %label9
  call void @neg_idx_except()
  br label %label18
label18:                                                ; preds = %label15, %label17
  store i32 2000, i32* %op16
  %op19 = load i32, i32* %op6
  %op20 = add i32 %op19, 1
  store i32 %op20, i32* %op6
  %op21 = load i32, i32* %op6
  %op22 = icmp slt i32 %op21, 2800
  br i1 %op22, label %label9, label %label12
label23:                                                ; preds = %label12, %label32
  %op24 = alloca i32
  store i32 0, i32* %op24
  %op25 = load i32, i32* %op2
  store i32 %op25, i32* %op1
  %op26 = load i32, i32* %op1
  %op27 = icmp ne i32 %op26, 0
  br i1 %op27, label %label29, label %label32
label28:                                                ; preds = %label12, %label32
  ret void
label29:                                                ; preds = %label23, %label74
  %op30 = load i32, i32* %op1
  %op31 = icmp sge i32 %op30, 0
  br i1 %op31, label %label43, label %label46
label32:                                                ; preds = %label23, %label74
  %op33 = load i32, i32* %op24
  %op34 = sdiv i32 %op33, 10000
  %op35 = load i32, i32* %op5
  %op36 = add i32 %op35, %op34
  call void @printfour(i32 %op36)
  %op37 = load i32, i32* %op24
  %op38 = call i32 @mod(i32 %op37, i32 10000)
  store i32 %op38, i32* %op5
  %op39 = load i32, i32* %op2
  %op40 = sub i32 %op39, 14
  store i32 %op40, i32* %op2
  %op41 = load i32, i32* %op2
  %op42 = icmp ne i32 %op41, 0
  br i1 %op42, label %label23, label %label28
label43:                                                ; preds = %label29
  %op44 = getelementptr [2801 x i32], [2801 x i32]* %op0, i32 0, i32 %op30
  %op45 = load i32, i32* %op44
  br label %label47
label46:                                                ; preds = %label29
  call void @neg_idx_except()
  br label %label47
label47:                                                ; preds = %label43, %label46
  %op48 = mul i32 %op45, 10000
  %op49 = load i32, i32* %op24
  %op50 = add i32 %op49, %op48
  store i32 %op50, i32* %op24
  %op51 = load i32, i32* %op1
  %op52 = mul i32 2, %op51
  %op53 = sub i32 %op52, 1
  store i32 %op53, i32* %op3
  %op54 = load i32, i32* %op1
  %op55 = icmp sge i32 %op54, 0
  br i1 %op55, label %label56, label %label58
label56:                                                ; preds = %label47
  %op57 = getelementptr [2801 x i32], [2801 x i32]* %op0, i32 0, i32 %op54
  br label %label59
label58:                                                ; preds = %label47
  call void @neg_idx_except()
  br label %label59
label59:                                                ; preds = %label56, %label58
  %op60 = load i32, i32* %op24
  %op61 = load i32, i32* %op3
  %op62 = call i32 @mod(i32 %op60, i32 %op61)
  store i32 %op62, i32* %op57
  %op63 = load i32, i32* %op3
  %op64 = load i32, i32* %op24
  %op65 = sdiv i32 %op64, %op63
  store i32 %op65, i32* %op24
  %op66 = load i32, i32* %op1
  %op67 = sub i32 %op66, 1
  store i32 %op67, i32* %op1
  %op68 = load i32, i32* %op1
  %op69 = icmp ne i32 %op68, 0
  br i1 %op69, label %label70, label %label74
label70:                                                ; preds = %label59
  %op71 = load i32, i32* %op1
  %op72 = load i32, i32* %op24
  %op73 = mul i32 %op72, %op71
  store i32 %op73, i32* %op24
  br label %label74
label74:                                                ; preds = %label59, %label70
  %op75 = load i32, i32* %op1
  %op76 = icmp ne i32 %op75, 0
  br i1 %op76, label %label29, label %label32
}
