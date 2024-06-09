# Global variables
	.text
	.section .bss, "aw", @nobits
	.globl n
	.type n, @object
	.size n, 4
n:
	.space 4
	.globl m
	.type m, @object
	.size m, 4
m:
	.space 4
	.globl w
	.type w, @object
	.size w, 20
w:
	.space 20
	.globl v
	.type v, @object
	.size v, 20
v:
	.space 20
	.globl dp
	.type dp, @object
	.size dp, 264
dp:
	.space 264
	.text
	.globl max
	.type max, @function
max:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -80
	st.w $a0, $fp, -20
	st.w $a1, $fp, -24
.max_label_entry:
# %op2 = alloca i32
	addi.d $t8, $fp, -36
	addi.d $t7, $fp, -32
	st.d $t8, $t7, 0
# store i32 %arg0, i32* %op2
	ld.w $t0, $fp, -20
	ld.d $t1, $fp, -32
	st.w $t0, $t1, 0
# %op3 = alloca i32
	addi.d $t8, $fp, -52
	addi.d $t7, $fp, -48
	st.d $t8, $t7, 0
# store i32 %arg1, i32* %op3
	ld.w $t0, $fp, -24
	ld.d $t1, $fp, -48
	st.w $t0, $t1, 0
# %op4 = load i32, i32* %op2
	ld.d $t0, $fp, -32
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -56
# %op5 = load i32, i32* %op3
	ld.d $t0, $fp, -48
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -60
# %op6 = icmp sgt i32 %op4, %op5
	ld.w $t0, $fp, -56
	ld.w $t1, $fp, -60
	slt $t2, $t1, $t0
	st.b $t2, $fp, -61
# br i1 %op6, label %label7, label %label9
	ld.b $t0, $fp, -61
	bnez $t0, .max_label7
	b .max_label9
.max_label7:
# %op8 = load i32, i32* %op2
	ld.d $t0, $fp, -32
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -68
# ret i32 %op8
	ld.w $a0, $fp, -68
	b max_exit
.max_label9:
# %op10 = load i32, i32* %op3
	ld.d $t0, $fp, -48
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -72
# ret i32 %op10
	ld.w $a0, $fp, -72
	b max_exit
.max_label11:
# ret i32 0
	addi.w $a0, $zero, 0
	b max_exit
max_exit:
	addi.d $sp, $sp, 80
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl knapsack
	.type knapsack, @function
knapsack:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -336
	st.w $a0, $fp, -20
	st.w $a1, $fp, -24
.knapsack_label_entry:
# %op2 = alloca i32
	addi.d $t8, $fp, -36
	addi.d $t7, $fp, -32
	st.d $t8, $t7, 0
# store i32 %arg0, i32* %op2
	ld.w $t0, $fp, -20
	ld.d $t1, $fp, -32
	st.w $t0, $t1, 0
# %op3 = alloca i32
	addi.d $t8, $fp, -52
	addi.d $t7, $fp, -48
	st.d $t8, $t7, 0
# store i32 %arg1, i32* %op3
	ld.w $t0, $fp, -24
	ld.d $t1, $fp, -48
	st.w $t0, $t1, 0
# %op4 = alloca i32
	addi.d $t8, $fp, -68
	addi.d $t7, $fp, -64
	st.d $t8, $t7, 0
# %op5 = load i32, i32* %op3
	ld.d $t0, $fp, -48
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -72
# %op6 = icmp sle i32 %op5, 0
	ld.w $t0, $fp, -72
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	xor $t3, $t0, $t1
	sltu $t4, $zero, $t3
	xori $t4, $t4, 1
	or $t5, $t2, $t4
	st.b $t5, $fp, -73
# br i1 %op6, label %label7, label %label8
	ld.b $t0, $fp, -73
	bnez $t0, .knapsack_label7
	b .knapsack_label8
.knapsack_label7:
# ret i32 0
	addi.w $a0, $zero, 0
	b knapsack_exit
.knapsack_label8:
# %op9 = load i32, i32* %op2
	ld.d $t0, $fp, -32
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -80
# %op10 = icmp eq i32 %op9, 0
	ld.w $t0, $fp, -80
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t3, $zero, $t2
	xori $t3, $t3, 1
	st.b $t3, $fp, -81
# br i1 %op10, label %label11, label %label12
	ld.b $t0, $fp, -81
	bnez $t0, .knapsack_label11
	b .knapsack_label12
