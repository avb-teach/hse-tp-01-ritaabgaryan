#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Need 2 arguments: input dir and output dir"
    exit 1
fi

input_dir="$1"
output_dir="$2"

if [ ! -d "$input_dir" ]; then
    echo "Input dir does not exist: $input_dir"
    exit 1
fi

mkdir -p "$output_dir"

find "$input_dir" -type f | while read file; do
    filename=$(basename "$file")
    counter=1
    newname="$filename"
    while [ -f "$output_dir/$newname" ]; do
        extension="${filename##*.}"
        basename="${filename%.*}"
        newname="${basename}${counter}.${extension}"
        counter=$((counter+1))
    done
    cp "$file" "$output_dir/$newname"
done

echo "Files copied to $output_dir"