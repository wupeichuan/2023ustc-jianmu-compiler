	.text
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -176
.main_label_entry:
# %op0 = alloca [10 x i32]
	addi.d $t8, $fp, -64
	addi.d $t7, $fp, -24
	st.d $t8, $t7, 0
# %op1 = icmp sge i32 0, 0
	addi.w $t7, $zero, 0
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
# %op3 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 0
	addi.w $t8, $zero, 0
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	ld.d $t8, $fp, -24
	add.d $t1, $t8, $t7
# br label %label5
	b .main_label5
.main_label4:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label5
	b .main_label5
.main_label5:
# store i32 11, i32* %op3
	addi.w $t7, $zero, 11
	st.w $t7, $t1, 0
# %op6 = icmp sge i32 4, 0
	addi.w $t7, $zero, 4
	addi.w $t8, $zero, 0
	slt $t1, $t8, $t7
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	or $t1, $t1, $t8
# br i1 %op6, label %label7, label %label9
	bnez $t1, .main_label7
	b .main_label9
.main_label7:
# %op8 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 4
	addi.w $t8, $zero, 4
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	ld.d $t8, $fp, -24
	add.d $t1, $t8, $t7
# br label %label10
	b .main_label10
.main_label9:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label10
	b .main_label10
.main_label10:
# store i32 22, i32* %op8
	addi.w $t7, $zero, 22
	st.w $t7, $t1, 0
# %op11 = icmp sge i32 9, 0
	addi.w $t7, $zero, 9
	addi.w $t8, $zero, 0
	slt $t1, $t8, $t7
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	or $t1, $t1, $t8
# br i1 %op11, label %label12, label %label14
	bnez $t1, .main_label12
	b .main_label14
.main_label12:
# %op13 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 9
	addi.w $t8, $zero, 9
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	ld.d $t8, $fp, -24
	add.d $t1, $t8, $t7
# br label %label15
	b .main_label15
.main_label14:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label15
	b .main_label15
.main_label15:
# store i32 33, i32* %op13
	addi.w $t7, $zero, 33
	st.w $t7, $t1, 0
# %op16 = icmp sge i32 0, 0
	addi.w $t7, $zero, 0
	addi.w $t8, $zero, 0
	slt $t1, $t8, $t7
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	or $t1, $t1, $t8
# br i1 %op16, label %label17, label %label20
	bnez $t1, .main_label17
	b .main_label20
.main_label17:
# %op18 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 0
	addi.w $t8, $zero, 0
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	ld.d $t8, $fp, -24
	add.d $t1, $t8, $t7
# %op19 = load i32, i32* %op18
	ld.w $t1, $t1, 0
# br label %label21
	b .main_label21
.main_label20:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label21
	b .main_label21
.main_label21:
# call void @output(i32 %op19)
	add.d $a0, $t1, $zero
	bl output
# %op22 = icmp sge i32 4, 0
	addi.w $t7, $zero, 4
	addi.w $t8, $zero, 0
	slt $t0, $t8, $t7
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	or $t0, $t0, $t8
# br i1 %op22, label %label23, label %label26
	bnez $t0, .main_label23
	b .main_label26
.main_label23:
# %op24 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 4
	addi.w $t8, $zero, 4
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	ld.d $t8, $fp, -24
	add.d $t0, $t8, $t7
# %op25 = load i32, i32* %op24
	ld.w $t0, $t0, 0
# br label %label27
	b .main_label27
.main_label26:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label27
	b .main_label27
.main_label27:
# call void @output(i32 %op25)
	add.d $a0, $t0, $zero
	bl output
# %op28 = icmp sge i32 9, 0
	addi.w $t7, $zero, 9
	addi.w $t8, $zero, 0
	slt $t0, $t8, $t7
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	or $t0, $t0, $t8
# br i1 %op28, label %label29, label %label32
	bnez $t0, .main_label29
	b .main_label32
.main_label29:
# %op30 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 9
	addi.w $t8, $zero, 9
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	ld.d $t8, $fp, -24
	add.d $t0, $t8, $t7
# %op31 = load i32, i32* %op30
	ld.w $t0, $t0, 0
# br label %label33
	b .main_label33
.main_label32:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label33
	b .main_label33
.main_label33:
# call void @output(i32 %op31)
	add.d $a0, $t0, $zero
	bl output
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
main_exit:
	addi.d $sp, $sp, 176
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
