	.text
	.globl get
	.type get, @function
get:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -160
	add.d $t0, $a0, $zero
	add.d $t1, $a1, $zero
	add.d $t2, $a2, $zero
	add.d $t3, $a3, $zero
.get_label_entry:
# %op4 = alloca float*
	addi.d $t4, $fp, -56
# store float* %arg0, float** %op4
	st.d $t0, $t4, 0
# %op5 = alloca i32
	addi.d $t0, $fp, -68
# store i32 %arg1, i32* %op5
	st.w $t1, $t0, 0
# %op6 = alloca i32
	addi.d $t1, $fp, -84
# store i32 %arg2, i32* %op6
	st.w $t2, $t1, 0
# %op7 = alloca i32
	addi.d $t2, $fp, -100
# store i32 %arg3, i32* %op7
	st.w $t3, $t2, 0
# %op8 = load i32, i32* %op6
	ld.w $t1, $t1, 0
# %op9 = load i32, i32* %op7
	ld.w $t2, $t2, 0
# %op10 = load i32, i32* %op5
	ld.w $t0, $t0, 0
# %op11 = mul i32 %op10, %op9
	mul.w $t0, $t0, $t2
# %op12 = add i32 %op11, %op8
	add.w $t0, $t0, $t1
# %op13 = icmp sge i32 %op12, 0
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t0
	xor $t8, $t8, $t0
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	or $t1, $t7, $t8
# br i1 %op13, label %label14, label %label18
	bnez $t1, .get_label14
	b .get_label18
.get_label14:
# %op15 = load float*, float** %op4
	ld.d $t1, $t4, 0
# %op16 = getelementptr float, float* %op15, i32 %op12
	addi.w $t7, $zero, 4
	mul.w $t7, $t0, $t7
	add.d $t0, $t1, $t7
# %op17 = load float, float* %op16
	fld.s $ft0, $t0, 0
# br label %label19
	b .get_label19
.get_label18:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label19
	b .get_label19
.get_label19:
# ret float %op17
	movgr2fr.w $ft14, $zero
	fadd.s $fa0, $ft0, $ft14
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
	movgr2fr.w $ft14, $zero
	fadd.s $ft0, $fa0, $ft14
.abs_label_entry:
# %op1 = alloca float
	addi.d $t0, $fp, -36
# store float %arg0, float* %op1
	fst.s $ft0, $t0, 0
# %op2 = load float, float* %op1
	fld.s $ft0, $t0, 0
# %op3 = sitofp i32 0 to float
	addi.w $t7, $zero, 0
	movgr2fr.w $ft14, $t7
	ffint.s.w $ft1, $ft14
# %op4 = fcmp ugt float %op2, %op3
	fcmp.slt.s $fcc0, $ft1, $ft0
	bcnez $fcc0, 8
	b 12
	addi.w $t1, $zero, 1
	b 12
	addi.w $t1, $zero, 0
	b 4
# br i1 %op4, label %label5, label %label7
	bnez $t1, .abs_label5
	b .abs_label7
.abs_label5:
# %op6 = load float, float* %op1
	fld.s $ft0, $t0, 0
# ret float %op6
	movgr2fr.w $ft14, $zero
	fadd.s $fa0, $ft0, $ft14
	b abs_exit
.abs_label7:
# %op8 = load float, float* %op1
	fld.s $ft0, $t0, 0
# %op9 = sitofp i32 0 to float
	addi.w $t7, $zero, 0
	movgr2fr.w $ft14, $t7
	ffint.s.w $ft1, $ft14
# %op10 = fsub float %op9, %op8
	fsub.s $ft0, $ft1, $ft0
# ret float %op10
	movgr2fr.w $ft14, $zero
	fadd.s $fa0, $ft0, $ft14
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
	movgr2fr.w $ft14, $zero
	fadd.s $ft0, $fa0, $ft14
.isZero_label_entry:
# %op1 = alloca float
	addi.d $t0, $fp, -36
# store float %arg0, float* %op1
	fst.s $ft0, $t0, 0
# %op2 = load float, float* %op1
	fld.s $ft0, $t0, 0
# %op3 = call float @abs(float %op2)
	movgr2fr.w $ft14, $zero
	fadd.s $fa0, $ft0, $ft14
	bl abs
	movgr2fr.w $ft14, $zero
	fadd.s $ft0, $fa0, $ft14
# %op4 = fcmp ult float %op3, 0x3eb0c6f7a0000000
	lu12i.w $t8, 219235
	ori $t8, $t8, 1981
	movgr2fr.w $ft15, $t8
	fcmp.slt.s $fcc0, $ft0, $ft15
	bcnez $fcc0, 8
	b 12
	addi.w $t0, $zero, 1
	b 12
	addi.w $t0, $zero, 0
	b 4
# %op5 = sitofp i1 %op4 to float
	movgr2fr.w $ft14, $t0
	ffint.s.w $ft0, $ft14
# ret float %op5
	movgr2fr.w $ft14, $zero
	fadd.s $fa0, $ft0, $ft14
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
	addi.d $sp, $sp, -784
	add.d $t0, $a0, $zero
	add.d $t1, $a1, $zero
	add.d $t2, $a2, $zero
.gauss_label_entry:
# %op3 = alloca float*
	addi.d $t8, $fp, -56
	addi.d $t7, $fp, -48
	st.d $t8, $t7, 0
# store float* %arg0, float** %op3
	ld.d $t7, $fp, -48
	st.d $t0, $t7, 0
# %op4 = alloca float*
	addi.d $t8, $fp, -72
	addi.d $t7, $fp, -64
	st.d $t8, $t7, 0
# store float* %arg1, float** %op4
	ld.d $t7, $fp, -64
	st.d $t1, $t7, 0
# %op5 = alloca i32
	addi.d $t8, $fp, -84
	addi.d $t7, $fp, -80
	st.d $t8, $t7, 0
# store i32 %arg2, i32* %op5
	ld.d $t7, $fp, -80
	st.w $t2, $t7, 0
# %op6 = load i32, i32* %op5
	ld.d $t8, $fp, -80
	ld.w $t2, $t8, 0
# %op7 = add i32 %op6, 1
	addi.w $t7, $zero, 1
	add.w $t7, $t2, $t7
	st.w $t7, $fp, -92
# %op8 = load i32, i32* %op5
	ld.d $t8, $fp, -80
	ld.w $t4, $t8, 0
# %op9 = icmp slt i32 0, %op8
	addi.w $t8, $zero, 0
	slt $t4, $t8, $t4
# br i1 %op9, label %label10, label %label13
	st.b $t4, $fp, -97
# %op11 = phi i32 [ 0, %label_entry ], [ %op22, %label20 ]
	addi.w $t7, $zero, 0
	add.d $t4, $t7, $zero
	ld.b $t7, $fp, -97
	bnez $t7, .gauss_label10
	b .gauss_label13
