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
	addi.d $sp, $sp, -80
.readarray_label_entry:
# %op0 = alloca i32
	addi.d $t8, $fp, -28
	addi.d $t7, $fp, -24
	st.d $t8, $t7, 0
# store i32 0, i32* %op0
	addi.w $t7, $zero, 0
	ld.d $t8, $fp, -24
	st.w $t7, $t8, 0
# %op1 = load i32, i32* %op0
	ld.d $t8, $fp, -24
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -32
# %op2 = load i32, i32* @len
	la.local $t8, len
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -36
# %op3 = icmp slt i32 %op1, %op2
	ld.w $t7, $fp, -32
	ld.w $t8, $fp, -36
	slt $t7, $t7, $t8
	st.b $t7, $fp, -37
# br i1 %op3, label %label4, label %label7
	ld.b $t7, $fp, -37
	bnez $t7, .readarray_label4
	b .readarray_label7
.readarray_label4:
# %op5 = load i32, i32* %op0
	ld.d $t8, $fp, -24
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -44
# %op6 = icmp sge i32 %op5, 0
	ld.w $t7, $fp, -44
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t7
	st.b $t7, $fp, -45
	ld.w $t7, $fp, -44
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	ld.b $t7, $fp, -45
	or $t7, $t7, $t8
	st.b $t7, $fp, -45
# br i1 %op6, label %label8, label %label10
	ld.b $t7, $fp, -45
	bnez $t7, .readarray_label8
	b .readarray_label10
.readarray_label7:
# ret void
	addi.w $a0, $zero, 0
	b readarray_exit
.readarray_label8:
# %op9 = getelementptr [100000 x i32], [100000 x i32]* @ad, i32 0, i32 %op5
	ld.w $t8, $fp, -44
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	la.local $t8, ad
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -56
# br label %label11
	b .readarray_label11
.readarray_label10:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label11
	b .readarray_label11
.readarray_label11:
# %op12 = call i32 @input()
	bl input
	st.w $a0, $fp, -60
# store i32 %op12, i32* %op9
	ld.w $t7, $fp, -60
	ld.d $t8, $fp, -56
	st.w $t7, $t8, 0
# %op13 = load i32, i32* %op0
	ld.d $t8, $fp, -24
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -64
# %op14 = add i32 %op13, 1
	ld.w $t7, $fp, -64
	addi.w $t8, $zero, 1
	add.w $t7, $t7, $t8
	st.w $t7, $fp, -68
# store i32 %op14, i32* %op0
	ld.w $t7, $fp, -68
	ld.d $t8, $fp, -24
	st.w $t7, $t8, 0
# %op15 = load i32, i32* %op0
	ld.d $t8, $fp, -24
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -72
# %op16 = load i32, i32* @len
	la.local $t8, len
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -76
# %op17 = icmp slt i32 %op15, %op16
	ld.w $t7, $fp, -72
	ld.w $t8, $fp, -76
	slt $t7, $t7, $t8
	st.b $t7, $fp, -77
# br i1 %op17, label %label4, label %label7
	ld.b $t7, $fp, -77
	bnez $t7, .readarray_label4
	b .readarray_label7
readarray_exit:
	addi.d $sp, $sp, 80
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl transpose
	.type transpose, @function
transpose:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -432
	st.w $a0, $fp, -20
	st.d $a1, $fp, -32
	st.w $a2, $fp, -36
.transpose_label_entry:
# %op3 = alloca i32
	addi.d $t8, $fp, -52
	addi.d $t7, $fp, -48
	st.d $t8, $t7, 0
# store i32 %arg0, i32* %op3
	ld.w $t7, $fp, -20
	ld.d $t8, $fp, -48
	st.w $t7, $t8, 0
# %op4 = alloca i32*
	addi.d $t8, $fp, -72
	addi.d $t7, $fp, -64
	st.d $t8, $t7, 0
# store i32* %arg1, i32** %op4
	ld.d $t7, $fp, -32
	ld.d $t8, $fp, -64
	st.d $t7, $t8, 0
# %op5 = alloca i32
	addi.d $t8, $fp, -84
	addi.d $t7, $fp, -80
	st.d $t8, $t7, 0
# store i32 %arg2, i32* %op5
	ld.w $t7, $fp, -36
	ld.d $t8, $fp, -80
	st.w $t7, $t8, 0
