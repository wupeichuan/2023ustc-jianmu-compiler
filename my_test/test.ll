; ModuleID = 'cminus'
source_filename = "/home/hzw/桌面/2023ustc-jianmu-compiler/my_test/test.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define i32 @gcd(i32 %arg0, i32 %arg1) {
label_entry:
  %op2 = alloca i32
  store i32 %arg0, i32* %op2
  %op3 = alloca i32
  store i32 %arg1, i32* %op3
  %op4 = load i32, i32* %op3
  %op5 = icmp eq i32 %op4, 0
  br i1 %op5, label %label6, label %label8
label6:                                                ; preds = %label_entry
  %op7 = load i32, i32* %op2
  ret i32 %op7
label8:                                                ; preds = %label_entry
  %op9 = load i32, i32* %op3
  %op10 = load i32, i32* %op3
  %op11 = load i32, i32* %op3
  %op12 = load i32, i32* %op2
  %op13 = sdiv i32 %op12, %op11
  %op14 = mul i32 %op13, %op10
  %op15 = load i32, i32* %op2
  %op16 = sub i32 %op15, %op14
  %op17 = call i32 @gcd(i32 %op9, i32 %op16)
  ret i32 %op17
label18:
  ret i32 0
}
define void @main() {
label_entry:
  %op0 = add i32 435, 1
  %op1 = icmp sge i32 135, %op0
  br i1 %op1, label %label2, label %label3
label2:                                                ; preds = %label_entry
  br label %label3
label3:                                                ; preds = %label_entry, %label2
  %op4 = phi i32 [ 135, %label_entry ], [ 435, %label2 ]
  %op5 = phi i32 [ 435, %label_entry ], [ 135, %label2 ]
  %op6 = call i32 @gcd(i32 %op5, i32 %op4)
  call void @output(i32 %op6)
  ret void
}
