	.text
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -144
.main_label_entry:
# %op0 = call i32 @input()
	bl input
	st.w $a0, $fp, -20
# %op1 = icmp slt i32 0, %op0
	addi.w $t7, $zero, 0
	ld.w $t8, $fp, -20
	slt $t7, $t7, $t8
	st.b $t7, $fp, -21
# br i1 %op1, label %label2, label %label31
# %op3 = phi i32 [ 0, %label_entry ], [ %op29, %label2 ]
	addi.w $t7, $zero, 0
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -28
	ld.b $t7, $fp, -21
	bnez $t7, .main_label2
# %op32 = phi i32 [ 0, %label_entry ], [ %op28, %label2 ]
	addi.w $t7, $zero, 0
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -140
	b .main_label31
.main_label2:
# %op3 = phi i32 [ 0, %label_entry ], [ %op29, %label2 ]
# %op4 = fmul float 0x3ff3c0c200000000, 0x4016f06a20000000
	lu12i.w $t8, 260576
	ori $t8, $t8, 1552
	movgr2fr.w $ft14, $t8
	lu12i.w $t8, 265080
	ori $t8, $t8, 849
	movgr2fr.w $ft15, $t8
	fmul.s $ft14, $ft14, $ft15
	fst.s $ft14, $fp, -32
# %op5 = fmul float %op4, 0x4002aa9940000000
	fld.s $ft14, $fp, -32
	lu12i.w $t8, 262485
	ori $t8, $t8, 1226
	movgr2fr.w $ft15, $t8
	fmul.s $ft14, $ft14, $ft15
	fst.s $ft14, $fp, -36
# %op6 = fmul float %op5, 0x4011781d80000000
	fld.s $ft14, $fp, -36
	lu12i.w $t8, 264380
	ori $t8, $t8, 236
	movgr2fr.w $ft15, $t8
	fmul.s $ft14, $ft14, $ft15
	fst.s $ft14, $fp, -40
# %op7 = fmul float %op6, 0x401962ac40000000
	fld.s $ft14, $fp, -40
	lu12i.w $t8, 265393
	ori $t8, $t8, 1378
	movgr2fr.w $ft15, $t8
	fmul.s $ft14, $ft14, $ft15
	fst.s $ft14, $fp, -44
# %op8 = fptosi float %op7 to i32
	fld.s $ft14, $fp, -44
	ftintrz.w.s $ft15, $ft14
	movfr2gr.s $t7, $ft15
	st.w $t7, $fp, -48
# %op9 = mul i32 %op8, %op8
	ld.w $t7, $fp, -48
	ld.w $t8, $fp, -48
	mul.w $t7, $t7, $t8
	st.w $t7, $fp, -52
# %op10 = mul i32 %op9, %op8
	ld.w $t7, $fp, -52
	ld.w $t8, $fp, -48
	mul.w $t7, $t7, $t8
	st.w $t7, $fp, -56
# %op11 = mul i32 %op10, %op8
	ld.w $t7, $fp, -56
	ld.w $t8, $fp, -48
	mul.w $t7, $t7, $t8
	st.w $t7, $fp, -60
# %op12 = mul i32 %op11, %op8
	ld.w $t7, $fp, -60
	ld.w $t8, $fp, -48
	mul.w $t7, $t7, $t8
	st.w $t7, $fp, -64
# %op13 = mul i32 %op12, %op8
	ld.w $t7, $fp, -64
	ld.w $t8, $fp, -48
	mul.w $t7, $t7, $t8
	st.w $t7, $fp, -68
# %op14 = mul i32 %op13, %op13
	ld.w $t7, $fp, -68
	ld.w $t8, $fp, -68
	mul.w $t7, $t7, $t8
	st.w $t7, $fp, -72
# %op15 = mul i32 %op14, %op13
	ld.w $t7, $fp, -72
	ld.w $t8, $fp, -68
	mul.w $t7, $t7, $t8
	st.w $t7, $fp, -76