# %op6 = alloca i32
	addi.d $t8, $fp, -100
	addi.d $t7, $fp, -96
	st.d $t8, $t7, 0
# %op7 = alloca i32
	addi.d $t8, $fp, -116
	addi.d $t7, $fp, -112
	st.d $t8, $t7, 0
# %op8 = alloca i32
	addi.d $t8, $fp, -132
	addi.d $t7, $fp, -128
	st.d $t8, $t7, 0
# %op9 = alloca i32
	addi.d $t8, $fp, -148
	addi.d $t7, $fp, -144
	st.d $t8, $t7, 0
# %op10 = load i32, i32* %op5
	ld.d $t8, $fp, -80
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -152
# %op11 = load i32, i32* %op3
	ld.d $t8, $fp, -48
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -156
# %op12 = sdiv i32 %op11, %op10
	ld.w $t7, $fp, -156
	ld.w $t8, $fp, -152
	div.w $t7, $t7, $t8
	st.w $t7, $fp, -160
# store i32 %op12, i32* %op6
	ld.w $t7, $fp, -160
	ld.d $t8, $fp, -96
	st.w $t7, $t8, 0
# store i32 0, i32* %op7
	addi.w $t7, $zero, 0
	ld.d $t8, $fp, -112
	st.w $t7, $t8, 0
# store i32 0, i32* %op8
	addi.w $t7, $zero, 0
	ld.d $t8, $fp, -128
	st.w $t7, $t8, 0
# %op13 = load i32, i32* %op7
	ld.d $t8, $fp, -112
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -164
# %op14 = load i32, i32* %op6
	ld.d $t8, $fp, -96
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -168
# %op15 = icmp slt i32 %op13, %op14
	ld.w $t7, $fp, -164
	ld.w $t8, $fp, -168
	slt $t7, $t7, $t8
	st.b $t7, $fp, -169
# br i1 %op15, label %label16, label %label20
	ld.b $t7, $fp, -169
	bnez $t7, .transpose_label16
	b .transpose_label20
.transpose_label16:
# store i32 0, i32* %op8
	addi.w $t7, $zero, 0
	ld.d $t8, $fp, -128
	st.w $t7, $t8, 0
# %op17 = load i32, i32* %op8
	ld.d $t8, $fp, -128
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -176
# %op18 = load i32, i32* %op5
	ld.d $t8, $fp, -80
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -180
# %op19 = icmp slt i32 %op17, %op18
	ld.w $t7, $fp, -176
	ld.w $t8, $fp, -180
	slt $t7, $t7, $t8
	st.b $t7, $fp, -181
# br i1 %op19, label %label22, label %label26
	ld.b $t7, $fp, -181
	bnez $t7, .transpose_label22
	b .transpose_label26
.transpose_label20:
# %op21 = sub i32 0, 1
	addi.w $t7, $zero, 0
	addi.w $t8, $zero, 1
	sub.w $t7, $t7, $t8
	st.w $t7, $fp, -188
# ret i32 %op21
	ld.w $a0, $fp, -188
	b transpose_exit
.transpose_label22:
# %op23 = load i32, i32* %op7
	ld.d $t8, $fp, -112
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -192
# %op24 = load i32, i32* %op8
	ld.d $t8, $fp, -128
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -196
# %op25 = icmp slt i32 %op23, %op24
	ld.w $t7, $fp, -192
	ld.w $t8, $fp, -196
	slt $t7, $t7, $t8
	st.b $t7, $fp, -197
# br i1 %op25, label %label32, label %label35
	ld.b $t7, $fp, -197
	bnez $t7, .transpose_label32
	b .transpose_label35
.transpose_label26:
# %op27 = load i32, i32* %op7
	ld.d $t8, $fp, -112
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -204
# %op28 = add i32 %op27, 1
	ld.w $t7, $fp, -204
	addi.w $t8, $zero, 1
	add.w $t7, $t7, $t8
	st.w $t7, $fp, -208
# store i32 %op28, i32* %op7
	ld.w $t7, $fp, -208
	ld.d $t8, $fp, -112
	st.w $t7, $t8, 0
