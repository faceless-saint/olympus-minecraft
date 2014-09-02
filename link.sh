#!/bin/bash
shopt -s nullglob

#save old IFS and update to ignore spaces
IFS_backup=$IFS
IFS='
'

#parse script arguments
if [ $# -lt 2 ] || [ $# -gt 3 ] || [ "$1" == "--help" ]; then
    echo "  Usage: \"link <destination> <source> [blacklist]"
    exit 0;
fi

destination=$1
source=$2
blacklist=$3

echo "\"$destination\" <-- \"$source\" ($blacklist)"

#navigate to destination directory
root_dir=`pwd`
cd $destination

#clean old links from destination
echo "Cleaning destination..."
for i in *; do
    if [ -h "$i" ]; then
        rm "$i"
    fi
done

#link files from source to destination
echo "Generating links..."
for i in "${source}"/*; do
    ln -s "$i" `basename "$i"`
done

#return to local root directory
cd $root_dir

#remove blacklisted items
if [ -f "${blacklist}" ]; then
    echo "Parsing blacklist..."
    while read i
    do
        if [ -e "$destination/$i" ]; then
            rm "$destination/$i"
        fi
    done < $blacklist
fi

echo "Done!"

#restore old IFS
IFS=$IFS_backup
