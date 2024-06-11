	.text
	.globl get
	.type get, @function
get:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -160
	st.d $a0, $fp, -24
	st.w $a1, $fp, -28
	st.w $a2, $fp, -32
	st.w $a3, $fp, -36
.get_label_entry:
# %op4 = alloca float*
	addi.d $t8, $fp, -56
	addi.d $t7, $fp, -48
	st.d $t8, $t7, 0
# store float* %arg0, float** %op4
	ld.d $t7, $fp, -24
	ld.d $t8, $fp, -48
	st.d $t7, $t8, 0
# %op5 = alloca i32
	addi.d $t8, $fp, -68
	addi.d $t7, $fp, -64
	st.d $t8, $t7, 0
# store i32 %arg1, i32* %op5
	ld.w $t7, $fp, -28
	ld.d $t8, $fp, -64
	st.w $t7, $t8, 0
# %op6 = alloca i32
	addi.d $t8, $fp, -84
	addi.d $t7, $fp, -80
	st.d $t8, $t7, 0
# store i32 %arg2, i32* %op6
	ld.w $t7, $fp, -32
	ld.d $t8, $fp, -80
	st.w $t7, $t8, 0
# %op7 = alloca i32
	addi.d $t8, $fp, -100
	addi.d $t7, $fp, -96
	st.d $t8, $t7, 0
# store i32 %arg3, i32* %op7
	ld.w $t7, $fp, -36
	ld.d $t8, $fp, -96
	st.w $t7, $t8, 0
# %op8 = load i32, i32* %op6
	ld.d $t8, $fp, -80
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -104
# %op9 = load i32, i32* %op7
	ld.d $t8, $fp, -96
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -108
# %op10 = load i32, i32* %op5
	ld.d $t8, $fp, -64
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -112
# %op11 = mul i32 %op10, %op9
	ld.w $t7, $fp, -112
	ld.w $t8, $fp, -108
	mul.w $t7, $t7, $t8
	st.w $t7, $fp, -116
# %op12 = add i32 %op11, %op8
	ld.w $t7, $fp, -116
	ld.w $t8, $fp, -104
	add.w $t7, $t7, $t8
	st.w $t7, $fp, -120
# %op13 = icmp sge i32 %op12, 0
	ld.w $t7, $fp, -120
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t7
	st.b $t7, $fp, -121
	ld.w $t7, $fp, -120
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	ld.b $t7, $fp, -121
	or $t7, $t7, $t8
	st.b $t7, $fp, -121
# br i1 %op13, label %label14, label %label18
	ld.b $t7, $fp, -121
	bnez $t7, .get_label14
	b .get_label18
.get_label14:
# %op15 = load float*, float** %op4
	ld.d $t8, $fp, -48
	ld.d $t7, $t8, 0
	st.d $t7, $fp, -136
# %op16 = getelementptr float, float* %op15, i32 %op12
	ld.w $t8, $fp, -120
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	ld.d $t8, $fp, -136
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -144
# %op17 = load float, float* %op16
	ld.d $t8, $fp, -144
	fld.s $ft14, $t8, 0
	fst.s $ft14, $fp, -148
# br label %label19
	b .get_label19
.get_label18:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label19
	b .get_label19
.get_label19:
# ret float %op17
	fld.s $fa0, $fp, -148
	b get_exit
get_exit:
	addi.d $sp, $sp, 160
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl abs
	.type abs, @function
abs:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -64
	fst.s $fa0, $fp, -20
.abs_label_entry:
# %op1 = alloca float
	addi.d $t8, $fp, -36
	addi.d $t7, $fp, -32
	st.d $t8, $t7, 0
# store float %arg0, float* %op1
	fld.s $ft14, $fp, -20
	ld.d $t7, $fp, -32
	fst.s $ft14, $t7, 0
# %op2 = load float, float* %op1
	ld.d $t8, $fp, -32
	fld.s $ft14, $t8, 0
	fst.s $ft14, $fp, -40
# %op3 = sitofp i32 0 to float
	addi.w $t7, $zero, 0
	movgr2fr.w $ft14, $t7
	ffint.s.w $ft15, $ft14
	fst.s $ft15, $fp, -44
# %op4 = fcmp ugt float %op2, %op3
	fld.s $ft14, $fp, -40
	fld.s $ft15, $fp, -44
	fcmp.slt.s $fcc0, $ft15, $ft14
	bcnez $fcc0, 8
	b 12
	addi.w $t7, $zero, 1
	b 12
	addi.w $t7, $zero, 0
	b 4
	st.b $t7, $fp, -45
# br i1 %op4, label %label5, label %label7
	ld.b $t7, $fp, -45
	bnez $t7, .abs_label5
	b .abs_label7
.abs_label5:
# %op6 = load float, float* %op1
	ld.d $t8, $fp, -32
	fld.s $ft14, $t8, 0
	fst.s $ft14, $fp, -52
# ret float %op6
	fld.s $fa0, $fp, -52
	b abs_exit
.abs_label7:
# %op8 = load float, float* %op1
	ld.d $t8, $fp, -32
	fld.s $ft14, $t8, 0
	fst.s $ft14, $fp, -56
# %op9 = sitofp i32 0 to float
	addi.w $t7, $zero, 0
	movgr2fr.w $ft14, $t7
	ffint.s.w $ft15, $ft14
	fst.s $ft15, $fp, -60
# %op10 = fsub float %op9, %op8
	fld.s $ft14, $fp, -60
	fld.s $ft15, $fp, -56
	fsub.s $ft14, $ft14, $ft15
	fst.s $ft14, $fp, -64
# ret float %op10
	fld.s $fa0, $fp, -64
	b abs_exit
.abs_label11:
# ret float 0x0
	lu12i.w $t8, 0
	ori $t8, $t8, 0
	movgr2fr.w $fa0, $t8
	b abs_exit
abs_exit:
	addi.d $sp, $sp, 64
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl isZero
	.type isZero, @function
isZero:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -64
	fst.s $fa0, $fp, -20
.isZero_label_entry:
# %op1 = alloca float
	addi.d $t8, $fp, -36
	addi.d $t7, $fp, -32
	st.d $t8, $t7, 0
# store float %arg0, float* %op1
	fld.s $ft14, $fp, -20
	ld.d $t7, $fp, -32
	fst.s $ft14, $t7, 0
# %op2 = load float, float* %op1
	ld.d $t8, $fp, -32
	fld.s $ft14, $t8, 0
	fst.s $ft14, $fp, -40
# %op3 = call float @abs(float %op2)
	fld.s $fa0, $fp, -40
	bl abs
	fst.s $fa0, $fp, -44
# %op4 = fcmp ult float %op3, 0x3eb0c6f7a0000000
	fld.s $ft14, $fp, -44
	lu12i.w $t8, 219235
	ori $t8, $t8, 1981
	movgr2fr.w $ft15, $t8
	fcmp.slt.s $fcc0, $ft14, $ft15
	bcnez $fcc0, 8
	b 12
	addi.w $t7, $zero, 1
	b 12
	addi.w $t7, $zero, 0
	b 4
	st.b $t7, $fp, -45
# %op5 = sitofp i1 %op4 to float
	ld.b $t7, $fp, -45
	movgr2fr.w $ft14, $t7
	ffint.s.w $ft15, $ft14
	fst.s $ft15, $fp, -52
# ret float %op5
	fld.s $fa0, $fp, -52
	b isZero_exit
isZero_exit:
	addi.d $sp, $sp, 64
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl gauss
	.type gauss, @function
gauss:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -1216
	st.d $a0, $fp, -24
	st.d $a1, $fp, -32
	st.w $a2, $fp, -36
.gauss_label_entry:
# %op3 = alloca float*
	addi.d $t8, $fp, -56
	addi.d $t7, $fp, -48
	st.d $t8, $t7, 0
# store float* %arg0, float** %op3
	ld.d $t7, $fp, -24
	ld.d $t8, $fp, -48
	st.d $t7, $t8, 0
# %op4 = alloca float*
	addi.d $t8, $fp, -72
	addi.d $t7, $fp, -64
	st.d $t8, $t7, 0
# store float* %arg1, float** %op4
	ld.d $t7, $fp, -32
	ld.d $t8, $fp, -64
	st.d $t7, $t8, 0
# %op5 = alloca i32
	addi.d $t8, $fp, -84
	addi.d $t7, $fp, -80
	st.d $t8, $t7, 0
# store i32 %arg2, i32* %op5
	ld.w $t7, $fp, -36
	ld.d $t8, $fp, -80
	st.w $t7, $t8, 0
# %op6 = alloca i32
	addi.d $t8, $fp, -100
	addi.d $t7, $fp, -96
	st.d $t8, $t7, 0
# %op7 = alloca i32
	addi.d $t8, $fp, -116
	addi.d $t7, $fp, -112
	st.d $t8, $t7, 0
# %op8 = alloca i32
	addi.d $t8, $fp, -132
	addi.d $t7, $fp, -128
	st.d $t8, $t7, 0
# %op9 = alloca i32
	addi.d $t8, $fp, -148
	addi.d $t7, $fp, -144
	st.d $t8, $t7, 0
# %op10 = alloca i32
	addi.d $t8, $fp, -164
	addi.d $t7, $fp, -160
	st.d $t8, $t7, 0
# %op11 = alloca i32
	addi.d $t8, $fp, -180
	addi.d $t7, $fp, -176
	st.d $t8, $t7, 0