# %op29 = load i32, i32* %op7
	ld.d $t8, $fp, -112
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -212
# %op30 = load i32, i32* %op6
	ld.d $t8, $fp, -96
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -216
# %op31 = icmp slt i32 %op29, %op30
	ld.w $t7, $fp, -212
	ld.w $t8, $fp, -216
	slt $t7, $t7, $t8
	st.b $t7, $fp, -217
# br i1 %op31, label %label16, label %label20
	ld.b $t7, $fp, -217
	bnez $t7, .transpose_label16
	b .transpose_label20
.transpose_label32:
# %op33 = load i32, i32* %op8
	ld.d $t8, $fp, -128
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -224
# %op34 = add i32 %op33, 1
	ld.w $t7, $fp, -224
	addi.w $t8, $zero, 1
	add.w $t7, $t7, $t8
	st.w $t7, $fp, -228
# store i32 %op34, i32* %op8
	ld.w $t7, $fp, -228
	ld.d $t8, $fp, -128
	st.w $t7, $t8, 0
# br label %label42
	b .transpose_label42
.transpose_label35:
# %op36 = load i32, i32* %op8
	ld.d $t8, $fp, -128
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -232
# %op37 = load i32, i32* %op5
	ld.d $t8, $fp, -80
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -236
# %op38 = load i32, i32* %op7
	ld.d $t8, $fp, -112
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -240
# %op39 = mul i32 %op38, %op37
	ld.w $t7, $fp, -240
	ld.w $t8, $fp, -236
	mul.w $t7, $t7, $t8
	st.w $t7, $fp, -244
# %op40 = add i32 %op39, %op36
	ld.w $t7, $fp, -244
	ld.w $t8, $fp, -232
	add.w $t7, $t7, $t8
	st.w $t7, $fp, -248
# %op41 = icmp sge i32 %op40, 0
	ld.w $t7, $fp, -248
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t7
	st.b $t7, $fp, -249
	ld.w $t7, $fp, -248
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	ld.b $t7, $fp, -249
	or $t7, $t7, $t8
	st.b $t7, $fp, -249
# br i1 %op41, label %label46, label %label50
	ld.b $t7, $fp, -249
	bnez $t7, .transpose_label46
	b .transpose_label50
.transpose_label42:
# %op43 = load i32, i32* %op8
	ld.d $t8, $fp, -128
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -256
# %op44 = load i32, i32* %op5
	ld.d $t8, $fp, -80
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -260
# %op45 = icmp slt i32 %op43, %op44
	ld.w $t7, $fp, -256
	ld.w $t8, $fp, -260
	slt $t7, $t7, $t8
	st.b $t7, $fp, -261
# br i1 %op45, label %label22, label %label26
	ld.b $t7, $fp, -261
	bnez $t7, .transpose_label22
	b .transpose_label26
.transpose_label46:
# %op47 = load i32*, i32** %op4
	ld.d $t8, $fp, -64
	ld.d $t7, $t8, 0
	st.d $t7, $fp, -272
# %op48 = getelementptr i32, i32* %op47, i32 %op40
	ld.w $t8, $fp, -248
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	ld.d $t8, $fp, -272
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -280
# %op49 = load i32, i32* %op48
	ld.d $t8, $fp, -280
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -284
# br label %label51
	b .transpose_label51
.transpose_label50:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label51
	b .transpose_label51
.transpose_label51:
# store i32 %op49, i32* %op9
	ld.w $t7, $fp, -284
	ld.d $t8, $fp, -144
	st.w $t7, $t8, 0
# %op52 = load i32, i32* %op7
	ld.d $t8, $fp, -112
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -288
# %op53 = load i32, i32* %op6
	ld.d $t8, $fp, -96
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -292
# %op54 = load i32, i32* %op8
	ld.d $t8, $fp, -128
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -296
# %op55 = mul i32 %op54, %op53
	ld.w $t7, $fp, -296
	ld.w $t8, $fp, -292
	mul.w $t7, $t7, $t8
	st.w $t7, $fp, -300
# %op56 = add i32 %op55, %op52
	ld.w $t7, $fp, -300
	ld.w $t8, $fp, -288
	add.w $t7, $t7, $t8
	st.w $t7, $fp, -304
# %op57 = icmp sge i32 %op56, 0
	ld.w $t7, $fp, -304
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t7
	st.b $t7, $fp, -305
	ld.w $t7, $fp, -304
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	ld.b $t7, $fp, -305
	or $t7, $t7, $t8
	st.b $t7, $fp, -305
