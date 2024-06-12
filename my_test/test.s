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
	ld.w $t7, $fp, -20
	ld.d $t8, $fp, -32
	st.w $t7, $t8, 0
# %op3 = alloca i32
	addi.d $t8, $fp, -52
	addi.d $t7, $fp, -48
	st.d $t8, $t7, 0
# store i32 %arg1, i32* %op3
	ld.w $t7, $fp, -24
	ld.d $t8, $fp, -48
	st.w $t7, $t8, 0
# %op4 = load i32, i32* %op3
	ld.d $t8, $fp, -48
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -56
# %op5 = load i32, i32* %op3
	ld.d $t8, $fp, -48
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -60
# %op6 = load i32, i32* %op2
	ld.d $t8, $fp, -32
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -64
# %op7 = sdiv i32 %op6, %op5
	ld.w $t7, $fp, -64
	ld.w $t8, $fp, -60
	div.w $t7, $t7, $t8
	st.w $t7, $fp, -68
# %op8 = mul i32 %op7, %op4
	ld.w $t7, $fp, -68
	ld.w $t8, $fp, -56
	mul.w $t7, $t7, $t8
	st.w $t7, $fp, -72
# %op9 = load i32, i32* %op2
	ld.d $t8, $fp, -32
	ld.w $t7, $t8, 0
	st.w $t7, $fp, -76
# %op10 = sub i32 %op9, %op8
	ld.w $t7, $fp, -76
	ld.w $t8, $fp, -72
	sub.w $t7, $t7, $t8
	st.w $t7, $fp, -80
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
	addi.d $sp, $sp, -80
	st.w $a0, $fp, -20
.printfour_label_entry:
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
# %op3 = call i32 @mod(i32 %op2, i32 10000)
	ld.w $a0, $fp, -40
	lu12i.w $a1, 2
	ori $a1, $a1, 1808
	bl mod
	st.w $a0, $fp, -44
# %op4 = call i32 @mod(i32 %op3, i32 10)
	ld.w $a0, $fp, -44
	addi.w $a1, $zero, 10
	bl mod
	st.w $a0, $fp, -48
# %op5 = sdiv i32 %op3, 10
	ld.w $t7, $fp, -44
	addi.w $t8, $zero, 10
	div.w $t7, $t7, $t8
	st.w $t7, $fp, -52
# %op6 = call i32 @mod(i32 %op5, i32 10)
	ld.w $a0, $fp, -52
	addi.w $a1, $zero, 10
	bl mod
	st.w $a0, $fp, -56
# %op7 = sdiv i32 %op5, 10
	ld.w $t7, $fp, -52
	addi.w $t8, $zero, 10
	div.w $t7, $t7, $t8
	st.w $t7, $fp, -60
# %op8 = call i32 @mod(i32 %op7, i32 10)
	ld.w $a0, $fp, -60
	addi.w $a1, $zero, 10
	bl mod
	st.w $a0, $fp, -64
# %op9 = sdiv i32 %op7, 10
	ld.w $t7, $fp, -60
	addi.w $t8, $zero, 10
	div.w $t7, $t7, $t8
	st.w $t7, $fp, -68
# call void @output(i32 %op9)
	ld.w $a0, $fp, -68
	bl output
# call void @output(i32 %op8)
	ld.w $a0, $fp, -64
	bl output
# call void @output(i32 %op6)
	ld.w $a0, $fp, -56
	bl output
# call void @output(i32 %op4)
	ld.w $a0, $fp, -48
	bl output
# ret void
	addi.w $a0, $zero, 0
	b printfour_exit
printfour_exit:
	addi.d $sp, $sp, 80
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl main
	.type main, @function
main:
	lu12i.w $t0, 2
	ori $t0, $t0, 3184
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
# %op1 = icmp slt i32 0, 2800
	addi.w $t7, $zero, 0
	lu12i.w $t8, 0
	ori $t8, $t8, 2800
	slt $t7, $t7, $t8
	lu12i.w $t8, -3
	ori $t8, $t8, 1059
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.b $t7, $t8, 0
# br i1 %op1, label %label2, label %label5
# %op3 = phi i32 [ 0, %label_entry ], [ %op11, %label10 ]
	addi.w $t7, $zero, 0
	add.d $t7, $t7, $zero
	lu12i.w $t8, -3
	ori $t8, $t8, 1052
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.w $t7, $t8, 0
	lu12i.w $t7, -3
	ori $t7, $t7, 1059
	lu32i.d $t7, -1
	lu52i.d $t7, $t7, -1
	add.d $t7, $fp, $t7
	ld.b $t7, $t7, 0
	bnez $t7, .main_label2
	b .main_label5
