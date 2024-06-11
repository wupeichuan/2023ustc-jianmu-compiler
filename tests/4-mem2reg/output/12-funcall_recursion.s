	.text
	.globl factorial
	.type factorial, @function
factorial:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -64
	add.d $t0, $a0, $zero
.factorial_label_entry:
# %op1 = alloca i32
	addi.d $t8, $fp, -36
	addi.d $t7, $fp, -32
	st.d $t8, $t7, 0
# store i32 %arg0, i32* %op1
	ld.d $t7, $fp, -32
	st.w $t0, $t7, 0
# %op2 = load i32, i32* %op1
	ld.d $t8, $fp, -32
	ld.w $t0, $t8, 0
# %op3 = icmp eq i32 %op2, 0
	addi.w $t8, $zero, 0
	xor $t7, $t0, $t8
	sltu $t7, $zero, $t7
	xori $t0, $t7, 1
# br i1 %op3, label %label4, label %label5
	bnez $t0, .factorial_label4
	b .factorial_label5
.factorial_label4:
# ret i32 1
	addi.w $a0, $zero, 1
	b factorial_exit
.factorial_label5:
# %op6 = load i32, i32* %op1
	ld.d $t8, $fp, -32
	ld.w $t0, $t8, 0
# %op7 = sub i32 %op6, 1
	addi.w $t8, $zero, 1
	sub.w $t0, $t0, $t8
# %op8 = call i32 @factorial(i32 %op7)
	add.d $a0, $t0, $zero
	bl factorial
	add.w $t0, $a0, $zero
# %op9 = load i32, i32* %op1
	ld.d $t8, $fp, -32
	ld.w $t1, $t8, 0
# %op10 = mul i32 %op9, %op8
	mul.w $t0, $t1, $t0
# ret i32 %op10
	add.w $a0, $t0, $zero
	b factorial_exit
.factorial_label11:
# ret i32 0
	addi.w $a0, $zero, 0
	b factorial_exit
factorial_exit:
	addi.d $sp, $sp, 64
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
# %op0 = call i32 @factorial(i32 10)
	addi.w $a0, $zero, 10
	bl factorial
	add.w $t0, $a0, $zero
# ret i32 %op0
	add.w $a0, $t0, $zero
	b main_exit
main_exit:
	addi.d $sp, $sp, 32
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
