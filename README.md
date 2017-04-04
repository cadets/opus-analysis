# OPUS Analysis of CADETS traces

* _prov.tar.gz files contain compressed Neo4J V3 databases for the given traces.
* _proc.json files contain process tree json documents with network connection tagging, suitable for use with the GUI from the first adversarial engagement.

## Setup
```
git clone git@gitlab.dtg.cl.cam.ac.uk:fresco-projects/opus-vm.git
git checkout opus-trace-analysis
git submodule init
git submodule update
vagrant up
vagrant ssh
```

## Available Commands
(All must be performed inside a `vagrant ssh` shell.)
```
/vagrant/opus-analysis/trace.sh $FOO.json
```
Runs an opus analysis of the given cadets format json trace $FOO. It will write $FOO\_prov.tar.gz and $FOO\_proc.json into the same directory as $FOO.


```
/vagrant/opus-analysis/cypher.sh $FOO_prov.tar.gz
```
When provided with an OPUS compressed database as an argument, this script will extract the DB, startup a neo4J session and open a cypher command prompt which can be used to execute queries against the database. When the cypher prompt is closed, the system automatically shuts down the Neo4J server and cleans up the extracted database. Currently any modifications made to the database will not be persisted.
