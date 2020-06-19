#!/bin/sh

ZIP_NAME=bck_all
cd $(dirname $0)/env
mkdir -p envbck
for ref in $(git for-each-ref --format='%(refname)' refs/heads/); do
    branch=$(echo $ref|cut -d '/' -f 3)
    echo $branch
    git checkout $branch
    git format-patch --root
    mkdir envbck/$branch
    mv *.patch envbck/$branch/
done
cd ..
zip $ZIP_NAME.zip -r ./env/envbck/* $@
rm -r env/envbck/
cantreadth1s $ZIP_NAME.zip
rm $ZIP_NAME.zip
