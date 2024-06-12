	.text
	.globl min
	.type min, @function
min:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -80
	add.d $t0, $a0, $zero
	add.d $t1, $a1, $zero
.min_label_entry:
# %op2 = alloca i32
	addi.d $t2, $fp, -36
# store i32 %arg0, i32* %op2
	st.w $t0, $t2, 0
# %op3 = alloca i32
	addi.d $t0, $fp, -52
# store i32 %arg1, i32* %op3
	st.w $t1, $t0, 0
# %op4 = load i32, i32* %op2
	ld.w $t1, $t2, 0
# %op5 = load i32, i32* %op3
	ld.w $t3, $t0, 0
# %op6 = icmp sle i32 %op4, %op5
	slt $t7, $t1, $t3
	xor $t8, $t1, $t3
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	or $t1, $t7, $t8
# br i1 %op6, label %label7, label %label9
	bnez $t1, .min_label7
	b .min_label9
.min_label7:
# %op8 = load i32, i32* %op2
	ld.w $t1, $t2, 0
# ret i32 %op8
	add.w $a0, $t1, $zero
	b min_exit
.min_label9:
# %op10 = load i32, i32* %op3
	ld.w $t0, $t0, 0
# ret i32 %op10
	add.w $a0, $t0, $zero
	b min_exit
.min_label11:
# ret i32 0
	addi.w $a0, $zero, 0
	b min_exit
min_exit:
	addi.d $sp, $sp, 80
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
# %op0 = call i32 @min(i32 11, i32 22)
	addi.w $a0, $zero, 11
	addi.w $a1, $zero, 22
	bl min
	add.w $t0, $a0, $zero
# call void @output(i32 %op0)
	add.d $a0, $t0, $zero
	bl output
# %op1 = call i32 @min(i32 22, i32 33)
	addi.w $a0, $zero, 22
	addi.w $a1, $zero, 33
	bl min
	add.w $t0, $a0, $zero
# call void @output(i32 %op1)
	add.d $a0, $t0, $zero
	bl output
# %op2 = call i32 @min(i32 33, i32 11)
	addi.w $a0, $zero, 33
	addi.w $a1, $zero, 11
	bl min
	add.w $t0, $a0, $zero
# call void @output(i32 %op2)
	add.d $a0, $t0, $zero
	bl output
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
main_exit:
	addi.d $sp, $sp, 32
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
