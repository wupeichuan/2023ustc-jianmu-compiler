; ModuleID = 'cminus'
source_filename = "/home/hzw/桌面/2023ustc-jianmu-compiler/tests/testcases_general/19-global_local_var.cminus"

@a = global i32 zeroinitializer
declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define void @GlobalAssign() {
label_entry:
  store i32 10, i32* @a
  ret void
}
define i32 @main() {
label_entry:
  call void @GlobalAssign()
  ret i32 20
}
