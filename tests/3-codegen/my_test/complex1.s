	.text
	.globl mod
	.type mod, @function
mod:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -80
	st.w $a0, $fp, -20
	st.w $a1, $fp, -24
.mod_label_entry:
# %op2 = alloca i32
	addi.d $t8, $fp, -36
	addi.d $t7, $fp, -32
	st.d $t8, $t7, 0
# store i32 %arg0, i32* %op2
	ld.w $t0, $fp, -20
	ld.d $t1, $fp, -32
	st.w $t0, $t1, 0
# %op3 = alloca i32
	addi.d $t8, $fp, -52
	addi.d $t7, $fp, -48
	st.d $t8, $t7, 0
# store i32 %arg1, i32* %op3
	ld.w $t0, $fp, -24
	ld.d $t1, $fp, -48
	st.w $t0, $t1, 0
# %op4 = load i32, i32* %op3
	ld.d $t0, $fp, -48
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -56
# %op5 = load i32, i32* %op3
	ld.d $t0, $fp, -48
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -60
# %op6 = load i32, i32* %op2
	ld.d $t0, $fp, -32
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -64
# %op7 = sdiv i32 %op6, %op5
	ld.w $t0, $fp, -64
	ld.w $t1, $fp, -60
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -68
# %op8 = mul i32 %op7, %op4
	ld.w $t0, $fp, -68
	ld.w $t1, $fp, -56
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -72
# %op9 = load i32, i32* %op2
	ld.d $t0, $fp, -32
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -76
# %op10 = sub i32 %op9, %op8
	ld.w $t0, $fp, -76
	ld.w $t1, $fp, -72
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -80
# ret i32 %op10
	ld.w $a0, $fp, -80
	b mod_exit
mod_exit:
	addi.d $sp, $sp, 80
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl printfour
	.type printfour, @function
printfour:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -176
	st.w $a0, $fp, -20
.printfour_label_entry:
# %op1 = alloca i32
	addi.d $t8, $fp, -36
	addi.d $t7, $fp, -32
	st.d $t8, $t7, 0
# store i32 %arg0, i32* %op1
	ld.w $t0, $fp, -20
	ld.d $t1, $fp, -32
	st.w $t0, $t1, 0
# %op2 = alloca i32
	addi.d $t8, $fp, -52
	addi.d $t7, $fp, -48
	st.d $t8, $t7, 0
# %op3 = alloca i32
	addi.d $t8, $fp, -68
	addi.d $t7, $fp, -64
	st.d $t8, $t7, 0
# %op4 = alloca i32
	addi.d $t8, $fp, -84
	addi.d $t7, $fp, -80
	st.d $t8, $t7, 0
# %op5 = alloca i32
	addi.d $t8, $fp, -100
	addi.d $t7, $fp, -96
	st.d $t8, $t7, 0
# %op6 = load i32, i32* %op1
	ld.d $t0, $fp, -32
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -104
# %op7 = call i32 @mod(i32 %op6, i32 10000)
	ld.w $a0, $fp, -104
	lu12i.w $a1, 2
	ori $a1, $a1, 1808
	bl mod
	st.w $a0, $fp, -108
# store i32 %op7, i32* %op1
	ld.w $t0, $fp, -108
	ld.d $t1, $fp, -32
	st.w $t0, $t1, 0
# %op8 = load i32, i32* %op1
	ld.d $t0, $fp, -32
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -112
# %op9 = call i32 @mod(i32 %op8, i32 10)
	ld.w $a0, $fp, -112
	addi.w $a1, $zero, 10
	bl mod
	st.w $a0, $fp, -116
# store i32 %op9, i32* %op5
	ld.w $t0, $fp, -116
	ld.d $t1, $fp, -96
	st.w $t0, $t1, 0
# %op10 = load i32, i32* %op1
	ld.d $t0, $fp, -32
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -120
# %op11 = sdiv i32 %op10, 10
	ld.w $t0, $fp, -120
	addi.w $t1, $zero, 10
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -124
# store i32 %op11, i32* %op1
	ld.w $t0, $fp, -124
	ld.d $t1, $fp, -32
	st.w $t0, $t1, 0
# %op12 = load i32, i32* %op1
	ld.d $t0, $fp, -32
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -128
# %op13 = call i32 @mod(i32 %op12, i32 10)
	ld.w $a0, $fp, -128
	addi.w $a1, $zero, 10
	bl mod
	st.w $a0, $fp, -132
# store i32 %op13, i32* %op4
	ld.w $t0, $fp, -132
	ld.d $t1, $fp, -80
	st.w $t0, $t1, 0
# %op14 = load i32, i32* %op1
	ld.d $t0, $fp, -32
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -136
# %op15 = sdiv i32 %op14, 10
	ld.w $t0, $fp, -136
	addi.w $t1, $zero, 10
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -140
# store i32 %op15, i32* %op1
	ld.w $t0, $fp, -140
	ld.d $t1, $fp, -32
	st.w $t0, $t1, 0
# %op16 = load i32, i32* %op1
	ld.d $t0, $fp, -32
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -144
# %op17 = call i32 @mod(i32 %op16, i32 10)
	ld.w $a0, $fp, -144
	addi.w $a1, $zero, 10
	bl mod
	st.w $a0, $fp, -148
# store i32 %op17, i32* %op3
	ld.w $t0, $fp, -148
	ld.d $t1, $fp, -64
	st.w $t0, $t1, 0
# %op18 = load i32, i32* %op1
	ld.d $t0, $fp, -32
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -152
# %op19 = sdiv i32 %op18, 10
	ld.w $t0, $fp, -152
	addi.w $t1, $zero, 10
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -156
# store i32 %op19, i32* %op1
	ld.w $t0, $fp, -156
	ld.d $t1, $fp, -32
	st.w $t0, $t1, 0
