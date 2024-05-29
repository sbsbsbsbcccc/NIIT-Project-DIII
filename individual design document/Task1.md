### 1. Choose proper dataset

+ greater than 10000 rows.
+ few odd data.
+ good for analysis.



### 2. Install Ubuntu 22.04 system and configure static IP

+ installation of ubuntu22.04 on VMware.
+ set VMnet8 related configuration on windows control panel.
+ set NAT mode on VMware virtual network editor and set some configurations like ip, gateway, don't use DHCP services .etc.
+ create a file in `/etc/netplan/` and do some changes, then run `sudo netplan apply` command.



Note : 

`Username` : `willson`

`password`  : `123456`

`IP address` : `192.168.8.128`

`port` : `22`



You need to change three places to connect to internet : inside of ubuntu(already done), windows control panel vmnet8 settings, and vmware virtual network editor. 

For more details, see https://blog.csdn.net/m0_54219225/article/details/127170419



### 3. Install Big Data related techonology

+ Java
+ Hadoop pesuodo mode
+ Flume
+ Mysql and remote connection
+ Hive and mysql metastore
+ Sqoop and addtional jar files
+ Scala
+ Spark



### Use Flume to upload data from windows to hdfs

to `/dataset/train` and `/dataset/test`

Simple way : 

```
hdfs dfs -put ... /dataset/...
```



### Clean data

No null value.

No duplicate rows.

Delete the first row.

```
sed '1d' train.csv > newtrain.csv
```





### Insert Data to Hive

Note: When failed using hive, try this:

```
rm -rf $HIVE_HOME/metastore_db/
```

```
schematool -initSchema -dbType mysql
```



Enter hive:

```
Create DATABASE IF NOT EXISTS analysis;
```

```
USE analysis;
```

Create an table and ignore the first row(title of each column). Cannot use external table for sqoop exporting problems.

```sql
CREATE TABLE IF NOT EXISTS train (
    Id STRING,
    CustomerId STRING,
    Surname STRING,
    Creditscore INT,
    Geography STRING,
    Gender STRING,
    Age INT,
    Tenure INT,
    Balance FLOAT,
    Numofproducts INT,
    Hascrcard INT,
    Isactivemember INT,
    Estimatedsalary FLOAT,
    Exited INT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE;
```

```
LOAD DATA INPATH '/dataset/train' INTO TABLE analysis.train;
```







### Mapreduce using hive

#### WordCount

##### Gender analysis

```
CREATE TABLE train_gender (
    Gender STRING,
    count INT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ',';
```

```
INSERT INTO TABLE train_gender
SELECT Gender, COUNT(*) AS count
FROM train
GROUP BY Gender;
```



##### Geography analysis

```
CREATE TABLE train_geography (
    Geography STRING,
    count INT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ',';
```

```
INSERT INTO TABLE train_geography
SELECT Geography, COUNT(*) AS count
FROM train
GROUP BY Geography;
```



##### Tenure analysis

```
CREATE TABLE train_tenure (
    Tenure STRING,
    count INT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ',';
```

```
INSERT INTO TABLE train_tenure
SELECT Tenure, COUNT(*) AS count
FROM train
GROUP BY Tenure;
```



##### NumOfProducts analysis

```
CREATE TABLE train_numofproducts (
    NumOfProducts STRING,
    count INT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ',';
```

```
INSERT INTO TABLE train_numofproducts
SELECT NumOfProducts, COUNT(*) AS count
FROM train
GROUP BY NumOfProducts;
```



##### HasCrCard analysis

```
CREATE TABLE train_hascrcard (
    HasCrCard STRING,
    count INT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ',';
```

```
INSERT INTO TABLE train_hascrcard
SELECT HasCrCard, COUNT(*) AS count
FROM train
GROUP BY HasCrCard;
```



##### IsActiveMember analysis

```
CREATE TABLE train_isactivemember (
    IsActiveMember STRING,
    count INT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ',';
```

```
INSERT INTO TABLE train_isactivemember
SELECT IsActiveMember, COUNT(*) AS count
FROM train
GROUP BY IsActiveMember;
```



##### Exited analysis

```
CREATE TABLE train_exited (
    Exited STRING,
    count INT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ',';
```

```
INSERT INTO TABLE train_exited
SELECT Exited, COUNT(*) AS count
FROM train
GROUP BY Exited;
```



### Export To MySQL

Note:

+ When use INT datatype in hive, it will be float type.
+ Need to change the default delimeter of hive.





```
sqoop export --connect jdbc:mysql://localhost/analysis --username root --password 123456 --table train --export-dir /user/hive/warehouse/analysis.db/train --input-fields-terminated-by ','
```

```
sqoop export --connect jdbc:mysql://localhost/analysis --username root --password 123456 --table train_gender --export-dir /user/hive/warehouse/analysis.db/train_gender --input-fields-terminated-by ','
```

```
sqoop export --connect jdbc:mysql://localhost/analysis --username root --password 123456 --table train_geography --export-dir /user/hive/warehouse/analysis.db/train_geography --input-fields-terminated-by ','
```

```
sqoop export --connect jdbc:mysql://localhost/analysis --username root --password 123456 --table train_tenure --export-dir /user/hive/warehouse/analysis.db/train_tenure --input-fields-terminated-by ','
```

```
sqoop export --connect jdbc:mysql://localhost/analysis --username root --password 123456 --table train_numofproducts --export-dir /user/hive/warehouse/analysis.db/train_numofproducts --input-fields-terminated-by ','
```

```
sqoop export --connect jdbc:mysql://localhost/analysis --username root --password 123456 --table train_hascrcard --export-dir /user/hive/warehouse/analysis.db/train_hascrcard --input-fields-terminated-by ','
```

```
sqoop export --connect jdbc:mysql://localhost/analysis --username root --password 123456 --table train_isactivemember --export-dir /user/hive/warehouse/analysis.db/train_isactivemember --input-fields-terminated-by ','
```

```
sqoop export --connect jdbc:mysql://localhost/analysis --username root --password 123456 --table train_exited --export-dir /user/hive/warehouse/analysis.db/train_exited --input-fields-terminated-by ','
```



### Mysql Check

Use `mysql -u root -p` and input password`123456` to enter mysql interface.



### Start Spark

```
cd $SPARK_HOME/sbin
```

```
./start-all.sh
```

