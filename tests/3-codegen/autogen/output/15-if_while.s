	.text
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -128
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
# store i32 0, i32* %op1
	addi.w $t0, $zero, 0
	ld.d $t1, $fp, -40
	st.w $t0, $t1, 0
# store i32 0, i32* %op2
	addi.w $t0, $zero, 0
	ld.d $t1, $fp, -56
	st.w $t0, $t1, 0
# store i32 10, i32* %op0
	addi.w $t0, $zero, 10
	ld.d $t1, $fp, -24
	st.w $t0, $t1, 0
# %op3 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -64
# %op4 = icmp ne i32 %op3, 0
	ld.w $t0, $fp, -64
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t3, $zero, $t2
	st.b $t3, $fp, -65
# br i1 %op4, label %label5, label %label10
	ld.b $t0, $fp, -65
	bnez $t0, .main_label5
	b .main_label10
.main_label5:
# %op6 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -72
# %op7 = sub i32 %op6, 1
	ld.w $t0, $fp, -72
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -76
# store i32 %op7, i32* %op0
	ld.w $t0, $fp, -76
	ld.d $t1, $fp, -24
	st.w $t0, $t1, 0
# %op8 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -80
# %op9 = icmp slt i32 %op8, 5
	ld.w $t0, $fp, -80
	addi.w $t1, $zero, 5
	slt $t2, $t0, $t1
	st.b $t2, $fp, -81
# br i1 %op9, label %label14, label %label18
	ld.b $t0, $fp, -81
	bnez $t0, .main_label14
	b .main_label18
.main_label10:
# %op11 = load i32, i32* %op2
	ld.d $t0, $fp, -56
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -88
# %op12 = load i32, i32* %op1
	ld.d $t0, $fp, -40
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -92
# %op13 = add i32 %op12, %op11
	ld.w $t0, $fp, -92
	ld.w $t1, $fp, -88
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -96
# ret i32 %op13
	ld.w $a0, $fp, -96
	b main_exit
.main_label14:
# %op15 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -100
# %op16 = load i32, i32* %op1
	ld.d $t0, $fp, -40
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -104
# %op17 = add i32 %op16, %op15
	ld.w $t0, $fp, -104
	ld.w $t1, $fp, -100
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -108
# store i32 %op17, i32* %op1
	ld.w $t0, $fp, -108
	ld.d $t1, $fp, -40
	st.w $t0, $t1, 0
# br label %label22
	b .main_label22
.main_label18:
# %op19 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -112
# %op20 = load i32, i32* %op2
	ld.d $t0, $fp, -56
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -116
# %op21 = add i32 %op20, %op19
	ld.w $t0, $fp, -116
	ld.w $t1, $fp, -112
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -120
# store i32 %op21, i32* %op2
	ld.w $t0, $fp, -120
	ld.d $t1, $fp, -56
	st.w $t0, $t1, 0
# br label %label22
	b .main_label22
.main_label22:
# %op23 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -124
# %op24 = icmp ne i32 %op23, 0
	ld.w $t0, $fp, -124
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t3, $zero, $t2
	st.b $t3, $fp, -125
# br i1 %op24, label %label5, label %label10
	ld.b $t0, $fp, -125
	bnez $t0, .main_label5
	b .main_label10
main_exit:
	addi.d $sp, $sp, 128
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
