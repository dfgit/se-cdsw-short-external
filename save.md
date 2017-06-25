# Cloudera Data Science Workbench demos
Basic tour of Cloudera Data Science Workbench.

## Workbench
There are 4 scripts provided which walk through the interactive capabilities of Cloudera Data Science Workbench.

1. **Basic Python visualizations (Python 2).** Demonstrates:
  - Markdown via comments
  - Jupyter-compatible visualizations
  - Simple console sharing
2. **PySpark (Python 2).** Demonstrates:
  - Easy connectivity to (kerberized) Spark in YARN client mode.
  - Access to Hadoop HDFS CLI (e.g. `hdfs dfs -ls /`).
3. **Tensorflow (Python 2).** Demonstrates:
  - Ability to install and use custom packages (e.g. `pip search tensorflow`)
4. **R on Spark via Sparklyr (R).** Demonstrates:
  - Use familiar dplyr with Spark using [Sparklyr](http://spark.rstudio.com)

## Setup Instructions
You can run the following to cover all setup tasks once:

1. Installs 

  pip install -r requirements.txt
  4a_pkgSetup.R
  4b_dataSetup.sh
  4c_libSetup.sh

2. Stop any workbench sessions.


## Files
```
.
├── 1_python.py           Google Stock Analysis smoke test
├── 2_pyspark.py          Simple K-means smoke test
├── 3_tensorflow.py       Tensor Flow intro demo. Creates tensorboard
├── 4a_pkgSetup.R         Setup R packages 
├── 4b_dataSetup.sh       Setup data in hdfs
├── 4c_libSetup.sh        Setup ibis packages
├── 4.0_sparklyr.R        Sparklyr flights demo NOTE: creates flights db need for 4.2_ibis.py
├── 4.1_sparklyr.R        Sparklyr linear regression model
├── 4.2_ibis.py           Access Impala tables created in 4.0_sparklyr with ibis
├── 5_shiny.R             Show in-line Shiny output
├── 6_alice_wordcloud.py  Alice In Wonderland word cloud
├── MISC
│   ├── _bashrc           cp _bashrc ~/.bashrc if you want
│   └── _gitignore        cp _gitignore .gitignore  Keeps data and other files out of github
├── README.md             This file
├── alice-mask.jpg        Mask for Alice In Wonderland word cloude
├── app                   Needed for Shiny server
│   ├── server.R
│   └── ui.R
├── data                  Data for 1_python.py and 2_pyspark.py
│   ├── GoogleTrendsData.csv
│   └── kmeans_data.txt
├── env_utils.py          Python generic utilities for env vars, spark app name, etc.
├── env_utils.R           R version of env_utils.py
├── alice_readme.png      Alice image for README.md
├── requirements.txt      Run to install packages python packages, except those needed for ibis
└── utils.py              Helper functions for tensorflow.py

```

## Jobs
We recommend setting up a **"Nightly Analysis"** job to illustrate how data scientists can easily automate their projects.

## Misc files
_bashrc
_gitignore


## For "Alice In Wonderland" word cloud
### Dan Modifications
#### NLP example: Wordcloud "ALICE'S ADVENTURES IN WONDERLAND"
* make sure you run the pip install -r requirements.txt to have wget and wordcloud imports*

This code is inspired from https://github.com/amueller/word_cloud/blob/master/examples/masked.py

![](./IMAGES/alice_readme.png)