.knapsack_label11:
# ret i32 0
	addi.w $a0, $zero, 0
	b knapsack_exit
.knapsack_label12:
# %op13 = load i32, i32* %op3
	ld.d $t0, $fp, -48
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -88
# %op14 = load i32, i32* %op2
	ld.d $t0, $fp, -32
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -92
# %op15 = mul i32 %op14, 11
	ld.w $t0, $fp, -92
	addi.w $t1, $zero, 11
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -96
# %op16 = add i32 %op15, %op13
	ld.w $t0, $fp, -96
	ld.w $t1, $fp, -88
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -100
# %op17 = icmp sge i32 %op16, 0
	ld.w $t0, $fp, -100
	addi.w $t1, $zero, 0
	slt $t2, $t1, $t0
	xor $t3, $t0, $t1
	sltu $t4, $zero, $t3
	xori $t4, $t4, 1
	or $t5, $t2, $t4
	st.b $t5, $fp, -101
# br i1 %op17, label %label18, label %label21
	ld.b $t0, $fp, -101
	bnez $t0, .knapsack_label18
	b .knapsack_label21
.knapsack_label18:
# %op19 = getelementptr [66 x i32], [66 x i32]* @dp, i32 0, i32 %op16
	la.local $t3, dp
	ld.w $t0, $fp, -100
	addi.w $t1, $zero, 4
	mul.w $t2, $t0, $t1
	add.d $t3, $t3, $t2
	st.d $t3, $fp, -112
# %op20 = load i32, i32* %op19
	ld.d $t0, $fp, -112
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -116
# br label %label22
	b .knapsack_label22
.knapsack_label21:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label22
	b .knapsack_label22
.knapsack_label22:
# %op23 = icmp sge i32 %op20, 0
	ld.w $t0, $fp, -116
	addi.w $t1, $zero, 0
	slt $t2, $t1, $t0
	xor $t3, $t0, $t1
	sltu $t4, $zero, $t3
	xori $t4, $t4, 1
	or $t5, $t2, $t4
	st.b $t5, $fp, -117
# br i1 %op23, label %label24, label %label30
	ld.b $t0, $fp, -117
	bnez $t0, .knapsack_label24
	b .knapsack_label30
.knapsack_label24:
# %op25 = load i32, i32* %op3
	ld.d $t0, $fp, -48
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -124
# %op26 = load i32, i32* %op2
	ld.d $t0, $fp, -32
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -128
# %op27 = mul i32 %op26, 11
	ld.w $t0, $fp, -128
	addi.w $t1, $zero, 11
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -132
# %op28 = add i32 %op27, %op25
	ld.w $t0, $fp, -132
	ld.w $t1, $fp, -124
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -136
# %op29 = icmp sge i32 %op28, 0
	ld.w $t0, $fp, -136
	addi.w $t1, $zero, 0
	slt $t2, $t1, $t0
	xor $t3, $t0, $t1
	sltu $t4, $zero, $t3
	xori $t4, $t4, 1
	or $t5, $t2, $t4
	st.b $t5, $fp, -137
# br i1 %op29, label %label35, label %label38
	ld.b $t0, $fp, -137
	bnez $t0, .knapsack_label35
	b .knapsack_label38
.knapsack_label30:
# %op31 = load i32, i32* %op3
	ld.d $t0, $fp, -48
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -144
# %op32 = load i32, i32* %op2
	ld.d $t0, $fp, -32
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -148
# %op33 = sub i32 %op32, 1
	ld.w $t0, $fp, -148
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -152
# %op34 = icmp sge i32 %op33, 0
	ld.w $t0, $fp, -152
	addi.w $t1, $zero, 0
	slt $t2, $t1, $t0
	xor $t3, $t0, $t1
	sltu $t4, $zero, $t3
	xori $t4, $t4, 1
	or $t5, $t2, $t4
	st.b $t5, $fp, -153
# br i1 %op34, label %label40, label %label43
	ld.b $t0, $fp, -153
	bnez $t0, .knapsack_label40
	b .knapsack_label43
.knapsack_label35:
# %op36 = getelementptr [66 x i32], [66 x i32]* @dp, i32 0, i32 %op28
	la.local $t3, dp
	ld.w $t0, $fp, -136
	addi.w $t1, $zero, 4
	mul.w $t2, $t0, $t1
	add.d $t3, $t3, $t2
	st.d $t3, $fp, -168
