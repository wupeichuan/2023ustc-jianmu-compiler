	.text
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -64
.main_label_entry:
# %op0 = alloca i32
	addi.d $t8, $fp, -28
	addi.d $t7, $fp, -24
	st.d $t8, $t7, 0
# store i32 1, i32* %op0
	addi.w $t7, $zero, 1
	ld.d $t8, $fp, -24
	st.w $t7, $t8, 0
# %op1 = load i32, i32* %op0
	ld.d $t8, $fp, -24
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -32
# %op2 = icmp slt i32 %op1, 999999999
	ld.w $t7, $fp, -32
	lu12i.w $t8, 244140
	ori $t8, $t8, 2559
	slt $t7, $t7, $t8
	st.b $t7, $fp, -33
# br i1 %op2, label %label3, label %label8
	ld.b $t7, $fp, -33
	bnez $t7, .main_label3
	b .main_label8
.main_label3:
# %op4 = load i32, i32* %op0
	ld.d $t8, $fp, -24
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -40
# %op5 = add i32 %op4, 1
	ld.w $t7, $fp, -40
	addi.w $t8, $zero, 1
	add.w $t7, $t7, $t8
	st.w $t7, $fp, -44
# store i32 %op5, i32* %op0
	ld.w $t7, $fp, -44
	ld.d $t8, $fp, -24
	st.w $t7, $t8, 0
# %op6 = load i32, i32* %op0
	ld.d $t8, $fp, -24
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -48
# %op7 = icmp slt i32 %op6, 999999999
	ld.w $t7, $fp, -48
	lu12i.w $t8, 244140
	ori $t8, $t8, 2559
	slt $t7, $t7, $t8
	st.b $t7, $fp, -49
# br i1 %op7, label %label3, label %label8
	ld.b $t7, $fp, -49
	bnez $t7, .main_label3
	b .main_label8
.main_label8:
# %op9 = load i32, i32* %op0
	ld.d $t8, $fp, -24
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -56
# ret i32 %op9
	ld.w $a0, $fp, -56
	b main_exit
main_exit:
	addi.d $sp, $sp, 64
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
