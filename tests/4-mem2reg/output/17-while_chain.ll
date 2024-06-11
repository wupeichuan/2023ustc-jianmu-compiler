; ModuleID = 'cminus'
source_filename = "/home/hzw/桌面/2023ustc-jianmu-compiler/tests/testcases_general/17-while_chain.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define i32 @main() {
label_entry:
  %op0 = icmp ne i32 10, 0
  br i1 %op0, label %label1, label %label5
label1:                                                ; preds = %label_entry, %label13
  %op2 = phi i32 [ 10, %label_entry ], [ %op3, %label13 ]
  %op3 = sub i32 %op2, 1
  %op4 = icmp ne i32 %op3, 0
  br i1 %op4, label %label9, label %label13
label5:                                                ; preds = %label_entry, %label13
  %op6 = phi i32 [ %op14, %label13 ], [ undef, %label_entry ]
  %op7 = phi i32 [ 10, %label_entry ], [ %op3, %label13 ]
  %op8 = add i32 %op7, %op6
  ret i32 %op8
label9:                                                ; preds = %label1, %label9
  %op10 = phi i32 [ %op3, %label1 ], [ %op11, %label9 ]
  %op11 = sub i32 %op10, 1
  %op12 = icmp ne i32 %op11, 0
  br i1 %op12, label %label9, label %label13
label13:                                                ; preds = %label1, %label9
  %op14 = phi i32 [ %op3, %label1 ], [ %op11, %label9 ]
  %op15 = icmp ne i32 %op3, 0
  br i1 %op15, label %label1, label %label5
}
