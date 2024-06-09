; ModuleID = 'cminus'
source_filename = "/home/hzw/桌面/2023ustc-jianmu-compiler/tests/4-mem2reg/functional-cases/8-store.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define i32 @store(i32* %arg0, i32 %arg1, i32 %arg2) {
label_entry:
  %op3 = alloca i32*
  store i32* %arg0, i32** %op3
  %op4 = alloca i32
  store i32 %arg1, i32* %op4
  %op5 = alloca i32
  store i32 %arg2, i32* %op5
  %op6 = load i32, i32* %op4
  %op7 = icmp sge i32 %op6, 0
  br i1 %op7, label %label8, label %label11
label8:                                                ; preds = %label_entry
  %op9 = load i32*, i32** %op3
  %op10 = getelementptr i32, i32* %op9, i32 %op6
  br label %label12
label11:                                                ; preds = %label_entry
  call void @neg_idx_except()
  br label %label12
label12:                                                ; preds = %label8, %label11
  %op13 = load i32, i32* %op5
  store i32 %op13, i32* %op10
  %op14 = load i32, i32* %op5
  ret i32 %op14
}
define i32 @main() {
label_entry:
  %op0 = alloca [10 x i32]
  %op1 = icmp slt i32 0, 10
  br i1 %op1, label %label2, label %label9
label2:                                                ; preds = %label_entry, %label2
  %op3 = phi i32 [ 0, %label_entry ], [ %op7, %label2 ]
  %op4 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 0
  %op5 = mul i32 %op3, 2
  %op6 = call i32 @store(i32* %op4, i32 %op3, i32 %op5)
  %op7 = add i32 %op3, 1
  %op8 = icmp slt i32 %op7, 10
  br i1 %op8, label %label2, label %label9
label9:                                                ; preds = %label_entry, %label2
  %op10 = icmp slt i32 0, 10
  br i1 %op10, label %label11, label %label15
label11:                                                ; preds = %label9, %label21
  %op12 = phi i32 [ 0, %label9 ], [ %op22, %label21 ]
  %op13 = phi i32 [ 0, %label9 ], [ %op23, %label21 ]
  %op14 = icmp sge i32 %op13, 0
  br i1 %op14, label %label17, label %label20
label15:                                                ; preds = %label9, %label21
  %op16 = phi i32 [ 0, %label9 ], [ %op22, %label21 ]
  call void @output(i32 %op16)
  ret i32 0
label17:                                                ; preds = %label11
  %op18 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 %op13
  %op19 = load i32, i32* %op18
  br label %label21
label20:                                                ; preds = %label11
  call void @neg_idx_except()
  br label %label21
label21:                                                ; preds = %label17, %label20
  %op22 = add i32 %op12, %op19
  %op23 = add i32 %op13, 1
  %op24 = icmp slt i32 %op23, 10
  br i1 %op24, label %label11, label %label15
}