# %op20 = load i32, i32* %op1
	ld.d $t0, $fp, -32
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -160
# store i32 %op20, i32* %op2
	ld.w $t0, $fp, -160
	ld.d $t1, $fp, -48
	st.w $t0, $t1, 0
# %op21 = load i32, i32* %op2
	ld.d $t0, $fp, -48
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -164
# call void @output(i32 %op21)
	ld.w $a0, $fp, -164
	bl output
# %op22 = load i32, i32* %op3
	ld.d $t0, $fp, -64
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -168
# call void @output(i32 %op22)
	ld.w $a0, $fp, -168
	bl output
# %op23 = load i32, i32* %op4
	ld.d $t0, $fp, -80
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -172
# call void @output(i32 %op23)
	ld.w $a0, $fp, -172
	bl output
# %op24 = load i32, i32* %op5
	ld.d $t0, $fp, -96
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -176
# call void @output(i32 %op24)
	ld.w $a0, $fp, -176
	bl output
# ret void
	addi.w $a0, $zero, 0
	b printfour_exit
printfour_exit:
	addi.d $sp, $sp, 176
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl main
	.type main, @function
main:
	lu12i.w $t0, 2
	ori $t0, $t0, 3376
	lu32i.d $t0, 0
	lu52i.d $t0, $t0, 0
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	sub.d $sp, $sp, $t0
	add.d $fp, $sp, $t0
.main_label_entry:
# %op0 = alloca [2801 x i32]
	lu12i.w $t8, -3
	ori $t8, $t8, 1060
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	addi.d $t7, $fp, -24
	st.d $t8, $t7, 0
# %op1 = alloca i32
	lu12i.w $t8, -3
	ori $t8, $t8, 1044
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	lu12i.w $t7, -3
	ori $t7, $t7, 1048
	lu32i.d $t7, -1
	lu52i.d $t7, $t7, -1
	add.d $t7, $fp, $t7
	st.d $t8, $t7, 0
# %op2 = alloca i32
	lu12i.w $t8, -3
	ori $t8, $t8, 1028
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	lu12i.w $t7, -3
	ori $t7, $t7, 1032
	lu32i.d $t7, -1
	lu52i.d $t7, $t7, -1
	add.d $t7, $fp, $t7
	st.d $t8, $t7, 0
# %op3 = alloca i32
	lu12i.w $t8, -3
	ori $t8, $t8, 1012
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	lu12i.w $t7, -3
	ori $t7, $t7, 1016
	lu32i.d $t7, -1
	lu52i.d $t7, $t7, -1
	add.d $t7, $fp, $t7
	st.d $t8, $t7, 0
# %op4 = alloca i32
	lu12i.w $t8, -3
	ori $t8, $t8, 996
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	lu12i.w $t7, -3
	ori $t7, $t7, 1000
	lu32i.d $t7, -1
	lu52i.d $t7, $t7, -1
	add.d $t7, $fp, $t7
	st.d $t8, $t7, 0
# %op5 = alloca i32
	lu12i.w $t8, -3
	ori $t8, $t8, 980
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	lu12i.w $t7, -3
	ori $t7, $t7, 984
	lu32i.d $t7, -1
	lu52i.d $t7, $t7, -1
	add.d $t7, $fp, $t7
	st.d $t8, $t7, 0
# store i32 0, i32* %op5
	addi.w $t0, $zero, 0
	lu12i.w $t1, -3
	ori $t1, $t1, 984
	lu32i.d $t1, -1
	lu52i.d $t1, $t1, -1
	add.d $t1, $fp, $t1
	ld.d $t1, $t1, 0
	st.w $t0, $t1, 0
# store i32 1234, i32* %op4
	addi.w $t0, $zero, 1234
	lu12i.w $t1, -3
	ori $t1, $t1, 1000
	lu32i.d $t1, -1
	lu52i.d $t1, $t1, -1
	add.d $t1, $fp, $t1
	ld.d $t1, $t1, 0
	st.w $t0, $t1, 0
# %op6 = alloca i32
	lu12i.w $t8, -3
	ori $t8, $t8, 964
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	lu12i.w $t7, -3
	ori $t7, $t7, 968
	lu32i.d $t7, -1
	lu52i.d $t7, $t7, -1
	add.d $t7, $fp, $t7
	st.d $t8, $t7, 0
# store i32 0, i32* %op6
	addi.w $t0, $zero, 0
	lu12i.w $t1, -3
	ori $t1, $t1, 968
	lu32i.d $t1, -1
	lu52i.d $t1, $t1, -1
	add.d $t1, $fp, $t1
	ld.d $t1, $t1, 0
	st.w $t0, $t1, 0
# %op7 = load i32, i32* %op6
	lu12i.w $t0, -3
	ori $t0, $t0, 968
	lu32i.d $t0, -1
	lu52i.d $t0, $t0, -1
	add.d $t0, $fp, $t0
	ld.d $t0, $t0, 0
	ld.w $t0, $t0, 0
	lu12i.w $t8, -3
	ori $t8, $t8, 960
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.w $t0, $t8, 0
# %op8 = icmp slt i32 %op7, 2800
	lu12i.w $t0, -3
	ori $t0, $t0, 960
	lu32i.d $t0, -1
	lu52i.d $t0, $t0, -1
	add.d $t0, $fp, $t0
	ld.w $t0, $t0, 0
	lu12i.w $t1, 0
	ori $t1, $t1, 2800
	slt $t2, $t0, $t1
	lu12i.w $t8, -3
	ori $t8, $t8, 959
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.b $t2, $t8, 0
# br i1 %op8, label %label9, label %label12
	lu12i.w $t0, -3
	ori $t0, $t0, 959
	lu32i.d $t0, -1
	lu52i.d $t0, $t0, -1
	add.d $t0, $fp, $t0
	ld.b $t0, $t0, 0
	bnez $t0, .main_label9
	b .main_label12
