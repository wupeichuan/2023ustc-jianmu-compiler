	.text
	.globl store
	.type store, @function
store:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -112
	st.d $a0, $fp, -24
	st.w $a1, $fp, -28
	st.w $a2, $fp, -32
.store_label_entry:
# %op3 = alloca i32*
	addi.d $t8, $fp, -48
	addi.d $t7, $fp, -40
	st.d $t8, $t7, 0
# store i32* %arg0, i32** %op3
	ld.d $t0, $fp, -24
	ld.d $t1, $fp, -40
	st.d $t0, $t1, 0
# %op4 = alloca i32
	addi.d $t8, $fp, -60
	addi.d $t7, $fp, -56
	st.d $t8, $t7, 0
# store i32 %arg1, i32* %op4
	ld.w $t0, $fp, -28
	ld.d $t1, $fp, -56
	st.w $t0, $t1, 0
# %op5 = alloca i32
	addi.d $t8, $fp, -76
	addi.d $t7, $fp, -72
	st.d $t8, $t7, 0
# store i32 %arg2, i32* %op5
	ld.w $t0, $fp, -32
	ld.d $t1, $fp, -72
	st.w $t0, $t1, 0
# %op6 = load i32, i32* %op4
	ld.d $t0, $fp, -56
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -80
# %op7 = icmp sge i32 %op6, 0
	ld.w $t0, $fp, -80
	addi.w $t1, $zero, 0
	slt $t2, $t1, $t0
	xor $t3, $t0, $t1
	sltu $t4, $zero, $t3
	xori $t4, $t4, 1
	or $t5, $t2, $t4
	st.b $t5, $fp, -81
# br i1 %op7, label %label8, label %label11
	ld.b $t0, $fp, -81
	bnez $t0, .store_label8
	b .store_label11
.store_label8:
# %op9 = load i32*, i32** %op3
	ld.d $t0, $fp, -40
	ld.d $t0, $t0, 0
	st.d $t0, $fp, -96
# %op10 = getelementptr i32, i32* %op9, i32 %op6
	ld.d $t3, $fp, -96
	ld.w $t0, $fp, -80
	addi.w $t1, $zero, 4
	mul.w $t2, $t0, $t1
	add.d $t3, $t3, $t2
	st.d $t3, $fp, -104
# br label %label12
	b .store_label12
.store_label11:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label12
	b .store_label12
.store_label12:
# %op13 = load i32, i32* %op5
	ld.d $t0, $fp, -72
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -108
# store i32 %op13, i32* %op10
	ld.w $t0, $fp, -108
	ld.d $t1, $fp, -104
	st.w $t0, $t1, 0
# %op14 = load i32, i32* %op5
	ld.d $t0, $fp, -72
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -112
# ret i32 %op14
	ld.w $a0, $fp, -112
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
	addi.d $sp, $sp, -208
.main_label_entry:
# %op0 = alloca [10 x i32]
	addi.d $t8, $fp, -64
	addi.d $t7, $fp, -24
	st.d $t8, $t7, 0
# %op1 = alloca i32
	addi.d $t8, $fp, -76
	addi.d $t7, $fp, -72
	st.d $t8, $t7, 0
# %op2 = alloca i32
	addi.d $t8, $fp, -92
	addi.d $t7, $fp, -88
	st.d $t8, $t7, 0
# store i32 0, i32* %op1
	addi.w $t0, $zero, 0
	ld.d $t1, $fp, -72
	st.w $t0, $t1, 0
# %op3 = load i32, i32* %op1
	ld.d $t0, $fp, -72
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -96
# %op4 = icmp slt i32 %op3, 10
	ld.w $t0, $fp, -96
	addi.w $t1, $zero, 10
	slt $t2, $t0, $t1
	st.b $t2, $fp, -97
# br i1 %op4, label %label5, label %label15
	ld.b $t0, $fp, -97
	bnez $t0, .main_label5
	b .main_label15
.main_label5:
# %op6 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 0
	ld.d $t3, $fp, -24
	addi.w $t0, $zero, 0
	addi.w $t1, $zero, 4
	mul.w $t2, $t0, $t1
	add.d $t3, $t3, $t2
	st.d $t3, $fp, -112
