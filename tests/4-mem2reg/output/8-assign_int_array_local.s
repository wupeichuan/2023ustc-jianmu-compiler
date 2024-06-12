	.text
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -112
.main_label_entry:
# %op0 = alloca [10 x i32]
	addi.d $t0, $fp, -64
# %op1 = icmp sge i32 3, 0
	addi.w $t7, $zero, 3
	addi.w $t8, $zero, 0
	slt $t1, $t8, $t7
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	or $t1, $t1, $t8
# br i1 %op1, label %label2, label %label4
	bnez $t1, .main_label2
	b .main_label4
.main_label2:
# %op3 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 3
	addi.w $t8, $zero, 3
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	add.d $t1, $t0, $t7
# br label %label5
	b .main_label5
.main_label4:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label5
	b .main_label5
.main_label5:
# store i32 1234, i32* %op3
	addi.w $t7, $zero, 1234
	st.w $t7, $t1, 0
# %op6 = icmp sge i32 3, 0
	addi.w $t7, $zero, 3
	addi.w $t8, $zero, 0
	slt $t1, $t8, $t7
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	or $t1, $t1, $t8
# br i1 %op6, label %label7, label %label10
	bnez $t1, .main_label7
	b .main_label10
.main_label7:
# %op8 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 3
	addi.w $t8, $zero, 3
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	add.d $t0, $t0, $t7
# %op9 = load i32, i32* %op8
	ld.w $t0, $t0, 0
# br label %label11
	b .main_label11
.main_label10:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label11
	b .main_label11
.main_label11:
# ret i32 %op9
	add.w $a0, $t0, $zero
	b main_exit
main_exit:
	addi.d $sp, $sp, 112
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