.main_label2:
# %op3 = phi i32 [ 0, %label_entry ], [ %op11, %label10 ]
# %op4 = icmp sge i32 %op3, 0
	lu12i.w $t7, -3
	ori $t7, $t7, 1052
	lu32i.d $t7, -1
	lu52i.d $t7, $t7, -1
	add.d $t7, $fp, $t7
	ld.w $t7, $t7, 0
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t7
	lu12i.w $t8, -3
	ori $t8, $t8, 1051
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.b $t7, $t8, 0
	addi.w $t8, $zero, 0
	lu12i.w $t7, -3
	ori $t7, $t7, 1052
	lu32i.d $t7, -1
	lu52i.d $t7, $t7, -1
	add.d $t7, $fp, $t7
	ld.w $t7, $t7, 0
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	lu12i.w $t7, -3
	ori $t7, $t7, 1051
	lu32i.d $t7, -1
	lu52i.d $t7, $t7, -1
	add.d $t7, $fp, $t7
	ld.b $t7, $t7, 0
	or $t7, $t7, $t8
	lu12i.w $t8, -3
	ori $t8, $t8, 1051
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.b $t7, $t8, 0
# br i1 %op4, label %label7, label %label9
	lu12i.w $t7, -3
	ori $t7, $t7, 1051
	lu32i.d $t7, -1
	lu52i.d $t7, $t7, -1
	add.d $t7, $fp, $t7
	ld.b $t7, $t7, 0
	bnez $t7, .main_label7
	b .main_label9
.main_label5:
# %op6 = icmp ne i32 2800, 0
	lu12i.w $t7, 0
	ori $t7, $t7, 2800
	addi.w $t8, $zero, 0
	xor $t7, $t7, $t8
	sltu $t7, $zero, $t7
	lu12i.w $t8, -3
	ori $t8, $t8, 1050
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.b $t7, $t8, 0
# br i1 %op6, label %label13, label %label17
# %op14 = phi i32 [ 0, %label5 ], [ %op26, %label22 ]
	addi.w $t7, $zero, 0
	add.d $t7, $t7, $zero
	lu12i.w $t8, -3
	ori $t8, $t8, 1028
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.w $t7, $t8, 0
# %op15 = phi i32 [ 2800, %label5 ], [ %op27, %label22 ]
	lu12i.w $t7, 0
	ori $t7, $t7, 2800
	add.d $t7, $t7, $zero
	lu12i.w $t8, -3
	ori $t8, $t8, 1024
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.w $t7, $t8, 0
	lu12i.w $t7, -3
	ori $t7, $t7, 1050
	lu32i.d $t7, -1
	lu52i.d $t7, $t7, -1
	add.d $t7, $fp, $t7
	ld.b $t7, $t7, 0
	bnez $t7, .main_label13
	b .main_label17
.main_label7:
# %op8 = getelementptr [2801 x i32], [2801 x i32]* %op0, i32 0, i32 %op3
	lu12i.w $t8, -3
	ori $t8, $t8, 1052
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	ld.w $t8, $t8, 0
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	ld.d $t8, $fp, -24
	add.d $t7, $t8, $t7
	lu12i.w $t8, -3
	ori $t8, $t8, 1040
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.d $t7, $t8, 0
# br label %label10
	b .main_label10
.main_label9:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label10
	b .main_label10
.main_label10:
# store i32 2000, i32* %op8
	addi.w $t7, $zero, 2000
	lu12i.w $t8, -3
	ori $t8, $t8, 1040
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	ld.d $t8, $t8, 0
	st.w $t7, $t8, 0
