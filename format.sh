#!/bin/bash

# clang-format
clang_format(){
    for filename in ${file_list[@]};
    do
        bash -c "clang-format -style=file -i ${filename}"
    done
}

file_list=$(find ./src -name '*.cpp' -o -name '*.c')
clang_format file_list
file_list=$(find ./include -name '*.hpp' -o -name '*.h')
clang_format file_list
