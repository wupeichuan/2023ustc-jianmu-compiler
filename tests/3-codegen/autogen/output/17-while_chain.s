	.text
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -112
.main_label_entry:
# %op0 = alloca i32
	addi.d $t8, $fp, -28
	addi.d $t7, $fp, -24
	st.d $t8, $t7, 0
# %op1 = alloca i32
	addi.d $t8, $fp, -44
	addi.d $t7, $fp, -40
	st.d $t8, $t7, 0
# store i32 10, i32* %op0
	addi.w $t0, $zero, 10
	ld.d $t1, $fp, -24
	st.w $t0, $t1, 0
# %op2 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -48
# %op3 = icmp ne i32 %op2, 0
	ld.w $t0, $fp, -48
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t3, $zero, $t2
	st.b $t3, $fp, -49
# br i1 %op3, label %label4, label %label10
	ld.b $t0, $fp, -49
	bnez $t0, .main_label4
	b .main_label10
.main_label4:
# %op5 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -56
# %op6 = sub i32 %op5, 1
	ld.w $t0, $fp, -56
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -60
# store i32 %op6, i32* %op0
	ld.w $t0, $fp, -60
	ld.d $t1, $fp, -24
	st.w $t0, $t1, 0
# %op7 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -64
# store i32 %op7, i32* %op1
	ld.w $t0, $fp, -64
	ld.d $t1, $fp, -40
	st.w $t0, $t1, 0
# %op8 = load i32, i32* %op1
	ld.d $t0, $fp, -40
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -68
# %op9 = icmp ne i32 %op8, 0
	ld.w $t0, $fp, -68
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t3, $zero, $t2
	st.b $t3, $fp, -69
# br i1 %op9, label %label14, label %label19
	ld.b $t0, $fp, -69
	bnez $t0, .main_label14
	b .main_label19
.main_label10:
# %op11 = load i32, i32* %op1
	ld.d $t0, $fp, -40
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -76
# %op12 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -80
# %op13 = add i32 %op12, %op11
	ld.w $t0, $fp, -80
	ld.w $t1, $fp, -76
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -84
# ret i32 %op13
	ld.w $a0, $fp, -84
	b main_exit
.main_label14:
# %op15 = load i32, i32* %op1
	ld.d $t0, $fp, -40
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -88
# %op16 = sub i32 %op15, 1
	ld.w $t0, $fp, -88
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -92
# store i32 %op16, i32* %op1
	ld.w $t0, $fp, -92
	ld.d $t1, $fp, -40
	st.w $t0, $t1, 0
# %op17 = load i32, i32* %op1
	ld.d $t0, $fp, -40
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -96
# %op18 = icmp ne i32 %op17, 0
	ld.w $t0, $fp, -96
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t3, $zero, $t2
	st.b $t3, $fp, -97
# br i1 %op18, label %label14, label %label19
	ld.b $t0, $fp, -97
	bnez $t0, .main_label14
	b .main_label19
.main_label19:
# %op20 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -104
# %op21 = icmp ne i32 %op20, 0
	ld.w $t0, $fp, -104
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t3, $zero, $t2
	st.b $t3, $fp, -105
# br i1 %op21, label %label4, label %label10
	ld.b $t0, $fp, -105
	bnez $t0, .main_label4
	b .main_label10
main_exit:
	addi.d $sp, $sp, 112
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
