	.text
	.globl addone
	.type addone, @function
addone:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -48
	st.w $a0, $fp, -20
.addone_label_entry:
# %op1 = alloca i32
	addi.d $t8, $fp, -36
	addi.d $t7, $fp, -32
	st.d $t8, $t7, 0
# store i32 %arg0, i32* %op1
	ld.w $t7, $fp, -20
	ld.d $t8, $fp, -32
	st.w $t7, $t8, 0
# %op2 = load i32, i32* %op1
	ld.d $t8, $fp, -32
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -40
# %op3 = add i32 %op2, 1
	ld.w $t7, $fp, -40
	addi.w $t8, $zero, 1
	add.w $t7, $t7, $t8
	st.w $t7, $fp, -44
# ret i32 %op3
	ld.w $a0, $fp, -44
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
	st.w $a0, $fp, -32
# ret i32 %op3
	ld.w $a0, $fp, -32
	b main_exit
main_exit:
	addi.d $sp, $sp, 32
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
