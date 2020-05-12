#!/bin/sh

ZIP_NAME=bck_all
cd $(dirname $0)/env
mkdir -p envbck
for ref in $(git for-each-ref --format='%(refname)' refs/heads/); do
    branch=$(echo $ref|cut -d '/' -f 3)
    echo $branch
    git format-patch --root
    mkdir envbck/$branch
    mv *.patch envbck/$branch/
done
cd ..
zip $ZIP_NAME.zip -r ./env/envbck/*
rm -r env/envbck/
cantreadth1s $ZIP_NAME.zip

init_size=$(ls -lh $ZIP_NAME.zip | awk '{print $5}')
rm $ZIP_NAME.zip
dst_size=$(ls -lh $ZIP_NAME.zip.cant_read_this | awk '{print $5}')
echo "Backed up securely.\n\tSize " $init_size " -> " $dst_size