# %op7 = load i32, i32* %op1
	ld.d $t0, $fp, -72
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -116
# %op8 = load i32, i32* %op1
	ld.d $t0, $fp, -72
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -120
# %op9 = mul i32 %op8, 2
	ld.w $t0, $fp, -120
	addi.w $t1, $zero, 2
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -124
# %op10 = call i32 @store(i32* %op6, i32 %op7, i32 %op9)
	ld.d $a0, $fp, -112
	ld.w $a1, $fp, -116
	ld.w $a2, $fp, -124
	bl store
	st.w $a0, $fp, -128
# %op11 = load i32, i32* %op1
	ld.d $t0, $fp, -72
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -132
# %op12 = add i32 %op11, 1
	ld.w $t0, $fp, -132
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -136
# store i32 %op12, i32* %op1
	ld.w $t0, $fp, -136
	ld.d $t1, $fp, -72
	st.w $t0, $t1, 0
# %op13 = load i32, i32* %op1
	ld.d $t0, $fp, -72
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -140
# %op14 = icmp slt i32 %op13, 10
	ld.w $t0, $fp, -140
	addi.w $t1, $zero, 10
	slt $t2, $t0, $t1
	st.b $t2, $fp, -141
# br i1 %op14, label %label5, label %label15
	ld.b $t0, $fp, -141
	bnez $t0, .main_label5
	b .main_label15
.main_label15:
# store i32 0, i32* %op2
	addi.w $t0, $zero, 0
	ld.d $t1, $fp, -88
	st.w $t0, $t1, 0
# store i32 0, i32* %op1
	addi.w $t0, $zero, 0
	ld.d $t1, $fp, -72
	st.w $t0, $t1, 0
# %op16 = load i32, i32* %op1
	ld.d $t0, $fp, -72
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -148
# %op17 = icmp slt i32 %op16, 10
	ld.w $t0, $fp, -148
	addi.w $t1, $zero, 10
	slt $t2, $t0, $t1
	st.b $t2, $fp, -149
# br i1 %op17, label %label18, label %label21
	ld.b $t0, $fp, -149
	bnez $t0, .main_label18
	b .main_label21
.main_label18:
# %op19 = load i32, i32* %op1
	ld.d $t0, $fp, -72
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -156
# %op20 = icmp sge i32 %op19, 0
	ld.w $t0, $fp, -156
	addi.w $t1, $zero, 0
	slt $t2, $t1, $t0
	xor $t3, $t0, $t1
	sltu $t4, $zero, $t3
	xori $t4, $t4, 1
	or $t5, $t2, $t4
	st.b $t5, $fp, -157
# br i1 %op20, label %label23, label %label26
	ld.b $t0, $fp, -157
	bnez $t0, .main_label23
	b .main_label26
.main_label21:
# %op22 = load i32, i32* %op2
	ld.d $t0, $fp, -88
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -164
# call void @output(i32 %op22)
	ld.w $a0, $fp, -164
	bl output
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
.main_label23:
# %op24 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 %op19
	ld.d $t3, $fp, -24
	ld.w $t0, $fp, -156
	addi.w $t1, $zero, 4
	mul.w $t2, $t0, $t1
	add.d $t3, $t3, $t2
	st.d $t3, $fp, -176
# %op25 = load i32, i32* %op24
	ld.d $t0, $fp, -176
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -180
# br label %label27
	b .main_label27
.main_label26:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label27
	b .main_label27
.main_label27:
# %op28 = load i32, i32* %op2
	ld.d $t0, $fp, -88
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -184
# %op29 = add i32 %op28, %op25
	ld.w $t0, $fp, -184
	ld.w $t1, $fp, -180
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -188
# store i32 %op29, i32* %op2
	ld.w $t0, $fp, -188
	ld.d $t1, $fp, -88
	st.w $t0, $t1, 0
# %op30 = load i32, i32* %op1
	ld.d $t0, $fp, -72
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -192
# %op31 = add i32 %op30, 1
	ld.w $t0, $fp, -192
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -196
# store i32 %op31, i32* %op1
	ld.w $t0, $fp, -196
	ld.d $t1, $fp, -72
	st.w $t0, $t1, 0
# %op32 = load i32, i32* %op1
	ld.d $t0, $fp, -72
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -200
# %op33 = icmp slt i32 %op32, 10
	ld.w $t0, $fp, -200
	addi.w $t1, $zero, 10
	slt $t2, $t0, $t1
	st.b $t2, $fp, -201
# br i1 %op33, label %label18, label %label21
	ld.b $t0, $fp, -201
	bnez $t0, .main_label18
	b .main_label21
main_exit:
	addi.d $sp, $sp, 208
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
