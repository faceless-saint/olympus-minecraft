#!/bin/bash
##
##  Symbolicly link all files in one directory into another, with an
##  optional blacklist to exclude specific files from being linked.
##
############################################################################
# This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
############################################################################
# Usage: "linkupdate.sh <destination> <source> [blacklist]"
#   links to all files in <source> are created in <destination>
#   files in <destination> listed in [blacklist] are removed
#

#save old IFS and update to only newline
IFS_backup=$IFS
IFS='
'

#parse script arguments
case $# in
    2)
        destination="$1"
        source="$2"
        blacklist=""
        echo "\"$destination\" <-- \"$source\""
        ;;
    3)
        destination="$1"
        source="$2"
        blacklist="$3"
        echo "\"$destination\" <-- \"$source\" ($blacklist)"
        ;;
    *)
        echo "Err: invalid arguments"
        echo "  usage: gitupdate.sh <directory> [branch]"
        exit 1
        ;;
esac

#navigate to destination directory
root_dir=`pwd`
cd $destination

#clean old links from destination
echo -n "Cleaning destination... "
for i in *; do
    if [ -h "$i" ]; then
        rm -rf "$i"
    fi
done
echo "Done."

#link files from source to destination
echo -n "Generating links... "
for i in "${source}"/*; do
    ln -s "$i" `basename "$i"`
done
echo "Done."

#return to local root directory
cd $root_dir

#remove blacklisted items
if [ -f "${blacklist}" ]; then
    echo -n "Parsing blacklist... "
    while read i
    do
        if [ -e "$destination/$i" ]; then
            rm -qrf "$destination/$i"
        fi
    done < $blacklist
    echo "Done."
fi

#restore old IFS
IFS=$IFS_backup

exit 0
