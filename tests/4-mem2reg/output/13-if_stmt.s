	.text
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -32
.main_label_entry:
# %op0 = icmp ne i32 2, 0
	addi.w $t7, $zero, 2
	addi.w $t8, $zero, 0
	xor $t7, $t7, $t8
	sltu $t0, $zero, $t7
# br i1 %op0, label %label1, label %label2
	bnez $t0, .main_label1
	b .main_label2
.main_label1:
# br label %label2
	b .main_label2
.main_label2:
# ret void
	addi.w $a0, $zero, 0
	b main_exit
main_exit:
	addi.d $sp, $sp, 32
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
