; ModuleID = 'cminus'
source_filename = "/home/hzw/桌面/2023ustc-jianmu-compiler/tests/4-mem2reg/functional-cases/11-floatcall.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define float @mod(float %arg0, float %arg1) {
label_entry:
  %op2 = alloca float
  store float %arg0, float* %op2
  %op3 = alloca float
  store float %arg1, float* %op3
  %op4 = load float, float* %op3
  %op5 = load float, float* %op2
  %op6 = fdiv float %op5, %op4
  %op7 = fptosi float %op6 to i32
  %op8 = load float, float* %op3
  %op9 = sitofp i32 %op7 to float
  %op10 = fmul float %op9, %op8
  %op11 = load float, float* %op2
  %op12 = fsub float %op11, %op10
  ret float %op12
}
define i32 @main() {
label_entry:
  %op0 = call float @mod(float 0x4026666660000000, float 0x40019999a0000000)
  call void @outputFloat(float %op0)
  ret i32 0
}