# %op12 = alloca float
	addi.d $t8, $fp, -196
	addi.d $t7, $fp, -192
	st.d $t8, $t7, 0
# %op13 = load i32, i32* %op5
	ld.d $t8, $fp, -80
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -200
# %op14 = add i32 %op13, 1
	ld.w $t7, $fp, -200
	addi.w $t8, $zero, 1
	add.w $t7, $t7, $t8
	st.w $t7, $fp, -204
# store i32 %op14, i32* %op9
	ld.w $t7, $fp, -204
	ld.d $t8, $fp, -144
	st.w $t7, $t8, 0
# store i32 0, i32* %op6
	addi.w $t7, $zero, 0
	ld.d $t8, $fp, -96
	st.w $t7, $t8, 0
# %op15 = load i32, i32* %op6
	ld.d $t8, $fp, -96
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -208
# %op16 = load i32, i32* %op5
	ld.d $t8, $fp, -80
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -212
# %op17 = icmp slt i32 %op15, %op16
	ld.w $t7, $fp, -208
	ld.w $t8, $fp, -212
	slt $t7, $t7, $t8
	st.b $t7, $fp, -213
# br i1 %op17, label %label18, label %label21
	ld.b $t7, $fp, -213
	bnez $t7, .gauss_label18
	b .gauss_label21
.gauss_label18:
# %op19 = load i32, i32* %op6
	ld.d $t8, $fp, -96
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -220
# %op20 = icmp sge i32 %op19, 0
	ld.w $t7, $fp, -220
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t7
	st.b $t7, $fp, -221
	ld.w $t7, $fp, -220
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	ld.b $t7, $fp, -221
	or $t7, $t7, $t8
	st.b $t7, $fp, -221
# br i1 %op20, label %label25, label %label28
	ld.b $t7, $fp, -221
	bnez $t7, .gauss_label25
	b .gauss_label28
.gauss_label21:
# store i32 0, i32* %op11
	addi.w $t7, $zero, 0
	ld.d $t8, $fp, -176
	st.w $t7, $t8, 0
# store i32 0, i32* %op8
	addi.w $t7, $zero, 0
	ld.d $t8, $fp, -128
	st.w $t7, $t8, 0
# %op22 = load i32, i32* %op8
	ld.d $t8, $fp, -128
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -228
# %op23 = load i32, i32* %op5
	ld.d $t8, $fp, -80
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -232
# %op24 = icmp slt i32 %op22, %op23
	ld.w $t7, $fp, -228
	ld.w $t8, $fp, -232
	slt $t7, $t7, $t8
	st.b $t7, $fp, -233
# br i1 %op24, label %label36, label %label43
	ld.b $t7, $fp, -233
	bnez $t7, .gauss_label36
	b .gauss_label43
.gauss_label25:
# %op26 = load float*, float** %op3
	ld.d $t8, $fp, -48
	ld.d $t7, $t8, 0
	st.d $t7, $fp, -248
# %op27 = getelementptr float, float* %op26, i32 %op19
	ld.w $t8, $fp, -220
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	ld.d $t8, $fp, -248
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -256
# br label %label29
	b .gauss_label29
.gauss_label28:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label29
	b .gauss_label29
.gauss_label29:
# %op30 = sitofp i32 0 to float
	addi.w $t7, $zero, 0
	movgr2fr.w $ft14, $t7
	ffint.s.w $ft15, $ft14
	fst.s $ft15, $fp, -260
# store float %op30, float* %op27
	fld.s $ft14, $fp, -260
	ld.d $t7, $fp, -256
	fst.s $ft14, $t7, 0
# %op31 = load i32, i32* %op6
	ld.d $t8, $fp, -96
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -264
# %op32 = add i32 %op31, 1
	ld.w $t7, $fp, -264
	addi.w $t8, $zero, 1
	add.w $t7, $t7, $t8
	st.w $t7, $fp, -268
# store i32 %op32, i32* %op6
	ld.w $t7, $fp, -268
	ld.d $t8, $fp, -96
	st.w $t7, $t8, 0
# %op33 = load i32, i32* %op6
	ld.d $t8, $fp, -96
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -272
# %op34 = load i32, i32* %op5
	ld.d $t8, $fp, -80
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -276
# %op35 = icmp slt i32 %op33, %op34
	ld.w $t7, $fp, -272
	ld.w $t8, $fp, -276
	slt $t7, $t7, $t8
	st.b $t7, $fp, -277
# br i1 %op35, label %label18, label %label21
	ld.b $t7, $fp, -277
	bnez $t7, .gauss_label18
	b .gauss_label21
.gauss_label36:
# %op37 = load i32, i32* %op8
	ld.d $t8, $fp, -128
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -284
# store i32 %op37, i32* %op10
	ld.w $t7, $fp, -284
	ld.d $t8, $fp, -160
	st.w $t7, $t8, 0
# %op38 = load i32, i32* %op8
	ld.d $t8, $fp, -128
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -288
# %op39 = add i32 %op38, 1
	ld.w $t7, $fp, -288
	addi.w $t8, $zero, 1
	add.w $t7, $t7, $t8
	st.w $t7, $fp, -292
# store i32 %op39, i32* %op6
	ld.w $t7, $fp, -292
	ld.d $t8, $fp, -96
	st.w $t7, $t8, 0
# %op40 = load i32, i32* %op6
	ld.d $t8, $fp, -96
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -296
# %op41 = load i32, i32* %op5
	ld.d $t8, $fp, -80
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -300
# %op42 = icmp slt i32 %op40, %op41
	ld.w $t7, $fp, -296
	ld.w $t8, $fp, -300
	slt $t7, $t7, $t8
	st.b $t7, $fp, -301
# br i1 %op42, label %label48, label %label62
	ld.b $t7, $fp, -301
	bnez $t7, .gauss_label48
	b .gauss_label62
.gauss_label43:
# %op44 = load i32, i32* %op5
	ld.d $t8, $fp, -80
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -308
# %op45 = sub i32 %op44, 1
	ld.w $t7, $fp, -308
	addi.w $t8, $zero, 1
	sub.w $t7, $t7, $t8
	st.w $t7, $fp, -312
# store i32 %op45, i32* %op6
	ld.w $t7, $fp, -312
	ld.d $t8, $fp, -96
	st.w $t7, $t8, 0
# %op46 = load i32, i32* %op6
	ld.d $t8, $fp, -96
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -316
# %op47 = icmp sge i32 %op46, 0
	ld.w $t7, $fp, -316
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t7
	st.b $t7, $fp, -317
	ld.w $t7, $fp, -316
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	ld.b $t7, $fp, -317
	or $t7, $t7, $t8
	st.b $t7, $fp, -317
# br i1 %op47, label %label215, label %label226
	ld.b $t7, $fp, -317
	bnez $t7, .gauss_label215
	b .gauss_label226
.gauss_label48:
# %op49 = load float*, float** %op4
	ld.d $t8, $fp, -64
	ld.d $t7, $t8, 0
	st.d $t7, $fp, -328
# %op50 = load i32, i32* %op6
	ld.d $t8, $fp, -96
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -332
# %op51 = load i32, i32* %op11
	ld.d $t8, $fp, -176
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -336
# %op52 = load i32, i32* %op9
	ld.d $t8, $fp, -144
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -340
# %op53 = call float @get(float* %op49, i32 %op50, i32 %op51, i32 %op52)
	ld.d $a0, $fp, -328
	ld.w $a1, $fp, -332
	ld.w $a2, $fp, -336
	ld.w $a3, $fp, -340
	bl get
	fst.s $fa0, $fp, -344
# %op54 = call float @abs(float %op53)
	fld.s $fa0, $fp, -344
	bl abs
	fst.s $fa0, $fp, -348
# %op55 = load float*, float** %op4
	ld.d $t8, $fp, -64
	ld.d $t7, $t8, 0
	st.d $t7, $fp, -360
# %op56 = load i32, i32* %op10
	ld.d $t8, $fp, -160
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -364
# %op57 = load i32, i32* %op11
	ld.d $t8, $fp, -176
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -368
# %op58 = load i32, i32* %op9
	ld.d $t8, $fp, -144
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -372
# %op59 = call float @get(float* %op55, i32 %op56, i32 %op57, i32 %op58)
	ld.d $a0, $fp, -360
	ld.w $a1, $fp, -364
	ld.w $a2, $fp, -368
	ld.w $a3, $fp, -372
	bl get
	fst.s $fa0, $fp, -376
# %op60 = call float @abs(float %op59)
	fld.s $fa0, $fp, -376
	bl abs
	fst.s $fa0, $fp, -380
# %op61 = fcmp ugt float %op54, %op60
	fld.s $ft14, $fp, -348
	fld.s $ft15, $fp, -380
	fcmp.slt.s $fcc0, $ft15, $ft14
	bcnez $fcc0, 8
	b 12
	addi.w $t7, $zero, 1
	b 12
	addi.w $t7, $zero, 0
	b 4
	st.b $t7, $fp, -381
# br i1 %op61, label %label66, label %label68
	ld.b $t7, $fp, -381
	bnez $t7, .gauss_label66
	b .gauss_label68
.gauss_label62:
# %op63 = load i32, i32* %op10
	ld.d $t8, $fp, -160
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -388
# %op64 = load i32, i32* %op8
	ld.d $t8, $fp, -128
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -392
# %op65 = icmp ne i32 %op63, %op64
	ld.w $t7, $fp, -388
	ld.w $t8, $fp, -392
	xor $t7, $t7, $t8
	sltu $t7, $zero, $t7
	st.b $t7, $fp, -393
