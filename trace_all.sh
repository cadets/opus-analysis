#! /bin/bash

. /trace/trace_list.sh

for f in ${TRACE_LIST[*]}
do
    /trace/trace.sh $f
done