.gauss_label10:
# %op11 = phi i32 [ 0, %label_entry ], [ %op22, %label20 ]
# %op12 = icmp sge i32 %op11, 0
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t4
	xor $t8, $t8, $t4
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	or $t5, $t7, $t8
# br i1 %op12, label %label16, label %label19
	bnez $t5, .gauss_label16
	b .gauss_label19
.gauss_label13:
# %op14 = load i32, i32* %op5
	ld.d $t8, $fp, -80
	ld.w $t4, $t8, 0
# %op15 = icmp slt i32 0, %op14
	addi.w $t8, $zero, 0
	slt $t4, $t8, $t4
# br i1 %op15, label %label25, label %label31
# %op27 = phi i32 [ 0, %label13 ], [ %op94, %label92 ]
	addi.w $t7, $zero, 0
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -160
# %op26 = phi i32 [ 0, %label13 ], [ %op95, %label92 ]
	addi.w $t7, $zero, 0
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -156
	bnez $t4, .gauss_label25
	b .gauss_label31
.gauss_label16:
# %op17 = load float*, float** %op3
	ld.d $t8, $fp, -48
	ld.d $t5, $t8, 0
# %op18 = getelementptr float, float* %op17, i32 %op11
	addi.w $t7, $zero, 4
	mul.w $t7, $t4, $t7
	add.d $t5, $t5, $t7
# br label %label20
	b .gauss_label20
.gauss_label19:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label20
	b .gauss_label20
.gauss_label20:
# %op21 = sitofp i32 0 to float
	addi.w $t7, $zero, 0
	movgr2fr.w $ft14, $t7
	ffint.s.w $ft0, $ft14
# store float %op21, float* %op18
	fst.s $ft0, $t5, 0
# %op22 = add i32 %op11, 1
	addi.w $t8, $zero, 1
	add.w $t4, $t4, $t8
# %op23 = load i32, i32* %op5
	ld.d $t8, $fp, -80
	ld.w $t6, $t8, 0
# %op24 = icmp slt i32 %op22, %op23
	slt $t6, $t4, $t6
# br i1 %op24, label %label10, label %label13
# %op11 = phi i32 [ 0, %label_entry ], [ %op22, %label20 ]
	add.d $t4, $t4, $zero
	bnez $t6, .gauss_label10
	b .gauss_label13
.gauss_label25:
# %op26 = phi i32 [ 0, %label13 ], [ %op95, %label92 ]
# %op27 = phi i32 [ 0, %label13 ], [ %op94, %label92 ]
# %op28 = add i32 %op27, 1
	ld.w $t7, $fp, -160
	addi.w $t8, $zero, 1
	add.w $t7, $t7, $t8
	st.w $t7, $fp, -164
# %op29 = load i32, i32* %op5
	ld.d $t8, $fp, -80
	ld.w $t2, $t8, 0
# %op30 = icmp slt i32 %op28, %op29
	ld.w $t8, $fp, -164
	slt $t2, $t8, $t2
# br i1 %op30, label %label35, label %label45
# %op36 = phi i32 [ %op27, %label25 ], [ %op50, %label49 ]
	ld.w $t7, $fp, -160
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -188
# %op37 = phi i32 [ %op28, %label25 ], [ %op51, %label49 ]
	ld.w $t7, $fp, -164
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -192
	bnez $t2, .gauss_label35
# %op46 = phi i32 [ %op27, %label25 ], [ %op50, %label49 ]
	ld.w $t7, $fp, -160
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -232
	b .gauss_label45
.gauss_label31:
# %op32 = load i32, i32* %op5
	ld.d $t8, $fp, -80
	ld.w $t0, $t8, 0
# %op33 = sub i32 %op32, 1
	addi.w $t7, $zero, 1
	sub.w $t7, $t0, $t7
	st.w $t7, $fp, -180
# %op34 = icmp sge i32 %op33, 0
	ld.w $t7, $fp, -180
	addi.w $t8, $zero, 0
	slt $t1, $t8, $t7
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	or $t1, $t1, $t8
# br i1 %op34, label %label144, label %label152
# %op145 = phi i32 [ %op33, %label31 ], [ %op190, %label186 ]
	ld.w $t7, $fp, -180
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -588
	bnez $t1, .gauss_label144
	b .gauss_label152
.gauss_label35:
# %op36 = phi i32 [ %op27, %label25 ], [ %op50, %label49 ]
# %op37 = phi i32 [ %op28, %label25 ], [ %op51, %label49 ]
# %op38 = load float*, float** %op4
	ld.d $t8, $fp, -64
	ld.d $t0, $t8, 0
# %op39 = call float @get(float* %op38, i32 %op37, i32 %op26, i32 %op7)
	add.d $a0, $t0, $zero
	ld.w $a1, $fp, -192
	ld.w $a2, $fp, -156
	ld.w $a3, $fp, -92
	bl get
	movgr2fr.w $ft14, $zero
	fadd.s $ft0, $fa0, $ft14
# %op40 = call float @abs(float %op39)
	movgr2fr.w $ft14, $zero
	fadd.s $fa0, $ft0, $ft14
	bl abs
	fst.s $fa0, $fp, -208
# %op41 = load float*, float** %op4
	ld.d $t8, $fp, -64
	ld.d $t0, $t8, 0
# %op42 = call float @get(float* %op41, i32 %op36, i32 %op26, i32 %op7)
	add.d $a0, $t0, $zero
	ld.w $a1, $fp, -188
	ld.w $a2, $fp, -156
	ld.w $a3, $fp, -92
	bl get
	movgr2fr.w $ft14, $zero
	fadd.s $ft0, $fa0, $ft14
# %op43 = call float @abs(float %op42)
	movgr2fr.w $ft14, $zero
	fadd.s $fa0, $ft0, $ft14
	bl abs
	movgr2fr.w $ft14, $zero
	fadd.s $ft0, $fa0, $ft14
# %op44 = fcmp ugt float %op40, %op43
	fld.s $ft14, $fp, -208
	fcmp.slt.s $fcc0, $ft0, $ft14
	bcnez $fcc0, 8
	b 12
	addi.w $t0, $zero, 1
	b 12
	addi.w $t0, $zero, 0
	b 4
# br i1 %op44, label %label48, label %label49
	bnez $t0, .gauss_label48
# %op50 = phi i32 [ %op36, %label35 ], [ %op37, %label48 ]
	ld.w $t7, $fp, -188
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -240
	b .gauss_label49
.gauss_label45:
# %op46 = phi i32 [ %op27, %label25 ], [ %op50, %label49 ]
# %op47 = icmp ne i32 %op46, %op27
	ld.w $t7, $fp, -232
	ld.w $t8, $fp, -160
	xor $t7, $t7, $t8
	sltu $t3, $zero, $t7
# br i1 %op47, label %label54, label %label56
	bnez $t3, .gauss_label54
	b .gauss_label56
.gauss_label48:
# br label %label49
# %op50 = phi i32 [ %op36, %label35 ], [ %op37, %label48 ]
	ld.w $t7, $fp, -192
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -240
	b .gauss_label49
