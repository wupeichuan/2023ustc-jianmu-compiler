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
# %op2 = phi i32 [ 0, %label_entry ], [ %op3, %label1 ]
	addi.w $t7, $zero, 0
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -24
	bnez $t0, .main_label1
	b .main_label5
.main_label1:
# %op2 = phi i32 [ 0, %label_entry ], [ %op3, %label1 ]
# call void @output(i32 %op2)
	ld.w $a0, $fp, -24
	bl output
# %op3 = add i32 %op2, 1
	ld.w $t7, $fp, -24
	addi.w $t8, $zero, 1
	add.w $t0, $t7, $t8
# %op4 = icmp slt i32 %op3, 10
	addi.w $t8, $zero, 10
	slt $t1, $t0, $t8
# br i1 %op4, label %label1, label %label5
# %op2 = phi i32 [ 0, %label_entry ], [ %op3, %label1 ]
	st.w $t0, $fp, -24
	bnez $t1, .main_label1
	b .main_label5
.main_label5:
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
main_exit:
	addi.d $sp, $sp, 32
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
