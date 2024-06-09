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
	st.w $a0, $fp, -20
	st.w $a1, $fp, -24
.gcd_label_entry:
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
# %op4 = load i32, i32* %op3
	ld.d $t0, $fp, -48
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -56
# %op5 = icmp eq i32 %op4, 0
	ld.w $t0, $fp, -56
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t3, $zero, $t2
	xori $t3, $t3, 1
	st.b $t3, $fp, -57
# br i1 %op5, label %label6, label %label8
	ld.b $t0, $fp, -57
	bnez $t0, .gcd_label6
	b .gcd_label8
.gcd_label6:
# %op7 = load i32, i32* %op2
	ld.d $t0, $fp, -32
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -64
# ret i32 %op7
	ld.w $a0, $fp, -64
	b gcd_exit
.gcd_label8:
# %op9 = load i32, i32* %op3
	ld.d $t0, $fp, -48
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -68
# %op10 = load i32, i32* %op3
	ld.d $t0, $fp, -48
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -72
# %op11 = load i32, i32* %op3
	ld.d $t0, $fp, -48
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -76
# %op12 = load i32, i32* %op2
	ld.d $t0, $fp, -32
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -80
# %op13 = sdiv i32 %op12, %op11
	ld.w $t0, $fp, -80
	ld.w $t1, $fp, -76
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -84
# %op14 = mul i32 %op13, %op10
	ld.w $t0, $fp, -84
	ld.w $t1, $fp, -72
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -88
# %op15 = load i32, i32* %op2
	ld.d $t0, $fp, -32
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -92
# %op16 = sub i32 %op15, %op14
	ld.w $t0, $fp, -92
	ld.w $t1, $fp, -88
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -96
# %op17 = call i32 @gcd(i32 %op9, i32 %op16)
	ld.w $a0, $fp, -68
	ld.w $a1, $fp, -96
	bl gcd
	st.w $a0, $fp, -100
# ret i32 %op17
	ld.w $a0, $fp, -100
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
	addi.d $sp, $sp, -192
	st.d $a0, $fp, -24
	st.d $a1, $fp, -32
.funArray_label_entry:
# %op2 = alloca i32*
	addi.d $t8, $fp, -48
	addi.d $t7, $fp, -40
	st.d $t8, $t7, 0
# store i32* %arg0, i32** %op2
	ld.d $t0, $fp, -24
	ld.d $t1, $fp, -40
	st.d $t0, $t1, 0
# %op3 = alloca i32*
	addi.d $t8, $fp, -64
	addi.d $t7, $fp, -56
	st.d $t8, $t7, 0
# store i32* %arg1, i32** %op3
	ld.d $t0, $fp, -32
	ld.d $t1, $fp, -56
	st.d $t0, $t1, 0
# %op4 = alloca i32
	addi.d $t8, $fp, -76
	addi.d $t7, $fp, -72
	st.d $t8, $t7, 0
# %op5 = alloca i32
	addi.d $t8, $fp, -92
	addi.d $t7, $fp, -88
	st.d $t8, $t7, 0
# %op6 = alloca i32
	addi.d $t8, $fp, -108
	addi.d $t7, $fp, -104
	st.d $t8, $t7, 0
# %op7 = icmp sge i32 0, 0
	addi.w $t0, $zero, 0
	addi.w $t1, $zero, 0
	slt $t2, $t1, $t0
	xor $t3, $t0, $t1
	sltu $t4, $zero, $t3
	xori $t4, $t4, 1
	or $t5, $t2, $t4
	st.b $t5, $fp, -109
# br i1 %op7, label %label8, label %label12
	ld.b $t0, $fp, -109
	bnez $t0, .funArray_label8
	b .funArray_label12
.funArray_label8:
# %op9 = load i32*, i32** %op2
	ld.d $t0, $fp, -40
	ld.d $t0, $t0, 0
	st.d $t0, $fp, -120
# %op10 = getelementptr i32, i32* %op9, i32 0
	ld.d $t3, $fp, -120
	addi.w $t0, $zero, 0
	addi.w $t1, $zero, 4
	mul.w $t2, $t0, $t1
	add.d $t3, $t3, $t2
	st.d $t3, $fp, -128
# %op11 = load i32, i32* %op10
	ld.d $t0, $fp, -128
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -132
# br label %label13
	b .funArray_label13
.funArray_label12:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label13
	b .funArray_label13
.funArray_label13:
# store i32 %op11, i32* %op4
	ld.w $t0, $fp, -132
	ld.d $t1, $fp, -72
	st.w $t0, $t1, 0
# %op14 = icmp sge i32 0, 0
	addi.w $t0, $zero, 0
	addi.w $t1, $zero, 0
	slt $t2, $t1, $t0
	xor $t3, $t0, $t1
	sltu $t4, $zero, $t3
	xori $t4, $t4, 1
	or $t5, $t2, $t4
	st.b $t5, $fp, -133
# br i1 %op14, label %label15, label %label19
	ld.b $t0, $fp, -133
	bnez $t0, .funArray_label15
	b .funArray_label19
.funArray_label15:
# %op16 = load i32*, i32** %op3
	ld.d $t0, $fp, -56
	ld.d $t0, $t0, 0
	st.d $t0, $fp, -144
# %op17 = getelementptr i32, i32* %op16, i32 0
	ld.d $t3, $fp, -144
	addi.w $t0, $zero, 0
	addi.w $t1, $zero, 4
	mul.w $t2, $t0, $t1
	add.d $t3, $t3, $t2
	st.d $t3, $fp, -152
