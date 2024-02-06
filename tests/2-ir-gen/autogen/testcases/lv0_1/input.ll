; ModuleID = 'cminus'
source_filename = "/home/hzw/桌面/2023ustc-jianmu-compiler-master/tests/2-ir-gen/autogen/testcases/lv0_1/input.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define void @main() {
label_entry:
  %op0 = icmp eq i32 1, 1
  br i1 %op0, label %label_trueBB, label %label_brBB
label_trueBB:                                                ; preds = %label_entry, %label_trueBB
  %op1 = icmp eq i32 1, 1
  br i1 %op1, label %label_trueBB, label %label_brBB
label_brBB:                                                ; preds = %label_entry, %label_trueBB
  ret void
}
