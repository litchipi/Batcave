#!/bin/bash

BCK_FNAME=$1
cantreadth1s $BCK_FNAME --outfile bck.zip
unzip bck.zip
rm bck.zip
cd env
git init
echo "$(ls envbck)" > list_envs
git add *
git commit -m "Loading bck $BCK_FNAME"
for e in $(ls envbck);
do
    git branch $e
    git checkout $e
    git apply envbck/$e/*.patch
    git add *
    git commit -m "Applied patches from bck"
    git checkout master
done
rm -r envbck
