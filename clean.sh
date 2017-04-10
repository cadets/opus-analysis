#! /bin/bash

. /trace/trace_list.sh

for f in ${TRACE_LIST[*]}
do
    rm -f ${f%.json}_proc.json
    rm -f ${f%.json}_prov.tar.gz
done