# %op37 = load i32, i32* %op36
	ld.d $t0, $fp, -168
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -172
# br label %label39
	b .knapsack_label39
.knapsack_label38:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label39
	b .knapsack_label39
.knapsack_label39:
# ret i32 %op37
	ld.w $a0, $fp, -172
	b knapsack_exit
.knapsack_label40:
# %op41 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 %op33
	la.local $t3, w
	ld.w $t0, $fp, -152
	addi.w $t1, $zero, 4
	mul.w $t2, $t0, $t1
	add.d $t3, $t3, $t2
	st.d $t3, $fp, -184
# %op42 = load i32, i32* %op41
	ld.d $t0, $fp, -184
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -188
# br label %label44
	b .knapsack_label44
.knapsack_label43:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label44
	b .knapsack_label44
.knapsack_label44:
# %op45 = icmp slt i32 %op31, %op42
	ld.w $t0, $fp, -144
	ld.w $t1, $fp, -188
	slt $t2, $t0, $t1
	st.b $t2, $fp, -189
# br i1 %op45, label %label46, label %label51
	ld.b $t0, $fp, -189
	bnez $t0, .knapsack_label46
	b .knapsack_label51
.knapsack_label46:
# %op47 = load i32, i32* %op2
	ld.d $t0, $fp, -32
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -196
# %op48 = sub i32 %op47, 1
	ld.w $t0, $fp, -196
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -200
# %op49 = load i32, i32* %op3
	ld.d $t0, $fp, -48
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -204
# %op50 = call i32 @knapsack(i32 %op48, i32 %op49)
	ld.w $a0, $fp, -200
	ld.w $a1, $fp, -204
	bl knapsack
	st.w $a0, $fp, -208
# store i32 %op50, i32* %op4
	ld.w $t0, $fp, -208
	ld.d $t1, $fp, -64
	st.w $t0, $t1, 0
# br label %label59
	b .knapsack_label59
.knapsack_label51:
# %op52 = load i32, i32* %op2
	ld.d $t0, $fp, -32
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -212
# %op53 = sub i32 %op52, 1
	ld.w $t0, $fp, -212
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -216
# %op54 = load i32, i32* %op3
	ld.d $t0, $fp, -48
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -220
# %op55 = call i32 @knapsack(i32 %op53, i32 %op54)
	ld.w $a0, $fp, -216
	ld.w $a1, $fp, -220
	bl knapsack
	st.w $a0, $fp, -224
# %op56 = load i32, i32* %op2
	ld.d $t0, $fp, -32
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -228
# %op57 = sub i32 %op56, 1
	ld.w $t0, $fp, -228
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -232
# %op58 = icmp sge i32 %op57, 0
	ld.w $t0, $fp, -232
	addi.w $t1, $zero, 0
	slt $t2, $t1, $t0
	xor $t3, $t0, $t1
	sltu $t4, $zero, $t3
	xori $t4, $t4, 1
	or $t5, $t2, $t4
	st.b $t5, $fp, -233
# br i1 %op58, label %label65, label %label68
	ld.b $t0, $fp, -233
	bnez $t0, .knapsack_label65
	b .knapsack_label68
.knapsack_label59:
# %op60 = load i32, i32* %op3
	ld.d $t0, $fp, -48
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -240
# %op61 = load i32, i32* %op2
	ld.d $t0, $fp, -32
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -244
# %op62 = mul i32 %op61, 11
	ld.w $t0, $fp, -244
	addi.w $t1, $zero, 11
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -248
# %op63 = add i32 %op62, %op60
	ld.w $t0, $fp, -248
	ld.w $t1, $fp, -240
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -252
# %op64 = icmp sge i32 %op63, 0
	ld.w $t0, $fp, -252
	addi.w $t1, $zero, 0
	slt $t2, $t1, $t0
	xor $t3, $t0, $t1
	sltu $t4, $zero, $t3
	xori $t4, $t4, 1
	or $t5, $t2, $t4
	st.b $t5, $fp, -253
# br i1 %op64, label %label85, label %label87
	ld.b $t0, $fp, -253
	bnez $t0, .knapsack_label85
	b .knapsack_label87
