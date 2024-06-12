	.text
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -48
.main_label_entry:
# %op0 = icmp slt i32 1, 999999999
	addi.w $t7, $zero, 1
	lu12i.w $t8, 244140
	ori $t8, $t8, 2559
	slt $t7, $t7, $t8
	st.b $t7, $fp, -17
# br i1 %op0, label %label1, label %label5
# %op2 = phi i32 [ 1, %label_entry ], [ %op3, %label1 ]
	addi.w $t7, $zero, 1
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -24
	ld.b $t7, $fp, -17
	bnez $t7, .main_label1
# %op6 = phi i32 [ 1, %label_entry ], [ %op3, %label1 ]
	addi.w $t7, $zero, 1
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -36
	b .main_label5
.main_label1:
# %op2 = phi i32 [ 1, %label_entry ], [ %op3, %label1 ]
# %op3 = add i32 %op2, 1
	ld.w $t7, $fp, -24
	addi.w $t8, $zero, 1
	add.w $t7, $t7, $t8
	st.w $t7, $fp, -28
# %op4 = icmp slt i32 %op3, 999999999
	ld.w $t7, $fp, -28
	lu12i.w $t8, 244140
	ori $t8, $t8, 2559
	slt $t7, $t7, $t8
	st.b $t7, $fp, -29
# br i1 %op4, label %label1, label %label5
# %op2 = phi i32 [ 1, %label_entry ], [ %op3, %label1 ]
	ld.w $t7, $fp, -28
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -24
	ld.b $t7, $fp, -29
	bnez $t7, .main_label1
# %op6 = phi i32 [ 1, %label_entry ], [ %op3, %label1 ]
	ld.w $t7, $fp, -28
	add.d $t7, $t7, $zero
	st.w $t7, $fp, -36
	b .main_label5
.main_label5:
# %op6 = phi i32 [ 1, %label_entry ], [ %op3, %label1 ]
# ret i32 %op6
	ld.w $a0, $fp, -36
	b main_exit
main_exit:
	addi.d $sp, $sp, 48
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
