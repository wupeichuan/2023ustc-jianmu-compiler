	.text
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -80
.main_label_entry:
# %op0 = icmp ne i32 10, 0
	addi.w $t7, $zero, 10
	addi.w $t8, $zero, 0
	xor $t7, $t7, $t8
	sltu $t7, $zero, $t7
	st.b $t7, $fp, -17
# br i1 %op0, label %label1, label %label7
# %op4 = phi i32 [ 0, %label_entry ], [ %op17, %label15 ]
	addi.w $t7, $zero, 0
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -32
# %op2 = phi i32 [ 0, %label_entry ], [ %op16, %label15 ]
	addi.w $t7, $zero, 0
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -24
# %op3 = phi i32 [ 10, %label_entry ], [ %op5, %label15 ]
	addi.w $t7, $zero, 10
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -28
	ld.b $t7, $fp, -17
	bnez $t7, .main_label1
# %op9 = phi i32 [ 0, %label_entry ], [ %op17, %label15 ]
	addi.w $t7, $zero, 0
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -48
# %op8 = phi i32 [ 0, %label_entry ], [ %op16, %label15 ]
	addi.w $t7, $zero, 0
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -44
	b .main_label7
.main_label1:
# %op2 = phi i32 [ 0, %label_entry ], [ %op16, %label15 ]
# %op3 = phi i32 [ 10, %label_entry ], [ %op5, %label15 ]
# %op4 = phi i32 [ 0, %label_entry ], [ %op17, %label15 ]
# %op5 = sub i32 %op3, 1
	ld.w $t7, $fp, -28
	addi.w $t8, $zero, 1
	sub.w $t7, $t7, $t8
	st.w $t7, $fp, -36
# %op6 = icmp slt i32 %op5, 5
	ld.w $t7, $fp, -36
	addi.w $t8, $zero, 5
	slt $t7, $t7, $t8
	st.b $t7, $fp, -37
# br i1 %op6, label %label11, label %label13
	ld.b $t7, $fp, -37
	bnez $t7, .main_label11
	b .main_label13
.main_label7:
# %op8 = phi i32 [ 0, %label_entry ], [ %op16, %label15 ]
# %op9 = phi i32 [ 0, %label_entry ], [ %op17, %label15 ]
# %op10 = add i32 %op8, %op9
	ld.w $t7, $fp, -44
	ld.w $t8, $fp, -48
	add.w $t7, $t7, $t8
	st.w $t7, $fp, -52
# ret i32 %op10
	ld.w $a0, $fp, -52
	b main_exit
.main_label11:
# %op12 = add i32 %op2, %op5
	ld.w $t7, $fp, -24
	ld.w $t8, $fp, -36
	add.w $t7, $t7, $t8
	st.w $t7, $fp, -56
# br label %label15
# %op16 = phi i32 [ %op12, %label11 ], [ %op2, %label13 ]
	ld.w $t7, $fp, -56
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -64
# %op17 = phi i32 [ %op4, %label11 ], [ %op14, %label13 ]
	ld.w $t7, $fp, -32
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -68
	b .main_label15
.main_label13:
# %op14 = add i32 %op4, %op5
	ld.w $t7, $fp, -32
	ld.w $t8, $fp, -36
	add.w $t7, $t7, $t8
	st.w $t7, $fp, -60
# br label %label15
# %op16 = phi i32 [ %op12, %label11 ], [ %op2, %label13 ]
	ld.w $t7, $fp, -24
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -64
# %op17 = phi i32 [ %op4, %label11 ], [ %op14, %label13 ]
	ld.w $t7, $fp, -60
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -68
	b .main_label15
.main_label15:
# %op16 = phi i32 [ %op12, %label11 ], [ %op2, %label13 ]
# %op17 = phi i32 [ %op4, %label11 ], [ %op14, %label13 ]
# %op18 = icmp ne i32 %op5, 0
	ld.w $t7, $fp, -36
	addi.w $t8, $zero, 0
	xor $t7, $t7, $t8
	sltu $t7, $zero, $t7
	st.b $t7, $fp, -69
# br i1 %op18, label %label1, label %label7
# %op2 = phi i32 [ 0, %label_entry ], [ %op16, %label15 ]
	ld.w $t7, $fp, -64
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -24
# %op3 = phi i32 [ 10, %label_entry ], [ %op5, %label15 ]
	ld.w $t7, $fp, -36
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -28
# %op4 = phi i32 [ 0, %label_entry ], [ %op17, %label15 ]
	ld.w $t7, $fp, -68
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -32
	ld.b $t7, $fp, -69
	bnez $t7, .main_label1
# %op8 = phi i32 [ 0, %label_entry ], [ %op16, %label15 ]
	ld.w $t7, $fp, -64
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -44
# %op9 = phi i32 [ 0, %label_entry ], [ %op17, %label15 ]
	ld.w $t7, $fp, -68
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -48
	b .main_label7
main_exit:
	addi.d $sp, $sp, 80
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
