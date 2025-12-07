NF {
    part2();
}

function part1() {
    tens=getBiggestDigitIndex($0, 0, 1)
    #printf "tens=%s\n", substr($0, tens, 1)
    
    ones=getBiggestDigitIndex($0, tens, 0)
    #printf "ones=%s\n", substr($0, ones, 1)

    # print the actual output:
    printf "%s%s\n", substr($0, tens, 1), substr($0, ones, 1)
}

function part2() {
    startIndex=0
    for (j = 1; j <= 12; j++) {
        indices[j]=getBiggestDigitIndex($0, startIndex, 12-j)
        startIndex=indices[j]
        #printf "%s -> j=%s, index=%s & v=%s\n", $0, j, indices[j], substr($0, indices[j], 1)
    }

    for (j = 1; j <= 12; j++) {
        printf "%s", substr($0, indices[j], 1)
    }
    print ""
}

function getBiggestDigitIndex(str, startIndex, skipLast) {
    max = 0
    maxIndex = 0
    for (i = startIndex + 1; i <= length(str) - skipLast; i++) { # damn 1-index arrays again
        v=substr(str, i, 1)
        if (v > max) {
            max = v
            maxIndex = i
        }
        else {
            #printf "%s is not bigger than %s\n", v, max
        }
    }
    return maxIndex
}