# br i1 %op65, label %label74, label %label79
	ld.b $t7, $fp, -393
	bnez $t7, .gauss_label74
	b .gauss_label79
.gauss_label66:
# %op67 = load i32, i32* %op6
	ld.d $t8, $fp, -96
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -400
# store i32 %op67, i32* %op10
	ld.w $t7, $fp, -400
	ld.d $t8, $fp, -160
	st.w $t7, $t8, 0
# br label %label68
	b .gauss_label68
.gauss_label68:
# %op69 = load i32, i32* %op6
	ld.d $t8, $fp, -96
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -404
# %op70 = add i32 %op69, 1
	ld.w $t7, $fp, -404
	addi.w $t8, $zero, 1
	add.w $t7, $t7, $t8
	st.w $t7, $fp, -408
# store i32 %op70, i32* %op6
	ld.w $t7, $fp, -408
	ld.d $t8, $fp, -96
	st.w $t7, $t8, 0
# %op71 = load i32, i32* %op6
	ld.d $t8, $fp, -96
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -412
# %op72 = load i32, i32* %op5
	ld.d $t8, $fp, -80
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -416
# %op73 = icmp slt i32 %op71, %op72
	ld.w $t7, $fp, -412
	ld.w $t8, $fp, -416
	slt $t7, $t7, $t8
	st.b $t7, $fp, -417
# br i1 %op73, label %label48, label %label62
	ld.b $t7, $fp, -417
	bnez $t7, .gauss_label48
	b .gauss_label62
.gauss_label74:
# %op75 = load i32, i32* %op8
	ld.d $t8, $fp, -128
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -424
# store i32 %op75, i32* %op7
	ld.w $t7, $fp, -424
	ld.d $t8, $fp, -112
	st.w $t7, $t8, 0
# %op76 = load i32, i32* %op7
	ld.d $t8, $fp, -112
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -428
# %op77 = load i32, i32* %op9
	ld.d $t8, $fp, -144
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -432
# %op78 = icmp slt i32 %op76, %op77
	ld.w $t7, $fp, -428
	ld.w $t8, $fp, -432
	slt $t7, $t7, $t8
	st.b $t7, $fp, -433
# br i1 %op78, label %label87, label %label99
	ld.b $t7, $fp, -433
	bnez $t7, .gauss_label87
	b .gauss_label99
.gauss_label79:
# %op80 = load float*, float** %op4
	ld.d $t8, $fp, -64
	ld.d $t7, $t8, 0
	st.d $t7, $fp, -448
# %op81 = load i32, i32* %op8
	ld.d $t8, $fp, -128
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -452
# %op82 = load i32, i32* %op11
	ld.d $t8, $fp, -176
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -456
# %op83 = load i32, i32* %op9
	ld.d $t8, $fp, -144
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -460
# %op84 = call float @get(float* %op80, i32 %op81, i32 %op82, i32 %op83)
	ld.d $a0, $fp, -448
	ld.w $a1, $fp, -452
	ld.w $a2, $fp, -456
	ld.w $a3, $fp, -460
	bl get
	fst.s $fa0, $fp, -464
# %op85 = call float @isZero(float %op84)
	fld.s $fa0, $fp, -464
	bl isZero
	fst.s $fa0, $fp, -468
# %op86 = fcmp une float %op85, 0x0
	fld.s $ft14, $fp, -468
	lu12i.w $t8, 0
	ori $t8, $t8, 0
	movgr2fr.w $ft15, $t8
	fcmp.sne.s $fcc0, $ft15, $ft14
	bcnez $fcc0, 8
	b 12
	addi.w $t7, $zero, 1
	b 12
	addi.w $t7, $zero, 0
	b 4
	st.b $t7, $fp, -469
# br i1 %op86, label %label127, label %label130
	ld.b $t7, $fp, -469
	bnez $t7, .gauss_label127
	b .gauss_label130
.gauss_label87:
# %op88 = load float*, float** %op4
	ld.d $t8, $fp, -64
	ld.d $t7, $t8, 0
	st.d $t7, $fp, -480
# %op89 = load i32, i32* %op8
	ld.d $t8, $fp, -128
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -484
# %op90 = load i32, i32* %op7
	ld.d $t8, $fp, -112
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -488
# %op91 = load i32, i32* %op9
	ld.d $t8, $fp, -144
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -492
# %op92 = call float @get(float* %op88, i32 %op89, i32 %op90, i32 %op91)
	ld.d $a0, $fp, -480
	ld.w $a1, $fp, -484
	ld.w $a2, $fp, -488
	ld.w $a3, $fp, -492
	bl get
	fst.s $fa0, $fp, -496
# store float %op92, float* %op12
	fld.s $ft14, $fp, -496
	ld.d $t7, $fp, -192
	fst.s $ft14, $t7, 0
# %op93 = load i32, i32* %op7
	ld.d $t8, $fp, -112
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -500
# %op94 = load i32, i32* %op9
	ld.d $t8, $fp, -144
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -504
# %op95 = load i32, i32* %op8
	ld.d $t8, $fp, -128
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -508
# %op96 = mul i32 %op95, %op94
	ld.w $t7, $fp, -508
	ld.w $t8, $fp, -504
	mul.w $t7, $t7, $t8
	st.w $t7, $fp, -512
# %op97 = add i32 %op96, %op93
	ld.w $t7, $fp, -512
	ld.w $t8, $fp, -500
	add.w $t7, $t7, $t8
	st.w $t7, $fp, -516
# %op98 = icmp sge i32 %op97, 0
	ld.w $t7, $fp, -516
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t7
	st.b $t7, $fp, -517
	ld.w $t7, $fp, -516
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	ld.b $t7, $fp, -517
	or $t7, $t7, $t8
	st.b $t7, $fp, -517
# br i1 %op98, label %label100, label %label103
	ld.b $t7, $fp, -517
	bnez $t7, .gauss_label100
	b .gauss_label103
.gauss_label99:
# br label %label79
	b .gauss_label79
.gauss_label100:
# %op101 = load float*, float** %op4
	ld.d $t8, $fp, -64
	ld.d $t7, $t8, 0
	st.d $t7, $fp, -528
# %op102 = getelementptr float, float* %op101, i32 %op97
	ld.w $t8, $fp, -516
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	ld.d $t8, $fp, -528
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -536
# br label %label104
	b .gauss_label104
.gauss_label103:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label104
	b .gauss_label104
.gauss_label104:
# %op105 = load float*, float** %op4
	ld.d $t8, $fp, -64
	ld.d $t7, $t8, 0
	st.d $t7, $fp, -544
# %op106 = load i32, i32* %op10
	ld.d $t8, $fp, -160
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -548
# %op107 = load i32, i32* %op7
	ld.d $t8, $fp, -112
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -552
# %op108 = load i32, i32* %op9
	ld.d $t8, $fp, -144
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -556
# %op109 = call float @get(float* %op105, i32 %op106, i32 %op107, i32 %op108)
	ld.d $a0, $fp, -544
	ld.w $a1, $fp, -548
	ld.w $a2, $fp, -552
	ld.w $a3, $fp, -556
	bl get
	fst.s $fa0, $fp, -560
# store float %op109, float* %op102
	fld.s $ft14, $fp, -560
	ld.d $t7, $fp, -536
	fst.s $ft14, $t7, 0
# %op110 = load i32, i32* %op7
	ld.d $t8, $fp, -112
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -564
# %op111 = load i32, i32* %op9
	ld.d $t8, $fp, -144
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -568
# %op112 = load i32, i32* %op10
	ld.d $t8, $fp, -160
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -572
# %op113 = mul i32 %op112, %op111
	ld.w $t7, $fp, -572
	ld.w $t8, $fp, -568
	mul.w $t7, $t7, $t8
	st.w $t7, $fp, -576
# %op114 = add i32 %op113, %op110
	ld.w $t7, $fp, -576
	ld.w $t8, $fp, -564
	add.w $t7, $t7, $t8
	st.w $t7, $fp, -580
# %op115 = icmp sge i32 %op114, 0
	ld.w $t7, $fp, -580
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t7
	st.b $t7, $fp, -581
	ld.w $t7, $fp, -580
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	ld.b $t7, $fp, -581
	or $t7, $t7, $t8
	st.b $t7, $fp, -581
# br i1 %op115, label %label116, label %label119
	ld.b $t7, $fp, -581
	bnez $t7, .gauss_label116
	b .gauss_label119
.gauss_label116:
# %op117 = load float*, float** %op4
	ld.d $t8, $fp, -64
	ld.d $t7, $t8, 0
	st.d $t7, $fp, -592
# %op118 = getelementptr float, float* %op117, i32 %op114
	ld.w $t8, $fp, -580
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	ld.d $t8, $fp, -592
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -600
# br label %label120
	b .gauss_label120
.gauss_label119:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label120
	b .gauss_label120
.gauss_label120:
# %op121 = load float, float* %op12
	ld.d $t8, $fp, -192
	fld.s $ft14, $t8, 0
	fst.s $ft14, $fp, -604
# store float %op121, float* %op118
	fld.s $ft14, $fp, -604
	ld.d $t7, $fp, -600
	fst.s $ft14, $t7, 0
# %op122 = load i32, i32* %op7
	ld.d $t8, $fp, -112
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -608
# %op123 = add i32 %op122, 1
	ld.w $t7, $fp, -608
	addi.w $t8, $zero, 1
	add.w $t7, $t7, $t8
	st.w $t7, $fp, -612
