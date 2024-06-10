	.text
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -48
.main_label_entry:
# %op0 = icmp slt i32 0, 10
	addi.w $t7, $zero, 0
	addi.w $t8, $zero, 10
	slt $t0, $t7, $t8
# br i1 %op0, label %label1, label %label6
	st.b $t0, $fp, -17
# %op2 = phi i32 [ 0, %label_entry ], [ %op3, %label1 ]
	addi.w $t7, $zero, 0
	add.d $t0, $t7, $zero
	ld.b $t7, $fp, -17
	bnez $t7, .main_label1
# %op7 = phi i32 [ 0, %label_entry ], [ %op3, %label1 ]
	addi.w $t7, $zero, 0
	add.d $t1, $t7, $zero
# %op8 = phi i32 [ 0, %label_entry ], [ %op4, %label1 ]
	addi.w $t7, $zero, 0
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -44
	b .main_label6
.main_label1:
# %op2 = phi i32 [ 0, %label_entry ], [ %op3, %label1 ]
# %op3 = add i32 %op2, 1
	addi.w $t8, $zero, 1
	add.w $t0, $t0, $t8
# %op4 = add i32 %op3, 2
	addi.w $t7, $zero, 2
	add.w $t7, $t0, $t7
	st.w $t7, $fp, -32
# %op5 = icmp slt i32 %op3, 10
	addi.w $t8, $zero, 10
	slt $t1, $t0, $t8
# br i1 %op5, label %label1, label %label6
# %op2 = phi i32 [ 0, %label_entry ], [ %op3, %label1 ]
	add.d $t0, $t0, $zero
	bnez $t1, .main_label1
# %op8 = phi i32 [ 0, %label_entry ], [ %op4, %label1 ]
	ld.w $t7, $fp, -32
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -44
# %op7 = phi i32 [ 0, %label_entry ], [ %op3, %label1 ]
	add.d $t1, $t0, $zero
	b .main_label6
.main_label6:
# %op7 = phi i32 [ 0, %label_entry ], [ %op3, %label1 ]
# %op8 = phi i32 [ 0, %label_entry ], [ %op4, %label1 ]
# call void @output(i32 %op7)
	add.d $a0, $t1, $zero
	bl output
# call void @output(i32 %op8)
	ld.w $a0, $fp, -44
	bl output
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
main_exit:
	addi.d $sp, $sp, 48
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
