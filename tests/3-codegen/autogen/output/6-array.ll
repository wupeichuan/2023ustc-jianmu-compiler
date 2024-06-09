; ModuleID = 'cminus'
source_filename = "/home/hzw/桌面/2023ustc-jianmu-compiler/tests/3-codegen/autogen/testcases/6-array.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define i32 @main() {
label_entry:
  %op0 = alloca [10 x i32]
  %op1 = alloca i32
  store i32 0, i32* %op1
  %op2 = icmp sge i32 0, 0
  br i1 %op2, label %label3, label %label5
label3:                                                ; preds = %label_entry
  %op4 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 0
  br label %label6
label5:                                                ; preds = %label_entry
  call void @neg_idx_except()
  br label %label6
label6:                                                ; preds = %label3, %label5
  store i32 11, i32* %op4
  %op7 = icmp sge i32 4, 0
  br i1 %op7, label %label8, label %label10
label8:                                                ; preds = %label6
  %op9 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 4
  br label %label11
label10:                                                ; preds = %label6
  call void @neg_idx_except()
  br label %label11
label11:                                                ; preds = %label8, %label10
  store i32 22, i32* %op9
  %op12 = icmp sge i32 9, 0
  br i1 %op12, label %label13, label %label15
label13:                                                ; preds = %label11
  %op14 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 9
  br label %label16
label15:                                                ; preds = %label11
  call void @neg_idx_except()
  br label %label16
label16:                                                ; preds = %label13, %label15
  store i32 33, i32* %op14
  %op17 = icmp sge i32 0, 0
  br i1 %op17, label %label18, label %label21
label18:                                                ; preds = %label16
  %op19 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 0
  %op20 = load i32, i32* %op19
  br label %label22
label21:                                                ; preds = %label16
  call void @neg_idx_except()
  br label %label22
label22:                                                ; preds = %label18, %label21
  call void @output(i32 %op20)
  %op23 = icmp sge i32 4, 0
  br i1 %op23, label %label24, label %label27
label24:                                                ; preds = %label22
  %op25 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 4
  %op26 = load i32, i32* %op25
  br label %label28
label27:                                                ; preds = %label22
  call void @neg_idx_except()
  br label %label28
label28:                                                ; preds = %label24, %label27
  call void @output(i32 %op26)
  %op29 = icmp sge i32 9, 0
  br i1 %op29, label %label30, label %label33
label30:                                                ; preds = %label28
  %op31 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 9
  %op32 = load i32, i32* %op31
  br label %label34
label33:                                                ; preds = %label28
  call void @neg_idx_except()
  br label %label34
label34:                                                ; preds = %label30, %label33
  call void @output(i32 %op32)
  ret i32 0
}
