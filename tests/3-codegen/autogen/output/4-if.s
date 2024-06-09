	.text
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -112
.main_label_entry:
# %op0 = alloca i32
	addi.d $t8, $fp, -28
	addi.d $t7, $fp, -24
	st.d $t8, $t7, 0
# %op1 = alloca i32
	addi.d $t8, $fp, -44
	addi.d $t7, $fp, -40
	st.d $t8, $t7, 0
# %op2 = alloca i32
	addi.d $t8, $fp, -60
	addi.d $t7, $fp, -56
	st.d $t8, $t7, 0
# store i32 11, i32* %op0
	addi.w $t0, $zero, 11
	ld.d $t1, $fp, -24
	st.w $t0, $t1, 0
# store i32 22, i32* %op1
	addi.w $t0, $zero, 22
	ld.d $t1, $fp, -40
	st.w $t0, $t1, 0
# store i32 33, i32* %op2
	addi.w $t0, $zero, 33
	ld.d $t1, $fp, -56
	st.w $t0, $t1, 0
# %op3 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -64
# %op4 = load i32, i32* %op1
	ld.d $t0, $fp, -40
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -68
# %op5 = icmp sgt i32 %op3, %op4
	ld.w $t0, $fp, -64
	ld.w $t1, $fp, -68
	slt $t2, $t1, $t0
	st.b $t2, $fp, -69
# br i1 %op5, label %label6, label %label10
	ld.b $t0, $fp, -69
	bnez $t0, .main_label6
	b .main_label10
.main_label6:
# %op7 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -76
# %op8 = load i32, i32* %op2
	ld.d $t0, $fp, -56
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -80
# %op9 = icmp sgt i32 %op7, %op8
	ld.w $t0, $fp, -76
	ld.w $t1, $fp, -80
	slt $t2, $t1, $t0
	st.b $t2, $fp, -81
# br i1 %op9, label %label15, label %label17
	ld.b $t0, $fp, -81
	bnez $t0, .main_label15
	b .main_label17
.main_label10:
# %op11 = load i32, i32* %op2
	ld.d $t0, $fp, -56
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -88
# %op12 = load i32, i32* %op1
	ld.d $t0, $fp, -40
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -92
# %op13 = icmp slt i32 %op11, %op12
	ld.w $t0, $fp, -88
	ld.w $t1, $fp, -92
	slt $t2, $t0, $t1
	st.b $t2, $fp, -93
# br i1 %op13, label %label20, label %label22
	ld.b $t0, $fp, -93
	bnez $t0, .main_label20
	b .main_label22
.main_label14:
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
.main_label15:
# %op16 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -100
# call void @output(i32 %op16)
	ld.w $a0, $fp, -100
	bl output
# br label %label19
	b .main_label19
.main_label17:
# %op18 = load i32, i32* %op2
	ld.d $t0, $fp, -56
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -104
# call void @output(i32 %op18)
	ld.w $a0, $fp, -104
	bl output
# br label %label19
	b .main_label19
.main_label19:
# br label %label14
	b .main_label14
.main_label20:
# %op21 = load i32, i32* %op1
	ld.d $t0, $fp, -40
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -108
# call void @output(i32 %op21)
	ld.w $a0, $fp, -108
	bl output
# br label %label24
	b .main_label24
.main_label22:
# %op23 = load i32, i32* %op2
	ld.d $t0, $fp, -56
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -112
# call void @output(i32 %op23)
	ld.w $a0, $fp, -112
	bl output
# br label %label24
	b .main_label24
.main_label24:
# br label %label14
	b .main_label14
main_exit:
	addi.d $sp, $sp, 112
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
