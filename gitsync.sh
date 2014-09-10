#!/bin/bash
## Syncs a local git repository with a given remote branch
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

# Usage: "gitsync.sh <directory> [branch]"
#   <directory> must be a git repository
#   [branch] defaults to "master"

# Exit codes:
#   0 - normal (success)
#   1 - improper usage
#   2 - git failure

#location of git binary on this system
GIT_CMD="/usr/bin/git"

case $#
	1)
		echo "Syncing git repository at \"$1\"..."
		DIR="$1"
		BRANCH="master"
	;;
	
	2)
		echo "Syncing git repository at \"$1\" using branch \"$2\"..."
		DIR="$1"
		BRANCH="$2"
	;;
	
	*)
		echo "Err: invalid arguments"
		echo "  usage: gitsync.sh <dir> [branch]"
		exit 1
	;;
esac

## Move into target directory
if [ -d ${DIR} ]; then
	cd ${DIR}
else
	echo "Err: target does not exist"
	exit 1
fi

## Pull down latest remote status
if [ -d .git ]; then
	$GIT_CMD fetch origin ${BRANCH} or exit 2
	$GIT_CMD reset --hard FETCH_HEAD or exit 2
else
	echo "Err: target is not a git repository"
	exit 1
fi

echo "Done!"
exit 0
