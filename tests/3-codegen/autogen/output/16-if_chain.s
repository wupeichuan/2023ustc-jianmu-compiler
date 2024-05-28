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
# %op2 = alloca i32
	addi.d $t8, $fp, -60
	addi.d $t7, $fp, -56
	st.d $t8, $t7, 0
# store i32 0, i32* %op2
	addi.w $t0, $zero, 0
	ld.d $t1, $fp, -56
	st.w $t0, $t1, 0
# store i32 2, i32* %op0
	addi.w $t0, $zero, 2
	ld.d $t1, $fp, -24
	st.w $t0, $t1, 0
# store i32 1, i32* %op1
	addi.w $t0, $zero, 1
	ld.d $t1, $fp, -40
	st.w $t0, $t1, 0
# %op3 = load i32, i32* %op1
	ld.d $t0, $fp, -40
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -64
# %op4 = icmp ne i32 %op3, 0
	ld.w $t0, $fp, -64
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t3, $zero, $t2
	st.b $t3, $fp, -65
# br i1 %op4, label %label5, label %label8
	ld.b $t0, $fp, -65
	bnez $t0, .main_label5
	b .main_label8
.main_label5:
# %op6 = load i32, i32* %op2
	ld.d $t0, $fp, -56
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -72
# %op7 = icmp ne i32 %op6, 0
	ld.w $t0, $fp, -72
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t3, $zero, $t2
	st.b $t3, $fp, -73
# br i1 %op7, label %label10, label %label11
	ld.b $t0, $fp, -73
	bnez $t0, .main_label10
	b .main_label11
.main_label8:
# %op9 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -80
# ret i32 %op9
	ld.w $a0, $fp, -80
	b main_exit
.main_label10:
# store i32 4, i32* %op0
	addi.w $t0, $zero, 4
	ld.d $t1, $fp, -24
	st.w $t0, $t1, 0
# br label %label12
	b .main_label12
.main_label11:
# store i32 3, i32* %op0
	addi.w $t0, $zero, 3
	ld.d $t1, $fp, -24
	st.w $t0, $t1, 0
# br label %label12
	b .main_label12
.main_label12:
# br label %label8
	b .main_label8
main_exit:
	addi.d $sp, $sp, 80
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
