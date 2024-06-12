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
	sltu $t7, $zero, $t7
	st.b $t7, $fp, -17
# br i1 %op0, label %label1, label %label5
# %op2 = phi i32 [ 10, %label_entry ], [ %op3, %label13 ]
	addi.w $t7, $zero, 10
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -24
	ld.b $t7, $fp, -17
	bnez $t7, .main_label1
# %op7 = phi i32 [ 10, %label_entry ], [ %op3, %label13 ]
	addi.w $t7, $zero, 10
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -40
	b .main_label5
.main_label1:
# %op2 = phi i32 [ 10, %label_entry ], [ %op3, %label13 ]
# %op3 = sub i32 %op2, 1
	ld.w $t7, $fp, -24
	addi.w $t8, $zero, 1
	sub.w $t7, $t7, $t8
	st.w $t7, $fp, -28
# %op4 = icmp ne i32 %op3, 0
	ld.w $t7, $fp, -28
	addi.w $t8, $zero, 0
	xor $t7, $t7, $t8
	sltu $t7, $zero, $t7
	st.b $t7, $fp, -29
# br i1 %op4, label %label9, label %label13
# %op10 = phi i32 [ %op3, %label1 ], [ %op11, %label9 ]
	ld.w $t7, $fp, -28
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -48
	ld.b $t7, $fp, -29
	bnez $t7, .main_label9
# %op14 = phi i32 [ %op3, %label1 ], [ %op11, %label9 ]
	ld.w $t7, $fp, -28
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -60
	b .main_label13
.main_label5:
# %op6 = phi i32 [ %op14, %label13 ], [ undef, %label_entry ]
# %op7 = phi i32 [ 10, %label_entry ], [ %op3, %label13 ]
# %op8 = add i32 %op7, %op6
	ld.w $t7, $fp, -40
	ld.w $t8, $fp, -36
	add.w $t7, $t7, $t8
	st.w $t7, $fp, -44
# ret i32 %op8
	ld.w $a0, $fp, -44
	b main_exit
.main_label9:
# %op10 = phi i32 [ %op3, %label1 ], [ %op11, %label9 ]
# %op11 = sub i32 %op10, 1
	ld.w $t7, $fp, -48
	addi.w $t8, $zero, 1
	sub.w $t7, $t7, $t8
	st.w $t7, $fp, -52
# %op12 = icmp ne i32 %op11, 0
	ld.w $t7, $fp, -52
	addi.w $t8, $zero, 0
	xor $t7, $t7, $t8
	sltu $t7, $zero, $t7
	st.b $t7, $fp, -53
# br i1 %op12, label %label9, label %label13
# %op10 = phi i32 [ %op3, %label1 ], [ %op11, %label9 ]
	ld.w $t7, $fp, -52
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -48
	ld.b $t7, $fp, -53
	bnez $t7, .main_label9
# %op14 = phi i32 [ %op3, %label1 ], [ %op11, %label9 ]
	ld.w $t7, $fp, -52
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -60
	b .main_label13
.main_label13:
# %op14 = phi i32 [ %op3, %label1 ], [ %op11, %label9 ]
# %op15 = icmp ne i32 %op3, 0
	ld.w $t7, $fp, -28
	addi.w $t8, $zero, 0
	xor $t7, $t7, $t8
	sltu $t7, $zero, $t7
	st.b $t7, $fp, -61
# br i1 %op15, label %label1, label %label5
# %op2 = phi i32 [ 10, %label_entry ], [ %op3, %label13 ]
	ld.w $t7, $fp, -28
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -24
	ld.b $t7, $fp, -61
	bnez $t7, .main_label1
# %op7 = phi i32 [ 10, %label_entry ], [ %op3, %label13 ]
	ld.w $t7, $fp, -28
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -40
# %op6 = phi i32 [ %op14, %label13 ], [ undef, %label_entry ]
	ld.w $t7, $fp, -60
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -36
	b .main_label5
main_exit:
	addi.d $sp, $sp, 64
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