.gauss_label49:
# %op50 = phi i32 [ %op36, %label35 ], [ %op37, %label48 ]
# %op51 = add i32 %op37, 1
	ld.w $t7, $fp, -192
	addi.w $t8, $zero, 1
	add.w $t7, $t7, $t8
	st.w $t7, $fp, -244
# %op52 = load i32, i32* %op5
	ld.d $t8, $fp, -80
	ld.w $t2, $t8, 0
# %op53 = icmp slt i32 %op51, %op52
	ld.w $t8, $fp, -244
	slt $t2, $t8, $t2
# br i1 %op53, label %label35, label %label45
# %op36 = phi i32 [ %op27, %label25 ], [ %op50, %label49 ]
	ld.w $t7, $fp, -240
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -188
# %op37 = phi i32 [ %op28, %label25 ], [ %op51, %label49 ]
	ld.w $t7, $fp, -244
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -192
	bnez $t2, .gauss_label35
# %op46 = phi i32 [ %op27, %label25 ], [ %op50, %label49 ]
	ld.w $t7, $fp, -240
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -232
	b .gauss_label45
.gauss_label54:
# %op55 = icmp slt i32 %op27, %op7
	ld.w $t7, $fp, -160
	ld.w $t8, $fp, -92
	slt $t3, $t7, $t8
# br i1 %op55, label %label61, label %label68
# %op62 = phi i32 [ %op27, %label54 ], [ %op84, %label83 ]
	ld.w $t7, $fp, -160
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -280
	bnez $t3, .gauss_label61
	b .gauss_label68
.gauss_label56:
# %op57 = load float*, float** %op4
	ld.d $t8, $fp, -64
	ld.d $t2, $t8, 0
# %op58 = call float @get(float* %op57, i32 %op27, i32 %op26, i32 %op7)
	add.d $a0, $t2, $zero
	ld.w $a1, $fp, -160
	ld.w $a2, $fp, -156
	ld.w $a3, $fp, -92
	bl get
	movgr2fr.w $ft14, $zero
	fadd.s $ft0, $fa0, $ft14
# %op59 = call float @isZero(float %op58)
	movgr2fr.w $ft14, $zero
	fadd.s $fa0, $ft0, $ft14
	bl isZero
	movgr2fr.w $ft14, $zero
	fadd.s $ft0, $fa0, $ft14
# %op60 = fcmp une float %op59, 0x0
	lu12i.w $t8, 0
	ori $t8, $t8, 0
	movgr2fr.w $ft15, $t8
	fcmp.sne.s $fcc0, $ft15, $ft0
	bcnez $fcc0, 8
	b 12
	addi.w $t0, $zero, 1
	b 12
	addi.w $t0, $zero, 0
	b 4
# br i1 %op60, label %label86, label %label88
	bnez $t0, .gauss_label86
	b .gauss_label88
.gauss_label61:
# %op62 = phi i32 [ %op27, %label54 ], [ %op84, %label83 ]
# %op63 = load float*, float** %op4
	ld.d $t8, $fp, -64
	ld.d $t4, $t8, 0
# %op64 = call float @get(float* %op63, i32 %op27, i32 %op62, i32 %op7)
	add.d $a0, $t4, $zero
	ld.w $a1, $fp, -160
	ld.w $a2, $fp, -280
	ld.w $a3, $fp, -92
	bl get
	fst.s $fa0, $fp, -292
# %op65 = mul i32 %op27, %op7
	ld.w $t7, $fp, -160
	ld.w $t8, $fp, -92
	mul.w $t0, $t7, $t8
# %op66 = add i32 %op65, %op62
	ld.w $t8, $fp, -280
	add.w $t0, $t0, $t8
# %op67 = icmp sge i32 %op66, 0
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t0
	xor $t8, $t8, $t0
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	or $t1, $t7, $t8
# br i1 %op67, label %label69, label %label72
	bnez $t1, .gauss_label69
	b .gauss_label72
.gauss_label68:
# br label %label56
	b .gauss_label56
.gauss_label69:
# %op70 = load float*, float** %op4
	ld.d $t8, $fp, -64
	ld.d $t1, $t8, 0
# %op71 = getelementptr float, float* %op70, i32 %op66
	addi.w $t7, $zero, 4
	mul.w $t7, $t0, $t7
	add.d $t7, $t1, $t7
	st.d $t7, $fp, -320
# br label %label73
	b .gauss_label73
.gauss_label72:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label73
	b .gauss_label73
.gauss_label73:
# %op74 = load float*, float** %op4
	ld.d $t8, $fp, -64
	ld.d $t1, $t8, 0
# %op75 = call float @get(float* %op74, i32 %op46, i32 %op62, i32 %op7)
	add.d $a0, $t1, $zero
	ld.w $a1, $fp, -232
	ld.w $a2, $fp, -280
	ld.w $a3, $fp, -92
	bl get
	movgr2fr.w $ft14, $zero
	fadd.s $ft0, $fa0, $ft14
# store float %op75, float* %op71
	ld.d $t7, $fp, -320
	fst.s $ft0, $t7, 0
# %op76 = mul i32 %op46, %op7
	ld.w $t7, $fp, -232
	ld.w $t8, $fp, -92
	mul.w $t0, $t7, $t8
# %op77 = add i32 %op76, %op62
	ld.w $t8, $fp, -280
	add.w $t0, $t0, $t8
# %op78 = icmp sge i32 %op77, 0
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t0
	xor $t8, $t8, $t0
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	or $t1, $t7, $t8
# br i1 %op78, label %label79, label %label82
	bnez $t1, .gauss_label79
	b .gauss_label82
.gauss_label79:
# %op80 = load float*, float** %op4
	ld.d $t8, $fp, -64
	ld.d $t1, $t8, 0
# %op81 = getelementptr float, float* %op80, i32 %op77
	addi.w $t7, $zero, 4
	mul.w $t7, $t0, $t7
	add.d $t7, $t1, $t7
	st.d $t7, $fp, -360
# br label %label83
	b .gauss_label83
.gauss_label82:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label83
	b .gauss_label83
.gauss_label83:
# store float %op64, float* %op81
	fld.s $ft14, $fp, -292
	ld.d $t7, $fp, -360
	fst.s $ft14, $t7, 0
# %op84 = add i32 %op62, 1
	ld.w $t7, $fp, -280
	addi.w $t8, $zero, 1
	add.w $t7, $t7, $t8
	st.w $t7, $fp, -364
# %op85 = icmp slt i32 %op84, %op7
	ld.w $t7, $fp, -364
	ld.w $t8, $fp, -92
	slt $t2, $t7, $t8
# br i1 %op85, label %label61, label %label68
# %op62 = phi i32 [ %op27, %label54 ], [ %op84, %label83 ]
	ld.w $t7, $fp, -364
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -280
	bnez $t2, .gauss_label61
	b .gauss_label68
.gauss_label86:
# %op87 = sub i32 %op27, 1
	ld.w $t7, $fp, -160
	addi.w $t8, $zero, 1
	sub.w $t7, $t7, $t8
	st.w $t7, $fp, -372
