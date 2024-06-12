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
	add.d $t0, $a0, $zero
	add.d $t1, $a1, $zero
.max_label_entry:
# %op2 = alloca i32
	addi.d $t2, $fp, -36
# store i32 %arg0, i32* %op2
	st.w $t0, $t2, 0
# %op3 = alloca i32
	addi.d $t0, $fp, -52
# store i32 %arg1, i32* %op3
	st.w $t1, $t0, 0
# %op4 = load i32, i32* %op2
	ld.w $t1, $t2, 0
# %op5 = load i32, i32* %op3
	ld.w $t3, $t0, 0
# %op6 = icmp sgt i32 %op4, %op5
	slt $t1, $t3, $t1
# br i1 %op6, label %label7, label %label9
	bnez $t1, .max_label7
	b .max_label9
.max_label7:
# %op8 = load i32, i32* %op2
	ld.w $t1, $t2, 0
# ret i32 %op8
	add.w $a0, $t1, $zero
	b max_exit
.max_label9:
# %op10 = load i32, i32* %op3
	ld.w $t0, $t0, 0
# ret i32 %op10
	add.w $a0, $t0, $zero
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
	addi.d $sp, $sp, -320
	add.d $t0, $a0, $zero
	add.d $t1, $a1, $zero
.knapsack_label_entry:
# %op2 = alloca i32
	addi.d $t8, $fp, -36
	addi.d $t7, $fp, -32
	st.d $t8, $t7, 0
# store i32 %arg0, i32* %op2
	ld.d $t7, $fp, -32
	st.w $t0, $t7, 0
# %op3 = alloca i32
	addi.d $t8, $fp, -52
	addi.d $t7, $fp, -48
	st.d $t8, $t7, 0
# store i32 %arg1, i32* %op3
	ld.d $t7, $fp, -48
	st.w $t1, $t7, 0
# %op4 = load i32, i32* %op3
	ld.d $t8, $fp, -48
	ld.w $t1, $t8, 0
# %op5 = icmp sle i32 %op4, 0
	addi.w $t8, $zero, 0
	slt $t7, $t1, $t8
	xor $t8, $t1, $t8
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	or $t1, $t7, $t8
# br i1 %op5, label %label6, label %label7
	bnez $t1, .knapsack_label6
	b .knapsack_label7
.knapsack_label6:
# ret i32 0
	addi.w $a0, $zero, 0
	b knapsack_exit
.knapsack_label7:
# %op8 = load i32, i32* %op2
	ld.d $t8, $fp, -32
	ld.w $t1, $t8, 0
# %op9 = icmp eq i32 %op8, 0
	addi.w $t8, $zero, 0
	xor $t7, $t1, $t8
	sltu $t7, $zero, $t7
	xori $t1, $t7, 1
# br i1 %op9, label %label10, label %label11
	bnez $t1, .knapsack_label10
	b .knapsack_label11
.knapsack_label10:
# ret i32 0
	addi.w $a0, $zero, 0
	b knapsack_exit
.knapsack_label11:
# %op12 = load i32, i32* %op3
	ld.d $t8, $fp, -48
	ld.w $t1, $t8, 0
# %op13 = load i32, i32* %op2
	ld.d $t8, $fp, -32
	ld.w $t3, $t8, 0
# %op14 = mul i32 %op13, 11
	addi.w $t8, $zero, 11
	mul.w $t3, $t3, $t8
# %op15 = add i32 %op14, %op12
	add.w $t1, $t3, $t1
# %op16 = icmp sge i32 %op15, 0
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t1
	xor $t8, $t8, $t1
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	or $t3, $t7, $t8
# br i1 %op16, label %label17, label %label20
	bnez $t3, .knapsack_label17
	b .knapsack_label20
.knapsack_label17:
# %op18 = getelementptr [66 x i32], [66 x i32]* @dp, i32 0, i32 %op15
	la.local $t8, dp
	addi.w $t7, $zero, 4
	mul.w $t7, $t1, $t7
	add.d $t1, $t8, $t7
# %op19 = load i32, i32* %op18
	ld.w $t7, $t1, 0
	st.w $t7, $fp, -100
# br label %label21
	b .knapsack_label21
.knapsack_label20:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label21
	b .knapsack_label21
.knapsack_label21:
# %op22 = icmp sge i32 %op19, 0
	ld.w $t7, $fp, -100
	addi.w $t8, $zero, 0
	slt $t0, $t8, $t7
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	or $t0, $t0, $t8
# br i1 %op22, label %label23, label %label29
	bnez $t0, .knapsack_label23
	b .knapsack_label29
