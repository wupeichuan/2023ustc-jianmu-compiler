# Global variables
	.text
	.section .bss, "aw", @nobits
	.globl x
	.type x, @object
	.size x, 40
x:
	.space 40
	.text
	.globl minloc
	.type minloc, @function
minloc:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -240
	add.d $t0, $a0, $zero
	movgr2fr.w $ft14, $zero
	fadd.s $ft0, $fa1, $ft14
	add.d $t1, $a2, $zero
.minloc_label_entry:
# %op3 = alloca float*
	addi.d $t8, $fp, -48
	addi.d $t7, $fp, -40
	st.d $t8, $t7, 0
# store float* %arg0, float** %op3
	ld.d $t7, $fp, -40
	st.d $t0, $t7, 0
# %op4 = alloca float
	addi.d $t8, $fp, -60
	addi.d $t7, $fp, -56
	st.d $t8, $t7, 0
# store float %arg1, float* %op4
	ld.d $t7, $fp, -56
	fst.s $ft0, $t7, 0
# %op5 = alloca i32
	addi.d $t8, $fp, -76
	addi.d $t7, $fp, -72
	st.d $t8, $t7, 0
# store i32 %arg2, i32* %op5
	ld.d $t7, $fp, -72
	st.w $t1, $t7, 0
# %op6 = load float, float* %op4
	ld.d $t8, $fp, -56
	fld.s $ft0, $t8, 0
# %op7 = fptosi float %op6 to i32
	ftintrz.w.s $ft14, $ft0
	movfr2gr.s $t7, $ft14
	st.w $t7, $fp, -84
# %op8 = load float, float* %op4
	ld.d $t8, $fp, -56
	fld.s $ft0, $t8, 0
# %op9 = fptosi float %op8 to i32
	ftintrz.w.s $ft14, $ft0
	movfr2gr.s $t4, $ft14
# %op10 = icmp sge i32 %op9, 0
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t4
	xor $t8, $t8, $t4
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	or $t5, $t7, $t8
# br i1 %op10, label %label11, label %label15
	bnez $t5, .minloc_label11
	b .minloc_label15
.minloc_label11:
# %op12 = load float*, float** %op3
	ld.d $t8, $fp, -40
	ld.d $t5, $t8, 0
# %op13 = getelementptr float, float* %op12, i32 %op9
	addi.w $t7, $zero, 4
	mul.w $t7, $t4, $t7
	add.d $t4, $t5, $t7
# %op14 = load float, float* %op13
	fld.s $ft14, $t4, 0
	fst.s $ft14, $fp, -116
# br label %label16
	b .minloc_label16
.minloc_label15:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label16
	b .minloc_label16
.minloc_label16:
# %op17 = fptosi float %op14 to i32
	fld.s $ft14, $fp, -116
	ftintrz.w.s $ft15, $ft14
	movfr2gr.s $t7, $ft15
	st.w $t7, $fp, -120
# %op18 = load float, float* %op4
	ld.d $t8, $fp, -56
	fld.s $ft14, $t8, 0
	fst.s $ft14, $fp, -124
# %op19 = sitofp i32 1 to float
	addi.w $t7, $zero, 1
	movgr2fr.w $ft14, $t7
	ffint.s.w $ft15, $ft14
	fst.s $ft15, $fp, -128
# %op20 = fadd float %op18, %op19
	fld.s $ft14, $fp, -124
	fld.s $ft15, $fp, -128
	fadd.s $ft14, $ft14, $ft15
	fst.s $ft14, $fp, -132
# %op21 = fptosi float %op20 to i32
	fld.s $ft14, $fp, -132
	ftintrz.w.s $ft15, $ft14
	movfr2gr.s $t7, $ft15
	st.w $t7, $fp, -136
# %op22 = load i32, i32* %op5
	ld.d $t8, $fp, -72
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -140
# %op23 = icmp slt i32 %op21, %op22
	ld.w $t7, $fp, -136
	ld.w $t8, $fp, -140
	slt $t7, $t7, $t8
	st.b $t7, $fp, -141
