#! /bin/bash
set -e

. /trace/db.sh

db_up $1

~/neo4j3/bin/cypher-shell -uneo4j -popus

db_down
