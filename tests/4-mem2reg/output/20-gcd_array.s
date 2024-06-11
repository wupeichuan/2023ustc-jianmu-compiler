# Global variables
	.text
	.section .bss, "aw", @nobits
	.globl x
	.type x, @object
	.size x, 4
x:
	.space 4
	.globl y
	.type y, @object
	.size y, 4
y:
	.space 4
	.text
	.globl gcd
	.type gcd, @function
gcd:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -112
	add.d $t0, $a0, $zero
	add.d $t1, $a1, $zero
.gcd_label_entry:
# %op2 = alloca i32
	addi.d $t8, $fp, -36
	addi.d $t7, $fp, -32
	st.d $t8, $t7, 0
# store i32 %arg0, i32* %op2
	ld.d $t7, $fp, -32
	st.w $t0, $t7, 0
# %op3 = alloca i32
	addi.d $t0, $fp, -52
# store i32 %arg1, i32* %op3
	st.w $t1, $t0, 0
# %op4 = load i32, i32* %op3
	ld.w $t1, $t0, 0
# %op5 = icmp eq i32 %op4, 0
	addi.w $t8, $zero, 0
	xor $t7, $t1, $t8
	sltu $t7, $zero, $t7
	xori $t1, $t7, 1
# br i1 %op5, label %label6, label %label8
	bnez $t1, .gcd_label6
	b .gcd_label8
.gcd_label6:
# %op7 = load i32, i32* %op2
	ld.d $t8, $fp, -32
	ld.w $t1, $t8, 0
# ret i32 %op7
	add.w $a0, $t1, $zero
	b gcd_exit
.gcd_label8:
# %op9 = load i32, i32* %op3
	ld.w $t7, $t0, 0
	st.w $t7, $fp, -68
# %op10 = load i32, i32* %op3
	ld.w $t7, $t0, 0
	st.w $t7, $fp, -72
# %op11 = load i32, i32* %op3
	ld.w $t0, $t0, 0
# %op12 = load i32, i32* %op2
	ld.d $t8, $fp, -32
	ld.w $t1, $t8, 0
# %op13 = sdiv i32 %op12, %op11
	div.w $t0, $t1, $t0
# %op14 = mul i32 %op13, %op10
	ld.w $t8, $fp, -72
	mul.w $t0, $t0, $t8
# %op15 = load i32, i32* %op2
	ld.d $t8, $fp, -32
	ld.w $t1, $t8, 0
# %op16 = sub i32 %op15, %op14
	sub.w $t0, $t1, $t0
# %op17 = call i32 @gcd(i32 %op9, i32 %op16)
	ld.w $a0, $fp, -68
	add.d $a1, $t0, $zero
	bl gcd
	add.w $t0, $a0, $zero
# ret i32 %op17
	add.w $a0, $t0, $zero
	b gcd_exit
.gcd_label18:
# ret i32 0
	addi.w $a0, $zero, 0
	b gcd_exit
gcd_exit:
	addi.d $sp, $sp, 112
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl funArray
	.type funArray, @function
funArray:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -144
	st.d $a0, $fp, -24
	st.d $a1, $fp, -32
.funArray_label_entry:
# %op2 = alloca i32*
	addi.d $t8, $fp, -48
	addi.d $t7, $fp, -40
	st.d $t8, $t7, 0
# store i32* %arg0, i32** %op2
	ld.d $t7, $fp, -24
	ld.d $t8, $fp, -40
	st.d $t7, $t8, 0
# %op3 = alloca i32*
	addi.d $t8, $fp, -64
	addi.d $t7, $fp, -56
	st.d $t8, $t7, 0
# store i32* %arg1, i32** %op3
	ld.d $t7, $fp, -32
	ld.d $t8, $fp, -56
	st.d $t7, $t8, 0
# %op4 = icmp sge i32 0, 0
	addi.w $t7, $zero, 0
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t7
	st.b $t7, $fp, -65
	addi.w $t7, $zero, 0
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	ld.b $t7, $fp, -65
	or $t7, $t7, $t8
	st.b $t7, $fp, -65
# br i1 %op4, label %label5, label %label9
	ld.b $t7, $fp, -65
	bnez $t7, .funArray_label5
	b .funArray_label9
.funArray_label5:
# %op6 = load i32*, i32** %op2
	ld.d $t8, $fp, -40
	ld.d $t7, $t8, 0
	st.d $t7, $fp, -80
# %op7 = getelementptr i32, i32* %op6, i32 0
	addi.w $t8, $zero, 0
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	ld.d $t8, $fp, -80
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -88
# %op8 = load i32, i32* %op7
	ld.d $t8, $fp, -88
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -92
# br label %label10
	b .funArray_label10
