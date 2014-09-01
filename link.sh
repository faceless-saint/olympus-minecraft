#!/bin/sh

#save old IFS and update to ignore spaces
IFS_backup=$IFS
IFS="\n"

#mod file source and destination directories
src_dir="minecraft/mods"
dest_dir="server/mods"

#path back to the root directory
rel_path="../.."

#update working directory
cd "$src_dir"

for f in *
do
	if [ -e $rel_path/$dest_dir/$f ]; then
		echo "Skipping: $f"
	else
		echo "Linking:  $f"
		ln -s "$rel_path/$src_dir/$f" "$rel_path/$dest_dir/$f"
	fi
done

cd $rel_path
while read line
do
	echo "Removing (client only): $line"
	rm -rf "$dest_dir/$line"
done < clientOnlyMods.dat

#restore old IFS
IFS=$IFS_backup

