; ModuleID = 'cminus'
source_filename = "/home/hzw/桌面/2023ustc-jianmu-compiler/tests/testcases_general/20-gcd_array.cminus"

@x = global [1 x i32] zeroinitializer
@y = global [1 x i32] zeroinitializer
declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define i32 @gcd(i32 %arg0, i32 %arg1) {
label_entry:
  %op2 = alloca i32
  store i32 %arg0, i32* %op2
  %op3 = alloca i32
  store i32 %arg1, i32* %op3
  %op4 = load i32, i32* %op3
  %op5 = icmp eq i32 %op4, 0
  br i1 %op5, label %label6, label %label8
label6:                                                ; preds = %label_entry
  %op7 = load i32, i32* %op2
  ret i32 %op7
label8:                                                ; preds = %label_entry
  %op9 = load i32, i32* %op3
  %op10 = load i32, i32* %op3
  %op11 = load i32, i32* %op3
  %op12 = load i32, i32* %op2
  %op13 = sdiv i32 %op12, %op11
  %op14 = mul i32 %op13, %op10
  %op15 = load i32, i32* %op2
  %op16 = sub i32 %op15, %op14
  %op17 = call i32 @gcd(i32 %op9, i32 %op16)
  ret i32 %op17
label18:
  ret i32 0
}
define i32 @funArray(i32* %arg0, i32* %arg1) {
label_entry:
  %op2 = alloca i32*
  store i32* %arg0, i32** %op2
  %op3 = alloca i32*
  store i32* %arg1, i32** %op3
  %op4 = icmp sge i32 0, 0
  br i1 %op4, label %label5, label %label9
label5:                                                ; preds = %label_entry
  %op6 = load i32*, i32** %op2
  %op7 = getelementptr i32, i32* %op6, i32 0
  %op8 = load i32, i32* %op7
  br label %label10
label9:                                                ; preds = %label_entry
  call void @neg_idx_except()
  br label %label10
label10:                                                ; preds = %label5, %label9
  %op11 = icmp sge i32 0, 0
  br i1 %op11, label %label12, label %label16
label12:                                                ; preds = %label10
  %op13 = load i32*, i32** %op3
  %op14 = getelementptr i32, i32* %op13, i32 0
  %op15 = load i32, i32* %op14
  br label %label17
label16:                                                ; preds = %label10
  call void @neg_idx_except()
  br label %label17
label17:                                                ; preds = %label12, %label16
  %op18 = icmp slt i32 %op8, %op15
  br i1 %op18, label %label19, label %label20
label19:                                                ; preds = %label17
  br label %label20
label20:                                                ; preds = %label17, %label19
  %op21 = phi i32 [ %op15, %label17 ], [ %op8, %label19 ]
  %op22 = phi i32 [ %op8, %label17 ], [ %op15, %label19 ]
  %op23 = call i32 @gcd(i32 %op22, i32 %op21)
  ret i32 %op23
}
define i32 @main() {
label_entry:
  %op0 = icmp sge i32 0, 0
  br i1 %op0, label %label1, label %label3
label1:                                                ; preds = %label_entry
  %op2 = getelementptr [1 x i32], [1 x i32]* @x, i32 0, i32 0
  br label %label4
label3:                                                ; preds = %label_entry
  call void @neg_idx_except()
  br label %label4
label4:                                                ; preds = %label1, %label3
  store i32 90, i32* %op2
  %op5 = icmp sge i32 0, 0
  br i1 %op5, label %label6, label %label8
label6:                                                ; preds = %label4
  %op7 = getelementptr [1 x i32], [1 x i32]* @y, i32 0, i32 0
  br label %label9
label8:                                                ; preds = %label4
  call void @neg_idx_except()
  br label %label9
label9:                                                ; preds = %label6, %label8
  store i32 18, i32* %op7
  %op10 = getelementptr [1 x i32], [1 x i32]* @x, i32 0, i32 0
  %op11 = getelementptr [1 x i32], [1 x i32]* @y, i32 0, i32 0
  %op12 = call i32 @funArray(i32* %op10, i32* %op11)
  ret i32 %op12
}
