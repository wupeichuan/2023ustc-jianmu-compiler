; ModuleID = 'cminus'
source_filename = "/home/hzw/桌面/2023ustc-jianmu-compiler/my_test/test.cminus"

@x = global [10 x float] zeroinitializer
declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define i32 @minloc(float* %arg0, float %arg1, i32 %arg2) {
label_entry:
  %op3 = alloca float*
  store float* %arg0, float** %op3
  %op4 = alloca float
  store float %arg1, float* %op4
  %op5 = alloca i32
  store i32 %arg2, i32* %op5
  %op6 = load float, float* %op4
  %op7 = fptosi float %op6 to i32
  %op8 = load float, float* %op4
  %op9 = fptosi float %op8 to i32
  %op10 = icmp sge i32 %op9, 0
  br i1 %op10, label %label11, label %label15
label11:                                                ; preds = %label_entry
  %op12 = load float*, float** %op3
  %op13 = getelementptr float, float* %op12, i32 %op9
  %op14 = load float, float* %op13
  br label %label16
label15:                                                ; preds = %label_entry
  call void @neg_idx_except()
  br label %label16
label16:                                                ; preds = %label11, %label15
  %op17 = fptosi float %op14 to i32
  %op18 = load float, float* %op4
  %op19 = sitofp i32 1 to float
  %op20 = fadd float %op18, %op19
  %op21 = fptosi float %op20 to i32
  %op22 = load i32, i32* %op5
  %op23 = icmp slt i32 %op21, %op22
  br i1 %op23, label %label24, label %label29
label24:                                                ; preds = %label16, %label41
  %op25 = phi i32 [ %op7, %label16 ], [ %op42, %label41 ]
  %op26 = phi i32 [ %op17, %label16 ], [ %op43, %label41 ]
  %op27 = phi i32 [ %op21, %label16 ], [ %op44, %label41 ]
  %op28 = icmp sge i32 %op27, 0
  br i1 %op28, label %label31, label %label35
label29:                                                ; preds = %label16, %label41
  %op30 = phi i32 [ %op7, %label16 ], [ %op42, %label41 ]
  ret i32 %op30
label31:                                                ; preds = %label24
  %op32 = load float*, float** %op3
  %op33 = getelementptr float, float* %op32, i32 %op27
  %op34 = load float, float* %op33
  br label %label36
label35:                                                ; preds = %label24
  call void @neg_idx_except()
  br label %label36
label36:                                                ; preds = %label31, %label35
  %op37 = sitofp i32 %op26 to float
  %op38 = fcmp ult float %op34, %op37
  br i1 %op38, label %label39, label %label41
label39:                                                ; preds = %label36
  %op40 = icmp sge i32 %op27, 0
  br i1 %op40, label %label47, label %label51
label41:                                                ; preds = %label36, %label52
  %op42 = phi i32 [ %op25, %label36 ], [ %op27, %label52 ]
  %op43 = phi i32 [ %op26, %label36 ], [ %op53, %label52 ]
  %op44 = add i32 %op27, 1
  %op45 = load i32, i32* %op5
  %op46 = icmp slt i32 %op44, %op45
  br i1 %op46, label %label24, label %label29
label47:                                                ; preds = %label39
  %op48 = load float*, float** %op3
  %op49 = getelementptr float, float* %op48, i32 %op27
  %op50 = load float, float* %op49
  br label %label52
label51:                                                ; preds = %label39
  call void @neg_idx_except()
  br label %label52
label52:                                                ; preds = %label47, %label51
  %op53 = fptosi float %op50 to i32
  br label %label41
}
define void @sort(float* %arg0, i32 %arg1, float %arg2) {
label_entry:
  %op3 = alloca float*
  store float* %arg0, float** %op3
  %op4 = alloca i32
  store i32 %arg1, i32* %op4
  %op5 = alloca float
  store float %arg2, float* %op5
  %op6 = load i32, i32* %op4
  %op7 = load float, float* %op5
  %op8 = sitofp i32 1 to float
  %op9 = fsub float %op7, %op8
  %op10 = sitofp i32 %op6 to float
  %op11 = fcmp ult float %op10, %op9
  br i1 %op11, label %label12, label %label20
label12:                                                ; preds = %label_entry, %label46
  %op13 = phi i32 [ %op6, %label_entry ], [ %op48, %label46 ]
  %op14 = load float*, float** %op3
  %op15 = sitofp i32 %op13 to float
  %op16 = load float, float* %op5
  %op17 = fptosi float %op16 to i32
  %op18 = call i32 @minloc(float* %op14, float %op15, i32 %op17)
  %op19 = icmp sge i32 %op18, 0
  br i1 %op19, label %label21, label %label25
label20:                                                ; preds = %label_entry, %label46
  ret void
label21:                                                ; preds = %label12
  %op22 = load float*, float** %op3
  %op23 = getelementptr float, float* %op22, i32 %op18
  %op24 = load float, float* %op23
  br label %label26
label25:                                                ; preds = %label12
  call void @neg_idx_except()
  br label %label26
label26:                                                ; preds = %label21, %label25
  %op27 = fptosi float %op24 to i32
  %op28 = icmp sge i32 %op18, 0
  br i1 %op28, label %label29, label %label32
label29:                                                ; preds = %label26
  %op30 = load float*, float** %op3
  %op31 = getelementptr float, float* %op30, i32 %op18
  br label %label33
label32:                                                ; preds = %label26
  call void @neg_idx_except()
  br label %label33
label33:                                                ; preds = %label29, %label32
  %op34 = icmp sge i32 %op13, 0
  br i1 %op34, label %label35, label %label39
label35:                                                ; preds = %label33
  %op36 = load float*, float** %op3
  %op37 = getelementptr float, float* %op36, i32 %op13
  %op38 = load float, float* %op37
  br label %label40
label39:                                                ; preds = %label33
  call void @neg_idx_except()
  br label %label40
label40:                                                ; preds = %label35, %label39
  store float %op38, float* %op31
  %op41 = icmp sge i32 %op13, 0
  br i1 %op41, label %label42, label %label45
label42:                                                ; preds = %label40
  %op43 = load float*, float** %op3
  %op44 = getelementptr float, float* %op43, i32 %op13
  br label %label46
label45:                                                ; preds = %label40
  call void @neg_idx_except()
  br label %label46
label46:                                                ; preds = %label42, %label45
  %op47 = sitofp i32 %op27 to float
  store float %op47, float* %op44
  %op48 = add i32 %op13, 1
  %op49 = load float, float* %op5
  %op50 = sitofp i32 1 to float
  %op51 = fsub float %op49, %op50
  %op52 = sitofp i32 %op48 to float
  %op53 = fcmp ult float %op52, %op51
  br i1 %op53, label %label12, label %label20
}
define void @main() {
label_entry:
  %op0 = icmp slt i32 0, 10
  br i1 %op0, label %label1, label %label4
label1:                                                ; preds = %label_entry, %label11
  %op2 = phi i32 [ 0, %label_entry ], [ %op14, %label11 ]
  %op3 = icmp sge i32 %op2, 0
  br i1 %op3, label %label8, label %label10
label4:                                                ; preds = %label_entry, %label11
  %op5 = getelementptr [10 x float], [10 x float]* @x, i32 0, i32 0
  %op6 = sitofp i32 10 to float
  call void @sort(float* %op5, i32 0, float %op6)
  %op7 = icmp slt i32 0, 10
  br i1 %op7, label %label16, label %label19
label8:                                                ; preds = %label1
  %op9 = getelementptr [10 x float], [10 x float]* @x, i32 0, i32 %op2
  br label %label11
label10:                                                ; preds = %label1
  call void @neg_idx_except()
  br label %label11
label11:                                                ; preds = %label8, %label10
  %op12 = sub i32 10, %op2
  %op13 = sitofp i32 %op12 to float
  store float %op13, float* %op9
  %op14 = add i32 %op2, 1
  %op15 = icmp slt i32 %op14, 10
  br i1 %op15, label %label1, label %label4
label16:                                                ; preds = %label4, %label24
  %op17 = phi i32 [ 0, %label4 ], [ %op26, %label24 ]
  %op18 = icmp sge i32 %op17, 0
  br i1 %op18, label %label20, label %label23
label19:                                                ; preds = %label4, %label24
  ret void
label20:                                                ; preds = %label16
  %op21 = getelementptr [10 x float], [10 x float]* @x, i32 0, i32 %op17
  %op22 = load float, float* %op21
  br label %label24
label23:                                                ; preds = %label16
  call void @neg_idx_except()
  br label %label24
label24:                                                ; preds = %label20, %label23
  %op25 = fptosi float %op22 to i32
  call void @output(i32 %op25)
  %op26 = add i32 %op17, 1
  %op27 = icmp slt i32 %op26, 10
  br i1 %op27, label %label16, label %label19
}
