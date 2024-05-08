; ModuleID = 'cminus'
source_filename = "/home/hzw/桌面/2023ustc-jianmu-compiler/tests/testcases_general/14-while_stmt.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define void @main() {
label_entry:
  %op0 = alloca i32
  store i32 10, i32* %op0
  %op1 = load i32, i32* %op0
  %op2 = icmp ne i32 %op1, 0
  br i1 %op2, label %label3, label %label8
label3:                                                ; preds = %label_entry, %label3
  %op4 = load i32, i32* %op0
  %op5 = sub i32 %op4, 1
  store i32 %op5, i32* %op0
  %op6 = load i32, i32* %op0
  %op7 = icmp ne i32 %op6, 0
  br i1 %op7, label %label3, label %label8
label8:                                                ; preds = %label_entry, %label3
  ret void
}