# br i1 %op23, label %label24, label %label29
# %op25 = phi i32 [ %op7, %label16 ], [ %op42, %label41 ]
	ld.w $t7, $fp, -84
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -148
# %op26 = phi i32 [ %op17, %label16 ], [ %op43, %label41 ]
	ld.w $t7, $fp, -120
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -152
# %op27 = phi i32 [ %op21, %label16 ], [ %op44, %label41 ]
	ld.w $t7, $fp, -136
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -156
	ld.b $t7, $fp, -141
	bnez $t7, .minloc_label24
# %op30 = phi i32 [ %op7, %label16 ], [ %op42, %label41 ]
	ld.w $t7, $fp, -84
	add.d $t0, $t7, $zero
	b .minloc_label29
.minloc_label24:
# %op25 = phi i32 [ %op7, %label16 ], [ %op42, %label41 ]
# %op26 = phi i32 [ %op17, %label16 ], [ %op43, %label41 ]
# %op27 = phi i32 [ %op21, %label16 ], [ %op44, %label41 ]
# %op28 = icmp sge i32 %op27, 0
	ld.w $t7, $fp, -156
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t7
	st.b $t7, $fp, -157
	ld.w $t7, $fp, -156
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	ld.b $t7, $fp, -157
	or $t7, $t7, $t8
	st.b $t7, $fp, -157
# br i1 %op28, label %label31, label %label35
	ld.b $t7, $fp, -157
	bnez $t7, .minloc_label31
	b .minloc_label35
.minloc_label29:
# %op30 = phi i32 [ %op7, %label16 ], [ %op42, %label41 ]
# ret i32 %op30
	add.w $a0, $t0, $zero
	b minloc_exit
.minloc_label31:
# %op32 = load float*, float** %op3
	ld.d $t8, $fp, -40
	ld.d $t7, $t8, 0
	st.d $t7, $fp, -176
# %op33 = getelementptr float, float* %op32, i32 %op27
	ld.w $t8, $fp, -156
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	ld.d $t8, $fp, -176
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -184
# %op34 = load float, float* %op33
	ld.d $t8, $fp, -184
	fld.s $ft14, $t8, 0
	fst.s $ft14, $fp, -188
# br label %label36
	b .minloc_label36
.minloc_label35:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label36
	b .minloc_label36
.minloc_label36:
# %op37 = sitofp i32 %op26 to float
	ld.w $t7, $fp, -152
	movgr2fr.w $ft14, $t7
	ffint.s.w $ft15, $ft14
	fst.s $ft15, $fp, -192
# %op38 = fcmp ult float %op34, %op37
	fld.s $ft14, $fp, -188
	fld.s $ft15, $fp, -192
	fcmp.slt.s $fcc0, $ft14, $ft15
	bcnez $fcc0, 8
	b 12
	addi.w $t7, $zero, 1
	b 12
	addi.w $t7, $zero, 0
	b 4
	st.b $t7, $fp, -193
# br i1 %op38, label %label39, label %label41
	ld.b $t7, $fp, -193
	bnez $t7, .minloc_label39
# %op42 = phi i32 [ %op25, %label36 ], [ %op27, %label52 ]
	ld.w $t7, $fp, -148
	add.d $t1, $t7, $zero
# %op43 = phi i32 [ %op26, %label36 ], [ %op53, %label52 ]
	ld.w $t7, $fp, -152
	add.d $t2, $t7, $zero
	b .minloc_label41
.minloc_label39:
# %op40 = icmp sge i32 %op27, 0
	ld.w $t7, $fp, -156
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t7
	st.b $t7, $fp, -194
	ld.w $t7, $fp, -156
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	ld.b $t7, $fp, -194
	or $t7, $t7, $t8
	st.b $t7, $fp, -194
# br i1 %op40, label %label47, label %label51
	ld.b $t7, $fp, -194
	bnez $t7, .minloc_label47
	b .minloc_label51
.minloc_label41:
# %op42 = phi i32 [ %op25, %label36 ], [ %op27, %label52 ]
# %op43 = phi i32 [ %op26, %label36 ], [ %op53, %label52 ]
# %op44 = add i32 %op27, 1
	ld.w $t7, $fp, -156
	addi.w $t8, $zero, 1
	add.w $t3, $t7, $t8
# %op45 = load i32, i32* %op5
	ld.d $t8, $fp, -72
	ld.w $t4, $t8, 0
# %op46 = icmp slt i32 %op44, %op45
	slt $t4, $t3, $t4
