spark2-shell --conf spark.neo4j.bolt.url=bolt://52.41.231.203:7687 \
 --conf spark.neo4j.bolt.user=neo4j \
 --conf spark.neo4j.bolt.password=admin \
 --name roch \
 --jars neo4j-spark-connector-2.1.0-M4.jar \
-i ./neo.scala
