#!/bin/sh
#===============================================================================
#
#          FILE: ftrace.sh
#
#         USAGE: start trace
#                   ftrace.sh or ftrace.sh <cmd>
#                stop trace
#                   echo 0 > /sys/kernel/debug/tracing/tracing_on
#                dump trace
#                   cat /sys/kernel/debug/tracing/trace > output_$(date +"%Y%m%d_%H_%M_%S")
#
#   DESCRIPTION: 
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 04/ 7/2021  2:44:14 PM
#      REVISION:  ---
#===============================================================================

#set -o nounset                                  # Treat unset variables as an error

cmd=''
pid=''
debugfs=/sys/kernel/debug
tracing_dir=$debugfs/tracing

if [ $# -lt 2 ] && [ -z $cmd ]; then
    echo "Please specifiy a cmd."
    exit 0
fi

mount -t debugfs none $debugfs
mount -t tracefs nodev $debugfs/tracing

# trace name foo
echo foo > $tracing_dir/current_tracer
echo nop > $tracing_dir/current_tracer

# stop trace
echo 0 > $tracing_dir/tracing_on

echo function_graph > $tracing_dir/current_tracer

# trace a specified process
#if [ -z $pid ]; then
#    pid=$$
#fi
#echo $pid > $tracing_dir/set_ftrace_pid

# trace spi
echo 1 > $tracing_dir/events/spi/enable
#echo 1 > $tracing_dir/events/spi/spi_transfer_start/enable
#echo 1 > $tracing_dir/events/spi/spi_transfer_stop/enable

# trace i2c
#echo 1 > $tracing_dir/events/i2c/enable

# trace the functions are you interested
echo at25_ee_write > $tracing_dir/set_graph_function

# start trace
echo 1 > $tracing_dir/tracing_on

#if [ $# -gt 1 ]; then
#    exec $@
#else
#    exec $cmd
#fi
#
## stop trace
#echo 0 > $tracing_dir/tracing_on
#
##suffix=$(date +"%Y%m%d_%H_%M_%S")
##output=output_$suffix
#output=output_$(date +"%Y%m%d_%H_%M_%S")
#cat $tracing_dir/trace > $output


