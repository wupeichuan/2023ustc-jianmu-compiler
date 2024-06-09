; ModuleID = 'cminus'
source_filename = "/home/hzw/桌面/2023ustc-jianmu-compiler/tests/testcases_general/15-if_while.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define i32 @main() {
label_entry:
  %op0 = alloca i32
  %op1 = alloca i32
  %op2 = alloca i32
  store i32 0, i32* %op1
  store i32 0, i32* %op2
  store i32 10, i32* %op0
  %op3 = load i32, i32* %op0
  %op4 = icmp ne i32 %op3, 0
  br i1 %op4, label %label5, label %label10
label5:                                                ; preds = %label_entry, %label22
  %op6 = load i32, i32* %op0
  %op7 = sub i32 %op6, 1
  store i32 %op7, i32* %op0
  %op8 = load i32, i32* %op0
  %op9 = icmp slt i32 %op8, 5
  br i1 %op9, label %label14, label %label18
label10:                                                ; preds = %label_entry, %label22
  %op11 = load i32, i32* %op2
  %op12 = load i32, i32* %op1
  %op13 = add i32 %op12, %op11
  ret i32 %op13
label14:                                                ; preds = %label5
  %op15 = load i32, i32* %op0
  %op16 = load i32, i32* %op1
  %op17 = add i32 %op16, %op15
  store i32 %op17, i32* %op1
  br label %label22
label18:                                                ; preds = %label5
  %op19 = load i32, i32* %op0
  %op20 = load i32, i32* %op2
  %op21 = add i32 %op20, %op19
  store i32 %op21, i32* %op2
  br label %label22
label22:                                                ; preds = %label14, %label18
  %op23 = load i32, i32* %op0
  %op24 = icmp ne i32 %op23, 0
  br i1 %op24, label %label5, label %label10
}
