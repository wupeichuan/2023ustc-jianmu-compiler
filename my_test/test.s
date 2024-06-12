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
	addi.d $sp, $sp, -304
	st.d $a0, $fp, -24
	fst.s $fa0, $fp, -28
	st.w $a1, $fp, -32
.minloc_label_entry:
# %op3 = alloca float*
	addi.d $t8, $fp, -48
	addi.d $t7, $fp, -40
	st.d $t8, $t7, 0
# store float* %arg0, float** %op3
	ld.d $t7, $fp, -24
	ld.d $t8, $fp, -40
	st.d $t7, $t8, 0
# %op4 = alloca float
	addi.d $t8, $fp, -60
	addi.d $t7, $fp, -56
	st.d $t8, $t7, 0
# store float %arg1, float* %op4
	fld.s $ft14, $fp, -28
	ld.d $t7, $fp, -56
	fst.s $ft14, $t7, 0
# %op5 = alloca i32
	addi.d $t8, $fp, -76
	addi.d $t7, $fp, -72
	st.d $t8, $t7, 0
# store i32 %arg2, i32* %op5
	ld.w $t7, $fp, -32
	ld.d $t8, $fp, -72
	st.w $t7, $t8, 0
# %op6 = alloca i32
	addi.d $t8, $fp, -92
	addi.d $t7, $fp, -88
	st.d $t8, $t7, 0
# %op7 = alloca i32
	addi.d $t8, $fp, -108
	addi.d $t7, $fp, -104
	st.d $t8, $t7, 0
# %op8 = alloca i32
	addi.d $t8, $fp, -124
	addi.d $t7, $fp, -120
	st.d $t8, $t7, 0
# %op9 = load float, float* %op4
	ld.d $t8, $fp, -56
	fld.s $ft14, $t8, 0
	fst.s $ft14, $fp, -128
# %op10 = fptosi float %op9 to i32
	fld.s $ft14, $fp, -128
	ftintrz.w.s $ft15, $ft14
	movfr2gr.s $t7, $ft15
	st.w $t7, $fp, -132
# store i32 %op10, i32* %op8
	ld.w $t7, $fp, -132
	ld.d $t8, $fp, -120
	st.w $t7, $t8, 0
# %op11 = load float, float* %op4
	ld.d $t8, $fp, -56
	fld.s $ft14, $t8, 0
	fst.s $ft14, $fp, -136
# %op12 = fptosi float %op11 to i32
	fld.s $ft14, $fp, -136
	ftintrz.w.s $ft15, $ft14
	movfr2gr.s $t7, $ft15
	st.w $t7, $fp, -140
# %op13 = icmp sge i32 %op12, 0
	ld.w $t7, $fp, -140
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t7
	st.b $t7, $fp, -141
	addi.w $t8, $zero, 0
	ld.w $t7, $fp, -140
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	ld.b $t7, $fp, -141
	or $t7, $t7, $t8
	st.b $t7, $fp, -141
# br i1 %op13, label %label14, label %label18
	ld.b $t7, $fp, -141
	bnez $t7, .minloc_label14
	b .minloc_label18
.minloc_label14:
# %op15 = load float*, float** %op3
	ld.d $t8, $fp, -40
	ld.d $t7, $t8, 0
	st.d $t7, $fp, -152
# %op16 = getelementptr float, float* %op15, i32 %op12
	ld.w $t8, $fp, -140
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	ld.d $t8, $fp, -152
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -160
# %op17 = load float, float* %op16
	ld.d $t8, $fp, -160
	fld.s $ft14, $t8, 0
	fst.s $ft14, $fp, -164
# br label %label19
	b .minloc_label19
.minloc_label18:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label19
	b .minloc_label19
.minloc_label19:
# %op20 = fptosi float %op17 to i32
	fld.s $ft14, $fp, -164
	ftintrz.w.s $ft15, $ft14
	movfr2gr.s $t7, $ft15
	st.w $t7, $fp, -168
# store i32 %op20, i32* %op7
	ld.w $t7, $fp, -168
	ld.d $t8, $fp, -104
	st.w $t7, $t8, 0
# %op21 = load float, float* %op4
	ld.d $t8, $fp, -56
	fld.s $ft14, $t8, 0
	fst.s $ft14, $fp, -172
