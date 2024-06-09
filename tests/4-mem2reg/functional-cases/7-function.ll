; ModuleID = 'cminus'
source_filename = "/home/hzw/桌面/2023ustc-jianmu-compiler/tests/4-mem2reg/functional-cases/7-function.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define i32 @min(i32 %arg0, i32 %arg1) {
label_entry:
  %op2 = alloca i32
  store i32 %arg0, i32* %op2
  %op3 = alloca i32
  store i32 %arg1, i32* %op3
  %op4 = load i32, i32* %op2
  %op5 = load i32, i32* %op3
  %op6 = icmp sle i32 %op4, %op5
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
define i32 @main() {
label_entry:
  %op0 = alloca i32
  %op1 = alloca i32
  %op2 = alloca i32
  store i32 11, i32* %op0
  store i32 22, i32* %op1
  store i32 33, i32* %op2
  %op3 = call i32 @min(i32 11, i32 22)
  call void @output(i32 %op3)
  %op4 = call i32 @min(i32 22, i32 33)
  call void @output(i32 %op4)
  %op5 = call i32 @min(i32 33, i32 11)
  call void @output(i32 %op5)
  ret i32 0
}