# br i1 %op57, label %label58, label %label61
	ld.b $t7, $fp, -305
	bnez $t7, .transpose_label58
	b .transpose_label61
.transpose_label58:
# %op59 = load i32*, i32** %op4
	ld.d $t8, $fp, -64
	ld.d $t7, $t8, 0
	st.d $t7, $fp, -320
# %op60 = getelementptr i32, i32* %op59, i32 %op56
	ld.w $t8, $fp, -304
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	ld.d $t8, $fp, -320
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -328
# br label %label62
	b .transpose_label62
.transpose_label61:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label62
	b .transpose_label62
.transpose_label62:
# %op63 = load i32, i32* %op8
	ld.d $t8, $fp, -128
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -332
# %op64 = load i32, i32* %op5
	ld.d $t8, $fp, -80
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -336
# %op65 = load i32, i32* %op7
	ld.d $t8, $fp, -112
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -340
# %op66 = mul i32 %op65, %op64
	ld.w $t7, $fp, -340
	ld.w $t8, $fp, -336
	mul.w $t7, $t7, $t8
	st.w $t7, $fp, -344
# %op67 = add i32 %op66, %op63
	ld.w $t7, $fp, -344
	ld.w $t8, $fp, -332
	add.w $t7, $t7, $t8
	st.w $t7, $fp, -348
# %op68 = icmp sge i32 %op67, 0
	ld.w $t7, $fp, -348
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t7
	st.b $t7, $fp, -349
	ld.w $t7, $fp, -348
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	ld.b $t7, $fp, -349
	or $t7, $t7, $t8
	st.b $t7, $fp, -349
# br i1 %op68, label %label69, label %label73
	ld.b $t7, $fp, -349
	bnez $t7, .transpose_label69
	b .transpose_label73
.transpose_label69:
# %op70 = load i32*, i32** %op4
	ld.d $t8, $fp, -64
	ld.d $t7, $t8, 0
	st.d $t7, $fp, -360
# %op71 = getelementptr i32, i32* %op70, i32 %op67
	ld.w $t8, $fp, -348
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	ld.d $t8, $fp, -360
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -368
# %op72 = load i32, i32* %op71
	ld.d $t8, $fp, -368
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -372
# br label %label74
	b .transpose_label74
.transpose_label73:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label74
	b .transpose_label74
.transpose_label74:
# store i32 %op72, i32* %op60
	ld.w $t7, $fp, -372
	ld.d $t8, $fp, -328
	st.w $t7, $t8, 0
# %op75 = load i32, i32* %op8
	ld.d $t8, $fp, -128
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -376
# %op76 = load i32, i32* %op5
	ld.d $t8, $fp, -80
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -380
# %op77 = load i32, i32* %op7
	ld.d $t8, $fp, -112
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -384
# %op78 = mul i32 %op77, %op76
	ld.w $t7, $fp, -384
	ld.w $t8, $fp, -380
	mul.w $t7, $t7, $t8
	st.w $t7, $fp, -388
# %op79 = add i32 %op78, %op75
	ld.w $t7, $fp, -388
	ld.w $t8, $fp, -376
	add.w $t7, $t7, $t8
	st.w $t7, $fp, -392
# %op80 = icmp sge i32 %op79, 0
	ld.w $t7, $fp, -392
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t7
	st.b $t7, $fp, -393
	ld.w $t7, $fp, -392
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	ld.b $t7, $fp, -393
	or $t7, $t7, $t8
	st.b $t7, $fp, -393
# br i1 %op80, label %label81, label %label84
	ld.b $t7, $fp, -393
	bnez $t7, .transpose_label81
	b .transpose_label84
.transpose_label81:
# %op82 = load i32*, i32** %op4
	ld.d $t8, $fp, -64
	ld.d $t7, $t8, 0
	st.d $t7, $fp, -408
# %op83 = getelementptr i32, i32* %op82, i32 %op79
	ld.w $t8, $fp, -392
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	ld.d $t8, $fp, -408
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -416
# br label %label85
	b .transpose_label85
.transpose_label84:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label85
	b .transpose_label85