# store i32 %op123, i32* %op7
	ld.w $t7, $fp, -612
	ld.d $t8, $fp, -112
	st.w $t7, $t8, 0
# %op124 = load i32, i32* %op7
	ld.d $t8, $fp, -112
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -616
# %op125 = load i32, i32* %op9
	ld.d $t8, $fp, -144
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -620
# %op126 = icmp slt i32 %op124, %op125
	ld.w $t7, $fp, -616
	ld.w $t8, $fp, -620
	slt $t7, $t7, $t8
	st.b $t7, $fp, -621
# br i1 %op126, label %label87, label %label99
	ld.b $t7, $fp, -621
	bnez $t7, .gauss_label87
	b .gauss_label99
.gauss_label127:
# %op128 = load i32, i32* %op8
	ld.d $t8, $fp, -128
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -628
# %op129 = sub i32 %op128, 1
	ld.w $t7, $fp, -628
	addi.w $t8, $zero, 1
	sub.w $t7, $t7, $t8
	st.w $t7, $fp, -632
# store i32 %op129, i32* %op8
	ld.w $t7, $fp, -632
	ld.d $t8, $fp, -128
	st.w $t7, $t8, 0
# br label %label136
	b .gauss_label136
.gauss_label130:
# %op131 = load i32, i32* %op8
	ld.d $t8, $fp, -128
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -636
# %op132 = add i32 %op131, 1
	ld.w $t7, $fp, -636
	addi.w $t8, $zero, 1
	add.w $t7, $t7, $t8
	st.w $t7, $fp, -640
# store i32 %op132, i32* %op6
	ld.w $t7, $fp, -640
	ld.d $t8, $fp, -96
	st.w $t7, $t8, 0
# %op133 = load i32, i32* %op6
	ld.d $t8, $fp, -96
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -644
# %op134 = load i32, i32* %op5
	ld.d $t8, $fp, -80
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -648
# %op135 = icmp slt i32 %op133, %op134
	ld.w $t7, $fp, -644
	ld.w $t8, $fp, -648
	slt $t7, $t7, $t8
	st.b $t7, $fp, -649
# br i1 %op135, label %label144, label %label154
	ld.b $t7, $fp, -649
	bnez $t7, .gauss_label144
	b .gauss_label154
.gauss_label136:
# %op137 = load i32, i32* %op8
	ld.d $t8, $fp, -128
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -656
# %op138 = add i32 %op137, 1
	ld.w $t7, $fp, -656
	addi.w $t8, $zero, 1
	add.w $t7, $t7, $t8
	st.w $t7, $fp, -660
# store i32 %op138, i32* %op8
	ld.w $t7, $fp, -660
	ld.d $t8, $fp, -128
	st.w $t7, $t8, 0
# %op139 = load i32, i32* %op11
	ld.d $t8, $fp, -176
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -664
# %op140 = add i32 %op139, 1
	ld.w $t7, $fp, -664
	addi.w $t8, $zero, 1
	add.w $t7, $t7, $t8
	st.w $t7, $fp, -668
# store i32 %op140, i32* %op11
	ld.w $t7, $fp, -668
	ld.d $t8, $fp, -176
	st.w $t7, $t8, 0
# %op141 = load i32, i32* %op8
	ld.d $t8, $fp, -128
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -672
# %op142 = load i32, i32* %op5
	ld.d $t8, $fp, -80
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -676
# %op143 = icmp slt i32 %op141, %op142
	ld.w $t7, $fp, -672
	ld.w $t8, $fp, -676
	slt $t7, $t7, $t8
	st.b $t7, $fp, -677
# br i1 %op143, label %label36, label %label43
	ld.b $t7, $fp, -677
	bnez $t7, .gauss_label36
	b .gauss_label43
.gauss_label144:
# %op145 = load float*, float** %op4
	ld.d $t8, $fp, -64
	ld.d $t7, $t8, 0
	st.d $t7, $fp, -688
# %op146 = load i32, i32* %op6
	ld.d $t8, $fp, -96
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -692
# %op147 = load i32, i32* %op11
	ld.d $t8, $fp, -176
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -696
# %op148 = load i32, i32* %op9
	ld.d $t8, $fp, -144
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -700
# %op149 = call float @get(float* %op145, i32 %op146, i32 %op147, i32 %op148)
	ld.d $a0, $fp, -688
	ld.w $a1, $fp, -692
	ld.w $a2, $fp, -696
	ld.w $a3, $fp, -700
	bl get
	fst.s $fa0, $fp, -704
# %op150 = call float @isZero(float %op149)
	fld.s $fa0, $fp, -704
	bl isZero
	fst.s $fa0, $fp, -708
# %op151 = sitofp i32 1 to float
	addi.w $t7, $zero, 1
	movgr2fr.w $ft14, $t7
	ffint.s.w $ft15, $ft14
	fst.s $ft15, $fp, -712
# %op152 = fsub float %op151, %op150
	fld.s $ft14, $fp, -712
	fld.s $ft15, $fp, -708
	fsub.s $ft14, $ft14, $ft15
	fst.s $ft14, $fp, -716
# %op153 = fcmp une float %op152, 0x0
	fld.s $ft14, $fp, -716
	lu12i.w $t8, 0
	ori $t8, $t8, 0
	movgr2fr.w $ft15, $t8
	fcmp.sne.s $fcc0, $ft15, $ft14
	bcnez $fcc0, 8
	b 12
	addi.w $t7, $zero, 1
	b 12
	addi.w $t7, $zero, 0
	b 4
	st.b $t7, $fp, -717
# br i1 %op153, label %label155, label %label171
	ld.b $t7, $fp, -717
	bnez $t7, .gauss_label155
	b .gauss_label171
.gauss_label154:
# br label %label136
	b .gauss_label136
.gauss_label155:
# %op156 = load float*, float** %op4
	ld.d $t8, $fp, -64
	ld.d $t7, $t8, 0
	st.d $t7, $fp, -728
# %op157 = load i32, i32* %op8
	ld.d $t8, $fp, -128
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -732
# %op158 = load i32, i32* %op11
	ld.d $t8, $fp, -176
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -736
# %op159 = load i32, i32* %op9
	ld.d $t8, $fp, -144
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -740
# %op160 = call float @get(float* %op156, i32 %op157, i32 %op158, i32 %op159)
	ld.d $a0, $fp, -728
	ld.w $a1, $fp, -732
	ld.w $a2, $fp, -736
	ld.w $a3, $fp, -740
	bl get
	fst.s $fa0, $fp, -744
# %op161 = load float*, float** %op4
	ld.d $t8, $fp, -64
	ld.d $t7, $t8, 0
	st.d $t7, $fp, -752
# %op162 = load i32, i32* %op6
	ld.d $t8, $fp, -96
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -756
# %op163 = load i32, i32* %op11
	ld.d $t8, $fp, -176
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -760
# %op164 = load i32, i32* %op9
	ld.d $t8, $fp, -144
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -764
# %op165 = call float @get(float* %op161, i32 %op162, i32 %op163, i32 %op164)
	ld.d $a0, $fp, -752
	ld.w $a1, $fp, -756
	ld.w $a2, $fp, -760
	ld.w $a3, $fp, -764
	bl get
	fst.s $fa0, $fp, -768
# %op166 = fdiv float %op165, %op160
	fld.s $ft14, $fp, -768
	fld.s $ft15, $fp, -744
	fdiv.s $ft14, $ft14, $ft15
	fst.s $ft14, $fp, -772
# store float %op166, float* %op12
	fld.s $ft14, $fp, -772
	ld.d $t7, $fp, -192
	fst.s $ft14, $t7, 0
# %op167 = load i32, i32* %op11
	ld.d $t8, $fp, -176
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -776
# store i32 %op167, i32* %op7
	ld.w $t7, $fp, -776
	ld.d $t8, $fp, -112
	st.w $t7, $t8, 0
# %op168 = load i32, i32* %op7
	ld.d $t8, $fp, -112
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -780
# %op169 = load i32, i32* %op9
	ld.d $t8, $fp, -144
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -784
# %op170 = icmp slt i32 %op168, %op169
	ld.w $t7, $fp, -780
	ld.w $t8, $fp, -784
	slt $t7, $t7, $t8
	st.b $t7, $fp, -785
# br i1 %op170, label %label177, label %label184
	ld.b $t7, $fp, -785
	bnez $t7, .gauss_label177
	b .gauss_label184
.gauss_label171:
# %op172 = load i32, i32* %op6
	ld.d $t8, $fp, -96
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -792
# %op173 = add i32 %op172, 1
	ld.w $t7, $fp, -792
	addi.w $t8, $zero, 1
	add.w $t7, $t7, $t8
	st.w $t7, $fp, -796
# store i32 %op173, i32* %op6
	ld.w $t7, $fp, -796
	ld.d $t8, $fp, -96
	st.w $t7, $t8, 0
# %op174 = load i32, i32* %op6
	ld.d $t8, $fp, -96
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -800
# %op175 = load i32, i32* %op5
	ld.d $t8, $fp, -80
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -804
# %op176 = icmp slt i32 %op174, %op175
	ld.w $t7, $fp, -800
	ld.w $t8, $fp, -804
	slt $t7, $t7, $t8
	st.b $t7, $fp, -805
# br i1 %op176, label %label144, label %label154
	ld.b $t7, $fp, -805
	bnez $t7, .gauss_label144
	b .gauss_label154
