; ModuleID = 'cminus'
source_filename = "/home/hzw/桌面/2023ustc-jianmu-compiler/tests/testcases_general/12-funcall_recursion.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define i32 @factorial(i32 %arg0) {
label_entry:
  %op1 = alloca i32
  store i32 %arg0, i32* %op1
  %op2 = load i32, i32* %op1
  %op3 = icmp eq i32 %op2, 0
  br i1 %op3, label %label4, label %label5
label4:                                                ; preds = %label_entry
  ret i32 1
label5:                                                ; preds = %label_entry
  %op6 = load i32, i32* %op1
  %op7 = sub i32 %op6, 1
  %op8 = call i32 @factorial(i32 %op7)
  %op9 = load i32, i32* %op1
  %op10 = mul i32 %op9, %op8
  ret i32 %op10
label11:
  ret i32 0
}
define i32 @main() {
label_entry:
  %op0 = call i32 @factorial(i32 10)
  ret i32 %op0
}
