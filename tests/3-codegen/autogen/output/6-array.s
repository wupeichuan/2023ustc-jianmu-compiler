	.text
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -128
.main_label_entry:
# %op0 = alloca [10 x i32]
	addi.d $t0, $fp, -64
	st.d $t0, $fp, -24
# %op1 = alloca i32
	addi.d $t0, $fp, -76
	st.d $t0, $fp, -72
# store i32 0, i32* %op1
	addi.w $t0, $zero, 0
	ld.d $t1, $fp, -72
	st.w $t0, $t1, 0
# %op2 = icmp sge i32 0, 0
	addi.w $t0, $zero, 0
	addi.w $t1, $zero, 0
	slt $t2, $t1, $t0
	xor $t3, $t0, $t1
	sltu $t4, $zero, $t3
	xori $t4, $t4, 1
	or $t5, $t2, $t4
	st.b $t5, $fp, -77
# br i1 %op2, label %label3, label %label5
	ld.b $t0, $fp, -77
	bnez $t0, .main_label3
	b .main_label5
.main_label3:
# %op4 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 0
	ld.d $t0, $fp, -24
	ld.d $t0, $t0, 0
	addi.w $t0, $t0, 0
	st.d $t0, $fp, -88
# br label %label6
	b .main_label6
.main_label5:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label6
	b .main_label6
.main_label6:
# store i32 11, i32* %op4
	addi.w $t0, $zero, 11
	ld.d $t1, $fp, -88
	st.w $t0, $t1, 0
# %op7 = icmp sge i32 4, 0
	addi.w $t0, $zero, 4
	addi.w $t1, $zero, 0
	slt $t2, $t1, $t0
	xor $t3, $t0, $t1
	sltu $t4, $zero, $t3
	xori $t4, $t4, 1
	or $t5, $t2, $t4
	st.b $t5, $fp, -89
# br i1 %op7, label %label8, label %label10
	ld.b $t0, $fp, -89
	bnez $t0, .main_label8
	b .main_label10
.main_label8:
# %op9 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 4
	ld.d $t0, $fp, -24
	ld.d $t0, $t0, 0
	addi.w $t0, $t0, 0
	st.d $t0, $fp, -104
# br label %label11
	b .main_label11
.main_label10:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label11
	b .main_label11
.main_label11:
# store i32 22, i32* %op9
	addi.w $t0, $zero, 22
	ld.d $t1, $fp, -104
	st.w $t0, $t1, 0
# %op12 = icmp sge i32 9, 0
	addi.w $t0, $zero, 9
	addi.w $t1, $zero, 0
	slt $t2, $t1, $t0
	xor $t3, $t0, $t1
	sltu $t4, $zero, $t3
	xori $t4, $t4, 1
	or $t5, $t2, $t4
	st.b $t5, $fp, -105
# br i1 %op12, label %label13, label %label15
	ld.b $t0, $fp, -105
	bnez $t0, .main_label13
	b .main_label15
.main_label13:
# %op14 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 9
	ld.d $t0, $fp, -24
	ld.d $t0, $t0, 0
	addi.w $t0, $t0, 0
	st.d $t0, $fp, -120
# br label %label16
	b .main_label16
.main_label15:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label16
	b .main_label16
.main_label16:
# store i32 33, i32* %op14
	addi.w $t0, $zero, 33
	ld.d $t1, $fp, -120
	st.w $t0, $t1, 0
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
main_exit:
	addi.d $sp, $sp, 128
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
