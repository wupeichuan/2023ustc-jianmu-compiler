; ModuleID = 'cminus'
source_filename = "/home/hzw/桌面/2023ustc-jianmu-compiler/tests/2-ir-gen/autogen/testcases/lv1/assign_int_array_local.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define void @main() {
label_entry:
  %op0 = alloca [10 x i32]
  %op1 = icmp sge i32 3, 0
  br i1 %op1, label %label_normalBB, label %label_errorBB
label_normalBB:                                                ; preds = %label_entry
  %op2 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 3
  br label %label3
label_errorBB:                                                ; preds = %label_entry
  call void @neg_idx_except()
  br label %label3
label3:                                                ; preds = %label_normalBB, %label_errorBB
  store i32 1234, i32* %op2
  %op4 = icmp sge i32 3, 0
  br i1 %op4, label %label_normalBB, label %label_errorBB
label_normalBB:                                                ; preds = %label3
  %op5 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 3
  %op6 = load i32, i32* %op5
  br label %label7
label_errorBB:                                                ; preds = %label3
  call void @neg_idx_except()
  br label %label7
label7:                                                ; preds = %label_normalBB, %label_errorBB
  call void @output(i32 %op6)
  ret void
}
