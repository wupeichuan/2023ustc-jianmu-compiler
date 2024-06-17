	.text
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -64
.main_label_entry:
# %op0 = icmp slt i32 0, 11
	addi.w $t7, $zero, 0
	addi.w $t8, $zero, 11
	slt $t0, $t7, $t8
# br i1 %op0, label %label1, label %label7
	st.b $t0, $fp, -17
# %op4 = phi i32 [ 0, %label_entry ], [ %op5, %label1 ]
	addi.w $t7, $zero, 0
	add.d $t2, $t7, $zero
# %op2 = phi i32 [ 2, %label_entry ], [ %op3, %label1 ]
	addi.w $t7, $zero, 2
	add.d $t1, $t7, $zero
# %op3 = phi i32 [ 1, %label_entry ], [ %op2, %label1 ]
	addi.w $t7, $zero, 1
	add.d $t0, $t7, $zero
	ld.b $t7, $fp, -17
	bnez $t7, .main_label1
# %op8 = phi i32 [ 2, %label_entry ], [ %op3, %label1 ]
	addi.w $t7, $zero, 2
	add.d $t2, $t7, $zero
	b .main_label7
.main_label1:
# %op2 = phi i32 [ 2, %label_entry ], [ %op3, %label1 ]
# %op3 = phi i32 [ 1, %label_entry ], [ %op2, %label1 ]
# %op4 = phi i32 [ 0, %label_entry ], [ %op5, %label1 ]
# %op5 = add i32 %op4, 1
	addi.w $t8, $zero, 1
	add.w $t2, $t2, $t8
# %op6 = icmp slt i32 %op5, 11
	addi.w $t8, $zero, 11
	slt $t3, $t2, $t8
# br i1 %op6, label %label1, label %label7
# %op4 = phi i32 [ 0, %label_entry ], [ %op5, %label1 ]
	add.d $t2, $t2, $zero
# %op3 = phi i32 [ 1, %label_entry ], [ %op2, %label1 ]
	st.w $t0, $fp, -28
	add.d $t0, $t1, $zero
# %op2 = phi i32 [ 2, %label_entry ], [ %op3, %label1 ]
	ld.w $t1, $fp, -28
	bnez $t3, .main_label1
# %op8 = phi i32 [ 2, %label_entry ], [ %op3, %label1 ]
	ld.w $t2, $fp, -28
	b .main_label7
.main_label7:
# %op8 = phi i32 [ 2, %label_entry ], [ %op3, %label1 ]
# %op9 = phi i32 [ 1, %label_entry ], [ %op2, %label1 ]
# %op10 = sub i32 %op9, %op8
	sub.w $t0, $t0, $t2
# call void @output(i32 %op10)
	add.d $a0, $t0, $zero
	bl output
# ret void
	addi.w $a0, $zero, 0
	b main_exit
main_exit:
	addi.d $sp, $sp, 64
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
