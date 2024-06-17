; ModuleID = 'cminus'
source_filename = "/home/hzw/桌面/2023ustc-jianmu-compiler/my_test/test.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define void @main() {
label_entry:
  %op0 = icmp slt i32 0, 11
  br i1 %op0, label %label1, label %label7
label1:                                                ; preds = %label_entry, %label1
  %op2 = phi i32 [ 2, %label_entry ], [ %op3, %label1 ]
  %op3 = phi i32 [ 1, %label_entry ], [ %op2, %label1 ]
  %op4 = phi i32 [ 0, %label_entry ], [ %op5, %label1 ]
  %op5 = add i32 %op4, 1
  %op6 = icmp slt i32 %op5, 11
  br i1 %op6, label %label1, label %label7
label7:                                                ; preds = %label_entry, %label1
  %op8 = phi i32 [ 2, %label_entry ], [ %op3, %label1 ]
  %op9 = phi i32 [ 1, %label_entry ], [ %op2, %label1 ]
  %op10 = sub i32 %op9, %op8
  call void @output(i32 %op10)
  ret void
}
