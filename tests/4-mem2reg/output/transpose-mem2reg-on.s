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
	st.w $a2, $fp, -36
.transpose_label_entry:
# %op3 = alloca i32
	addi.d $t8, $fp, -52
	addi.d $t7, $fp, -48
	st.d $t8, $t7, 0
# store i32 %arg0, i32* %op3
	ld.d $t7, $fp, -48
	st.w $t0, $t7, 0
# %op4 = alloca i32*
	addi.d $t8, $fp, -72
	addi.d $t7, $fp, -64
	st.d $t8, $t7, 0
# store i32* %arg1, i32** %op4
	ld.d $t7, $fp, -64
	st.d $t1, $t7, 0
# %op5 = alloca i32
	addi.d $t8, $fp, -84
	addi.d $t7, $fp, -80
	st.d $t8, $t7, 0
# store i32 %arg2, i32* %op5
	ld.w $t7, $fp, -36
	ld.d $t8, $fp, -80
	st.w $t7, $t8, 0
# %op6 = load i32, i32* %op5
	ld.d $t8, $fp, -80
	ld.w $t1, $t8, 0
# %op7 = load i32, i32* %op3
	ld.d $t8, $fp, -48
	ld.w $t0, $t8, 0
# %op8 = sdiv i32 %op7, %op6
	div.w $t7, $t0, $t1
	st.w $t7, $fp, -96
# %op9 = icmp slt i32 0, %op8
	addi.w $t7, $zero, 0
	ld.w $t8, $fp, -96
	slt $t1, $t7, $t8
# br i1 %op9, label %label10, label %label14
# %op11 = phi i32 [ 0, %label_entry ], [ %op20, %label19 ]
	addi.w $t7, $zero, 0
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -104
	bnez $t1, .transpose_label10
	b .transpose_label14
.transpose_label10:
# %op11 = phi i32 [ 0, %label_entry ], [ %op20, %label19 ]
# %op12 = load i32, i32* %op5
	ld.d $t8, $fp, -80
	ld.w $t0, $t8, 0
# %op13 = icmp slt i32 0, %op12
	addi.w $t8, $zero, 0
	slt $t0, $t8, $t0
# br i1 %op13, label %label16, label %label19
# %op17 = phi i32 [ 0, %label10 ], [ %op30, %label29 ]
	addi.w $t7, $zero, 0
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -120
	bnez $t0, .transpose_label16
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
	ld.w $t7, $fp, -104
	ld.w $t8, $fp, -120
	slt $t1, $t7, $t8
# br i1 %op18, label %label22, label %label24
	bnez $t1, .transpose_label22
	b .transpose_label24
.transpose_label19:
# %op20 = add i32 %op11, 1
	ld.w $t7, $fp, -104
	addi.w $t8, $zero, 1
	add.w $t7, $t7, $t8
	st.w $t7, $fp, -128
# %op21 = icmp slt i32 %op20, %op8
	ld.w $t7, $fp, -128
	ld.w $t8, $fp, -96
	slt $t1, $t7, $t8
# br i1 %op21, label %label10, label %label14
# %op11 = phi i32 [ 0, %label_entry ], [ %op20, %label19 ]
	ld.w $t7, $fp, -128
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -104
	bnez $t1, .transpose_label10
	b .transpose_label14
.transpose_label22:
# %op23 = add i32 %op17, 1
	ld.w $t7, $fp, -120
	addi.w $t8, $zero, 1
	add.w $t7, $t7, $t8
	st.w $t7, $fp, -136
# br label %label29
# %op30 = phi i32 [ %op23, %label22 ], [ %op66, %label65 ]
	ld.w $t7, $fp, -136
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -156
	b .transpose_label29
.transpose_label24:
# %op25 = load i32, i32* %op5
	ld.d $t8, $fp, -80
	ld.w $t1, $t8, 0
# %op26 = mul i32 %op11, %op25
	ld.w $t7, $fp, -104
	mul.w $t1, $t7, $t1
# %op27 = add i32 %op26, %op17
	ld.w $t8, $fp, -120
	add.w $t1, $t1, $t8
# %op28 = icmp sge i32 %op27, 0
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t1
	xor $t8, $t8, $t1
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	or $t0, $t7, $t8
# br i1 %op28, label %label33, label %label37
	bnez $t0, .transpose_label33
	b .transpose_label37
.transpose_label29:
# %op30 = phi i32 [ %op23, %label22 ], [ %op66, %label65 ]
# %op31 = load i32, i32* %op5
	ld.d $t8, $fp, -80
	ld.w $t1, $t8, 0
# %op32 = icmp slt i32 %op30, %op31
	ld.w $t8, $fp, -156
	slt $t1, $t8, $t1
# br i1 %op32, label %label16, label %label19
# %op17 = phi i32 [ 0, %label10 ], [ %op30, %label29 ]
	ld.w $t7, $fp, -156
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -120
	bnez $t1, .transpose_label16
	b .transpose_label19
