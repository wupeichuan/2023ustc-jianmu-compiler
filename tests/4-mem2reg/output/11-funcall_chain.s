	.text
	.globl addone
	.type addone, @function
addone:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -48
	add.d $t0, $a0, $zero
.addone_label_entry:
# %op1 = alloca i32
	addi.d $t1, $fp, -36
# store i32 %arg0, i32* %op1
	st.w $t0, $t1, 0
# %op2 = load i32, i32* %op1
	ld.w $t0, $t1, 0
# %op3 = add i32 %op2, 1
	addi.w $t8, $zero, 1
	add.w $t0, $t0, $t8
# ret i32 %op3
	add.w $a0, $t0, $zero
	b addone_exit
addone_exit:
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
	addi.d $sp, $sp, -32
.main_label_entry:
# %op0 = call i32 @addone(i32 1230)
	addi.w $a0, $zero, 1230
	bl addone
	st.w $a0, $fp, -20
# %op1 = call i32 @addone(i32 %op0)
	ld.w $a0, $fp, -20
	bl addone
	st.w $a0, $fp, -24
# %op2 = call i32 @addone(i32 %op1)
	ld.w $a0, $fp, -24
	bl addone
	st.w $a0, $fp, -28
# %op3 = call i32 @addone(i32 %op2)
	ld.w $a0, $fp, -28
	bl addone
	add.w $t0, $a0, $zero
# ret i32 %op3
	add.w $a0, $t0, $zero
	b main_exit
main_exit:
	addi.d $sp, $sp, 32
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
