#!/bin/bash
#===============================================================================
#
#          FILE: shellLog.sh
# 
#         USAGE: source shellLog.sh 
# 
#   DESCRIPTION: color table refer to https://github.com/yonchu/shell-color-pallet
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: coneagoe
#  ORGANIZATION: 
#       CREATED: 03/20/2014 01:17
#      REVISION:  ---
#===============================================================================

# set -o nounset                              # Treat unset variables as an error


#-------------------------------------------------------------------------------
# control
#-------------------------------------------------------------------------------
_DEBUG='off'
_INFO='on'
_WARN='on'
_ERROR='on'


#-------------------------------------------------------------------------------
# color
#-------------------------------------------------------------------------------
PREFIX="[38;05;"
DEFAULT_COLOR='\e[0m'    # Text Reset
DEBUG_COLOR="${PREFIX}239m"
INFO_COLOR="${PREFIX}015m"
WARN_COLOR="${PREFIX}011m"
ERROR_COLOR="${PREFIX}196m"

DEBUG ()
{
    if [[ "$_DEBUG" == 'on' ]]; then
        echo -e "${DEBUG_COLOR}[DEBUG] $gScriptName: $@${DEFAULT_COLOR}" 1>&2
    fi
}	# ----------  end of function DEBUG  ----------


INFO ()
{
    if [[ "$_INFO" == 'on' ]]; then
        echo -e "${INFO_COLOR}[INFO] $gScriptName: $@${DEFAULT_COLOR}" 1>&2
    fi
}	# ----------  end of function INFO  ----------


WARN ()
{
    if [[ "$_WARN" == 'on' ]]; then
        echo -e "${WARN_COLOR}[WARN] $gScriptName: $@${DEFAULT_COLOR}" 1>&2
    fi
}	# ----------  end of function WARN  ----------


ERROR ()
{
    if [[ "$_ERROR" == 'on' ]]; then
        echo -e "${ERROR_COLOR}[ERROR] $gScriptName: $@${DEFAULT_COLOR}" 1>&2
    fi
}	# ----------  end of function ERROR  ----------


