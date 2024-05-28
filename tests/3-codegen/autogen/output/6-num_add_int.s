	.text
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -48
.main_label_entry:
# %op0 = alloca i32
	addi.d $t8, $fp, -28
	addi.d $t7, $fp, -24
	st.d $t8, $t7, 0
# %op1 = add i32 1000, 234
	addi.w $t0, $zero, 1000
	addi.w $t1, $zero, 234
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -32
# store i32 %op1, i32* %op0
	ld.w $t0, $fp, -32
	ld.d $t1, $fp, -24
	st.w $t0, $t1, 0
# %op2 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -36
# ret i32 %op2
	ld.w $a0, $fp, -36
	b main_exit
main_exit:
	addi.d $sp, $sp, 48
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