.gauss_label177:
# %op178 = load i32, i32* %op7
	ld.d $t8, $fp, -112
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -812
# %op179 = load i32, i32* %op9
	ld.d $t8, $fp, -144
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -816
# %op180 = load i32, i32* %op6
	ld.d $t8, $fp, -96
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -820
# %op181 = mul i32 %op180, %op179
	ld.w $t7, $fp, -820
	ld.w $t8, $fp, -816
	mul.w $t7, $t7, $t8
	st.w $t7, $fp, -824
# %op182 = add i32 %op181, %op178
	ld.w $t7, $fp, -824
	ld.w $t8, $fp, -812
	add.w $t7, $t7, $t8
	st.w $t7, $fp, -828
# %op183 = icmp sge i32 %op182, 0
	ld.w $t7, $fp, -828
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t7
	st.b $t7, $fp, -829
	ld.w $t7, $fp, -828
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	ld.b $t7, $fp, -829
	or $t7, $t7, $t8
	st.b $t7, $fp, -829
# br i1 %op183, label %label185, label %label188
	ld.b $t7, $fp, -829
	bnez $t7, .gauss_label185
	b .gauss_label188
.gauss_label184:
# br label %label171
	b .gauss_label171
.gauss_label185:
# %op186 = load float*, float** %op4
	ld.d $t8, $fp, -64
	ld.d $t7, $t8, 0
	st.d $t7, $fp, -840
# %op187 = getelementptr float, float* %op186, i32 %op182
	ld.w $t8, $fp, -828
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	ld.d $t8, $fp, -840
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -848
# br label %label189
	b .gauss_label189
.gauss_label188:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label189
	b .gauss_label189
.gauss_label189:
# %op190 = load float, float* %op12
	ld.d $t8, $fp, -192
	fld.s $ft14, $t8, 0
	fst.s $ft14, $fp, -852
# %op191 = load float*, float** %op4
	ld.d $t8, $fp, -64
	ld.d $t7, $t8, 0
	st.d $t7, $fp, -864
# %op192 = load i32, i32* %op8
	ld.d $t8, $fp, -128
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -868
# %op193 = load i32, i32* %op7
	ld.d $t8, $fp, -112
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -872
# %op194 = load i32, i32* %op9
	ld.d $t8, $fp, -144
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -876
# %op195 = call float @get(float* %op191, i32 %op192, i32 %op193, i32 %op194)
	ld.d $a0, $fp, -864
	ld.w $a1, $fp, -868
	ld.w $a2, $fp, -872
	ld.w $a3, $fp, -876
	bl get
	fst.s $fa0, $fp, -880
# %op196 = fmul float %op195, %op190
	fld.s $ft14, $fp, -880
	fld.s $ft15, $fp, -852
	fmul.s $ft14, $ft14, $ft15
	fst.s $ft14, $fp, -884
# %op197 = load i32, i32* %op7
	ld.d $t8, $fp, -112
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -888
# %op198 = load i32, i32* %op9
	ld.d $t8, $fp, -144
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -892
# %op199 = load i32, i32* %op6
	ld.d $t8, $fp, -96
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -896
# %op200 = mul i32 %op199, %op198
	ld.w $t7, $fp, -896
	ld.w $t8, $fp, -892
	mul.w $t7, $t7, $t8
	st.w $t7, $fp, -900
# %op201 = add i32 %op200, %op197
	ld.w $t7, $fp, -900
	ld.w $t8, $fp, -888
	add.w $t7, $t7, $t8
	st.w $t7, $fp, -904
# %op202 = icmp sge i32 %op201, 0
	ld.w $t7, $fp, -904
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t7
	st.b $t7, $fp, -905
	ld.w $t7, $fp, -904
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	ld.b $t7, $fp, -905
	or $t7, $t7, $t8
	st.b $t7, $fp, -905
# br i1 %op202, label %label203, label %label207
	ld.b $t7, $fp, -905
	bnez $t7, .gauss_label203
	b .gauss_label207
.gauss_label203:
# %op204 = load float*, float** %op4
	ld.d $t8, $fp, -64
	ld.d $t7, $t8, 0
	st.d $t7, $fp, -920
# %op205 = getelementptr float, float* %op204, i32 %op201
	ld.w $t8, $fp, -904
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	ld.d $t8, $fp, -920
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -928
# %op206 = load float, float* %op205
	ld.d $t8, $fp, -928
	fld.s $ft14, $t8, 0
	fst.s $ft14, $fp, -932
# br label %label208
	b .gauss_label208
.gauss_label207:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label208
	b .gauss_label208
.gauss_label208:
# %op209 = fsub float %op206, %op196
	fld.s $ft14, $fp, -932
	fld.s $ft15, $fp, -884
	fsub.s $ft14, $ft14, $ft15
	fst.s $ft14, $fp, -936
# store float %op209, float* %op187
	fld.s $ft14, $fp, -936
	ld.d $t7, $fp, -848
	fst.s $ft14, $t7, 0
# %op210 = load i32, i32* %op7
	ld.d $t8, $fp, -112
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -940
# %op211 = add i32 %op210, 1
	ld.w $t7, $fp, -940
	addi.w $t8, $zero, 1
	add.w $t7, $t7, $t8
	st.w $t7, $fp, -944
# store i32 %op211, i32* %op7
	ld.w $t7, $fp, -944
	ld.d $t8, $fp, -112
	st.w $t7, $t8, 0
# %op212 = load i32, i32* %op7
	ld.d $t8, $fp, -112
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -948
# %op213 = load i32, i32* %op9
	ld.d $t8, $fp, -144
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -952
# %op214 = icmp slt i32 %op212, %op213
	ld.w $t7, $fp, -948
	ld.w $t8, $fp, -952
	slt $t7, $t7, $t8
	st.b $t7, $fp, -953
# br i1 %op214, label %label177, label %label184
	ld.b $t7, $fp, -953
	bnez $t7, .gauss_label177
	b .gauss_label184
.gauss_label215:
# %op216 = load float*, float** %op4
	ld.d $t8, $fp, -64
	ld.d $t7, $t8, 0
	st.d $t7, $fp, -968
# %op217 = load i32, i32* %op6
	ld.d $t8, $fp, -96
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -972
# %op218 = load i32, i32* %op5
	ld.d $t8, $fp, -80
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -976
# %op219 = load i32, i32* %op9
	ld.d $t8, $fp, -144
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -980
# %op220 = call float @get(float* %op216, i32 %op217, i32 %op218, i32 %op219)
	ld.d $a0, $fp, -968
	ld.w $a1, $fp, -972
	ld.w $a2, $fp, -976
	ld.w $a3, $fp, -980
	bl get
	fst.s $fa0, $fp, -984
# store float %op220, float* %op12
	fld.s $ft14, $fp, -984
	ld.d $t7, $fp, -192
	fst.s $ft14, $t7, 0
# %op221 = load i32, i32* %op6
	ld.d $t8, $fp, -96
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -988
# %op222 = add i32 %op221, 1
	ld.w $t7, $fp, -988
	addi.w $t8, $zero, 1
	add.w $t7, $t7, $t8
	st.w $t7, $fp, -992
# store i32 %op222, i32* %op7
	ld.w $t7, $fp, -992
	ld.d $t8, $fp, -112
	st.w $t7, $t8, 0
# %op223 = load i32, i32* %op7
	ld.d $t8, $fp, -112
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -996
# %op224 = load i32, i32* %op5
	ld.d $t8, $fp, -80
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -1000
# %op225 = icmp slt i32 %op223, %op224
	ld.w $t7, $fp, -996
	ld.w $t8, $fp, -1000
	slt $t7, $t7, $t8
	st.b $t7, $fp, -1001
# br i1 %op225, label %label227, label %label237
	ld.b $t7, $fp, -1001
	bnez $t7, .gauss_label227
	b .gauss_label237
.gauss_label226:
# ret i32 0
	addi.w $a0, $zero, 0
	b gauss_exit
.gauss_label227:
# %op228 = load float*, float** %op4
	ld.d $t8, $fp, -64
	ld.d $t7, $t8, 0
	st.d $t7, $fp, -1016
# %op229 = load i32, i32* %op6
	ld.d $t8, $fp, -96
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -1020
# %op230 = load i32, i32* %op7
	ld.d $t8, $fp, -112
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -1024
# %op231 = load i32, i32* %op9
	ld.d $t8, $fp, -144
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -1028
# %op232 = call float @get(float* %op228, i32 %op229, i32 %op230, i32 %op231)
	ld.d $a0, $fp, -1016
	ld.w $a1, $fp, -1020
	ld.w $a2, $fp, -1024
	ld.w $a3, $fp, -1028
	bl get
	fst.s $fa0, $fp, -1032
# %op233 = call float @isZero(float %op232)
	fld.s $fa0, $fp, -1032
	bl isZero
	fst.s $fa0, $fp, -1036
# %op234 = sitofp i32 1 to float
	addi.w $t7, $zero, 1
	movgr2fr.w $ft14, $t7
	ffint.s.w $ft15, $ft14
	fst.s $ft15, $fp, -1040
# %op235 = fsub float %op234, %op233
	fld.s $ft14, $fp, -1040
	fld.s $ft15, $fp, -1036
	fsub.s $ft14, $ft14, $ft15
	fst.s $ft14, $fp, -1044
