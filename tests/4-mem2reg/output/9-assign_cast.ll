; ModuleID = 'cminus'
source_filename = "/home/hzw/桌面/2023ustc-jianmu-compiler/tests/testcases_general/9-assign_cast.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define i32 @main() {
label_entry:
  %op0 = icmp slt i32 1, 3
  %op1 = zext i1 %op0 to i32
  %op2 = sitofp i32 2 to float
  %op3 = fadd float %op2, 0x4003333340000000
  %op4 = fptosi float %op3 to i32
  %op5 = add i32 %op1, %op4
  ret i32 %op5
}