.main_label9:
# %op10 = load i32, i32* %op6
	lu12i.w $t0, -3
	ori $t0, $t0, 968
	lu32i.d $t0, -1
	lu52i.d $t0, $t0, -1
	add.d $t0, $fp, $t0
	ld.d $t0, $t0, 0
	ld.w $t0, $t0, 0
	lu12i.w $t8, -3
	ori $t8, $t8, 952
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.w $t0, $t8, 0
# %op11 = icmp sge i32 %op10, 0
	lu12i.w $t0, -3
	ori $t0, $t0, 952
	lu32i.d $t0, -1
	lu52i.d $t0, $t0, -1
	add.d $t0, $fp, $t0
	ld.w $t0, $t0, 0
	addi.w $t1, $zero, 0
	slt $t2, $t1, $t0
	xor $t3, $t0, $t1
	sltu $t4, $zero, $t3
	xori $t4, $t4, 1
	or $t5, $t2, $t4
	lu12i.w $t8, -3
	ori $t8, $t8, 951
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.b $t5, $t8, 0
# br i1 %op11, label %label15, label %label17
	lu12i.w $t0, -3
	ori $t0, $t0, 951
	lu32i.d $t0, -1
	lu52i.d $t0, $t0, -1
	add.d $t0, $fp, $t0
	ld.b $t0, $t0, 0
	bnez $t0, .main_label15
	b .main_label17
.main_label12:
# store i32 2800, i32* %op2
	lu12i.w $t0, 0
	ori $t0, $t0, 2800
	lu12i.w $t1, -3
	ori $t1, $t1, 1032
	lu32i.d $t1, -1
	lu52i.d $t1, $t1, -1
	add.d $t1, $fp, $t1
	ld.d $t1, $t1, 0
	st.w $t0, $t1, 0
# %op13 = load i32, i32* %op2
	lu12i.w $t0, -3
	ori $t0, $t0, 1032
	lu32i.d $t0, -1
	lu52i.d $t0, $t0, -1
	add.d $t0, $fp, $t0
	ld.d $t0, $t0, 0
	ld.w $t0, $t0, 0
	lu12i.w $t8, -3
	ori $t8, $t8, 944
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.w $t0, $t8, 0
# %op14 = icmp ne i32 %op13, 0
	lu12i.w $t0, -3
	ori $t0, $t0, 944
	lu32i.d $t0, -1
	lu52i.d $t0, $t0, -1
	add.d $t0, $fp, $t0
	ld.w $t0, $t0, 0
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t3, $zero, $t2
	lu12i.w $t8, -3
	ori $t8, $t8, 943
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.b $t3, $t8, 0
# br i1 %op14, label %label23, label %label28
	lu12i.w $t0, -3
	ori $t0, $t0, 943
	lu32i.d $t0, -1
	lu52i.d $t0, $t0, -1
	add.d $t0, $fp, $t0
	ld.b $t0, $t0, 0
	bnez $t0, .main_label23
	b .main_label28
.main_label15:
# %op16 = getelementptr [2801 x i32], [2801 x i32]* %op0, i32 0, i32 %op10
	ld.d $t3, $fp, -24
	lu12i.w $t0, -3
	ori $t0, $t0, 952
	lu32i.d $t0, -1
	lu52i.d $t0, $t0, -1
	add.d $t0, $fp, $t0
	ld.w $t0, $t0, 0
	addi.w $t1, $zero, 4
	mul.w $t2, $t0, $t1
	add.d $t3, $t3, $t2
	lu12i.w $t8, -3
	ori $t8, $t8, 928
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.d $t3, $t8, 0
# br label %label18
	b .main_label18
.main_label17:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label18
	b .main_label18
.main_label18:
# store i32 2000, i32* %op16
	addi.w $t0, $zero, 2000
	lu12i.w $t1, -3
	ori $t1, $t1, 928
	lu32i.d $t1, -1
	lu52i.d $t1, $t1, -1
	add.d $t1, $fp, $t1
	ld.d $t1, $t1, 0
	st.w $t0, $t1, 0
# %op19 = load i32, i32* %op6
	lu12i.w $t0, -3
	ori $t0, $t0, 968
	lu32i.d $t0, -1
	lu52i.d $t0, $t0, -1
	add.d $t0, $fp, $t0
	ld.d $t0, $t0, 0
	ld.w $t0, $t0, 0
	lu12i.w $t8, -3
	ori $t8, $t8, 924
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.w $t0, $t8, 0
# %op20 = add i32 %op19, 1
	lu12i.w $t0, -3
	ori $t0, $t0, 924
	lu32i.d $t0, -1
	lu52i.d $t0, $t0, -1
	add.d $t0, $fp, $t0
	ld.w $t0, $t0, 0
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	lu12i.w $t8, -3
	ori $t8, $t8, 920
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.w $t2, $t8, 0
# store i32 %op20, i32* %op6
	lu12i.w $t0, -3
	ori $t0, $t0, 920
	lu32i.d $t0, -1
	lu52i.d $t0, $t0, -1
	add.d $t0, $fp, $t0
	ld.w $t0, $t0, 0
	lu12i.w $t1, -3
	ori $t1, $t1, 968
	lu32i.d $t1, -1
	lu52i.d $t1, $t1, -1
	add.d $t1, $fp, $t1
	ld.d $t1, $t1, 0
	st.w $t0, $t1, 0
