## NLP example: Wordcloud of "Alice In Wonderland"
# Basic code is taken from https://github.com/amueller/word_cloud/blob/master/examples/masked.py

##
#
# get supporting files
#
# example includes python package wget and wordcloud. Run pip if haven't run pip -r requirements.txt
# !pip install wget wordcloud

##
# Imports

# utility
from os import path, environ
import subprocess
import wget
import wordcloud
import re

# spark processing 
from pyspark.sql import SparkSession

# wordcloud and image processing
from wordcloud import WordCloud, STOPWORDS
import PIL
from PIL import Image 
import numpy as np
import matplotlib.pyplot as plt
from IPython.display import Image 

from UTILS import env_utils
cur_project_home = env_utils.cur_project_home
app_name = env_utils.set_app_name("PySpark Alice WC")
print("Spark App Name ->", app_name)

hdfs_alice_directory = path.join("/user", environ['HADOOP_USER_NAME'], "ALICE")
local_alice_directory = 'tmp'
local_alice_text= path.join(local_alice_directory, 'alice30.txt')

def removePunctuation(text):
    text=text.lower()
    text=re.sub('[^0-9a-z ]', ' ', text)
    return text 
  
def run_cmd(args_list):
    print('Running system command: {0}'.format(' '.join(args_list)))
    proc = subprocess.Popen(args_list, stdout=subprocess.PIPE,
            stderr=subprocess.PIPE)
    (output, errors) = proc.communicate()
    if proc.returncode:
        raise RuntimeError(
            'Error running command: %s. Return code: %d, Error: %s' % (
                ' '.join(args_list), proc.returncode, errors))
    return (output, errors)
  
# Download from http://www.umich.edu/~umfandsf/other/ebooks/alice30.txt

if path.isfile(local_alice_text):
  print('{0} Alice In Wonderland book text already exists'.format(local_alice_text))
else:
  print('{0} Alice In Wonderland book text is being downloaded'.format(local_alice_text))
  wget_url = 'http://www.umich.edu/~umfandsf/other/ebooks/alice30.txt'
  wget.download(wget_url, out=local_alice_directory)

# put alice.txt to HDFS
(out, errors)= run_cmd(['hdfs', 'dfs', '-mkdir', '-p', hdfs_alice_directory])
(out, errors)= run_cmd(['hdfs', 'dfs', '-put', '-f',local_alice_text, hdfs_alice_directory])

# begin processing
spark = SparkSession.builder \
      .appName(app_name) \
      .getOrCreate()
    
threshold = 5

text_file = spark.sparkContext.textFile(path.join(hdfs_alice_directory, "alice30.txt"))

# create word cloud 
stopwords = set(STOPWORDS)
stopwords.add("and")

# counts = text_file.flatMap(lambda line: line.lower().split(" ")) \
counts = text_file.map(removePunctuation) \
  .flatMap(lambda line: line.split(" ")) \
  .filter(lambda word: word not in stopwords) \
  .map(lambda word: (word, 1)) \
  .reduceByKey(lambda a, b: a + b)

from pyspark.sql.types import *
schema = StructType([StructField("word", StringType(), True),
                     StructField("frequency", IntegerType(), True)])

filtered = counts.filter(lambda pair: pair[1] >= threshold)
counts_df = spark.createDataFrame(filtered, schema)

frequencies = counts_df.toPandas().set_index('word').T.to_dict('records')

# 
img = PIL.Image.open(path.join(cur_project_home, "IMAGES/alice-mask.jpg"))

alice_mask = np.array(img)

wc = WordCloud(background_color="white", max_words=2000, mask=alice_mask,
               stopwords=stopwords)
wc.generate_from_frequencies(dict(*frequencies))

# use IPython image display vs. imshow
# plt.imshow(wc, interpolation='bilinear')
plt.imsave("tmp/alice_wc.png", wc)
IPython.display.Image(filename="tmp/alice_wc.png")

# HDFS cleanup
# !hdfs dfs -rm -r $HDFS_ALICE_DIRECTORY
# (out, errors)= run_cmd(['hdfs', 'dfs', '-rm', '-r',  hdfs_alice_directory])
# close spark session
spark.stop()
#!rm {local_alice_text}
print("DONE!")