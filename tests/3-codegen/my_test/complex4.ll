; ModuleID = 'cminus'
source_filename = "/home/hzw/桌面/2023ustc-jianmu-compiler/tests/3-codegen/my_test/complex4.cminus"

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
  %op6 = alloca i32
  %op7 = alloca i32
  %op8 = alloca i32
  %op9 = alloca i32
  %op10 = alloca i32
  %op11 = alloca i32
  %op12 = alloca float
  %op13 = load i32, i32* %op5
  %op14 = add i32 %op13, 1
  store i32 %op14, i32* %op9
  store i32 0, i32* %op6
  %op15 = load i32, i32* %op6
  %op16 = load i32, i32* %op5
  %op17 = icmp slt i32 %op15, %op16
  br i1 %op17, label %label18, label %label21
label18:                                                ; preds = %label_entry, %label29
  %op19 = load i32, i32* %op6
  %op20 = icmp sge i32 %op19, 0
  br i1 %op20, label %label25, label %label28
label21:                                                ; preds = %label_entry, %label29
  store i32 0, i32* %op11
  store i32 0, i32* %op8
  %op22 = load i32, i32* %op8
  %op23 = load i32, i32* %op5
  %op24 = icmp slt i32 %op22, %op23
  br i1 %op24, label %label36, label %label43
label25:                                                ; preds = %label18
  %op26 = load float*, float** %op3
  %op27 = getelementptr float, float* %op26, i32 %op19
  br label %label29
label28:                                                ; preds = %label18
  call void @neg_idx_except()
  br label %label29
label29:                                                ; preds = %label25, %label28
  %op30 = sitofp i32 0 to float
  store float %op30, float* %op27
  %op31 = load i32, i32* %op6
  %op32 = add i32 %op31, 1
  store i32 %op32, i32* %op6
  %op33 = load i32, i32* %op6
  %op34 = load i32, i32* %op5
  %op35 = icmp slt i32 %op33, %op34
  br i1 %op35, label %label18, label %label21
label36:                                                ; preds = %label21, %label136
  %op37 = load i32, i32* %op8
  store i32 %op37, i32* %op10
  %op38 = load i32, i32* %op8
  %op39 = add i32 %op38, 1
  store i32 %op39, i32* %op6
  %op40 = load i32, i32* %op6
  %op41 = load i32, i32* %op5
  %op42 = icmp slt i32 %op40, %op41
  br i1 %op42, label %label48, label %label62
label43:                                                ; preds = %label21, %label136
  %op44 = load i32, i32* %op5
  %op45 = sub i32 %op44, 1
  store i32 %op45, i32* %op6
  %op46 = load i32, i32* %op6
  %op47 = icmp sge i32 %op46, 0
  br i1 %op47, label %label215, label %label226
label48:                                                ; preds = %label36, %label68
  %op49 = load float*, float** %op4
  %op50 = load i32, i32* %op6
  %op51 = load i32, i32* %op11
  %op52 = load i32, i32* %op9
  %op53 = call float @get(float* %op49, i32 %op50, i32 %op51, i32 %op52)
  %op54 = call float @abs(float %op53)
  %op55 = load float*, float** %op4
  %op56 = load i32, i32* %op10
  %op57 = load i32, i32* %op11
  %op58 = load i32, i32* %op9
  %op59 = call float @get(float* %op55, i32 %op56, i32 %op57, i32 %op58)
  %op60 = call float @abs(float %op59)
  %op61 = fcmp ugt float %op54, %op60
  br i1 %op61, label %label66, label %label68
label62:                                                ; preds = %label36, %label68
  %op63 = load i32, i32* %op10
  %op64 = load i32, i32* %op8
  %op65 = icmp ne i32 %op63, %op64
  br i1 %op65, label %label74, label %label79
label66:                                                ; preds = %label48
  %op67 = load i32, i32* %op6
  store i32 %op67, i32* %op10
  br label %label68