.knapsack_label23:
# %op24 = load i32, i32* %op3
	ld.d $t8, $fp, -48
	ld.w $t0, $t8, 0
# %op25 = load i32, i32* %op2
	ld.d $t8, $fp, -32
	ld.w $t1, $t8, 0
# %op26 = mul i32 %op25, 11
	addi.w $t8, $zero, 11
	mul.w $t1, $t1, $t8
# %op27 = add i32 %op26, %op24
	add.w $t0, $t1, $t0
# %op28 = icmp sge i32 %op27, 0
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t0
	xor $t8, $t8, $t0
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	or $t1, $t7, $t8
# br i1 %op28, label %label34, label %label37
	bnez $t1, .knapsack_label34
	b .knapsack_label37
.knapsack_label29:
# %op30 = load i32, i32* %op3
	ld.d $t8, $fp, -48
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -128
# %op31 = load i32, i32* %op2
	ld.d $t8, $fp, -32
	ld.w $t1, $t8, 0
# %op32 = sub i32 %op31, 1
	addi.w $t8, $zero, 1
	sub.w $t1, $t1, $t8
# %op33 = icmp sge i32 %op32, 0
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t1
	xor $t8, $t8, $t1
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	or $t2, $t7, $t8
# br i1 %op33, label %label39, label %label42
	bnez $t2, .knapsack_label39
	b .knapsack_label42
.knapsack_label34:
# %op35 = getelementptr [66 x i32], [66 x i32]* @dp, i32 0, i32 %op27
	la.local $t8, dp
	addi.w $t7, $zero, 4
	mul.w $t7, $t0, $t7
	add.d $t0, $t8, $t7
# %op36 = load i32, i32* %op35
	ld.w $t0, $t0, 0
# br label %label38
	b .knapsack_label38
.knapsack_label37:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label38
	b .knapsack_label38
.knapsack_label38:
# ret i32 %op36
	add.w $a0, $t0, $zero
	b knapsack_exit
.knapsack_label39:
# %op40 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 %op32
	la.local $t8, w
	addi.w $t7, $zero, 4
	mul.w $t7, $t1, $t7
	add.d $t1, $t8, $t7
# %op41 = load i32, i32* %op40
	ld.w $t7, $t1, 0
	st.w $t7, $fp, -172
# br label %label43
	b .knapsack_label43
.knapsack_label42:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label43
	b .knapsack_label43
.knapsack_label43:
# %op44 = icmp slt i32 %op30, %op41
	ld.w $t7, $fp, -128
	ld.w $t8, $fp, -172
	slt $t0, $t7, $t8
# br i1 %op44, label %label45, label %label50
	bnez $t0, .knapsack_label45
	b .knapsack_label50
.knapsack_label45:
# %op46 = load i32, i32* %op2
	ld.d $t8, $fp, -32
	ld.w $t0, $t8, 0
# %op47 = sub i32 %op46, 1
	addi.w $t8, $zero, 1
	sub.w $t0, $t0, $t8
# %op48 = load i32, i32* %op3
	ld.d $t8, $fp, -48
	ld.w $t1, $t8, 0
# %op49 = call i32 @knapsack(i32 %op47, i32 %op48)
	add.d $a0, $t0, $zero
	add.d $a1, $t1, $zero
	bl knapsack
	st.w $a0, $fp, -192
# br label %label58
# %op59 = phi i32 [ %op49, %label45 ], [ %op84, %label79 ]
	ld.w $t7, $fp, -192
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -224
	b .knapsack_label58
.knapsack_label50:
# %op51 = load i32, i32* %op2
	ld.d $t8, $fp, -32
	ld.w $t1, $t8, 0
# %op52 = sub i32 %op51, 1
	addi.w $t8, $zero, 1
	sub.w $t1, $t1, $t8
# %op53 = load i32, i32* %op3
	ld.d $t8, $fp, -48
	ld.w $t2, $t8, 0
# %op54 = call i32 @knapsack(i32 %op52, i32 %op53)
	add.d $a0, $t1, $zero
	add.d $a1, $t2, $zero
	bl knapsack
	st.w $a0, $fp, -208
# %op55 = load i32, i32* %op2
	ld.d $t8, $fp, -32
	ld.w $t1, $t8, 0
# %op56 = sub i32 %op55, 1
	addi.w $t8, $zero, 1
	sub.w $t1, $t1, $t8
# %op57 = icmp sge i32 %op56, 0
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t1
	xor $t8, $t8, $t1
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	or $t2, $t7, $t8
# br i1 %op57, label %label65, label %label68
	bnez $t2, .knapsack_label65
	b .knapsack_label68
