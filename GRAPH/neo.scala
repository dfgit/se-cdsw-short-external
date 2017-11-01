import org.neo4j.spark._

val neo = Neo4j(sc)

val rowRDD = neo.cypher("MATCH (n:Person) RETURN n.name as name limit 10").loadRowRdd
rowRDD.map(t => "Name: " + t(0)).collect.foreach(println)

// System.exit(0)
