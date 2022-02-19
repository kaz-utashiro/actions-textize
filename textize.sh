#!/bin/bash

set -e

target=textize
repository=../../textize 

[ -d $target/.git ] || git clone $repository $target

cd $target

: ${root:=.}

files=$(git ls-files)

for file in $files
do
    [[ "$file" =~ (.*)\.([a-z]+)$ ]] || continue
    base=${BASH_REMATCH[1]}
    suffix=${BASH_REMATCH[2]}
    case "$suffix" in
	docx)
	    txt="${base}_${suffix}.txt" ;;
	*)
	    continue ;;
    esac
    echo $txt
    if [ -f $txt ]
    then
	echo $txt exists
    else
	optex -Mtextconv cat $file > $txt
    fi
done