# %op21 = load i32, i32* %op6
	lu12i.w $t0, -3
	ori $t0, $t0, 968
	lu32i.d $t0, -1
	lu52i.d $t0, $t0, -1
	add.d $t0, $fp, $t0
	ld.d $t0, $t0, 0
	ld.w $t0, $t0, 0
	lu12i.w $t8, -3
	ori $t8, $t8, 916
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.w $t0, $t8, 0
# %op22 = icmp slt i32 %op21, 2800
	lu12i.w $t0, -3
	ori $t0, $t0, 916
	lu32i.d $t0, -1
	lu52i.d $t0, $t0, -1
	add.d $t0, $fp, $t0
	ld.w $t0, $t0, 0
	lu12i.w $t1, 0
	ori $t1, $t1, 2800
	slt $t2, $t0, $t1
	lu12i.w $t8, -3
	ori $t8, $t8, 915
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.b $t2, $t8, 0
# br i1 %op22, label %label9, label %label12
	lu12i.w $t0, -3
	ori $t0, $t0, 915
	lu32i.d $t0, -1
	lu52i.d $t0, $t0, -1
	add.d $t0, $fp, $t0
	ld.b $t0, $t0, 0
	bnez $t0, .main_label9
	b .main_label12
.main_label23:
# %op24 = alloca i32
	lu12i.w $t8, -3
	ori $t8, $t8, 900
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	lu12i.w $t7, -3
	ori $t7, $t7, 904
	lu32i.d $t7, -1
	lu52i.d $t7, $t7, -1
	add.d $t7, $fp, $t7
	st.d $t8, $t7, 0
# store i32 0, i32* %op24
	addi.w $t0, $zero, 0
	lu12i.w $t1, -3
	ori $t1, $t1, 904
	lu32i.d $t1, -1
	lu52i.d $t1, $t1, -1
	add.d $t1, $fp, $t1
	ld.d $t1, $t1, 0
	st.w $t0, $t1, 0
# %op25 = load i32, i32* %op2
	lu12i.w $t0, -3
	ori $t0, $t0, 1032
	lu32i.d $t0, -1
	lu52i.d $t0, $t0, -1
	add.d $t0, $fp, $t0
	ld.d $t0, $t0, 0
	ld.w $t0, $t0, 0
	lu12i.w $t8, -3
	ori $t8, $t8, 896
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.w $t0, $t8, 0
# store i32 %op25, i32* %op1
	lu12i.w $t0, -3
	ori $t0, $t0, 896
	lu32i.d $t0, -1
	lu52i.d $t0, $t0, -1
	add.d $t0, $fp, $t0
	ld.w $t0, $t0, 0
	lu12i.w $t1, -3
	ori $t1, $t1, 1048
	lu32i.d $t1, -1
	lu52i.d $t1, $t1, -1
	add.d $t1, $fp, $t1
	ld.d $t1, $t1, 0
	st.w $t0, $t1, 0
# %op26 = load i32, i32* %op1
	lu12i.w $t0, -3
	ori $t0, $t0, 1048
	lu32i.d $t0, -1
	lu52i.d $t0, $t0, -1
	add.d $t0, $fp, $t0
	ld.d $t0, $t0, 0
	ld.w $t0, $t0, 0
	lu12i.w $t8, -3
	ori $t8, $t8, 892
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.w $t0, $t8, 0
# %op27 = icmp ne i32 %op26, 0
	lu12i.w $t0, -3
	ori $t0, $t0, 892
	lu32i.d $t0, -1
	lu52i.d $t0, $t0, -1
	add.d $t0, $fp, $t0
	ld.w $t0, $t0, 0
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t3, $zero, $t2
	lu12i.w $t8, -3
	ori $t8, $t8, 891
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.b $t3, $t8, 0
# br i1 %op27, label %label29, label %label32
	lu12i.w $t0, -3
	ori $t0, $t0, 891
	lu32i.d $t0, -1
	lu52i.d $t0, $t0, -1
	add.d $t0, $fp, $t0
	ld.b $t0, $t0, 0
	bnez $t0, .main_label29
	b .main_label32
.main_label28:
# ret void
	addi.w $a0, $zero, 0
	b main_exit
.main_label29:
# %op30 = load i32, i32* %op1
	lu12i.w $t0, -3
	ori $t0, $t0, 1048
	lu32i.d $t0, -1
	lu52i.d $t0, $t0, -1
	add.d $t0, $fp, $t0
	ld.d $t0, $t0, 0
	ld.w $t0, $t0, 0
	lu12i.w $t8, -3
	ori $t8, $t8, 884
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.w $t0, $t8, 0
# %op31 = icmp sge i32 %op30, 0
	lu12i.w $t0, -3
	ori $t0, $t0, 884
	lu32i.d $t0, -1
	lu52i.d $t0, $t0, -1
	add.d $t0, $fp, $t0
	ld.w $t0, $t0, 0
	addi.w $t1, $zero, 0
	slt $t2, $t1, $t0
	xor $t3, $t0, $t1
	sltu $t4, $zero, $t3
	xori $t4, $t4, 1
	or $t5, $t2, $t4
	lu12i.w $t8, -3
	ori $t8, $t8, 883
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.b $t5, $t8, 0
# br i1 %op31, label %label43, label %label46
	lu12i.w $t0, -3
	ori $t0, $t0, 883
	lu32i.d $t0, -1
	lu52i.d $t0, $t0, -1
	add.d $t0, $fp, $t0
	ld.b $t0, $t0, 0
	bnez $t0, .main_label43
	b .main_label46
