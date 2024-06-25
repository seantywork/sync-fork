#!/bin/bash

STREAM_MAIN=($(cat stream_main.txt))

STREAM_UP=($(cat stream_up.txt))

STREAM_BRANCH=($(cat stream_branch.txt))

STREAM_NAME=($(cat stream_name.txt))

INDEX=0
LENGTH=${#STREAM_MAIN[@]}

echo "length: $LENGTH"


function do_sync(){

    target="$1"
    upstream="$2"
    branch="$3"
    name="$4"


    mkdir -p $name

    cd $name

    git clone $target .

    git remote add stream-up $upstream

    git fetch --all

    git rebase stream-up/$branch 

    git push

    cd ../

    rm -rf $name

}

for target in "${STREAM_MAIN[@]}"
do


    upstream="${STREAM_UP[$INDEX]}"
    branch="${STREAM_BRANCH[$INDEX]}"
    name="${STREAM_NAME[$INDEX]}"

    echo "--------------------------"
    echo "UP: $upstream"
    echo "MAIN: $target"
    echo "BRANCH: $branch"
    echo "NAME: $name"
    echo "--------------------------"

    do_sync $target $upstream $branch $name

    INDEX=$((INDEX + 1))



done


