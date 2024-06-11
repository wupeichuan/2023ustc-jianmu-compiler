# Global variables
	.text
	.section .bss, "aw", @nobits
	.globl a
	.type a, @object
	.size a, 4
a:
	.space 4
	.text
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -32
.main_label_entry:
# store i32 10, i32* @a
	addi.w $t7, $zero, 10
	la.local $t8, a
	st.w $t7, $t8, 0
# %op0 = load i32, i32* @a
	la.local $t8, a
	ld.w $t0, $t8, 0
# ret i32 %op0
	add.w $a0, $t0, $zero
	b main_exit
main_exit:
	addi.d $sp, $sp, 32
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