# %op16 = mul i32 %op15, %op13
	ld.w $t7, $fp, -76
	ld.w $t8, $fp, -68
	mul.w $t7, $t7, $t8
	st.w $t7, $fp, -80
# %op17 = mul i32 %op16, %op13
	ld.w $t7, $fp, -80
	ld.w $t8, $fp, -68
	mul.w $t7, $t7, $t8
	st.w $t7, $fp, -84
# %op18 = mul i32 %op17, %op13
	ld.w $t7, $fp, -84
	ld.w $t8, $fp, -68
	mul.w $t7, $t7, $t8
	st.w $t7, $fp, -88
# %op19 = mul i32 %op18, %op18
	ld.w $t7, $fp, -88
	ld.w $t8, $fp, -88
	mul.w $t7, $t7, $t8
	st.w $t7, $fp, -92
# %op20 = mul i32 %op19, %op18
	ld.w $t7, $fp, -92
	ld.w $t8, $fp, -88
	mul.w $t7, $t7, $t8
	st.w $t7, $fp, -96
# %op21 = mul i32 %op20, %op18
	ld.w $t7, $fp, -96
	ld.w $t8, $fp, -88
	mul.w $t7, $t7, $t8
	st.w $t7, $fp, -100
# %op22 = mul i32 %op21, %op18
	ld.w $t7, $fp, -100
	ld.w $t8, $fp, -88
	mul.w $t7, $t7, $t8
	st.w $t7, $fp, -104
# %op23 = mul i32 %op22, %op18
	ld.w $t7, $fp, -104
	ld.w $t8, $fp, -88
	mul.w $t7, $t7, $t8
	st.w $t7, $fp, -108
# %op24 = mul i32 %op23, %op23
	ld.w $t7, $fp, -108
	ld.w $t8, $fp, -108
	mul.w $t7, $t7, $t8
	st.w $t7, $fp, -112
# %op25 = mul i32 %op24, %op23
	ld.w $t7, $fp, -112
	ld.w $t8, $fp, -108
	mul.w $t7, $t7, $t8
	st.w $t7, $fp, -116
# %op26 = mul i32 %op25, %op23
	ld.w $t7, $fp, -116
	ld.w $t8, $fp, -108
	mul.w $t7, $t7, $t8
	st.w $t7, $fp, -120
# %op27 = mul i32 %op26, %op23
	ld.w $t7, $fp, -120
	ld.w $t8, $fp, -108
	mul.w $t7, $t7, $t8
	st.w $t7, $fp, -124
# %op28 = mul i32 %op27, %op23
	ld.w $t7, $fp, -124
	ld.w $t8, $fp, -108
	mul.w $t7, $t7, $t8
	st.w $t7, $fp, -128
# %op29 = add i32 %op3, 1
	ld.w $t7, $fp, -28
	addi.w $t8, $zero, 1
	add.w $t7, $t7, $t8
	st.w $t7, $fp, -132
# %op30 = icmp slt i32 %op29, %op0
	ld.w $t7, $fp, -132
	ld.w $t8, $fp, -20
	slt $t7, $t7, $t8
	st.b $t7, $fp, -133
# br i1 %op30, label %label2, label %label31
# %op3 = phi i32 [ 0, %label_entry ], [ %op29, %label2 ]
	ld.w $t7, $fp, -132
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -28
	ld.b $t7, $fp, -133
	bnez $t7, .main_label2
# %op32 = phi i32 [ 0, %label_entry ], [ %op28, %label2 ]
	ld.w $t7, $fp, -128
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -140
	b .main_label31
.main_label31:
# %op32 = phi i32 [ 0, %label_entry ], [ %op28, %label2 ]
# call void @output(i32 %op32)
	ld.w $a0, $fp, -140
	bl output
# ret void
	addi.w $a0, $zero, 0
	b main_exit
main_exit:
	addi.d $sp, $sp, 144
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
