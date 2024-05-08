; ModuleID = 'cminus'
source_filename = "/home/hzw/桌面/2023ustc-jianmu-compiler/tests/3-codegen/autogen/testcases/8-store.cminus"

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
  %op1 = alloca i32
  %op2 = alloca i32
  store i32 0, i32* %op1
  %op3 = load i32, i32* %op1
  %op4 = icmp slt i32 %op3, 10
  br i1 %op4, label %label5, label %label15
label5:                                                ; preds = %label_entry, %label5
  %op6 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 0
  %op7 = load i32, i32* %op1
  %op8 = load i32, i32* %op1
  %op9 = mul i32 %op8, 2
  %op10 = call i32 @store(i32* %op6, i32 %op7, i32 %op9)
  %op11 = load i32, i32* %op1
  %op12 = add i32 %op11, 1
  store i32 %op12, i32* %op1
  %op13 = load i32, i32* %op1
  %op14 = icmp slt i32 %op13, 10
  br i1 %op14, label %label5, label %label15
label15:                                                ; preds = %label_entry, %label5
  store i32 0, i32* %op2
  store i32 0, i32* %op1
  %op16 = load i32, i32* %op1
  %op17 = icmp slt i32 %op16, 10
  br i1 %op17, label %label18, label %label21
label18:                                                ; preds = %label15, %label27
  %op19 = load i32, i32* %op1
  %op20 = icmp sge i32 %op19, 0
  br i1 %op20, label %label23, label %label26
label21:                                                ; preds = %label15, %label27
  %op22 = load i32, i32* %op2
  call void @output(i32 %op22)
  ret i32 0
label23:                                                ; preds = %label18
  %op24 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 %op19
  %op25 = load i32, i32* %op24
  br label %label27
label26:                                                ; preds = %label18
  call void @neg_idx_except()
  br label %label27
label27:                                                ; preds = %label23, %label26
  %op28 = load i32, i32* %op2
  %op29 = add i32 %op28, %op25
  store i32 %op29, i32* %op2
  %op30 = load i32, i32* %op1
  %op31 = add i32 %op30, 1
  store i32 %op31, i32* %op1
  %op32 = load i32, i32* %op1
  %op33 = icmp slt i32 %op32, 10
  br i1 %op33, label %label18, label %label21
}