.knapsack_label58:
# %op59 = phi i32 [ %op49, %label45 ], [ %op84, %label79 ]
# %op60 = load i32, i32* %op3
	ld.d $t8, $fp, -48
	ld.w $t1, $t8, 0
# %op61 = load i32, i32* %op2
	ld.d $t8, $fp, -32
	ld.w $t2, $t8, 0
# %op62 = mul i32 %op61, 11
	addi.w $t8, $zero, 11
	mul.w $t2, $t2, $t8
# %op63 = add i32 %op62, %op60
	add.w $t1, $t2, $t1
# %op64 = icmp sge i32 %op63, 0
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t1
	xor $t8, $t8, $t1
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	or $t2, $t7, $t8
# br i1 %op64, label %label85, label %label87
	bnez $t2, .knapsack_label85
	b .knapsack_label87
.knapsack_label65:
# %op66 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 %op56
	la.local $t8, v
	addi.w $t7, $zero, 4
	mul.w $t7, $t1, $t7
	add.d $t1, $t8, $t7
# %op67 = load i32, i32* %op66
	ld.w $t7, $t1, 0
	st.w $t7, $fp, -260
# br label %label69
	b .knapsack_label69
.knapsack_label68:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label69
	b .knapsack_label69
.knapsack_label69:
# %op70 = load i32, i32* %op2
	ld.d $t8, $fp, -32
	ld.w $t0, $t8, 0
# %op71 = sub i32 %op70, 1
	addi.w $t7, $zero, 1
	sub.w $t7, $t0, $t7
	st.w $t7, $fp, -268
# %op72 = load i32, i32* %op2
	ld.d $t8, $fp, -32
	ld.w $t1, $t8, 0
# %op73 = sub i32 %op72, 1
	addi.w $t8, $zero, 1
	sub.w $t1, $t1, $t8
# %op74 = icmp sge i32 %op73, 0
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t1
	xor $t8, $t8, $t1
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	or $t2, $t7, $t8
# br i1 %op74, label %label75, label %label78
	bnez $t2, .knapsack_label75
	b .knapsack_label78
.knapsack_label75:
# %op76 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 %op73
	la.local $t8, w
	addi.w $t7, $zero, 4
	mul.w $t7, $t1, $t7
	add.d $t1, $t8, $t7
# %op77 = load i32, i32* %op76
	ld.w $t7, $t1, 0
	st.w $t7, $fp, -292
# br label %label79
	b .knapsack_label79
.knapsack_label78:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label79
	b .knapsack_label79
.knapsack_label79:
# %op80 = load i32, i32* %op3
	ld.d $t8, $fp, -48
	ld.w $t0, $t8, 0
# %op81 = sub i32 %op80, %op77
	ld.w $t8, $fp, -292
	sub.w $t0, $t0, $t8
# %op82 = call i32 @knapsack(i32 %op71, i32 %op81)
	ld.w $a0, $fp, -268
	add.d $a1, $t0, $zero
	bl knapsack
	add.w $t0, $a0, $zero
# %op83 = add i32 %op82, %op67
	ld.w $t8, $fp, -260
	add.w $t0, $t0, $t8
# %op84 = call i32 @max(i32 %op54, i32 %op83)
	ld.w $a0, $fp, -208
	add.d $a1, $t0, $zero
	bl max
	add.w $t0, $a0, $zero
# br label %label58
# %op59 = phi i32 [ %op49, %label45 ], [ %op84, %label79 ]
	add.d $t7, $t0, $zero
	st.w $t7, $fp, -224
	b .knapsack_label58
.knapsack_label85:
# %op86 = getelementptr [66 x i32], [66 x i32]* @dp, i32 0, i32 %op63
	la.local $t8, dp
	addi.w $t7, $zero, 4
	mul.w $t7, $t1, $t7
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -320
# br label %label88
	b .knapsack_label88
.knapsack_label87:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label88
	b .knapsack_label88
.knapsack_label88:
# store i32 %op59, i32* %op86
	ld.w $t7, $fp, -224
	ld.d $t8, $fp, -320
	st.w $t7, $t8, 0
# ret i32 %op59
	ld.w $a0, $fp, -224
	b knapsack_exit
knapsack_exit:
	addi.d $sp, $sp, 320
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -224
.main_label_entry:
# store i32 5, i32* @n
	addi.w $t7, $zero, 5
	la.local $t8, n
	st.w $t7, $t8, 0
# store i32 10, i32* @m
	addi.w $t7, $zero, 10
	la.local $t8, m
	st.w $t7, $t8, 0