# br label %label92
# %op93 = phi i32 [ %op87, %label86 ], [ %op27, %label106 ]
	ld.w $t7, $fp, -372
	add.d $t2, $t7, $zero
	b .gauss_label92
.gauss_label88:
# %op89 = add i32 %op27, 1
	ld.w $t7, $fp, -160
	addi.w $t8, $zero, 1
	add.w $t7, $t7, $t8
	st.w $t7, $fp, -376
# %op90 = load i32, i32* %op5
	ld.d $t8, $fp, -80
	ld.w $t2, $t8, 0
# %op91 = icmp slt i32 %op89, %op90
	ld.w $t8, $fp, -376
	slt $t2, $t8, $t2
# br i1 %op91, label %label98, label %label106
# %op99 = phi i32 [ %op89, %label88 ], [ %op115, %label114 ]
	ld.w $t7, $fp, -376
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -408
	bnez $t2, .gauss_label98
	b .gauss_label106
.gauss_label92:
# %op93 = phi i32 [ %op87, %label86 ], [ %op27, %label106 ]
# %op94 = add i32 %op93, 1
	addi.w $t8, $zero, 1
	add.w $t2, $t2, $t8
# %op95 = add i32 %op26, 1
	ld.w $t7, $fp, -156
	addi.w $t8, $zero, 1
	add.w $t3, $t7, $t8
# %op96 = load i32, i32* %op5
	ld.d $t8, $fp, -80
	ld.w $t4, $t8, 0
# %op97 = icmp slt i32 %op94, %op96
	slt $t4, $t2, $t4
# br i1 %op97, label %label25, label %label31
# %op26 = phi i32 [ 0, %label13 ], [ %op95, %label92 ]
	add.d $t7, $t3, $zero
	st.w $t7, $fp, -156
# %op27 = phi i32 [ 0, %label13 ], [ %op94, %label92 ]
	add.d $t7, $t2, $zero
	st.w $t7, $fp, -160
	bnez $t4, .gauss_label25
	b .gauss_label31
.gauss_label98:
# %op99 = phi i32 [ %op89, %label88 ], [ %op115, %label114 ]
# %op100 = load float*, float** %op4
	ld.d $t8, $fp, -64
	ld.d $t3, $t8, 0
# %op101 = call float @get(float* %op100, i32 %op99, i32 %op26, i32 %op7)
	add.d $a0, $t3, $zero
	ld.w $a1, $fp, -408
	ld.w $a2, $fp, -156
	ld.w $a3, $fp, -92
	bl get
	movgr2fr.w $ft14, $zero
	fadd.s $ft0, $fa0, $ft14
# %op102 = call float @isZero(float %op101)
	movgr2fr.w $ft14, $zero
	fadd.s $fa0, $ft0, $ft14
	bl isZero
	movgr2fr.w $ft14, $zero
	fadd.s $ft0, $fa0, $ft14
# %op103 = sitofp i32 1 to float
	addi.w $t7, $zero, 1
	movgr2fr.w $ft14, $t7
	ffint.s.w $ft1, $ft14
# %op104 = fsub float %op103, %op102
	fsub.s $ft0, $ft1, $ft0
# %op105 = fcmp une float %op104, 0x0
	lu12i.w $t8, 0
	ori $t8, $t8, 0
	movgr2fr.w $ft15, $t8
	fcmp.sne.s $fcc0, $ft15, $ft0
	bcnez $fcc0, 8
	b 12
	addi.w $t0, $zero, 1
	b 12
	addi.w $t0, $zero, 0
	b 4
# br i1 %op105, label %label107, label %label114
	bnez $t0, .gauss_label107
	b .gauss_label114
.gauss_label106:
# br label %label92
# %op93 = phi i32 [ %op87, %label86 ], [ %op27, %label106 ]
	ld.w $t7, $fp, -160
	add.d $t2, $t7, $zero
	b .gauss_label92
.gauss_label107:
# %op108 = load float*, float** %op4
	ld.d $t8, $fp, -64
	ld.d $t0, $t8, 0
# %op109 = call float @get(float* %op108, i32 %op27, i32 %op26, i32 %op7)
	add.d $a0, $t0, $zero
	ld.w $a1, $fp, -160
	ld.w $a2, $fp, -156
	ld.w $a3, $fp, -92
	bl get
	fst.s $fa0, $fp, -452
# %op110 = load float*, float** %op4
	ld.d $t8, $fp, -64
	ld.d $t0, $t8, 0
# %op111 = call float @get(float* %op110, i32 %op99, i32 %op26, i32 %op7)
	add.d $a0, $t0, $zero
	ld.w $a1, $fp, -408
	ld.w $a2, $fp, -156
	ld.w $a3, $fp, -92
	bl get
	movgr2fr.w $ft14, $zero
	fadd.s $ft0, $fa0, $ft14
# %op112 = fdiv float %op111, %op109
	fld.s $ft14, $fp, -452
	fdiv.s $ft14, $ft0, $ft14
	fst.s $ft14, $fp, -472
# %op113 = icmp slt i32 %op26, %op7
	ld.w $t7, $fp, -156
	ld.w $t8, $fp, -92
	slt $t0, $t7, $t8
# br i1 %op113, label %label118, label %label123
# %op119 = phi i32 [ %op26, %label107 ], [ %op142, %label140 ]
	ld.w $t7, $fp, -156
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -492
	bnez $t0, .gauss_label118
	b .gauss_label123
.gauss_label114:
# %op115 = add i32 %op99, 1
	ld.w $t7, $fp, -408
	addi.w $t8, $zero, 1
	add.w $t1, $t7, $t8
# %op116 = load i32, i32* %op5
	ld.d $t8, $fp, -80
	ld.w $t2, $t8, 0
# %op117 = icmp slt i32 %op115, %op116
	slt $t2, $t1, $t2
# br i1 %op117, label %label98, label %label106
# %op99 = phi i32 [ %op89, %label88 ], [ %op115, %label114 ]
	add.d $t7, $t1, $zero
	st.w $t7, $fp, -408
	bnez $t2, .gauss_label98
	b .gauss_label106
.gauss_label118:
# %op119 = phi i32 [ %op26, %label107 ], [ %op142, %label140 ]
# %op120 = mul i32 %op99, %op7
	ld.w $t7, $fp, -408
	ld.w $t8, $fp, -92
	mul.w $t1, $t7, $t8
# %op121 = add i32 %op120, %op119
	ld.w $t8, $fp, -492
	add.w $t1, $t1, $t8
# %op122 = icmp sge i32 %op121, 0
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t1
	xor $t8, $t8, $t1
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	or $t2, $t7, $t8
# br i1 %op122, label %label124, label %label127
	bnez $t2, .gauss_label124
	b .gauss_label127
.gauss_label123:
# br label %label114
	b .gauss_label114
.gauss_label124:
# %op125 = load float*, float** %op4
	ld.d $t8, $fp, -64
	ld.d $t2, $t8, 0
