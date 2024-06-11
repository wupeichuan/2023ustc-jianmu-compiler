	.text
	.globl fibonacci
	.type fibonacci, @function
fibonacci:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -80
	add.d $t0, $a0, $zero
.fibonacci_label_entry:
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
	bnez $t0, .fibonacci_label4
	b .fibonacci_label5
.fibonacci_label4:
# ret i32 0
	addi.w $a0, $zero, 0
	b fibonacci_exit
.fibonacci_label5:
# %op6 = load i32, i32* %op1
	ld.d $t8, $fp, -32
	ld.w $t0, $t8, 0
# %op7 = icmp eq i32 %op6, 1
	addi.w $t8, $zero, 1
	xor $t7, $t0, $t8
	sltu $t7, $zero, $t7
	xori $t0, $t7, 1
# br i1 %op7, label %label9, label %label10
	bnez $t0, .fibonacci_label9
	b .fibonacci_label10
.fibonacci_label8:
# ret i32 0
	addi.w $a0, $zero, 0
	b fibonacci_exit
.fibonacci_label9:
# ret i32 1
	addi.w $a0, $zero, 1
	b fibonacci_exit
.fibonacci_label10:
# %op11 = load i32, i32* %op1
	ld.d $t8, $fp, -32
	ld.w $t0, $t8, 0
# %op12 = sub i32 %op11, 2
	addi.w $t8, $zero, 2
	sub.w $t0, $t0, $t8
# %op13 = call i32 @fibonacci(i32 %op12)
	add.d $a0, $t0, $zero
	bl fibonacci
	st.w $a0, $fp, -64
# %op14 = load i32, i32* %op1
	ld.d $t8, $fp, -32
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -68
# %op15 = sub i32 %op14, 1
	ld.w $t7, $fp, -68
	addi.w $t8, $zero, 1
	sub.w $t7, $t7, $t8
	st.w $t7, $fp, -72
# %op16 = call i32 @fibonacci(i32 %op15)
	ld.w $a0, $fp, -72
	bl fibonacci
	add.w $t0, $a0, $zero
# %op17 = add i32 %op16, %op13
	ld.w $t8, $fp, -64
	add.w $t0, $t0, $t8
# ret i32 %op17
	add.w $a0, $t0, $zero
	b fibonacci_exit
.fibonacci_label18:
# br label %label8
	b .fibonacci_label8
fibonacci_exit:
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
	addi.d $sp, $sp, -48
.main_label_entry:
# %op0 = icmp slt i32 0, 10
	addi.w $t7, $zero, 0
	addi.w $t8, $zero, 10
	slt $t7, $t7, $t8
	st.b $t7, $fp, -17
# br i1 %op0, label %label1, label %label6
# %op2 = phi i32 [ 0, %label_entry ], [ %op4, %label1 ]
	addi.w $t7, $zero, 0
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -24
	ld.b $t7, $fp, -17
	bnez $t7, .main_label1
	b .main_label6
.main_label1:
# %op2 = phi i32 [ 0, %label_entry ], [ %op4, %label1 ]
# %op3 = call i32 @fibonacci(i32 %op2)
	ld.w $a0, $fp, -24
	bl fibonacci
	add.w $t0, $a0, $zero
# call void @output(i32 %op3)
	add.d $a0, $t0, $zero
	bl output
# %op4 = add i32 %op2, 1
	ld.w $t7, $fp, -24
	addi.w $t8, $zero, 1
	add.w $t0, $t7, $t8
# %op5 = icmp slt i32 %op4, 10
	addi.w $t8, $zero, 10
	slt $t1, $t0, $t8
# br i1 %op5, label %label1, label %label6
# %op2 = phi i32 [ 0, %label_entry ], [ %op4, %label1 ]
	add.d $t7, $t0, $zero
	st.w $t7, $fp, -24
	bnez $t1, .main_label1
	b .main_label6
.main_label6:
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
main_exit:
	addi.d $sp, $sp, 48
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