.main_label32:
# %op33 = load i32, i32* %op24
	lu12i.w $t0, -3
	ori $t0, $t0, 904
	lu32i.d $t0, -1
	lu52i.d $t0, $t0, -1
	add.d $t0, $fp, $t0
	ld.d $t0, $t0, 0
	ld.w $t0, $t0, 0
	lu12i.w $t8, -3
	ori $t8, $t8, 876
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.w $t0, $t8, 0
# %op34 = sdiv i32 %op33, 10000
	lu12i.w $t0, -3
	ori $t0, $t0, 876
	lu32i.d $t0, -1
	lu52i.d $t0, $t0, -1
	add.d $t0, $fp, $t0
	ld.w $t0, $t0, 0
	lu12i.w $t1, 2
	ori $t1, $t1, 1808
	div.w $t2, $t0, $t1
	lu12i.w $t8, -3
	ori $t8, $t8, 872
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.w $t2, $t8, 0
# %op35 = load i32, i32* %op5
	lu12i.w $t0, -3
	ori $t0, $t0, 984
	lu32i.d $t0, -1
	lu52i.d $t0, $t0, -1
	add.d $t0, $fp, $t0
	ld.d $t0, $t0, 0
	ld.w $t0, $t0, 0
	lu12i.w $t8, -3
	ori $t8, $t8, 868
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.w $t0, $t8, 0
# %op36 = add i32 %op35, %op34
	lu12i.w $t0, -3
	ori $t0, $t0, 868
	lu32i.d $t0, -1
	lu52i.d $t0, $t0, -1
	add.d $t0, $fp, $t0
	ld.w $t0, $t0, 0
	lu12i.w $t1, -3
	ori $t1, $t1, 872
	lu32i.d $t1, -1
	lu52i.d $t1, $t1, -1
	add.d $t1, $fp, $t1
	ld.w $t1, $t1, 0
	add.w $t2, $t0, $t1
	lu12i.w $t8, -3
	ori $t8, $t8, 864
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.w $t2, $t8, 0
# call void @printfour(i32 %op36)
	lu12i.w $a0, -3
	ori $a0, $a0, 864
	lu32i.d $a0, -1
	lu52i.d $a0, $a0, -1
	add.d $a0, $fp, $a0
	ld.w $a0, $a0, 0
	bl printfour
# %op37 = load i32, i32* %op24
	lu12i.w $t0, -3
	ori $t0, $t0, 904
	lu32i.d $t0, -1
	lu52i.d $t0, $t0, -1
	add.d $t0, $fp, $t0
	ld.d $t0, $t0, 0
	ld.w $t0, $t0, 0
	lu12i.w $t8, -3
	ori $t8, $t8, 860
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.w $t0, $t8, 0
# %op38 = call i32 @mod(i32 %op37, i32 10000)
	lu12i.w $a0, -3
	ori $a0, $a0, 860
	lu32i.d $a0, -1
	lu52i.d $a0, $a0, -1
	add.d $a0, $fp, $a0
	ld.w $a0, $a0, 0
	lu12i.w $a1, 2
	ori $a1, $a1, 1808
	bl mod
	lu12i.w $t8, -3
	ori $t8, $t8, 856
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.w $a0, $t8, 0
# store i32 %op38, i32* %op5
	lu12i.w $t0, -3
	ori $t0, $t0, 856
	lu32i.d $t0, -1
	lu52i.d $t0, $t0, -1
	add.d $t0, $fp, $t0
	ld.w $t0, $t0, 0
	lu12i.w $t1, -3
	ori $t1, $t1, 984
	lu32i.d $t1, -1
	lu52i.d $t1, $t1, -1
	add.d $t1, $fp, $t1
	ld.d $t1, $t1, 0
	st.w $t0, $t1, 0
# %op39 = load i32, i32* %op2
	lu12i.w $t0, -3
	ori $t0, $t0, 1032
	lu32i.d $t0, -1
	lu52i.d $t0, $t0, -1
	add.d $t0, $fp, $t0
	ld.d $t0, $t0, 0
	ld.w $t0, $t0, 0
	lu12i.w $t8, -3
	ori $t8, $t8, 852
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.w $t0, $t8, 0
# %op40 = sub i32 %op39, 14
	lu12i.w $t0, -3
	ori $t0, $t0, 852
	lu32i.d $t0, -1
	lu52i.d $t0, $t0, -1
	add.d $t0, $fp, $t0
	ld.w $t0, $t0, 0
	addi.w $t1, $zero, 14
	sub.w $t2, $t0, $t1
	lu12i.w $t8, -3
	ori $t8, $t8, 848
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.w $t2, $t8, 0
# store i32 %op40, i32* %op2
	lu12i.w $t0, -3
	ori $t0, $t0, 848
	lu32i.d $t0, -1
	lu52i.d $t0, $t0, -1
	add.d $t0, $fp, $t0
	ld.w $t0, $t0, 0
	lu12i.w $t1, -3
	ori $t1, $t1, 1032
	lu32i.d $t1, -1
	lu52i.d $t1, $t1, -1
	add.d $t1, $fp, $t1
	ld.d $t1, $t1, 0
	st.w $t0, $t1, 0
# %op41 = load i32, i32* %op2
	lu12i.w $t0, -3
	ori $t0, $t0, 1032
	lu32i.d $t0, -1
	lu52i.d $t0, $t0, -1
	add.d $t0, $fp, $t0
	ld.d $t0, $t0, 0
	ld.w $t0, $t0, 0
	lu12i.w $t8, -3
	ori $t8, $t8, 844
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.w $t0, $t8, 0
# %op42 = icmp ne i32 %op41, 0
	lu12i.w $t0, -3
	ori $t0, $t0, 844
	lu32i.d $t0, -1
	lu52i.d $t0, $t0, -1
	add.d $t0, $fp, $t0
	ld.w $t0, $t0, 0
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t3, $zero, $t2
	lu12i.w $t8, -3
	ori $t8, $t8, 843
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.b $t3, $t8, 0
# br i1 %op42, label %label23, label %label28
	lu12i.w $t0, -3
	ori $t0, $t0, 843
	lu32i.d $t0, -1
	lu52i.d $t0, $t0, -1
	add.d $t0, $fp, $t0
	ld.b $t0, $t0, 0
	bnez $t0, .main_label23
	b .main_label28