.transpose_label33:
# %op34 = load i32*, i32** %op4
	ld.d $t8, $fp, -64
	ld.d $t0, $t8, 0
# %op35 = getelementptr i32, i32* %op34, i32 %op27
	addi.w $t7, $zero, 4
	mul.w $t7, $t1, $t7
	add.d $t0, $t0, $t7
# %op36 = load i32, i32* %op35
	ld.w $t7, $t0, 0
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
	ld.w $t7, $fp, -120
	ld.w $t8, $fp, -96
	mul.w $t7, $t7, $t8
	st.w $t7, $fp, -192
# %op40 = add i32 %op39, %op11
	ld.w $t7, $fp, -192
	ld.w $t8, $fp, -104
	add.w $t7, $t7, $t8
	st.w $t7, $fp, -196
# %op41 = icmp sge i32 %op40, 0
	ld.w $t7, $fp, -196
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t7
	st.b $t7, $fp, -197
	ld.w $t7, $fp, -196
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	ld.b $t7, $fp, -197
	or $t7, $t7, $t8
	st.b $t7, $fp, -197
# br i1 %op41, label %label42, label %label45
	ld.b $t7, $fp, -197
	bnez $t7, .transpose_label42
	b .transpose_label45
.transpose_label42:
# %op43 = load i32*, i32** %op4
	ld.d $t8, $fp, -64
	ld.d $t7, $t8, 0
	st.d $t7, $fp, -208
# %op44 = getelementptr i32, i32* %op43, i32 %op40
	ld.w $t8, $fp, -196
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	ld.d $t8, $fp, -208
	add.d $t7, $t8, $t7
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
	ld.d $t8, $fp, -80
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -220
# %op48 = mul i32 %op11, %op47
	ld.w $t7, $fp, -104
	ld.w $t8, $fp, -220
	mul.w $t7, $t7, $t8
	st.w $t7, $fp, -224
# %op49 = add i32 %op48, %op17
	ld.w $t7, $fp, -224
	ld.w $t8, $fp, -120
	add.w $t7, $t7, $t8
	st.w $t7, $fp, -228
# %op50 = icmp sge i32 %op49, 0
	ld.w $t7, $fp, -228
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t7
	st.b $t7, $fp, -229
	ld.w $t7, $fp, -228
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	ld.b $t7, $fp, -229
	or $t7, $t7, $t8
	st.b $t7, $fp, -229
# br i1 %op50, label %label51, label %label55
	ld.b $t7, $fp, -229
	bnez $t7, .transpose_label51
	b .transpose_label55
.transpose_label51:
# %op52 = load i32*, i32** %op4
	ld.d $t8, $fp, -64
	ld.d $t7, $t8, 0
	st.d $t7, $fp, -240
# %op53 = getelementptr i32, i32* %op52, i32 %op49
	ld.w $t8, $fp, -228
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	ld.d $t8, $fp, -240
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -248
# %op54 = load i32, i32* %op53
	ld.d $t8, $fp, -248
	ld.w $t7, $t8, 0
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
	ld.d $t8, $fp, -80
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -256
# %op58 = mul i32 %op11, %op57
	ld.w $t7, $fp, -104
	ld.w $t8, $fp, -256
	mul.w $t7, $t7, $t8
	st.w $t7, $fp, -260
# %op59 = add i32 %op58, %op17
	ld.w $t7, $fp, -260
	ld.w $t8, $fp, -120
	add.w $t7, $t7, $t8
	st.w $t7, $fp, -264
# %op60 = icmp sge i32 %op59, 0
	ld.w $t7, $fp, -264
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t7
	st.b $t7, $fp, -265
	ld.w $t7, $fp, -264
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	ld.b $t7, $fp, -265
	or $t7, $t7, $t8
	st.b $t7, $fp, -265
# br i1 %op60, label %label61, label %label64
	ld.b $t7, $fp, -265
	bnez $t7, .transpose_label61
	b .transpose_label64
.transpose_label61:
# %op62 = load i32*, i32** %op4
	ld.d $t8, $fp, -64
	ld.d $t7, $t8, 0
	st.d $t7, $fp, -280
# %op63 = getelementptr i32, i32* %op62, i32 %op59
	ld.w $t8, $fp, -264
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	ld.d $t8, $fp, -280
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -288
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
	ld.d $t8, $fp, -288
	st.w $t7, $t8, 0
# %op66 = add i32 %op17, 1
	ld.w $t7, $fp, -120
	addi.w $t8, $zero, 1
	add.w $t0, $t7, $t8
# br label %label29
# %op30 = phi i32 [ %op23, %label22 ], [ %op66, %label65 ]
	add.d $t7, $t0, $zero
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
# %op4 = phi i32 [ 0, %label_entry ], [ %op13, %label12 ]
	addi.w $t7, $zero, 0
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -32
	bnez $t0, .main_label3
	b .main_label6
