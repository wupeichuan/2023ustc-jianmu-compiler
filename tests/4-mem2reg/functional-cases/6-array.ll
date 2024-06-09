; ModuleID = 'cminus'
source_filename = "/home/hzw/桌面/2023ustc-jianmu-compiler/tests/4-mem2reg/functional-cases/6-array.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define i32 @main() {
label_entry:
  %op0 = alloca [10 x i32]
  %op1 = icmp sge i32 0, 0
  br i1 %op1, label %label2, label %label4
label2:                                                ; preds = %label_entry
  %op3 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 0
  br label %label5
label4:                                                ; preds = %label_entry
  call void @neg_idx_except()
  br label %label5
label5:                                                ; preds = %label2, %label4
  store i32 11, i32* %op3
  %op6 = icmp sge i32 4, 0
  br i1 %op6, label %label7, label %label9
label7:                                                ; preds = %label5
  %op8 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 4
  br label %label10
label9:                                                ; preds = %label5
  call void @neg_idx_except()
  br label %label10
label10:                                                ; preds = %label7, %label9
  store i32 22, i32* %op8
  %op11 = icmp sge i32 9, 0
  br i1 %op11, label %label12, label %label14
label12:                                                ; preds = %label10
  %op13 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 9
  br label %label15
label14:                                                ; preds = %label10
  call void @neg_idx_except()
  br label %label15
label15:                                                ; preds = %label12, %label14
  store i32 33, i32* %op13
  %op16 = icmp sge i32 0, 0
  br i1 %op16, label %label17, label %label20
label17:                                                ; preds = %label15
  %op18 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 0
  %op19 = load i32, i32* %op18
  br label %label21
label20:                                                ; preds = %label15
  call void @neg_idx_except()
  br label %label21
label21:                                                ; preds = %label17, %label20
  call void @output(i32 %op19)
  %op22 = icmp sge i32 4, 0
  br i1 %op22, label %label23, label %label26
label23:                                                ; preds = %label21
  %op24 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 4
  %op25 = load i32, i32* %op24
  br label %label27
label26:                                                ; preds = %label21
  call void @neg_idx_except()
  br label %label27
label27:                                                ; preds = %label23, %label26
  call void @output(i32 %op25)
  %op28 = icmp sge i32 9, 0
  br i1 %op28, label %label29, label %label32
label29:                                                ; preds = %label27
  %op30 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 9
  %op31 = load i32, i32* %op30
  br label %label33
label32:                                                ; preds = %label27
  call void @neg_idx_except()
  br label %label33
label33:                                                ; preds = %label29, %label32
  call void @output(i32 %op31)
  ret i32 0
}