.main_label43:
# %op44 = getelementptr [2801 x i32], [2801 x i32]* %op0, i32 0, i32 %op30
	ld.d $t3, $fp, -24
	lu12i.w $t0, -3
	ori $t0, $t0, 884
	lu32i.d $t0, -1
	lu52i.d $t0, $t0, -1
	add.d $t0, $fp, $t0
	ld.w $t0, $t0, 0
	addi.w $t1, $zero, 4
	mul.w $t2, $t0, $t1
	add.d $t3, $t3, $t2
	lu12i.w $t8, -3
	ori $t8, $t8, 832
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.d $t3, $t8, 0
# %op45 = load i32, i32* %op44
	lu12i.w $t0, -3
	ori $t0, $t0, 832
	lu32i.d $t0, -1
	lu52i.d $t0, $t0, -1
	add.d $t0, $fp, $t0
	ld.d $t0, $t0, 0
	ld.w $t0, $t0, 0
	lu12i.w $t8, -3
	ori $t8, $t8, 828
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.w $t0, $t8, 0
# br label %label47
	b .main_label47
.main_label46:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label47
	b .main_label47
.main_label47:
# %op48 = mul i32 %op45, 10000
	lu12i.w $t0, -3
	ori $t0, $t0, 828
	lu32i.d $t0, -1
	lu52i.d $t0, $t0, -1
	add.d $t0, $fp, $t0
	ld.w $t0, $t0, 0
	lu12i.w $t1, 2
	ori $t1, $t1, 1808
	mul.w $t2, $t0, $t1
	lu12i.w $t8, -3
	ori $t8, $t8, 824
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.w $t2, $t8, 0
# %op49 = load i32, i32* %op24
	lu12i.w $t0, -3
	ori $t0, $t0, 904
	lu32i.d $t0, -1
	lu52i.d $t0, $t0, -1
	add.d $t0, $fp, $t0
	ld.d $t0, $t0, 0
	ld.w $t0, $t0, 0
	lu12i.w $t8, -3
	ori $t8, $t8, 820
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.w $t0, $t8, 0
# %op50 = add i32 %op49, %op48
	lu12i.w $t0, -3
	ori $t0, $t0, 820
	lu32i.d $t0, -1
	lu52i.d $t0, $t0, -1
	add.d $t0, $fp, $t0
	ld.w $t0, $t0, 0
	lu12i.w $t1, -3
	ori $t1, $t1, 824
	lu32i.d $t1, -1
	lu52i.d $t1, $t1, -1
	add.d $t1, $fp, $t1
	ld.w $t1, $t1, 0
	add.w $t2, $t0, $t1
	lu12i.w $t8, -3
	ori $t8, $t8, 816
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.w $t2, $t8, 0
# store i32 %op50, i32* %op24
	lu12i.w $t0, -3
	ori $t0, $t0, 816
	lu32i.d $t0, -1
	lu52i.d $t0, $t0, -1
	add.d $t0, $fp, $t0
	ld.w $t0, $t0, 0
	lu12i.w $t1, -3
	ori $t1, $t1, 904
	lu32i.d $t1, -1
	lu52i.d $t1, $t1, -1
	add.d $t1, $fp, $t1
	ld.d $t1, $t1, 0
	st.w $t0, $t1, 0
# %op51 = load i32, i32* %op1
	lu12i.w $t0, -3
	ori $t0, $t0, 1048
	lu32i.d $t0, -1
	lu52i.d $t0, $t0, -1
	add.d $t0, $fp, $t0
	ld.d $t0, $t0, 0
	ld.w $t0, $t0, 0
	lu12i.w $t8, -3
	ori $t8, $t8, 812
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.w $t0, $t8, 0
# %op52 = mul i32 2, %op51
	addi.w $t0, $zero, 2
	lu12i.w $t1, -3
	ori $t1, $t1, 812
	lu32i.d $t1, -1
	lu52i.d $t1, $t1, -1
	add.d $t1, $fp, $t1
	ld.w $t1, $t1, 0
	mul.w $t2, $t0, $t1
	lu12i.w $t8, -3
	ori $t8, $t8, 808
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.w $t2, $t8, 0
# %op53 = sub i32 %op52, 1
	lu12i.w $t0, -3
	ori $t0, $t0, 808
	lu32i.d $t0, -1
	lu52i.d $t0, $t0, -1
	add.d $t0, $fp, $t0
	ld.w $t0, $t0, 0
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	lu12i.w $t8, -3
	ori $t8, $t8, 804
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.w $t2, $t8, 0
# store i32 %op53, i32* %op3
	lu12i.w $t0, -3
	ori $t0, $t0, 804
	lu32i.d $t0, -1
	lu52i.d $t0, $t0, -1
	add.d $t0, $fp, $t0
	ld.w $t0, $t0, 0
	lu12i.w $t1, -3
	ori $t1, $t1, 1016
	lu32i.d $t1, -1
	lu52i.d $t1, $t1, -1
	add.d $t1, $fp, $t1
	ld.d $t1, $t1, 0
	st.w $t0, $t1, 0