# br i1 %op46, label %label24, label %label29
# %op25 = phi i32 [ %op7, %label16 ], [ %op42, %label41 ]
	add.d $t7, $t1, $zero
	st.w $t7, $fp, -148
# %op27 = phi i32 [ %op21, %label16 ], [ %op44, %label41 ]
	add.d $t7, $t3, $zero
	st.w $t7, $fp, -156
# %op26 = phi i32 [ %op17, %label16 ], [ %op43, %label41 ]
	add.d $t7, $t2, $zero
	st.w $t7, $fp, -152
	bnez $t4, .minloc_label24
# %op30 = phi i32 [ %op7, %label16 ], [ %op42, %label41 ]
	add.d $t0, $t1, $zero
	b .minloc_label29
.minloc_label47:
# %op48 = load float*, float** %op3
	ld.d $t8, $fp, -40
	ld.d $t7, $t8, 0
	st.d $t7, $fp, -224
# %op49 = getelementptr float, float* %op48, i32 %op27
	ld.w $t8, $fp, -156
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	ld.d $t8, $fp, -224
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -232
# %op50 = load float, float* %op49
	ld.d $t8, $fp, -232
	fld.s $ft14, $t8, 0
	fst.s $ft14, $fp, -236
# br label %label52
	b .minloc_label52
.minloc_label51:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label52
	b .minloc_label52
.minloc_label52:
# %op53 = fptosi float %op50 to i32
	fld.s $ft14, $fp, -236
	ftintrz.w.s $ft15, $ft14
	movfr2gr.s $t0, $ft15
# br label %label41
# %op42 = phi i32 [ %op25, %label36 ], [ %op27, %label52 ]
	ld.w $t7, $fp, -156
	add.d $t1, $t7, $zero
# %op43 = phi i32 [ %op26, %label36 ], [ %op53, %label52 ]
	add.d $t2, $t0, $zero
	b .minloc_label41
minloc_exit:
	addi.d $sp, $sp, 240
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl sort
	.type sort, @function
sort:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -272
	st.d $a0, $fp, -24
	st.w $a1, $fp, -28
	fst.s $fa0, $fp, -32
.sort_label_entry:
# %op3 = alloca float*
	addi.d $t8, $fp, -48
	addi.d $t7, $fp, -40
	st.d $t8, $t7, 0
# store float* %arg0, float** %op3
	ld.d $t7, $fp, -24
	ld.d $t8, $fp, -40
	st.d $t7, $t8, 0
# %op4 = alloca i32
	addi.d $t8, $fp, -60
	addi.d $t7, $fp, -56
	st.d $t8, $t7, 0
# store i32 %arg1, i32* %op4
	ld.w $t7, $fp, -28
	ld.d $t8, $fp, -56
	st.w $t7, $t8, 0
# %op5 = alloca float
	addi.d $t8, $fp, -76
	addi.d $t7, $fp, -72
	st.d $t8, $t7, 0
# store float %arg2, float* %op5
	fld.s $ft14, $fp, -32
	ld.d $t7, $fp, -72
	fst.s $ft14, $t7, 0
# %op6 = load i32, i32* %op4
	ld.d $t8, $fp, -56
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -80
# %op7 = load float, float* %op5
	ld.d $t8, $fp, -72
	fld.s $ft14, $t8, 0
	fst.s $ft14, $fp, -84
# %op8 = sitofp i32 1 to float
	addi.w $t7, $zero, 1
	movgr2fr.w $ft14, $t7
	ffint.s.w $ft15, $ft14
	fst.s $ft15, $fp, -88
# %op9 = fsub float %op7, %op8
	fld.s $ft14, $fp, -84
	fld.s $ft15, $fp, -88
	fsub.s $ft14, $ft14, $ft15
	fst.s $ft14, $fp, -92
# %op10 = sitofp i32 %op6 to float
	ld.w $t7, $fp, -80
	movgr2fr.w $ft14, $t7
	ffint.s.w $ft15, $ft14
	fst.s $ft15, $fp, -96
# %op11 = fcmp ult float %op10, %op9
	fld.s $ft14, $fp, -96
	fld.s $ft15, $fp, -92
	fcmp.slt.s $fcc0, $ft14, $ft15
	bcnez $fcc0, 8
	b 12
	addi.w $t7, $zero, 1
	b 12
	addi.w $t7, $zero, 0
	b 4
	st.b $t7, $fp, -97
