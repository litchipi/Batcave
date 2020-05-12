#!/bin/bash

if [ $# -gt 0 ]; then

    ls .git 1>/dev/null 2>/dev/null
    has_git=$?
    echo "$1"
    if [ "$1" = "RESET" ] || [ $has_git -eq 2 ]; then
        if [ "$1" = "RESET" ]; then
            read -r -N 1 -p "Are you sure ? [y/n] "
        else
            REPLY="y"
        fi
        if [[ $REPLY =~ ^[Yy]$ ]]
        then
            rm -rf .git
            git init
            echo -e "nobck/*\n.*" > .gitignore
            git add create_env
            git commit -m "Init"
            rm -rf ./.nobck_*
            clear
            echo "Env resetted"
            if [ "$1" = "RESET" ]; then
                exit 0
            fi
        fi
    fi

    exists=$(git branch|grep $1)
    if [ ! -z $exists ]; then
        git checkout $1
        mv create_env .create_env
        mv ./.nobck_$1 ./nobck
        clear
        echo "Loaded env $1"
    else
        git branch $1
        git checkout $1

        touch notes
        mkdir -p nobck

        ln -s ../.scripts/quit_env.sh quit_env
        chmod +x quit_env
        mv create_env .create_env
        git add *
        git add create_env .create_env
        git commit -m "$1 env init"
        clear
        echo "Created env $1"
        ls --color
    fi
else
    echo "usage: create_env <env name>"
fi
