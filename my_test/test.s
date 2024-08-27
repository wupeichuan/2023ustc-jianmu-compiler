	.text
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -80
.main_label_entry:
# %op0 = icmp slt i32 0, 10
	addi.w $t7, $zero, 0
	addi.w $t8, $zero, 10
	slt $t0, $t7, $t8
# br i1 %op0, label %label1, label %label8
	st.b $t0, $fp, -17
# %op4 = phi i32 [ 0, %label_entry ], [ %op6, %label1 ]
	addi.w $t7, $zero, 0
	add.d $t0, $t7, $zero
# %op5 = phi i32 [ 2, %label_entry ], [ %op3, %label1 ]
	addi.w $t7, $zero, 2
	add.d $t3, $t7, $zero
# %op2 = phi i32 [ 2, %label_entry ], [ %op5, %label1 ]
	addi.w $t7, $zero, 2
	add.d $t2, $t7, $zero
# %op3 = phi i32 [ 1, %label_entry ], [ %op2, %label1 ]
	addi.w $t7, $zero, 1
	add.d $t1, $t7, $zero
	ld.b $t7, $fp, -17
	bnez $t7, .main_label1
# %op11 = phi i32 [ 2, %label_entry ], [ %op3, %label1 ]
	addi.w $t7, $zero, 2
	add.d $t0, $t7, $zero
# %op9 = phi i32 [ 2, %label_entry ], [ %op5, %label1 ]
	addi.w $t7, $zero, 2
	add.d $t4, $t7, $zero
# %op10 = phi i32 [ 1, %label_entry ], [ %op2, %label1 ]
	addi.w $t7, $zero, 1
	add.d $t3, $t7, $zero
# %op12 = phi i32 [ 3, %label_entry ], [ %op3, %label1 ]
	addi.w $t7, $zero, 3
	add.d $t5, $t7, $zero
	b .main_label8
.main_label1:
# %op2 = phi i32 [ 2, %label_entry ], [ %op5, %label1 ]
# %op3 = phi i32 [ 1, %label_entry ], [ %op2, %label1 ]
# %op4 = phi i32 [ 0, %label_entry ], [ %op6, %label1 ]
# %op5 = phi i32 [ 2, %label_entry ], [ %op3, %label1 ]
# %op6 = add i32 %op4, 1
	addi.w $t8, $zero, 1
	add.w $t0, $t0, $t8
# %op7 = icmp slt i32 %op6, 10
	addi.w $t8, $zero, 10
	slt $t4, $t0, $t8
# br i1 %op7, label %label1, label %label8
# %op4 = phi i32 [ 0, %label_entry ], [ %op6, %label1 ]
	add.d $t0, $t0, $zero
# %op5 = phi i32 [ 2, %label_entry ], [ %op3, %label1 ]
	st.w $t3, $fp, -36
	add.d $t3, $t1, $zero
# %op3 = phi i32 [ 1, %label_entry ], [ %op2, %label1 ]
	st.w $t1, $fp, -28
	add.d $t1, $t2, $zero
# %op2 = phi i32 [ 2, %label_entry ], [ %op5, %label1 ]
	st.w $t2, $fp, -24
	ld.w $t2, $fp, -36
	bnez $t4, .main_label1
# %op9 = phi i32 [ 2, %label_entry ], [ %op5, %label1 ]
	ld.w $t4, $fp, -36
# %op10 = phi i32 [ 1, %label_entry ], [ %op2, %label1 ]
	st.w $t3, $fp, -36
	ld.w $t3, $fp, -24
# %op12 = phi i32 [ 3, %label_entry ], [ %op3, %label1 ]
	ld.w $t5, $fp, -28
# %op11 = phi i32 [ 2, %label_entry ], [ %op3, %label1 ]
	ld.w $t0, $fp, -28
	b .main_label8
.main_label8:
# %op9 = phi i32 [ 2, %label_entry ], [ %op5, %label1 ]
# %op10 = phi i32 [ 1, %label_entry ], [ %op2, %label1 ]
# %op11 = phi i32 [ 2, %label_entry ], [ %op3, %label1 ]
# %op12 = phi i32 [ 3, %label_entry ], [ %op3, %label1 ]
# %op13 = sub i32 %op10, %op9
	sub.w $t1, $t3, $t4
# %op14 = add i32 %op13, %op12
	add.w $t1, $t1, $t5
# %op15 = add i32 %op14, %op11
	add.w $t0, $t1, $t0
# call void @output(i32 %op15)
	add.d $a0, $t0, $zero
	bl output
# ret void
	addi.w $a0, $zero, 0
	b main_exit
main_exit:
	addi.d $sp, $sp, 80
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
