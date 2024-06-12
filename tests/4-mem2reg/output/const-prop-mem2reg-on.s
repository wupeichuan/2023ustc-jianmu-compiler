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
	add.w $t0, $a0, $zero
# %op1 = icmp slt i32 0, %op0
	addi.w $t8, $zero, 0
	slt $t1, $t8, $t0
# br i1 %op1, label %label2, label %label31
	st.b $t1, $fp, -21
# %op3 = phi i32 [ 0, %label_entry ], [ %op29, %label2 ]
	addi.w $t7, $zero, 0
	add.d $t1, $t7, $zero
	ld.b $t7, $fp, -21
	bnez $t7, .main_label2
# %op32 = phi i32 [ 0, %label_entry ], [ %op28, %label2 ]
	addi.w $t7, $zero, 0
	add.d $t0, $t7, $zero
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
	fmul.s $ft0, $ft14, $ft15
# %op5 = fmul float %op4, 0x4002aa9940000000
	lu12i.w $t8, 262485
	ori $t8, $t8, 1226
	movgr2fr.w $ft14, $t8
	fmul.s $ft0, $ft0, $ft14
# %op6 = fmul float %op5, 0x4011781d80000000
	lu12i.w $t8, 264380
	ori $t8, $t8, 236
	movgr2fr.w $ft14, $t8
	fmul.s $ft0, $ft0, $ft14
# %op7 = fmul float %op6, 0x401962ac40000000
	lu12i.w $t8, 265393
	ori $t8, $t8, 1378
	movgr2fr.w $ft14, $t8
	fmul.s $ft0, $ft0, $ft14
# %op8 = fptosi float %op7 to i32
	ftintrz.w.s $ft14, $ft0
	movfr2gr.s $t2, $ft14
# %op9 = mul i32 %op8, %op8
	mul.w $t3, $t2, $t2
# %op10 = mul i32 %op9, %op8
	mul.w $t3, $t3, $t2
# %op11 = mul i32 %op10, %op8
	mul.w $t3, $t3, $t2
# %op12 = mul i32 %op11, %op8
	mul.w $t3, $t3, $t2
# %op13 = mul i32 %op12, %op8
	mul.w $t2, $t3, $t2
# %op14 = mul i32 %op13, %op13
	mul.w $t3, $t2, $t2
# %op15 = mul i32 %op14, %op13
	mul.w $t3, $t3, $t2
# %op16 = mul i32 %op15, %op13
	mul.w $t3, $t3, $t2
# %op17 = mul i32 %op16, %op13
	mul.w $t3, $t3, $t2
# %op18 = mul i32 %op17, %op13
	mul.w $t2, $t3, $t2
# %op19 = mul i32 %op18, %op18
	mul.w $t3, $t2, $t2
# %op20 = mul i32 %op19, %op18
	mul.w $t3, $t3, $t2
# %op21 = mul i32 %op20, %op18
	mul.w $t3, $t3, $t2
# %op22 = mul i32 %op21, %op18
	mul.w $t3, $t3, $t2
# %op23 = mul i32 %op22, %op18
	mul.w $t2, $t3, $t2
# %op24 = mul i32 %op23, %op23
	mul.w $t3, $t2, $t2
# %op25 = mul i32 %op24, %op23
	mul.w $t3, $t3, $t2
# %op26 = mul i32 %op25, %op23
	mul.w $t3, $t3, $t2
# %op27 = mul i32 %op26, %op23
	mul.w $t3, $t3, $t2
# %op28 = mul i32 %op27, %op23
	mul.w $t2, $t3, $t2
# %op29 = add i32 %op3, 1
	addi.w $t8, $zero, 1
	add.w $t1, $t1, $t8
# %op30 = icmp slt i32 %op29, %op0
	slt $t3, $t1, $t0
# br i1 %op30, label %label2, label %label31
# %op3 = phi i32 [ 0, %label_entry ], [ %op29, %label2 ]
	add.d $t1, $t1, $zero
	bnez $t3, .main_label2
# %op32 = phi i32 [ 0, %label_entry ], [ %op28, %label2 ]
	add.d $t0, $t2, $zero
	b .main_label31
.main_label31:
# %op32 = phi i32 [ 0, %label_entry ], [ %op28, %label2 ]
# call void @output(i32 %op32)
	add.d $a0, $t0, $zero
	bl output
# ret void
	addi.w $a0, $zero, 0
	b main_exit
main_exit:
	addi.d $sp, $sp, 144
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
