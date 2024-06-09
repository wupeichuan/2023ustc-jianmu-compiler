; ModuleID = 'cminus'
source_filename = "/home/hzw/桌面/2023ustc-jianmu-compiler/test.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define i32 @main() {
label_entry:
  %op0 = icmp slt i32 0, 10
  br i1 %op0, label %label1, label %label5
label1:                                                ; preds = %label_entry, %label1
  %op2 = phi i32 [ 0, %label_entry ], [ %op3, %label1 ]
  %op3 = add i32 %op2, 1
  %op4 = icmp slt i32 %op3, 10
  br i1 %op4, label %label1, label %label5
label5:                                                ; preds = %label_entry, %label1
  %op6 = phi i32 [ 0, %label_entry ], [ %op3, %label1 ]
  call void @output(i32 %op6)
  ret i32 0
}
