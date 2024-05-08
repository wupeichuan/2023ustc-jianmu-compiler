; ModuleID = 'cminus'
source_filename = "/home/hzw/桌面/2023ustc-jianmu-compiler/tests/testcases_general/8-assign_int_array_local.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define i32 @main() {
label_entry:
  %op0 = alloca [10 x i32]
  %op1 = icmp sge i32 3, 0
  br i1 %op1, label %label2, label %label4
label2:                                                ; preds = %label_entry
  %op3 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 3
  br label %label5
label4:                                                ; preds = %label_entry
  call void @neg_idx_except()
  br label %label5
label5:                                                ; preds = %label2, %label4
  store i32 1234, i32* %op3
  %op6 = icmp sge i32 3, 0
  br i1 %op6, label %label7, label %label10
label7:                                                ; preds = %label5
  %op8 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 3
  %op9 = load i32, i32* %op8
  br label %label11
label10:                                                ; preds = %label5
  call void @neg_idx_except()
  br label %label11
label11:                                                ; preds = %label7, %label10
  ret i32 %op9
}