.funArray_label9:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label10
	b .funArray_label10
.funArray_label10:
# %op11 = icmp sge i32 0, 0
	addi.w $t7, $zero, 0
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t7
	st.b $t7, $fp, -93
	addi.w $t7, $zero, 0
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	ld.b $t7, $fp, -93
	or $t7, $t7, $t8
	st.b $t7, $fp, -93
# br i1 %op11, label %label12, label %label16
	ld.b $t7, $fp, -93
	bnez $t7, .funArray_label12
	b .funArray_label16
.funArray_label12:
# %op13 = load i32*, i32** %op3
	ld.d $t8, $fp, -56
	ld.d $t7, $t8, 0
	st.d $t7, $fp, -104
# %op14 = getelementptr i32, i32* %op13, i32 0
	addi.w $t8, $zero, 0
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	ld.d $t8, $fp, -104
	add.d $t7, $t8, $t7
	st.d $t7, $fp, -112
# %op15 = load i32, i32* %op14
	ld.d $t8, $fp, -112
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -116
# br label %label17
	b .funArray_label17
.funArray_label16:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label17
	b .funArray_label17
.funArray_label17:
# %op18 = icmp slt i32 %op8, %op15
	ld.w $t7, $fp, -92
	ld.w $t8, $fp, -116
	slt $t0, $t7, $t8
# br i1 %op18, label %label19, label %label20
	bnez $t0, .funArray_label19
# %op21 = phi i32 [ %op15, %label17 ], [ %op8, %label19 ]
	ld.w $t7, $fp, -116
	add.d $t0, $t7, $zero
# %op22 = phi i32 [ %op8, %label17 ], [ %op15, %label19 ]
	ld.w $t7, $fp, -92
	add.d $t1, $t7, $zero
	b .funArray_label20
.funArray_label19:
# br label %label20
# %op21 = phi i32 [ %op15, %label17 ], [ %op8, %label19 ]
	ld.w $t7, $fp, -92
	add.d $t0, $t7, $zero
# %op22 = phi i32 [ %op8, %label17 ], [ %op15, %label19 ]
	ld.w $t7, $fp, -116
	add.d $t1, $t7, $zero
	b .funArray_label20
.funArray_label20:
# %op21 = phi i32 [ %op15, %label17 ], [ %op8, %label19 ]
# %op22 = phi i32 [ %op8, %label17 ], [ %op15, %label19 ]
# %op23 = call i32 @gcd(i32 %op22, i32 %op21)
	add.d $a0, $t1, $zero
	add.d $a1, $t0, $zero
	bl gcd
	add.w $t0, $a0, $zero
# ret i32 %op23
	add.w $a0, $t0, $zero
	b funArray_exit
funArray_exit:
	addi.d $sp, $sp, 144
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -80
.main_label_entry:
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
# %op2 = getelementptr [1 x i32], [1 x i32]* @x, i32 0, i32 0
	addi.w $t8, $zero, 0
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	la.local $t8, x
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
# store i32 90, i32* %op2
	addi.w $t7, $zero, 90
	ld.d $t8, $fp, -32
	st.w $t7, $t8, 0
# %op5 = icmp sge i32 0, 0
	addi.w $t7, $zero, 0
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t7
	st.b $t7, $fp, -33
	addi.w $t7, $zero, 0
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	ld.b $t7, $fp, -33
	or $t7, $t7, $t8
	st.b $t7, $fp, -33
# br i1 %op5, label %label6, label %label8
	ld.b $t7, $fp, -33
	bnez $t7, .main_label6
	b .main_label8
.main_label6:
# %op7 = getelementptr [1 x i32], [1 x i32]* @y, i32 0, i32 0
	addi.w $t8, $zero, 0
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	la.local $t8, y
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
# store i32 18, i32* %op7
	addi.w $t7, $zero, 18
	ld.d $t8, $fp, -48
	st.w $t7, $t8, 0
# %op10 = getelementptr [1 x i32], [1 x i32]* @x, i32 0, i32 0
	addi.w $t8, $zero, 0
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	la.local $t8, x
	add.d $t0, $t8, $t7
# %op11 = getelementptr [1 x i32], [1 x i32]* @y, i32 0, i32 0
	addi.w $t8, $zero, 0
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	la.local $t8, y
	add.d $t1, $t8, $t7
# %op12 = call i32 @funArray(i32* %op10, i32* %op11)
	add.d $a0, $t0, $zero
	add.d $a1, $t1, $zero
	bl funArray
	add.w $t0, $a0, $zero
# ret i32 %op12
	add.w $a0, $t0, $zero
	b main_exit
main_exit:
	addi.d $sp, $sp, 80
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
