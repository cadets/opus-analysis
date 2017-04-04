#! /usr/bin/env python

import time

import neo4j
from neo4j.v1 import GraphDatabase


driver = GraphDatabase.driver("bolt://localhost")


while True:
    try:
        driver.session()
        break
    except neo4j.bolt.connection.ServiceUnavailable:
        time.sleep(1)
    except neo4j.v1.security.Unauthorized:
        break
