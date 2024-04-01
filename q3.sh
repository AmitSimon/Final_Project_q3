#!/bin/bash

#input
read -p "Enter a 5-letter word: " word
read -p "Enter the colors of the letters (g for green, y for yellow, s for gray): " colors

# check if there are 5 characters
if [[ ${#word} -ne 5 || ${#colors} -ne 5 ]]; then
    echo "Error: Word and colors must be 5 characters long."
    exit 1
fi

#Search the pattern
pattern=""
yellow_letters=""
for (( i=0; i<5; i++ )); do
    if [[ ${colors:$i:1} == "g" ]]; then
        pattern+=${word:$i:1}
    elif [[ ${colors:$i:1} == "y" ]]; then
        pattern+="[^${word:$i:1}]"
        yellow_letters+=${word:$i:1}
    else
        pattern+="."
    fi
done