# br i1 %op11, label %label12, label %label20
# %op13 = phi i32 [ %op6, %label_entry ], [ %op48, %label46 ]
	ld.w $t7, $fp, -80
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -104
	ld.b $t7, $fp, -97
	bnez $t7, .sort_label12
	b .sort_label20
.sort_label12:
# %op13 = phi i32 [ %op6, %label_entry ], [ %op48, %label46 ]
# %op14 = load float*, float** %op3
	ld.d $t8, $fp, -40
	ld.d $t7, $t8, 0
	st.d $t7, $fp, -112
# %op15 = sitofp i32 %op13 to float
	ld.w $t7, $fp, -104
	movgr2fr.w $ft14, $t7
	ffint.s.w $ft15, $ft14
	fst.s $ft15, $fp, -116
# %op16 = load float, float* %op5
	ld.d $t8, $fp, -72
	fld.s $ft14, $t8, 0
	fst.s $ft14, $fp, -120
# %op17 = fptosi float %op16 to i32
	fld.s $ft14, $fp, -120
	ftintrz.w.s $ft15, $ft14
	movfr2gr.s $t7, $ft15
	st.w $t7, $fp, -124
# %op18 = call i32 @minloc(float* %op14, float %op15, i32 %op17)
	ld.d $a0, $fp, -112
	fld.s $fa0, $fp, -116
	ld.w $a1, $fp, -124
	bl minloc
	st.w $a0, $fp, -128
# %op19 = icmp sge i32 %op18, 0
	ld.w $t7, $fp, -128
	addi.w $t8, $zero, 0
	slt $t1, $t8, $t7
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	or $t1, $t1, $t8
# br i1 %op19, label %label21, label %label25
	bnez $t1, .sort_label21
	b .sort_label25
.sort_label20:
# ret void
	addi.w $a0, $zero, 0
	b sort_exit
.sort_label21:
# %op22 = load float*, float** %op3
	ld.d $t8, $fp, -40
	ld.d $t1, $t8, 0
# %op23 = getelementptr float, float* %op22, i32 %op18
	ld.w $t8, $fp, -128
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	add.d $t1, $t1, $t7
# %op24 = load float, float* %op23
	fld.s $ft14, $t1, 0
	fst.s $ft14, $fp, -156
# br label %label26
	b .sort_label26
.sort_label25:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label26
	b .sort_label26
.sort_label26:
# %op27 = fptosi float %op24 to i32
	fld.s $ft14, $fp, -156
	ftintrz.w.s $ft15, $ft14
	movfr2gr.s $t7, $ft15
	st.w $t7, $fp, -160
# %op28 = icmp sge i32 %op18, 0
	ld.w $t7, $fp, -128
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t7
	st.b $t7, $fp, -161
	ld.w $t7, $fp, -128
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	ld.b $t7, $fp, -161
	or $t7, $t7, $t8
	st.b $t7, $fp, -161
# br i1 %op28, label %label29, label %label32
	ld.b $t7, $fp, -161
	bnez $t7, .sort_label29
	b .sort_label32
.sort_label29:
# %op30 = load float*, float** %op3
	ld.d $t8, $fp, -40
	ld.d $t7, $t8, 0
	st.d $t7, $fp, -176
# %op31 = getelementptr float, float* %op30, i32 %op18
	ld.w $t8, $fp, -128
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	ld.d $t8, $fp, -176
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -184
# br label %label33
	b .sort_label33
.sort_label32:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label33
	b .sort_label33
.sort_label33:
# %op34 = icmp sge i32 %op13, 0
	ld.w $t7, $fp, -104
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t7
	st.b $t7, $fp, -185
	ld.w $t7, $fp, -104
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	ld.b $t7, $fp, -185
	or $t7, $t7, $t8
	st.b $t7, $fp, -185
# br i1 %op34, label %label35, label %label39
	ld.b $t7, $fp, -185
	bnez $t7, .sort_label35
	b .sort_label39
.sort_label35:
# %op36 = load float*, float** %op3
	ld.d $t8, $fp, -40
	ld.d $t7, $t8, 0
	st.d $t7, $fp, -200