label68:                                                ; preds = %label48, %label66
  %op69 = load i32, i32* %op6
  %op70 = add i32 %op69, 1
  store i32 %op70, i32* %op6
  %op71 = load i32, i32* %op6
  %op72 = load i32, i32* %op5
  %op73 = icmp slt i32 %op71, %op72
  br i1 %op73, label %label48, label %label62
label74:                                                ; preds = %label62
  %op75 = load i32, i32* %op8
  store i32 %op75, i32* %op7
  %op76 = load i32, i32* %op7
  %op77 = load i32, i32* %op9
  %op78 = icmp slt i32 %op76, %op77
  br i1 %op78, label %label87, label %label99
label79:                                                ; preds = %label62, %label99
  %op80 = load float*, float** %op4
  %op81 = load i32, i32* %op8
  %op82 = load i32, i32* %op11
  %op83 = load i32, i32* %op9
  %op84 = call float @get(float* %op80, i32 %op81, i32 %op82, i32 %op83)
  %op85 = call float @isZero(float %op84)
  %op86 = fcmp une float %op85, 0x0
  br i1 %op86, label %label127, label %label130
label87:                                                ; preds = %label74, %label120
  %op88 = load float*, float** %op4
  %op89 = load i32, i32* %op8
  %op90 = load i32, i32* %op7
  %op91 = load i32, i32* %op9
  %op92 = call float @get(float* %op88, i32 %op89, i32 %op90, i32 %op91)
  store float %op92, float* %op12
  %op93 = load i32, i32* %op7
  %op94 = load i32, i32* %op9
  %op95 = load i32, i32* %op8
  %op96 = mul i32 %op95, %op94
  %op97 = add i32 %op96, %op93
  %op98 = icmp sge i32 %op97, 0
  br i1 %op98, label %label100, label %label103
label99:                                                ; preds = %label74, %label120
  br label %label79
label100:                                                ; preds = %label87
  %op101 = load float*, float** %op4
  %op102 = getelementptr float, float* %op101, i32 %op97
  br label %label104
label103:                                                ; preds = %label87
  call void @neg_idx_except()
  br label %label104
label104:                                                ; preds = %label100, %label103
  %op105 = load float*, float** %op4
  %op106 = load i32, i32* %op10
  %op107 = load i32, i32* %op7
  %op108 = load i32, i32* %op9
  %op109 = call float @get(float* %op105, i32 %op106, i32 %op107, i32 %op108)
  store float %op109, float* %op102
  %op110 = load i32, i32* %op7
  %op111 = load i32, i32* %op9
  %op112 = load i32, i32* %op10
  %op113 = mul i32 %op112, %op111
  %op114 = add i32 %op113, %op110
  %op115 = icmp sge i32 %op114, 0
  br i1 %op115, label %label116, label %label119
label116:                                                ; preds = %label104
  %op117 = load float*, float** %op4
  %op118 = getelementptr float, float* %op117, i32 %op114
  br label %label120
label119:                                                ; preds = %label104
  call void @neg_idx_except()
  br label %label120
label120:                                                ; preds = %label116, %label119
  %op121 = load float, float* %op12
  store float %op121, float* %op118
  %op122 = load i32, i32* %op7
  %op123 = add i32 %op122, 1
  store i32 %op123, i32* %op7
  %op124 = load i32, i32* %op7
  %op125 = load i32, i32* %op9
  %op126 = icmp slt i32 %op124, %op125
  br i1 %op126, label %label87, label %label99
label127:                                                ; preds = %label79
  %op128 = load i32, i32* %op8
  %op129 = sub i32 %op128, 1
  store i32 %op129, i32* %op8
  br label %label136
label130:                                                ; preds = %label79
  %op131 = load i32, i32* %op8
  %op132 = add i32 %op131, 1
  store i32 %op132, i32* %op6
  %op133 = load i32, i32* %op6
  %op134 = load i32, i32* %op5
  %op135 = icmp slt i32 %op133, %op134
  br i1 %op135, label %label144, label %label154
