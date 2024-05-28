# Global variables
	.text
	.section .bss, "aw", @nobits
	.globl a
	.type a, @object
	.size a, 4
a:
	.space 4
	.text
	.globl GlobalAssign
	.type GlobalAssign, @function
GlobalAssign:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -16
.GlobalAssign_label_entry:
# store i32 10, i32* @a
	addi.w $t0, $zero, 10
	la.local $t1, a
	st.w $t0, $t1, 0
# ret void
	addi.w $a0, $zero, 0
	b GlobalAssign_exit
GlobalAssign_exit:
	addi.d $sp, $sp, 16
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -32
.main_label_entry:
# %op0 = alloca i32
	addi.d $t8, $fp, -28
	addi.d $t7, $fp, -24
	st.d $t8, $t7, 0
# call void @GlobalAssign()
	bl GlobalAssign
# store i32 20, i32* %op0
	addi.w $t0, $zero, 20
	ld.d $t1, $fp, -24
	st.w $t0, $t1, 0
# %op1 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -32
# ret i32 %op1
	ld.w $a0, $fp, -32
	b main_exit
main_exit:
	addi.d $sp, $sp, 32
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
