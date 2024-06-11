	.text
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -368
.main_label_entry:
# %op0 = alloca i32
	addi.d $t8, $fp, -28
	addi.d $t7, $fp, -24
	st.d $t8, $t7, 0
# %op1 = alloca i32
	addi.d $t8, $fp, -44
	addi.d $t7, $fp, -40
	st.d $t8, $t7, 0
# %op2 = alloca i32
	addi.d $t8, $fp, -60
	addi.d $t7, $fp, -56
	st.d $t8, $t7, 0
# %op3 = alloca i32
	addi.d $t8, $fp, -76
	addi.d $t7, $fp, -72
	st.d $t8, $t7, 0
# %op4 = alloca i32
	addi.d $t8, $fp, -92
	addi.d $t7, $fp, -88
	st.d $t8, $t7, 0
# %op5 = alloca i32
	addi.d $t8, $fp, -108
	addi.d $t7, $fp, -104
	st.d $t8, $t7, 0
# %op6 = alloca i32
	addi.d $t8, $fp, -124
	addi.d $t7, $fp, -120
	st.d $t8, $t7, 0
# %op7 = call i32 @input()
	bl input
	st.w $a0, $fp, -128
# store i32 %op7, i32* %op6
	ld.w $t7, $fp, -128
	ld.d $t8, $fp, -120
	st.w $t7, $t8, 0
# store i32 0, i32* %op0
	addi.w $t7, $zero, 0
	ld.d $t8, $fp, -24
	st.w $t7, $t8, 0
# store i32 0, i32* %op1
	addi.w $t7, $zero, 0
	ld.d $t8, $fp, -40
	st.w $t7, $t8, 0
# store i32 0, i32* %op5
	addi.w $t7, $zero, 0
	ld.d $t8, $fp, -104
	st.w $t7, $t8, 0
# %op8 = load i32, i32* %op0
	ld.d $t8, $fp, -24
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -132
# %op9 = load i32, i32* %op6
	ld.d $t8, $fp, -120
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -136
# %op10 = icmp slt i32 %op8, %op9
	ld.w $t7, $fp, -132
	ld.w $t8, $fp, -136
	slt $t7, $t7, $t8
	st.b $t7, $fp, -137
# br i1 %op10, label %label11, label %label66
	ld.b $t7, $fp, -137
	bnez $t7, .main_label11
	b .main_label66
.main_label11:
# %op12 = fmul float 0x3ff3c0c200000000, 0x4016f06a20000000
	lu12i.w $t8, 260576
	ori $t8, $t8, 1552
	movgr2fr.w $ft14, $t8
	lu12i.w $t8, 265080
	ori $t8, $t8, 849
	movgr2fr.w $ft15, $t8
	fmul.s $ft14, $ft14, $ft15
	fst.s $ft14, $fp, -144
# %op13 = fmul float %op12, 0x4002aa9940000000
	fld.s $ft14, $fp, -144
	lu12i.w $t8, 262485
	ori $t8, $t8, 1226
	movgr2fr.w $ft15, $t8
	fmul.s $ft14, $ft14, $ft15
	fst.s $ft14, $fp, -148
# %op14 = fmul float %op13, 0x4011781d80000000
	fld.s $ft14, $fp, -148
	lu12i.w $t8, 264380
	ori $t8, $t8, 236
	movgr2fr.w $ft15, $t8
	fmul.s $ft14, $ft14, $ft15
	fst.s $ft14, $fp, -152
# %op15 = fmul float %op14, 0x401962ac40000000
	fld.s $ft14, $fp, -152
	lu12i.w $t8, 265393
	ori $t8, $t8, 1378
	movgr2fr.w $ft15, $t8
	fmul.s $ft14, $ft14, $ft15
	fst.s $ft14, $fp, -156
# %op16 = fptosi float %op15 to i32
	fld.s $ft14, $fp, -156
	ftintrz.w.s $ft15, $ft14
	movfr2gr.s $t7, $ft15
	st.w $t7, $fp, -160
# store i32 %op16, i32* %op1
	ld.w $t7, $fp, -160
	ld.d $t8, $fp, -40
	st.w $t7, $t8, 0
