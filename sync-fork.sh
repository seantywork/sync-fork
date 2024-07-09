#!/bin/bash

STREAM_MAIN=($(cat stream_main.txt))



INDEX=0
LENGTH=${#STREAM_MAIN[@]}

echo "length: $LENGTH"


function do_sync(){

    target="$1"

    gh repo sync "$target"

}

for target in "${STREAM_MAIN[@]}"
do


    echo "--------------------------"
    echo "TARGET: $target"
    echo "--------------------------"

    do_sync $target 

    INDEX=$((INDEX + 1))


done