# %op126 = getelementptr float, float* %op125, i32 %op121
	addi.w $t7, $zero, 4
	mul.w $t7, $t1, $t7
	add.d $t7, $t2, $t7
	st.d $t7, $fp, -520
# br label %label128
	b .gauss_label128
.gauss_label127:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label128
	b .gauss_label128
.gauss_label128:
# %op129 = load float*, float** %op4
	ld.d $t8, $fp, -64
	ld.d $t2, $t8, 0
# %op130 = call float @get(float* %op129, i32 %op27, i32 %op119, i32 %op7)
	add.d $a0, $t2, $zero
	ld.w $a1, $fp, -160
	ld.w $a2, $fp, -492
	ld.w $a3, $fp, -92
	bl get
	movgr2fr.w $ft14, $zero
	fadd.s $ft0, $fa0, $ft14
# %op131 = fmul float %op130, %op112
	fld.s $ft14, $fp, -472
	fmul.s $ft0, $ft0, $ft14
# %op132 = mul i32 %op99, %op7
	ld.w $t7, $fp, -408
	ld.w $t8, $fp, -92
	mul.w $t0, $t7, $t8
# %op133 = add i32 %op132, %op119
	ld.w $t8, $fp, -492
	add.w $t0, $t0, $t8
# %op134 = icmp sge i32 %op133, 0
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t0
	xor $t8, $t8, $t0
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	or $t1, $t7, $t8
# br i1 %op134, label %label135, label %label139
	bnez $t1, .gauss_label135
	b .gauss_label139
.gauss_label135:
# %op136 = load float*, float** %op4
	ld.d $t8, $fp, -64
	ld.d $t1, $t8, 0
# %op137 = getelementptr float, float* %op136, i32 %op133
	addi.w $t7, $zero, 4
	mul.w $t7, $t0, $t7
	add.d $t0, $t1, $t7
# %op138 = load float, float* %op137
	fld.s $ft1, $t0, 0
# br label %label140
	b .gauss_label140
.gauss_label139:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label140
	b .gauss_label140
.gauss_label140:
# %op141 = fsub float %op138, %op131
	fsub.s $ft0, $ft1, $ft0
# store float %op141, float* %op126
	ld.d $t7, $fp, -520
	fst.s $ft0, $t7, 0
# %op142 = add i32 %op119, 1
	ld.w $t7, $fp, -492
	addi.w $t8, $zero, 1
	add.w $t0, $t7, $t8
# %op143 = icmp slt i32 %op142, %op7
	ld.w $t8, $fp, -92
	slt $t1, $t0, $t8
# br i1 %op143, label %label118, label %label123
# %op119 = phi i32 [ %op26, %label107 ], [ %op142, %label140 ]
	add.d $t7, $t0, $zero
	st.w $t7, $fp, -492
	bnez $t1, .gauss_label118
	b .gauss_label123
.gauss_label144:
# %op145 = phi i32 [ %op33, %label31 ], [ %op190, %label186 ]
# %op146 = load float*, float** %op4
	ld.d $t8, $fp, -64
	ld.d $t2, $t8, 0
# %op147 = load i32, i32* %op5
	ld.d $t8, $fp, -80
	ld.w $t3, $t8, 0
# %op148 = call float @get(float* %op146, i32 %op145, i32 %op147, i32 %op7)
	add.d $a0, $t2, $zero
	ld.w $a1, $fp, -588
	add.d $a2, $t3, $zero
	ld.w $a3, $fp, -92
	bl get
	fst.s $fa0, $fp, -608
# %op149 = add i32 %op145, 1
	ld.w $t7, $fp, -588
	addi.w $t8, $zero, 1
	add.w $t7, $t7, $t8
	st.w $t7, $fp, -612
# %op150 = load i32, i32* %op5
	ld.d $t8, $fp, -80
	ld.w $t1, $t8, 0
# %op151 = icmp slt i32 %op149, %op150
	ld.w $t8, $fp, -612
	slt $t1, $t8, $t1
# br i1 %op151, label %label153, label %label162
# %op154 = phi float [ %op148, %label144 ], [ %op168, %label167 ]
	fld.s $ft15, $fp, -608
	movgr2fr.w $ft14, $zero
	fadd.s $ft15, $ft15, $ft14
	fst.s $ft15, $fp, -624
# %op155 = phi i32 [ %op149, %label144 ], [ %op169, %label167 ]
	ld.w $t7, $fp, -612
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -628
	bnez $t1, .gauss_label153
# %op163 = phi float [ %op148, %label144 ], [ %op168, %label167 ]
	fld.s $ft15, $fp, -608
	movgr2fr.w $ft14, $zero
	fadd.s $ft15, $ft15, $ft14
	fst.s $ft15, $fp, -664
	b .gauss_label162
.gauss_label152:
# ret i32 0
	addi.w $a0, $zero, 0
	b gauss_exit
.gauss_label153:
# %op154 = phi float [ %op148, %label144 ], [ %op168, %label167 ]
# %op155 = phi i32 [ %op149, %label144 ], [ %op169, %label167 ]
# %op156 = load float*, float** %op4
	ld.d $t8, $fp, -64
	ld.d $t2, $t8, 0
# %op157 = call float @get(float* %op156, i32 %op145, i32 %op155, i32 %op7)
	add.d $a0, $t2, $zero
	ld.w $a1, $fp, -588
	ld.w $a2, $fp, -628
	ld.w $a3, $fp, -92
	bl get
	movgr2fr.w $ft14, $zero
	fadd.s $ft0, $fa0, $ft14
# %op158 = call float @isZero(float %op157)
	movgr2fr.w $ft14, $zero
	fadd.s $fa0, $ft0, $ft14
	bl isZero
	movgr2fr.w $ft14, $zero
	fadd.s $ft0, $fa0, $ft14
# %op159 = sitofp i32 1 to float
	addi.w $t7, $zero, 1
	movgr2fr.w $ft14, $t7
	ffint.s.w $ft1, $ft14
# %op160 = fsub float %op159, %op158
	fsub.s $ft0, $ft1, $ft0
# %op161 = fcmp une float %op160, 0x0
	lu12i.w $t8, 0
	ori $t8, $t8, 0
	movgr2fr.w $ft15, $t8
	fcmp.sne.s $fcc0, $ft15, $ft0
	bcnez $fcc0, 8
	b 12
	addi.w $t0, $zero, 1
	b 12
	addi.w $t0, $zero, 0
	b 4
# br i1 %op161, label %label165, label %label167
	bnez $t0, .gauss_label165
# %op168 = phi float [ %op154, %label153 ], [ %op181, %label177 ]
	fld.s $ft15, $fp, -624
	movgr2fr.w $ft14, $zero
	fadd.s $ft15, $ft15, $ft14
	fst.s $ft15, $fp, -672
	b .gauss_label167
