#!/usr/bin/env bash

[ -z "$1" ] && echo "Directory input required" && exit 1
[ ! -d "$1" ] && echo "The given input is not a directory" && exit 1

cd "$1" || exit 1

# eml files
find . -iname "*.eml" -delete

# gz files
find . -iname "*.gz" -exec gunzip {} \;

# zip files
find . -iname "*.zip" -exec unzip -n {} \;
find . -iname "*.zip" -delete