# %op37 = getelementptr float, float* %op36, i32 %op13
	ld.w $t8, $fp, -104
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	ld.d $t8, $fp, -200
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -208
# %op38 = load float, float* %op37
	ld.d $t8, $fp, -208
	fld.s $ft14, $t8, 0
	fst.s $ft14, $fp, -212
# br label %label40
	b .sort_label40
.sort_label39:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label40
	b .sort_label40
.sort_label40:
# store float %op38, float* %op31
	fld.s $ft14, $fp, -212
	ld.d $t7, $fp, -184
	fst.s $ft14, $t7, 0
# %op41 = icmp sge i32 %op13, 0
	ld.w $t7, $fp, -104
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t7
	st.b $t7, $fp, -213
	ld.w $t7, $fp, -104
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	ld.b $t7, $fp, -213
	or $t7, $t7, $t8
	st.b $t7, $fp, -213
# br i1 %op41, label %label42, label %label45
	ld.b $t7, $fp, -213
	bnez $t7, .sort_label42
	b .sort_label45
.sort_label42:
# %op43 = load float*, float** %op3
	ld.d $t8, $fp, -40
	ld.d $t7, $t8, 0
	st.d $t7, $fp, -224
# %op44 = getelementptr float, float* %op43, i32 %op13
	ld.w $t8, $fp, -104
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	ld.d $t8, $fp, -224
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -232
# br label %label46
	b .sort_label46
.sort_label45:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label46
	b .sort_label46
.sort_label46:
# %op47 = sitofp i32 %op27 to float
	ld.w $t7, $fp, -160
	movgr2fr.w $ft14, $t7
	ffint.s.w $ft0, $ft14
# store float %op47, float* %op44
	ld.d $t7, $fp, -232
	fst.s $ft0, $t7, 0
# %op48 = add i32 %op13, 1
	ld.w $t7, $fp, -104
	addi.w $t8, $zero, 1
	add.w $t0, $t7, $t8
# %op49 = load float, float* %op5
	ld.d $t8, $fp, -72
	fld.s $ft0, $t8, 0
# %op50 = sitofp i32 1 to float
	addi.w $t7, $zero, 1
	movgr2fr.w $ft14, $t7
	ffint.s.w $ft1, $ft14
# %op51 = fsub float %op49, %op50
	fsub.s $ft0, $ft0, $ft1
# %op52 = sitofp i32 %op48 to float
	movgr2fr.w $ft14, $t0
	ffint.s.w $ft1, $ft14
# %op53 = fcmp ult float %op52, %op51
	fcmp.slt.s $fcc0, $ft1, $ft0
	bcnez $fcc0, 8
	b 12
	addi.w $t1, $zero, 1
	b 12
	addi.w $t1, $zero, 0
	b 4
# br i1 %op53, label %label12, label %label20
# %op13 = phi i32 [ %op6, %label_entry ], [ %op48, %label46 ]
	add.d $t7, $t0, $zero
	st.w $t7, $fp, -104
	bnez $t1, .sort_label12
	b .sort_label20
sort_exit:
	addi.d $sp, $sp, 272
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -112
.main_label_entry:
# %op0 = icmp slt i32 0, 10
	addi.w $t7, $zero, 0
	addi.w $t8, $zero, 10
	slt $t7, $t7, $t8
	st.b $t7, $fp, -17
# br i1 %op0, label %label1, label %label4
# %op2 = phi i32 [ 0, %label_entry ], [ %op14, %label11 ]
	addi.w $t7, $zero, 0
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -24
	ld.b $t7, $fp, -17
	bnez $t7, .main_label1
	b .main_label4
.main_label1:
# %op2 = phi i32 [ 0, %label_entry ], [ %op14, %label11 ]
# %op3 = icmp sge i32 %op2, 0
	ld.w $t7, $fp, -24
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t7
	st.b $t7, $fp, -25
	ld.w $t7, $fp, -24
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	ld.b $t7, $fp, -25
	or $t7, $t7, $t8
	st.b $t7, $fp, -25
# br i1 %op3, label %label8, label %label10
	ld.b $t7, $fp, -25
	bnez $t7, .main_label8
	b .main_label10
