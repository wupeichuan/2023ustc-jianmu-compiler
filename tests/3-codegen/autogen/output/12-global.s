# Global variables
	.text
	.section .bss, "aw", @nobits
	.globl seed
	.type seed, @object
	.size seed, 4
seed:
	.space 4
	.text
	.globl randomLCG
	.type randomLCG, @function
randomLCG:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -32
.randomLCG_label_entry:
# %op0 = load i32, i32* @seed
	la.local $t0, seed
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -20
# %op1 = mul i32 %op0, 1103515245
	ld.w $t0, $fp, -20
	lu12i.w $t1, 269412
	ori $t1, $t1, 3693
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -24
# %op2 = add i32 %op1, 12345
	ld.w $t0, $fp, -24
	lu12i.w $t1, 3
	ori $t1, $t1, 57
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -28
# store i32 %op2, i32* @seed
	ld.w $t0, $fp, -28
	la.local $t1, seed
	st.w $t0, $t1, 0
# %op3 = load i32, i32* @seed
	la.local $t0, seed
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -32
# ret i32 %op3
	ld.w $a0, $fp, -32
	b randomLCG_exit
randomLCG_exit:
	addi.d $sp, $sp, 32
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl randBin
	.type randBin, @function
randBin:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -32
.randBin_label_entry:
# %op0 = call i32 @randomLCG()
	bl randomLCG
	st.w $a0, $fp, -20
# %op1 = icmp sgt i32 %op0, 0
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 0
	slt $t2, $t1, $t0
	st.b $t2, $fp, -21
# br i1 %op1, label %label2, label %label3
	ld.b $t0, $fp, -21
	bnez $t0, .randBin_label2
	b .randBin_label3
.randBin_label2:
# ret i32 1
	addi.w $a0, $zero, 1
	b randBin_exit
.randBin_label3:
# ret i32 0
	addi.w $a0, $zero, 0
	b randBin_exit
.randBin_label4:
# ret i32 0
	addi.w $a0, $zero, 0
	b randBin_exit
randBin_exit:
	addi.d $sp, $sp, 32
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl returnToZeroSteps
	.type returnToZeroSteps, @function
returnToZeroSteps:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -112
.returnToZeroSteps_label_entry:
# %op0 = alloca i32
	addi.d $t8, $fp, -28
	addi.d $t7, $fp, -24
	st.d $t8, $t7, 0
# %op1 = alloca i32
	addi.d $t8, $fp, -44
	addi.d $t7, $fp, -40
	st.d $t8, $t7, 0
# store i32 0, i32* %op0
	addi.w $t0, $zero, 0
	ld.d $t1, $fp, -24
	st.w $t0, $t1, 0
# store i32 0, i32* %op1
	addi.w $t0, $zero, 0
	ld.d $t1, $fp, -40
	st.w $t0, $t1, 0
# %op2 = load i32, i32* %op1
	ld.d $t0, $fp, -40
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -48
# %op3 = icmp slt i32 %op2, 20
	ld.w $t0, $fp, -48
	addi.w $t1, $zero, 20
	slt $t2, $t0, $t1
	st.b $t2, $fp, -49
# br i1 %op3, label %label4, label %label7
	ld.b $t0, $fp, -49
	bnez $t0, .returnToZeroSteps_label4
	b .returnToZeroSteps_label7
.returnToZeroSteps_label4:
# %op5 = call i32 @randBin()
	bl randBin
	st.w $a0, $fp, -56
# %op6 = icmp ne i32 %op5, 0
	ld.w $t0, $fp, -56
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t3, $zero, $t2
	st.b $t3, $fp, -57
# br i1 %op6, label %label8, label %label11
	ld.b $t0, $fp, -57
	bnez $t0, .returnToZeroSteps_label8
	b .returnToZeroSteps_label11
.returnToZeroSteps_label7:
# ret i32 20
	addi.w $a0, $zero, 20
	b returnToZeroSteps_exit
