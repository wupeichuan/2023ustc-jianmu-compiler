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
	sltu $t0, $zero, $t7
# br i1 %op0, label %label1, label %label7
	st.b $t0, $fp, -17
# %op3 = phi i32 [ 10, %label_entry ], [ %op5, %label15 ]
	addi.w $t7, $zero, 10
	add.d $t1, $t7, $zero
# %op4 = phi i32 [ 0, %label_entry ], [ %op17, %label15 ]
	addi.w $t7, $zero, 0
	add.d $t0, $t7, $zero
# %op2 = phi i32 [ 0, %label_entry ], [ %op16, %label15 ]
	addi.w $t7, $zero, 0
	add.d $t2, $t7, $zero
	ld.b $t7, $fp, -17
	bnez $t7, .main_label1
# %op8 = phi i32 [ 0, %label_entry ], [ %op16, %label15 ]
	addi.w $t7, $zero, 0
	add.d $t1, $t7, $zero
	b .main_label7
.main_label1:
# %op2 = phi i32 [ 0, %label_entry ], [ %op16, %label15 ]
# %op3 = phi i32 [ 10, %label_entry ], [ %op5, %label15 ]
# %op4 = phi i32 [ 0, %label_entry ], [ %op17, %label15 ]
# %op5 = sub i32 %op3, 1
	addi.w $t8, $zero, 1
	sub.w $t1, $t1, $t8
# %op6 = icmp slt i32 %op5, 5
	addi.w $t8, $zero, 5
	slt $t3, $t1, $t8
# br i1 %op6, label %label11, label %label13
	bnez $t3, .main_label11
	b .main_label13
.main_label7:
# %op8 = phi i32 [ 0, %label_entry ], [ %op16, %label15 ]
# %op9 = phi i32 [ 0, %label_entry ], [ %op17, %label15 ]
# %op10 = add i32 %op8, %op9
	add.w $t0, $t1, $t0
# ret i32 %op10
	add.w $a0, $t0, $zero
	b main_exit
.main_label11:
# %op12 = add i32 %op2, %op5
	add.w $t3, $t2, $t1
# br label %label15
# %op16 = phi i32 [ %op12, %label11 ], [ %op2, %label13 ]
	add.d $t2, $t3, $zero
# %op17 = phi i32 [ %op4, %label11 ], [ %op14, %label13 ]
	add.d $t5, $t0, $zero
	b .main_label15
.main_label13:
# %op14 = add i32 %op4, %op5
	add.w $t4, $t0, $t1
# br label %label15
# %op16 = phi i32 [ %op12, %label11 ], [ %op2, %label13 ]
	add.d $t2, $t2, $zero
# %op17 = phi i32 [ %op4, %label11 ], [ %op14, %label13 ]
	add.d $t5, $t4, $zero
	b .main_label15
.main_label15:
# %op16 = phi i32 [ %op12, %label11 ], [ %op2, %label13 ]
# %op17 = phi i32 [ %op4, %label11 ], [ %op14, %label13 ]
# %op18 = icmp ne i32 %op5, 0
	addi.w $t8, $zero, 0
	xor $t7, $t1, $t8
	sltu $t0, $zero, $t7
# br i1 %op18, label %label1, label %label7
	st.b $t0, $fp, -69
# %op3 = phi i32 [ 10, %label_entry ], [ %op5, %label15 ]
	add.d $t1, $t1, $zero
# %op2 = phi i32 [ 0, %label_entry ], [ %op16, %label15 ]
	st.w $t2, $fp, -64
	add.d $t2, $t2, $zero
# %op4 = phi i32 [ 0, %label_entry ], [ %op17, %label15 ]
	add.d $t0, $t5, $zero
	ld.b $t7, $fp, -69
	bnez $t7, .main_label1
# %op8 = phi i32 [ 0, %label_entry ], [ %op16, %label15 ]
	ld.w $t1, $fp, -64
	b .main_label7
main_exit:
	addi.d $sp, $sp, 80
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