.transpose_label85:
# %op86 = load i32, i32* %op9
	ld.d $t8, $fp, -144
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -420
# store i32 %op86, i32* %op83
	ld.w $t7, $fp, -420
	ld.d $t8, $fp, -416
	st.w $t7, $t8, 0
# %op87 = load i32, i32* %op8
	ld.d $t8, $fp, -128
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -424
# %op88 = add i32 %op87, 1
	ld.w $t7, $fp, -424
	addi.w $t8, $zero, 1
	add.w $t7, $t7, $t8
	st.w $t7, $fp, -428
# store i32 %op88, i32* %op8
	ld.w $t7, $fp, -428
	ld.d $t8, $fp, -128
	st.w $t7, $t8, 0
# br label %label42
	b .transpose_label42
transpose_exit:
	addi.d $sp, $sp, 432
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -304
.main_label_entry:
# %op0 = alloca i32
	addi.d $t8, $fp, -28
	addi.d $t7, $fp, -24
	st.d $t8, $t7, 0
# %op1 = alloca i32
	addi.d $t8, $fp, -44
	addi.d $t7, $fp, -40
	st.d $t8, $t7, 0
# %op2 = alloca i32
	addi.d $t8, $fp, -60
	addi.d $t7, $fp, -56
	st.d $t8, $t7, 0
# %op3 = call i32 @input()
	bl input
	st.w $a0, $fp, -64
# store i32 %op3, i32* %op0
	ld.w $t7, $fp, -64
	ld.d $t8, $fp, -24
	st.w $t7, $t8, 0
# %op4 = call i32 @input()
	bl input
	st.w $a0, $fp, -68
# store i32 %op4, i32* @len
	ld.w $t7, $fp, -68
	la.local $t8, len
	st.w $t7, $t8, 0
# call void @readarray()
	bl readarray
# store i32 0, i32* %op1
	addi.w $t7, $zero, 0
	ld.d $t8, $fp, -40
	st.w $t7, $t8, 0
# %op5 = load i32, i32* %op1
	ld.d $t8, $fp, -40
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -72
# %op6 = load i32, i32* %op0
	ld.d $t8, $fp, -24
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -76
# %op7 = icmp slt i32 %op5, %op6
	ld.w $t7, $fp, -72
	ld.w $t8, $fp, -76
	slt $t7, $t7, $t8
	st.b $t7, $fp, -77
# br i1 %op7, label %label8, label %label11
	ld.b $t7, $fp, -77
	bnez $t7, .main_label8
	b .main_label11
.main_label8:
# %op9 = load i32, i32* %op1
	ld.d $t8, $fp, -40
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -84
# %op10 = icmp sge i32 %op9, 0
	ld.w $t7, $fp, -84
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t7
	st.b $t7, $fp, -85
	ld.w $t7, $fp, -84
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	ld.b $t7, $fp, -85
	or $t7, $t7, $t8
	st.b $t7, $fp, -85
# br i1 %op10, label %label15, label %label17
	ld.b $t7, $fp, -85
	bnez $t7, .main_label15
	b .main_label17
.main_label11:
# store i32 0, i32* %op1
	addi.w $t7, $zero, 0
	ld.d $t8, $fp, -40
	st.w $t7, $t8, 0
# %op12 = load i32, i32* %op1
	ld.d $t8, $fp, -40
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -92
# %op13 = load i32, i32* @len
	la.local $t8, len
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -96
# %op14 = icmp slt i32 %op12, %op13
	ld.w $t7, $fp, -92
	ld.w $t8, $fp, -96
	slt $t7, $t7, $t8
	st.b $t7, $fp, -97
# br i1 %op14, label %label25, label %label30
	ld.b $t7, $fp, -97
	bnez $t7, .main_label25
	b .main_label30
.main_label15:
# %op16 = getelementptr [20000000 x i32], [20000000 x i32]* @matrix, i32 0, i32 %op9
	ld.w $t8, $fp, -84
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	la.local $t8, matrix
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -112
# br label %label18
	b .main_label18
.main_label17:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label18
	b .main_label18
.main_label18:
# %op19 = load i32, i32* %op1
	ld.d $t8, $fp, -40
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -116
# store i32 %op19, i32* %op16
	ld.w $t7, $fp, -116
	ld.d $t8, $fp, -112
	st.w $t7, $t8, 0
