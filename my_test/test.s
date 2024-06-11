	.text
	.globl gcd
	.type gcd, @function
gcd:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -112
	add.d $t0, $a0, $zero
	add.d $t1, $a1, $zero
.gcd_label_entry:
# %op2 = alloca i32
	addi.d $t8, $fp, -36
	addi.d $t7, $fp, -32
	st.d $t8, $t7, 0
# store i32 %arg0, i32* %op2
	ld.d $t7, $fp, -32
	st.w $t0, $t7, 0
# %op3 = alloca i32
	addi.d $t0, $fp, -52
# store i32 %arg1, i32* %op3
	st.w $t1, $t0, 0
# %op4 = load i32, i32* %op3
	ld.w $t1, $t0, 0
# %op5 = icmp eq i32 %op4, 0
	addi.w $t8, $zero, 0
	xor $t7, $t1, $t8
	sltu $t7, $zero, $t7
	xori $t1, $t7, 1
# br i1 %op5, label %label6, label %label8
	bnez $t1, .gcd_label6
	b .gcd_label8
.gcd_label6:
# %op7 = load i32, i32* %op2
	ld.d $t8, $fp, -32
	ld.w $t1, $t8, 0
# ret i32 %op7
	add.w $a0, $t1, $zero
	b gcd_exit
.gcd_label8:
# %op9 = load i32, i32* %op3
	ld.w $t7, $t0, 0
	st.w $t7, $fp, -68
# %op10 = load i32, i32* %op3
	ld.w $t7, $t0, 0
	st.w $t7, $fp, -72
# %op11 = load i32, i32* %op3
	ld.w $t0, $t0, 0
# %op12 = load i32, i32* %op2
	ld.d $t8, $fp, -32
	ld.w $t1, $t8, 0
# %op13 = sdiv i32 %op12, %op11
	div.w $t0, $t1, $t0
# %op14 = mul i32 %op13, %op10
	ld.w $t8, $fp, -72
	mul.w $t0, $t0, $t8
# %op15 = load i32, i32* %op2
	ld.d $t8, $fp, -32
	ld.w $t1, $t8, 0
# %op16 = sub i32 %op15, %op14
	sub.w $t0, $t1, $t0
# %op17 = call i32 @gcd(i32 %op9, i32 %op16)
	ld.w $a0, $fp, -68
	add.d $a1, $t0, $zero
	bl gcd
	add.w $t0, $a0, $zero
# ret i32 %op17
	add.w $a0, $t0, $zero
	b gcd_exit
.gcd_label18:
# ret i32 0
	addi.w $a0, $zero, 0
	b gcd_exit
gcd_exit:
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
	addi.d $sp, $sp, -48
.main_label_entry:
# %op0 = add i32 435, 1
	addi.w $t7, $zero, 435
	addi.w $t8, $zero, 1
	add.w $t0, $t7, $t8
# %op1 = icmp sge i32 135, %op0
	addi.w $t8, $zero, 135
	slt $t7, $t0, $t8
	xor $t8, $t0, $t8
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	or $t0, $t7, $t8
# br i1 %op1, label %label2, label %label3
	bnez $t0, .main_label2
# %op4 = phi i32 [ 135, %label_entry ], [ 435, %label2 ]
	addi.w $t7, $zero, 135
	add.d $t0, $t7, $zero
# %op5 = phi i32 [ 435, %label_entry ], [ 135, %label2 ]
	addi.w $t7, $zero, 435
	add.d $t1, $t7, $zero
	b .main_label3
.main_label2:
# br label %label3
# %op5 = phi i32 [ 435, %label_entry ], [ 135, %label2 ]
	addi.w $t7, $zero, 135
	add.d $t1, $t7, $zero
# %op4 = phi i32 [ 135, %label_entry ], [ 435, %label2 ]
	addi.w $t7, $zero, 435
	add.d $t0, $t7, $zero
	b .main_label3
.main_label3:
# %op4 = phi i32 [ 135, %label_entry ], [ 435, %label2 ]
# %op5 = phi i32 [ 435, %label_entry ], [ 135, %label2 ]
# %op6 = call i32 @gcd(i32 %op5, i32 %op4)
	add.d $a0, $t1, $zero
	add.d $a1, $t0, $zero
	bl gcd
	add.w $t0, $a0, $zero
# call void @output(i32 %op6)
	add.d $a0, $t0, $zero
	bl output
# ret void
	addi.w $a0, $zero, 0
	b main_exit
main_exit:
	addi.d $sp, $sp, 48
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