.gauss_label162:
# %op163 = phi float [ %op148, %label144 ], [ %op168, %label167 ]
# %op164 = icmp sge i32 %op145, 0
	ld.w $t7, $fp, -588
	addi.w $t8, $zero, 0
	slt $t1, $t8, $t7
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	or $t1, $t1, $t8
# br i1 %op164, label %label182, label %label185
	bnez $t1, .gauss_label182
	b .gauss_label185
.gauss_label165:
# %op166 = icmp sge i32 %op155, 0
	ld.w $t7, $fp, -628
	addi.w $t8, $zero, 0
	slt $t0, $t8, $t7
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	or $t0, $t0, $t8
# br i1 %op166, label %label172, label %label176
	bnez $t0, .gauss_label172
	b .gauss_label176
.gauss_label167:
# %op168 = phi float [ %op154, %label153 ], [ %op181, %label177 ]
# %op169 = add i32 %op155, 1
	ld.w $t7, $fp, -628
	addi.w $t8, $zero, 1
	add.w $t7, $t7, $t8
	st.w $t7, $fp, -676
# %op170 = load i32, i32* %op5
	ld.d $t8, $fp, -80
	ld.w $t1, $t8, 0
# %op171 = icmp slt i32 %op169, %op170
	ld.w $t8, $fp, -676
	slt $t1, $t8, $t1
# br i1 %op171, label %label153, label %label162
# %op154 = phi float [ %op148, %label144 ], [ %op168, %label167 ]
	fld.s $ft15, $fp, -672
	movgr2fr.w $ft14, $zero
	fadd.s $ft15, $ft15, $ft14
	fst.s $ft15, $fp, -624
# %op155 = phi i32 [ %op149, %label144 ], [ %op169, %label167 ]
	ld.w $t7, $fp, -676
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -628
	bnez $t1, .gauss_label153
# %op163 = phi float [ %op148, %label144 ], [ %op168, %label167 ]
	fld.s $ft15, $fp, -672
	movgr2fr.w $ft14, $zero
	fadd.s $ft15, $ft15, $ft14
	fst.s $ft15, $fp, -664
	b .gauss_label162
.gauss_label172:
# %op173 = load float*, float** %op3
	ld.d $t8, $fp, -48
	ld.d $t0, $t8, 0
# %op174 = getelementptr float, float* %op173, i32 %op155
	ld.w $t8, $fp, -628
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	add.d $t0, $t0, $t7
# %op175 = load float, float* %op174
	fld.s $ft14, $t0, 0
	fst.s $ft14, $fp, -708
# br label %label177
	b .gauss_label177
.gauss_label176:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label177
	b .gauss_label177
.gauss_label177:
# %op178 = load float*, float** %op4
	ld.d $t8, $fp, -64
	ld.d $t0, $t8, 0
# %op179 = call float @get(float* %op178, i32 %op145, i32 %op155, i32 %op7)
	add.d $a0, $t0, $zero
	ld.w $a1, $fp, -588
	ld.w $a2, $fp, -628
	ld.w $a3, $fp, -92
	bl get
	movgr2fr.w $ft14, $zero
	fadd.s $ft0, $fa0, $ft14
# %op180 = fmul float %op179, %op175
	fld.s $ft14, $fp, -708
	fmul.s $ft0, $ft0, $ft14
# %op181 = fsub float %op154, %op180
	fld.s $ft14, $fp, -624
	fsub.s $ft14, $ft14, $ft0
	fst.s $ft14, $fp, -732
# br label %label167
# %op168 = phi float [ %op154, %label153 ], [ %op181, %label177 ]
	fld.s $ft15, $fp, -732
	movgr2fr.w $ft14, $zero
	fadd.s $ft15, $ft15, $ft14
	fst.s $ft15, $fp, -672
	b .gauss_label167
.gauss_label182:
# %op183 = load float*, float** %op3
	ld.d $t8, $fp, -48
	ld.d $t1, $t8, 0
# %op184 = getelementptr float, float* %op183, i32 %op145
	ld.w $t8, $fp, -588
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	add.d $t7, $t1, $t7
	st.d $t7, $fp, -752
# br label %label186
	b .gauss_label186
.gauss_label185:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label186
	b .gauss_label186
.gauss_label186:
# %op187 = load float*, float** %op4
	ld.d $t8, $fp, -64
	ld.d $t2, $t8, 0
# %op188 = call float @get(float* %op187, i32 %op145, i32 %op145, i32 %op7)
	add.d $a0, $t2, $zero
	ld.w $a1, $fp, -588
	ld.w $a2, $fp, -588
	ld.w $a3, $fp, -92
	bl get
	movgr2fr.w $ft14, $zero
	fadd.s $ft0, $fa0, $ft14
# %op189 = fdiv float %op163, %op188
	fld.s $ft14, $fp, -664
	fdiv.s $ft0, $ft14, $ft0
# store float %op189, float* %op184
	ld.d $t7, $fp, -752
	fst.s $ft0, $t7, 0
# %op190 = sub i32 %op145, 1
	ld.w $t7, $fp, -588
	addi.w $t8, $zero, 1
	sub.w $t0, $t7, $t8
# %op191 = icmp sge i32 %op190, 0
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t0
	xor $t8, $t8, $t0
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	or $t1, $t7, $t8
# br i1 %op191, label %label144, label %label152
# %op145 = phi i32 [ %op33, %label31 ], [ %op190, %label186 ]
	add.d $t7, $t0, $zero
	st.w $t7, $fp, -588
	bnez $t1, .gauss_label144
	b .gauss_label152
gauss_exit:
	addi.d $sp, $sp, 784
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -432
.main_label_entry:
# %op0 = alloca [3 x float]
	addi.d $t8, $fp, -36
	addi.d $t7, $fp, -24
	st.d $t8, $t7, 0
# %op1 = alloca [12 x float]
	addi.d $t1, $fp, -96
# %op2 = icmp sge i32 0, 0
	addi.w $t7, $zero, 0
	addi.w $t8, $zero, 0
	slt $t2, $t8, $t7
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	or $t2, $t2, $t8
# br i1 %op2, label %label3, label %label5
	bnez $t2, .main_label3
	b .main_label5
.main_label3:
# %op4 = getelementptr [12 x float], [12 x float]* %op1, i32 0, i32 0
	addi.w $t8, $zero, 0
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	add.d $t2, $t1, $t7
# br label %label6
	b .main_label6
.main_label5:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label6
	b .main_label6
.main_label6:
# %op7 = sitofp i32 1 to float
	addi.w $t7, $zero, 1
	movgr2fr.w $ft14, $t7
	ffint.s.w $ft0, $ft14
# store float %op7, float* %op4
	fst.s $ft0, $t2, 0
# %op8 = icmp sge i32 1, 0
	addi.w $t7, $zero, 1
	addi.w $t8, $zero, 0
	slt $t2, $t8, $t7
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	or $t2, $t2, $t8
# br i1 %op8, label %label9, label %label11
	bnez $t2, .main_label9
	b .main_label11
