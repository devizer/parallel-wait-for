#!/usr/bin/env bash

wget -O /tmp/bfg-1.13.0.jar --no-check-certificate 'https://github.com/devizer/glist/raw/master/bin/bfg-1.13.0.jar'

repo=parallel-wait-for
work=/transient-builds/defrag
pushd "$(dirname $0)" >/dev/null; ScriptDir="$(pwd)"; popd >/dev/null
mkdir -p $work
pushd $work
rm -rf $repo.git
git clone --mirror git@github.com:devizer/$repo
java -jar /tmp/bfg-1.13.0.jar --strip-blobs-bigger-than 1M $repo.git


cd $repo.git
git reflog expire --expire=now --all && git gc --prune=now --aggressive
git push

popd
rm -f /tmp/bfg-1.13.0.jar
