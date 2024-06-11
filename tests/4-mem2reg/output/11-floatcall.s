	.text
	.globl mod
	.type mod, @function
mod:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -96
	movgr2fr.w $ft14, $zero
	fadd.s $ft0, $fa0, $ft14
	movgr2fr.w $ft14, $zero
	fadd.s $ft1, $fa1, $ft14
.mod_label_entry:
# %op2 = alloca float
	addi.d $t0, $fp, -36
# store float %arg0, float* %op2
	fst.s $ft0, $t0, 0
# %op3 = alloca float
	addi.d $t1, $fp, -52
# store float %arg1, float* %op3
	fst.s $ft1, $t1, 0
# %op4 = load float, float* %op3
	fld.s $ft0, $t1, 0
# %op5 = load float, float* %op2
	fld.s $ft1, $t0, 0
# %op6 = fdiv float %op5, %op4
	fdiv.s $ft0, $ft1, $ft0
# %op7 = fptosi float %op6 to i32
	ftintrz.w.s $ft14, $ft0
	movfr2gr.s $t2, $ft14
# %op8 = load float, float* %op3
	fld.s $ft0, $t1, 0
# %op9 = sitofp i32 %op7 to float
	movgr2fr.w $ft14, $t2
	ffint.s.w $ft1, $ft14
# %op10 = fmul float %op9, %op8
	fmul.s $ft0, $ft1, $ft0
# %op11 = load float, float* %op2
	fld.s $ft1, $t0, 0
# %op12 = fsub float %op11, %op10
	fsub.s $ft0, $ft1, $ft0
# ret float %op12
	movgr2fr.w $ft14, $zero
	fadd.s $fa0, $ft0, $ft14
	b mod_exit
mod_exit:
	addi.d $sp, $sp, 96
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -32
.main_label_entry:
# %op0 = call float @mod(float 0x4026666660000000, float 0x40019999a0000000)
	lu12i.w $t8, 267059
	ori $t8, $t8, 819
	movgr2fr.w $fa0, $t8
	lu12i.w $t8, 262348
	ori $t8, $t8, 3277
	movgr2fr.w $fa1, $t8
	bl mod
	movgr2fr.w $ft14, $zero
	fadd.s $ft0, $fa0, $ft14
# call void @outputFloat(float %op0)
	movgr2fr.w $ft14, $zero
	fadd.s $fa0, $ft0, $ft14
	bl outputFloat
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
main_exit:
	addi.d $sp, $sp, 32
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