.main_label9:
# %op10 = getelementptr [12 x float], [12 x float]* %op1, i32 0, i32 1
	addi.w $t8, $zero, 1
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	add.d $t2, $t1, $t7
# br label %label12
	b .main_label12
.main_label11:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label12
	b .main_label12
.main_label12:
# %op13 = sitofp i32 2 to float
	addi.w $t7, $zero, 2
	movgr2fr.w $ft14, $t7
	ffint.s.w $ft0, $ft14
# store float %op13, float* %op10
	fst.s $ft0, $t2, 0
# %op14 = icmp sge i32 2, 0
	addi.w $t7, $zero, 2
	addi.w $t8, $zero, 0
	slt $t2, $t8, $t7
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	or $t2, $t2, $t8
# br i1 %op14, label %label15, label %label17
	bnez $t2, .main_label15
	b .main_label17
.main_label15:
# %op16 = getelementptr [12 x float], [12 x float]* %op1, i32 0, i32 2
	addi.w $t8, $zero, 2
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	add.d $t2, $t1, $t7
# br label %label18
	b .main_label18
.main_label17:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label18
	b .main_label18
.main_label18:
# %op19 = sitofp i32 1 to float
	addi.w $t7, $zero, 1
	movgr2fr.w $ft14, $t7
	ffint.s.w $ft0, $ft14
# store float %op19, float* %op16
	fst.s $ft0, $t2, 0
# %op20 = icmp sge i32 3, 0
	addi.w $t7, $zero, 3
	addi.w $t8, $zero, 0
	slt $t2, $t8, $t7
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	or $t2, $t2, $t8
# br i1 %op20, label %label21, label %label23
	bnez $t2, .main_label21
	b .main_label23
.main_label21:
# %op22 = getelementptr [12 x float], [12 x float]* %op1, i32 0, i32 3
	addi.w $t8, $zero, 3
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	add.d $t2, $t1, $t7
# br label %label24
	b .main_label24
.main_label23:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label24
	b .main_label24
.main_label24:
# %op25 = sitofp i32 1 to float
	addi.w $t7, $zero, 1
	movgr2fr.w $ft14, $t7
	ffint.s.w $ft0, $ft14
# store float %op25, float* %op22
	fst.s $ft0, $t2, 0
# %op26 = mul i32 1, 4
	addi.w $t7, $zero, 1
	addi.w $t8, $zero, 4
	mul.w $t2, $t7, $t8
# %op27 = add i32 %op26, 0
	addi.w $t8, $zero, 0
	add.w $t2, $t2, $t8
# %op28 = icmp sge i32 %op27, 0
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t2
	xor $t8, $t8, $t2
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	or $t3, $t7, $t8
# br i1 %op28, label %label29, label %label31
	bnez $t3, .main_label29
	b .main_label31
.main_label29:
# %op30 = getelementptr [12 x float], [12 x float]* %op1, i32 0, i32 %op27
	addi.w $t7, $zero, 4
	mul.w $t7, $t2, $t7
	add.d $t2, $t1, $t7
# br label %label32
	b .main_label32
.main_label31:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label32
	b .main_label32
.main_label32:
# %op33 = sitofp i32 2 to float
	addi.w $t7, $zero, 2
	movgr2fr.w $ft14, $t7
	ffint.s.w $ft0, $ft14
# store float %op33, float* %op30
	fst.s $ft0, $t2, 0
# %op34 = mul i32 1, 4
	addi.w $t7, $zero, 1
	addi.w $t8, $zero, 4
	mul.w $t2, $t7, $t8
# %op35 = add i32 %op34, 1
	addi.w $t8, $zero, 1
	add.w $t2, $t2, $t8
# %op36 = icmp sge i32 %op35, 0
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t2
	xor $t8, $t8, $t2
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	or $t3, $t7, $t8
# br i1 %op36, label %label37, label %label39
	bnez $t3, .main_label37
	b .main_label39
.main_label37:
# %op38 = getelementptr [12 x float], [12 x float]* %op1, i32 0, i32 %op35
	addi.w $t7, $zero, 4
	mul.w $t7, $t2, $t7
	add.d $t2, $t1, $t7
# br label %label40
	b .main_label40
.main_label39:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label40
	b .main_label40
.main_label40:
# %op41 = sitofp i32 3 to float
	addi.w $t7, $zero, 3
	movgr2fr.w $ft14, $t7
	ffint.s.w $ft0, $ft14
# store float %op41, float* %op38
	fst.s $ft0, $t2, 0
# %op42 = mul i32 1, 4
	addi.w $t7, $zero, 1
	addi.w $t8, $zero, 4
	mul.w $t2, $t7, $t8
# %op43 = add i32 %op42, 2
	addi.w $t8, $zero, 2
	add.w $t2, $t2, $t8
# %op44 = icmp sge i32 %op43, 0
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t2
	xor $t8, $t8, $t2
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	or $t3, $t7, $t8
# br i1 %op44, label %label45, label %label47
	bnez $t3, .main_label45
	b .main_label47
.main_label45:
# %op46 = getelementptr [12 x float], [12 x float]* %op1, i32 0, i32 %op43
	addi.w $t7, $zero, 4
	mul.w $t7, $t2, $t7
	add.d $t2, $t1, $t7
# br label %label48
	b .main_label48
.main_label47:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label48
	b .main_label48
.main_label48:
# %op49 = sitofp i32 4 to float
	addi.w $t7, $zero, 4
	movgr2fr.w $ft14, $t7
	ffint.s.w $ft0, $ft14
# store float %op49, float* %op46
	fst.s $ft0, $t2, 0
# %op50 = mul i32 1, 4
	addi.w $t7, $zero, 1
	addi.w $t8, $zero, 4
	mul.w $t2, $t7, $t8
# %op51 = add i32 %op50, 3
	addi.w $t8, $zero, 3
	add.w $t2, $t2, $t8
# %op52 = icmp sge i32 %op51, 0
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t2
	xor $t8, $t8, $t2
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	or $t3, $t7, $t8
# br i1 %op52, label %label53, label %label55
	bnez $t3, .main_label53
	b .main_label55
.main_label53:
# %op54 = getelementptr [12 x float], [12 x float]* %op1, i32 0, i32 %op51
	addi.w $t7, $zero, 4
	mul.w $t7, $t2, $t7
	add.d $t2, $t1, $t7
# br label %label56
	b .main_label56
.main_label55:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label56
	b .main_label56
.main_label56:
# %op57 = sitofp i32 3 to float
	addi.w $t7, $zero, 3
	movgr2fr.w $ft14, $t7
	ffint.s.w $ft0, $ft14
# store float %op57, float* %op54
	fst.s $ft0, $t2, 0
# %op58 = mul i32 2, 4
	addi.w $t7, $zero, 2
	addi.w $t8, $zero, 4
	mul.w $t2, $t7, $t8
# %op59 = add i32 %op58, 0
	addi.w $t8, $zero, 0
	add.w $t2, $t2, $t8
