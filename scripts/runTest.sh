#!/bin/bash
#Run a single verilator testbench
echo "Usage: -v verilog_file -t test_bench_file(Not needed if just verilating) -s(flag to include SDL) true"
SDL=false;
FILE="foobar";
TESTBENCH="foobar";
VERILATE_ONLY=false;

while getopts "v:t:s:" flag; do
    case $flag in
        s)
         SDL=true
        ;;
        v) 
            FILE=$OPTARG
        ;;
        t)
            TESTBENCH=$OPTARG
    esac
done


if !(test -f $FILE); then
    echo "Error: File $FILE not found!"
    exit 1
fi
if !(test -f $TESTBENCH); then
    echo Verilating only
    VERILATE_ONLY=true
fi





INCLUDES=""
#Find subdirectories
for D in $(find ./src -mindepth 0 -maxdepth 10 -type d); do
    INCLUDES="$INCLUDES -y $D"
done
echo Includes $INCLUDES

echo Clearing build directory
rm -rf ./obj_dir

echo "Verilating $FILE"
COMMAND="$INCLUDES -Wno-fatal -Wall +libext+.vs --trace --x-assign unique --x-initial unique --cc $FILE"
if !($VERILATE_ONLY); then
    echo "Using $TESTBENCH"
    COMMAND="$COMMAND --exe $TESTBENCH"
fi

if $SDL; then
    echo "Using SDL"
    verilator $COMMAND -CFLAGS "$(sdl2-config --cflags)" -LDFLAGS "$(sdl2-config --libs)"
else
    verilator $COMMAND
fi

if $VERILATE_ONLY; then
    exit 0
fi

NAME="$(basename $FILE .vs)"
echo "Bulding $NAME"
make -C obj_dir -f V$NAME.mk V$NAME
echo Running $FILE
obj_dir/V$NAME +verilator+rand+reset+2
RET=$?
if [ $RET -eq 0 ]; then
    echo "Test $NAME passed"
else
    echo "Test $NAME failed"
fi
 
