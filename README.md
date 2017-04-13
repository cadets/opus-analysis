# OPUS Analysis of CADETS traces

* .db files contain dumped Neo4J V3 databases for the given traces.
* _proc.json files contain process tree json documents with network connection tagging, suitable for use with the GUI from the first adversarial engagement.

## Setup
```
git clone git@github.com:cadets/opus-analysis.git 
git submodule init
git submodule update
cd opus-vm
vagrant up
vagrant ssh
cd /trace
./gen-make
```

## traces.yml
This file describes the traces that should be analysed by the system. The file is in the YAML format with top level dictionary keys denoting folders within trace-data to be examined, and under those are optional keys "white" followed by a list of files to be whitelisted, or "black" followed by a list of files to be blacklisted. The system preffers whitelists over blacklists, but in general you should avoid using both for the same folder. If neither is specified then all the traces within the folder are added.

Once the file has been modified you then should run `./gen-make` to regenerate the Makefile, this will be done automatically if you run `make`, `make analysis` or `make db`, though not if you make a specific individual trace.

## Available Commands
(All must be performed inside a `vagrant ssh` shell.)
```
cd /trace
make
make analysis
make db
make $Y
```
Make within the trace folder will automatically build any fresh databases or analysies that need to be run. A specific file can be targeted for building by naming it after the make invocation. Also the targets 'analysis' and 'db' exist for rebuilding either databases or analysies specifically. (Warning, as analysis targets depend on their databases, the database may be rebuilt if only the analysis if targetted if it is determined to be out of date.)


```
/trace/clean-state
```
This command will attempt to revert the VM into a clean state in the event of a crash or failure during a command.


```
/trace/trace $X.json $Y
```
Runs an opus analysis of the given cadets format json trace $X. It will write out a database dump to $Y.


```
/trace/analyse $Y
```
$Y Must be an OPUS database, this will run all available analysis tools on the DB, writing their results out to the same folder.


```
/trace/cypher $FOO.db
```
When provided with an OPUS database as an argument, this script will extract the DB, startup a neo4J session and open a cypher command prompt which can be used to execute queries against the database. When the cypher prompt is closed, the system automatically shuts down the Neo4J server and cleans up the extracted database. Currently any modifications made to the database will not be persisted.
