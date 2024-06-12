# Global variables
	.text
	.section .bss, "aw", @nobits
	.globl matrix
	.type matrix, @object
	.size matrix, 80000000
matrix:
	.space 80000000
	.globl ad
	.type ad, @object
	.size ad, 400000
ad:
	.space 400000
	.globl len
	.type len, @object
	.size len, 4
len:
	.space 4
	.text
	.globl readarray
	.type readarray, @function
readarray:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -64
.readarray_label_entry:
# %op0 = load i32, i32* @len
	la.local $t8, len
	ld.w $t0, $t8, 0
# %op1 = icmp slt i32 0, %op0
	addi.w $t8, $zero, 0
	slt $t0, $t8, $t0
# br i1 %op1, label %label2, label %label5
# %op3 = phi i32 [ 0, %label_entry ], [ %op11, %label9 ]
	addi.w $t7, $zero, 0
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -28
	bnez $t0, .readarray_label2
	b .readarray_label5
.readarray_label2:
# %op3 = phi i32 [ 0, %label_entry ], [ %op11, %label9 ]
# %op4 = icmp sge i32 %op3, 0
	ld.w $t7, $fp, -28
	addi.w $t8, $zero, 0
	slt $t1, $t8, $t7
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	or $t1, $t1, $t8
# br i1 %op4, label %label6, label %label8
	bnez $t1, .readarray_label6
	b .readarray_label8
.readarray_label5:
# ret void
	addi.w $a0, $zero, 0
	b readarray_exit
.readarray_label6:
# %op7 = getelementptr [100000 x i32], [100000 x i32]* @ad, i32 0, i32 %op3
	ld.w $t8, $fp, -28
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	la.local $t8, ad
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -40
# br label %label9
	b .readarray_label9
.readarray_label8:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label9
	b .readarray_label9
.readarray_label9:
# %op10 = call i32 @input()
	bl input
	add.w $t0, $a0, $zero
# store i32 %op10, i32* %op7
	ld.d $t7, $fp, -40
	st.w $t0, $t7, 0
# %op11 = add i32 %op3, 1
	ld.w $t7, $fp, -28
	addi.w $t8, $zero, 1
	add.w $t0, $t7, $t8
# %op12 = load i32, i32* @len
	la.local $t8, len
	ld.w $t1, $t8, 0
# %op13 = icmp slt i32 %op11, %op12
	slt $t1, $t0, $t1
# br i1 %op13, label %label2, label %label5
# %op3 = phi i32 [ 0, %label_entry ], [ %op11, %label9 ]
	add.d $t7, $t0, $zero
	st.w $t7, $fp, -28
	bnez $t1, .readarray_label2
	b .readarray_label5
readarray_exit:
	addi.d $sp, $sp, 64
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl transpose
	.type transpose, @function
transpose:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -304
	add.d $t0, $a0, $zero
	add.d $t1, $a1, $zero
	add.d $t2, $a2, $zero
.transpose_label_entry:
# %op3 = alloca i32
	addi.d $t3, $fp, -52
# store i32 %arg0, i32* %op3
	st.w $t0, $t3, 0
# %op4 = alloca i32*
	addi.d $t0, $fp, -72
# store i32* %arg1, i32** %op4
	st.d $t1, $t0, 0
# %op5 = alloca i32
	addi.d $t1, $fp, -84
# store i32 %arg2, i32* %op5
	st.w $t2, $t1, 0
# %op6 = load i32, i32* %op5
	ld.w $t2, $t1, 0
# %op7 = load i32, i32* %op3
	ld.w $t3, $t3, 0
# %op8 = sdiv i32 %op7, %op6
	div.w $t2, $t3, $t2
# %op9 = icmp slt i32 0, %op8
	addi.w $t8, $zero, 0
	slt $t3, $t8, $t2
# br i1 %op9, label %label10, label %label14
	st.b $t3, $fp, -97
