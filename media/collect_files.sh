#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "You need to provide 2 arguments: input and output directory"
    exit 1
fi

input_dir="$1"
output_dir="$2"

if [ ! -d "$input_dir" ]; then
    echo "Input directory not found"
    exit 1
fi

mkdir -p "$output_dir"

counter=1
find "$input_dir" -type f | while read filepath; do
    filename=$(basename "$filepath")
    newname="$filename"
    while [ -e "$output_dir/$newname" ]; do
        name="${filename%.*}"
        ext="${filename##*.}"
        if [ "$name" = "$ext" ]; then
            newname="${name}_${counter}"
        else
            newname="${name}_${counter}.${ext}"
        fi
        counter=$((counter + 1))
    done
    cp "$filepath" "$output_dir/$newname"
done