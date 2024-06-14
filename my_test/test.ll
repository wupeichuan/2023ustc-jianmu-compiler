; ModuleID = 'cminus'
source_filename = "/home/hzw/桌面/2023ustc-jianmu-compiler/my_test/test.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define void @main() {
label_entry:
  %op0 = sitofp i32 0 to float
  %op1 = sitofp i32 0 to float
  %op2 = fcmp ugt float %op0, %op1
  br i1 %op2, label %label3, label %label11
label3:                                                ; preds = %label_entry, %label3
  %op4 = add i32 0, 1
  %op5 = add i32 %op4, 1
  %op6 = add i32 %op5, 1
  %op7 = icmp slt i32 %op6, 10
  %op8 = sitofp i1 %op7 to float
  %op9 = sitofp i32 0 to float
  %op10 = fcmp ugt float %op8, %op9
  br i1 %op10, label %label3, label %label11
label11:                                                ; preds = %label_entry, %label3
  %op12 = phi float [ %op0, %label_entry ], [ %op8, %label3 ]
  %op13 = phi i32 [ 0, %label_entry ], [ %op5, %label3 ]
  %op14 = add i32 %op13, 0
  %op15 = add i32 %op14, 0
  %op16 = add i32 %op15, 0
  %op17 = sitofp i32 %op16 to float
  %op18 = fadd float %op17, %op12
  %op19 = fptosi float %op18 to i32
  call void @output(i32 %op19)
  %op20 = fptosi float %op12 to i32
  call void @output(i32 %op20)
  ret void
}
