BEGIN {
    RS=","
}
NF {
    split($0, arr, "-")
    part1(arr[1], arr[2])
    #print arr[2] - arr[1]
}

function part1 (low, high) {
    #printf "%s to %s\n", low, high

    for (i = low; i <= high; i++) {
        len = length(i)
        a = substr(i + "", 1, len/2)
        b = substr(i + "", len/2 + 1, len)
        #printf "%u (len %u, half len %u) => a=%u & b=%u\n", i, len, len/2, a, b
        if (a == b)
            print i
    }
}

function part2 (low, high) {
    
}