BEGIN { 
    pointer=50;
}
NF { 
    part2()
}

function part1 () {
    startPos = pointer;
    dist=substr($0, 2, length($0)) + 0;
    if ($1 == "R") { 
        pointer += dist;
    } else {
        pointer -= dist;
    }

    initialChange = pointer
    if (pointer > 99) {
        pointer %= 100;
    }
    if (pointer < 0) {
        pointer = (100 + (pointer % 100)) % 100;
    }

    #printf "start %s, operation %s%s -> %s -> %s\n", startPos, $1, dist, initialChange, pointer
    print pointer;
}

function part2 () {
    startPos = pointer;
    dist=substr($0, 2, length($0)) + 0;
    if ($1 == "R") { 
        pointer += dist;
    } else {
        pointer -= dist;
    }

    initialChange = pointer
    if (pointer > 99) {
        #printf "initialChange %s passed zero %s times\n", initialChange, int(pointer / 100)
        print int(pointer / 100)
        pointer %= 100;
    }
    else if (pointer < 0) {
        #printf "initialChange %s passed zero %s times\n", initialChange, int(pointer / -100)
        if (int(pointer / -100) > 0) print int(pointer / -100);
        if (startPos > 0) print 1;
        pointer = (100 + (pointer % 100)) % 100;
    }
    else if (pointer == 0) {
        print 1;
    }

    printf "start %s, operation %s%s -> %s -> %s\n", startPos, $1, dist, initialChange, pointer
}