# %op17 = load i32, i32* %op1
	ld.d $t8, $fp, -40
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -164
# %op18 = load i32, i32* %op1
	ld.d $t8, $fp, -40
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -168
# %op19 = load i32, i32* %op1
	ld.d $t8, $fp, -40
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -172
# %op20 = load i32, i32* %op1
	ld.d $t8, $fp, -40
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -176
# %op21 = load i32, i32* %op1
	ld.d $t8, $fp, -40
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -180
# %op22 = load i32, i32* %op1
	ld.d $t8, $fp, -40
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -184
# %op23 = mul i32 %op22, %op21
	ld.w $t7, $fp, -184
	ld.w $t8, $fp, -180
	mul.w $t7, $t7, $t8
	st.w $t7, $fp, -188
# %op24 = mul i32 %op23, %op20
	ld.w $t7, $fp, -188
	ld.w $t8, $fp, -176
	mul.w $t7, $t7, $t8
	st.w $t7, $fp, -192
# %op25 = mul i32 %op24, %op19
	ld.w $t7, $fp, -192
	ld.w $t8, $fp, -172
	mul.w $t7, $t7, $t8
	st.w $t7, $fp, -196
# %op26 = mul i32 %op25, %op18
	ld.w $t7, $fp, -196
	ld.w $t8, $fp, -168
	mul.w $t7, $t7, $t8
	st.w $t7, $fp, -200
# %op27 = mul i32 %op26, %op17
	ld.w $t7, $fp, -200
	ld.w $t8, $fp, -164
	mul.w $t7, $t7, $t8
	st.w $t7, $fp, -204
# store i32 %op27, i32* %op2
	ld.w $t7, $fp, -204
	ld.d $t8, $fp, -56
	st.w $t7, $t8, 0
# %op28 = load i32, i32* %op2
	ld.d $t8, $fp, -56
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -208
# %op29 = load i32, i32* %op2
	ld.d $t8, $fp, -56
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -212
# %op30 = load i32, i32* %op2
	ld.d $t8, $fp, -56
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -216
# %op31 = load i32, i32* %op2
	ld.d $t8, $fp, -56
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -220
# %op32 = load i32, i32* %op2
	ld.d $t8, $fp, -56
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -224
# %op33 = load i32, i32* %op2
	ld.d $t8, $fp, -56
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -228
# %op34 = mul i32 %op33, %op32
	ld.w $t7, $fp, -228
	ld.w $t8, $fp, -224
	mul.w $t7, $t7, $t8
	st.w $t7, $fp, -232
# %op35 = mul i32 %op34, %op31
	ld.w $t7, $fp, -232
	ld.w $t8, $fp, -220
	mul.w $t7, $t7, $t8
	st.w $t7, $fp, -236
# %op36 = mul i32 %op35, %op30
	ld.w $t7, $fp, -236
	ld.w $t8, $fp, -216
	mul.w $t7, $t7, $t8
	st.w $t7, $fp, -240
# %op37 = mul i32 %op36, %op29
	ld.w $t7, $fp, -240
	ld.w $t8, $fp, -212
	mul.w $t7, $t7, $t8
	st.w $t7, $fp, -244
# %op38 = mul i32 %op37, %op28
	ld.w $t7, $fp, -244
	ld.w $t8, $fp, -208
	mul.w $t7, $t7, $t8
	st.w $t7, $fp, -248
# store i32 %op38, i32* %op3
	ld.w $t7, $fp, -248
	ld.d $t8, $fp, -72
	st.w $t7, $t8, 0
# %op39 = load i32, i32* %op3
	ld.d $t8, $fp, -72
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -252
# %op40 = load i32, i32* %op3
	ld.d $t8, $fp, -72
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -256
# %op41 = load i32, i32* %op3
	ld.d $t8, $fp, -72
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -260
# %op42 = load i32, i32* %op3
	ld.d $t8, $fp, -72
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -264
# %op43 = load i32, i32* %op3
	ld.d $t8, $fp, -72
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -268
# %op44 = load i32, i32* %op3
	ld.d $t8, $fp, -72
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -272
# %op45 = mul i32 %op44, %op43
	ld.w $t7, $fp, -272
	ld.w $t8, $fp, -268
	mul.w $t7, $t7, $t8
	st.w $t7, $fp, -276
