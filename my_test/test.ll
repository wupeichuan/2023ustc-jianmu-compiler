; ModuleID = 'cminus'
source_filename = "/home/hzw/桌面/2023ustc-jianmu-compiler/my_test/test.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define i32 @main() {
label_entry:
  %op0 = icmp slt i32 0, 10
  br i1 %op0, label %label1, label %label6
label1:                                                ; preds = %label_entry, %label1
  %op2 = phi i32 [ 0, %label_entry ], [ %op3, %label1 ]
  %op3 = add i32 %op2, 1
  %op4 = add i32 %op3, 2
  %op5 = icmp slt i32 %op3, 10
  br i1 %op5, label %label1, label %label6
label6:                                                ; preds = %label_entry, %label1
  %op7 = phi i32 [ 0, %label_entry ], [ %op3, %label1 ]
  %op8 = phi i32 [ 0, %label_entry ], [ %op4, %label1 ]
  call void @output(i32 %op7)
  call void @output(i32 %op8)
  ret i32 0
}