# %op236 = fcmp une float %op235, 0x0
	fld.s $ft14, $fp, -1044
	lu12i.w $t8, 0
	ori $t8, $t8, 0
	movgr2fr.w $ft15, $t8
	fcmp.sne.s $fcc0, $ft15, $ft14
	bcnez $fcc0, 8
	b 12
	addi.w $t7, $zero, 1
	b 12
	addi.w $t7, $zero, 0
	b 4
	st.b $t7, $fp, -1045
# br i1 %op236, label %label240, label %label243
	ld.b $t7, $fp, -1045
	bnez $t7, .gauss_label240
	b .gauss_label243
.gauss_label237:
# %op238 = load i32, i32* %op6
	ld.d $t8, $fp, -96
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -1052
# %op239 = icmp sge i32 %op238, 0
	ld.w $t7, $fp, -1052
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t7
	st.b $t7, $fp, -1053
	ld.w $t7, $fp, -1052
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	ld.b $t7, $fp, -1053
	or $t7, $t7, $t8
	st.b $t7, $fp, -1053
# br i1 %op239, label %label263, label %label266
	ld.b $t7, $fp, -1053
	bnez $t7, .gauss_label263
	b .gauss_label266
.gauss_label240:
# %op241 = load i32, i32* %op7
	ld.d $t8, $fp, -112
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -1060
# %op242 = icmp sge i32 %op241, 0
	ld.w $t7, $fp, -1060
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t7
	st.b $t7, $fp, -1061
	ld.w $t7, $fp, -1060
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	ld.b $t7, $fp, -1061
	or $t7, $t7, $t8
	st.b $t7, $fp, -1061
# br i1 %op242, label %label249, label %label253
	ld.b $t7, $fp, -1061
	bnez $t7, .gauss_label249
	b .gauss_label253
.gauss_label243:
# %op244 = load i32, i32* %op7
	ld.d $t8, $fp, -112
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -1068
# %op245 = add i32 %op244, 1
	ld.w $t7, $fp, -1068
	addi.w $t8, $zero, 1
	add.w $t7, $t7, $t8
	st.w $t7, $fp, -1072
# store i32 %op245, i32* %op7
	ld.w $t7, $fp, -1072
	ld.d $t8, $fp, -112
	st.w $t7, $t8, 0
# %op246 = load i32, i32* %op7
	ld.d $t8, $fp, -112
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -1076
# %op247 = load i32, i32* %op5
	ld.d $t8, $fp, -80
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -1080
# %op248 = icmp slt i32 %op246, %op247
	ld.w $t7, $fp, -1076
	ld.w $t8, $fp, -1080
	slt $t7, $t7, $t8
	st.b $t7, $fp, -1081
# br i1 %op248, label %label227, label %label237
	ld.b $t7, $fp, -1081
	bnez $t7, .gauss_label227
	b .gauss_label237
.gauss_label249:
# %op250 = load float*, float** %op3
	ld.d $t8, $fp, -48
	ld.d $t7, $t8, 0
	st.d $t7, $fp, -1096
# %op251 = getelementptr float, float* %op250, i32 %op241
	ld.w $t8, $fp, -1060
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	ld.d $t8, $fp, -1096
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -1104
# %op252 = load float, float* %op251
	ld.d $t8, $fp, -1104
	fld.s $ft14, $t8, 0
	fst.s $ft14, $fp, -1108
# br label %label254
	b .gauss_label254
.gauss_label253:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label254
	b .gauss_label254
.gauss_label254:
# %op255 = load float*, float** %op4
	ld.d $t8, $fp, -64
	ld.d $t7, $t8, 0
	st.d $t7, $fp, -1120
# %op256 = load i32, i32* %op6
	ld.d $t8, $fp, -96
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -1124
# %op257 = load i32, i32* %op7
	ld.d $t8, $fp, -112
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -1128
# %op258 = load i32, i32* %op9
	ld.d $t8, $fp, -144
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -1132
# %op259 = call float @get(float* %op255, i32 %op256, i32 %op257, i32 %op258)
	ld.d $a0, $fp, -1120
	ld.w $a1, $fp, -1124
	ld.w $a2, $fp, -1128
	ld.w $a3, $fp, -1132
	bl get
	fst.s $fa0, $fp, -1136
# %op260 = fmul float %op259, %op252
	fld.s $ft14, $fp, -1136
	fld.s $ft15, $fp, -1108
	fmul.s $ft14, $ft14, $ft15
	fst.s $ft14, $fp, -1140
# %op261 = load float, float* %op12
	ld.d $t8, $fp, -192
	fld.s $ft14, $t8, 0
	fst.s $ft14, $fp, -1144
# %op262 = fsub float %op261, %op260
	fld.s $ft14, $fp, -1144
	fld.s $ft15, $fp, -1140
	fsub.s $ft14, $ft14, $ft15
	fst.s $ft14, $fp, -1148
# store float %op262, float* %op12
	fld.s $ft14, $fp, -1148
	ld.d $t7, $fp, -192
	fst.s $ft14, $t7, 0
# br label %label243
	b .gauss_label243
.gauss_label263:
# %op264 = load float*, float** %op3
	ld.d $t8, $fp, -48
	ld.d $t7, $t8, 0
	st.d $t7, $fp, -1160
# %op265 = getelementptr float, float* %op264, i32 %op238
	ld.w $t8, $fp, -1052
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	ld.d $t8, $fp, -1160
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -1168
# br label %label267
	b .gauss_label267
.gauss_label266:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label267
	b .gauss_label267
.gauss_label267:
# %op268 = load float*, float** %op4
	ld.d $t8, $fp, -64
	ld.d $t7, $t8, 0
	st.d $t7, $fp, -1176
# %op269 = load i32, i32* %op6
	ld.d $t8, $fp, -96
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -1180
# %op270 = load i32, i32* %op6
	ld.d $t8, $fp, -96
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -1184
# %op271 = load i32, i32* %op9
	ld.d $t8, $fp, -144
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -1188
# %op272 = call float @get(float* %op268, i32 %op269, i32 %op270, i32 %op271)
	ld.d $a0, $fp, -1176
	ld.w $a1, $fp, -1180
	ld.w $a2, $fp, -1184
	ld.w $a3, $fp, -1188
	bl get
	fst.s $fa0, $fp, -1192
# %op273 = load float, float* %op12
	ld.d $t8, $fp, -192
	fld.s $ft14, $t8, 0
	fst.s $ft14, $fp, -1196
# %op274 = fdiv float %op273, %op272
	fld.s $ft14, $fp, -1196
	fld.s $ft15, $fp, -1192
	fdiv.s $ft14, $ft14, $ft15
	fst.s $ft14, $fp, -1200
# store float %op274, float* %op265
	fld.s $ft14, $fp, -1200
	ld.d $t7, $fp, -1168
	fst.s $ft14, $t7, 0
# %op275 = load i32, i32* %op6
	ld.d $t8, $fp, -96
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -1204
# %op276 = sub i32 %op275, 1
	ld.w $t7, $fp, -1204
	addi.w $t8, $zero, 1
	sub.w $t7, $t7, $t8
	st.w $t7, $fp, -1208
# store i32 %op276, i32* %op6
	ld.w $t7, $fp, -1208
	ld.d $t8, $fp, -96
	st.w $t7, $t8, 0
# %op277 = load i32, i32* %op6
	ld.d $t8, $fp, -96
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -1212
# %op278 = icmp sge i32 %op277, 0
	ld.w $t7, $fp, -1212
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t7
	st.b $t7, $fp, -1213
	ld.w $t7, $fp, -1212
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	ld.b $t7, $fp, -1213
	or $t7, $t7, $t8
	st.b $t7, $fp, -1213
# br i1 %op278, label %label215, label %label226
	ld.b $t7, $fp, -1213
	bnez $t7, .gauss_label215
	b .gauss_label226
gauss_exit:
	addi.d $sp, $sp, 1216
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -464
.main_label_entry:
# %op0 = alloca i32
	addi.d $t8, $fp, -28
	addi.d $t7, $fp, -24
	st.d $t8, $t7, 0
# %op1 = alloca [3 x float]
	addi.d $t8, $fp, -52
	addi.d $t7, $fp, -40
	st.d $t8, $t7, 0
# %op2 = alloca [12 x float]
	addi.d $t8, $fp, -112
	addi.d $t7, $fp, -64
	st.d $t8, $t7, 0
# %op3 = icmp sge i32 0, 0
	addi.w $t7, $zero, 0
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t7
	st.b $t7, $fp, -113
	addi.w $t7, $zero, 0
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	ld.b $t7, $fp, -113
	or $t7, $t7, $t8
	st.b $t7, $fp, -113
# br i1 %op3, label %label4, label %label6
	ld.b $t7, $fp, -113
	bnez $t7, .main_label4
	b .main_label6
.main_label4:
# %op5 = getelementptr [12 x float], [12 x float]* %op2, i32 0, i32 0
	addi.w $t8, $zero, 0
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	ld.d $t8, $fp, -64
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -128
# br label %label7
	b .main_label7
.main_label6:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label7
	b .main_label7
.main_label7:
# %op8 = sitofp i32 1 to float
	addi.w $t7, $zero, 1
	movgr2fr.w $ft14, $t7
	ffint.s.w $ft15, $ft14
	fst.s $ft15, $fp, -132
# store float %op8, float* %op5
	fld.s $ft14, $fp, -132
	ld.d $t7, $fp, -128
	fst.s $ft14, $t7, 0
