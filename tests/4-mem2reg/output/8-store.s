	.text
	.globl store
	.type store, @function
store:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -112
	add.d $t0, $a0, $zero
	add.d $t1, $a1, $zero
	add.d $t2, $a2, $zero
.store_label_entry:
# %op3 = alloca i32*
	addi.d $t3, $fp, -48
# store i32* %arg0, i32** %op3
	st.d $t0, $t3, 0
# %op4 = alloca i32
	addi.d $t0, $fp, -60
# store i32 %arg1, i32* %op4
	st.w $t1, $t0, 0
# %op5 = alloca i32
	addi.d $t8, $fp, -76
	addi.d $t7, $fp, -72
	st.d $t8, $t7, 0
# store i32 %arg2, i32* %op5
	ld.d $t7, $fp, -72
	st.w $t2, $t7, 0
# %op6 = load i32, i32* %op4
	ld.w $t0, $t0, 0
# %op7 = icmp sge i32 %op6, 0
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t0
	xor $t8, $t8, $t0
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	or $t2, $t7, $t8
# br i1 %op7, label %label8, label %label11
	bnez $t2, .store_label8
	b .store_label11
.store_label8:
# %op9 = load i32*, i32** %op3
	ld.d $t2, $t3, 0
# %op10 = getelementptr i32, i32* %op9, i32 %op6
	addi.w $t7, $zero, 4
	mul.w $t7, $t0, $t7
	add.d $t7, $t2, $t7
	st.d $t7, $fp, -104
# br label %label12
	b .store_label12
.store_label11:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label12
	b .store_label12
.store_label12:
# %op13 = load i32, i32* %op5
	ld.d $t8, $fp, -72
	ld.w $t0, $t8, 0
# store i32 %op13, i32* %op10
	ld.d $t7, $fp, -104
	st.w $t0, $t7, 0
# %op14 = load i32, i32* %op5
	ld.d $t8, $fp, -72
	ld.w $t0, $t8, 0
# ret i32 %op14
	add.w $a0, $t0, $zero
	b store_exit
store_exit:
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
	addi.d $sp, $sp, -144
.main_label_entry:
# %op0 = alloca [10 x i32]
	addi.d $t8, $fp, -64
	addi.d $t7, $fp, -24
	st.d $t8, $t7, 0
# %op1 = icmp slt i32 0, 10
	addi.w $t7, $zero, 0
	addi.w $t8, $zero, 10
	slt $t7, $t7, $t8
	st.b $t7, $fp, -65
# br i1 %op1, label %label2, label %label9
# %op3 = phi i32 [ 0, %label_entry ], [ %op7, %label2 ]
	addi.w $t7, $zero, 0
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -72
	ld.b $t7, $fp, -65
	bnez $t7, .main_label2
	b .main_label9
.main_label2:
# %op3 = phi i32 [ 0, %label_entry ], [ %op7, %label2 ]
# %op4 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 0
	addi.w $t8, $zero, 0
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	ld.d $t8, $fp, -24
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -80
# %op5 = mul i32 %op3, 2
	ld.w $t7, $fp, -72
	addi.w $t8, $zero, 2
	mul.w $t7, $t7, $t8
	st.w $t7, $fp, -84
# %op6 = call i32 @store(i32* %op4, i32 %op3, i32 %op5)
	ld.d $a0, $fp, -80
	ld.w $a1, $fp, -72
	ld.w $a2, $fp, -84
	bl store
	add.w $t0, $a0, $zero
# %op7 = add i32 %op3, 1
	ld.w $t7, $fp, -72
	addi.w $t8, $zero, 1
	add.w $t0, $t7, $t8
# %op8 = icmp slt i32 %op7, 10
	addi.w $t8, $zero, 10
	slt $t1, $t0, $t8
# br i1 %op8, label %label2, label %label9
# %op3 = phi i32 [ 0, %label_entry ], [ %op7, %label2 ]
	add.d $t7, $t0, $zero
	st.w $t7, $fp, -72
	bnez $t1, .main_label2
	b .main_label9
.main_label9:
# %op10 = icmp slt i32 0, 10
	addi.w $t7, $zero, 0
	addi.w $t8, $zero, 10
	slt $t0, $t7, $t8
# br i1 %op10, label %label11, label %label15
# %op13 = phi i32 [ 0, %label9 ], [ %op23, %label21 ]
	addi.w $t7, $zero, 0
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -104
# %op12 = phi i32 [ 0, %label9 ], [ %op22, %label21 ]
	addi.w $t7, $zero, 0
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -100
	bnez $t0, .main_label11
# %op16 = phi i32 [ 0, %label9 ], [ %op22, %label21 ]
	addi.w $t7, $zero, 0
	add.d $t0, $t7, $zero
	b .main_label15
.main_label11:
# %op12 = phi i32 [ 0, %label9 ], [ %op22, %label21 ]
# %op13 = phi i32 [ 0, %label9 ], [ %op23, %label21 ]
# %op14 = icmp sge i32 %op13, 0
	ld.w $t7, $fp, -104
	addi.w $t8, $zero, 0
	slt $t2, $t8, $t7
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	or $t2, $t2, $t8
# br i1 %op14, label %label17, label %label20
	bnez $t2, .main_label17
	b .main_label20
.main_label15:
# %op16 = phi i32 [ 0, %label9 ], [ %op22, %label21 ]
# call void @output(i32 %op16)
	add.d $a0, $t0, $zero
	bl output
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
.main_label17:
# %op18 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 %op13
	ld.w $t8, $fp, -104
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	ld.d $t8, $fp, -24
	add.d $t2, $t8, $t7
# %op19 = load i32, i32* %op18
	ld.w $t7, $t2, 0
	st.w $t7, $fp, -124
# br label %label21
	b .main_label21
.main_label20:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label21
	b .main_label21
.main_label21:
# %op22 = add i32 %op12, %op19
	ld.w $t7, $fp, -100
	ld.w $t8, $fp, -124
	add.w $t0, $t7, $t8
# %op23 = add i32 %op13, 1
	ld.w $t7, $fp, -104
	addi.w $t8, $zero, 1
	add.w $t1, $t7, $t8
# %op24 = icmp slt i32 %op23, 10
	addi.w $t8, $zero, 10
	slt $t2, $t1, $t8
# br i1 %op24, label %label11, label %label15
# %op12 = phi i32 [ 0, %label9 ], [ %op22, %label21 ]
	add.d $t7, $t0, $zero
	st.w $t7, $fp, -100
# %op13 = phi i32 [ 0, %label9 ], [ %op23, %label21 ]
	add.d $t7, $t1, $zero
	st.w $t7, $fp, -104
	bnez $t2, .main_label11
# %op16 = phi i32 [ 0, %label9 ], [ %op22, %label21 ]
	add.d $t0, $t0, $zero
	b .main_label15
main_exit:
	addi.d $sp, $sp, 144
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
