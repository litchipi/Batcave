#!/bin/bash

curr_branch=$(git branch|grep "*"|cut -d ' ' -f 2)
echo $curr_branch
if [ $curr_branch -eq "master" ]; then
    echo "Nothing to do\n"
    echo "\tTo reset master branch do: \"git reset --hard HEAD\""
else
    mv ./.create_env ./create_env
    mv ./.list_envs ./list_envs
    mv ./nobck ./.nobck_$curr_branch
    git add *
    git add .create_env create_env .list_envs list_envs
    git commit -m "Quitting env"
    git checkout master
    clear
    echo "Exited $curr_branch"
fi
