; ModuleID = 'cminus'
source_filename = "/home/hzw/桌面/2023ustc-jianmu-compiler/tests/testcases_general/17-while_chain.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define i32 @main() {
label_entry:
  %op0 = alloca i32
  %op1 = alloca i32
  store i32 10, i32* %op0
  %op2 = load i32, i32* %op0
  %op3 = icmp ne i32 %op2, 0
  br i1 %op3, label %label4, label %label10
label4:                                                ; preds = %label_entry, %label19
  %op5 = load i32, i32* %op0
  %op6 = sub i32 %op5, 1
  store i32 %op6, i32* %op0
  %op7 = load i32, i32* %op0
  store i32 %op7, i32* %op1
  %op8 = load i32, i32* %op1
  %op9 = icmp ne i32 %op8, 0
  br i1 %op9, label %label14, label %label19
label10:                                                ; preds = %label_entry, %label19
  %op11 = load i32, i32* %op1
  %op12 = load i32, i32* %op0
  %op13 = add i32 %op12, %op11
  ret i32 %op13
label14:                                                ; preds = %label4, %label14
  %op15 = load i32, i32* %op1
  %op16 = sub i32 %op15, 1
  store i32 %op16, i32* %op1
  %op17 = load i32, i32* %op1
  %op18 = icmp ne i32 %op17, 0
  br i1 %op18, label %label14, label %label19
label19:                                                ; preds = %label4, %label14
  %op20 = load i32, i32* %op0
  %op21 = icmp ne i32 %op20, 0
  br i1 %op21, label %label4, label %label10
}
