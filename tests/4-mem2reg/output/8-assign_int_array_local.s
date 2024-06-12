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
	addi.d $t8, $fp, -64
	addi.d $t7, $fp, -24
	st.d $t8, $t7, 0
# %op1 = icmp sge i32 3, 0
	addi.w $t7, $zero, 3
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t7
	st.b $t7, $fp, -65
	addi.w $t7, $zero, 3
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	ld.b $t7, $fp, -65
	or $t7, $t7, $t8
	st.b $t7, $fp, -65
# br i1 %op1, label %label2, label %label4
	ld.b $t7, $fp, -65
	bnez $t7, .main_label2
	b .main_label4
.main_label2:
# %op3 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 3
	addi.w $t8, $zero, 3
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	ld.d $t8, $fp, -24
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -80
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
	ld.d $t8, $fp, -80
	st.w $t7, $t8, 0
# %op6 = icmp sge i32 3, 0
	addi.w $t7, $zero, 3
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t7
	st.b $t7, $fp, -81
	addi.w $t7, $zero, 3
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	ld.b $t7, $fp, -81
	or $t7, $t7, $t8
	st.b $t7, $fp, -81
# br i1 %op6, label %label7, label %label10
	ld.b $t7, $fp, -81
	bnez $t7, .main_label7
	b .main_label10
.main_label7:
# %op8 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 3
	addi.w $t8, $zero, 3
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	ld.d $t8, $fp, -24
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -96
# %op9 = load i32, i32* %op8
	ld.d $t8, $fp, -96
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -100
# br label %label11
	b .main_label11
.main_label10:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label11
	b .main_label11
.main_label11:
# ret i32 %op9
	ld.w $a0, $fp, -100
	b main_exit
main_exit:
	addi.d $sp, $sp, 112
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