# %op9 = icmp sge i32 1, 0
	addi.w $t7, $zero, 1
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t7
	st.b $t7, $fp, -133
	addi.w $t7, $zero, 1
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	ld.b $t7, $fp, -133
	or $t7, $t7, $t8
	st.b $t7, $fp, -133
# br i1 %op9, label %label10, label %label12
	ld.b $t7, $fp, -133
	bnez $t7, .main_label10
	b .main_label12
.main_label10:
# %op11 = getelementptr [12 x float], [12 x float]* %op2, i32 0, i32 1
	addi.w $t8, $zero, 1
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	ld.d $t8, $fp, -64
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -144
# br label %label13
	b .main_label13
.main_label12:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label13
	b .main_label13
.main_label13:
# %op14 = sitofp i32 2 to float
	addi.w $t7, $zero, 2
	movgr2fr.w $ft14, $t7
	ffint.s.w $ft15, $ft14
	fst.s $ft15, $fp, -148
# store float %op14, float* %op11
	fld.s $ft14, $fp, -148
	ld.d $t7, $fp, -144
	fst.s $ft14, $t7, 0
# %op15 = icmp sge i32 2, 0
	addi.w $t7, $zero, 2
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t7
	st.b $t7, $fp, -149
	addi.w $t7, $zero, 2
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	ld.b $t7, $fp, -149
	or $t7, $t7, $t8
	st.b $t7, $fp, -149
# br i1 %op15, label %label16, label %label18
	ld.b $t7, $fp, -149
	bnez $t7, .main_label16
	b .main_label18
.main_label16:
# %op17 = getelementptr [12 x float], [12 x float]* %op2, i32 0, i32 2
	addi.w $t8, $zero, 2
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	ld.d $t8, $fp, -64
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -160
# br label %label19
	b .main_label19
.main_label18:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label19
	b .main_label19
.main_label19:
# %op20 = sitofp i32 1 to float
	addi.w $t7, $zero, 1
	movgr2fr.w $ft14, $t7
	ffint.s.w $ft15, $ft14
	fst.s $ft15, $fp, -164
# store float %op20, float* %op17
	fld.s $ft14, $fp, -164
	ld.d $t7, $fp, -160
	fst.s $ft14, $t7, 0
# %op21 = icmp sge i32 3, 0
	addi.w $t7, $zero, 3
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t7
	st.b $t7, $fp, -165
	addi.w $t7, $zero, 3
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	ld.b $t7, $fp, -165
	or $t7, $t7, $t8
	st.b $t7, $fp, -165
# br i1 %op21, label %label22, label %label24
	ld.b $t7, $fp, -165
	bnez $t7, .main_label22
	b .main_label24
.main_label22:
# %op23 = getelementptr [12 x float], [12 x float]* %op2, i32 0, i32 3
	addi.w $t8, $zero, 3
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	ld.d $t8, $fp, -64
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -176
# br label %label25
	b .main_label25
.main_label24:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label25
	b .main_label25
.main_label25:
# %op26 = sitofp i32 1 to float
	addi.w $t7, $zero, 1
	movgr2fr.w $ft14, $t7
	ffint.s.w $ft15, $ft14
	fst.s $ft15, $fp, -180
# store float %op26, float* %op23
	fld.s $ft14, $fp, -180
	ld.d $t7, $fp, -176
	fst.s $ft14, $t7, 0
# %op27 = mul i32 1, 4
	addi.w $t7, $zero, 1
	addi.w $t8, $zero, 4
	mul.w $t7, $t7, $t8
	st.w $t7, $fp, -184
# %op28 = add i32 %op27, 0
	ld.w $t7, $fp, -184
	addi.w $t8, $zero, 0
	add.w $t7, $t7, $t8
	st.w $t7, $fp, -188
# %op29 = icmp sge i32 %op28, 0
	ld.w $t7, $fp, -188
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t7
	st.b $t7, $fp, -189
	ld.w $t7, $fp, -188
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	ld.b $t7, $fp, -189
	or $t7, $t7, $t8
	st.b $t7, $fp, -189
# br i1 %op29, label %label30, label %label32
	ld.b $t7, $fp, -189
	bnez $t7, .main_label30
	b .main_label32
.main_label30:
# %op31 = getelementptr [12 x float], [12 x float]* %op2, i32 0, i32 %op28
	ld.w $t8, $fp, -188
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	ld.d $t8, $fp, -64
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -200
# br label %label33
	b .main_label33
.main_label32:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label33
	b .main_label33
.main_label33:
# %op34 = sitofp i32 2 to float
	addi.w $t7, $zero, 2
	movgr2fr.w $ft14, $t7
	ffint.s.w $ft15, $ft14
	fst.s $ft15, $fp, -204
# store float %op34, float* %op31
	fld.s $ft14, $fp, -204
	ld.d $t7, $fp, -200
	fst.s $ft14, $t7, 0
# %op35 = mul i32 1, 4
	addi.w $t7, $zero, 1
	addi.w $t8, $zero, 4
	mul.w $t7, $t7, $t8
	st.w $t7, $fp, -208
# %op36 = add i32 %op35, 1
	ld.w $t7, $fp, -208
	addi.w $t8, $zero, 1
	add.w $t7, $t7, $t8
	st.w $t7, $fp, -212
# %op37 = icmp sge i32 %op36, 0
	ld.w $t7, $fp, -212
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t7
	st.b $t7, $fp, -213
	ld.w $t7, $fp, -212
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	ld.b $t7, $fp, -213
	or $t7, $t7, $t8
	st.b $t7, $fp, -213
# br i1 %op37, label %label38, label %label40
	ld.b $t7, $fp, -213
	bnez $t7, .main_label38
	b .main_label40
.main_label38:
# %op39 = getelementptr [12 x float], [12 x float]* %op2, i32 0, i32 %op36
	ld.w $t8, $fp, -212
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	ld.d $t8, $fp, -64
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -224
# br label %label41
	b .main_label41
.main_label40:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label41
	b .main_label41
.main_label41:
# %op42 = sitofp i32 3 to float
	addi.w $t7, $zero, 3
	movgr2fr.w $ft14, $t7
	ffint.s.w $ft15, $ft14
	fst.s $ft15, $fp, -228
# store float %op42, float* %op39
	fld.s $ft14, $fp, -228
	ld.d $t7, $fp, -224
	fst.s $ft14, $t7, 0
# %op43 = mul i32 1, 4
	addi.w $t7, $zero, 1
	addi.w $t8, $zero, 4
	mul.w $t7, $t7, $t8
	st.w $t7, $fp, -232
# %op44 = add i32 %op43, 2
	ld.w $t7, $fp, -232
	addi.w $t8, $zero, 2
	add.w $t7, $t7, $t8
	st.w $t7, $fp, -236
# %op45 = icmp sge i32 %op44, 0
	ld.w $t7, $fp, -236
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t7
	st.b $t7, $fp, -237
	ld.w $t7, $fp, -236
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	ld.b $t7, $fp, -237
	or $t7, $t7, $t8
	st.b $t7, $fp, -237
# br i1 %op45, label %label46, label %label48
	ld.b $t7, $fp, -237
	bnez $t7, .main_label46
	b .main_label48
.main_label46:
# %op47 = getelementptr [12 x float], [12 x float]* %op2, i32 0, i32 %op44
	ld.w $t8, $fp, -236
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	ld.d $t8, $fp, -64
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -248
# br label %label49
	b .main_label49
.main_label48:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label49
	b .main_label49
.main_label49:
# %op50 = sitofp i32 4 to float
	addi.w $t7, $zero, 4
	movgr2fr.w $ft14, $t7
	ffint.s.w $ft15, $ft14
	fst.s $ft15, $fp, -252
# store float %op50, float* %op47
	fld.s $ft14, $fp, -252
	ld.d $t7, $fp, -248
	fst.s $ft14, $t7, 0
# %op51 = mul i32 1, 4
	addi.w $t7, $zero, 1
	addi.w $t8, $zero, 4
	mul.w $t7, $t7, $t8
	st.w $t7, $fp, -256
# %op52 = add i32 %op51, 3
	ld.w $t7, $fp, -256
	addi.w $t8, $zero, 3
	add.w $t7, $t7, $t8
	st.w $t7, $fp, -260
# %op53 = icmp sge i32 %op52, 0
	ld.w $t7, $fp, -260
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t7
	st.b $t7, $fp, -261
	ld.w $t7, $fp, -260
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	ld.b $t7, $fp, -261
	or $t7, $t7, $t8
	st.b $t7, $fp, -261
# br i1 %op53, label %label54, label %label56
	ld.b $t7, $fp, -261
	bnez $t7, .main_label54
	b .main_label56
.main_label54:
# %op55 = getelementptr [12 x float], [12 x float]* %op2, i32 0, i32 %op52
	ld.w $t8, $fp, -260
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	ld.d $t8, $fp, -64
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -272
# br label %label57
	b .main_label57
.main_label56:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label57
	b .main_label57
.main_label57:
# %op58 = sitofp i32 3 to float
	addi.w $t7, $zero, 3
	movgr2fr.w $ft14, $t7
	ffint.s.w $ft15, $ft14
	fst.s $ft15, $fp, -276
# store float %op58, float* %op55
	fld.s $ft14, $fp, -276
	ld.d $t7, $fp, -272
	fst.s $ft14, $t7, 0
# %op59 = mul i32 2, 4
	addi.w $t7, $zero, 2
	addi.w $t8, $zero, 4
	mul.w $t7, $t7, $t8
	st.w $t7, $fp, -280