label136:                                                ; preds = %label127, %label154
  %op137 = load i32, i32* %op8
  %op138 = add i32 %op137, 1
  store i32 %op138, i32* %op8
  %op139 = load i32, i32* %op11
  %op140 = add i32 %op139, 1
  store i32 %op140, i32* %op11
  %op141 = load i32, i32* %op8
  %op142 = load i32, i32* %op5
  %op143 = icmp slt i32 %op141, %op142
  br i1 %op143, label %label36, label %label43
label144:                                                ; preds = %label130, %label171
  %op145 = load float*, float** %op4
  %op146 = load i32, i32* %op6
  %op147 = load i32, i32* %op11
  %op148 = load i32, i32* %op9
  %op149 = call float @get(float* %op145, i32 %op146, i32 %op147, i32 %op148)
  %op150 = call float @isZero(float %op149)
  %op151 = sitofp i32 1 to float
  %op152 = fsub float %op151, %op150
  %op153 = fcmp une float %op152, 0x0
  br i1 %op153, label %label155, label %label171
label154:                                                ; preds = %label130, %label171
  br label %label136
label155:                                                ; preds = %label144
  %op156 = load float*, float** %op4
  %op157 = load i32, i32* %op8
  %op158 = load i32, i32* %op11
  %op159 = load i32, i32* %op9
  %op160 = call float @get(float* %op156, i32 %op157, i32 %op158, i32 %op159)
  %op161 = load float*, float** %op4
  %op162 = load i32, i32* %op6
  %op163 = load i32, i32* %op11
  %op164 = load i32, i32* %op9
  %op165 = call float @get(float* %op161, i32 %op162, i32 %op163, i32 %op164)
  %op166 = fdiv float %op165, %op160
  store float %op166, float* %op12
  %op167 = load i32, i32* %op11
  store i32 %op167, i32* %op7
  %op168 = load i32, i32* %op7
  %op169 = load i32, i32* %op9
  %op170 = icmp slt i32 %op168, %op169
  br i1 %op170, label %label177, label %label184
label171:                                                ; preds = %label144, %label184
  %op172 = load i32, i32* %op6
  %op173 = add i32 %op172, 1
  store i32 %op173, i32* %op6
  %op174 = load i32, i32* %op6
  %op175 = load i32, i32* %op5
  %op176 = icmp slt i32 %op174, %op175
  br i1 %op176, label %label144, label %label154
label177:                                                ; preds = %label155, %label208
  %op178 = load i32, i32* %op7
  %op179 = load i32, i32* %op9
  %op180 = load i32, i32* %op6
  %op181 = mul i32 %op180, %op179
  %op182 = add i32 %op181, %op178
  %op183 = icmp sge i32 %op182, 0
  br i1 %op183, label %label185, label %label188
label184:                                                ; preds = %label155, %label208
  br label %label171
label185:                                                ; preds = %label177
  %op186 = load float*, float** %op4
  %op187 = getelementptr float, float* %op186, i32 %op182
  br label %label189
label188:                                                ; preds = %label177
  call void @neg_idx_except()
  br label %label189
label189:                                                ; preds = %label185, %label188
  %op190 = load float, float* %op12
  %op191 = load float*, float** %op4
  %op192 = load i32, i32* %op8
  %op193 = load i32, i32* %op7
  %op194 = load i32, i32* %op9
  %op195 = call float @get(float* %op191, i32 %op192, i32 %op193, i32 %op194)
  %op196 = fmul float %op195, %op190
  %op197 = load i32, i32* %op7
  %op198 = load i32, i32* %op9
  %op199 = load i32, i32* %op6
  %op200 = mul i32 %op199, %op198
  %op201 = add i32 %op200, %op197
  %op202 = icmp sge i32 %op201, 0
  br i1 %op202, label %label203, label %label207
label203:                                                ; preds = %label189
  %op204 = load float*, float** %op4
  %op205 = getelementptr float, float* %op204, i32 %op201
  %op206 = load float, float* %op205
  br label %label208
label207:                                                ; preds = %label189
  call void @neg_idx_except()
  br label %label208
