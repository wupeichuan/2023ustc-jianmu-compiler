	.text
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -64
.main_label_entry:
# %op0 = icmp ne i32 10, 0
	addi.w $t7, $zero, 10
	addi.w $t8, $zero, 0
	xor $t7, $t7, $t8
	sltu $t0, $zero, $t7
# br i1 %op0, label %label1, label %label5
	st.b $t0, $fp, -17
# %op2 = phi i32 [ 10, %label_entry ], [ %op3, %label13 ]
	addi.w $t7, $zero, 10
	add.d $t0, $t7, $zero
	ld.b $t7, $fp, -17
	bnez $t7, .main_label1
# %op7 = phi i32 [ 10, %label_entry ], [ %op3, %label13 ]
	addi.w $t7, $zero, 10
	add.d $t1, $t7, $zero
	b .main_label5
.main_label1:
# %op2 = phi i32 [ 10, %label_entry ], [ %op3, %label13 ]
# %op3 = sub i32 %op2, 1
	addi.w $t8, $zero, 1
	sub.w $t0, $t0, $t8
# %op4 = icmp ne i32 %op3, 0
	addi.w $t8, $zero, 0
	xor $t7, $t0, $t8
	sltu $t1, $zero, $t7
# br i1 %op4, label %label9, label %label13
	st.b $t1, $fp, -29
# %op10 = phi i32 [ %op3, %label1 ], [ %op11, %label9 ]
	add.d $t1, $t0, $zero
	ld.b $t7, $fp, -29
	bnez $t7, .main_label9
# %op14 = phi i32 [ %op3, %label1 ], [ %op11, %label9 ]
	add.d $t2, $t0, $zero
	b .main_label13
.main_label5:
# %op6 = phi i32 [ %op14, %label13 ], [ undef, %label_entry ]
# %op7 = phi i32 [ 10, %label_entry ], [ %op3, %label13 ]
# %op8 = add i32 %op7, %op6
	add.w $t0, $t1, $t2
# ret i32 %op8
	add.w $a0, $t0, $zero
	b main_exit
.main_label9:
# %op10 = phi i32 [ %op3, %label1 ], [ %op11, %label9 ]
# %op11 = sub i32 %op10, 1
	addi.w $t8, $zero, 1
	sub.w $t1, $t1, $t8
# %op12 = icmp ne i32 %op11, 0
	addi.w $t8, $zero, 0
	xor $t7, $t1, $t8
	sltu $t2, $zero, $t7
# br i1 %op12, label %label9, label %label13
# %op10 = phi i32 [ %op3, %label1 ], [ %op11, %label9 ]
	add.d $t1, $t1, $zero
	bnez $t2, .main_label9
# %op14 = phi i32 [ %op3, %label1 ], [ %op11, %label9 ]
	add.d $t2, $t1, $zero
	b .main_label13
.main_label13:
# %op14 = phi i32 [ %op3, %label1 ], [ %op11, %label9 ]
# %op15 = icmp ne i32 %op3, 0
	addi.w $t8, $zero, 0
	xor $t7, $t0, $t8
	sltu $t3, $zero, $t7
# br i1 %op15, label %label1, label %label5
# %op2 = phi i32 [ 10, %label_entry ], [ %op3, %label13 ]
	add.d $t0, $t0, $zero
	bnez $t3, .main_label1
# %op7 = phi i32 [ 10, %label_entry ], [ %op3, %label13 ]
	add.d $t1, $t0, $zero
# %op6 = phi i32 [ %op14, %label13 ], [ undef, %label_entry ]
	add.d $t2, $t2, $zero
	b .main_label5
main_exit:
	addi.d $sp, $sp, 64
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
