### Choose proper dataset

+ greater than 10000 rows.
+ few odd data.
+ analysis convenience.



### Install Ubuntu 22.04 system and configure static IP

+ installation of ubuntu22.04 on VMware.

+ for remote connection

  + set VMnet8 related configuration on windows control panel.

  + set NAT mode on VMware virtual network editor and set some configurations like ip, gateway, don't use DHCP services .etc.
  + for more details, see https://blog.csdn.net/m0_54219225/article/details/127170419

  + create a file in `/etc/netplan/` and do some changes, then run `sudo netplan apply` command.



Note : 

`Username` : `willson`

`password`  : `123456`

`IP address` : `192.168.8.128`

`port` : `22`





### Install Big Data related techonology

+ Java
+ Hadoop pesuodo mode
+ Flume
+ Mysql and remote connection
+ Hive and mysql metastore
+ Sqoop and addtional jar files
+ Scala
+ Spark




### Clean data

No null value.

No duplicate rows.

Delete the first row.

```
sed '1d' ~/dataset/train.csv > ~/dataset/train/newtrain.csv
```



### Use Flume to upload data from linux to hdfs

+ Use commands: 
  + Note : flume must be closed totally, or you may fail because of file R/W reasons.

```
flume-ng agent -n agent1 -f $FLUME_HOME/conf/spool_train.conf
```

```
flume-ng agent -n agent2 -f $FLUME_HOME/conf/spool_test.conf
```



+ Contents

```
agent1.sources = source1
agent1.channels = channel1
agent1.sinks = sink1

agent1.sources.source1.type = spooldir
agent1.sources.source1.spoolDir = /home/willson/training/dataset/train

agent1.channels.channel1.type = memory
agent1.channels.channel1.capacity = 1000
agent1.channels.channel1.transactionCapacity = 1000

agent1.sinks.sink1.type = hdfs
agent1.sinks.sink1.hdfs.path = /dataset/train
agent1.sinks.sink1.hdfs.rollCount = 10000
agent1.sinks.sink1.hdfs.rollSize = 1073741824
agent1.sinks.sink1.hdfs.rollInterval = 3600
agent1.sinks.sink1.hdfs.fileType = DataStream
agent1.sinks.sink1.hdfs.filePrefix = train

agent1.sources.source1.channels = channel1
agent1.sinks.sink1.channel = channel1
```



```
agent2.sources = source2
agent2.channels = channel2
agent2.sinks = sink2

agent2.sources.source2.type = spooldir
agent2.sources.source2.spoolDir = /home/willson/training/dataset/test

agent2.channels.channel2.type = memory
agent2.channels.channel2.capacity = 1000
agent2.channels.channel2.transactionCapacity = 1000

agent2.sinks.sink2.type = hdfs
agent2.sinks.sink2.hdfs.path = /dataset/test
agent2.sinks.sink2.hdfs.rollCount = 10000
agent2.sinks.sink2.hdfs.rollSize = 1073741824
agent2.sinks.sink2.hdfs.rollInterval = 3600
agent2.sinks.sink2.hdfs.fileType = DataStream
agent2.sinks.sink2.hdfs.filePrefix = test

agent2.sources.source2.channels = channel2
agent2.sinks.sink2.channel = channel2
```



### Insert Data to Hive

+ Enter hive:

```
Create DATABASE IF NOT EXISTS analysis;
```

```
USE analysis;
```

+ Drop table if it exists.

```
DROP TABLE IF EXISTS train_tmp;
```

+ Create an tmp table(sqoop exporting problems).
  + When load data from hdfs, it will extract all files whether you ignore first line. So you must create a tmp table then transfer data to new table.

```sql
CREATE TABLE IF NOT EXISTS train_tmp (
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
STORED AS TEXTFILE
TBLPROPERTIES ('skip.header.line.count'='1');
```

```
LOAD DATA INPATH '/dataset/train' INTO TABLE analysis.train_tmp;
```

```
DROP TABLE IF EXISTS train;
```

```
CREATE TABLE IF NOT EXISTS train
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
AS
SELECT *
FROM (
  SELECT *, ROW_NUMBER() OVER () AS rn
  FROM train_tmp
) tmp
WHERE rn > 1;
```







### Mapreduce using hive

#### Gender analysis

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



#### Geography analysis

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



#### Tenure analysis

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



#### NumOfProducts analysis

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



#### HasCrCard analysis

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



#### IsActiveMember analysis

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



#### Exited analysis

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



### Disk space is not enough

+ `sudo apt install gparted` then in ubuntu desktop command shell `sudo gparted`.
+ See this link https://blog.csdn.net/ningmengzhihe/article/details/127295333 for more details.



### Shell script

#### How to use shell

+ vi filename.

```
#!/usr/bin/bash
commands
...
```

+ change permissions.

```
chmod +x filename
```



#### How to add hive command

```
hive -e "command; command;"
```