# %op11 = phi i32 [ 0, %label_entry ], [ %op20, %label19 ]
	addi.w $t7, $zero, 0
	add.d $t3, $t7, $zero
	ld.b $t7, $fp, -97
	bnez $t7, .transpose_label10
	b .transpose_label14
.transpose_label10:
# %op11 = phi i32 [ 0, %label_entry ], [ %op20, %label19 ]
# %op12 = load i32, i32* %op5
	ld.w $t4, $t1, 0
# %op13 = icmp slt i32 0, %op12
	addi.w $t8, $zero, 0
	slt $t4, $t8, $t4
# br i1 %op13, label %label16, label %label19
	st.b $t4, $fp, -109
# %op17 = phi i32 [ 0, %label10 ], [ %op30, %label29 ]
	addi.w $t7, $zero, 0
	add.d $t4, $t7, $zero
	ld.b $t7, $fp, -109
	bnez $t7, .transpose_label16
	b .transpose_label19
.transpose_label14:
# %op15 = sub i32 0, 1
	addi.w $t7, $zero, 0
	addi.w $t8, $zero, 1
	sub.w $t0, $t7, $t8
# ret i32 %op15
	add.w $a0, $t0, $zero
	b transpose_exit
.transpose_label16:
# %op17 = phi i32 [ 0, %label10 ], [ %op30, %label29 ]
# %op18 = icmp slt i32 %op11, %op17
	slt $t5, $t3, $t4
# br i1 %op18, label %label22, label %label24
	bnez $t5, .transpose_label22
	b .transpose_label24
.transpose_label19:
# %op20 = add i32 %op11, 1
	addi.w $t8, $zero, 1
	add.w $t3, $t3, $t8
# %op21 = icmp slt i32 %op20, %op8
	slt $t6, $t3, $t2
# br i1 %op21, label %label10, label %label14
# %op11 = phi i32 [ 0, %label_entry ], [ %op20, %label19 ]
	add.d $t3, $t3, $zero
	bnez $t6, .transpose_label10
	b .transpose_label14
.transpose_label22:
# %op23 = add i32 %op17, 1
	addi.w $t7, $zero, 1
	add.w $t7, $t4, $t7
	st.w $t7, $fp, -136
# br label %label29
# %op30 = phi i32 [ %op23, %label22 ], [ %op66, %label65 ]
	ld.w $t7, $fp, -136
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -156
	b .transpose_label29
.transpose_label24:
# %op25 = load i32, i32* %op5
	ld.w $t6, $t1, 0
# %op26 = mul i32 %op11, %op25
	mul.w $t6, $t3, $t6
# %op27 = add i32 %op26, %op17
	add.w $t6, $t6, $t4
# %op28 = icmp sge i32 %op27, 0
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t6
	xor $t8, $t8, $t6
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	or $t5, $t7, $t8
# br i1 %op28, label %label33, label %label37
	bnez $t5, .transpose_label33
	b .transpose_label37
.transpose_label29:
# %op30 = phi i32 [ %op23, %label22 ], [ %op66, %label65 ]
# %op31 = load i32, i32* %op5
	ld.w $t6, $t1, 0
# %op32 = icmp slt i32 %op30, %op31
	ld.w $t8, $fp, -156
	slt $t6, $t8, $t6
# br i1 %op32, label %label16, label %label19
# %op17 = phi i32 [ 0, %label10 ], [ %op30, %label29 ]
	ld.w $t7, $fp, -156
	add.d $t4, $t7, $zero
	bnez $t6, .transpose_label16
	b .transpose_label19
.transpose_label33:
# %op34 = load i32*, i32** %op4
	ld.d $t5, $t0, 0
# %op35 = getelementptr i32, i32* %op34, i32 %op27
	addi.w $t7, $zero, 4
	mul.w $t7, $t6, $t7
	add.d $t5, $t5, $t7
# %op36 = load i32, i32* %op35
	ld.w $t7, $t5, 0
	st.w $t7, $fp, -188
# br label %label38
	b .transpose_label38
.transpose_label37:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label38
	b .transpose_label38
