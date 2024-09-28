; ModuleID = 'cminus'
source_filename = "/home/hzw/桌面/2023ustc-jianmu-compiler/my_test/test.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define void @main() {
label_entry:
  %op0 = icmp slt i32 0, 10
  br i1 %op0, label %label1, label %label11
label1:                                                ; preds = %label_entry, %label1
  %op2 = phi i32 [ 2, %label_entry ], [ %op4, %label1 ]
  %op3 = phi i32 [ 1, %label_entry ], [ %op5, %label1 ]
  %op4 = phi i32 [ 7, %label_entry ], [ %op3, %label1 ]
  %op5 = phi i32 [ 2, %label_entry ], [ %op7, %label1 ]
  %op6 = phi i32 [ 0, %label_entry ], [ %op9, %label1 ]
  %op7 = phi i32 [ 2, %label_entry ], [ %op8, %label1 ]
  %op8 = phi i32 [ 3, %label_entry ], [ %op2, %label1 ]
  %op9 = add i32 %op6, 1
  %op10 = icmp slt i32 %op9, 10
  br i1 %op10, label %label1, label %label11
label11:                                                ; preds = %label_entry, %label1
  %op12 = phi i32 [ 2, %label_entry ], [ %op4, %label1 ]
  %op13 = phi i32 [ 1, %label_entry ], [ %op5, %label1 ]
  %op14 = phi i32 [ 7, %label_entry ], [ %op3, %label1 ]
  %op15 = phi i32 [ 2, %label_entry ], [ %op7, %label1 ]
  %op16 = phi i32 [ 2, %label_entry ], [ %op8, %label1 ]
  %op17 = phi i32 [ 3, %label_entry ], [ %op2, %label1 ]
  %op18 = sub i32 %op13, %op15
  %op19 = add i32 %op18, %op17
  %op20 = add i32 %op19, %op16
  %op21 = add i32 %op20, %op12
  %op22 = sub i32 %op21, %op14
  call void @output(i32 %op22)
  ret void
}
