#! /bin/bash

db_up(){
    cd ~ 

    echo -n "Extracting DB $1 : "
    ~/neo4j3/bin/neo4j-admin load --database=prov.neo4j --from="$1"
    ~/neo4j3/bin/neo4j start > /dev/null
    /trace/neo4j_up.py
    echo "Done"
}

db_down(){
    cd ~

    echo -n "Cleaning up : "
    ~/neo4j3/bin/neo4j stop > /dev/null
    rm -r prov.neo4j
    echo "Done"
}
