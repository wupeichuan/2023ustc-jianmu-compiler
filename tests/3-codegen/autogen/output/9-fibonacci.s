	.text
	.globl fibonacci
	.type fibonacci, @function
fibonacci:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -80
	st.w $a0, $fp, -20
.fibonacci_label_entry:
# %op1 = alloca i32
	addi.d $t8, $fp, -36
	addi.d $t7, $fp, -32
	st.d $t8, $t7, 0
# store i32 %arg0, i32* %op1
	ld.w $t0, $fp, -20
	ld.d $t1, $fp, -32
	st.w $t0, $t1, 0
# %op2 = load i32, i32* %op1
	ld.d $t0, $fp, -32
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -40
# %op3 = icmp eq i32 %op2, 0
	ld.w $t0, $fp, -40
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t3, $zero, $t2
	xori $t3, $t3, 1
	st.b $t3, $fp, -41
# br i1 %op3, label %label4, label %label5
	ld.b $t0, $fp, -41
	bnez $t0, .fibonacci_label4
	b .fibonacci_label5
.fibonacci_label4:
# ret i32 0
	addi.w $a0, $zero, 0
	b fibonacci_exit
.fibonacci_label5:
# %op6 = load i32, i32* %op1
	ld.d $t0, $fp, -32
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -48
# %op7 = icmp eq i32 %op6, 1
	ld.w $t0, $fp, -48
	addi.w $t1, $zero, 1
	xor $t2, $t0, $t1
	sltu $t3, $zero, $t2
	xori $t3, $t3, 1
	st.b $t3, $fp, -49
# br i1 %op7, label %label9, label %label10
	ld.b $t0, $fp, -49
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
	ld.d $t0, $fp, -32
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -56
# %op12 = sub i32 %op11, 2
	ld.w $t0, $fp, -56
	addi.w $t1, $zero, 2
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -60
# %op13 = call i32 @fibonacci(i32 %op12)
	ld.w $a0, $fp, -60
	bl fibonacci
	st.w $a0, $fp, -64
# %op14 = load i32, i32* %op1
	ld.d $t0, $fp, -32
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -68
# %op15 = sub i32 %op14, 1
	ld.w $t0, $fp, -68
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -72
# %op16 = call i32 @fibonacci(i32 %op15)
	ld.w $a0, $fp, -72
	bl fibonacci
	st.w $a0, $fp, -76
# %op17 = add i32 %op16, %op13
	ld.w $t0, $fp, -76
	ld.w $t1, $fp, -64
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -80
# ret i32 %op17
	ld.w $a0, $fp, -80
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
	addi.d $sp, $sp, -96
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
# br i1 %op4, label %label5, label %label13
	ld.b $t0, $fp, -53
	bnez $t0, .main_label5
	b .main_label13
.main_label5:
# %op6 = load i32, i32* %op1
	ld.d $t0, $fp, -40
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -60
# %op7 = call i32 @fibonacci(i32 %op6)
	ld.w $a0, $fp, -60
	bl fibonacci
	st.w $a0, $fp, -64
# call void @output(i32 %op7)
	ld.w $a0, $fp, -64
	bl output
# %op8 = load i32, i32* %op1
	ld.d $t0, $fp, -40
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -68
# %op9 = add i32 %op8, 1
	ld.w $t0, $fp, -68
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -72
# store i32 %op9, i32* %op1
	ld.w $t0, $fp, -72
	ld.d $t1, $fp, -40
	st.w $t0, $t1, 0
# %op10 = load i32, i32* %op1
	ld.d $t0, $fp, -40
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -76
# %op11 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -80
# %op12 = icmp slt i32 %op10, %op11
	ld.w $t0, $fp, -76
	ld.w $t1, $fp, -80
	slt $t2, $t0, $t1
	st.b $t2, $fp, -81
# br i1 %op12, label %label5, label %label13
	ld.b $t0, $fp, -81
	bnez $t0, .main_label5
	b .main_label13
.main_label13:
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
main_exit:
	addi.d $sp, $sp, 96
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
