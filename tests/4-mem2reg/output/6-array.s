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
# store i32 11, i32* %op3
	addi.w $t7, $zero, 11
	ld.d $t8, $fp, -80
	st.w $t7, $t8, 0
# %op6 = icmp sge i32 4, 0
	addi.w $t7, $zero, 4
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t7
	st.b $t7, $fp, -81
	addi.w $t7, $zero, 4
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	ld.b $t7, $fp, -81
	or $t7, $t7, $t8
	st.b $t7, $fp, -81
# br i1 %op6, label %label7, label %label9
	ld.b $t7, $fp, -81
	bnez $t7, .main_label7
	b .main_label9
.main_label7:
# %op8 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 4
	addi.w $t8, $zero, 4
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	ld.d $t8, $fp, -24
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -96
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
	ld.d $t8, $fp, -96
	st.w $t7, $t8, 0
# %op11 = icmp sge i32 9, 0
	addi.w $t7, $zero, 9
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t7
	st.b $t7, $fp, -97
	addi.w $t7, $zero, 9
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	ld.b $t7, $fp, -97
	or $t7, $t7, $t8
	st.b $t7, $fp, -97
# br i1 %op11, label %label12, label %label14
	ld.b $t7, $fp, -97
	bnez $t7, .main_label12
	b .main_label14
.main_label12:
# %op13 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 9
	addi.w $t8, $zero, 9
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	ld.d $t8, $fp, -24
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -112
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
	ld.d $t8, $fp, -112
	st.w $t7, $t8, 0
# %op16 = icmp sge i32 0, 0
	addi.w $t7, $zero, 0
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t7
	st.b $t7, $fp, -113
	addi.w $t7, $zero, 0
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	ld.b $t7, $fp, -113
	or $t7, $t7, $t8
	st.b $t7, $fp, -113
# br i1 %op16, label %label17, label %label20
	ld.b $t7, $fp, -113
	bnez $t7, .main_label17
	b .main_label20
.main_label17:
# %op18 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 0
	addi.w $t8, $zero, 0
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	ld.d $t8, $fp, -24
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -128
# %op19 = load i32, i32* %op18
	ld.d $t8, $fp, -128
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -132
# br label %label21
	b .main_label21
.main_label20:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label21
	b .main_label21
.main_label21:
# call void @output(i32 %op19)
	ld.w $a0, $fp, -132
	bl output
# %op22 = icmp sge i32 4, 0
	addi.w $t7, $zero, 4
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t7
	st.b $t7, $fp, -133
	addi.w $t7, $zero, 4
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	ld.b $t7, $fp, -133
	or $t7, $t7, $t8
	st.b $t7, $fp, -133
# br i1 %op22, label %label23, label %label26
	ld.b $t7, $fp, -133
	bnez $t7, .main_label23
	b .main_label26
.main_label23:
# %op24 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 4
	addi.w $t8, $zero, 4
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	ld.d $t8, $fp, -24
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -144
# %op25 = load i32, i32* %op24
	ld.d $t8, $fp, -144
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -148
# br label %label27
	b .main_label27
.main_label26:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label27
	b .main_label27
.main_label27:
# call void @output(i32 %op25)
	ld.w $a0, $fp, -148
	bl output
# %op28 = icmp sge i32 9, 0
	addi.w $t7, $zero, 9
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t7
	st.b $t7, $fp, -149
	addi.w $t7, $zero, 9
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	ld.b $t7, $fp, -149
	or $t7, $t7, $t8
	st.b $t7, $fp, -149
# br i1 %op28, label %label29, label %label32
	ld.b $t7, $fp, -149
	bnez $t7, .main_label29
	b .main_label32
.main_label29:
# %op30 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 9
	addi.w $t8, $zero, 9
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	ld.d $t8, $fp, -24
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -160
# %op31 = load i32, i32* %op30
	ld.d $t8, $fp, -160
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -164
# br label %label33
	b .main_label33
.main_label32:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label33
	b .main_label33
.main_label33:
# call void @output(i32 %op31)
	ld.w $a0, $fp, -164
	bl output
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
main_exit:
	addi.d $sp, $sp, 176
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
