; ModuleID = 'cminus'
source_filename = "/home/hzw/桌面/2023ustc-jianmu-compiler/tests/testcases_general/16-if_chain.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define i32 @main() {
label_entry:
  %op0 = icmp ne i32 1, 0
  br i1 %op0, label %label1, label %label3
label1:                                                ; preds = %label_entry
  %op2 = icmp ne i32 0, 0
  br i1 %op2, label %label5, label %label6
label3:                                                ; preds = %label_entry, %label7
  %op4 = phi i32 [ 2, %label_entry ], [ %op8, %label7 ]
  ret i32 %op4
label5:                                                ; preds = %label1
  br label %label7
label6:                                                ; preds = %label1
  br label %label7
label7:                                                ; preds = %label5, %label6
  %op8 = phi i32 [ 4, %label5 ], [ 3, %label6 ]
  br label %label3
}
