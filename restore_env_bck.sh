#!/bin/bash

BCK_FNAME=$1
OUTDIR=$PWD
tmpdir=$(mktemp -d)
cantreadth1s $BCK_FNAME --outfile $tmpdir/bck.zip
patchdir=$tmpdir/env/envbck/
#cd $tmpdir
unzip $tmpdir/bck.zip -d $tmpdir
ls $tmpdir
rm -rf $OUTDIR/env && mkdir -p $OUTDIR/env && cd $OUTDIR/env
git init
echo "$(ls $patchdir)" > list_envs
git add * #list_envs create_env .quit_env
git commit -m "Loading bck $BCK_FNAME"
for e in $(ls $patchdir);
do
    git branch $e
    git checkout $e
    for f in $(ls $patchdir/$e/*.patch);
    do
        git apply --whitespace=nowarn $f
    done
    git add *
    git commit -m "Applied patches from bck"
    git checkout master
done
echo $tmpdir
ls $tmpdir
rm $tmpdir/bck.zip
rm -rf $tmpdir/env/
cp -u -r $tmpdir/* $OUTDIR
