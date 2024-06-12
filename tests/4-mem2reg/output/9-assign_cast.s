	.text
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -48
.main_label_entry:
# %op0 = icmp slt i32 1, 3
	addi.w $t7, $zero, 1
	addi.w $t8, $zero, 3
	slt $t7, $t7, $t8
	st.b $t7, $fp, -17
# %op1 = zext i1 %op0 to i32
	ld.b $t8, $fp, -17
	add.w $t7, $t8, $zero
	st.w $t7, $fp, -24
# %op2 = sitofp i32 2 to float
	addi.w $t7, $zero, 2
	movgr2fr.w $ft14, $t7
	ffint.s.w $ft15, $ft14
	fst.s $ft15, $fp, -28
# %op3 = fadd float %op2, 0x4003333340000000
	fld.s $ft14, $fp, -28
	lu12i.w $t8, 262553
	ori $t8, $t8, 2458
	movgr2fr.w $ft15, $t8
	fadd.s $ft14, $ft14, $ft15
	fst.s $ft14, $fp, -32
# %op4 = fptosi float %op3 to i32
	fld.s $ft14, $fp, -32
	ftintrz.w.s $ft15, $ft14
	movfr2gr.s $t7, $ft15
	st.w $t7, $fp, -36
# %op5 = add i32 %op1, %op4
	ld.w $t7, $fp, -24
	ld.w $t8, $fp, -36
	add.w $t7, $t7, $t8
	st.w $t7, $fp, -40
# ret i32 %op5
	ld.w $a0, $fp, -40
	b main_exit
main_exit:
	addi.d $sp, $sp, 48
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