# %op22 = sitofp i32 1 to float
	addi.w $t7, $zero, 1
	movgr2fr.w $ft14, $t7
	ffint.s.w $ft15, $ft14
	fst.s $ft15, $fp, -176
# %op23 = fadd float %op21, %op22
	fld.s $ft14, $fp, -172
	fld.s $ft15, $fp, -176
	fadd.s $ft14, $ft14, $ft15
	fst.s $ft14, $fp, -180
# %op24 = fptosi float %op23 to i32
	fld.s $ft14, $fp, -180
	ftintrz.w.s $ft15, $ft14
	movfr2gr.s $t7, $ft15
	st.w $t7, $fp, -184
# store i32 %op24, i32* %op6
	ld.w $t7, $fp, -184
	ld.d $t8, $fp, -88
	st.w $t7, $t8, 0
# %op25 = load i32, i32* %op6
	ld.d $t8, $fp, -88
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -188
# %op26 = load i32, i32* %op5
	ld.d $t8, $fp, -72
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -192
# %op27 = icmp slt i32 %op25, %op26
	ld.w $t7, $fp, -188
	ld.w $t8, $fp, -192
	slt $t7, $t7, $t8
	st.b $t7, $fp, -193
# br i1 %op27, label %label28, label %label31
	ld.b $t7, $fp, -193
	bnez $t7, .minloc_label28
	b .minloc_label31
.minloc_label28:
# %op29 = load i32, i32* %op6
	ld.d $t8, $fp, -88
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -200
# %op30 = icmp sge i32 %op29, 0
	ld.w $t7, $fp, -200
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t7
	st.b $t7, $fp, -201
	addi.w $t8, $zero, 0
	ld.w $t7, $fp, -200
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	ld.b $t7, $fp, -201
	or $t7, $t7, $t8
	st.b $t7, $fp, -201
# br i1 %op30, label %label33, label %label37
	ld.b $t7, $fp, -201
	bnez $t7, .minloc_label33
	b .minloc_label37
.minloc_label31:
# %op32 = load i32, i32* %op8
	ld.d $t8, $fp, -120
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -208
# ret i32 %op32
	ld.w $a0, $fp, -208
	b minloc_exit
.minloc_label33:
# %op34 = load float*, float** %op3
	ld.d $t8, $fp, -40
	ld.d $t7, $t8, 0
	st.d $t7, $fp, -216
# %op35 = getelementptr float, float* %op34, i32 %op29
	ld.w $t8, $fp, -200
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	ld.d $t8, $fp, -216
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -224
# %op36 = load float, float* %op35
	ld.d $t8, $fp, -224
	fld.s $ft14, $t8, 0
	fst.s $ft14, $fp, -228
# br label %label38
	b .minloc_label38
.minloc_label37:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label38
	b .minloc_label38
.minloc_label38:
# %op39 = load i32, i32* %op7
	ld.d $t8, $fp, -104
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -232
# %op40 = sitofp i32 %op39 to float
	ld.w $t7, $fp, -232
	movgr2fr.w $ft14, $t7
	ffint.s.w $ft15, $ft14
	fst.s $ft15, $fp, -236
# %op41 = fcmp ult float %op36, %op40
	fld.s $ft14, $fp, -228
	fld.s $ft15, $fp, -236
	fcmp.slt.s $fcc0, $ft14, $ft15
	bcnez $fcc0, 8
	b 12
	addi.w $t7, $zero, 1
	b 12
	addi.w $t7, $zero, 0
	b 4
	st.b $t7, $fp, -237
# br i1 %op41, label %label42, label %label45
	ld.b $t7, $fp, -237
	bnez $t7, .minloc_label42
	b .minloc_label45
.minloc_label42:
# %op43 = load i32, i32* %op6
	ld.d $t8, $fp, -88
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -244
# %op44 = icmp sge i32 %op43, 0
	ld.w $t7, $fp, -244
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t7
	st.b $t7, $fp, -245
	addi.w $t8, $zero, 0
	ld.w $t7, $fp, -244
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	ld.b $t7, $fp, -245
	or $t7, $t7, $t8
	st.b $t7, $fp, -245
