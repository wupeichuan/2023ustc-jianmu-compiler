	.text
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -32
.main_label_entry:
# %op0 = icmp ne i32 10, 0
	addi.w $t7, $zero, 10
	addi.w $t8, $zero, 0
	xor $t7, $t7, $t8
	sltu $t7, $zero, $t7
	st.b $t7, $fp, -17
# br i1 %op0, label %label1, label %label5
# %op2 = phi i32 [ 10, %label_entry ], [ %op3, %label1 ]
	addi.w $t7, $zero, 10
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -24
	ld.b $t7, $fp, -17
	bnez $t7, .main_label1
	b .main_label5
.main_label1:
# %op2 = phi i32 [ 10, %label_entry ], [ %op3, %label1 ]
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
# br i1 %op4, label %label1, label %label5
# %op2 = phi i32 [ 10, %label_entry ], [ %op3, %label1 ]
	ld.w $t7, $fp, -28
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -24
	ld.b $t7, $fp, -29
	bnez $t7, .main_label1
	b .main_label5
.main_label5:
# ret void
	addi.w $a0, $zero, 0
	b main_exit
main_exit:
	addi.d $sp, $sp, 32
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
