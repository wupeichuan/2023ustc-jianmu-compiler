; ModuleID = 'cminus'
source_filename = "/home/hzw/桌面/2023ustc-jianmu-compiler/tests/3-codegen/autogen/testcases/4-if.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define i32 @main() {
label_entry:
  %op0 = alloca i32
  %op1 = alloca i32
  %op2 = alloca i32
  store i32 11, i32* %op0
  store i32 22, i32* %op1
  store i32 33, i32* %op2
  %op3 = load i32, i32* %op0
  %op4 = load i32, i32* %op1
  %op5 = icmp sgt i32 %op3, %op4
  br i1 %op5, label %label6, label %label10
label6:                                                ; preds = %label_entry
  %op7 = load i32, i32* %op0
  %op8 = load i32, i32* %op2
  %op9 = icmp sgt i32 %op7, %op8
  br i1 %op9, label %label15, label %label17
label10:                                                ; preds = %label_entry
  %op11 = load i32, i32* %op2
  %op12 = load i32, i32* %op1
  %op13 = icmp slt i32 %op11, %op12
  br i1 %op13, label %label20, label %label22
label14:                                                ; preds = %label19, %label24
  ret i32 0
label15:                                                ; preds = %label6
  %op16 = load i32, i32* %op0
  call void @output(i32 %op16)
  br label %label19
label17:                                                ; preds = %label6
  %op18 = load i32, i32* %op2
  call void @output(i32 %op18)
  br label %label19
label19:                                                ; preds = %label15, %label17
  br label %label14
label20:                                                ; preds = %label10
  %op21 = load i32, i32* %op1
  call void @output(i32 %op21)
  br label %label24
label22:                                                ; preds = %label10
  %op23 = load i32, i32* %op2
  call void @output(i32 %op23)
  br label %label24
label24:                                                ; preds = %label20, %label22
  br label %label14
}
