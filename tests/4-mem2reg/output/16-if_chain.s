	.text
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -32
.main_label_entry:
# %op0 = icmp ne i32 1, 0
	addi.w $t7, $zero, 1
	addi.w $t8, $zero, 0
	xor $t7, $t7, $t8
	sltu $t0, $zero, $t7
# br i1 %op0, label %label1, label %label3
	bnez $t0, .main_label1
# %op4 = phi i32 [ 2, %label_entry ], [ %op8, %label7 ]
	addi.w $t7, $zero, 2
	add.d $t0, $t7, $zero
	b .main_label3
.main_label1:
# %op2 = icmp ne i32 0, 0
	addi.w $t7, $zero, 0
	addi.w $t8, $zero, 0
	xor $t7, $t7, $t8
	sltu $t0, $zero, $t7
# br i1 %op2, label %label5, label %label6
	bnez $t0, .main_label5
	b .main_label6
.main_label3:
# %op4 = phi i32 [ 2, %label_entry ], [ %op8, %label7 ]
# ret i32 %op4
	add.w $a0, $t0, $zero
	b main_exit
.main_label5:
# br label %label7
# %op8 = phi i32 [ 4, %label5 ], [ 3, %label6 ]
	addi.w $t7, $zero, 4
	add.d $t0, $t7, $zero
	b .main_label7
.main_label6:
# br label %label7
# %op8 = phi i32 [ 4, %label5 ], [ 3, %label6 ]
	addi.w $t7, $zero, 3
	add.d $t0, $t7, $zero
	b .main_label7
.main_label7:
# %op8 = phi i32 [ 4, %label5 ], [ 3, %label6 ]
# br label %label3
# %op4 = phi i32 [ 2, %label_entry ], [ %op8, %label7 ]
	add.d $t0, $t0, $zero
	b .main_label3
main_exit:
	addi.d $sp, $sp, 32
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
