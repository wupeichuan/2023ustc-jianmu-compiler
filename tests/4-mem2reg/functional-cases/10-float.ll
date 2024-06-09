; ModuleID = 'cminus'
source_filename = "/home/hzw/桌面/2023ustc-jianmu-compiler/tests/4-mem2reg/functional-cases/10-float.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define i32 @main() {
label_entry:
  %op0 = fmul float 0x3ff19999a0000000, 0x3ff8000000000000
  %op1 = fadd float %op0, 0x3ff3333340000000
  call void @outputFloat(float %op1)
  ret i32 0
}
