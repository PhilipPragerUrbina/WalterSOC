#!/bin/bash
#Build and run all testbenches!
echo "Verilator tester. Run in project directory."
echo "Verilog files must have .vs extension"
echo "Test benches must have same name as verilog file."

#find source files
find . -name "*.vs" -print0 | while read -d $'\0' file
do
    NAME="$(basename $file .vs)"
    if test -f "test/test_verilator/$NAME.cpp"; then
        bash scripts/runTest.sh -v $file -t test/test_verilator/$NAME.cpp
    else
        echo "Warning: No test bench for $file"
    fi
done

