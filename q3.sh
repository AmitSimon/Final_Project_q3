#!/bin/bash

#Input
read -p "Enter a 5-letter word: " word
read -p "Enter the colors of the letters (g for green, y for yellow, s for gray): " colors

#Convert to lower case
word=$(echo "$word" | tr 'A-Z' 'a-z')
colors=$(echo "$colors" | tr 'A-Z' 'a-z')

#Check if there are 5 characters
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

#Finding all the letters that shouldn't appear
excluded=""
for (( i=0; i<5; i++ )); do
    if [[ ${colors:$i:1} == "s" && ${word:$i:1} != *[!${word:$i:1}]* ]]; then
        excluded+="${word:$i:1}"
    fi
done

#Search the words in the words.txt file
results=$(grep -i "^$pattern$" words.txt | grep -vi "[$excluded]")

#Filter the yellow letters
for letter in $(echo "$yellow_letters" | fold -w1 | sort -u); do
    results=$(echo "$results" | grep -i "$letter")
done

echo "$results"

