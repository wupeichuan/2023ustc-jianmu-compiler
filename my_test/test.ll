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
  br i1 %op11, label %label12, label %label21
label12:                                                ; preds = %label_entry, %label47
  %op13 = phi i32 [ %op6, %label_entry ], [ %op49, %label47 ]
  %op14 = sitofp i32 1 to float
  call void @outputFloat(float %op14)
  %op15 = load float*, float** %op3
  %op16 = sitofp i32 %op13 to float
  %op17 = load float, float* %op5
  %op18 = fptosi float %op17 to i32
  %op19 = call i32 @minloc(float* %op15, float %op16, i32 %op18)
  %op20 = icmp sge i32 %op19, 0
  br i1 %op20, label %label22, label %label26
label21:                                                ; preds = %label_entry, %label47
  ret void
label22:                                                ; preds = %label12
  %op23 = load float*, float** %op3
  %op24 = getelementptr float, float* %op23, i32 %op19
  %op25 = load float, float* %op24
  br label %label27
label26:                                                ; preds = %label12
  call void @neg_idx_except()
  br label %label27
label27:                                                ; preds = %label22, %label26
  %op28 = fptosi float %op25 to i32
  %op29 = icmp sge i32 %op19, 0
  br i1 %op29, label %label30, label %label33
label30:                                                ; preds = %label27
  %op31 = load float*, float** %op3
  %op32 = getelementptr float, float* %op31, i32 %op19
  br label %label34
label33:                                                ; preds = %label27
  call void @neg_idx_except()
  br label %label34
label34:                                                ; preds = %label30, %label33
  %op35 = icmp sge i32 %op13, 0
  br i1 %op35, label %label36, label %label40
label36:                                                ; preds = %label34
  %op37 = load float*, float** %op3
  %op38 = getelementptr float, float* %op37, i32 %op13
  %op39 = load float, float* %op38
  br label %label41
label40:                                                ; preds = %label34
  call void @neg_idx_except()
  br label %label41
label41:                                                ; preds = %label36, %label40
  store float %op39, float* %op32
  %op42 = icmp sge i32 %op13, 0
  br i1 %op42, label %label43, label %label46
label43:                                                ; preds = %label41
  %op44 = load float*, float** %op3
  %op45 = getelementptr float, float* %op44, i32 %op13
  br label %label47
label46:                                                ; preds = %label41
  call void @neg_idx_except()
  br label %label47
label47:                                                ; preds = %label43, %label46
  %op48 = sitofp i32 %op28 to float
  store float %op48, float* %op45
  %op49 = add i32 %op13, 1
  %op50 = load float, float* %op5
  %op51 = sitofp i32 1 to float
  %op52 = fsub float %op50, %op51
  %op53 = sitofp i32 %op49 to float
  %op54 = fcmp ult float %op53, %op52
  br i1 %op54, label %label12, label %label21
}
define void @main() {
label_entry:
  %op0 = icmp slt i32 0, 10
  br i1 %op0, label %label1, label %label4
label1:                                                ; preds = %label_entry, %label11
  %op2 = phi i32 [ 0, %label_entry ], [ %op36, %label11 ]
  %op3 = icmp sge i32 %op2, 0
  br i1 %op3, label %label8, label %label10
label4:                                                ; preds = %label_entry, %label11
  %op5 = getelementptr [10 x float], [10 x float]* @x, i32 0, i32 0
  %op6 = sitofp i32 10 to float
  call void @sort(float* %op5, i32 0, float %op6)
  %op7 = icmp slt i32 0, 10
  br i1 %op7, label %label38, label %label42
label8:                                                ; preds = %label1
  %op9 = getelementptr [10 x float], [10 x float]* @x, i32 0, i32 %op2
  br label %label11
label10:                                                ; preds = %label1
  call void @neg_idx_except()
  br label %label11
label11:                                                ; preds = %label8, %label10
  %op12 = mul i32 244, %op2
  %op13 = mul i32 100, %op2
  %op14 = mul i32 %op13, %op2
  %op15 = sitofp i32 %op2 to float
  %op16 = fmul float 0x4043466660000000, %op15
  %op17 = sitofp i32 %op2 to float
  %op18 = fmul float %op16, %op17
  %op19 = sitofp i32 %op2 to float
  %op20 = fmul float %op18, %op19
  %op21 = sitofp i32 %op2 to float
  %op22 = fmul float 0x402470a3e0000000, %op21
  %op23 = sitofp i32 %op2 to float
  %op24 = fmul float %op22, %op23
  %op25 = sitofp i32 %op2 to float
  %op26 = fmul float %op24, %op25
  %op27 = sitofp i32 %op2 to float
  %op28 = fmul float %op26, %op27
  %op29 = sitofp i32 %op2 to float
  %op30 = fmul float %op28, %op29
  %op31 = fsub float %op30, %op20
  %op32 = sitofp i32 %op14 to float
  %op33 = fadd float %op31, %op32
  %op34 = sitofp i32 %op12 to float
  %op35 = fsub float %op33, %op34
  store float %op35, float* %op9
  %op36 = add i32 %op2, 1
  %op37 = icmp slt i32 %op36, 10
  br i1 %op37, label %label1, label %label4
label38:                                                ; preds = %label4, %label38
  %op39 = phi i32 [ 0, %label4 ], [ %op40, %label38 ]
  %op40 = add i32 %op39, 1
  %op41 = icmp slt i32 %op40, 10
  br i1 %op41, label %label38, label %label42
label42:                                                ; preds = %label4, %label38
  ret void
}