# %op11 = add i32 %op3, 1
	lu12i.w $t7, -3
	ori $t7, $t7, 1052
	lu32i.d $t7, -1
	lu52i.d $t7, $t7, -1
	add.d $t7, $fp, $t7
	ld.w $t7, $t7, 0
	addi.w $t8, $zero, 1
	add.w $t7, $t7, $t8
	lu12i.w $t8, -3
	ori $t8, $t8, 1036
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.w $t7, $t8, 0
# %op12 = icmp slt i32 %op11, 2800
	lu12i.w $t7, -3
	ori $t7, $t7, 1036
	lu32i.d $t7, -1
	lu52i.d $t7, $t7, -1
	add.d $t7, $fp, $t7
	ld.w $t7, $t7, 0
	lu12i.w $t8, 0
	ori $t8, $t8, 2800
	slt $t7, $t7, $t8
	lu12i.w $t8, -3
	ori $t8, $t8, 1035
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.b $t7, $t8, 0
# br i1 %op12, label %label2, label %label5
# %op3 = phi i32 [ 0, %label_entry ], [ %op11, %label10 ]
	lu12i.w $t7, -3
	ori $t7, $t7, 1036
	lu32i.d $t7, -1
	lu52i.d $t7, $t7, -1
	add.d $t7, $fp, $t7
	ld.w $t7, $t7, 0
	add.d $t7, $t7, $zero
	lu12i.w $t8, -3
	ori $t8, $t8, 1052
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.w $t7, $t8, 0
	lu12i.w $t7, -3
	ori $t7, $t7, 1035
	lu32i.d $t7, -1
	lu52i.d $t7, $t7, -1
	add.d $t7, $fp, $t7
	ld.b $t7, $t7, 0
	bnez $t7, .main_label2
	b .main_label5
.main_label13:
# %op14 = phi i32 [ 0, %label5 ], [ %op26, %label22 ]
# %op15 = phi i32 [ 2800, %label5 ], [ %op27, %label22 ]
# %op16 = icmp ne i32 %op15, 0
	lu12i.w $t7, -3
	ori $t7, $t7, 1024
	lu32i.d $t7, -1
	lu52i.d $t7, $t7, -1
	add.d $t7, $fp, $t7
	ld.w $t7, $t7, 0
	addi.w $t8, $zero, 0
	xor $t7, $t7, $t8
	sltu $t7, $zero, $t7
	lu12i.w $t8, -3
	ori $t8, $t8, 1023
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.b $t7, $t8, 0
# br i1 %op16, label %label18, label %label22
# %op19 = phi i32 [ 0, %label13 ], [ %op50, %label49 ]
	addi.w $t7, $zero, 0
	add.d $t7, $t7, $zero
	lu12i.w $t8, -3
	ori $t8, $t8, 1016
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.w $t7, $t8, 0
# %op20 = phi i32 [ %op15, %label13 ], [ %op45, %label49 ]
	lu12i.w $t7, -3
	ori $t7, $t7, 1024
	lu32i.d $t7, -1
	lu52i.d $t7, $t7, -1
	add.d $t7, $fp, $t7
	ld.w $t7, $t7, 0
	add.d $t7, $t7, $zero
	lu12i.w $t8, -3
	ori $t8, $t8, 1012
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.w $t7, $t8, 0
	lu12i.w $t7, -3
	ori $t7, $t7, 1023
	lu32i.d $t7, -1
	lu52i.d $t7, $t7, -1
	add.d $t7, $fp, $t7
	ld.b $t7, $t7, 0
	bnez $t7, .main_label18
# %op23 = phi i32 [ 0, %label13 ], [ %op50, %label49 ]
	addi.w $t7, $zero, 0
	add.d $t7, $t7, $zero
	lu12i.w $t8, -3
	ori $t8, $t8, 1004
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.w $t7, $t8, 0
	b .main_label22
.main_label17:
# ret void
	addi.w $a0, $zero, 0
	b main_exit