.main_label3:
# %op4 = phi i32 [ 0, %label_entry ], [ %op13, %label12 ]
# %op5 = icmp sge i32 %op4, 0
	ld.w $t7, $fp, -32
	addi.w $t8, $zero, 0
	slt $t1, $t8, $t7
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	or $t1, $t1, $t8
# br i1 %op5, label %label9, label %label11
	bnez $t1, .main_label9
	b .main_label11
.main_label6:
# %op7 = load i32, i32* @len
	la.local $t8, len
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -40
# %op8 = icmp slt i32 0, %op7
	addi.w $t7, $zero, 0
	ld.w $t8, $fp, -40
	slt $t7, $t7, $t8
	st.b $t7, $fp, -41
# br i1 %op8, label %label15, label %label19
# %op16 = phi i32 [ 0, %label6 ], [ %op28, %label26 ]
	addi.w $t7, $zero, 0
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -68
	ld.b $t7, $fp, -41
	bnez $t7, .main_label15
	b .main_label19
.main_label9:
# %op10 = getelementptr [20000000 x i32], [20000000 x i32]* @matrix, i32 0, i32 %op4
	ld.w $t8, $fp, -32
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	la.local $t8, matrix
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -56
# br label %label12
	b .main_label12
.main_label11:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label12
	b .main_label12
.main_label12:
# store i32 %op4, i32* %op10
	ld.w $t7, $fp, -32
	ld.d $t8, $fp, -56
	st.w $t7, $t8, 0
# %op13 = add i32 %op4, 1
	ld.w $t7, $fp, -32
	addi.w $t8, $zero, 1
	add.w $t7, $t7, $t8
	st.w $t7, $fp, -60
# %op14 = icmp slt i32 %op13, %op0
	ld.w $t7, $fp, -60
	ld.w $t8, $fp, -20
	slt $t7, $t7, $t8
	st.b $t7, $fp, -61
# br i1 %op14, label %label3, label %label6
# %op4 = phi i32 [ 0, %label_entry ], [ %op13, %label12 ]
	ld.w $t7, $fp, -60
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -32
	ld.b $t7, $fp, -61
	bnez $t7, .main_label3
	b .main_label6
.main_label15:
# %op16 = phi i32 [ 0, %label6 ], [ %op28, %label26 ]
# %op17 = getelementptr [20000000 x i32], [20000000 x i32]* @matrix, i32 0, i32 0
	addi.w $t8, $zero, 0
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	la.local $t8, matrix
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -80
# %op18 = icmp sge i32 %op16, 0
	ld.w $t7, $fp, -68
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t7
	st.b $t7, $fp, -81
	ld.w $t7, $fp, -68
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	ld.b $t7, $fp, -81
	or $t7, $t7, $t8
	st.b $t7, $fp, -81
# br i1 %op18, label %label22, label %label25
	ld.b $t7, $fp, -81
	bnez $t7, .main_label22
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
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -132
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
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -104
# %op24 = load i32, i32* %op23
	ld.d $t8, $fp, -104
	ld.w $t7, $t8, 0
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
	ld.d $a1, $fp, -80
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
	ld.w $t7, $fp, -132
	addi.w $t8, $zero, 0
	slt $t1, $t8, $t7
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	or $t1, $t1, $t8
# br i1 %op34, label %label38, label %label41
	bnez $t1, .main_label38
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
	ld.w $t8, $fp, -132
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	la.local $t8, matrix
	add.d $t1, $t8, $t7
# %op40 = load i32, i32* %op39
	ld.w $t7, $t1, 0
	st.w $t7, $fp, -156
# br label %label42
	b .main_label42
.main_label41:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label42
	b .main_label42
.main_label42:
# %op43 = mul i32 %op33, %op33
	ld.w $t7, $fp, -132
	ld.w $t8, $fp, -132
	mul.w $t1, $t7, $t8
# %op44 = mul i32 %op43, %op40
	ld.w $t8, $fp, -156
	mul.w $t1, $t1, $t8
# %op45 = add i32 %op32, %op44
	add.w $t7, $t0, $t1
	st.w $t7, $fp, -168
# %op46 = add i32 %op33, 1
	ld.w $t7, $fp, -132
	addi.w $t8, $zero, 1
	add.w $t1, $t7, $t8
# %op47 = load i32, i32* @len
	la.local $t8, len
	ld.w $t0, $t8, 0
# %op48 = icmp slt i32 %op46, %op47
	slt $t0, $t1, $t0
# br i1 %op48, label %label31, label %label35
	st.b $t0, $fp, -177
# %op32 = phi i32 [ 0, %label19 ], [ %op45, %label42 ]
	ld.w $t7, $fp, -168
	add.d $t0, $t7, $zero
# %op33 = phi i32 [ 0, %label19 ], [ %op46, %label42 ]
	add.d $t7, $t1, $zero
	st.w $t7, $fp, -132
	ld.b $t7, $fp, -177
	bnez $t7, .main_label31
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