# %op60 = icmp sge i32 %op59, 0
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t2
	xor $t8, $t8, $t2
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	or $t3, $t7, $t8
# br i1 %op60, label %label61, label %label63
	bnez $t3, .main_label61
	b .main_label63
.main_label61:
# %op62 = getelementptr [12 x float], [12 x float]* %op1, i32 0, i32 %op59
	addi.w $t7, $zero, 4
	mul.w $t7, $t2, $t7
	add.d $t2, $t1, $t7
# br label %label64
	b .main_label64
.main_label63:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label64
	b .main_label64
.main_label64:
# %op65 = sitofp i32 1 to float
	addi.w $t7, $zero, 1
	movgr2fr.w $ft14, $t7
	ffint.s.w $ft0, $ft14
# store float %op65, float* %op62
	fst.s $ft0, $t2, 0
# %op66 = mul i32 2, 4
	addi.w $t7, $zero, 2
	addi.w $t8, $zero, 4
	mul.w $t2, $t7, $t8
# %op67 = add i32 %op66, 1
	addi.w $t8, $zero, 1
	add.w $t2, $t2, $t8
# %op68 = icmp sge i32 %op67, 0
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t2
	xor $t8, $t8, $t2
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	or $t3, $t7, $t8
# br i1 %op68, label %label69, label %label71
	bnez $t3, .main_label69
	b .main_label71
.main_label69:
# %op70 = getelementptr [12 x float], [12 x float]* %op1, i32 0, i32 %op67
	addi.w $t7, $zero, 4
	mul.w $t7, $t2, $t7
	add.d $t2, $t1, $t7
# br label %label72
	b .main_label72
.main_label71:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label72
	b .main_label72
.main_label72:
# %op73 = sitofp i32 1 to float
	addi.w $t7, $zero, 1
	movgr2fr.w $ft14, $t7
	ffint.s.w $ft0, $ft14
# store float %op73, float* %op70
	fst.s $ft0, $t2, 0
# %op74 = mul i32 2, 4
	addi.w $t7, $zero, 2
	addi.w $t8, $zero, 4
	mul.w $t2, $t7, $t8
# %op75 = add i32 %op74, 2
	addi.w $t8, $zero, 2
	add.w $t2, $t2, $t8
# %op76 = icmp sge i32 %op75, 0
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t2
	xor $t8, $t8, $t2
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	or $t3, $t7, $t8
# br i1 %op76, label %label77, label %label79
	bnez $t3, .main_label77
	b .main_label79
.main_label77:
# %op78 = getelementptr [12 x float], [12 x float]* %op1, i32 0, i32 %op75
	addi.w $t7, $zero, 4
	mul.w $t7, $t2, $t7
	add.d $t2, $t1, $t7
# br label %label80
	b .main_label80
.main_label79:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label80
	b .main_label80
.main_label80:
# %op81 = sub i32 0, 2
	addi.w $t7, $zero, 0
	addi.w $t8, $zero, 2
	sub.w $t3, $t7, $t8
# %op82 = sitofp i32 %op81 to float
	movgr2fr.w $ft14, $t3
	ffint.s.w $ft0, $ft14
# store float %op82, float* %op78
	fst.s $ft0, $t2, 0
# %op83 = mul i32 2, 4
	addi.w $t7, $zero, 2
	addi.w $t8, $zero, 4
	mul.w $t2, $t7, $t8
# %op84 = add i32 %op83, 3
	addi.w $t8, $zero, 3
	add.w $t2, $t2, $t8
# %op85 = icmp sge i32 %op84, 0
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t2
	xor $t8, $t8, $t2
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	or $t3, $t7, $t8
# br i1 %op85, label %label86, label %label88
	bnez $t3, .main_label86
	b .main_label88
.main_label86:
# %op87 = getelementptr [12 x float], [12 x float]* %op1, i32 0, i32 %op84
	addi.w $t7, $zero, 4
	mul.w $t7, $t2, $t7
	add.d $t2, $t1, $t7
# br label %label89
	b .main_label89
.main_label88:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label89
	b .main_label89
.main_label89:
# %op90 = sitofp i32 0 to float
	addi.w $t7, $zero, 0
	movgr2fr.w $ft14, $t7
	ffint.s.w $ft0, $ft14
# store float %op90, float* %op87
	fst.s $ft0, $t2, 0
# %op91 = getelementptr [3 x float], [3 x float]* %op0, i32 0, i32 0
	addi.w $t8, $zero, 0
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	ld.d $t8, $fp, -24
	add.d $t2, $t8, $t7
# %op92 = getelementptr [12 x float], [12 x float]* %op1, i32 0, i32 0
	addi.w $t8, $zero, 0
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	add.d $t1, $t1, $t7
# %op93 = call i32 @gauss(float* %op91, float* %op92, i32 3)
	add.d $a0, $t2, $zero
	add.d $a1, $t1, $zero
	addi.w $a2, $zero, 3
	bl gauss
	add.w $t0, $a0, $zero
# %op94 = icmp slt i32 0, 3
	addi.w $t7, $zero, 0
	addi.w $t8, $zero, 3
	slt $t0, $t7, $t8
# br i1 %op94, label %label95, label %label98
# %op96 = phi i32 [ 0, %label89 ], [ %op104, %label103 ]
	addi.w $t7, $zero, 0
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -396
	bnez $t0, .main_label95
	b .main_label98
.main_label95:
# %op96 = phi i32 [ 0, %label89 ], [ %op104, %label103 ]
# %op97 = icmp sge i32 %op96, 0
	ld.w $t7, $fp, -396
	addi.w $t8, $zero, 0
	slt $t1, $t8, $t7
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	or $t1, $t1, $t8
# br i1 %op97, label %label99, label %label102
	bnez $t1, .main_label99
	b .main_label102
.main_label98:
# ret void
	addi.w $a0, $zero, 0
	b main_exit
.main_label99:
# %op100 = getelementptr [3 x float], [3 x float]* %op0, i32 0, i32 %op96
	ld.w $t8, $fp, -396
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	ld.d $t8, $fp, -24
	add.d $t1, $t8, $t7
# %op101 = load float, float* %op100
	fld.s $ft14, $t1, 0
	fst.s $ft14, $fp, -412
# br label %label103
	b .main_label103
.main_label102:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label103
	b .main_label103
.main_label103:
# call void @outputFloat(float %op101)
	fld.s $fa0, $fp, -412
	bl outputFloat
# %op104 = add i32 %op96, 1
	ld.w $t7, $fp, -396
	addi.w $t8, $zero, 1
	add.w $t0, $t7, $t8
# %op105 = icmp slt i32 %op104, 3
	addi.w $t8, $zero, 3
	slt $t1, $t0, $t8
# br i1 %op105, label %label95, label %label98
# %op96 = phi i32 [ 0, %label89 ], [ %op104, %label103 ]
	add.d $t7, $t0, $zero
	st.w $t7, $fp, -396
	bnez $t1, .main_label95
	b .main_label98
main_exit:
	addi.d $sp, $sp, 432
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
