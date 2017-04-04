#! /bin/bash
set -x
set -e

cd ~ 

opusctl server start
opusctl server dtrace -u if="$1"
opusctl server stop

sleep 5

~/neo4j2/bin/neo4j start
~/neo4j2/bin/neo4j stop

sleep 5

~/neo4j3/bin/neo4j start
sleep 60

python /vagrant/cadets-query-scripts/update-labels.py
python /vagrant/cadets-query-scripts/get_complete_proc_tree.py > "${1%.json}_proc.json"

rm pickled_tree.dat
~/neo4j3/bin/neo4j stop

tar -czf "${1%.json}_prov.tar.gz" prov.neo4j
rm -r prov.neo4j