# %op54 = load i32, i32* %op1
	lu12i.w $t0, -3
	ori $t0, $t0, 1048
	lu32i.d $t0, -1
	lu52i.d $t0, $t0, -1
	add.d $t0, $fp, $t0
	ld.d $t0, $t0, 0
	ld.w $t0, $t0, 0
	lu12i.w $t8, -3
	ori $t8, $t8, 800
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.w $t0, $t8, 0
# %op55 = icmp sge i32 %op54, 0
	lu12i.w $t0, -3
	ori $t0, $t0, 800
	lu32i.d $t0, -1
	lu52i.d $t0, $t0, -1
	add.d $t0, $fp, $t0
	ld.w $t0, $t0, 0
	addi.w $t1, $zero, 0
	slt $t2, $t1, $t0
	xor $t3, $t0, $t1
	sltu $t4, $zero, $t3
	xori $t4, $t4, 1
	or $t5, $t2, $t4
	lu12i.w $t8, -3
	ori $t8, $t8, 799
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.b $t5, $t8, 0
# br i1 %op55, label %label56, label %label58
	lu12i.w $t0, -3
	ori $t0, $t0, 799
	lu32i.d $t0, -1
	lu52i.d $t0, $t0, -1
	add.d $t0, $fp, $t0
	ld.b $t0, $t0, 0
	bnez $t0, .main_label56
	b .main_label58
.main_label56:
# %op57 = getelementptr [2801 x i32], [2801 x i32]* %op0, i32 0, i32 %op54
	ld.d $t3, $fp, -24
	lu12i.w $t0, -3
	ori $t0, $t0, 800
	lu32i.d $t0, -1
	lu52i.d $t0, $t0, -1
	add.d $t0, $fp, $t0
	ld.w $t0, $t0, 0
	addi.w $t1, $zero, 4
	mul.w $t2, $t0, $t1
	add.d $t3, $t3, $t2
	lu12i.w $t8, -3
	ori $t8, $t8, 784
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.d $t3, $t8, 0
# br label %label59
	b .main_label59
.main_label58:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label59
	b .main_label59
.main_label59:
# %op60 = load i32, i32* %op24
	lu12i.w $t0, -3
	ori $t0, $t0, 904
	lu32i.d $t0, -1
	lu52i.d $t0, $t0, -1
	add.d $t0, $fp, $t0
	ld.d $t0, $t0, 0
	ld.w $t0, $t0, 0
	lu12i.w $t8, -3
	ori $t8, $t8, 780
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.w $t0, $t8, 0
# %op61 = load i32, i32* %op3
	lu12i.w $t0, -3
	ori $t0, $t0, 1016
	lu32i.d $t0, -1
	lu52i.d $t0, $t0, -1
	add.d $t0, $fp, $t0
	ld.d $t0, $t0, 0
	ld.w $t0, $t0, 0
	lu12i.w $t8, -3
	ori $t8, $t8, 776
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.w $t0, $t8, 0
# %op62 = call i32 @mod(i32 %op60, i32 %op61)
	lu12i.w $a0, -3
	ori $a0, $a0, 780
	lu32i.d $a0, -1
	lu52i.d $a0, $a0, -1
	add.d $a0, $fp, $a0
	ld.w $a0, $a0, 0
	lu12i.w $a1, -3
	ori $a1, $a1, 776
	lu32i.d $a1, -1
	lu52i.d $a1, $a1, -1
	add.d $a1, $fp, $a1
	ld.w $a1, $a1, 0
	bl mod
	lu12i.w $t8, -3
	ori $t8, $t8, 772
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.w $a0, $t8, 0
# store i32 %op62, i32* %op57
	lu12i.w $t0, -3
	ori $t0, $t0, 772
	lu32i.d $t0, -1
	lu52i.d $t0, $t0, -1
	add.d $t0, $fp, $t0
	ld.w $t0, $t0, 0
	lu12i.w $t1, -3
	ori $t1, $t1, 784
	lu32i.d $t1, -1
	lu52i.d $t1, $t1, -1
	add.d $t1, $fp, $t1
	ld.d $t1, $t1, 0
	st.w $t0, $t1, 0
# %op63 = load i32, i32* %op3
	lu12i.w $t0, -3
	ori $t0, $t0, 1016
	lu32i.d $t0, -1
	lu52i.d $t0, $t0, -1
	add.d $t0, $fp, $t0
	ld.d $t0, $t0, 0
	ld.w $t0, $t0, 0
	lu12i.w $t8, -3
	ori $t8, $t8, 768
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.w $t0, $t8, 0
# %op64 = load i32, i32* %op24
	lu12i.w $t0, -3
	ori $t0, $t0, 904
	lu32i.d $t0, -1
	lu52i.d $t0, $t0, -1
	add.d $t0, $fp, $t0
	ld.d $t0, $t0, 0
	ld.w $t0, $t0, 0
	lu12i.w $t8, -3
	ori $t8, $t8, 764
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.w $t0, $t8, 0
# %op65 = sdiv i32 %op64, %op63
	lu12i.w $t0, -3
	ori $t0, $t0, 764
	lu32i.d $t0, -1
	lu52i.d $t0, $t0, -1
	add.d $t0, $fp, $t0
	ld.w $t0, $t0, 0
	lu12i.w $t1, -3
	ori $t1, $t1, 768
	lu32i.d $t1, -1
	lu52i.d $t1, $t1, -1
	add.d $t1, $fp, $t1
	ld.w $t1, $t1, 0
	div.w $t2, $t0, $t1
	lu12i.w $t8, -3
	ori $t8, $t8, 760
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.w $t2, $t8, 0
# store i32 %op65, i32* %op24
	lu12i.w $t0, -3
	ori $t0, $t0, 760
	lu32i.d $t0, -1
	lu52i.d $t0, $t0, -1
	add.d $t0, $fp, $t0
	ld.w $t0, $t0, 0
	lu12i.w $t1, -3
	ori $t1, $t1, 904
	lu32i.d $t1, -1
	lu52i.d $t1, $t1, -1
	add.d $t1, $fp, $t1
	ld.d $t1, $t1, 0
	st.w $t0, $t1, 0