# %op20 = load i32, i32* %op1
	ld.d $t8, $fp, -40
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -120
# %op21 = add i32 %op20, 1
	ld.w $t7, $fp, -120
	addi.w $t8, $zero, 1
	add.w $t7, $t7, $t8
	st.w $t7, $fp, -124
# store i32 %op21, i32* %op1
	ld.w $t7, $fp, -124
	ld.d $t8, $fp, -40
	st.w $t7, $t8, 0
# %op22 = load i32, i32* %op1
	ld.d $t8, $fp, -40
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -128
# %op23 = load i32, i32* %op0
	ld.d $t8, $fp, -24
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -132
# %op24 = icmp slt i32 %op22, %op23
	ld.w $t7, $fp, -128
	ld.w $t8, $fp, -132
	slt $t7, $t7, $t8
	st.b $t7, $fp, -133
# br i1 %op24, label %label8, label %label11
	ld.b $t7, $fp, -133
	bnez $t7, .main_label8
	b .main_label11
.main_label25:
# %op26 = load i32, i32* %op0
	ld.d $t8, $fp, -24
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -140
# %op27 = getelementptr [20000000 x i32], [20000000 x i32]* @matrix, i32 0, i32 0
	addi.w $t8, $zero, 0
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	la.local $t8, matrix
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -152
# %op28 = load i32, i32* %op1
	ld.d $t8, $fp, -40
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -156
# %op29 = icmp sge i32 %op28, 0
	ld.w $t7, $fp, -156
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t7
	st.b $t7, $fp, -157
	ld.w $t7, $fp, -156
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	ld.b $t7, $fp, -157
	or $t7, $t7, $t8
	st.b $t7, $fp, -157
# br i1 %op29, label %label34, label %label37
	ld.b $t7, $fp, -157
	bnez $t7, .main_label34
	b .main_label37
.main_label30:
# store i32 0, i32* %op2
	addi.w $t7, $zero, 0
	ld.d $t8, $fp, -56
	st.w $t7, $t8, 0
# store i32 0, i32* %op1
	addi.w $t7, $zero, 0
	ld.d $t8, $fp, -40
	st.w $t7, $t8, 0
# %op31 = load i32, i32* %op1
	ld.d $t8, $fp, -40
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -164
# %op32 = load i32, i32* @len
	la.local $t8, len
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -168
# %op33 = icmp slt i32 %op31, %op32
	ld.w $t7, $fp, -164
	ld.w $t8, $fp, -168
	slt $t7, $t7, $t8
	st.b $t7, $fp, -169
# br i1 %op33, label %label45, label %label48
	ld.b $t7, $fp, -169
	bnez $t7, .main_label45
	b .main_label48
.main_label34:
# %op35 = getelementptr [100000 x i32], [100000 x i32]* @ad, i32 0, i32 %op28
	ld.w $t8, $fp, -156
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	la.local $t8, ad
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -184
# %op36 = load i32, i32* %op35
	ld.d $t8, $fp, -184
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -188
# br label %label38
	b .main_label38
.main_label37:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label38
	b .main_label38
.main_label38:
# %op39 = call i32 @transpose(i32 %op26, i32* %op27, i32 %op36)
	ld.w $a0, $fp, -140
	ld.d $a1, $fp, -152
	ld.w $a2, $fp, -188
	bl transpose
	st.w $a0, $fp, -192
# %op40 = load i32, i32* %op1
	ld.d $t8, $fp, -40
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -196
# %op41 = add i32 %op40, 1
	ld.w $t7, $fp, -196
	addi.w $t8, $zero, 1
	add.w $t7, $t7, $t8
	st.w $t7, $fp, -200
# store i32 %op41, i32* %op1
	ld.w $t7, $fp, -200
	ld.d $t8, $fp, -40
	st.w $t7, $t8, 0
# %op42 = load i32, i32* %op1
	ld.d $t8, $fp, -40
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -204
# %op43 = load i32, i32* @len
	la.local $t8, len
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -208
# %op44 = icmp slt i32 %op42, %op43
	ld.w $t7, $fp, -204
	ld.w $t8, $fp, -208
	slt $t7, $t7, $t8
	st.b $t7, $fp, -209
# br i1 %op44, label %label25, label %label30
	ld.b $t7, $fp, -209
	bnez $t7, .main_label25
	b .main_label30
