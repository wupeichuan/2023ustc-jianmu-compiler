	.text
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -32
.main_label_entry:
# %op0 = add i32 1000, 234
	addi.w $t7, $zero, 1000
	addi.w $t8, $zero, 234
	add.w $t0, $t7, $t8
# ret i32 %op0
	add.w $a0, $t0, $zero
	b main_exit
main_exit:
	addi.d $sp, $sp, 32
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
