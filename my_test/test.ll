; ModuleID = 'cminus'
source_filename = "/home/hzw/桌面/2023ustc-jianmu-compiler/my_test/test.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define i32 @fibonacci(i32 %arg0) {
label_entry:
  %op1 = alloca i32
  store i32 %arg0, i32* %op1
  %op2 = load i32, i32* %op1
  %op3 = icmp eq i32 %op2, 0
  br i1 %op3, label %label4, label %label5
label4:                                                ; preds = %label_entry
  ret i32 0
label5:                                                ; preds = %label_entry
  %op6 = load i32, i32* %op1
  %op7 = icmp eq i32 %op6, 1
  br i1 %op7, label %label9, label %label10
label8:                                                ; preds = %label18
  ret i32 0
label9:                                                ; preds = %label5
  ret i32 1
label10:                                                ; preds = %label5
  %op11 = load i32, i32* %op1
  %op12 = sub i32 %op11, 2
  %op13 = call i32 @fibonacci(i32 %op12)
  %op14 = load i32, i32* %op1
  %op15 = sub i32 %op14, 1
  %op16 = call i32 @fibonacci(i32 %op15)
  %op17 = add i32 %op16, %op13
  ret i32 %op17
label18:
  br label %label8
}
define i32 @main() {
label_entry:
  %op0 = icmp slt i32 0, 10
  br i1 %op0, label %label1, label %label6
label1:                                                ; preds = %label_entry, %label1
  %op2 = phi i32 [ 0, %label_entry ], [ %op4, %label1 ]
  %op3 = call i32 @fibonacci(i32 %op2)
  call void @output(i32 %op3)
  %op4 = add i32 %op2, 1
  %op5 = icmp slt i32 %op4, 10
  br i1 %op5, label %label1, label %label6
label6:                                                ; preds = %label_entry, %label1
  ret i32 0
}
