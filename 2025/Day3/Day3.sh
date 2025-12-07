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
    test "test1" findMaxJoltage "987654321111111" 98
    test "test2" findMaxJoltage "811111111111119" 89
    test "test3" findMaxJoltage "234234234234278" 78
    test "test4" findMaxJoltage "818181911112111" 92
    test "test5" findMaxJoltageFile "eric_input.txt" 357
    
    echo
}

function runTests2() {
    # just run every provided example, why not
    echo "tests:"
    test "test1" findMaxJoltage "987654321111111" 987654321111
    test "test2" findMaxJoltage "811111111111119" 811111111119
    test "test3" findMaxJoltage "234234234234278" 434234234278
    test "test4" findMaxJoltage "818181911112111" 888911112111
    test "test5" findMaxJoltageFile "eric_input.txt" 3121910778619
    
    echo
}

runTests2

echo "final answer:"
findMaxJoltageFile input.txt