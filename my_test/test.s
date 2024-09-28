	.text
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -112
.main_label_entry:
# %op0 = icmp slt i32 0, 10
	addi.w $t7, $zero, 0
	addi.w $t8, $zero, 10
	slt $t0, $t7, $t8
# br i1 %op0, label %label1, label %label11
	st.b $t0, $fp, -17
# %op4 = phi i32 [ 7, %label_entry ], [ %op3, %label1 ]
	addi.w $t7, $zero, 7
	add.d $t3, $t7, $zero
# %op5 = phi i32 [ 2, %label_entry ], [ %op7, %label1 ]
	addi.w $t7, $zero, 2
	add.d $t2, $t7, $zero
# %op7 = phi i32 [ 2, %label_entry ], [ %op8, %label1 ]
	addi.w $t7, $zero, 2
	add.d $t0, $t7, $zero
# %op2 = phi i32 [ 2, %label_entry ], [ %op4, %label1 ]
	addi.w $t7, $zero, 2
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -24
# %op3 = phi i32 [ 1, %label_entry ], [ %op5, %label1 ]
	addi.w $t7, $zero, 1
	add.d $t4, $t7, $zero
# %op6 = phi i32 [ 0, %label_entry ], [ %op9, %label1 ]
	addi.w $t7, $zero, 0
	add.d $t1, $t7, $zero
# %op8 = phi i32 [ 3, %label_entry ], [ %op2, %label1 ]
	addi.w $t7, $zero, 3
	add.d $t6, $t7, $zero
	ld.b $t7, $fp, -17
	bnez $t7, .main_label1
# %op16 = phi i32 [ 2, %label_entry ], [ %op8, %label1 ]
	addi.w $t7, $zero, 2
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -76
# %op15 = phi i32 [ 2, %label_entry ], [ %op7, %label1 ]
	addi.w $t7, $zero, 2
	add.d $t3, $t7, $zero
# %op12 = phi i32 [ 2, %label_entry ], [ %op4, %label1 ]
	addi.w $t7, $zero, 2
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -60
# %op13 = phi i32 [ 1, %label_entry ], [ %op5, %label1 ]
	addi.w $t7, $zero, 1
	add.d $t5, $t7, $zero
# %op14 = phi i32 [ 7, %label_entry ], [ %op3, %label1 ]
	addi.w $t7, $zero, 7
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -68
# %op17 = phi i32 [ 3, %label_entry ], [ %op2, %label1 ]
	addi.w $t7, $zero, 3
	add.d $t1, $t7, $zero
	b .main_label11
.main_label1:
# %op2 = phi i32 [ 2, %label_entry ], [ %op4, %label1 ]
# %op3 = phi i32 [ 1, %label_entry ], [ %op5, %label1 ]
# %op4 = phi i32 [ 7, %label_entry ], [ %op3, %label1 ]
# %op5 = phi i32 [ 2, %label_entry ], [ %op7, %label1 ]
# %op6 = phi i32 [ 0, %label_entry ], [ %op9, %label1 ]
# %op7 = phi i32 [ 2, %label_entry ], [ %op8, %label1 ]
# %op8 = phi i32 [ 3, %label_entry ], [ %op2, %label1 ]
# %op9 = add i32 %op6, 1
	addi.w $t8, $zero, 1
	add.w $t1, $t1, $t8
# %op10 = icmp slt i32 %op9, 10
	addi.w $t8, $zero, 10
	slt $t5, $t1, $t8
# br i1 %op10, label %label1, label %label11
# %op6 = phi i32 [ 0, %label_entry ], [ %op9, %label1 ]
	add.d $t1, $t1, $zero
# %op8 = phi i32 [ 3, %label_entry ], [ %op2, %label1 ]
	st.w $t6, $fp, -48
	ld.w $t7, $fp, -24
	add.d $t6, $t7, $zero
# %op2 = phi i32 [ 2, %label_entry ], [ %op4, %label1 ]
	st.w $t3, $fp, -24
# %op4 = phi i32 [ 7, %label_entry ], [ %op3, %label1 ]
	st.w $t3, $fp, -32
	add.d $t3, $t4, $zero
# %op3 = phi i32 [ 1, %label_entry ], [ %op5, %label1 ]
	st.w $t4, $fp, -28
	add.d $t4, $t2, $zero
# %op5 = phi i32 [ 2, %label_entry ], [ %op7, %label1 ]
	st.w $t2, $fp, -36
	add.d $t2, $t0, $zero
# %op7 = phi i32 [ 2, %label_entry ], [ %op8, %label1 ]
	st.w $t0, $fp, -44
	ld.w $t0, $fp, -48
	bnez $t5, .main_label1
# %op16 = phi i32 [ 2, %label_entry ], [ %op8, %label1 ]
	ld.w $t7, $fp, -48
	st.w $t7, $fp, -76
# %op12 = phi i32 [ 2, %label_entry ], [ %op4, %label1 ]
	ld.w $t7, $fp, -32
	st.w $t7, $fp, -60
# %op17 = phi i32 [ 3, %label_entry ], [ %op2, %label1 ]
	ld.w $t7, $fp, -24
	add.d $t1, $t7, $zero
# %op15 = phi i32 [ 2, %label_entry ], [ %op7, %label1 ]
	ld.w $t3, $fp, -44
# %op13 = phi i32 [ 1, %label_entry ], [ %op5, %label1 ]
	ld.w $t5, $fp, -36
# %op14 = phi i32 [ 7, %label_entry ], [ %op3, %label1 ]
	ld.w $t7, $fp, -28
	st.w $t7, $fp, -68
	b .main_label11
.main_label11:
# %op12 = phi i32 [ 2, %label_entry ], [ %op4, %label1 ]
# %op13 = phi i32 [ 1, %label_entry ], [ %op5, %label1 ]
# %op14 = phi i32 [ 7, %label_entry ], [ %op3, %label1 ]
# %op15 = phi i32 [ 2, %label_entry ], [ %op7, %label1 ]
# %op16 = phi i32 [ 2, %label_entry ], [ %op8, %label1 ]
# %op17 = phi i32 [ 3, %label_entry ], [ %op2, %label1 ]
# %op18 = sub i32 %op13, %op15
	sub.w $t0, $t5, $t3
# %op19 = add i32 %op18, %op17
	add.w $t0, $t0, $t1
# %op20 = add i32 %op19, %op16
	ld.w $t8, $fp, -76
	add.w $t0, $t0, $t8
# %op21 = add i32 %op20, %op12
	ld.w $t8, $fp, -60
	add.w $t0, $t0, $t8
# %op22 = sub i32 %op21, %op14
	ld.w $t8, $fp, -68
	sub.w $t0, $t0, $t8
# call void @output(i32 %op22)
	add.d $a0, $t0, $zero
	bl output
# ret void
	addi.w $a0, $zero, 0
	b main_exit
main_exit:
	addi.d $sp, $sp, 112
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