.knapsack_label65:
# %op66 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 %op57
	la.local $t3, v
	ld.w $t0, $fp, -232
	addi.w $t1, $zero, 4
	mul.w $t2, $t0, $t1
	add.d $t3, $t3, $t2
	st.d $t3, $fp, -264
# %op67 = load i32, i32* %op66
	ld.d $t0, $fp, -264
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -268
# br label %label69
	b .knapsack_label69
.knapsack_label68:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label69
	b .knapsack_label69
.knapsack_label69:
# %op70 = load i32, i32* %op2
	ld.d $t0, $fp, -32
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -272
# %op71 = sub i32 %op70, 1
	ld.w $t0, $fp, -272
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -276
# %op72 = load i32, i32* %op2
	ld.d $t0, $fp, -32
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -280
# %op73 = sub i32 %op72, 1
	ld.w $t0, $fp, -280
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -284
# %op74 = icmp sge i32 %op73, 0
	ld.w $t0, $fp, -284
	addi.w $t1, $zero, 0
	slt $t2, $t1, $t0
	xor $t3, $t0, $t1
	sltu $t4, $zero, $t3
	xori $t4, $t4, 1
	or $t5, $t2, $t4
	st.b $t5, $fp, -285
# br i1 %op74, label %label75, label %label78
	ld.b $t0, $fp, -285
	bnez $t0, .knapsack_label75
	b .knapsack_label78
.knapsack_label75:
# %op76 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 %op73
	la.local $t3, w
	ld.w $t0, $fp, -284
	addi.w $t1, $zero, 4
	mul.w $t2, $t0, $t1
	add.d $t3, $t3, $t2
	st.d $t3, $fp, -296
# %op77 = load i32, i32* %op76
	ld.d $t0, $fp, -296
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -300
# br label %label79
	b .knapsack_label79
.knapsack_label78:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label79
	b .knapsack_label79
.knapsack_label79:
# %op80 = load i32, i32* %op3
	ld.d $t0, $fp, -48
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -304
# %op81 = sub i32 %op80, %op77
	ld.w $t0, $fp, -304
	ld.w $t1, $fp, -300
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -308
# %op82 = call i32 @knapsack(i32 %op71, i32 %op81)
	ld.w $a0, $fp, -276
	ld.w $a1, $fp, -308
	bl knapsack
	st.w $a0, $fp, -312
# %op83 = add i32 %op82, %op67
	ld.w $t0, $fp, -312
	ld.w $t1, $fp, -268
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -316
# %op84 = call i32 @max(i32 %op55, i32 %op83)
	ld.w $a0, $fp, -224
	ld.w $a1, $fp, -316
	bl max
	st.w $a0, $fp, -320
# store i32 %op84, i32* %op4
	ld.w $t0, $fp, -320
	ld.d $t1, $fp, -64
	st.w $t0, $t1, 0
# br label %label59
	b .knapsack_label59
.knapsack_label85:
# %op86 = getelementptr [66 x i32], [66 x i32]* @dp, i32 0, i32 %op63
	la.local $t3, dp
	ld.w $t0, $fp, -252
	addi.w $t1, $zero, 4
	mul.w $t2, $t0, $t1
	add.d $t3, $t3, $t2
	st.d $t3, $fp, -328
# br label %label88
	b .knapsack_label88
.knapsack_label87:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label88
	b .knapsack_label88
.knapsack_label88:
# %op89 = load i32, i32* %op4
	ld.d $t0, $fp, -64
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -332
# store i32 %op89, i32* %op86
	ld.w $t0, $fp, -332
	ld.d $t1, $fp, -328
	st.w $t0, $t1, 0
# %op90 = load i32, i32* %op4
	ld.d $t0, $fp, -64
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -336
# ret i32 %op90
	ld.w $a0, $fp, -336
	b knapsack_exit
knapsack_exit:
	addi.d $sp, $sp, 336
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -256
.main_label_entry:
# %op0 = alloca i32
	addi.d $t8, $fp, -28
	addi.d $t7, $fp, -24
	st.d $t8, $t7, 0
# store i32 0, i32* %op0
	addi.w $t0, $zero, 0
	ld.d $t1, $fp, -24
	st.w $t0, $t1, 0
# store i32 5, i32* @n
	addi.w $t0, $zero, 5
	la.local $t1, n
	st.w $t0, $t1, 0
# store i32 10, i32* @m
	addi.w $t0, $zero, 10
	la.local $t1, m
	st.w $t0, $t1, 0
