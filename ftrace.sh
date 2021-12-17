#!/bin/bash -
#===============================================================================
#
#          FILE: ftrace.sh
#
#         USAGE: ./ftrace.sh
#
#   DESCRIPTION: 
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: 
#  ORGANIZATION: 
#       CREATED: 06/01/2021 09:28:12 AM
#      REVISION:  ---
#===============================================================================

set -o nounset                                  # Treat unset variables as an error

debugfs=/sys/kernel/debug
echo nop > $debugfs/tracing/current_tracer
echo 0 > $debugfs/tracing/tracing_on
echo $$ > $debugfs/tracing/set_ftrace_pid
echo function_graph > $debugfs/tracing/current_tracer
#replace test_proc_show by your function name
echo test_proc_show > $debugfs/tracing/set_graph_function
echo 1 > $debugfs/tracing/tracing_on
exec "$@"

