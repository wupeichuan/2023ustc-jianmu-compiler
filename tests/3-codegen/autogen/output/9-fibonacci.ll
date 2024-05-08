; ModuleID = 'cminus'
source_filename = "/home/hzw/桌面/2023ustc-jianmu-compiler/tests/3-codegen/autogen/testcases/9-fibonacci.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define i32 @fibonacci(i32 %arg0) {
label_entry:
  %op1 = alloca i32
  store i32 %arg0, i32* %op1
  %op2 = load i32, i32* %op1
  %op3 = icmp eq i32 %op2, 0
  br i1 %op3, label %label4, label %label5
label4:                                                ; preds = %label_entry
  ret i32 0
label5:                                                ; preds = %label_entry
  %op6 = load i32, i32* %op1
  %op7 = icmp eq i32 %op6, 1
  br i1 %op7, label %label9, label %label10
label8:                                                ; preds = %label18
  ret i32 0
label9:                                                ; preds = %label5
  ret i32 1
label10:                                                ; preds = %label5
  %op11 = load i32, i32* %op1
  %op12 = sub i32 %op11, 2
  %op13 = call i32 @fibonacci(i32 %op12)
  %op14 = load i32, i32* %op1
  %op15 = sub i32 %op14, 1
  %op16 = call i32 @fibonacci(i32 %op15)
  %op17 = add i32 %op16, %op13
  ret i32 %op17
label18:
  br label %label8
}
define i32 @main() {
label_entry:
  %op0 = alloca i32
  %op1 = alloca i32
  store i32 10, i32* %op0
  store i32 0, i32* %op1
  %op2 = load i32, i32* %op1
  %op3 = load i32, i32* %op0
  %op4 = icmp slt i32 %op2, %op3
  br i1 %op4, label %label5, label %label13
label5:                                                ; preds = %label_entry, %label5
  %op6 = load i32, i32* %op1
  %op7 = call i32 @fibonacci(i32 %op6)
  call void @output(i32 %op7)
  %op8 = load i32, i32* %op1
  %op9 = add i32 %op8, 1
  store i32 %op9, i32* %op1
  %op10 = load i32, i32* %op1
  %op11 = load i32, i32* %op0
  %op12 = icmp slt i32 %op10, %op11
  br i1 %op12, label %label5, label %label13
label13:                                                ; preds = %label_entry, %label5
  ret i32 0
}
