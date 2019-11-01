#!/bin/bash -
#===============================================================================
#
#          FILE: build_env.sh
#
#         USAGE: ./build_env.sh
#
#   DESCRIPTION: 
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: 
#  ORGANIZATION: 
#       CREATED: 04/27/2018 02:41:21 PM
#      REVISION:  ---
#===============================================================================

set -o nounset                                  # Treat unset variables as an error


HOST_IP=$(hostname -I | awk '{print $1}')
BR_REPO_PREFIX=ssh://buildmgr@$HOST_IP
BR_REPO=""
BR_REV=""
OUTPUT_PATH=/repo3/xufengwu/buildme
LIMITED_BUILDS=""
OS_PATH=""
SUPERBATCH="n"
PACKAGE="y"
#--package_options "-a fant-g,nelt-b"
PACKAGE_OPTIONS=""
BUILD_ID=""

#MAKE="hmake"
MAKE="make IVY=ivy"


get_build_id()
{
    if [ ! -f $HOME/.build_id ]; then
        echo 826 > $HOME/.build_id
    fi

    build_id=$(cat $HOME/.build_id)
    build_id=$(($build_id + 1))
    if [[ $build_id > 829 ]]; then
        build_id=826
    fi

    echo $build_id > $HOME/.build_id
    echo $build_id
}



check ()
{
    if [ ! -d $SW_REPO/sw ]; then
        ERROR "$SW_REPO/sw doesn't exist!"
        exit 1
    fi

    if [[ $BR_REPO != "" && ! -d $BR_REPO ]]; then
        ERROR "$BR_REPO doesn't exist!"
        exit 1
    fi
}	# ----------  end of function check  ----------


build_me ()
{
    if [ $(hostname) == FNSHA189 ] ; then
        WARN "DO NOT run on FNSHA189"
    fi

    check

    cd $SW_REPO/sw

    build_id=$(get_build_id)

    local cmd="buildme -r $SW_REV"

    if [[ $PACKAGE == "y" ]]; then
        cmd="$cmd --package_directory $OUTPUT_PATH"

        if [[ $PACKAGE_OPTIONS != "" ]]; then
            cmd="$cmd --package_options \"$PACKAGE_OPTIONS\""
        fi
    fi

    cmd="$cmd --build_id $build_id \
        --no-sst --no-unittest --no-cppcheck"

    if [[ $LIMITED_BUILDS != "" ]]; then
        cmd="$cmd --limited_builds \"$LIMITED_BUILDS\""
    fi

    if [[ $SUPERBATCH == "y" ]]; then
        cmd="$cmd --superbatch"
    fi

    if [[ $BR_REPO != "" ]]; then
        cmd="$cmd --build_options \"-make='BUILDROOT_REPO=$BR_REPO_PREFIX/$BR_REPO BUILDROOT_REV=$BR_REV'\""
    fi

    echo $cmd

    eval $cmd
}	# ----------  end of function buildme  ----------


build ()
{
    if [ -z $BUILD_ID ]; then
        BUILD_ID=$(cat $HOME/.build_id)
    fi

    check

    local cmd="cd $OS_PATH && \
        $MAKE $* -j20 \
        VERS=$BUILD_ID"

    if [[ $BR_REPO != "" ]]; then
        cmd="$cmd BUILDROOT_REPO=$BR_REPO BUILDROOT_REV=$BR_REV"
    fi

    cmd="$cmd 2>&1 | tee log"

    echo $cmd

    eval $cmd
 
}	# ----------  end of function build  ----------