.transpose_label38:
# %op39 = mul i32 %op17, %op8
	mul.w $t6, $t4, $t2
# %op40 = add i32 %op39, %op11
	add.w $t6, $t6, $t3
# %op41 = icmp sge i32 %op40, 0
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t6
	xor $t8, $t8, $t6
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	or $t5, $t7, $t8
# br i1 %op41, label %label42, label %label45
	bnez $t5, .transpose_label42
	b .transpose_label45
.transpose_label42:
# %op43 = load i32*, i32** %op4
	ld.d $t5, $t0, 0
# %op44 = getelementptr i32, i32* %op43, i32 %op40
	addi.w $t7, $zero, 4
	mul.w $t7, $t6, $t7
	add.d $t7, $t5, $t7
	st.d $t7, $fp, -216
# br label %label46
	b .transpose_label46
.transpose_label45:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label46
	b .transpose_label46
.transpose_label46:
# %op47 = load i32, i32* %op5
	ld.w $t6, $t1, 0
# %op48 = mul i32 %op11, %op47
	mul.w $t6, $t3, $t6
# %op49 = add i32 %op48, %op17
	add.w $t6, $t6, $t4
# %op50 = icmp sge i32 %op49, 0
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t6
	xor $t8, $t8, $t6
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	or $t5, $t7, $t8
# br i1 %op50, label %label51, label %label55
	bnez $t5, .transpose_label51
	b .transpose_label55
.transpose_label51:
# %op52 = load i32*, i32** %op4
	ld.d $t5, $t0, 0
# %op53 = getelementptr i32, i32* %op52, i32 %op49
	addi.w $t7, $zero, 4
	mul.w $t7, $t6, $t7
	add.d $t5, $t5, $t7
# %op54 = load i32, i32* %op53
	ld.w $t7, $t5, 0
	st.w $t7, $fp, -252
# br label %label56
	b .transpose_label56
.transpose_label55:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label56
	b .transpose_label56
.transpose_label56:
# store i32 %op54, i32* %op44
	ld.w $t7, $fp, -252
	ld.d $t8, $fp, -216
	st.w $t7, $t8, 0
# %op57 = load i32, i32* %op5
	ld.w $t6, $t1, 0
# %op58 = mul i32 %op11, %op57
	mul.w $t6, $t3, $t6
# %op59 = add i32 %op58, %op17
	add.w $t6, $t6, $t4
# %op60 = icmp sge i32 %op59, 0
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t6
	xor $t8, $t8, $t6
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	or $t5, $t7, $t8
# br i1 %op60, label %label61, label %label64
	bnez $t5, .transpose_label61
	b .transpose_label64
.transpose_label61:
# %op62 = load i32*, i32** %op4
	ld.d $t5, $t0, 0
# %op63 = getelementptr i32, i32* %op62, i32 %op59
	addi.w $t7, $zero, 4
	mul.w $t7, $t6, $t7
	add.d $t5, $t5, $t7
# br label %label65
	b .transpose_label65
.transpose_label64:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label65
	b .transpose_label65
.transpose_label65:
# store i32 %op36, i32* %op63
	ld.w $t7, $fp, -188
	st.w $t7, $t5, 0
# %op66 = add i32 %op17, 1
	addi.w $t8, $zero, 1
	add.w $t4, $t4, $t8
# br label %label29
# %op30 = phi i32 [ %op23, %label22 ], [ %op66, %label65 ]
	add.d $t7, $t4, $zero
	st.w $t7, $fp, -156
	b .transpose_label29
transpose_exit:
	addi.d $sp, $sp, 304
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -192
.main_label_entry:
# %op0 = call i32 @input()
	bl input
	st.w $a0, $fp, -20
# %op1 = call i32 @input()
	bl input
	add.w $t0, $a0, $zero
# store i32 %op1, i32* @len
	la.local $t7, len
	st.w $t0, $t7, 0
# call void @readarray()
	bl readarray
