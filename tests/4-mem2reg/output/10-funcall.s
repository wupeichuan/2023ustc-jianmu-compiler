	.text
	.globl test
	.type test, @function
test:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -48
	add.d $t0, $a0, $zero
.test_label_entry:
# %op1 = alloca i32
	addi.d $t1, $fp, -36
# store i32 %arg0, i32* %op1
	st.w $t0, $t1, 0
# ret void
	addi.w $a0, $zero, 0
	b test_exit
test_exit:
	addi.d $sp, $sp, 48
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -16
.main_label_entry:
# ret void
	addi.w $a0, $zero, 0
	b main_exit
main_exit:
	addi.d $sp, $sp, 16
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
