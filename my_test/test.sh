#!/bin/bash

bash -c "cminusfc -emit-llvm -mem2reg test.cminus" 
bash -c "clang -O0 -w -no-pie test.ll -o test_0 -lcminus_io"
result_0=$(./test_0) 
echo "true result:${result_0}"
bash -c "cminusfc -S -mem2reg test.cminus" 
bash -c "loongarch64-unknown-linux-gnu-gcc -static test.s ../src/io/io.c -o test_1"
result_1=$(qemu-loongarch64 ./test_1) 
echo "my result:${result_1}"