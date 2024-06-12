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
	slt $t0, $t7, $t8
# %op1 = zext i1 %op0 to i32
	add.w $t0, $t0, $zero
# %op2 = sitofp i32 2 to float
	addi.w $t7, $zero, 2
	movgr2fr.w $ft14, $t7
	ffint.s.w $ft0, $ft14
# %op3 = fadd float %op2, 0x4003333340000000
	lu12i.w $t8, 262553
	ori $t8, $t8, 2458
	movgr2fr.w $ft14, $t8
	fadd.s $ft0, $ft0, $ft14
# %op4 = fptosi float %op3 to i32
	ftintrz.w.s $ft14, $ft0
	movfr2gr.s $t1, $ft14
# %op5 = add i32 %op1, %op4
	add.w $t0, $t0, $t1
# ret i32 %op5
	add.w $a0, $t0, $zero
	b main_exit
main_exit:
	addi.d $sp, $sp, 48
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
