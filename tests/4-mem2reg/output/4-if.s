	.text
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -32
.main_label_entry:
# %op0 = icmp sgt i32 11, 22
	addi.w $t7, $zero, 11
	addi.w $t8, $zero, 22
	slt $t0, $t8, $t7
# br i1 %op0, label %label1, label %label3
	bnez $t0, .main_label1
	b .main_label3
.main_label1:
# %op2 = icmp sgt i32 11, 33
	addi.w $t7, $zero, 11
	addi.w $t8, $zero, 33
	slt $t0, $t8, $t7
# br i1 %op2, label %label6, label %label7
	bnez $t0, .main_label6
	b .main_label7
.main_label3:
# %op4 = icmp slt i32 33, 22
	addi.w $t7, $zero, 33
	addi.w $t8, $zero, 22
	slt $t7, $t7, $t8
	st.b $t7, $fp, -19
# br i1 %op4, label %label9, label %label10
	ld.b $t7, $fp, -19
	bnez $t7, .main_label9
	b .main_label10
.main_label5:
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
.main_label6:
# call void @output(i32 11)
	addi.w $a0, $zero, 11
	bl output
# br label %label8
	b .main_label8
.main_label7:
# call void @output(i32 33)
	addi.w $a0, $zero, 33
	bl output
# br label %label8
	b .main_label8
.main_label8:
# br label %label5
	b .main_label5
.main_label9:
# call void @output(i32 22)
	addi.w $a0, $zero, 22
	bl output
# br label %label11
	b .main_label11
.main_label10:
# call void @output(i32 33)
	addi.w $a0, $zero, 33
	bl output
# br label %label11
	b .main_label11
.main_label11:
# br label %label5
	b .main_label5
main_exit:
	addi.d $sp, $sp, 32
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
