#! /bin/bash
set -e

cd ~ 

echo "Extracting $1"
tar -xzf "$1"

echo "Starting Neo4J"
~/neo4j3/bin/neo4j start > /dev/null
/vagrant/opus-analysis/neo4j_up.py

~/neo4j3/bin/cypher-shell -uneo4j -popus

echo "Stopping Neo4J"
~/neo4j3/bin/neo4j stop > /dev/null

echo "Cleanup"
rm -r prov.neo4j