.main_label18:
# %op19 = phi i32 [ 0, %label13 ], [ %op50, %label49 ]
# %op20 = phi i32 [ %op15, %label13 ], [ %op45, %label49 ]
# %op21 = icmp sge i32 %op20, 0
	lu12i.w $t7, -3
	ori $t7, $t7, 1012
	lu32i.d $t7, -1
	lu52i.d $t7, $t7, -1
	add.d $t7, $fp, $t7
	ld.w $t7, $t7, 0
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t7
	lu12i.w $t8, -3
	ori $t8, $t8, 1011
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.b $t7, $t8, 0
	addi.w $t8, $zero, 0
	lu12i.w $t7, -3
	ori $t7, $t7, 1012
	lu32i.d $t7, -1
	lu52i.d $t7, $t7, -1
	add.d $t7, $fp, $t7
	ld.w $t7, $t7, 0
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	lu12i.w $t7, -3
	ori $t7, $t7, 1011
	lu32i.d $t7, -1
	lu52i.d $t7, $t7, -1
	add.d $t7, $fp, $t7
	ld.b $t7, $t7, 0
	or $t7, $t7, $t8
	lu12i.w $t8, -3
	ori $t8, $t8, 1011
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.b $t7, $t8, 0
# br i1 %op21, label %label29, label %label32
	lu12i.w $t7, -3
	ori $t7, $t7, 1011
	lu32i.d $t7, -1
	lu52i.d $t7, $t7, -1
	add.d $t7, $fp, $t7
	ld.b $t7, $t7, 0
	bnez $t7, .main_label29
	b .main_label32
.main_label22:
# %op23 = phi i32 [ 0, %label13 ], [ %op50, %label49 ]
# %op24 = sdiv i32 %op23, 10000
	lu12i.w $t7, -3
	ori $t7, $t7, 1004
	lu32i.d $t7, -1
	lu52i.d $t7, $t7, -1
	add.d $t7, $fp, $t7
	ld.w $t7, $t7, 0
	lu12i.w $t8, 2
	ori $t8, $t8, 1808
	div.w $t7, $t7, $t8
	lu12i.w $t8, -3
	ori $t8, $t8, 1000
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.w $t7, $t8, 0
# %op25 = add i32 %op14, %op24
	lu12i.w $t7, -3
	ori $t7, $t7, 1028
	lu32i.d $t7, -1
	lu52i.d $t7, $t7, -1
	add.d $t7, $fp, $t7
	ld.w $t7, $t7, 0
	lu12i.w $t8, -3
	ori $t8, $t8, 1000
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	ld.w $t8, $t8, 0
	add.w $t7, $t7, $t8
	lu12i.w $t8, -3
	ori $t8, $t8, 996
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.w $t7, $t8, 0
# call void @printfour(i32 %op25)
	lu12i.w $a0, -3
	ori $a0, $a0, 996
	lu32i.d $a0, -1
	lu52i.d $a0, $a0, -1
	add.d $a0, $fp, $a0
	ld.w $a0, $a0, 0
	bl printfour
# %op26 = call i32 @mod(i32 %op23, i32 10000)
	lu12i.w $a0, -3
	ori $a0, $a0, 1004
	lu32i.d $a0, -1
	lu52i.d $a0, $a0, -1
	add.d $a0, $fp, $a0
	ld.w $a0, $a0, 0
	lu12i.w $a1, 2
	ori $a1, $a1, 1808
	bl mod
	lu12i.w $t8, -3
	ori $t8, $t8, 992
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.w $a0, $t8, 0
# %op27 = sub i32 %op15, 14
	lu12i.w $t7, -3
	ori $t7, $t7, 1024
	lu32i.d $t7, -1
	lu52i.d $t7, $t7, -1
	add.d $t7, $fp, $t7
	ld.w $t7, $t7, 0
	addi.w $t8, $zero, 14
	sub.w $t7, $t7, $t8
	lu12i.w $t8, -3
	ori $t8, $t8, 988
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.w $t7, $t8, 0
# %op28 = icmp ne i32 %op27, 0
	lu12i.w $t7, -3
	ori $t7, $t7, 988
	lu32i.d $t7, -1
	lu52i.d $t7, $t7, -1
	add.d $t7, $fp, $t7
	ld.w $t7, $t7, 0
	addi.w $t8, $zero, 0
	xor $t7, $t7, $t8
	sltu $t7, $zero, $t7
	lu12i.w $t8, -3
	ori $t8, $t8, 987
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.b $t7, $t8, 0
# br i1 %op28, label %label13, label %label17
# %op14 = phi i32 [ 0, %label5 ], [ %op26, %label22 ]
	lu12i.w $t7, -3
	ori $t7, $t7, 992
	lu32i.d $t7, -1
	lu52i.d $t7, $t7, -1
	add.d $t7, $fp, $t7
	ld.w $t7, $t7, 0
	add.d $t7, $t7, $zero
	lu12i.w $t8, -3
	ori $t8, $t8, 1028
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.w $t7, $t8, 0
# %op15 = phi i32 [ 2800, %label5 ], [ %op27, %label22 ]
	lu12i.w $t7, -3
	ori $t7, $t7, 988
	lu32i.d $t7, -1
	lu52i.d $t7, $t7, -1
	add.d $t7, $fp, $t7
	ld.w $t7, $t7, 0
	add.d $t7, $t7, $zero
	lu12i.w $t8, -3
	ori $t8, $t8, 1024
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.w $t7, $t8, 0
	lu12i.w $t7, -3
	ori $t7, $t7, 987
	lu32i.d $t7, -1
	lu52i.d $t7, $t7, -1
	add.d $t7, $fp, $t7
	ld.b $t7, $t7, 0
	bnez $t7, .main_label13
	b .main_label17
