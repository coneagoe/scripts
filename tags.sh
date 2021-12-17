#!/bin/bash
#


#-------------------------------------------------------------------------------
# Debug
#-------------------------------------------------------------------------------
gScriptName=$(basename $0)
source $HOME/script/shellLog.sh > /dev/null


#-------------------------------------------------------------------------------
# globals
#-------------------------------------------------------------------------------
gDirList='dir.lst'

gType='c'

gUsage="$gScriptName <-t c/c++/python> [paths]"


while getopts :t: opt
do
	case ${opt} in
	t) gType="${OPTARG}";;
	?) echo $gUsage
		exit 1;;
	esac
done
shift $(expr ${OPTIND} - 1)

DEBUG $gType


if [ ! -e filelist ]; then
  find . -path .hg -prune -name '*.h' -o -name '*.hpp' -o -name '*.c' \
    -o -name '*.cc' -o -name '*.cpp' -o -name '*.cxx' > filelist
fi

ctags -L filelist -o .tags

cscope -bkq -i filelist


