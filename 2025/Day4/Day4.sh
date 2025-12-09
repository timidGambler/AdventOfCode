function charAtCoord() { # contents, linelength, x, y where 0,0 is the first character
    #echo "len=$2, x=$3, y=$4"
    linearCoord=$(($4 * $2 + $3))
    #echo "linearCoord="$linearCoord

    if [ $4 -lt 0 ] || [ $3 -lt 0 ]; then
        echo "-"
        return
    fi
    if [ $3 -ge $2 ] || [ $linearCoord -ge ${#contents} ]; then
        echo "-"
        return
    fi

    echo ${contents:linearCoord:1}
}

function findMaxRollsFile() {
    line1=`head $1 -n 1`
    width=$((${#line1}))
    # echo "width=$width"

    contents=$(<$1)
    contents=${contents//$'\n'/} # "parameter expansion" to remove all newlines (we don't need them anymore and they just cause trouble)
    # echo "content length=${#contents}"
    height=$((${#contents}/$width))
    # echo "height=$height"
    availableRolls=$((0))

    newFileContent=''

    for ((h=0; h < height; h++)); do
        for ((w=0; w < width; w++)); do
            currChar=`charAtCoord $contents $width $w $h`
            if [ $currChar != "@" ]; then 
                if [ $currChar != "-" ]; then 
                    newFileContent=$newFileContent$currChar
                fi
                continue
            fi

            #echo "$w,$h =" `charAtCoord $contents $width $w $h`
            adjRolls=$((0))
            # up one row
            if [ `charAtCoord $contents $width $(($w-1)) $(($h-1))` == "@" ]; then adjRolls=$(($adjRolls+1)); fi
            if [ `charAtCoord $contents $width $(($w)) $(($h-1))` == "@" ]; then adjRolls=$(($adjRolls+1)); fi
            if [ `charAtCoord $contents $width $(($w+1)) $(($h-1))` == "@" ]; then adjRolls=$(($adjRolls+1)); fi
            # left+right
            if [ `charAtCoord $contents $width $(($w-1)) $(($h))` == "@" ]; then adjRolls=$(($adjRolls+1)); fi
            if [ `charAtCoord $contents $width $(($w+1)) $(($h))` == "@" ]; then adjRolls=$(($adjRolls+1)); fi
            # down one
            if [ `charAtCoord $contents $width $(($w-1)) $(($h+1))` == "@" ]; then adjRolls=$(($adjRolls+1)); fi
            if [ `charAtCoord $contents $width $(($w)) $(($h+1))` == "@" ]; then adjRolls=$(($adjRolls+1)); fi
            if [ `charAtCoord $contents $width $(($w+1)) $(($h+1))` == "@" ]; then adjRolls=$(($adjRolls+1)); fi

            if [ $adjRolls -lt 4 ]; then 
                availableRolls=$(($availableRolls+1));
                newFileContent=${newFileContent}.
            else
                newFileContent=$newFileContent$currChar
            fi
        done
    done

    if [[ $2 != "" ]]; then
        echo $newFileContent | fold -w $width > $2
    fi

    echo $availableRolls
}

function findFinalRollTotal() {

    removedRolls=`findMaxRollsFile $1 temp_0.txt`
    totalRemoved=$removedRolls
    itor=0
    while [[ $removedRolls -gt 0 ]]
    do
        removedRolls=`findMaxRollsFile "temp_$itor.txt" "temp_"$(($itor+1))".txt"`
        totalRemoved=$(($totalRemoved+$removedRolls))
        itor=$(($itor+1))
    done

    echo $totalRemoved
}

function test() { # testname, expected result, function, func param
    v=`$3 $4 $5` # todo is there a snazzy way to pass 4+ as arbitrary array of all the remaining args? $@ or $* maybe?
    if [ "$v" == "$2" ]; then
        echo "$1 pass"
    else
        echo "$1 fail got $v expected $2"
    fi
}

function runTests1() {
    # just run every provided example, why not
    echo "tests:"
    test "test1" 13 findMaxRollsFile "eric_input.txt"
    
    echo
}

function runTests2() {
    # just run every provided example, why not
    echo "tests:"
    # test "test1" 13 findMaxRollsFile "eric_input.txt" "eric_input_1.txt"
    # test "test2" 12 findMaxRollsFile "eric_input_1.txt" "eric_input_2.txt"
    # test "test3" 7 findMaxRollsFile "eric_input_2.txt" "eric_input_3.txt"
    # test "test4" 5 findMaxRollsFile "eric_input_3.txt" "eric_input_4.txt"
    # test "test5" 2 findMaxRollsFile "eric_input_4.txt" "eric_input_5.txt"
    # test "test6" 1 findMaxRollsFile "eric_input_5.txt" "eric_input_6.txt"
    # test "test7" 1 findMaxRollsFile "eric_input_6.txt" "eric_input_7.txt"
    # test "test8" 1 findMaxRollsFile "eric_input_7.txt" "eric_input_8.txt"
    # test "test9" 1 findMaxRollsFile "eric_input_8.txt" "eric_input_9.txt"
    test "test10" 43 findFinalRollTotal "eric_input.txt"

    rm eric_input_*
    rm temp_*
    
    echo
}

runTests2

echo "final answer:"
findFinalRollTotal input.txt