# br i1 %op44, label %label51, label %label55
	ld.b $t7, $fp, -245
	bnez $t7, .minloc_label51
	b .minloc_label55
.minloc_label45:
# %op46 = load i32, i32* %op6
	ld.d $t8, $fp, -88
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -252
# %op47 = add i32 %op46, 1
	ld.w $t7, $fp, -252
	addi.w $t8, $zero, 1
	add.w $t7, $t7, $t8
	st.w $t7, $fp, -256
# store i32 %op47, i32* %op6
	ld.w $t7, $fp, -256
	ld.d $t8, $fp, -88
	st.w $t7, $t8, 0
# %op48 = load i32, i32* %op6
	ld.d $t8, $fp, -88
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -260
# %op49 = load i32, i32* %op5
	ld.d $t8, $fp, -72
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -264
# %op50 = icmp slt i32 %op48, %op49
	ld.w $t7, $fp, -260
	ld.w $t8, $fp, -264
	slt $t7, $t7, $t8
	st.b $t7, $fp, -265
# br i1 %op50, label %label28, label %label31
	ld.b $t7, $fp, -265
	bnez $t7, .minloc_label28
	b .minloc_label31
.minloc_label51:
# %op52 = load float*, float** %op3
	ld.d $t8, $fp, -40
	ld.d $t7, $t8, 0
	st.d $t7, $fp, -280
# %op53 = getelementptr float, float* %op52, i32 %op43
	ld.w $t8, $fp, -244
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	ld.d $t8, $fp, -280
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -288
# %op54 = load float, float* %op53
	ld.d $t8, $fp, -288
	fld.s $ft14, $t8, 0
	fst.s $ft14, $fp, -292
# br label %label56
	b .minloc_label56
.minloc_label55:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label56
	b .minloc_label56
.minloc_label56:
# %op57 = fptosi float %op54 to i32
	fld.s $ft14, $fp, -292
	ftintrz.w.s $ft15, $ft14
	movfr2gr.s $t7, $ft15
	st.w $t7, $fp, -296
# store i32 %op57, i32* %op7
	ld.w $t7, $fp, -296
	ld.d $t8, $fp, -104
	st.w $t7, $t8, 0
# %op58 = load i32, i32* %op6
	ld.d $t8, $fp, -88
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -300
# store i32 %op58, i32* %op8
	ld.w $t7, $fp, -300
	ld.d $t8, $fp, -120
	st.w $t7, $t8, 0
# br label %label45
	b .minloc_label45
minloc_exit:
	addi.d $sp, $sp, 304
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl sort
	.type sort, @function
sort:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -336
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
# %op6 = alloca i32
	addi.d $t8, $fp, -92
	addi.d $t7, $fp, -88
	st.d $t8, $t7, 0
# %op7 = alloca i32
	addi.d $t8, $fp, -108
	addi.d $t7, $fp, -104
	st.d $t8, $t7, 0
# %op8 = load i32, i32* %op4
	ld.d $t8, $fp, -56
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -112
# store i32 %op8, i32* %op6
	ld.w $t7, $fp, -112
	ld.d $t8, $fp, -88
	st.w $t7, $t8, 0
# %op9 = load i32, i32* %op6
	ld.d $t8, $fp, -88
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -116
# %op10 = load float, float* %op5
	ld.d $t8, $fp, -72
	fld.s $ft14, $t8, 0
	fst.s $ft14, $fp, -120
# %op11 = sitofp i32 1 to float
	addi.w $t7, $zero, 1
	movgr2fr.w $ft14, $t7
	ffint.s.w $ft15, $ft14
	fst.s $ft15, $fp, -124
# %op12 = fsub float %op10, %op11
	fld.s $ft14, $fp, -120
	fld.s $ft15, $fp, -124
	fsub.s $ft14, $ft14, $ft15
	fst.s $ft14, $fp, -128
# %op13 = sitofp i32 %op9 to float
	ld.w $t7, $fp, -116
	movgr2fr.w $ft14, $t7
	ffint.s.w $ft15, $ft14
	fst.s $ft15, $fp, -132
# %op14 = fcmp ult float %op13, %op12
	fld.s $ft14, $fp, -132
	fld.s $ft15, $fp, -128
	fcmp.slt.s $fcc0, $ft14, $ft15
	bcnez $fcc0, 8
	b 12
	addi.w $t7, $zero, 1
	b 12
	addi.w $t7, $zero, 0
	b 4
	st.b $t7, $fp, -133