.returnToZeroSteps_label8:
# %op9 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -64
# %op10 = add i32 %op9, 1
	ld.w $t0, $fp, -64
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -68
# store i32 %op10, i32* %op0
	ld.w $t0, $fp, -68
	ld.d $t1, $fp, -24
	st.w $t0, $t1, 0
# br label %label14
	b .returnToZeroSteps_label14
.returnToZeroSteps_label11:
# %op12 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -72
# %op13 = sub i32 %op12, 1
	ld.w $t0, $fp, -72
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -76
# store i32 %op13, i32* %op0
	ld.w $t0, $fp, -76
	ld.d $t1, $fp, -24
	st.w $t0, $t1, 0
# br label %label14
	b .returnToZeroSteps_label14
.returnToZeroSteps_label14:
# %op15 = load i32, i32* %op1
	ld.d $t0, $fp, -40
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -80
# %op16 = add i32 %op15, 1
	ld.w $t0, $fp, -80
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -84
# store i32 %op16, i32* %op1
	ld.w $t0, $fp, -84
	ld.d $t1, $fp, -40
	st.w $t0, $t1, 0
# %op17 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -88
# %op18 = icmp eq i32 %op17, 0
	ld.w $t0, $fp, -88
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t3, $zero, $t2
	xori $t3, $t3, 1
	st.b $t3, $fp, -89
# br i1 %op18, label %label19, label %label21
	ld.b $t0, $fp, -89
	bnez $t0, .returnToZeroSteps_label19
	b .returnToZeroSteps_label21
.returnToZeroSteps_label19:
# %op20 = load i32, i32* %op1
	ld.d $t0, $fp, -40
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -96
# ret i32 %op20
	ld.w $a0, $fp, -96
	b returnToZeroSteps_exit
.returnToZeroSteps_label21:
# %op22 = load i32, i32* %op1
	ld.d $t0, $fp, -40
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -100
# %op23 = icmp slt i32 %op22, 20
	ld.w $t0, $fp, -100
	addi.w $t1, $zero, 20
	slt $t2, $t0, $t1
	st.b $t2, $fp, -101
# br i1 %op23, label %label4, label %label7
	ld.b $t0, $fp, -101
	bnez $t0, .returnToZeroSteps_label4
	b .returnToZeroSteps_label7
returnToZeroSteps_exit:
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
	addi.d $sp, $sp, -64
.main_label_entry:
# %op0 = alloca i32
	addi.d $t8, $fp, -28
	addi.d $t7, $fp, -24
	st.d $t8, $t7, 0
# store i32 0, i32* %op0
	addi.w $t0, $zero, 0
	ld.d $t1, $fp, -24
	st.w $t0, $t1, 0
# store i32 3407, i32* @seed
	lu12i.w $t0, 0
	ori $t0, $t0, 3407
	la.local $t1, seed
	st.w $t0, $t1, 0
# %op1 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -32
# %op2 = icmp slt i32 %op1, 20
	ld.w $t0, $fp, -32
	addi.w $t1, $zero, 20
	slt $t2, $t0, $t1
	st.b $t2, $fp, -33
# br i1 %op2, label %label3, label %label9
	ld.b $t0, $fp, -33
	bnez $t0, .main_label3
	b .main_label9
.main_label3:
# %op4 = call i32 @returnToZeroSteps()
	bl returnToZeroSteps
	st.w $a0, $fp, -40
# call void @output(i32 %op4)
	ld.w $a0, $fp, -40
	bl output
# %op5 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -44
# %op6 = add i32 %op5, 1
	ld.w $t0, $fp, -44
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -48
# store i32 %op6, i32* %op0
	ld.w $t0, $fp, -48
	ld.d $t1, $fp, -24
	st.w $t0, $t1, 0
# %op7 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -52
# %op8 = icmp slt i32 %op7, 20
	ld.w $t0, $fp, -52
	addi.w $t1, $zero, 20
	slt $t2, $t0, $t1
	st.b $t2, $fp, -53
# br i1 %op8, label %label3, label %label9
	ld.b $t0, $fp, -53
	bnez $t0, .main_label3
	b .main_label9
.main_label9:
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
main_exit:
	addi.d $sp, $sp, 64
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
