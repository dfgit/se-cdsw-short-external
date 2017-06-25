# Spark ML Lib example.  
## This one takes awhile to run unless you have more than a "demo" amount of CPU's on the CDH cluster

library(sparklyr)
library(dplyr)
library(DBI)

# install / load packages
source("UTILS/env_utils.R")
pkgs <- c("sparklyr", "dplyr", "DBI")
installLoadPkgs(pkgs)

app_name <- set_app_name("Spark MLlib")
sprintf("Spark History App Name: %s", app_name)

## Configure cluster
config <- spark_config()
config$spark.driver.cores   <- 2
#config$spark.executor.cores <- 4
config$spark.executor.memory <- "4G"

sc <- spark_connect(master="yarn-client", config=config, app_name=app_name)


dbSendQuery(sc, "USE flights")
airlines <- tbl(sc, "airlines_bi_pq")
airlines

#We will build a predictive model with MLlib. We use linear regression of MLlib.

#First, we will prepare training data. In order to handle categorical data, you should use tf_string_indexer for converting.

# build predictive model with linear regression

# 50/50 test / training partition, set hour to be on hour closest hour boundary, etc.
partitions <- airlines %>%
  filter(arrdelay >= 5) %>%
  sdf_mutate(
       carrier_cat = ft_string_indexer(carrier),
       origin_cat = ft_string_indexer(origin),
       dest_cat = ft_string_indexer(dest)
  ) %>%
  mutate(hour = floor(dep_time/100)) %>%
  sdf_partition(training = 0.5, test = 0.5, seed = 1099)

# Fit using spark ml_linear_regression on cluster
fit <- partitions$training %>%
   ml_linear_regression(
     response = "arrdelay",
     features = c(
        "month", "hour", "dayofweek", "carrier_cat", "depdelay", "origin_cat", "dest_cat", "distance"
       )
    )

fit

summary(fit)
spark_disconnect(sc)
print("DONE!")