.main_label29:
# %op30 = getelementptr [2801 x i32], [2801 x i32]* %op0, i32 0, i32 %op20
	lu12i.w $t8, -3
	ori $t8, $t8, 1012
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	ld.w $t8, $t8, 0
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	ld.d $t8, $fp, -24
	add.d $t7, $t8, $t7
	lu12i.w $t8, -3
	ori $t8, $t8, 976
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.d $t7, $t8, 0
# %op31 = load i32, i32* %op30
	lu12i.w $t8, -3
	ori $t8, $t8, 976
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	ld.d $t8, $t8, 0
	ld.w $t7, $t8, 0
	lu12i.w $t8, -3
	ori $t8, $t8, 972
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.w $t7, $t8, 0
# br label %label33
	b .main_label33
.main_label32:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label33
	b .main_label33
.main_label33:
# %op34 = mul i32 %op31, 10000
	lu12i.w $t7, -3
	ori $t7, $t7, 972
	lu32i.d $t7, -1
	lu52i.d $t7, $t7, -1
	add.d $t7, $fp, $t7
	ld.w $t7, $t7, 0
	lu12i.w $t8, 2
	ori $t8, $t8, 1808
	mul.w $t7, $t7, $t8
	lu12i.w $t8, -3
	ori $t8, $t8, 968
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.w $t7, $t8, 0
# %op35 = add i32 %op19, %op34
	lu12i.w $t7, -3
	ori $t7, $t7, 1016
	lu32i.d $t7, -1
	lu52i.d $t7, $t7, -1
	add.d $t7, $fp, $t7
	ld.w $t7, $t7, 0
	lu12i.w $t8, -3
	ori $t8, $t8, 968
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	ld.w $t8, $t8, 0
	add.w $t7, $t7, $t8
	lu12i.w $t8, -3
	ori $t8, $t8, 964
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.w $t7, $t8, 0
# %op36 = mul i32 2, %op20
	addi.w $t7, $zero, 2
	lu12i.w $t8, -3
	ori $t8, $t8, 1012
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	ld.w $t8, $t8, 0
	mul.w $t7, $t7, $t8
	lu12i.w $t8, -3
	ori $t8, $t8, 960
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.w $t7, $t8, 0
# %op37 = sub i32 %op36, 1
	lu12i.w $t7, -3
	ori $t7, $t7, 960
	lu32i.d $t7, -1
	lu52i.d $t7, $t7, -1
	add.d $t7, $fp, $t7
	ld.w $t7, $t7, 0
	addi.w $t8, $zero, 1
	sub.w $t7, $t7, $t8
	lu12i.w $t8, -3
	ori $t8, $t8, 956
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.w $t7, $t8, 0
# %op38 = icmp sge i32 %op20, 0
	lu12i.w $t7, -3
	ori $t7, $t7, 1012
	lu32i.d $t7, -1
	lu52i.d $t7, $t7, -1
	add.d $t7, $fp, $t7
	ld.w $t7, $t7, 0
	addi.w $t8, $zero, 0
	slt $t7, $t8, $t7
	lu12i.w $t8, -3
	ori $t8, $t8, 955
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.b $t7, $t8, 0
	addi.w $t8, $zero, 0
	lu12i.w $t7, -3
	ori $t7, $t7, 1012
	lu32i.d $t7, -1
	lu52i.d $t7, $t7, -1
	add.d $t7, $fp, $t7
	ld.w $t7, $t7, 0
	xor $t8, $t8, $t7
	sltu $t8, $zero, $t8
	xori $t8, $t8, 1
	lu12i.w $t7, -3
	ori $t7, $t7, 955
	lu32i.d $t7, -1
	lu52i.d $t7, $t7, -1
	add.d $t7, $fp, $t7
	ld.b $t7, $t7, 0
	or $t7, $t7, $t8
	lu12i.w $t8, -3
	ori $t8, $t8, 955
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.b $t7, $t8, 0
# br i1 %op38, label %label39, label %label41
	lu12i.w $t7, -3
	ori $t7, $t7, 955
	lu32i.d $t7, -1
	lu52i.d $t7, $t7, -1
	add.d $t7, $fp, $t7
	ld.b $t7, $t7, 0
	bnez $t7, .main_label39
	b .main_label41