# br i1 %op14, label %label15, label %label26
	ld.b $t7, $fp, -133
	bnez $t7, .sort_label15
	b .sort_label26
.sort_label15:
# %op16 = alloca i32
	addi.d $t8, $fp, -148
	addi.d $t7, $fp, -144
	st.d $t8, $t7, 0
# %op17 = sitofp i32 1 to float
	addi.w $t7, $zero, 1
	movgr2fr.w $ft14, $t7
	ffint.s.w $ft15, $ft14
	fst.s $ft15, $fp, -152
# call void @outputFloat(float %op17)
	fld.s $fa0, $fp, -152
	bl outputFloat
# %op18 = load float*, float** %op3
	ld.d $t8, $fp, -40
	ld.d $t7, $t8, 0
	st.d $t7, $fp, -160
# %op19 = load i32, i32* %op6
	ld.d $t8, $fp, -88
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -164
# %op20 = sitofp i32 %op19 to float
	ld.w $t7, $fp, -164
	movgr2fr.w $ft14, $t7
	ffint.s.w $ft15, $ft14
	fst.s $ft15, $fp, -168
# %op21 = load float, float* %op5
	ld.d $t8, $fp, -72
	fld.s $ft14, $t8, 0
	fst.s $ft14, $fp, -172
# %op22 = fptosi float %op21 to i32
	fld.s $ft14, $fp, -172
	ftintrz.w.s $ft15, $ft14
	movfr2gr.s $t7, $ft15
	st.w $t7, $fp, -176
# %op23 = call i32 @minloc(float* %op18, float %op20, i32 %op22)
	ld.d $a0, $fp, -160
	fld.s $fa0, $fp, -168
	ld.w $a1, $fp, -176
	bl minloc
	st.w $a0, $fp, -180
# store i32 %op23, i32* %op7
	ld.w $t7, $fp, -180
	ld.d $t8, $fp, -104
	st.w $t7, $t8, 0
# %op24 = load i32, i32* %op7
	ld.d $t8, $fp, -104
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -184
# %op25 = icmp sge i32 %op24, 0
	ld.w $t7, $fp, -184
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t7
	st.b $t7, $fp, -185
	addi.w $t8, $zero, 0
	ld.w $t7, $fp, -184
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	ld.b $t7, $fp, -185
	or $t7, $t7, $t8
	st.b $t7, $fp, -185
# br i1 %op25, label %label27, label %label31
	ld.b $t7, $fp, -185
	bnez $t7, .sort_label27
	b .sort_label31
.sort_label26:
# ret void
	addi.w $a0, $zero, 0
	b sort_exit
.sort_label27:
# %op28 = load float*, float** %op3
	ld.d $t8, $fp, -40
	ld.d $t7, $t8, 0
	st.d $t7, $fp, -200
# %op29 = getelementptr float, float* %op28, i32 %op24
	ld.w $t8, $fp, -184
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	ld.d $t8, $fp, -200
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -208
# %op30 = load float, float* %op29
	ld.d $t8, $fp, -208
	fld.s $ft14, $t8, 0
	fst.s $ft14, $fp, -212
# br label %label32
	b .sort_label32
.sort_label31:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label32
	b .sort_label32
.sort_label32:
# %op33 = fptosi float %op30 to i32
	fld.s $ft14, $fp, -212
	ftintrz.w.s $ft15, $ft14
	movfr2gr.s $t7, $ft15
	st.w $t7, $fp, -216
# store i32 %op33, i32* %op16
	ld.w $t7, $fp, -216
	ld.d $t8, $fp, -144
	st.w $t7, $t8, 0
# %op34 = load i32, i32* %op7
	ld.d $t8, $fp, -104
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -220
# %op35 = icmp sge i32 %op34, 0
	ld.w $t7, $fp, -220
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t7
	st.b $t7, $fp, -221
	addi.w $t8, $zero, 0
	ld.w $t7, $fp, -220
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	ld.b $t7, $fp, -221
	or $t7, $t7, $t8
	st.b $t7, $fp, -221
