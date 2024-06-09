	.text
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -64
.main_label_entry:
# %op0 = alloca i32
	addi.d $t8, $fp, -28
	addi.d $t7, $fp, -24
	st.d $t8, $t7, 0
# store i32 10, i32* %op0
	addi.w $t0, $zero, 10
	ld.d $t1, $fp, -24
	st.w $t0, $t1, 0
# %op1 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -32
# %op2 = icmp ne i32 %op1, 0
	ld.w $t0, $fp, -32
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t3, $zero, $t2
	st.b $t3, $fp, -33
# br i1 %op2, label %label3, label %label8
	ld.b $t0, $fp, -33
	bnez $t0, .main_label3
	b .main_label8
.main_label3:
# %op4 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -40
# %op5 = sub i32 %op4, 1
	ld.w $t0, $fp, -40
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -44
# store i32 %op5, i32* %op0
	ld.w $t0, $fp, -44
	ld.d $t1, $fp, -24
	st.w $t0, $t1, 0
# %op6 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -48
# %op7 = icmp ne i32 %op6, 0
	ld.w $t0, $fp, -48
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t3, $zero, $t2
	st.b $t3, $fp, -49
# br i1 %op7, label %label3, label %label8
	ld.b $t0, $fp, -49
	bnez $t0, .main_label3
	b .main_label8
.main_label8:
# ret void
	addi.w $a0, $zero, 0
	b main_exit
main_exit:
	addi.d $sp, $sp, 64
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