.main_label4:
# %op5 = getelementptr [10 x float], [10 x float]* @x, i32 0, i32 0
	addi.w $t8, $zero, 0
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	la.local $t8, x
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -40
# %op6 = sitofp i32 10 to float
	addi.w $t7, $zero, 10
	movgr2fr.w $ft14, $t7
	ffint.s.w $ft15, $ft14
	fst.s $ft15, $fp, -44
# call void @sort(float* %op5, i32 0, float %op6)
	ld.d $a0, $fp, -40
	addi.w $a1, $zero, 0
	fld.s $fa0, $fp, -44
	bl sort
# %op7 = icmp slt i32 0, 10
	addi.w $t7, $zero, 0
	addi.w $t8, $zero, 10
	slt $t0, $t7, $t8
# br i1 %op7, label %label16, label %label19
# %op17 = phi i32 [ 0, %label4 ], [ %op26, %label24 ]
	addi.w $t7, $zero, 0
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -76
	bnez $t0, .main_label16
	b .main_label19
.main_label8:
# %op9 = getelementptr [10 x float], [10 x float]* @x, i32 0, i32 %op2
	ld.w $t8, $fp, -24
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	la.local $t8, x
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -56
# br label %label11
	b .main_label11
.main_label10:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label11
	b .main_label11
.main_label11:
# %op12 = sub i32 10, %op2
	addi.w $t7, $zero, 10
	ld.w $t8, $fp, -24
	sub.w $t7, $t7, $t8
	st.w $t7, $fp, -60
# %op13 = sitofp i32 %op12 to float
	ld.w $t7, $fp, -60
	movgr2fr.w $ft14, $t7
	ffint.s.w $ft15, $ft14
	fst.s $ft15, $fp, -64
# store float %op13, float* %op9
	fld.s $ft14, $fp, -64
	ld.d $t7, $fp, -56
	fst.s $ft14, $t7, 0
# %op14 = add i32 %op2, 1
	ld.w $t7, $fp, -24
	addi.w $t8, $zero, 1
	add.w $t7, $t7, $t8
	st.w $t7, $fp, -68
# %op15 = icmp slt i32 %op14, 10
	ld.w $t7, $fp, -68
	addi.w $t8, $zero, 10
	slt $t7, $t7, $t8
	st.b $t7, $fp, -69
# br i1 %op15, label %label1, label %label4
# %op2 = phi i32 [ 0, %label_entry ], [ %op14, %label11 ]
	ld.w $t7, $fp, -68
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -24
	ld.b $t7, $fp, -69
	bnez $t7, .main_label1
	b .main_label4
.main_label16:
# %op17 = phi i32 [ 0, %label4 ], [ %op26, %label24 ]
# %op18 = icmp sge i32 %op17, 0
	ld.w $t7, $fp, -76
	addi.w $t8, $zero, 0
	slt $t1, $t8, $t7
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	or $t1, $t1, $t8
# br i1 %op18, label %label20, label %label23
	bnez $t1, .main_label20
	b .main_label23
.main_label19:
# ret void
	addi.w $a0, $zero, 0
	b main_exit
.main_label20:
# %op21 = getelementptr [10 x float], [10 x float]* @x, i32 0, i32 %op17
	ld.w $t8, $fp, -76
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	la.local $t8, x
	add.d $t1, $t8, $t7
# %op22 = load float, float* %op21
	fld.s $ft14, $t1, 0
	fst.s $ft14, $fp, -92
# br label %label24
	b .main_label24
.main_label23:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label24
	b .main_label24
.main_label24:
# %op25 = fptosi float %op22 to i32
	fld.s $ft14, $fp, -92
	ftintrz.w.s $ft15, $ft14
	movfr2gr.s $t1, $ft15
# call void @output(i32 %op25)
	add.d $a0, $t1, $zero
	bl output
# %op26 = add i32 %op17, 1
	ld.w $t7, $fp, -76
	addi.w $t8, $zero, 1
	add.w $t0, $t7, $t8
# %op27 = icmp slt i32 %op26, 10
	addi.w $t8, $zero, 10
	slt $t1, $t0, $t8
# br i1 %op27, label %label16, label %label19
# %op17 = phi i32 [ 0, %label4 ], [ %op26, %label24 ]
	add.d $t7, $t0, $zero
	st.w $t7, $fp, -76
	bnez $t1, .main_label16
	b .main_label19
main_exit:
	addi.d $sp, $sp, 112
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