# %op18 = load i32, i32* %op17
	ld.d $t0, $fp, -152
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -156
# br label %label20
	b .funArray_label20
.funArray_label19:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label20
	b .funArray_label20
.funArray_label20:
# store i32 %op18, i32* %op5
	ld.w $t0, $fp, -156
	ld.d $t1, $fp, -88
	st.w $t0, $t1, 0
# %op21 = load i32, i32* %op4
	ld.d $t0, $fp, -72
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -160
# %op22 = load i32, i32* %op5
	ld.d $t0, $fp, -88
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -164
# %op23 = icmp slt i32 %op21, %op22
	ld.w $t0, $fp, -160
	ld.w $t1, $fp, -164
	slt $t2, $t0, $t1
	st.b $t2, $fp, -165
# br i1 %op23, label %label24, label %label28
	ld.b $t0, $fp, -165
	bnez $t0, .funArray_label24
	b .funArray_label28
.funArray_label24:
# %op25 = load i32, i32* %op4
	ld.d $t0, $fp, -72
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -172
# store i32 %op25, i32* %op6
	ld.w $t0, $fp, -172
	ld.d $t1, $fp, -104
	st.w $t0, $t1, 0
# %op26 = load i32, i32* %op5
	ld.d $t0, $fp, -88
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -176
# store i32 %op26, i32* %op4
	ld.w $t0, $fp, -176
	ld.d $t1, $fp, -72
	st.w $t0, $t1, 0
# %op27 = load i32, i32* %op6
	ld.d $t0, $fp, -104
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -180
# store i32 %op27, i32* %op5
	ld.w $t0, $fp, -180
	ld.d $t1, $fp, -88
	st.w $t0, $t1, 0
# br label %label28
	b .funArray_label28
.funArray_label28:
# %op29 = load i32, i32* %op4
	ld.d $t0, $fp, -72
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -184
# %op30 = load i32, i32* %op5
	ld.d $t0, $fp, -88
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -188
# %op31 = call i32 @gcd(i32 %op29, i32 %op30)
	ld.w $a0, $fp, -184
	ld.w $a1, $fp, -188
	bl gcd
	st.w $a0, $fp, -192
# ret i32 %op31
	ld.w $a0, $fp, -192
	b funArray_exit
funArray_exit:
	addi.d $sp, $sp, 192
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
	addi.w $t0, $zero, 0
	addi.w $t1, $zero, 0
	slt $t2, $t1, $t0
	xor $t3, $t0, $t1
	sltu $t4, $zero, $t3
	xori $t4, $t4, 1
	or $t5, $t2, $t4
	st.b $t5, $fp, -17
# br i1 %op0, label %label1, label %label3
	ld.b $t0, $fp, -17
	bnez $t0, .main_label1
	b .main_label3
.main_label1:
# %op2 = getelementptr [1 x i32], [1 x i32]* @x, i32 0, i32 0
	la.local $t3, x
	addi.w $t0, $zero, 0
	addi.w $t1, $zero, 4
	mul.w $t2, $t0, $t1
	add.d $t3, $t3, $t2
	st.d $t3, $fp, -32
# br label %label4
	b .main_label4
.main_label3:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label4
	b .main_label4
.main_label4:
# store i32 90, i32* %op2
	addi.w $t0, $zero, 90
	ld.d $t1, $fp, -32
	st.w $t0, $t1, 0
# %op5 = icmp sge i32 0, 0
	addi.w $t0, $zero, 0
	addi.w $t1, $zero, 0
	slt $t2, $t1, $t0
	xor $t3, $t0, $t1
	sltu $t4, $zero, $t3
	xori $t4, $t4, 1
	or $t5, $t2, $t4
	st.b $t5, $fp, -33
# br i1 %op5, label %label6, label %label8
	ld.b $t0, $fp, -33
	bnez $t0, .main_label6
	b .main_label8
.main_label6:
# %op7 = getelementptr [1 x i32], [1 x i32]* @y, i32 0, i32 0
	la.local $t3, y
	addi.w $t0, $zero, 0
	addi.w $t1, $zero, 4
	mul.w $t2, $t0, $t1
	add.d $t3, $t3, $t2
	st.d $t3, $fp, -48
# br label %label9
	b .main_label9
.main_label8:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label9
	b .main_label9
.main_label9:
# store i32 18, i32* %op7
	addi.w $t0, $zero, 18
	ld.d $t1, $fp, -48
	st.w $t0, $t1, 0
# %op10 = getelementptr [1 x i32], [1 x i32]* @x, i32 0, i32 0
	la.local $t3, x
	addi.w $t0, $zero, 0
	addi.w $t1, $zero, 4
	mul.w $t2, $t0, $t1
	add.d $t3, $t3, $t2
	st.d $t3, $fp, -56
# %op11 = getelementptr [1 x i32], [1 x i32]* @y, i32 0, i32 0
	la.local $t3, y
	addi.w $t0, $zero, 0
	addi.w $t1, $zero, 4
	mul.w $t2, $t0, $t1
	add.d $t3, $t3, $t2
	st.d $t3, $fp, -64
# %op12 = call i32 @funArray(i32* %op10, i32* %op11)
	ld.d $a0, $fp, -56
	ld.d $a1, $fp, -64
	bl funArray
	st.w $a0, $fp, -68
# ret i32 %op12
	ld.w $a0, $fp, -68
	b main_exit
main_exit:
	addi.d $sp, $sp, 80
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
