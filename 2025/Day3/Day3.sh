#!/bin/bash

function findMaxJoltage() {
    echo $1 | awk -f Joltage.awk
}

function findMaxJoltageFile() {
    awk -f Joltage.awk $1 | jq -s 'add'
}

function test() { # testname, function, func param, expected result
    v=`$2 $3`
    if [ "$v" == "$4" ]; then
        echo "$1 pass"
    else
        echo "$1 fail got $v expected $4"
    fi
}

function runTests1() {
    # just run every provided example, why not
    echo "tests:"
    test "test1" findMaxJoltage "123" 23
    test "test2" findMaxJoltage "987654321111111" 98
    test "test3" findMaxJoltage "811111111111119" 89
    test "test4" findMaxJoltage "234234234234278" 78
    test "test5" findMaxJoltage "818181911112111" 92
    test "test6" findMaxJoltageFile "eric_input.txt" 357
    
    echo
}

runTests1

echo "final answer:"
findMaxJoltageFile input.txt