.main_label39:
# %op40 = getelementptr [2801 x i32], [2801 x i32]* %op0, i32 0, i32 %op20
	lu12i.w $t8, -3
	ori $t8, $t8, 1012
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	ld.w $t8, $t8, 0
	addi.w $t7, $zero, 4
	mul.w $t7, $t8, $t7
	ld.d $t8, $fp, -24
	add.d $t7, $t8, $t7
	lu12i.w $t8, -3
	ori $t8, $t8, 944
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.d $t7, $t8, 0
# br label %label42
	b .main_label42
.main_label41:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label42
	b .main_label42
.main_label42:
# %op43 = call i32 @mod(i32 %op35, i32 %op37)
	lu12i.w $a0, -3
	ori $a0, $a0, 964
	lu32i.d $a0, -1
	lu52i.d $a0, $a0, -1
	add.d $a0, $fp, $a0
	ld.w $a0, $a0, 0
	lu12i.w $a1, -3
	ori $a1, $a1, 956
	lu32i.d $a1, -1
	lu52i.d $a1, $a1, -1
	add.d $a1, $fp, $a1
	ld.w $a1, $a1, 0
	bl mod
	lu12i.w $t8, -3
	ori $t8, $t8, 940
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.w $a0, $t8, 0
# store i32 %op43, i32* %op40
	lu12i.w $t7, -3
	ori $t7, $t7, 940
	lu32i.d $t7, -1
	lu52i.d $t7, $t7, -1
	add.d $t7, $fp, $t7
	ld.w $t7, $t7, 0
	lu12i.w $t8, -3
	ori $t8, $t8, 944
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	ld.d $t8, $t8, 0
	st.w $t7, $t8, 0
# %op44 = sdiv i32 %op35, %op37
	lu12i.w $t7, -3
	ori $t7, $t7, 964
	lu32i.d $t7, -1
	lu52i.d $t7, $t7, -1
	add.d $t7, $fp, $t7
	ld.w $t7, $t7, 0
	lu12i.w $t8, -3
	ori $t8, $t8, 956
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	ld.w $t8, $t8, 0
	div.w $t7, $t7, $t8
	lu12i.w $t8, -3
	ori $t8, $t8, 936
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.w $t7, $t8, 0
# %op45 = sub i32 %op20, 1
	lu12i.w $t7, -3
	ori $t7, $t7, 1012
	lu32i.d $t7, -1
	lu52i.d $t7, $t7, -1
	add.d $t7, $fp, $t7
	ld.w $t7, $t7, 0
	addi.w $t8, $zero, 1
	sub.w $t7, $t7, $t8
	lu12i.w $t8, -3
	ori $t8, $t8, 932
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.w $t7, $t8, 0
# %op46 = icmp ne i32 %op45, 0
	lu12i.w $t7, -3
	ori $t7, $t7, 932
	lu32i.d $t7, -1
	lu52i.d $t7, $t7, -1
	add.d $t7, $fp, $t7
	ld.w $t7, $t7, 0
	addi.w $t8, $zero, 0
	xor $t7, $t7, $t8
	sltu $t7, $zero, $t7
	lu12i.w $t8, -3
	ori $t8, $t8, 931
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.b $t7, $t8, 0
# br i1 %op46, label %label47, label %label49
	lu12i.w $t7, -3
	ori $t7, $t7, 931
	lu32i.d $t7, -1
	lu52i.d $t7, $t7, -1
	add.d $t7, $fp, $t7
	ld.b $t7, $t7, 0
	bnez $t7, .main_label47
