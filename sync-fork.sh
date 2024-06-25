#!/bin/bash

STREAM_MAIN=($(cat stream_main.txt))

STREAM_UP=($(cat stream_up.txt))

STREAM_BRANCH=($(cat stream_branch.txt))

INDEX=0
LENGTH=${#STREAM_MAIN[@]}

echo "length: $LENGTH"

for target in "${STREAM_MAIN[@]}"
do

    mkdir -p target

    cd target

    upstream="${STREAM_UP[$INDEX]}"
    branch="${STREAM_BRANCH[$INDEX]}"

    echo "--------------------------"
    echo "UP: $upstream"
    echo "MAIN: $target"
    echo "BRANCH: $branch"
    echo "--------------------------"

    git clone $target .

    git remote add stream-up $upstream

    git fetch --all

    git rebase stream-up/$branch 

    git push

    INDEX=$((INDEX + 1))

    cd ../

    rm -rf target/*

done


