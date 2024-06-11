; ModuleID = 'cminus'
source_filename = "/home/hzw/桌面/2023ustc-jianmu-compiler/tests/testcases_general/15-if_while.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define i32 @main() {
label_entry:
  %op0 = icmp ne i32 10, 0
  br i1 %op0, label %label1, label %label7
label1:                                                ; preds = %label_entry, %label15
  %op2 = phi i32 [ 0, %label_entry ], [ %op16, %label15 ]
  %op3 = phi i32 [ 10, %label_entry ], [ %op5, %label15 ]
  %op4 = phi i32 [ 0, %label_entry ], [ %op17, %label15 ]
  %op5 = sub i32 %op3, 1
  %op6 = icmp slt i32 %op5, 5
  br i1 %op6, label %label11, label %label13
label7:                                                ; preds = %label_entry, %label15
  %op8 = phi i32 [ 0, %label_entry ], [ %op16, %label15 ]
  %op9 = phi i32 [ 0, %label_entry ], [ %op17, %label15 ]
  %op10 = add i32 %op8, %op9
  ret i32 %op10
label11:                                                ; preds = %label1
  %op12 = add i32 %op2, %op5
  br label %label15
label13:                                                ; preds = %label1
  %op14 = add i32 %op4, %op5
  br label %label15
label15:                                                ; preds = %label11, %label13
  %op16 = phi i32 [ %op12, %label11 ], [ %op2, %label13 ]
  %op17 = phi i32 [ %op4, %label11 ], [ %op14, %label13 ]
  %op18 = icmp ne i32 %op5, 0
  br i1 %op18, label %label1, label %label7
}