# br i1 %op35, label %label36, label %label39
	ld.b $t7, $fp, -221
	bnez $t7, .sort_label36
	b .sort_label39
.sort_label36:
# %op37 = load float*, float** %op3
	ld.d $t8, $fp, -40
	ld.d $t7, $t8, 0
	st.d $t7, $fp, -232
# %op38 = getelementptr float, float* %op37, i32 %op34
	ld.w $t8, $fp, -220
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	ld.d $t8, $fp, -232
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -240
# br label %label40
	b .sort_label40
.sort_label39:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label40
	b .sort_label40
.sort_label40:
# %op41 = load i32, i32* %op6
	ld.d $t8, $fp, -88
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -244
# %op42 = icmp sge i32 %op41, 0
	ld.w $t7, $fp, -244
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t7
	st.b $t7, $fp, -245
	addi.w $t8, $zero, 0
	ld.w $t7, $fp, -244
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	ld.b $t7, $fp, -245
	or $t7, $t7, $t8
	st.b $t7, $fp, -245
# br i1 %op42, label %label43, label %label47
	ld.b $t7, $fp, -245
	bnez $t7, .sort_label43
	b .sort_label47
.sort_label43:
# %op44 = load float*, float** %op3
	ld.d $t8, $fp, -40
	ld.d $t7, $t8, 0
	st.d $t7, $fp, -256
# %op45 = getelementptr float, float* %op44, i32 %op41
	ld.w $t8, $fp, -244
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	ld.d $t8, $fp, -256
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -264
# %op46 = load float, float* %op45
	ld.d $t8, $fp, -264
	fld.s $ft14, $t8, 0
	fst.s $ft14, $fp, -268
# br label %label48
	b .sort_label48
.sort_label47:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label48
	b .sort_label48
.sort_label48:
# store float %op46, float* %op38
	fld.s $ft14, $fp, -268
	ld.d $t7, $fp, -240
	fst.s $ft14, $t7, 0
# %op49 = load i32, i32* %op6
	ld.d $t8, $fp, -88
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -272
# %op50 = icmp sge i32 %op49, 0
	ld.w $t7, $fp, -272
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t7
	st.b $t7, $fp, -273
	addi.w $t8, $zero, 0
	ld.w $t7, $fp, -272
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	ld.b $t7, $fp, -273
	or $t7, $t7, $t8
	st.b $t7, $fp, -273
# br i1 %op50, label %label51, label %label54
	ld.b $t7, $fp, -273
	bnez $t7, .sort_label51
	b .sort_label54
.sort_label51:
# %op52 = load float*, float** %op3
	ld.d $t8, $fp, -40
	ld.d $t7, $t8, 0
	st.d $t7, $fp, -288
# %op53 = getelementptr float, float* %op52, i32 %op49
	ld.w $t8, $fp, -272
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	ld.d $t8, $fp, -288
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -296
# br label %label55
	b .sort_label55
.sort_label54:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label55
	b .sort_label55
.sort_label55:
# %op56 = load i32, i32* %op16
	ld.d $t8, $fp, -144
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -300
# %op57 = sitofp i32 %op56 to float
	ld.w $t7, $fp, -300
	movgr2fr.w $ft14, $t7
	ffint.s.w $ft15, $ft14
	fst.s $ft15, $fp, -304
# store float %op57, float* %op53
	fld.s $ft14, $fp, -304
	ld.d $t7, $fp, -296
	fst.s $ft14, $t7, 0
# %op58 = load i32, i32* %op6
	ld.d $t8, $fp, -88
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -308
# %op59 = add i32 %op58, 1
	ld.w $t7, $fp, -308
	addi.w $t8, $zero, 1
	add.w $t7, $t7, $t8
	st.w $t7, $fp, -312
# store i32 %op59, i32* %op6
	ld.w $t7, $fp, -312
	ld.d $t8, $fp, -88
	st.w $t7, $t8, 0
# %op60 = load i32, i32* %op6
	ld.d $t8, $fp, -88
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -316
# %op61 = load float, float* %op5
	ld.d $t8, $fp, -72
	fld.s $ft14, $t8, 0
	fst.s $ft14, $fp, -320
# %op62 = sitofp i32 1 to float
	addi.w $t7, $zero, 1
	movgr2fr.w $ft14, $t7
	ffint.s.w $ft15, $ft14
	fst.s $ft15, $fp, -324
