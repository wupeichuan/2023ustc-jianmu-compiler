; ModuleID = 'cminus'
source_filename = "/home/hzw/桌面/2023ustc-jianmu-compiler/tests/3-codegen/autogen/testcases/12-global.cminus"

@seed = global i32 zeroinitializer
declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define i32 @randomLCG() {
label_entry:
  %op0 = load i32, i32* @seed
  %op1 = mul i32 %op0, 1103515245
  %op2 = add i32 %op1, 12345
  store i32 %op2, i32* @seed
  %op3 = load i32, i32* @seed
  ret i32 %op3
}
define i32 @randBin() {
label_entry:
  %op0 = call i32 @randomLCG()
  %op1 = icmp sgt i32 %op0, 0
  br i1 %op1, label %label2, label %label3
label2:                                                ; preds = %label_entry
  ret i32 1
label3:                                                ; preds = %label_entry
  ret i32 0
label4:
  ret i32 0
}
define i32 @returnToZeroSteps() {
label_entry:
  %op0 = alloca i32
  %op1 = alloca i32
  store i32 0, i32* %op0
  store i32 0, i32* %op1
  %op2 = load i32, i32* %op1
  %op3 = icmp slt i32 %op2, 20
  br i1 %op3, label %label4, label %label7
label4:                                                ; preds = %label_entry, %label21
  %op5 = call i32 @randBin()
  %op6 = icmp ne i32 %op5, 0
  br i1 %op6, label %label8, label %label11
label7:                                                ; preds = %label_entry, %label21
  ret i32 20
label8:                                                ; preds = %label4
  %op9 = load i32, i32* %op0
  %op10 = add i32 %op9, 1
  store i32 %op10, i32* %op0
  br label %label14
label11:                                                ; preds = %label4
  %op12 = load i32, i32* %op0
  %op13 = sub i32 %op12, 1
  store i32 %op13, i32* %op0
  br label %label14
label14:                                                ; preds = %label8, %label11
  %op15 = load i32, i32* %op1
  %op16 = add i32 %op15, 1
  store i32 %op16, i32* %op1
  %op17 = load i32, i32* %op0
  %op18 = icmp eq i32 %op17, 0
  br i1 %op18, label %label19, label %label21
label19:                                                ; preds = %label14
  %op20 = load i32, i32* %op1
  ret i32 %op20
label21:                                                ; preds = %label14
  %op22 = load i32, i32* %op1
  %op23 = icmp slt i32 %op22, 20
  br i1 %op23, label %label4, label %label7
}
define i32 @main() {
label_entry:
  %op0 = alloca i32
  store i32 0, i32* %op0
  store i32 3407, i32* @seed
  %op1 = load i32, i32* %op0
  %op2 = icmp slt i32 %op1, 20
  br i1 %op2, label %label3, label %label9
label3:                                                ; preds = %label_entry, %label3
  %op4 = call i32 @returnToZeroSteps()
  call void @output(i32 %op4)
  %op5 = load i32, i32* %op0
  %op6 = add i32 %op5, 1
  store i32 %op6, i32* %op0
  %op7 = load i32, i32* %op0
  %op8 = icmp slt i32 %op7, 20
  br i1 %op8, label %label3, label %label9
label9:                                                ; preds = %label_entry, %label3
  ret i32 0
}
