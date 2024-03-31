#!/bin/bash

#input
read -p "Enter a 5-letter word: " word
read -p "Enter the colors of the letters (g for green, y for yellow, s for gray): " colors

# check if there are 5 characters
if [[ ${#word} -ne 5 || ${#colors} -ne 5 ]]; then
    echo "Error: Word and colors must be 5 characters long."
    exit 1
fi