# %op63 = fsub float %op61, %op62
	fld.s $ft14, $fp, -320
	fld.s $ft15, $fp, -324
	fsub.s $ft14, $ft14, $ft15
	fst.s $ft14, $fp, -328
# %op64 = sitofp i32 %op60 to float
	ld.w $t7, $fp, -316
	movgr2fr.w $ft14, $t7
	ffint.s.w $ft15, $ft14
	fst.s $ft15, $fp, -332
# %op65 = fcmp ult float %op64, %op63
	fld.s $ft14, $fp, -332
	fld.s $ft15, $fp, -328
	fcmp.slt.s $fcc0, $ft14, $ft15
	bcnez $fcc0, 8
	b 12
	addi.w $t7, $zero, 1
	b 12
	addi.w $t7, $zero, 0
	b 4
	st.b $t7, $fp, -333
# br i1 %op65, label %label15, label %label26
	ld.b $t7, $fp, -333
	bnez $t7, .sort_label15
	b .sort_label26
sort_exit:
	addi.d $sp, $sp, 336
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -256
.main_label_entry:
# %op0 = alloca i32
	addi.d $t8, $fp, -28
	addi.d $t7, $fp, -24
	st.d $t8, $t7, 0
# store i32 0, i32* %op0
	addi.w $t7, $zero, 0
	ld.d $t8, $fp, -24
	st.w $t7, $t8, 0
# %op1 = load i32, i32* %op0
	ld.d $t8, $fp, -24
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -32
# %op2 = icmp slt i32 %op1, 10
	ld.w $t7, $fp, -32
	addi.w $t8, $zero, 10
	slt $t7, $t7, $t8
	st.b $t7, $fp, -33
# br i1 %op2, label %label3, label %label6
	ld.b $t7, $fp, -33
	bnez $t7, .main_label3
	b .main_label6
.main_label3:
# %op4 = load i32, i32* %op0
	ld.d $t8, $fp, -24
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -40
# %op5 = icmp sge i32 %op4, 0
	ld.w $t7, $fp, -40
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t7
	st.b $t7, $fp, -41
	addi.w $t8, $zero, 0
	ld.w $t7, $fp, -40
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	ld.b $t7, $fp, -41
	or $t7, $t7, $t8
	st.b $t7, $fp, -41
# br i1 %op5, label %label11, label %label13
	ld.b $t7, $fp, -41
	bnez $t7, .main_label11
	b .main_label13
.main_label6:
# %op7 = getelementptr [10 x float], [10 x float]* @x, i32 0, i32 0
	addi.w $t8, $zero, 0
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	la.local $t8, x
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -56
# %op8 = sitofp i32 10 to float
	addi.w $t7, $zero, 10
	movgr2fr.w $ft14, $t7
	ffint.s.w $ft15, $ft14
	fst.s $ft15, $fp, -60
# call void @sort(float* %op7, i32 0, float %op8)
	ld.d $a0, $fp, -56
	addi.w $a1, $zero, 0
	fld.s $fa0, $fp, -60
	bl sort
# store i32 0, i32* %op0
	addi.w $t7, $zero, 0
	ld.d $t8, $fp, -24
	st.w $t7, $t8, 0
# %op9 = load i32, i32* %op0
	ld.d $t8, $fp, -24
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -64
# %op10 = icmp slt i32 %op9, 10
	ld.w $t7, $fp, -64
	addi.w $t8, $zero, 10
	slt $t7, $t7, $t8
	st.b $t7, $fp, -65
# br i1 %op10, label %label54, label %label59
	ld.b $t7, $fp, -65
	bnez $t7, .main_label54
	b .main_label59
.main_label11:
# %op12 = getelementptr [10 x float], [10 x float]* @x, i32 0, i32 %op4
	ld.w $t8, $fp, -40
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	la.local $t8, x
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -80
# br label %label14
	b .main_label14
.main_label13:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label14
	b .main_label14
.main_label14:
# %op15 = load i32, i32* %op0
	ld.d $t8, $fp, -24
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -84
# %op16 = mul i32 244, %op15
	addi.w $t7, $zero, 244
	ld.w $t8, $fp, -84
	mul.w $t7, $t7, $t8
	st.w $t7, $fp, -88
