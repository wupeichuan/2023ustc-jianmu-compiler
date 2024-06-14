	.text
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -96
.main_label_entry:
# %op0 = sitofp i32 0 to float
	addi.w $t7, $zero, 0
	movgr2fr.w $ft14, $t7
	ffint.s.w $ft0, $ft14
# %op1 = sitofp i32 0 to float
	addi.w $t7, $zero, 0
	movgr2fr.w $ft14, $t7
	ffint.s.w $ft1, $ft14
# %op2 = fcmp ugt float %op0, %op1
	fcmp.slt.s $fcc0, $ft1, $ft0
	bcnez $fcc0, 8
	b 12
	addi.w $t0, $zero, 1
	b 12
	addi.w $t0, $zero, 0
	b 4
# br i1 %op2, label %label3, label %label11
	bnez $t0, .main_label3
# %op12 = phi float [ %op0, %label_entry ], [ %op8, %label3 ]
	fst.s $ft0, $fp, -60
# %op13 = phi i32 [ 0, %label_entry ], [ %op5, %label3 ]
	addi.w $t7, $zero, 0
	add.d $t1, $t7, $zero
	b .main_label11
.main_label3:
# %op4 = add i32 0, 1
	addi.w $t7, $zero, 0
	addi.w $t8, $zero, 1
	add.w $t0, $t7, $t8
# %op5 = add i32 %op4, 1
	addi.w $t8, $zero, 1
	add.w $t0, $t0, $t8
# %op6 = add i32 %op5, 1
	addi.w $t8, $zero, 1
	add.w $t1, $t0, $t8
# %op7 = icmp slt i32 %op6, 10
	addi.w $t8, $zero, 10
	slt $t1, $t1, $t8
# %op8 = sitofp i1 %op7 to float
	movgr2fr.w $ft14, $t1
	ffint.s.w $ft1, $ft14
# %op9 = sitofp i32 0 to float
	addi.w $t7, $zero, 0
	movgr2fr.w $ft14, $t7
	ffint.s.w $ft2, $ft14
# %op10 = fcmp ugt float %op8, %op9
	fcmp.slt.s $fcc0, $ft2, $ft1
	bcnez $fcc0, 8
	b 12
	addi.w $t1, $zero, 1
	b 12
	addi.w $t1, $zero, 0
	b 4
# br i1 %op10, label %label3, label %label11
	bnez $t1, .main_label3
# %op12 = phi float [ %op0, %label_entry ], [ %op8, %label3 ]
	fst.s $ft1, $fp, -60
# %op13 = phi i32 [ 0, %label_entry ], [ %op5, %label3 ]
	add.d $t1, $t0, $zero
	b .main_label11
.main_label11:
# %op12 = phi float [ %op0, %label_entry ], [ %op8, %label3 ]
# %op13 = phi i32 [ 0, %label_entry ], [ %op5, %label3 ]
# %op14 = add i32 %op13, 0
	addi.w $t8, $zero, 0
	add.w $t0, $t1, $t8
# %op15 = add i32 %op14, 0
	addi.w $t8, $zero, 0
	add.w $t0, $t0, $t8
# %op16 = add i32 %op15, 0
	addi.w $t8, $zero, 0
	add.w $t0, $t0, $t8
# %op17 = sitofp i32 %op16 to float
	movgr2fr.w $ft14, $t0
	ffint.s.w $ft1, $ft14
# %op18 = fadd float %op17, %op12
	fld.s $ft14, $fp, -60
	fadd.s $ft1, $ft1, $ft14
# %op19 = fptosi float %op18 to i32
	ftintrz.w.s $ft14, $ft1
	movfr2gr.s $t0, $ft14
# call void @output(i32 %op19)
	add.d $a0, $t0, $zero
	bl output
# %op20 = fptosi float %op12 to i32
	fld.s $ft14, $fp, -60
	ftintrz.w.s $ft15, $ft14
	movfr2gr.s $t0, $ft15
# call void @output(i32 %op20)
	add.d $a0, $t0, $zero
	bl output
# ret void
	addi.w $a0, $zero, 0
	b main_exit
main_exit:
	addi.d $sp, $sp, 96
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
