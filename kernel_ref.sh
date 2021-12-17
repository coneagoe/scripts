#!/bin/bash -
#===============================================================================
#
#          FILE: kernel_ref.sh
#
#         USAGE: ./kernel_ref.sh
#
#   DESCRIPTION: used to generate kernel's tags and cscope
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR:
#  ORGANIZATION:
#       CREATED: 05/13/2020 09:55:41 AM
#      REVISION:  ---
#===============================================================================

set -o nounset                                  # Treat unset variables as an error

gScriptName=$(basename $0)
source $HOME/scripts/shellLog.sh > /dev/null

usage ()
{
  echo "Usage: $gScriptName <arch> [subarch]"
  echo "arch: see arch/"
  echo "subarch: see arch/xxx/ if needed"
}	# ----------  end of function usage  ----------

if [ $# -ne 1 ] && [ $# -ne 2 ]; then
  usage
  exit 0
fi

if [ $1 == "-h" ] || [ $1 == "--help" ]; then
  usage
  exit 0
fi

if [ ! -e arch/$1 ]; then
  ERROR "No such arch $1, please check."
  exit 0
fi

if [ $# -eq 1 ]; then
  make O=. ARCH=$1 COMPILED_SOURCE=1 cscope tags
elif [ $# -eq 2 ]; then
  if [ ! -e arch/$1/$2 ]; then
    ERROR "No such subarch $2, please check."
    exit 0
  fi

  make O=. ARCH=$1 SUBARCH=$2 COMPILED_SOURCE=1 cscope tags
fi