label208:                                                ; preds = %label203, %label207
  %op209 = fsub float %op206, %op196
  store float %op209, float* %op187
  %op210 = load i32, i32* %op7
  %op211 = add i32 %op210, 1
  store i32 %op211, i32* %op7
  %op212 = load i32, i32* %op7
  %op213 = load i32, i32* %op9
  %op214 = icmp slt i32 %op212, %op213
  br i1 %op214, label %label177, label %label184
label215:                                                ; preds = %label43, %label267
  %op216 = load float*, float** %op4
  %op217 = load i32, i32* %op6
  %op218 = load i32, i32* %op5
  %op219 = load i32, i32* %op9
  %op220 = call float @get(float* %op216, i32 %op217, i32 %op218, i32 %op219)
  store float %op220, float* %op12
  %op221 = load i32, i32* %op6
  %op222 = add i32 %op221, 1
  store i32 %op222, i32* %op7
  %op223 = load i32, i32* %op7
  %op224 = load i32, i32* %op5
  %op225 = icmp slt i32 %op223, %op224
  br i1 %op225, label %label227, label %label237
label226:                                                ; preds = %label43, %label267
  ret i32 0
label227:                                                ; preds = %label215, %label243
  %op228 = load float*, float** %op4
  %op229 = load i32, i32* %op6
  %op230 = load i32, i32* %op7
  %op231 = load i32, i32* %op9
  %op232 = call float @get(float* %op228, i32 %op229, i32 %op230, i32 %op231)
  %op233 = call float @isZero(float %op232)
  %op234 = sitofp i32 1 to float
  %op235 = fsub float %op234, %op233
  %op236 = fcmp une float %op235, 0x0
  br i1 %op236, label %label240, label %label243
label237:                                                ; preds = %label215, %label243
  %op238 = load i32, i32* %op6
  %op239 = icmp sge i32 %op238, 0
  br i1 %op239, label %label263, label %label266
label240:                                                ; preds = %label227
  %op241 = load i32, i32* %op7
  %op242 = icmp sge i32 %op241, 0
  br i1 %op242, label %label249, label %label253
label243:                                                ; preds = %label227, %label254
  %op244 = load i32, i32* %op7
  %op245 = add i32 %op244, 1
  store i32 %op245, i32* %op7
  %op246 = load i32, i32* %op7
  %op247 = load i32, i32* %op5
  %op248 = icmp slt i32 %op246, %op247
  br i1 %op248, label %label227, label %label237
label249:                                                ; preds = %label240
  %op250 = load float*, float** %op3
  %op251 = getelementptr float, float* %op250, i32 %op241
  %op252 = load float, float* %op251
  br label %label254
label253:                                                ; preds = %label240
  call void @neg_idx_except()
  br label %label254
label254:                                                ; preds = %label249, %label253
  %op255 = load float*, float** %op4
  %op256 = load i32, i32* %op6
  %op257 = load i32, i32* %op7
  %op258 = load i32, i32* %op9
  %op259 = call float @get(float* %op255, i32 %op256, i32 %op257, i32 %op258)
  %op260 = fmul float %op259, %op252
  %op261 = load float, float* %op12
  %op262 = fsub float %op261, %op260
  store float %op262, float* %op12
  br label %label243
label263:                                                ; preds = %label237
  %op264 = load float*, float** %op3
  %op265 = getelementptr float, float* %op264, i32 %op238
  br label %label267
label266:                                                ; preds = %label237
  call void @neg_idx_except()
  br label %label267
