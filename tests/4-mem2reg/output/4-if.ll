; ModuleID = 'cminus'
source_filename = "/home/hzw/桌面/2023ustc-jianmu-compiler/tests/4-mem2reg/functional-cases/4-if.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define i32 @main() {
label_entry:
  %op0 = icmp sgt i32 11, 22
  br i1 %op0, label %label1, label %label3
label1:                                                ; preds = %label_entry
  %op2 = icmp sgt i32 11, 33
  br i1 %op2, label %label6, label %label7
label3:                                                ; preds = %label_entry
  %op4 = icmp slt i32 33, 22
  br i1 %op4, label %label9, label %label10
label5:                                                ; preds = %label8, %label11
  ret i32 0
label6:                                                ; preds = %label1
  call void @output(i32 11)
  br label %label8
label7:                                                ; preds = %label1
  call void @output(i32 33)
  br label %label8
label8:                                                ; preds = %label6, %label7
  br label %label5
label9:                                                ; preds = %label3
  call void @output(i32 22)
  br label %label11
label10:                                                ; preds = %label3
  call void @output(i32 33)
  br label %label11
label11:                                                ; preds = %label9, %label10
  br label %label5
}
