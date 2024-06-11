; ModuleID = 'cminus'
source_filename = "/home/hzw/桌面/2023ustc-jianmu-compiler/tests/testcases_general/14-while_stmt.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define void @main() {
label_entry:
  %op0 = icmp ne i32 10, 0
  br i1 %op0, label %label1, label %label5
label1:                                                ; preds = %label_entry, %label1
  %op2 = phi i32 [ 10, %label_entry ], [ %op3, %label1 ]
  %op3 = sub i32 %op2, 1
  %op4 = icmp ne i32 %op3, 0
  br i1 %op4, label %label1, label %label5
label5:                                                ; preds = %label_entry, %label1
  ret void
}
