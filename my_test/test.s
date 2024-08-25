	.text
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -32
.main_label_entry:
# %op0 = icmp slt i32 0, 10
	addi.w $t7, $zero, 0
	addi.w $t8, $zero, 10
	slt $t0, $t7, $t8
# br i1 %op0, label %label1, label %label5
	st.b $t0, $fp, -17
# %op2 = phi i32 [ 0, %label_entry ], [ %op3, %label1 ]
	addi.w $t7, $zero, 0
	add.d $t0, $t7, $zero
	ld.b $t7, $fp, -17
	bnez $t7, .main_label1
	b .main_label5
.main_label1:
# %op2 = phi i32 [ 0, %label_entry ], [ %op3, %label1 ]
# %op3 = add i32 %op2, 1
	addi.w $t8, $zero, 1
	add.w $t1, $t0, $t8
# %op4 = icmp slt i32 %op3, 10
	addi.w $t8, $zero, 10
	slt $t2, $t1, $t8
# br i1 %op4, label %label1, label %label5
# %op2 = phi i32 [ 0, %label_entry ], [ %op3, %label1 ]
	add.d $t0, $t1, $zero
	bnez $t2, .main_label1
	b .main_label5
.main_label5:
# call void @output(i32 %op2)
	add.d $a0, $t0, $zero
	bl output
# ret void
	addi.w $a0, $zero, 0
	b main_exit
main_exit:
	addi.d $sp, $sp, 32
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
