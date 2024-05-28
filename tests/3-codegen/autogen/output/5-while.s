	.text
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -80
.main_label_entry:
# %op0 = alloca i32
	addi.d $t8, $fp, -28
	addi.d $t7, $fp, -24
	st.d $t8, $t7, 0
# %op1 = alloca i32
	addi.d $t8, $fp, -44
	addi.d $t7, $fp, -40
	st.d $t8, $t7, 0
# store i32 10, i32* %op0
	addi.w $t0, $zero, 10
	ld.d $t1, $fp, -24
	st.w $t0, $t1, 0
# store i32 0, i32* %op1
	addi.w $t0, $zero, 0
	ld.d $t1, $fp, -40
	st.w $t0, $t1, 0
# %op2 = load i32, i32* %op1
	ld.d $t0, $fp, -40
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -48
# %op3 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -52
# %op4 = icmp slt i32 %op2, %op3
	ld.w $t0, $fp, -48
	ld.w $t1, $fp, -52
	slt $t2, $t0, $t1
	st.b $t2, $fp, -53
# br i1 %op4, label %label5, label %label12
	ld.b $t0, $fp, -53
	bnez $t0, .main_label5
	b .main_label12
.main_label5:
# %op6 = load i32, i32* %op1
	ld.d $t0, $fp, -40
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -60
# call void @output(i32 %op6)
	ld.w $a0, $fp, -60
	bl output
# %op7 = load i32, i32* %op1
	ld.d $t0, $fp, -40
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -64
# %op8 = add i32 %op7, 1
	ld.w $t0, $fp, -64
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -68
# store i32 %op8, i32* %op1
	ld.w $t0, $fp, -68
	ld.d $t1, $fp, -40
	st.w $t0, $t1, 0
# %op9 = load i32, i32* %op1
	ld.d $t0, $fp, -40
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -72
# %op10 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -76
# %op11 = icmp slt i32 %op9, %op10
	ld.w $t0, $fp, -72
	ld.w $t1, $fp, -76
	slt $t2, $t0, $t1
	st.b $t2, $fp, -77
# br i1 %op11, label %label5, label %label12
	ld.b $t0, $fp, -77
	bnez $t0, .main_label5
	b .main_label12
.main_label12:
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
main_exit:
	addi.d $sp, $sp, 80
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