# %op2 = icmp slt i32 0, %op0
	addi.w $t7, $zero, 0
	ld.w $t8, $fp, -20
	slt $t0, $t7, $t8
# br i1 %op2, label %label3, label %label6
	st.b $t0, $fp, -25
# %op4 = phi i32 [ 0, %label_entry ], [ %op13, %label12 ]
	addi.w $t7, $zero, 0
	add.d $t0, $t7, $zero
	ld.b $t7, $fp, -25
	bnez $t7, .main_label3
	b .main_label6
.main_label3:
# %op4 = phi i32 [ 0, %label_entry ], [ %op13, %label12 ]
# %op5 = icmp sge i32 %op4, 0
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t0
	xor $t8, $t8, $t0
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	or $t1, $t7, $t8
# br i1 %op5, label %label9, label %label11
	bnez $t1, .main_label9
	b .main_label11
.main_label6:
# %op7 = load i32, i32* @len
	la.local $t8, len
	ld.w $t0, $t8, 0
# %op8 = icmp slt i32 0, %op7
	addi.w $t8, $zero, 0
	slt $t0, $t8, $t0
# br i1 %op8, label %label15, label %label19
# %op16 = phi i32 [ 0, %label6 ], [ %op28, %label26 ]
	addi.w $t7, $zero, 0
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -68
	bnez $t0, .main_label15
	b .main_label19
.main_label9:
# %op10 = getelementptr [20000000 x i32], [20000000 x i32]* @matrix, i32 0, i32 %op4
	la.local $t8, matrix
	addi.w $t7, $zero, 4
	mul.w $t7, $t0, $t7
	add.d $t1, $t8, $t7
# br label %label12
	b .main_label12
.main_label11:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label12
	b .main_label12
.main_label12:
# store i32 %op4, i32* %op10
	st.w $t0, $t1, 0
# %op13 = add i32 %op4, 1
	addi.w $t8, $zero, 1
	add.w $t0, $t0, $t8
# %op14 = icmp slt i32 %op13, %op0
	ld.w $t8, $fp, -20
	slt $t2, $t0, $t8
# br i1 %op14, label %label3, label %label6
# %op4 = phi i32 [ 0, %label_entry ], [ %op13, %label12 ]
	add.d $t0, $t0, $zero
	bnez $t2, .main_label3
	b .main_label6
.main_label15:
# %op16 = phi i32 [ 0, %label6 ], [ %op28, %label26 ]
# %op17 = getelementptr [20000000 x i32], [20000000 x i32]* @matrix, i32 0, i32 0
	addi.w $t8, $zero, 0
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	la.local $t8, matrix
	add.d $t1, $t8, $t7
# %op18 = icmp sge i32 %op16, 0
	ld.w $t7, $fp, -68
	addi.w $t8, $zero, 0
	slt $t2, $t8, $t7
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	or $t2, $t2, $t8
# br i1 %op18, label %label22, label %label25
	bnez $t2, .main_label22
	b .main_label25
.main_label19:
# %op20 = load i32, i32* @len
	la.local $t8, len
	ld.w $t0, $t8, 0
# %op21 = icmp slt i32 0, %op20
	addi.w $t8, $zero, 0
	slt $t0, $t8, $t0
# br i1 %op21, label %label31, label %label35
	st.b $t0, $fp, -89
# %op33 = phi i32 [ 0, %label19 ], [ %op46, %label42 ]
	addi.w $t7, $zero, 0
	add.d $t1, $t7, $zero
# %op32 = phi i32 [ 0, %label19 ], [ %op45, %label42 ]
	addi.w $t7, $zero, 0
	add.d $t0, $t7, $zero
	ld.b $t7, $fp, -89
	bnez $t7, .main_label31
	b .main_label35
.main_label22:
# %op23 = getelementptr [100000 x i32], [100000 x i32]* @ad, i32 0, i32 %op16
	ld.w $t8, $fp, -68
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	la.local $t8, ad
	add.d $t2, $t8, $t7