# %op60 = add i32 %op59, 0
	ld.w $t7, $fp, -280
	addi.w $t8, $zero, 0
	add.w $t7, $t7, $t8
	st.w $t7, $fp, -284
# %op61 = icmp sge i32 %op60, 0
	ld.w $t7, $fp, -284
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t7
	st.b $t7, $fp, -285
	ld.w $t7, $fp, -284
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	ld.b $t7, $fp, -285
	or $t7, $t7, $t8
	st.b $t7, $fp, -285
# br i1 %op61, label %label62, label %label64
	ld.b $t7, $fp, -285
	bnez $t7, .main_label62
	b .main_label64
.main_label62:
# %op63 = getelementptr [12 x float], [12 x float]* %op2, i32 0, i32 %op60
	ld.w $t8, $fp, -284
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	ld.d $t8, $fp, -64
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -296
# br label %label65
	b .main_label65
.main_label64:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label65
	b .main_label65
.main_label65:
# %op66 = sitofp i32 1 to float
	addi.w $t7, $zero, 1
	movgr2fr.w $ft14, $t7
	ffint.s.w $ft15, $ft14
	fst.s $ft15, $fp, -300
# store float %op66, float* %op63
	fld.s $ft14, $fp, -300
	ld.d $t7, $fp, -296
	fst.s $ft14, $t7, 0
# %op67 = mul i32 2, 4
	addi.w $t7, $zero, 2
	addi.w $t8, $zero, 4
	mul.w $t7, $t7, $t8
	st.w $t7, $fp, -304
# %op68 = add i32 %op67, 1
	ld.w $t7, $fp, -304
	addi.w $t8, $zero, 1
	add.w $t7, $t7, $t8
	st.w $t7, $fp, -308
# %op69 = icmp sge i32 %op68, 0
	ld.w $t7, $fp, -308
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t7
	st.b $t7, $fp, -309
	ld.w $t7, $fp, -308
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	ld.b $t7, $fp, -309
	or $t7, $t7, $t8
	st.b $t7, $fp, -309
# br i1 %op69, label %label70, label %label72
	ld.b $t7, $fp, -309
	bnez $t7, .main_label70
	b .main_label72
.main_label70:
# %op71 = getelementptr [12 x float], [12 x float]* %op2, i32 0, i32 %op68
	ld.w $t8, $fp, -308
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	ld.d $t8, $fp, -64
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -320
# br label %label73
	b .main_label73
.main_label72:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label73
	b .main_label73
.main_label73:
# %op74 = sitofp i32 1 to float
	addi.w $t7, $zero, 1
	movgr2fr.w $ft14, $t7
	ffint.s.w $ft15, $ft14
	fst.s $ft15, $fp, -324
# store float %op74, float* %op71
	fld.s $ft14, $fp, -324
	ld.d $t7, $fp, -320
	fst.s $ft14, $t7, 0
# %op75 = mul i32 2, 4
	addi.w $t7, $zero, 2
	addi.w $t8, $zero, 4
	mul.w $t7, $t7, $t8
	st.w $t7, $fp, -328
# %op76 = add i32 %op75, 2
	ld.w $t7, $fp, -328
	addi.w $t8, $zero, 2
	add.w $t7, $t7, $t8
	st.w $t7, $fp, -332
# %op77 = icmp sge i32 %op76, 0
	ld.w $t7, $fp, -332
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t7
	st.b $t7, $fp, -333
	ld.w $t7, $fp, -332
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	ld.b $t7, $fp, -333
	or $t7, $t7, $t8
	st.b $t7, $fp, -333
# br i1 %op77, label %label78, label %label80
	ld.b $t7, $fp, -333
	bnez $t7, .main_label78
	b .main_label80
.main_label78:
# %op79 = getelementptr [12 x float], [12 x float]* %op2, i32 0, i32 %op76
	ld.w $t8, $fp, -332
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	ld.d $t8, $fp, -64
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -344
# br label %label81
	b .main_label81
.main_label80:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label81
	b .main_label81
.main_label81:
# %op82 = sub i32 0, 2
	addi.w $t7, $zero, 0
	addi.w $t8, $zero, 2
	sub.w $t7, $t7, $t8
	st.w $t7, $fp, -348
# %op83 = sitofp i32 %op82 to float
	ld.w $t7, $fp, -348
	movgr2fr.w $ft14, $t7
	ffint.s.w $ft15, $ft14
	fst.s $ft15, $fp, -352
# store float %op83, float* %op79
	fld.s $ft14, $fp, -352
	ld.d $t7, $fp, -344
	fst.s $ft14, $t7, 0
# %op84 = mul i32 2, 4
	addi.w $t7, $zero, 2
	addi.w $t8, $zero, 4
	mul.w $t7, $t7, $t8
	st.w $t7, $fp, -356
# %op85 = add i32 %op84, 3
	ld.w $t7, $fp, -356
	addi.w $t8, $zero, 3
	add.w $t7, $t7, $t8
	st.w $t7, $fp, -360
# %op86 = icmp sge i32 %op85, 0
	ld.w $t7, $fp, -360
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t7
	st.b $t7, $fp, -361
	ld.w $t7, $fp, -360
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	ld.b $t7, $fp, -361
	or $t7, $t7, $t8
	st.b $t7, $fp, -361
# br i1 %op86, label %label87, label %label89
	ld.b $t7, $fp, -361
	bnez $t7, .main_label87
	b .main_label89
.main_label87:
# %op88 = getelementptr [12 x float], [12 x float]* %op2, i32 0, i32 %op85
	ld.w $t8, $fp, -360
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	ld.d $t8, $fp, -64
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -376
# br label %label90
	b .main_label90
.main_label89:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label90
	b .main_label90
.main_label90:
# %op91 = sitofp i32 0 to float
	addi.w $t7, $zero, 0
	movgr2fr.w $ft14, $t7
	ffint.s.w $ft15, $ft14
	fst.s $ft15, $fp, -380
# store float %op91, float* %op88
	fld.s $ft14, $fp, -380
	ld.d $t7, $fp, -376
	fst.s $ft14, $t7, 0
# %op92 = getelementptr [3 x float], [3 x float]* %op1, i32 0, i32 0
	addi.w $t8, $zero, 0
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	ld.d $t8, $fp, -40
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -392
# %op93 = getelementptr [12 x float], [12 x float]* %op2, i32 0, i32 0
	addi.w $t8, $zero, 0
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	ld.d $t8, $fp, -64
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -400
# %op94 = call i32 @gauss(float* %op92, float* %op93, i32 3)
	ld.d $a0, $fp, -392
	ld.d $a1, $fp, -400
	addi.w $a2, $zero, 3
	bl gauss
	st.w $a0, $fp, -404
# store i32 0, i32* %op0
	addi.w $t7, $zero, 0
	ld.d $t8, $fp, -24
	st.w $t7, $t8, 0
# %op95 = load i32, i32* %op0
	ld.d $t8, $fp, -24
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -408
# %op96 = icmp slt i32 %op95, 3
	ld.w $t7, $fp, -408
	addi.w $t8, $zero, 3
	slt $t7, $t7, $t8
	st.b $t7, $fp, -409
# br i1 %op96, label %label97, label %label100
	ld.b $t7, $fp, -409
	bnez $t7, .main_label97
	b .main_label100
.main_label97:
# %op98 = load i32, i32* %op0
	ld.d $t8, $fp, -24
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -416
# %op99 = icmp sge i32 %op98, 0
	ld.w $t7, $fp, -416
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t7
	st.b $t7, $fp, -417
	ld.w $t7, $fp, -416
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	ld.b $t7, $fp, -417
	or $t7, $t7, $t8
	st.b $t7, $fp, -417
# br i1 %op99, label %label101, label %label104
	ld.b $t7, $fp, -417
	bnez $t7, .main_label101
	b .main_label104
.main_label100:
# ret void
	addi.w $a0, $zero, 0
	b main_exit
.main_label101:
# %op102 = getelementptr [3 x float], [3 x float]* %op1, i32 0, i32 %op98
	ld.w $t8, $fp, -416
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	ld.d $t8, $fp, -40
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -432
# %op103 = load float, float* %op102
	ld.d $t8, $fp, -432
	fld.s $ft14, $t8, 0
	fst.s $ft14, $fp, -436
# br label %label105
	b .main_label105
.main_label104:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label105
	b .main_label105
.main_label105:
# call void @outputFloat(float %op103)
	fld.s $fa0, $fp, -436
	bl outputFloat
# %op106 = load i32, i32* %op0
	ld.d $t8, $fp, -24
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -440
# %op107 = add i32 %op106, 1
	ld.w $t7, $fp, -440
	addi.w $t8, $zero, 1
	add.w $t7, $t7, $t8
	st.w $t7, $fp, -444
# store i32 %op107, i32* %op0
	ld.w $t7, $fp, -444
	ld.d $t8, $fp, -24
	st.w $t7, $t8, 0
# %op108 = load i32, i32* %op0
	ld.d $t8, $fp, -24
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -448
# %op109 = icmp slt i32 %op108, 3
	ld.w $t7, $fp, -448
	addi.w $t8, $zero, 3
	slt $t7, $t7, $t8
	st.b $t7, $fp, -449
# br i1 %op109, label %label97, label %label100
	ld.b $t7, $fp, -449
	bnez $t7, .main_label97
	b .main_label100
main_exit:
	addi.d $sp, $sp, 464
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
