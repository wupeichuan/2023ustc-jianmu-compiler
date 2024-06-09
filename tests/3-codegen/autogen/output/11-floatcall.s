	.text
	.globl mod
	.type mod, @function
mod:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -112
	fst.s $fa0, $fp, -20
	fst.s $fa1, $fp, -24
.mod_label_entry:
# %op2 = alloca float
	addi.d $t8, $fp, -36
	addi.d $t7, $fp, -32
	st.d $t8, $t7, 0
# store float %arg0, float* %op2
	fld.s $ft0, $fp, -20
	ld.d $t1, $fp, -32
	movfr2gr.s $t2, $ft0
	st.w $t2, $t1, 0
# %op3 = alloca float
	addi.d $t8, $fp, -52
	addi.d $t7, $fp, -48
	st.d $t8, $t7, 0
# store float %arg1, float* %op3
	fld.s $ft0, $fp, -24
	ld.d $t1, $fp, -48
	movfr2gr.s $t2, $ft0
	st.w $t2, $t1, 0
# %op4 = alloca i32
	addi.d $t8, $fp, -68
	addi.d $t7, $fp, -64
	st.d $t8, $t7, 0
# %op5 = load float, float* %op3
	ld.d $t0, $fp, -48
	fld.s $ft0, $t0, 0
	fst.s $ft0, $fp, -72
# %op6 = load float, float* %op2
	ld.d $t0, $fp, -32
	fld.s $ft0, $t0, 0
	fst.s $ft0, $fp, -76
# %op7 = fdiv float %op6, %op5
	fld.s $ft0, $fp, -76
	fld.s $ft1, $fp, -72
	fdiv.s $ft2, $ft0, $ft1
	fst.s $ft2, $fp, -80
# %op8 = fptosi float %op7 to i32
	fld.s $ft0, $fp, -80
	ftintrz.w.s $ft1, $ft0
	movfr2gr.s $t0, $ft1
	st.w $t0, $fp, -84
# store i32 %op8, i32* %op4
	ld.w $t0, $fp, -84
	ld.d $t1, $fp, -64
	st.w $t0, $t1, 0
# %op9 = load float, float* %op3
	ld.d $t0, $fp, -48
	fld.s $ft0, $t0, 0
	fst.s $ft0, $fp, -88
# %op10 = load i32, i32* %op4
	ld.d $t0, $fp, -64
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -92
# %op11 = sitofp i32 %op10 to float
	ld.w $t0, $fp, -92
	movgr2fr.w $ft0, $t0
	ffint.s.w $ft1, $ft0
	fst.s $ft1, $fp, -96
# %op12 = fmul float %op11, %op9
	fld.s $ft0, $fp, -96
	fld.s $ft1, $fp, -88
	fmul.s $ft2, $ft0, $ft1
	fst.s $ft2, $fp, -100
# %op13 = load float, float* %op2
	ld.d $t0, $fp, -32
	fld.s $ft0, $t0, 0
	fst.s $ft0, $fp, -104
# %op14 = fsub float %op13, %op12
	fld.s $ft0, $fp, -104
	fld.s $ft1, $fp, -100
	fsub.s $ft2, $ft0, $ft1
	fst.s $ft2, $fp, -108
# ret float %op14
	fld.s $fa0, $fp, -108
	b mod_exit
mod_exit:
	addi.d $sp, $sp, 112
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -64
.main_label_entry:
# %op0 = alloca float
	addi.d $t8, $fp, -28
	addi.d $t7, $fp, -24
	st.d $t8, $t7, 0
# %op1 = alloca float
	addi.d $t8, $fp, -44
	addi.d $t7, $fp, -40
	st.d $t8, $t7, 0
# store float 0x4026666660000000, float* %op0
	lu12i.w $t8, 267059
	ori $t8, $t8, 819
	movgr2fr.w $ft0, $t8
	ld.d $t1, $fp, -24
	movfr2gr.s $t2, $ft0
	st.w $t2, $t1, 0
# store float 0x40019999a0000000, float* %op1
	lu12i.w $t8, 262348
	ori $t8, $t8, 3277
	movgr2fr.w $ft0, $t8
	ld.d $t1, $fp, -40
	movfr2gr.s $t2, $ft0
	st.w $t2, $t1, 0
# %op2 = load float, float* %op0
	ld.d $t0, $fp, -24
	fld.s $ft0, $t0, 0
	fst.s $ft0, $fp, -48
# %op3 = load float, float* %op1
	ld.d $t0, $fp, -40
	fld.s $ft0, $t0, 0
	fst.s $ft0, $fp, -52
# %op4 = call float @mod(float %op2, float %op3)
	fld.s $fa0, $fp, -48
	fld.s $fa1, $fp, -52
	bl mod
	fst.s $fa0, $fp, -56
# call void @outputFloat(float %op4)
	fld.s $fa0, $fp, -56
	bl outputFloat
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
main_exit:
	addi.d $sp, $sp, 64
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