.main_label45:
# %op46 = load i32, i32* %op1
	ld.d $t8, $fp, -40
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -216
# %op47 = icmp sge i32 %op46, 0
	ld.w $t7, $fp, -216
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t7
	st.b $t7, $fp, -217
	ld.w $t7, $fp, -216
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	ld.b $t7, $fp, -217
	or $t7, $t7, $t8
	st.b $t7, $fp, -217
# br i1 %op47, label %label51, label %label54
	ld.b $t7, $fp, -217
	bnez $t7, .main_label51
	b .main_label54
.main_label48:
# %op49 = load i32, i32* %op2
	ld.d $t8, $fp, -56
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -224
# %op50 = icmp slt i32 %op49, 0
	ld.w $t7, $fp, -224
	addi.w $t8, $zero, 0
	slt $t7, $t7, $t8
	st.b $t7, $fp, -225
# br i1 %op50, label %label67, label %label70
	ld.b $t7, $fp, -225
	bnez $t7, .main_label67
	b .main_label70
.main_label51:
# %op52 = getelementptr [20000000 x i32], [20000000 x i32]* @matrix, i32 0, i32 %op46
	ld.w $t8, $fp, -216
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	la.local $t8, matrix
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -240
# %op53 = load i32, i32* %op52
	ld.d $t8, $fp, -240
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -244
# br label %label55
	b .main_label55
.main_label54:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label55
	b .main_label55
.main_label55:
# %op56 = load i32, i32* %op1
	ld.d $t8, $fp, -40
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -248
# %op57 = load i32, i32* %op1
	ld.d $t8, $fp, -40
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -252
# %op58 = mul i32 %op57, %op56
	ld.w $t7, $fp, -252
	ld.w $t8, $fp, -248
	mul.w $t7, $t7, $t8
	st.w $t7, $fp, -256
# %op59 = mul i32 %op58, %op53
	ld.w $t7, $fp, -256
	ld.w $t8, $fp, -244
	mul.w $t7, $t7, $t8
	st.w $t7, $fp, -260
# %op60 = load i32, i32* %op2
	ld.d $t8, $fp, -56
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -264
# %op61 = add i32 %op60, %op59
	ld.w $t7, $fp, -264
	ld.w $t8, $fp, -260
	add.w $t7, $t7, $t8
	st.w $t7, $fp, -268
# store i32 %op61, i32* %op2
	ld.w $t7, $fp, -268
	ld.d $t8, $fp, -56
	st.w $t7, $t8, 0
# %op62 = load i32, i32* %op1
	ld.d $t8, $fp, -40
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -272
# %op63 = add i32 %op62, 1
	ld.w $t7, $fp, -272
	addi.w $t8, $zero, 1
	add.w $t7, $t7, $t8
	st.w $t7, $fp, -276
# store i32 %op63, i32* %op1
	ld.w $t7, $fp, -276
	ld.d $t8, $fp, -40
	st.w $t7, $t8, 0
# %op64 = load i32, i32* %op1
	ld.d $t8, $fp, -40
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -280
# %op65 = load i32, i32* @len
	la.local $t8, len
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -284
# %op66 = icmp slt i32 %op64, %op65
	ld.w $t7, $fp, -280
	ld.w $t8, $fp, -284
	slt $t7, $t7, $t8
	st.b $t7, $fp, -285
# br i1 %op66, label %label45, label %label48
	ld.b $t7, $fp, -285
	bnez $t7, .main_label45
	b .main_label48
.main_label67:
# %op68 = load i32, i32* %op2
	ld.d $t8, $fp, -56
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -292
# %op69 = sub i32 0, %op68
	addi.w $t7, $zero, 0
	ld.w $t8, $fp, -292
	sub.w $t7, $t7, $t8
	st.w $t7, $fp, -296
# store i32 %op69, i32* %op2
	ld.w $t7, $fp, -296
	ld.d $t8, $fp, -56
	st.w $t7, $t8, 0
# br label %label70
	b .main_label70
.main_label70:
# %op71 = load i32, i32* %op2
	ld.d $t8, $fp, -56
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -300
# call void @output(i32 %op71)
	ld.w $a0, $fp, -300
	bl output
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
main_exit:
	addi.d $sp, $sp, 304
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