# %op50 = phi i32 [ %op44, %label42 ], [ %op48, %label47 ]
	lu12i.w $t7, -3
	ori $t7, $t7, 936
	lu32i.d $t7, -1
	lu52i.d $t7, $t7, -1
	add.d $t7, $fp, $t7
	ld.w $t7, $t7, 0
	add.d $t7, $t7, $zero
	lu12i.w $t8, -3
	ori $t8, $t8, 920
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.w $t7, $t8, 0
	b .main_label49
.main_label47:
# %op48 = mul i32 %op44, %op45
	lu12i.w $t7, -3
	ori $t7, $t7, 936
	lu32i.d $t7, -1
	lu52i.d $t7, $t7, -1
	add.d $t7, $fp, $t7
	ld.w $t7, $t7, 0
	lu12i.w $t8, -3
	ori $t8, $t8, 932
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	ld.w $t8, $t8, 0
	mul.w $t7, $t7, $t8
	lu12i.w $t8, -3
	ori $t8, $t8, 924
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.w $t7, $t8, 0
# br label %label49
# %op50 = phi i32 [ %op44, %label42 ], [ %op48, %label47 ]
	lu12i.w $t7, -3
	ori $t7, $t7, 924
	lu32i.d $t7, -1
	lu52i.d $t7, $t7, -1
	add.d $t7, $fp, $t7
	ld.w $t7, $t7, 0
	add.d $t7, $t7, $zero
	lu12i.w $t8, -3
	ori $t8, $t8, 920
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.w $t7, $t8, 0
	b .main_label49
.main_label49:
# %op50 = phi i32 [ %op44, %label42 ], [ %op48, %label47 ]
# %op51 = icmp ne i32 %op45, 0
	lu12i.w $t7, -3
	ori $t7, $t7, 932
	lu32i.d $t7, -1
	lu52i.d $t7, $t7, -1
	add.d $t7, $fp, $t7
	ld.w $t7, $t7, 0
	addi.w $t8, $zero, 0
	xor $t7, $t7, $t8
	sltu $t7, $zero, $t7
	lu12i.w $t8, -3
	ori $t8, $t8, 919
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.b $t7, $t8, 0
# br i1 %op51, label %label18, label %label22
# %op19 = phi i32 [ 0, %label13 ], [ %op50, %label49 ]
	lu12i.w $t7, -3
	ori $t7, $t7, 920
	lu32i.d $t7, -1
	lu52i.d $t7, $t7, -1
	add.d $t7, $fp, $t7
	ld.w $t7, $t7, 0
	add.d $t7, $t7, $zero
	lu12i.w $t8, -3
	ori $t8, $t8, 1016
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.w $t7, $t8, 0
# %op20 = phi i32 [ %op15, %label13 ], [ %op45, %label49 ]
	lu12i.w $t7, -3
	ori $t7, $t7, 932
	lu32i.d $t7, -1
	lu52i.d $t7, $t7, -1
	add.d $t7, $fp, $t7
	ld.w $t7, $t7, 0
	add.d $t7, $t7, $zero
	lu12i.w $t8, -3
	ori $t8, $t8, 1012
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.w $t7, $t8, 0
	lu12i.w $t7, -3
	ori $t7, $t7, 919
	lu32i.d $t7, -1
	lu52i.d $t7, $t7, -1
	add.d $t7, $fp, $t7
	ld.b $t7, $t7, 0
	bnez $t7, .main_label18
# %op23 = phi i32 [ 0, %label13 ], [ %op50, %label49 ]
	lu12i.w $t7, -3
	ori $t7, $t7, 920
	lu32i.d $t7, -1
	lu52i.d $t7, $t7, -1
	add.d $t7, $fp, $t7
	ld.w $t7, $t7, 0
	add.d $t7, $t7, $zero
	lu12i.w $t8, -3
	ori $t8, $t8, 1004
	lu32i.d $t8, -1
	lu52i.d $t8, $t8, -1
	add.d $t8, $fp, $t8
	st.w $t7, $t8, 0
	b .main_label22
main_exit:
	lu12i.w $t0, 2
	ori $t0, $t0, 3184
	lu32i.d $t0, 0
	lu52i.d $t0, $t0, 0
	add.d $sp, $sp, $t0
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