# %op1 = icmp sge i32 0, 0
	addi.w $t0, $zero, 0
	addi.w $t1, $zero, 0
	slt $t2, $t1, $t0
	xor $t3, $t0, $t1
	sltu $t4, $zero, $t3
	xori $t4, $t4, 1
	or $t5, $t2, $t4
	st.b $t5, $fp, -29
# br i1 %op1, label %label2, label %label4
	ld.b $t0, $fp, -29
	bnez $t0, .main_label2
	b .main_label4
.main_label2:
# %op3 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 0
	la.local $t3, w
	addi.w $t0, $zero, 0
	addi.w $t1, $zero, 4
	mul.w $t2, $t0, $t1
	add.d $t3, $t3, $t2
	st.d $t3, $fp, -40
# br label %label5
	b .main_label5
.main_label4:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label5
	b .main_label5
.main_label5:
# store i32 2, i32* %op3
	addi.w $t0, $zero, 2
	ld.d $t1, $fp, -40
	st.w $t0, $t1, 0
# %op6 = icmp sge i32 1, 0
	addi.w $t0, $zero, 1
	addi.w $t1, $zero, 0
	slt $t2, $t1, $t0
	xor $t3, $t0, $t1
	sltu $t4, $zero, $t3
	xori $t4, $t4, 1
	or $t5, $t2, $t4
	st.b $t5, $fp, -41
# br i1 %op6, label %label7, label %label9
	ld.b $t0, $fp, -41
	bnez $t0, .main_label7
	b .main_label9
.main_label7:
# %op8 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 1
	la.local $t3, w
	addi.w $t0, $zero, 1
	addi.w $t1, $zero, 4
	mul.w $t2, $t0, $t1
	add.d $t3, $t3, $t2
	st.d $t3, $fp, -56
# br label %label10
	b .main_label10
.main_label9:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label10
	b .main_label10
.main_label10:
# store i32 2, i32* %op8
	addi.w $t0, $zero, 2
	ld.d $t1, $fp, -56
	st.w $t0, $t1, 0
# %op11 = icmp sge i32 2, 0
	addi.w $t0, $zero, 2
	addi.w $t1, $zero, 0
	slt $t2, $t1, $t0
	xor $t3, $t0, $t1
	sltu $t4, $zero, $t3
	xori $t4, $t4, 1
	or $t5, $t2, $t4
	st.b $t5, $fp, -57
# br i1 %op11, label %label12, label %label14
	ld.b $t0, $fp, -57
	bnez $t0, .main_label12
	b .main_label14
.main_label12:
# %op13 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 2
	la.local $t3, w
	addi.w $t0, $zero, 2
	addi.w $t1, $zero, 4
	mul.w $t2, $t0, $t1
	add.d $t3, $t3, $t2
	st.d $t3, $fp, -72
# br label %label15
	b .main_label15
.main_label14:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label15
	b .main_label15
.main_label15:
# store i32 6, i32* %op13
	addi.w $t0, $zero, 6
	ld.d $t1, $fp, -72
	st.w $t0, $t1, 0
# %op16 = icmp sge i32 3, 0
	addi.w $t0, $zero, 3
	addi.w $t1, $zero, 0
	slt $t2, $t1, $t0
	xor $t3, $t0, $t1
	sltu $t4, $zero, $t3
	xori $t4, $t4, 1
	or $t5, $t2, $t4
	st.b $t5, $fp, -73
# br i1 %op16, label %label17, label %label19
	ld.b $t0, $fp, -73
	bnez $t0, .main_label17
	b .main_label19
.main_label17:
# %op18 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 3
	la.local $t3, w
	addi.w $t0, $zero, 3
	addi.w $t1, $zero, 4
	mul.w $t2, $t0, $t1
	add.d $t3, $t3, $t2
	st.d $t3, $fp, -88
# br label %label20
	b .main_label20
.main_label19:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label20
	b .main_label20
.main_label20:
# store i32 5, i32* %op18
	addi.w $t0, $zero, 5
	ld.d $t1, $fp, -88
	st.w $t0, $t1, 0
# %op21 = icmp sge i32 4, 0
	addi.w $t0, $zero, 4
	addi.w $t1, $zero, 0
	slt $t2, $t1, $t0
	xor $t3, $t0, $t1
	sltu $t4, $zero, $t3
	xori $t4, $t4, 1
	or $t5, $t2, $t4
	st.b $t5, $fp, -89
