#!/bin/bash

declare -a txtfiles

for file in $*
do
    [[ "$file" =~ (.*)\.([a-z]+)$ ]] || continue
    base=${BASH_REMATCH[1]}
    suffix=${BASH_REMATCH[2]}
    case "$suffix" in
	docx|pdf)
	    txt="${base}_${suffix}.txt" ;;
	*)
	    continue ;;
    esac
    if [ -f $txt ]
    then
	echo update $txt 1>&2
    else
	echo create $txt 1>&2
    fi
    optex -Mtextconv cat $file > $txt
    txtfiles+=($txt)
done

if (( ${#txtfiles[@]} > 0 ))
then
    echo ${txtfiles[@]}
fi