# %op46 = mul i32 %op45, %op42
	ld.w $t7, $fp, -276
	ld.w $t8, $fp, -264
	mul.w $t7, $t7, $t8
	st.w $t7, $fp, -280
# %op47 = mul i32 %op46, %op41
	ld.w $t7, $fp, -280
	ld.w $t8, $fp, -260
	mul.w $t7, $t7, $t8
	st.w $t7, $fp, -284
# %op48 = mul i32 %op47, %op40
	ld.w $t7, $fp, -284
	ld.w $t8, $fp, -256
	mul.w $t7, $t7, $t8
	st.w $t7, $fp, -288
# %op49 = mul i32 %op48, %op39
	ld.w $t7, $fp, -288
	ld.w $t8, $fp, -252
	mul.w $t7, $t7, $t8
	st.w $t7, $fp, -292
# store i32 %op49, i32* %op4
	ld.w $t7, $fp, -292
	ld.d $t8, $fp, -88
	st.w $t7, $t8, 0
# %op50 = load i32, i32* %op4
	ld.d $t8, $fp, -88
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -296
# %op51 = load i32, i32* %op4
	ld.d $t8, $fp, -88
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -300
# %op52 = load i32, i32* %op4
	ld.d $t8, $fp, -88
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -304
# %op53 = load i32, i32* %op4
	ld.d $t8, $fp, -88
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -308
# %op54 = load i32, i32* %op4
	ld.d $t8, $fp, -88
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -312
# %op55 = load i32, i32* %op4
	ld.d $t8, $fp, -88
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -316
# %op56 = mul i32 %op55, %op54
	ld.w $t7, $fp, -316
	ld.w $t8, $fp, -312
	mul.w $t7, $t7, $t8
	st.w $t7, $fp, -320
# %op57 = mul i32 %op56, %op53
	ld.w $t7, $fp, -320
	ld.w $t8, $fp, -308
	mul.w $t7, $t7, $t8
	st.w $t7, $fp, -324
# %op58 = mul i32 %op57, %op52
	ld.w $t7, $fp, -324
	ld.w $t8, $fp, -304
	mul.w $t7, $t7, $t8
	st.w $t7, $fp, -328
# %op59 = mul i32 %op58, %op51
	ld.w $t7, $fp, -328
	ld.w $t8, $fp, -300
	mul.w $t7, $t7, $t8
	st.w $t7, $fp, -332
# %op60 = mul i32 %op59, %op50
	ld.w $t7, $fp, -332
	ld.w $t8, $fp, -296
	mul.w $t7, $t7, $t8
	st.w $t7, $fp, -336
# store i32 %op60, i32* %op5
	ld.w $t7, $fp, -336
	ld.d $t8, $fp, -104
	st.w $t7, $t8, 0
# %op61 = load i32, i32* %op0
	ld.d $t8, $fp, -24
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -340
# %op62 = add i32 %op61, 1
	ld.w $t7, $fp, -340
	addi.w $t8, $zero, 1
	add.w $t7, $t7, $t8
	st.w $t7, $fp, -344
# store i32 %op62, i32* %op0
	ld.w $t7, $fp, -344
	ld.d $t8, $fp, -24
	st.w $t7, $t8, 0
# %op63 = load i32, i32* %op0
	ld.d $t8, $fp, -24
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -348
# %op64 = load i32, i32* %op6
	ld.d $t8, $fp, -120
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -352
# %op65 = icmp slt i32 %op63, %op64
	ld.w $t7, $fp, -348
	ld.w $t8, $fp, -352
	slt $t7, $t7, $t8
	st.b $t7, $fp, -353
# br i1 %op65, label %label11, label %label66
	ld.b $t7, $fp, -353
	bnez $t7, .main_label11
	b .main_label66
.main_label66:
# %op67 = load i32, i32* %op5
	ld.d $t8, $fp, -104
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -360
# call void @output(i32 %op67)
	ld.w $a0, $fp, -360
	bl output
# ret void
	addi.w $a0, $zero, 0
	b main_exit
main_exit:
	addi.d $sp, $sp, 368
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