# br i1 %op21, label %label22, label %label24
	ld.b $t0, $fp, -89
	bnez $t0, .main_label22
	b .main_label24
.main_label22:
# %op23 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 4
	la.local $t3, w
	addi.w $t0, $zero, 4
	addi.w $t1, $zero, 4
	mul.w $t2, $t0, $t1
	add.d $t3, $t3, $t2
	st.d $t3, $fp, -104
# br label %label25
	b .main_label25
.main_label24:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label25
	b .main_label25
.main_label25:
# store i32 4, i32* %op23
	addi.w $t0, $zero, 4
	ld.d $t1, $fp, -104
	st.w $t0, $t1, 0
# %op26 = icmp sge i32 0, 0
	addi.w $t0, $zero, 0
	addi.w $t1, $zero, 0
	slt $t2, $t1, $t0
	xor $t3, $t0, $t1
	sltu $t4, $zero, $t3
	xori $t4, $t4, 1
	or $t5, $t2, $t4
	st.b $t5, $fp, -105
# br i1 %op26, label %label27, label %label29
	ld.b $t0, $fp, -105
	bnez $t0, .main_label27
	b .main_label29
.main_label27:
# %op28 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 0
	la.local $t3, v
	addi.w $t0, $zero, 0
	addi.w $t1, $zero, 4
	mul.w $t2, $t0, $t1
	add.d $t3, $t3, $t2
	st.d $t3, $fp, -120
# br label %label30
	b .main_label30
.main_label29:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label30
	b .main_label30
.main_label30:
# store i32 6, i32* %op28
	addi.w $t0, $zero, 6
	ld.d $t1, $fp, -120
	st.w $t0, $t1, 0
# %op31 = icmp sge i32 1, 0
	addi.w $t0, $zero, 1
	addi.w $t1, $zero, 0
	slt $t2, $t1, $t0
	xor $t3, $t0, $t1
	sltu $t4, $zero, $t3
	xori $t4, $t4, 1
	or $t5, $t2, $t4
	st.b $t5, $fp, -121
# br i1 %op31, label %label32, label %label34
	ld.b $t0, $fp, -121
	bnez $t0, .main_label32
	b .main_label34
.main_label32:
# %op33 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 1
	la.local $t3, v
	addi.w $t0, $zero, 1
	addi.w $t1, $zero, 4
	mul.w $t2, $t0, $t1
	add.d $t3, $t3, $t2
	st.d $t3, $fp, -136
# br label %label35
	b .main_label35
.main_label34:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label35
	b .main_label35
.main_label35:
# store i32 3, i32* %op33
	addi.w $t0, $zero, 3
	ld.d $t1, $fp, -136
	st.w $t0, $t1, 0
# %op36 = icmp sge i32 2, 0
	addi.w $t0, $zero, 2
	addi.w $t1, $zero, 0
	slt $t2, $t1, $t0
	xor $t3, $t0, $t1
	sltu $t4, $zero, $t3
	xori $t4, $t4, 1
	or $t5, $t2, $t4
	st.b $t5, $fp, -137
# br i1 %op36, label %label37, label %label39
	ld.b $t0, $fp, -137
	bnez $t0, .main_label37
	b .main_label39
.main_label37:
# %op38 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 2
	la.local $t3, v
	addi.w $t0, $zero, 2
	addi.w $t1, $zero, 4
	mul.w $t2, $t0, $t1
	add.d $t3, $t3, $t2
	st.d $t3, $fp, -152
# br label %label40
	b .main_label40
.main_label39:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label40
	b .main_label40
.main_label40:
# store i32 5, i32* %op38
	addi.w $t0, $zero, 5
	ld.d $t1, $fp, -152
	st.w $t0, $t1, 0
# %op41 = icmp sge i32 3, 0
	addi.w $t0, $zero, 3
	addi.w $t1, $zero, 0
	slt $t2, $t1, $t0
	xor $t3, $t0, $t1
	sltu $t4, $zero, $t3
	xori $t4, $t4, 1
	or $t5, $t2, $t4
	st.b $t5, $fp, -153
# br i1 %op41, label %label42, label %label44
	ld.b $t0, $fp, -153
	bnez $t0, .main_label42
	b .main_label44