# %op66 = load i32, i32* %op1
	lu12i.w $t0, -3
	ori $t0, $t0, 1048
	lu32i.d $t0, -1
	lu52i.d $t0, $t0, -1
	add.d $t0, $fp, $t0
	ld.d $t0, $t0, 0
	ld.w $t0, $t0, 0
	lu12i.w $t8, -3
	ori $t8, $t8, 756
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.w $t0, $t8, 0
# %op67 = sub i32 %op66, 1
	lu12i.w $t0, -3
	ori $t0, $t0, 756
	lu32i.d $t0, -1
	lu52i.d $t0, $t0, -1
	add.d $t0, $fp, $t0
	ld.w $t0, $t0, 0
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	lu12i.w $t8, -3
	ori $t8, $t8, 752
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.w $t2, $t8, 0
# store i32 %op67, i32* %op1
	lu12i.w $t0, -3
	ori $t0, $t0, 752
	lu32i.d $t0, -1
	lu52i.d $t0, $t0, -1
	add.d $t0, $fp, $t0
	ld.w $t0, $t0, 0
	lu12i.w $t1, -3
	ori $t1, $t1, 1048
	lu32i.d $t1, -1
	lu52i.d $t1, $t1, -1
	add.d $t1, $fp, $t1
	ld.d $t1, $t1, 0
	st.w $t0, $t1, 0
# %op68 = load i32, i32* %op1
	lu12i.w $t0, -3
	ori $t0, $t0, 1048
	lu32i.d $t0, -1
	lu52i.d $t0, $t0, -1
	add.d $t0, $fp, $t0
	ld.d $t0, $t0, 0
	ld.w $t0, $t0, 0
	lu12i.w $t8, -3
	ori $t8, $t8, 748
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.w $t0, $t8, 0
# %op69 = icmp ne i32 %op68, 0
	lu12i.w $t0, -3
	ori $t0, $t0, 748
	lu32i.d $t0, -1
	lu52i.d $t0, $t0, -1
	add.d $t0, $fp, $t0
	ld.w $t0, $t0, 0
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t3, $zero, $t2
	lu12i.w $t8, -3
	ori $t8, $t8, 747
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.b $t3, $t8, 0
# br i1 %op69, label %label70, label %label74
	lu12i.w $t0, -3
	ori $t0, $t0, 747
	lu32i.d $t0, -1
	lu52i.d $t0, $t0, -1
	add.d $t0, $fp, $t0
	ld.b $t0, $t0, 0
	bnez $t0, .main_label70
	b .main_label74
.main_label70:
# %op71 = load i32, i32* %op1
	lu12i.w $t0, -3
	ori $t0, $t0, 1048
	lu32i.d $t0, -1
	lu52i.d $t0, $t0, -1
	add.d $t0, $fp, $t0
	ld.d $t0, $t0, 0
	ld.w $t0, $t0, 0
	lu12i.w $t8, -3
	ori $t8, $t8, 740
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.w $t0, $t8, 0
# %op72 = load i32, i32* %op24
	lu12i.w $t0, -3
	ori $t0, $t0, 904
	lu32i.d $t0, -1
	lu52i.d $t0, $t0, -1
	add.d $t0, $fp, $t0
	ld.d $t0, $t0, 0
	ld.w $t0, $t0, 0
	lu12i.w $t8, -3
	ori $t8, $t8, 736
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.w $t0, $t8, 0
# %op73 = mul i32 %op72, %op71
	lu12i.w $t0, -3
	ori $t0, $t0, 736
	lu32i.d $t0, -1
	lu52i.d $t0, $t0, -1
	add.d $t0, $fp, $t0
	ld.w $t0, $t0, 0
	lu12i.w $t1, -3
	ori $t1, $t1, 740
	lu32i.d $t1, -1
	lu52i.d $t1, $t1, -1
	add.d $t1, $fp, $t1
	ld.w $t1, $t1, 0
	mul.w $t2, $t0, $t1
	lu12i.w $t8, -3
	ori $t8, $t8, 732
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.w $t2, $t8, 0
# store i32 %op73, i32* %op24
	lu12i.w $t0, -3
	ori $t0, $t0, 732
	lu32i.d $t0, -1
	lu52i.d $t0, $t0, -1
	add.d $t0, $fp, $t0
	ld.w $t0, $t0, 0
	lu12i.w $t1, -3
	ori $t1, $t1, 904
	lu32i.d $t1, -1
	lu52i.d $t1, $t1, -1
	add.d $t1, $fp, $t1
	ld.d $t1, $t1, 0
	st.w $t0, $t1, 0
# br label %label74
	b .main_label74
.main_label74:
# %op75 = load i32, i32* %op1
	lu12i.w $t0, -3
	ori $t0, $t0, 1048
	lu32i.d $t0, -1
	lu52i.d $t0, $t0, -1
	add.d $t0, $fp, $t0
	ld.d $t0, $t0, 0
	ld.w $t0, $t0, 0
	lu12i.w $t8, -3
	ori $t8, $t8, 728
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.w $t0, $t8, 0
# %op76 = icmp ne i32 %op75, 0
	lu12i.w $t0, -3
	ori $t0, $t0, 728
	lu32i.d $t0, -1
	lu52i.d $t0, $t0, -1
	add.d $t0, $fp, $t0
	ld.w $t0, $t0, 0
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t3, $zero, $t2
	lu12i.w $t8, -3
	ori $t8, $t8, 727
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.b $t3, $t8, 0
# br i1 %op76, label %label29, label %label32
	lu12i.w $t0, -3
	ori $t0, $t0, 727
	lu32i.d $t0, -1
	lu52i.d $t0, $t0, -1
	add.d $t0, $fp, $t0
	ld.b $t0, $t0, 0
	bnez $t0, .main_label29
	b .main_label32
main_exit:
	lu12i.w $t0, 2
	ori $t0, $t0, 3376
	lu32i.d $t0, 0
	lu52i.d $t0, $t0, 0
	add.d $sp, $sp, $t0
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
