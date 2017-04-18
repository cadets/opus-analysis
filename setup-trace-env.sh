#!/usr/bin/env bash

pip install --user neo4j-driver==1.1.0

# $1: Version $2: Destination Directory
get_neo4j(){
    curl -sS https://neo4j.com/artifact.php?name=neo4j-community-$1-unix.tar.gz > $2.tar.gz
    tar -xzf $2.tar.gz -C ~
    rm $2.tar.gz
    mv ~/neo4j-community-$1 $2
}

get_neo4j 3.1.3 ~/neo4j3
get_neo4j 2.3.10 ~/neo4j2

~/neo4j3/bin/neo4j start
/trace/neo4j_up.py
echo "CALL dbms.changePassword('opus');\n" | ~/neo4j3/bin/cypher-shell -uneo4j -pneo4j
~/neo4j3/bin/neo4j stop
rm -r ~/neo4j3/data/databases/graph.db

ln -s ~/prov.neo4j ~/neo4j2/data/graph.db
rm -rf ~/neo4j3/data/databases
ln -s ~ ~/neo4j3/data/databases

sed -i -e's/\#allow_store_upgrade/allow_store_upgrade/' ~/neo4j2/conf/neo4j.properties
sed -i -e's/\#dbms.allow_format_migration/dbms.allow_format_migration/' ~/neo4j3/conf/neo4j.conf
sed -i -e's/\#dbms.active_database=graph.db/dbms.active_database=prov.neo4j/' ~/neo4j3/conf/neo4j.conf