# %op17 = load i32, i32* %op0
	ld.d $t8, $fp, -24
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -92
# %op18 = load i32, i32* %op0
	ld.d $t8, $fp, -24
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -96
# %op19 = mul i32 100, %op18
	addi.w $t7, $zero, 100
	ld.w $t8, $fp, -96
	mul.w $t7, $t7, $t8
	st.w $t7, $fp, -100
# %op20 = mul i32 %op19, %op17
	ld.w $t7, $fp, -100
	ld.w $t8, $fp, -92
	mul.w $t7, $t7, $t8
	st.w $t7, $fp, -104
# %op21 = load i32, i32* %op0
	ld.d $t8, $fp, -24
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -108
# %op22 = load i32, i32* %op0
	ld.d $t8, $fp, -24
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -112
# %op23 = load i32, i32* %op0
	ld.d $t8, $fp, -24
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -116
# %op24 = sitofp i32 %op23 to float
	ld.w $t7, $fp, -116
	movgr2fr.w $ft14, $t7
	ffint.s.w $ft15, $ft14
	fst.s $ft15, $fp, -120
# %op25 = fmul float 0x4043466660000000, %op24
	lu12i.w $t8, 270755
	ori $t8, $t8, 819
	movgr2fr.w $ft14, $t8
	fld.s $ft15, $fp, -120
	fmul.s $ft14, $ft14, $ft15
	fst.s $ft14, $fp, -124
# %op26 = sitofp i32 %op22 to float
	ld.w $t7, $fp, -112
	movgr2fr.w $ft14, $t7
	ffint.s.w $ft15, $ft14
	fst.s $ft15, $fp, -128
# %op27 = fmul float %op25, %op26
	fld.s $ft14, $fp, -124
	fld.s $ft15, $fp, -128
	fmul.s $ft14, $ft14, $ft15
	fst.s $ft14, $fp, -132
# %op28 = sitofp i32 %op21 to float
	ld.w $t7, $fp, -108
	movgr2fr.w $ft14, $t7
	ffint.s.w $ft15, $ft14
	fst.s $ft15, $fp, -136
# %op29 = fmul float %op27, %op28
	fld.s $ft14, $fp, -132
	fld.s $ft15, $fp, -136
	fmul.s $ft14, $ft14, $ft15
	fst.s $ft14, $fp, -140
# %op30 = load i32, i32* %op0
	ld.d $t8, $fp, -24
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -144
# %op31 = load i32, i32* %op0
	ld.d $t8, $fp, -24
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -148
# %op32 = load i32, i32* %op0
	ld.d $t8, $fp, -24
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -152
# %op33 = load i32, i32* %op0
	ld.d $t8, $fp, -24
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -156
# %op34 = load i32, i32* %op0
	ld.d $t8, $fp, -24
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -160
# %op35 = sitofp i32 %op34 to float
	ld.w $t7, $fp, -160
	movgr2fr.w $ft14, $t7
	ffint.s.w $ft15, $ft14
	fst.s $ft15, $fp, -164
# %op36 = fmul float 0x402470a3e0000000, %op35
	lu12i.w $t8, 266808
	ori $t8, $t8, 1311
	movgr2fr.w $ft14, $t8
	fld.s $ft15, $fp, -164
	fmul.s $ft14, $ft14, $ft15
	fst.s $ft14, $fp, -168
# %op37 = sitofp i32 %op33 to float
	ld.w $t7, $fp, -156
	movgr2fr.w $ft14, $t7
	ffint.s.w $ft15, $ft14
	fst.s $ft15, $fp, -172
# %op38 = fmul float %op36, %op37
	fld.s $ft14, $fp, -168
	fld.s $ft15, $fp, -172
	fmul.s $ft14, $ft14, $ft15
	fst.s $ft14, $fp, -176
# %op39 = sitofp i32 %op32 to float
	ld.w $t7, $fp, -152
	movgr2fr.w $ft14, $t7
	ffint.s.w $ft15, $ft14
	fst.s $ft15, $fp, -180
# %op40 = fmul float %op38, %op39
	fld.s $ft14, $fp, -176
	fld.s $ft15, $fp, -180
	fmul.s $ft14, $ft14, $ft15
	fst.s $ft14, $fp, -184
