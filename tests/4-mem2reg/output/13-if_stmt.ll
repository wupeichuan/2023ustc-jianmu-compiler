; ModuleID = 'cminus'
source_filename = "/home/hzw/桌面/2023ustc-jianmu-compiler/tests/testcases_general/13-if_stmt.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define void @main() {
label_entry:
  %op0 = icmp ne i32 2, 0
  br i1 %op0, label %label1, label %label2
label1:                                                ; preds = %label_entry
  br label %label2
label2:                                                ; preds = %label_entry, %label1
  ret void
}