# %op24 = load i32, i32* %op23
	ld.w $t7, $t2, 0
	st.w $t7, $fp, -108
# br label %label26
	b .main_label26
.main_label25:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label26
	b .main_label26
.main_label26:
# %op27 = call i32 @transpose(i32 %op0, i32* %op17, i32 %op24)
	ld.w $a0, $fp, -20
	add.d $a1, $t1, $zero
	ld.w $a2, $fp, -108
	bl transpose
	add.w $t0, $a0, $zero
# %op28 = add i32 %op16, 1
	ld.w $t7, $fp, -68
	addi.w $t8, $zero, 1
	add.w $t0, $t7, $t8
# %op29 = load i32, i32* @len
	la.local $t8, len
	ld.w $t1, $t8, 0
# %op30 = icmp slt i32 %op28, %op29
	slt $t1, $t0, $t1
# br i1 %op30, label %label15, label %label19
# %op16 = phi i32 [ 0, %label6 ], [ %op28, %label26 ]
	add.d $t7, $t0, $zero
	st.w $t7, $fp, -68
	bnez $t1, .main_label15
	b .main_label19
.main_label31:
# %op32 = phi i32 [ 0, %label19 ], [ %op45, %label42 ]
# %op33 = phi i32 [ 0, %label19 ], [ %op46, %label42 ]
# %op34 = icmp sge i32 %op33, 0
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t1
	xor $t8, $t8, $t1
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	or $t2, $t7, $t8
# br i1 %op34, label %label38, label %label41
	bnez $t2, .main_label38
	b .main_label41
.main_label35:
# %op36 = phi i32 [ 0, %label19 ], [ %op45, %label42 ]
# %op37 = icmp slt i32 %op36, 0
	addi.w $t8, $zero, 0
	slt $t1, $t0, $t8
# br i1 %op37, label %label49, label %label51
	bnez $t1, .main_label49
# %op52 = phi i32 [ %op36, %label35 ], [ %op50, %label49 ]
	add.d $t0, $t0, $zero
	b .main_label51
.main_label38:
# %op39 = getelementptr [20000000 x i32], [20000000 x i32]* @matrix, i32 0, i32 %op33
	la.local $t8, matrix
	addi.w $t7, $zero, 4
	mul.w $t7, $t1, $t7
	add.d $t2, $t8, $t7
# %op40 = load i32, i32* %op39
	ld.w $t2, $t2, 0
# br label %label42
	b .main_label42
.main_label41:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label42
	b .main_label42
.main_label42:
# %op43 = mul i32 %op33, %op33
	mul.w $t3, $t1, $t1
# %op44 = mul i32 %op43, %op40
	mul.w $t3, $t3, $t2
# %op45 = add i32 %op32, %op44
	add.w $t0, $t0, $t3
# %op46 = add i32 %op33, 1
	addi.w $t8, $zero, 1
	add.w $t1, $t1, $t8
# %op47 = load i32, i32* @len
	la.local $t8, len
	ld.w $t3, $t8, 0
# %op48 = icmp slt i32 %op46, %op47
	slt $t3, $t1, $t3
# br i1 %op48, label %label31, label %label35
# %op32 = phi i32 [ 0, %label19 ], [ %op45, %label42 ]
	add.d $t0, $t0, $zero
# %op33 = phi i32 [ 0, %label19 ], [ %op46, %label42 ]
	add.d $t1, $t1, $zero
	bnez $t3, .main_label31
	b .main_label35
.main_label49:
# %op50 = sub i32 0, %op36
	addi.w $t7, $zero, 0
	sub.w $t1, $t7, $t0
# br label %label51
# %op52 = phi i32 [ %op36, %label35 ], [ %op50, %label49 ]
	add.d $t0, $t1, $zero
	b .main_label51
.main_label51:
# %op52 = phi i32 [ %op36, %label35 ], [ %op50, %label49 ]
# call void @output(i32 %op52)
	add.d $a0, $t0, $zero
	bl output
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
main_exit:
	addi.d $sp, $sp, 192
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
