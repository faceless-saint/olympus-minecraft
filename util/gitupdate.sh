#!/bin/bash
##
##  Synchronize a local git repository with a given remote branch,
##  discarding any local changes to the repository.
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
# Usage: "gitupdate.sh <directory> [branch]"
#   <directory> must be a git repository
#   [branch] defaults to "master"
#

#parse script arguments
case $# in
    1)
        echo "Syncing git repository..."
        DIR="$1"
        BRANCH="master"
        ;;        
    2)
        echo "Syncing git repository using branch \"$2\"..."
        DIR="$1"
        BRANCH="$2"
        ;;
    *)
        echo "Err: invalid arguments"
        echo "  usage: gitupdate.sh <directory> [branch]"
        exit 1
        ;;
esac

#move into target directory
if [ -d $DIR ]; then
    cd $DIR
else
    echo "Err: target does not exist"
    exit 1
fi

#temporarily stop tracking this script in git
echo "$0" >> .gitignore

#pull down latest remote status
if [ -d .git ]; then
    git fetch origin $BRANCH
    git reset --hard FETCH_HEAD
else
    echo "Err: target is not a git repository"
    exit 1
fi

echo "Done!"
exit 0
