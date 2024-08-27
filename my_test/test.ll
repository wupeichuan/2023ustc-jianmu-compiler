; ModuleID = 'cminus'
source_filename = "/home/hzw/桌面/2023ustc-jianmu-compiler/my_test/test.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define void @main() {
label_entry:
  %op0 = icmp slt i32 0, 10
  br i1 %op0, label %label1, label %label8
label1:                                                ; preds = %label_entry, %label1
  %op2 = phi i32 [ 2, %label_entry ], [ %op5, %label1 ]
  %op3 = phi i32 [ 1, %label_entry ], [ %op2, %label1 ]
  %op4 = phi i32 [ 0, %label_entry ], [ %op6, %label1 ]
  %op5 = phi i32 [ 2, %label_entry ], [ %op3, %label1 ]
  %op6 = add i32 %op4, 1
  %op7 = icmp slt i32 %op6, 10
  br i1 %op7, label %label1, label %label8
label8:                                                ; preds = %label_entry, %label1
  %op9 = phi i32 [ 2, %label_entry ], [ %op5, %label1 ]
  %op10 = phi i32 [ 1, %label_entry ], [ %op2, %label1 ]
  %op11 = phi i32 [ 2, %label_entry ], [ %op3, %label1 ]
  %op12 = phi i32 [ 3, %label_entry ], [ %op3, %label1 ]
  %op13 = sub i32 %op10, %op9
  %op14 = add i32 %op13, %op12
  %op15 = add i32 %op14, %op11
  call void @output(i32 %op15)
  ret void
}