# %op0 = icmp sge i32 0, 0
	addi.w $t7, $zero, 0
	addi.w $t8, $zero, 0
	slt $t0, $t8, $t7
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	or $t0, $t0, $t8
# br i1 %op0, label %label1, label %label3
	bnez $t0, .main_label1
	b .main_label3
.main_label1:
# %op2 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 0
	addi.w $t8, $zero, 0
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	la.local $t8, w
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -32
# br label %label4
	b .main_label4
.main_label3:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label4
	b .main_label4
.main_label4:
# store i32 2, i32* %op2
	addi.w $t7, $zero, 2
	ld.d $t8, $fp, -32
	st.w $t7, $t8, 0
# %op5 = icmp sge i32 1, 0
	addi.w $t7, $zero, 1
	addi.w $t8, $zero, 0
	slt $t0, $t8, $t7
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	or $t0, $t0, $t8
# br i1 %op5, label %label6, label %label8
	bnez $t0, .main_label6
	b .main_label8
.main_label6:
# %op7 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 1
	addi.w $t8, $zero, 1
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	la.local $t8, w
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -48
# br label %label9
	b .main_label9
.main_label8:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label9
	b .main_label9
.main_label9:
# store i32 2, i32* %op7
	addi.w $t7, $zero, 2
	ld.d $t8, $fp, -48
	st.w $t7, $t8, 0
# %op10 = icmp sge i32 2, 0
	addi.w $t7, $zero, 2
	addi.w $t8, $zero, 0
	slt $t0, $t8, $t7
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	or $t0, $t0, $t8
# br i1 %op10, label %label11, label %label13
	bnez $t0, .main_label11
	b .main_label13
.main_label11:
# %op12 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 2
	addi.w $t8, $zero, 2
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	la.local $t8, w
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -64
# br label %label14
	b .main_label14
.main_label13:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label14
	b .main_label14
.main_label14:
# store i32 6, i32* %op12
	addi.w $t7, $zero, 6
	ld.d $t8, $fp, -64
	st.w $t7, $t8, 0
# %op15 = icmp sge i32 3, 0
	addi.w $t7, $zero, 3
	addi.w $t8, $zero, 0
	slt $t0, $t8, $t7
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	or $t0, $t0, $t8
# br i1 %op15, label %label16, label %label18
	bnez $t0, .main_label16
	b .main_label18
.main_label16:
# %op17 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 3
	addi.w $t8, $zero, 3
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	la.local $t8, w
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -80
# br label %label19
	b .main_label19
.main_label18:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label19
	b .main_label19
.main_label19:
# store i32 5, i32* %op17
	addi.w $t7, $zero, 5
	ld.d $t8, $fp, -80
	st.w $t7, $t8, 0
# %op20 = icmp sge i32 4, 0
	addi.w $t7, $zero, 4
	addi.w $t8, $zero, 0
	slt $t0, $t8, $t7
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	or $t0, $t0, $t8
# br i1 %op20, label %label21, label %label23
	bnez $t0, .main_label21
	b .main_label23
.main_label21:
# %op22 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 4
	addi.w $t8, $zero, 4
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	la.local $t8, w
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -96
# br label %label24
	b .main_label24
.main_label23:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label24
	b .main_label24
.main_label24:
# store i32 4, i32* %op22
	addi.w $t7, $zero, 4
	ld.d $t8, $fp, -96
	st.w $t7, $t8, 0
# %op25 = icmp sge i32 0, 0
	addi.w $t7, $zero, 0
	addi.w $t8, $zero, 0
	slt $t0, $t8, $t7
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	or $t0, $t0, $t8
# br i1 %op25, label %label26, label %label28
	bnez $t0, .main_label26
	b .main_label28
.main_label26:
# %op27 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 0
	addi.w $t8, $zero, 0
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	la.local $t8, v
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -112
# br label %label29
	b .main_label29
.main_label28:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label29
	b .main_label29
.main_label29:
# store i32 6, i32* %op27
	addi.w $t7, $zero, 6
	ld.d $t8, $fp, -112
	st.w $t7, $t8, 0
# %op30 = icmp sge i32 1, 0
	addi.w $t7, $zero, 1
	addi.w $t8, $zero, 0
	slt $t0, $t8, $t7
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	or $t0, $t0, $t8
# br i1 %op30, label %label31, label %label33
	bnez $t0, .main_label31
	b .main_label33
.main_label31:
# %op32 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 1
	addi.w $t8, $zero, 1
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	la.local $t8, v
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -128
# br label %label34
	b .main_label34
.main_label33:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label34
	b .main_label34
.main_label34:
# store i32 3, i32* %op32
	addi.w $t7, $zero, 3
	ld.d $t8, $fp, -128
	st.w $t7, $t8, 0
