#!/bin/bash
#Generate a new testbench for a verilog file!
echo Enter verilog file path.
read VERILOG_FILE
if !(test -f $VERILOG_FILE); then
    echo "Error: File $VERILOG_FILE not found!"
    exit 1
fi

echo Verilating
bash scripts/runTest.sh -v $VERILOG_FILE
NAME="$(basename $VERILOG_FILE .vs)"
echo Creating test bench $NAME.cpp

if test -f "./test/test_verilator/test_bench_template.templ"; then
    echo "Copying template"
    cp test/test_verilator/test_bench_template.templ test/test_verilator/$NAME.cpp
    echo replacing template name
    sed -i "s/\[MODULE_NAME\]/$NAME/g" test/test_verilator/$NAME.cpp
    echo Enjoy your new template: test/test_verilator/$NAME.cpp
else
    echo "Error: No test bench template found"
fi
