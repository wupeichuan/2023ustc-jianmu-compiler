; ModuleID = 'cminus'
source_filename = "/home/hzw/桌面/2023ustc-jianmu-compiler/tests/3-codegen/autogen/testcases/5-while.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define i32 @main() {
label_entry:
  %op0 = alloca i32
  %op1 = alloca i32
  store i32 10, i32* %op0
  store i32 0, i32* %op1
  %op2 = load i32, i32* %op1
  %op3 = load i32, i32* %op0
  %op4 = icmp slt i32 %op2, %op3
  br i1 %op4, label %label5, label %label12
label5:                                                ; preds = %label_entry, %label5
  %op6 = load i32, i32* %op1
  call void @output(i32 %op6)
  %op7 = load i32, i32* %op1
  %op8 = add i32 %op7, 1
  store i32 %op8, i32* %op1
  %op9 = load i32, i32* %op1
  %op10 = load i32, i32* %op0
  %op11 = icmp slt i32 %op9, %op10
  br i1 %op11, label %label5, label %label12
label12:                                                ; preds = %label_entry, %label5
  ret i32 0
}