# %op35 = icmp sge i32 2, 0
	addi.w $t7, $zero, 2
	addi.w $t8, $zero, 0
	slt $t0, $t8, $t7
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	or $t0, $t0, $t8
# br i1 %op35, label %label36, label %label38
	bnez $t0, .main_label36
	b .main_label38
.main_label36:
# %op37 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 2
	addi.w $t8, $zero, 2
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	la.local $t8, v
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -144
# br label %label39
	b .main_label39
.main_label38:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label39
	b .main_label39
.main_label39:
# store i32 5, i32* %op37
	addi.w $t7, $zero, 5
	ld.d $t8, $fp, -144
	st.w $t7, $t8, 0
# %op40 = icmp sge i32 3, 0
	addi.w $t7, $zero, 3
	addi.w $t8, $zero, 0
	slt $t0, $t8, $t7
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	or $t0, $t0, $t8
# br i1 %op40, label %label41, label %label43
	bnez $t0, .main_label41
	b .main_label43
.main_label41:
# %op42 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 3
	addi.w $t8, $zero, 3
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	la.local $t8, v
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -160
# br label %label44
	b .main_label44
.main_label43:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label44
	b .main_label44
.main_label44:
# store i32 4, i32* %op42
	addi.w $t7, $zero, 4
	ld.d $t8, $fp, -160
	st.w $t7, $t8, 0
# %op45 = icmp sge i32 4, 0
	addi.w $t7, $zero, 4
	addi.w $t8, $zero, 0
	slt $t0, $t8, $t7
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	or $t0, $t0, $t8
# br i1 %op45, label %label46, label %label48
	bnez $t0, .main_label46
	b .main_label48
.main_label46:
# %op47 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 4
	addi.w $t8, $zero, 4
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	la.local $t8, v
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -176
# br label %label49
	b .main_label49
.main_label48:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label49
	b .main_label49
.main_label49:
# store i32 6, i32* %op47
	addi.w $t7, $zero, 6
	ld.d $t8, $fp, -176
	st.w $t7, $t8, 0
# %op50 = icmp slt i32 0, 66
	addi.w $t7, $zero, 0
	addi.w $t8, $zero, 66
	slt $t0, $t7, $t8
# br i1 %op50, label %label51, label %label54
# %op52 = phi i32 [ 0, %label49 ], [ %op63, %label61 ]
	addi.w $t7, $zero, 0
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -184
	bnez $t0, .main_label51
	b .main_label54
.main_label51:
# %op52 = phi i32 [ 0, %label49 ], [ %op63, %label61 ]
# %op53 = icmp sge i32 %op52, 0
	ld.w $t7, $fp, -184
	addi.w $t8, $zero, 0
	slt $t1, $t8, $t7
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	or $t1, $t1, $t8
# br i1 %op53, label %label58, label %label60
	bnez $t1, .main_label58
	b .main_label60
.main_label54:
# %op55 = load i32, i32* @n
	la.local $t8, n
	ld.w $t0, $t8, 0
# %op56 = load i32, i32* @m
	la.local $t8, m
	ld.w $t1, $t8, 0
# %op57 = call i32 @knapsack(i32 %op55, i32 %op56)
	add.d $a0, $t0, $zero
	add.d $a1, $t1, $zero
	bl knapsack
	add.w $t0, $a0, $zero
# call void @output(i32 %op57)
	add.d $a0, $t0, $zero
	bl output
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
.main_label58:
# %op59 = getelementptr [66 x i32], [66 x i32]* @dp, i32 0, i32 %op52
	ld.w $t8, $fp, -184
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	la.local $t8, dp
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -208
# br label %label61
	b .main_label61
.main_label60:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label61
	b .main_label61
.main_label61:
# %op62 = sub i32 0, 1
	addi.w $t7, $zero, 0
	addi.w $t8, $zero, 1
	sub.w $t0, $t7, $t8
# store i32 %op62, i32* %op59
	ld.d $t7, $fp, -208
	st.w $t0, $t7, 0
# %op63 = add i32 %op52, 1
	ld.w $t7, $fp, -184
	addi.w $t8, $zero, 1
	add.w $t0, $t7, $t8
# %op64 = icmp slt i32 %op63, 66
	addi.w $t8, $zero, 66
	slt $t1, $t0, $t8
# br i1 %op64, label %label51, label %label54
# %op52 = phi i32 [ 0, %label49 ], [ %op63, %label61 ]
	add.d $t7, $t0, $zero
	st.w $t7, $fp, -184
	bnez $t1, .main_label51
	b .main_label54
main_exit:
	addi.d $sp, $sp, 224
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
