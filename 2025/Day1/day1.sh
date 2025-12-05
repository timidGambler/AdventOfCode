#!/bin/bash

# echo "Day 1 solver"
awk -F '' -f day1.awk input.txt

# part1: bash day1.sh | sort | uniq -c | head -1
# part2: bash day1.sh | grep -E "^[[:digit:]]+$" | jq -s 'add'