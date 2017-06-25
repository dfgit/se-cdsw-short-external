#/bin/bash

# This only need be run by one person on the cluster

flightDataDir=flight-analytics-data

hdfs dfs -ls /tmp/airlines/*.parq  > /dev/null 2>&1
res=${?}
if [[ ${res} -eq 0 ]]; then
  echo "hdfs /tmp/airlines parquet files exist" 
else # assume the worst
  echo "airline parquet files will be in hdfs /tmp/airlines"
  hadoop fs -mkdir /tmp/airlines/ > /dev/null 2>&1
  [ -d ${flightDataDir} ] &&  echo "${flightDataDir} directory already exists" || mkdir ${flightDataDir}
  if [[ "$(ls -A ${flightDataDir}/airlines_parquet.tar.gz 2>/dev/null)" ]]; then
    echo -e "airlines_parquet.tar.gz exists\n" 
  else
    echo -e "getting data from https://ibis-resources.s3.amazonaws.com/data/airlines/airlines_parquet.tar.gz\n"
    wget https://ibis-resources.s3.amazonaws.com/data/airlines/airlines_parquet.tar.gz -P ${flightDataDir}
    echo "extracting parquet files"
    tar xvzf ${flightDataDir}/airlines_parquet.tar.gz -C ${flightDataDir}
  fi
  echo -e "\nputting data in hdfs /tmp/airlines\n"
  hadoop fs -put ${flightDataDir}/airlines_parquet/* /tmp/airlines/
  hadoop fs -chmod 777 /tmp/airlines 
  rm -rf ${flightDataDir}
fi


hdfs dfs -ls /tmp/airports/airports.csv > /dev/null 2>&1
res=${?}
if [[ ${res} -eq 0 ]]; then
  echo "hdfs /tmp/airports.csv already exists"
else # assume the worst
  echo "airport csv file will be in hdfs /tmp/airlines"
  hadoop fs -mkdir /tmp/airlines/
  wget http://stat-computing.org/dataexpo/2009/airports.csv
  hadoop fs -mkdir /tmp/airports
  hadoop fs -put airports.csv /tmp/airports/
  hadoop fs -chmod 777 /tmp/airports
  rm airports.csv
fi
echo "Done."
