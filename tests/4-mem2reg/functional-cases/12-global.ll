; ModuleID = 'cminus'
source_filename = "/home/hzw/桌面/2023ustc-jianmu-compiler/tests/4-mem2reg/functional-cases/12-global.cminus"

@seed = global i32 zeroinitializer
declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define i32 @randomLCG() {
label_entry:
  %op0 = load i32, i32* @seed
  %op1 = mul i32 %op0, 1103515245
  %op2 = add i32 %op1, 12345
  store i32 %op2, i32* @seed
  %op3 = load i32, i32* @seed
  ret i32 %op3
}
define i32 @randBin() {
label_entry:
  %op0 = call i32 @randomLCG()
  %op1 = icmp sgt i32 %op0, 0
  br i1 %op1, label %label2, label %label3
label2:                                                ; preds = %label_entry
  ret i32 1
label3:                                                ; preds = %label_entry
  ret i32 0
label4:
  ret i32 0
}
define i32 @returnToZeroSteps() {
label_entry:
  %op0 = icmp slt i32 0, 20
  br i1 %op0, label %label1, label %label6
label1:                                                ; preds = %label_entry, %label16
  %op2 = phi i32 [ 0, %label_entry ], [ %op13, %label16 ]
  %op3 = phi i32 [ 0, %label_entry ], [ %op12, %label16 ]
  %op4 = call i32 @randBin()
  %op5 = icmp ne i32 %op4, 0
  br i1 %op5, label %label7, label %label9
label6:                                                ; preds = %label_entry, %label16
  ret i32 20
label7:                                                ; preds = %label1
  %op8 = add i32 %op3, 1
  br label %label11
label9:                                                ; preds = %label1
  %op10 = sub i32 %op3, 1
  br label %label11
label11:                                                ; preds = %label7, %label9
  %op12 = phi i32 [ %op8, %label7 ], [ %op10, %label9 ]
  %op13 = add i32 %op2, 1
  %op14 = icmp eq i32 %op12, 0
  br i1 %op14, label %label15, label %label16
label15:                                                ; preds = %label11
  ret i32 %op13
label16:                                                ; preds = %label11
  %op17 = icmp slt i32 %op13, 20
  br i1 %op17, label %label1, label %label6
}
define i32 @main() {
label_entry:
  store i32 3407, i32* @seed
  %op0 = icmp slt i32 0, 20
  br i1 %op0, label %label1, label %label6
label1:                                                ; preds = %label_entry, %label1
  %op2 = phi i32 [ 0, %label_entry ], [ %op4, %label1 ]
  %op3 = call i32 @returnToZeroSteps()
  call void @output(i32 %op3)
  %op4 = add i32 %op2, 1
  %op5 = icmp slt i32 %op4, 20
  br i1 %op5, label %label1, label %label6
label6:                                                ; preds = %label_entry, %label1
  ret i32 0
}