label267:                                                ; preds = %label263, %label266
  %op268 = load float*, float** %op4
  %op269 = load i32, i32* %op6
  %op270 = load i32, i32* %op6
  %op271 = load i32, i32* %op9
  %op272 = call float @get(float* %op268, i32 %op269, i32 %op270, i32 %op271)
  %op273 = load float, float* %op12
  %op274 = fdiv float %op273, %op272
  store float %op274, float* %op265
  %op275 = load i32, i32* %op6
  %op276 = sub i32 %op275, 1
  store i32 %op276, i32* %op6
  %op277 = load i32, i32* %op6
  %op278 = icmp sge i32 %op277, 0
  br i1 %op278, label %label215, label %label226
}
define void @main() {
label_entry:
  %op0 = alloca i32
  %op1 = alloca [3 x float]
  %op2 = alloca [12 x float]
  %op3 = icmp sge i32 0, 0
  br i1 %op3, label %label4, label %label6
label4:                                                ; preds = %label_entry
  %op5 = getelementptr [12 x float], [12 x float]* %op2, i32 0, i32 0
  br label %label7
label6:                                                ; preds = %label_entry
  call void @neg_idx_except()
  br label %label7
label7:                                                ; preds = %label4, %label6
  %op8 = sitofp i32 1 to float
  store float %op8, float* %op5
  %op9 = icmp sge i32 1, 0
  br i1 %op9, label %label10, label %label12
label10:                                                ; preds = %label7
  %op11 = getelementptr [12 x float], [12 x float]* %op2, i32 0, i32 1
  br label %label13
label12:                                                ; preds = %label7
  call void @neg_idx_except()
  br label %label13
label13:                                                ; preds = %label10, %label12
  %op14 = sitofp i32 2 to float
  store float %op14, float* %op11
  %op15 = icmp sge i32 2, 0
  br i1 %op15, label %label16, label %label18
label16:                                                ; preds = %label13
  %op17 = getelementptr [12 x float], [12 x float]* %op2, i32 0, i32 2
  br label %label19
label18:                                                ; preds = %label13
  call void @neg_idx_except()
  br label %label19
label19:                                                ; preds = %label16, %label18
  %op20 = sitofp i32 1 to float
  store float %op20, float* %op17
  %op21 = icmp sge i32 3, 0
  br i1 %op21, label %label22, label %label24
label22:                                                ; preds = %label19
  %op23 = getelementptr [12 x float], [12 x float]* %op2, i32 0, i32 3
  br label %label25
label24:                                                ; preds = %label19
  call void @neg_idx_except()
  br label %label25
label25:                                                ; preds = %label22, %label24
  %op26 = sitofp i32 1 to float
  store float %op26, float* %op23
  %op27 = mul i32 1, 4
  %op28 = add i32 %op27, 0
  %op29 = icmp sge i32 %op28, 0
  br i1 %op29, label %label30, label %label32
label30:                                                ; preds = %label25
  %op31 = getelementptr [12 x float], [12 x float]* %op2, i32 0, i32 %op28
  br label %label33
label32:                                                ; preds = %label25
  call void @neg_idx_except()
  br label %label33
label33:                                                ; preds = %label30, %label32
  %op34 = sitofp i32 2 to float
  store float %op34, float* %op31
  %op35 = mul i32 1, 4
  %op36 = add i32 %op35, 1
  %op37 = icmp sge i32 %op36, 0
  br i1 %op37, label %label38, label %label40
label38:                                                ; preds = %label33
  %op39 = getelementptr [12 x float], [12 x float]* %op2, i32 0, i32 %op36
  br label %label41
label40:                                                ; preds = %label33
  call void @neg_idx_except()
  br label %label41
label41:                                                ; preds = %label38, %label40
  %op42 = sitofp i32 3 to float
  store float %op42, float* %op39
  %op43 = mul i32 1, 4
  %op44 = add i32 %op43, 2
  %op45 = icmp sge i32 %op44, 0
  br i1 %op45, label %label46, label %label48
label46:                                                ; preds = %label41
  %op47 = getelementptr [12 x float], [12 x float]* %op2, i32 0, i32 %op44
  br label %label49
label48:                                                ; preds = %label41
  call void @neg_idx_except()
  br label %label49
label49:                                                ; preds = %label46, %label48
  %op50 = sitofp i32 4 to float
  store float %op50, float* %op47
  %op51 = mul i32 1, 4
  %op52 = add i32 %op51, 3
  %op53 = icmp sge i32 %op52, 0
  br i1 %op53, label %label54, label %label56
label54:                                                ; preds = %label49
  %op55 = getelementptr [12 x float], [12 x float]* %op2, i32 0, i32 %op52
  br label %label57
label56:                                                ; preds = %label49
  call void @neg_idx_except()
  br label %label57
label57:                                                ; preds = %label54, %label56
  %op58 = sitofp i32 3 to float
  store float %op58, float* %op55
  %op59 = mul i32 2, 4
  %op60 = add i32 %op59, 0
  %op61 = icmp sge i32 %op60, 0
  br i1 %op61, label %label62, label %label64
label62:                                                ; preds = %label57
  %op63 = getelementptr [12 x float], [12 x float]* %op2, i32 0, i32 %op60
  br label %label65
label64:                                                ; preds = %label57
  call void @neg_idx_except()
  br label %label65
label65:                                                ; preds = %label62, %label64
  %op66 = sitofp i32 1 to float
  store float %op66, float* %op63
  %op67 = mul i32 2, 4
  %op68 = add i32 %op67, 1
  %op69 = icmp sge i32 %op68, 0
  br i1 %op69, label %label70, label %label72
label70:                                                ; preds = %label65
  %op71 = getelementptr [12 x float], [12 x float]* %op2, i32 0, i32 %op68
  br label %label73
label72:                                                ; preds = %label65
  call void @neg_idx_except()
  br label %label73
label73:                                                ; preds = %label70, %label72
  %op74 = sitofp i32 1 to float
  store float %op74, float* %op71
  %op75 = mul i32 2, 4
  %op76 = add i32 %op75, 2
  %op77 = icmp sge i32 %op76, 0
  br i1 %op77, label %label78, label %label80
label78:                                                ; preds = %label73
  %op79 = getelementptr [12 x float], [12 x float]* %op2, i32 0, i32 %op76
  br label %label81
label80:                                                ; preds = %label73
  call void @neg_idx_except()
  br label %label81
label81:                                                ; preds = %label78, %label80
  %op82 = sub i32 0, 2
  %op83 = sitofp i32 %op82 to float
  store float %op83, float* %op79
  %op84 = mul i32 2, 4
  %op85 = add i32 %op84, 3
  %op86 = icmp sge i32 %op85, 0
  br i1 %op86, label %label87, label %label89
label87:                                                ; preds = %label81
  %op88 = getelementptr [12 x float], [12 x float]* %op2, i32 0, i32 %op85
  br label %label90
label89:                                                ; preds = %label81
  call void @neg_idx_except()
  br label %label90
label90:                                                ; preds = %label87, %label89
  %op91 = sitofp i32 0 to float
  store float %op91, float* %op88
  %op92 = getelementptr [3 x float], [3 x float]* %op1, i32 0, i32 0
  %op93 = getelementptr [12 x float], [12 x float]* %op2, i32 0, i32 0
  %op94 = call i32 @gauss(float* %op92, float* %op93, i32 3)
  store i32 0, i32* %op0
  %op95 = load i32, i32* %op0
  %op96 = icmp slt i32 %op95, 3
  br i1 %op96, label %label97, label %label100
label97:                                                ; preds = %label90, %label105
  %op98 = load i32, i32* %op0
  %op99 = icmp sge i32 %op98, 0
  br i1 %op99, label %label101, label %label104
label100:                                                ; preds = %label90, %label105
  ret void
label101:                                                ; preds = %label97
  %op102 = getelementptr [3 x float], [3 x float]* %op1, i32 0, i32 %op98
  %op103 = load float, float* %op102
  br label %label105
label104:                                                ; preds = %label97
  call void @neg_idx_except()
  br label %label105
label105:                                                ; preds = %label101, %label104
  call void @outputFloat(float %op103)
  %op106 = load i32, i32* %op0
  %op107 = add i32 %op106, 1
  store i32 %op107, i32* %op0
  %op108 = load i32, i32* %op0
  %op109 = icmp slt i32 %op108, 3
  br i1 %op109, label %label97, label %label100
}
