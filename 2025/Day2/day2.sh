#!/bin/bash

function runFile() {
    echo `cat $1 | awk -f day2.awk | jq -s 'add'`
}

function awkTestRange() {
    echo $2 | awk -f day2.awk | jq -s 'add'
}

function test() { # testname, function, func param, expected result
    v=`$2 $3`
    if [ "$v" == "$4" ]; then
        echo "$1 pass"
    else
        echo "$1 fail got $v expected $4"
    fi
}

function bashRunRange() {
    low=${1%-*}
    high=${1#*-}
    sum=0
    for ((i=$low; i <= $high; i++)); do
        len=${#i}
        if [ $((len % 2)) -eq 0 ]; then
            a=${i:0:len/2}
            b=${i:len/2:len}
            # echo a=$a b=$b
            if [ "$a" == "$b" ]; then
                sum=$(($sum + $a$b))
            fi
        fi
    done
    echo $sum
}

function bashRunRange2() {
    low=${1%-*}
    high=${1#*-}
    sum=0
    p='^([[:digit:]]+)\1+$'
    for ((i=$low; i <= $high; i++)); do
        if [[ $i =~ $p ]]; then
            sum=$(($sum + $i))
            i=$((i+10))
        fi
    done
    echo $sum
}

function bashTestRange() {
    sum=`bashRunRange $2`

    if [ "$sum" == "$3" ]; then
        echo "$1 pass"
    else
        echo "$1 fail got $v expected $3"
    fi
}

function bashRunFile() {
    str=`cat $1`
    sum=0
    IFS=','
    read -rasplitIFS<<< $str

    for word in "${splitIFS[@]}"; do
        sum=$((sum + `bashRunRange2 $word`))
    done
    IFS=''

    echo $sum
}

function runTests1() {
    # just run every provided example, why not
    echo "tests:"
    test "test1" $1 "11-22" 33
    test "test2" $1 "95-115" 99
    test "test3" $1 998-1012 1010
    test "test4" $1 1188511880-1188511890 1188511885
    test "test5" $1 222220-222224 222222
    test "test6" $1 1698522-1698528 $((0))
    test "test7" $1 446443-446449  446446
    test "test8" $1 38593856-38593862 38593859
    test "test9" $2 sample_input.txt 1227775554
    echo
}

function runTests2() {
    # just run every provided example, why not
    echo "tests:"
    test "test1" $1 "11-22" 33
    test "test2" $1 "95-115" 210
    test "test3" $1 998-1012 2009
    test "test4" $1 1188511880-1188511890 1188511885
    test "test5" $1 222220-222224 222222
    test "test6" $1 1698522-1698528 $((0))
    test "test7" $1 446443-446449  446446
    test "test8" $1 38593856-38593862 38593859
    test "test9" $1 565653-565659 565656
    test "test10" $1 824824821-824824827 824824824
    test "test11" $1 2121212118-2121212124 2121212121
    test "test12" $2 sample_input.txt 4174379265
    echo
}

# runTests awkTestRange runFile # awk is being too problematic, let's try keeping it in bash...
#runTests2 bashRunRange2 bashRunFile

echo "final answer:"
bashRunFile input.txt