# %op41 = sitofp i32 %op31 to float
	ld.w $t7, $fp, -148
	movgr2fr.w $ft14, $t7
	ffint.s.w $ft15, $ft14
	fst.s $ft15, $fp, -188
# %op42 = fmul float %op40, %op41
	fld.s $ft14, $fp, -184
	fld.s $ft15, $fp, -188
	fmul.s $ft14, $ft14, $ft15
	fst.s $ft14, $fp, -192
# %op43 = sitofp i32 %op30 to float
	ld.w $t7, $fp, -144
	movgr2fr.w $ft14, $t7
	ffint.s.w $ft15, $ft14
	fst.s $ft15, $fp, -196
# %op44 = fmul float %op42, %op43
	fld.s $ft14, $fp, -192
	fld.s $ft15, $fp, -196
	fmul.s $ft14, $ft14, $ft15
	fst.s $ft14, $fp, -200
# %op45 = fsub float %op44, %op29
	fld.s $ft14, $fp, -200
	fld.s $ft15, $fp, -140
	fsub.s $ft14, $ft14, $ft15
	fst.s $ft14, $fp, -204
# %op46 = sitofp i32 %op20 to float
	ld.w $t7, $fp, -104
	movgr2fr.w $ft14, $t7
	ffint.s.w $ft15, $ft14
	fst.s $ft15, $fp, -208
# %op47 = fadd float %op45, %op46
	fld.s $ft14, $fp, -204
	fld.s $ft15, $fp, -208
	fadd.s $ft14, $ft14, $ft15
	fst.s $ft14, $fp, -212
# %op48 = sitofp i32 %op16 to float
	ld.w $t7, $fp, -88
	movgr2fr.w $ft14, $t7
	ffint.s.w $ft15, $ft14
	fst.s $ft15, $fp, -216
# %op49 = fsub float %op47, %op48
	fld.s $ft14, $fp, -212
	fld.s $ft15, $fp, -216
	fsub.s $ft14, $ft14, $ft15
	fst.s $ft14, $fp, -220
# store float %op49, float* %op12
	fld.s $ft14, $fp, -220
	ld.d $t7, $fp, -80
	fst.s $ft14, $t7, 0
# %op50 = load i32, i32* %op0
	ld.d $t8, $fp, -24
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -224
# %op51 = add i32 %op50, 1
	ld.w $t7, $fp, -224
	addi.w $t8, $zero, 1
	add.w $t7, $t7, $t8
	st.w $t7, $fp, -228
# store i32 %op51, i32* %op0
	ld.w $t7, $fp, -228
	ld.d $t8, $fp, -24
	st.w $t7, $t8, 0
# %op52 = load i32, i32* %op0
	ld.d $t8, $fp, -24
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -232
# %op53 = icmp slt i32 %op52, 10
	ld.w $t7, $fp, -232
	addi.w $t8, $zero, 10
	slt $t7, $t7, $t8
	st.b $t7, $fp, -233
# br i1 %op53, label %label3, label %label6
	ld.b $t7, $fp, -233
	bnez $t7, .main_label3
	b .main_label6
.main_label54:
# %op55 = load i32, i32* %op0
	ld.d $t8, $fp, -24
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -240
# %op56 = add i32 %op55, 1
	ld.w $t7, $fp, -240
	addi.w $t8, $zero, 1
	add.w $t7, $t7, $t8
	st.w $t7, $fp, -244
# store i32 %op56, i32* %op0
	ld.w $t7, $fp, -244
	ld.d $t8, $fp, -24
	st.w $t7, $t8, 0
# %op57 = load i32, i32* %op0
	ld.d $t8, $fp, -24
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -248
# %op58 = icmp slt i32 %op57, 10
	ld.w $t7, $fp, -248
	addi.w $t8, $zero, 10
	slt $t7, $t7, $t8
	st.b $t7, $fp, -249
# br i1 %op58, label %label54, label %label59
	ld.b $t7, $fp, -249
	bnez $t7, .main_label54
	b .main_label59
.main_label59:
# ret void
	addi.w $a0, $zero, 0
	b main_exit
main_exit:
	addi.d $sp, $sp, 256
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
