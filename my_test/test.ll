; ModuleID = 'cminus'
source_filename = "/home/hzw/桌面/2023ustc-jianmu-compiler/my_test/test.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define float @get(float* %arg0, i32 %arg1, i32 %arg2, i32 %arg3) {
label_entry:
  %op4 = alloca float*
  store float* %arg0, float** %op4
  %op5 = alloca i32
  store i32 %arg1, i32* %op5
  %op6 = alloca i32
  store i32 %arg2, i32* %op6
  %op7 = alloca i32
  store i32 %arg3, i32* %op7
  %op8 = load i32, i32* %op6
  %op9 = load i32, i32* %op7
  %op10 = load i32, i32* %op5
  %op11 = mul i32 %op10, %op9
  %op12 = add i32 %op11, %op8
  %op13 = icmp sge i32 %op12, 0
  br i1 %op13, label %label14, label %label18
label14:                                                ; preds = %label_entry
  %op15 = load float*, float** %op4
  %op16 = getelementptr float, float* %op15, i32 %op12
  %op17 = load float, float* %op16
  br label %label19
label18:                                                ; preds = %label_entry
  call void @neg_idx_except()
  br label %label19
label19:                                                ; preds = %label14, %label18
  ret float %op17
}
define float @abs(float %arg0) {
label_entry:
  %op1 = alloca float
  store float %arg0, float* %op1
  %op2 = load float, float* %op1
  %op3 = sitofp i32 0 to float
  %op4 = fcmp ugt float %op2, %op3
  br i1 %op4, label %label5, label %label7
label5:                                                ; preds = %label_entry
  %op6 = load float, float* %op1
  ret float %op6
label7:                                                ; preds = %label_entry
  %op8 = load float, float* %op1
  %op9 = sitofp i32 0 to float
  %op10 = fsub float %op9, %op8
  ret float %op10
label11:
  ret float 0x0
}
define float @isZero(float %arg0) {
label_entry:
  %op1 = alloca float
  store float %arg0, float* %op1
  %op2 = load float, float* %op1
  %op3 = call float @abs(float %op2)
  %op4 = fcmp ult float %op3, 0x3eb0c6f7a0000000
  %op5 = sitofp i1 %op4 to float
  ret float %op5
}
define i32 @gauss(float* %arg0, float* %arg1, i32 %arg2) {
label_entry:
  %op3 = alloca float*
  store float* %arg0, float** %op3
  %op4 = alloca float*
  store float* %arg1, float** %op4
  %op5 = alloca i32
  store i32 %arg2, i32* %op5
  %op6 = load i32, i32* %op5
  %op7 = add i32 %op6, 1
  %op8 = load i32, i32* %op5
  %op9 = icmp slt i32 0, %op8
  br i1 %op9, label %label10, label %label13
label10:                                                ; preds = %label_entry, %label20
  %op11 = phi i32 [ 0, %label_entry ], [ %op22, %label20 ]
  %op12 = icmp sge i32 %op11, 0
  br i1 %op12, label %label16, label %label19
label13:                                                ; preds = %label_entry, %label20
  %op14 = load i32, i32* %op5
  %op15 = icmp slt i32 0, %op14
  br i1 %op15, label %label25, label %label31
label16:                                                ; preds = %label10
  %op17 = load float*, float** %op3
  %op18 = getelementptr float, float* %op17, i32 %op11
  br label %label20
label19:                                                ; preds = %label10
  call void @neg_idx_except()
  br label %label20
label20:                                                ; preds = %label16, %label19
  %op21 = sitofp i32 0 to float
  store float %op21, float* %op18
  %op22 = add i32 %op11, 1
  %op23 = load i32, i32* %op5
  %op24 = icmp slt i32 %op22, %op23
  br i1 %op24, label %label10, label %label13
label25:                                                ; preds = %label13, %label92
  %op26 = phi i32 [ 0, %label13 ], [ %op95, %label92 ]
  %op27 = phi i32 [ 0, %label13 ], [ %op94, %label92 ]
  %op28 = add i32 %op27, 1
  %op29 = load i32, i32* %op5
  %op30 = icmp slt i32 %op28, %op29
  br i1 %op30, label %label35, label %label45
label31:                                                ; preds = %label13, %label92
  %op32 = load i32, i32* %op5
  %op33 = sub i32 %op32, 1
  %op34 = icmp sge i32 %op33, 0
  br i1 %op34, label %label144, label %label152
label35:                                                ; preds = %label25, %label49
  %op36 = phi i32 [ %op27, %label25 ], [ %op50, %label49 ]
  %op37 = phi i32 [ %op28, %label25 ], [ %op51, %label49 ]
  %op38 = load float*, float** %op4
  %op39 = call float @get(float* %op38, i32 %op37, i32 %op26, i32 %op7)
  %op40 = call float @abs(float %op39)
  %op41 = load float*, float** %op4
  %op42 = call float @get(float* %op41, i32 %op36, i32 %op26, i32 %op7)
  %op43 = call float @abs(float %op42)
  %op44 = fcmp ugt float %op40, %op43
  br i1 %op44, label %label48, label %label49
label45:                                                ; preds = %label25, %label49
  %op46 = phi i32 [ %op27, %label25 ], [ %op50, %label49 ]
  %op47 = icmp ne i32 %op46, %op27
  br i1 %op47, label %label54, label %label56
label48:                                                ; preds = %label35
  br label %label49
label49:                                                ; preds = %label35, %label48
  %op50 = phi i32 [ %op36, %label35 ], [ %op37, %label48 ]
  %op51 = add i32 %op37, 1
  %op52 = load i32, i32* %op5
  %op53 = icmp slt i32 %op51, %op52
  br i1 %op53, label %label35, label %label45
label54:                                                ; preds = %label45
  %op55 = icmp slt i32 %op27, %op7
  br i1 %op55, label %label61, label %label68
label56:                                                ; preds = %label45, %label68
  %op57 = load float*, float** %op4
  %op58 = call float @get(float* %op57, i32 %op27, i32 %op26, i32 %op7)
  %op59 = call float @isZero(float %op58)
  %op60 = fcmp une float %op59, 0x0
  br i1 %op60, label %label86, label %label88
label61:                                                ; preds = %label54, %label83
  %op62 = phi i32 [ %op27, %label54 ], [ %op84, %label83 ]
  %op63 = load float*, float** %op4
  %op64 = call float @get(float* %op63, i32 %op27, i32 %op62, i32 %op7)
  %op65 = mul i32 %op27, %op7
  %op66 = add i32 %op65, %op62
  %op67 = icmp sge i32 %op66, 0
  br i1 %op67, label %label69, label %label72
label68:                                                ; preds = %label54, %label83
  br label %label56
label69:                                                ; preds = %label61
  %op70 = load float*, float** %op4
  %op71 = getelementptr float, float* %op70, i32 %op66
  br label %label73
label72:                                                ; preds = %label61
  call void @neg_idx_except()
  br label %label73
label73:                                                ; preds = %label69, %label72
  %op74 = load float*, float** %op4
  %op75 = call float @get(float* %op74, i32 %op46, i32 %op62, i32 %op7)
  store float %op75, float* %op71
  %op76 = mul i32 %op46, %op7
  %op77 = add i32 %op76, %op62
  %op78 = icmp sge i32 %op77, 0
  br i1 %op78, label %label79, label %label82
label79:                                                ; preds = %label73
  %op80 = load float*, float** %op4
  %op81 = getelementptr float, float* %op80, i32 %op77
  br label %label83
label82:                                                ; preds = %label73
  call void @neg_idx_except()
  br label %label83
label83:                                                ; preds = %label79, %label82
  store float %op64, float* %op81
  %op84 = add i32 %op62, 1
  %op85 = icmp slt i32 %op84, %op7
  br i1 %op85, label %label61, label %label68
label86:                                                ; preds = %label56
  %op87 = sub i32 %op27, 1
  br label %label92
label88:                                                ; preds = %label56
  %op89 = add i32 %op27, 1
  %op90 = load i32, i32* %op5
  %op91 = icmp slt i32 %op89, %op90
  br i1 %op91, label %label98, label %label106
label92:                                                ; preds = %label86, %label106
  %op93 = phi i32 [ %op87, %label86 ], [ %op27, %label106 ]
  %op94 = add i32 %op93, 1
  %op95 = add i32 %op26, 1
  %op96 = load i32, i32* %op5
  %op97 = icmp slt i32 %op94, %op96
  br i1 %op97, label %label25, label %label31
label98:                                                ; preds = %label88, %label114
  %op99 = phi i32 [ %op89, %label88 ], [ %op115, %label114 ]
  %op100 = load float*, float** %op4
  %op101 = call float @get(float* %op100, i32 %op99, i32 %op26, i32 %op7)
  %op102 = call float @isZero(float %op101)
  %op103 = sitofp i32 1 to float
  %op104 = fsub float %op103, %op102
  %op105 = fcmp une float %op104, 0x0
  br i1 %op105, label %label107, label %label114
label106:                                                ; preds = %label88, %label114
  br label %label92
label107:                                                ; preds = %label98
  %op108 = load float*, float** %op4
  %op109 = call float @get(float* %op108, i32 %op27, i32 %op26, i32 %op7)
  %op110 = load float*, float** %op4
  %op111 = call float @get(float* %op110, i32 %op99, i32 %op26, i32 %op7)
  %op112 = fdiv float %op111, %op109
  %op113 = icmp slt i32 %op26, %op7
  br i1 %op113, label %label118, label %label123
label114:                                                ; preds = %label98, %label123
  %op115 = add i32 %op99, 1
  %op116 = load i32, i32* %op5
  %op117 = icmp slt i32 %op115, %op116
  br i1 %op117, label %label98, label %label106
label118:                                                ; preds = %label107, %label140
  %op119 = phi i32 [ %op26, %label107 ], [ %op142, %label140 ]
  %op120 = mul i32 %op99, %op7
  %op121 = add i32 %op120, %op119
  %op122 = icmp sge i32 %op121, 0
  br i1 %op122, label %label124, label %label127
label123:                                                ; preds = %label107, %label140
  br label %label114
label124:                                                ; preds = %label118
  %op125 = load float*, float** %op4
  %op126 = getelementptr float, float* %op125, i32 %op121
  br label %label128
label127:                                                ; preds = %label118
  call void @neg_idx_except()
  br label %label128
label128:                                                ; preds = %label124, %label127
  %op129 = load float*, float** %op4
  %op130 = call float @get(float* %op129, i32 %op27, i32 %op119, i32 %op7)
  %op131 = fmul float %op130, %op112
  %op132 = mul i32 %op99, %op7
  %op133 = add i32 %op132, %op119
  %op134 = icmp sge i32 %op133, 0
  br i1 %op134, label %label135, label %label139
label135:                                                ; preds = %label128
  %op136 = load float*, float** %op4
  %op137 = getelementptr float, float* %op136, i32 %op133
  %op138 = load float, float* %op137
  br label %label140
label139:                                                ; preds = %label128
  call void @neg_idx_except()
  br label %label140
label140:                                                ; preds = %label135, %label139
  %op141 = fsub float %op138, %op131
  store float %op141, float* %op126
  %op142 = add i32 %op119, 1
  %op143 = icmp slt i32 %op142, %op7
  br i1 %op143, label %label118, label %label123
label144:                                                ; preds = %label31, %label186
  %op145 = phi i32 [ %op33, %label31 ], [ %op190, %label186 ]
  %op146 = load float*, float** %op4
  %op147 = load i32, i32* %op5
  %op148 = call float @get(float* %op146, i32 %op145, i32 %op147, i32 %op7)
  %op149 = add i32 %op145, 1
  %op150 = load i32, i32* %op5
  %op151 = icmp slt i32 %op149, %op150
  br i1 %op151, label %label153, label %label162
label152:                                                ; preds = %label31, %label186
  ret i32 0
label153:                                                ; preds = %label144, %label167
  %op154 = phi float [ %op148, %label144 ], [ %op168, %label167 ]
  %op155 = phi i32 [ %op149, %label144 ], [ %op169, %label167 ]
  %op156 = load float*, float** %op4
  %op157 = call float @get(float* %op156, i32 %op145, i32 %op155, i32 %op7)
  %op158 = call float @isZero(float %op157)
  %op159 = sitofp i32 1 to float
  %op160 = fsub float %op159, %op158
  %op161 = fcmp une float %op160, 0x0
  br i1 %op161, label %label165, label %label167
label162:                                                ; preds = %label144, %label167
  %op163 = phi float [ %op148, %label144 ], [ %op168, %label167 ]
  %op164 = icmp sge i32 %op145, 0
  br i1 %op164, label %label182, label %label185
label165:                                                ; preds = %label153
  %op166 = icmp sge i32 %op155, 0
  br i1 %op166, label %label172, label %label176
label167:                                                ; preds = %label153, %label177
  %op168 = phi float [ %op154, %label153 ], [ %op181, %label177 ]
  %op169 = add i32 %op155, 1
  %op170 = load i32, i32* %op5
  %op171 = icmp slt i32 %op169, %op170
  br i1 %op171, label %label153, label %label162
label172:                                                ; preds = %label165
  %op173 = load float*, float** %op3
  %op174 = getelementptr float, float* %op173, i32 %op155
  %op175 = load float, float* %op174
  br label %label177
label176:                                                ; preds = %label165
  call void @neg_idx_except()
  br label %label177
label177:                                                ; preds = %label172, %label176
  %op178 = load float*, float** %op4
  %op179 = call float @get(float* %op178, i32 %op145, i32 %op155, i32 %op7)
  %op180 = fmul float %op179, %op175
  %op181 = fsub float %op154, %op180
  br label %label167
label182:                                                ; preds = %label162
  %op183 = load float*, float** %op3
  %op184 = getelementptr float, float* %op183, i32 %op145
  br label %label186
label185:                                                ; preds = %label162
  call void @neg_idx_except()
  br label %label186
label186:                                                ; preds = %label182, %label185
  %op187 = load float*, float** %op4
  %op188 = call float @get(float* %op187, i32 %op145, i32 %op145, i32 %op7)
  %op189 = fdiv float %op163, %op188
  store float %op189, float* %op184
  %op190 = sub i32 %op145, 1
  %op191 = icmp sge i32 %op190, 0
  br i1 %op191, label %label144, label %label152
}
define void @main() {
label_entry:
  %op0 = alloca [3 x float]
  %op1 = alloca [12 x float]
  %op2 = icmp sge i32 0, 0
  br i1 %op2, label %label3, label %label5
label3:                                                ; preds = %label_entry
  %op4 = getelementptr [12 x float], [12 x float]* %op1, i32 0, i32 0
  br label %label6
label5:                                                ; preds = %label_entry
  call void @neg_idx_except()
  br label %label6
label6:                                                ; preds = %label3, %label5
  %op7 = sitofp i32 1 to float
  store float %op7, float* %op4
  %op8 = icmp sge i32 1, 0
  br i1 %op8, label %label9, label %label11
label9:                                                ; preds = %label6
  %op10 = getelementptr [12 x float], [12 x float]* %op1, i32 0, i32 1
  br label %label12
label11:                                                ; preds = %label6
  call void @neg_idx_except()
  br label %label12
label12:                                                ; preds = %label9, %label11
  %op13 = sitofp i32 2 to float
  store float %op13, float* %op10
  %op14 = icmp sge i32 2, 0
  br i1 %op14, label %label15, label %label17
label15:                                                ; preds = %label12
  %op16 = getelementptr [12 x float], [12 x float]* %op1, i32 0, i32 2
  br label %label18
label17:                                                ; preds = %label12
  call void @neg_idx_except()
  br label %label18
label18:                                                ; preds = %label15, %label17
  %op19 = sitofp i32 1 to float
  store float %op19, float* %op16
  %op20 = icmp sge i32 3, 0
  br i1 %op20, label %label21, label %label23
label21:                                                ; preds = %label18
  %op22 = getelementptr [12 x float], [12 x float]* %op1, i32 0, i32 3
  br label %label24
label23:                                                ; preds = %label18
  call void @neg_idx_except()
  br label %label24
label24:                                                ; preds = %label21, %label23
  %op25 = sitofp i32 1 to float
  store float %op25, float* %op22
  %op26 = mul i32 1, 4
  %op27 = add i32 %op26, 0
  %op28 = icmp sge i32 %op27, 0
  br i1 %op28, label %label29, label %label31
label29:                                                ; preds = %label24
  %op30 = getelementptr [12 x float], [12 x float]* %op1, i32 0, i32 %op27
  br label %label32
label31:                                                ; preds = %label24
  call void @neg_idx_except()
  br label %label32
label32:                                                ; preds = %label29, %label31
  %op33 = sitofp i32 2 to float
  store float %op33, float* %op30
  %op34 = mul i32 1, 4
  %op35 = add i32 %op34, 1
  %op36 = icmp sge i32 %op35, 0
  br i1 %op36, label %label37, label %label39
label37:                                                ; preds = %label32
  %op38 = getelementptr [12 x float], [12 x float]* %op1, i32 0, i32 %op35
  br label %label40
label39:                                                ; preds = %label32
  call void @neg_idx_except()
  br label %label40
label40:                                                ; preds = %label37, %label39
  %op41 = sitofp i32 3 to float
  store float %op41, float* %op38
  %op42 = mul i32 1, 4
  %op43 = add i32 %op42, 2
  %op44 = icmp sge i32 %op43, 0
  br i1 %op44, label %label45, label %label47
label45:                                                ; preds = %label40
  %op46 = getelementptr [12 x float], [12 x float]* %op1, i32 0, i32 %op43
  br label %label48
label47:                                                ; preds = %label40
  call void @neg_idx_except()
  br label %label48
label48:                                                ; preds = %label45, %label47
  %op49 = sitofp i32 4 to float
  store float %op49, float* %op46
  %op50 = mul i32 1, 4
  %op51 = add i32 %op50, 3
  %op52 = icmp sge i32 %op51, 0
  br i1 %op52, label %label53, label %label55
label53:                                                ; preds = %label48
  %op54 = getelementptr [12 x float], [12 x float]* %op1, i32 0, i32 %op51
  br label %label56
label55:                                                ; preds = %label48
  call void @neg_idx_except()
  br label %label56
label56:                                                ; preds = %label53, %label55
  %op57 = sitofp i32 3 to float
  store float %op57, float* %op54
  %op58 = mul i32 2, 4
  %op59 = add i32 %op58, 0
  %op60 = icmp sge i32 %op59, 0
  br i1 %op60, label %label61, label %label63
label61:                                                ; preds = %label56
  %op62 = getelementptr [12 x float], [12 x float]* %op1, i32 0, i32 %op59
  br label %label64
label63:                                                ; preds = %label56
  call void @neg_idx_except()
  br label %label64
label64:                                                ; preds = %label61, %label63
  %op65 = sitofp i32 1 to float
  store float %op65, float* %op62
  %op66 = mul i32 2, 4
  %op67 = add i32 %op66, 1
  %op68 = icmp sge i32 %op67, 0
  br i1 %op68, label %label69, label %label71
label69:                                                ; preds = %label64
  %op70 = getelementptr [12 x float], [12 x float]* %op1, i32 0, i32 %op67
  br label %label72
label71:                                                ; preds = %label64
  call void @neg_idx_except()
  br label %label72
label72:                                                ; preds = %label69, %label71
  %op73 = sitofp i32 1 to float
  store float %op73, float* %op70
  %op74 = mul i32 2, 4
  %op75 = add i32 %op74, 2
  %op76 = icmp sge i32 %op75, 0
  br i1 %op76, label %label77, label %label79
label77:                                                ; preds = %label72
  %op78 = getelementptr [12 x float], [12 x float]* %op1, i32 0, i32 %op75
  br label %label80
label79:                                                ; preds = %label72
  call void @neg_idx_except()
  br label %label80
label80:                                                ; preds = %label77, %label79
  %op81 = sub i32 0, 2
  %op82 = sitofp i32 %op81 to float
  store float %op82, float* %op78
  %op83 = mul i32 2, 4
  %op84 = add i32 %op83, 3
  %op85 = icmp sge i32 %op84, 0
  br i1 %op85, label %label86, label %label88
label86:                                                ; preds = %label80
  %op87 = getelementptr [12 x float], [12 x float]* %op1, i32 0, i32 %op84
  br label %label89
label88:                                                ; preds = %label80
  call void @neg_idx_except()
  br label %label89
label89:                                                ; preds = %label86, %label88
  %op90 = sitofp i32 0 to float
  store float %op90, float* %op87
  %op91 = getelementptr [3 x float], [3 x float]* %op0, i32 0, i32 0
  %op92 = getelementptr [12 x float], [12 x float]* %op1, i32 0, i32 0
  %op93 = call i32 @gauss(float* %op91, float* %op92, i32 3)
  %op94 = icmp slt i32 0, 3
  br i1 %op94, label %label95, label %label98
label95:                                                ; preds = %label89, %label103
  %op96 = phi i32 [ 0, %label89 ], [ %op104, %label103 ]
  %op97 = icmp sge i32 %op96, 0
  br i1 %op97, label %label99, label %label102
label98:                                                ; preds = %label89, %label103
  ret void
label99:                                                ; preds = %label95
  %op100 = getelementptr [3 x float], [3 x float]* %op0, i32 0, i32 %op96
  %op101 = load float, float* %op100
  br label %label103
label102:                                                ; preds = %label95
  call void @neg_idx_except()
  br label %label103
label103:                                                ; preds = %label99, %label102
  call void @outputFloat(float %op101)
  %op104 = add i32 %op96, 1
  %op105 = icmp slt i32 %op104, 3
  br i1 %op105, label %label95, label %label98
}
