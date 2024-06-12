; ModuleID = 'cminus'
source_filename = "/home/hzw/桌面/2023ustc-jianmu-compiler/my_test/test.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define i32 @mod(i32 %arg0, i32 %arg1) {
label_entry:
  %op2 = alloca i32
  store i32 %arg0, i32* %op2
  %op3 = alloca i32
  store i32 %arg1, i32* %op3
  %op4 = load i32, i32* %op3
  %op5 = load i32, i32* %op3
  %op6 = load i32, i32* %op2
  %op7 = sdiv i32 %op6, %op5
  %op8 = mul i32 %op7, %op4
  %op9 = load i32, i32* %op2
  %op10 = sub i32 %op9, %op8
  ret i32 %op10
}
define void @printfour(i32 %arg0) {
label_entry:
  %op1 = alloca i32
  store i32 %arg0, i32* %op1
  %op2 = load i32, i32* %op1
  %op3 = call i32 @mod(i32 %op2, i32 10000)
  %op4 = call i32 @mod(i32 %op3, i32 10)
  %op5 = sdiv i32 %op3, 10
  %op6 = call i32 @mod(i32 %op5, i32 10)
  %op7 = sdiv i32 %op5, 10
  %op8 = call i32 @mod(i32 %op7, i32 10)
  %op9 = sdiv i32 %op7, 10
  call void @output(i32 %op9)
  call void @output(i32 %op8)
  call void @output(i32 %op6)
  call void @output(i32 %op4)
  ret void
}
define void @main() {
label_entry:
  %op0 = alloca [2801 x i32]
  %op1 = icmp slt i32 0, 2800
  br i1 %op1, label %label2, label %label5
label2:                                                ; preds = %label_entry, %label10
  %op3 = phi i32 [ 0, %label_entry ], [ %op11, %label10 ]
  %op4 = icmp sge i32 %op3, 0
  br i1 %op4, label %label7, label %label9
label5:                                                ; preds = %label_entry, %label10
  %op6 = icmp ne i32 2800, 0
  br i1 %op6, label %label13, label %label17
label7:                                                ; preds = %label2
  %op8 = getelementptr [2801 x i32], [2801 x i32]* %op0, i32 0, i32 %op3
  br label %label10
label9:                                                ; preds = %label2
  call void @neg_idx_except()
  br label %label10
label10:                                                ; preds = %label7, %label9
  store i32 2000, i32* %op8
  %op11 = add i32 %op3, 1
  %op12 = icmp slt i32 %op11, 2800
  br i1 %op12, label %label2, label %label5
label13:                                                ; preds = %label5, %label22
  %op14 = phi i32 [ 0, %label5 ], [ %op26, %label22 ]
  %op15 = phi i32 [ 2800, %label5 ], [ %op27, %label22 ]
  %op16 = icmp ne i32 %op15, 0
  br i1 %op16, label %label18, label %label22
label17:                                                ; preds = %label5, %label22
  ret void
label18:                                                ; preds = %label13, %label49
  %op19 = phi i32 [ 0, %label13 ], [ %op50, %label49 ]
  %op20 = phi i32 [ %op15, %label13 ], [ %op45, %label49 ]
  %op21 = icmp sge i32 %op20, 0
  br i1 %op21, label %label29, label %label32
label22:                                                ; preds = %label13, %label49
  %op23 = phi i32 [ 0, %label13 ], [ %op50, %label49 ]
  %op24 = sdiv i32 %op23, 10000
  %op25 = add i32 %op14, %op24
  call void @printfour(i32 %op25)
  %op26 = call i32 @mod(i32 %op23, i32 10000)
  %op27 = sub i32 %op15, 14
  %op28 = icmp ne i32 %op27, 0
  br i1 %op28, label %label13, label %label17
label29:                                                ; preds = %label18
  %op30 = getelementptr [2801 x i32], [2801 x i32]* %op0, i32 0, i32 %op20
  %op31 = load i32, i32* %op30
  br label %label33
label32:                                                ; preds = %label18
  call void @neg_idx_except()
  br label %label33
label33:                                                ; preds = %label29, %label32
  %op34 = mul i32 %op31, 10000
  %op35 = add i32 %op19, %op34
  %op36 = mul i32 2, %op20
  %op37 = sub i32 %op36, 1
  %op38 = icmp sge i32 %op20, 0
  br i1 %op38, label %label39, label %label41
label39:                                                ; preds = %label33
  %op40 = getelementptr [2801 x i32], [2801 x i32]* %op0, i32 0, i32 %op20
  br label %label42
label41:                                                ; preds = %label33
  call void @neg_idx_except()
  br label %label42
label42:                                                ; preds = %label39, %label41
  %op43 = call i32 @mod(i32 %op35, i32 %op37)
  store i32 %op43, i32* %op40
  %op44 = sdiv i32 %op35, %op37
  %op45 = sub i32 %op20, 1
  %op46 = icmp ne i32 %op45, 0
  br i1 %op46, label %label47, label %label49
label47:                                                ; preds = %label42
  %op48 = mul i32 %op44, %op45
  br label %label49
label49:                                                ; preds = %label42, %label47
  %op50 = phi i32 [ %op44, %label42 ], [ %op48, %label47 ]
  %op51 = icmp ne i32 %op45, 0
  br i1 %op51, label %label18, label %label22
}
