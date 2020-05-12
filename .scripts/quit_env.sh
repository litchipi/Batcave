#!/bin/bash

curr_branch=$(git branch|grep "*"|cut -d ' ' -f 2)
echo $curr_branch
if [ $curr_branch -eq "master" ]; then
    echo "Nothing to do\n"
    echo "\tTo reset master branch do: \"git reset --hard HEAD\""
else
    mv ./.env ./env
    mv ./nobck ./.nobck_$curr_branch
    git add *
    git add .env env
    git commit -m "Quitting env"
    git checkout master
    clear
    echo "Exited $curr_branch"
fi
