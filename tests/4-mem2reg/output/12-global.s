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
	la.local $t8, seed
	ld.w $t0, $t8, 0
# %op1 = mul i32 %op0, 1103515245
	lu12i.w $t8, 269412
	ori $t8, $t8, 3693
	mul.w $t0, $t0, $t8
# %op2 = add i32 %op1, 12345
	lu12i.w $t8, 3
	ori $t8, $t8, 57
	add.w $t0, $t0, $t8
# store i32 %op2, i32* @seed
	la.local $t7, seed
	st.w $t0, $t7, 0
# %op3 = load i32, i32* @seed
	la.local $t8, seed
	ld.w $t0, $t8, 0
# ret i32 %op3
	add.w $a0, $t0, $zero
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
	add.w $t0, $a0, $zero
# %op1 = icmp sgt i32 %op0, 0
	addi.w $t8, $zero, 0
	slt $t0, $t8, $t0
# br i1 %op1, label %label2, label %label3
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
	addi.d $sp, $sp, -64
.returnToZeroSteps_label_entry:
# %op0 = icmp slt i32 0, 20
	addi.w $t7, $zero, 0
	addi.w $t8, $zero, 20
	slt $t0, $t7, $t8
# br i1 %op0, label %label1, label %label6
# %op3 = phi i32 [ 0, %label_entry ], [ %op12, %label16 ]
	addi.w $t7, $zero, 0
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -28
# %op2 = phi i32 [ 0, %label_entry ], [ %op13, %label16 ]
	addi.w $t7, $zero, 0
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -24
	bnez $t0, .returnToZeroSteps_label1
	b .returnToZeroSteps_label6
.returnToZeroSteps_label1:
# %op2 = phi i32 [ 0, %label_entry ], [ %op13, %label16 ]
# %op3 = phi i32 [ 0, %label_entry ], [ %op12, %label16 ]
# %op4 = call i32 @randBin()
	bl randBin
	add.w $t0, $a0, $zero
# %op5 = icmp ne i32 %op4, 0
	addi.w $t8, $zero, 0
	xor $t7, $t0, $t8
	sltu $t0, $zero, $t7
# br i1 %op5, label %label7, label %label9
	bnez $t0, .returnToZeroSteps_label7
	b .returnToZeroSteps_label9
.returnToZeroSteps_label6:
# ret i32 20
	addi.w $a0, $zero, 20
	b returnToZeroSteps_exit
.returnToZeroSteps_label7:
# %op8 = add i32 %op3, 1
	ld.w $t7, $fp, -28
	addi.w $t8, $zero, 1
	add.w $t0, $t7, $t8
# br label %label11
# %op12 = phi i32 [ %op8, %label7 ], [ %op10, %label9 ]
	add.d $t7, $t0, $zero
	st.w $t7, $fp, -48
	b .returnToZeroSteps_label11
.returnToZeroSteps_label9:
# %op10 = sub i32 %op3, 1
	ld.w $t7, $fp, -28
	addi.w $t8, $zero, 1
	sub.w $t7, $t7, $t8
	st.w $t7, $fp, -44
# br label %label11
# %op12 = phi i32 [ %op8, %label7 ], [ %op10, %label9 ]
	ld.w $t7, $fp, -44
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -48
	b .returnToZeroSteps_label11
.returnToZeroSteps_label11:
# %op12 = phi i32 [ %op8, %label7 ], [ %op10, %label9 ]
# %op13 = add i32 %op2, 1
	ld.w $t7, $fp, -24
	addi.w $t8, $zero, 1
	add.w $t7, $t7, $t8
	st.w $t7, $fp, -52
# %op14 = icmp eq i32 %op12, 0
	ld.w $t7, $fp, -48
	addi.w $t8, $zero, 0
	xor $t7, $t7, $t8
	sltu $t7, $zero, $t7
	xori $t1, $t7, 1
# br i1 %op14, label %label15, label %label16
	bnez $t1, .returnToZeroSteps_label15
	b .returnToZeroSteps_label16
.returnToZeroSteps_label15:
# ret i32 %op13
	ld.w $a0, $fp, -52
	b returnToZeroSteps_exit
.returnToZeroSteps_label16:
# %op17 = icmp slt i32 %op13, 20
	ld.w $t7, $fp, -52
	addi.w $t8, $zero, 20
	slt $t1, $t7, $t8
# br i1 %op17, label %label1, label %label6
# %op2 = phi i32 [ 0, %label_entry ], [ %op13, %label16 ]
	ld.w $t7, $fp, -52
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -24
# %op3 = phi i32 [ 0, %label_entry ], [ %op12, %label16 ]
	ld.w $t7, $fp, -48
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -28
	bnez $t1, .returnToZeroSteps_label1
	b .returnToZeroSteps_label6
returnToZeroSteps_exit:
	addi.d $sp, $sp, 64
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -48
.main_label_entry:
# store i32 3407, i32* @seed
	lu12i.w $t7, 0
	ori $t7, $t7, 3407
	la.local $t8, seed
	st.w $t7, $t8, 0
# %op0 = icmp slt i32 0, 20
	addi.w $t7, $zero, 0
	addi.w $t8, $zero, 20
	slt $t0, $t7, $t8
# br i1 %op0, label %label1, label %label6
# %op2 = phi i32 [ 0, %label_entry ], [ %op4, %label1 ]
	addi.w $t7, $zero, 0
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -24
	bnez $t0, .main_label1
	b .main_label6
.main_label1:
# %op2 = phi i32 [ 0, %label_entry ], [ %op4, %label1 ]
# %op3 = call i32 @returnToZeroSteps()
	bl returnToZeroSteps
	add.w $t0, $a0, $zero
# call void @output(i32 %op3)
	add.d $a0, $t0, $zero
	bl output
# %op4 = add i32 %op2, 1
	ld.w $t7, $fp, -24
	addi.w $t8, $zero, 1
	add.w $t0, $t7, $t8
# %op5 = icmp slt i32 %op4, 20
	addi.w $t8, $zero, 20
	slt $t1, $t0, $t8
# br i1 %op5, label %label1, label %label6
# %op2 = phi i32 [ 0, %label_entry ], [ %op4, %label1 ]
	add.d $t7, $t0, $zero
	st.w $t7, $fp, -24
	bnez $t1, .main_label1
	b .main_label6
.main_label6:
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
main_exit:
	addi.d $sp, $sp, 48
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
