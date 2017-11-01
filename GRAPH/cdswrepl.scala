// %AddDeps --repository http://dl.bintray.com/spark-packages/maven neo4j-contrib neo4j-spark-connector 2.1.0-M4 
%AddJar file:/home/cdsw/neo4j-spark-connector-2.1.0-M4.jar
import org.neo4j.spark._

val neo = Neo4j(sc)
val rowRDD = neo.cypher("MATCH (n:Person) RETURN n.name as name limit 10").loadRowRdd
rowRDD.map(t => "Name: " + t(0)).collect.foreach(println)