.main_label42:
# %op43 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 3
	la.local $t3, v
	addi.w $t0, $zero, 3
	addi.w $t1, $zero, 4
	mul.w $t2, $t0, $t1
	add.d $t3, $t3, $t2
	st.d $t3, $fp, -168
# br label %label45
	b .main_label45
.main_label44:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label45
	b .main_label45
.main_label45:
# store i32 4, i32* %op43
	addi.w $t0, $zero, 4
	ld.d $t1, $fp, -168
	st.w $t0, $t1, 0
# %op46 = icmp sge i32 4, 0
	addi.w $t0, $zero, 4
	addi.w $t1, $zero, 0
	slt $t2, $t1, $t0
	xor $t3, $t0, $t1
	sltu $t4, $zero, $t3
	xori $t4, $t4, 1
	or $t5, $t2, $t4
	st.b $t5, $fp, -169
# br i1 %op46, label %label47, label %label49
	ld.b $t0, $fp, -169
	bnez $t0, .main_label47
	b .main_label49
.main_label47:
# %op48 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 4
	la.local $t3, v
	addi.w $t0, $zero, 4
	addi.w $t1, $zero, 4
	mul.w $t2, $t0, $t1
	add.d $t3, $t3, $t2
	st.d $t3, $fp, -184
# br label %label50
	b .main_label50
.main_label49:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label50
	b .main_label50
.main_label50:
# store i32 6, i32* %op48
	addi.w $t0, $zero, 6
	ld.d $t1, $fp, -184
	st.w $t0, $t1, 0
# %op51 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -188
# %op52 = icmp slt i32 %op51, 66
	ld.w $t0, $fp, -188
	addi.w $t1, $zero, 66
	slt $t2, $t0, $t1
	st.b $t2, $fp, -189
# br i1 %op52, label %label53, label %label56
	ld.b $t0, $fp, -189
	bnez $t0, .main_label53
	b .main_label56
.main_label53:
# %op54 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -196
# %op55 = icmp sge i32 %op54, 0
	ld.w $t0, $fp, -196
	addi.w $t1, $zero, 0
	slt $t2, $t1, $t0
	xor $t3, $t0, $t1
	sltu $t4, $zero, $t3
	xori $t4, $t4, 1
	or $t5, $t2, $t4
	st.b $t5, $fp, -197
# br i1 %op55, label %label60, label %label62
	ld.b $t0, $fp, -197
	bnez $t0, .main_label60
	b .main_label62
.main_label56:
# %op57 = load i32, i32* @n
	la.local $t0, n
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -204
# %op58 = load i32, i32* @m
	la.local $t0, m
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -208
# %op59 = call i32 @knapsack(i32 %op57, i32 %op58)
	ld.w $a0, $fp, -204
	ld.w $a1, $fp, -208
	bl knapsack
	st.w $a0, $fp, -212
# call void @output(i32 %op59)
	ld.w $a0, $fp, -212
	bl output
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
.main_label60:
# %op61 = getelementptr [66 x i32], [66 x i32]* @dp, i32 0, i32 %op54
	la.local $t3, dp
	ld.w $t0, $fp, -196
	addi.w $t1, $zero, 4
	mul.w $t2, $t0, $t1
	add.d $t3, $t3, $t2
	st.d $t3, $fp, -224
# br label %label63
	b .main_label63
.main_label62:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label63
	b .main_label63
.main_label63:
# %op64 = sub i32 0, 1
	addi.w $t0, $zero, 0
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -228
# store i32 %op64, i32* %op61
	ld.w $t0, $fp, -228
	ld.d $t1, $fp, -224
	st.w $t0, $t1, 0
# %op65 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -232
# %op66 = add i32 %op65, 1
	ld.w $t0, $fp, -232
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -236
# store i32 %op66, i32* %op0
	ld.w $t0, $fp, -236
	ld.d $t1, $fp, -24
	st.w $t0, $t1, 0
# %op67 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -240
# %op68 = icmp slt i32 %op67, 66
	ld.w $t0, $fp, -240
	addi.w $t1, $zero, 66
	slt $t2, $t0, $t1
	st.b $t2, $fp, -241
# br i1 %op68, label %label53, label %label56
	ld.b $t0, $fp, -241
	bnez $t0, .main_label53
	b .main_label56
main_exit:
	addi.d $sp, $sp, 256
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
