### Note

+ When each member is doing his or her part, he or she needs to record the workflow and difficulties of his or her part in a personal document, which will be convenient for later integration and making PPT and SRS.
+ Ubuntu virtual machine download link: https://pan.baidu.com/s/1ZhLTO1j1PWfKSX8ybn8Faw Extraction code: s2n3


### Task1 - Big Data Processing - Willson 余

#### Requirement

+ Configure Ubuntu virtual machine, including installing big data environment, configuring static network, expanding memory and installing and configuring some common tools such as vim fzf, etc.
+ Input: Dataset - Bank churn dataset. Source: https://www.kaggle.com/competitions/playground-series-s4e1/data 
+ Use Flume to transfer from Linux system to HDFS. 
+ Use Hive to generate tables, load files on HDFS and perform Mapreduce work. 
+ Write mysql-related, flume-related, hive-related, sqoop-related shell scripts, and run shell commands.
+ Output: MySQL data SHELL script


### Task2 - Front End Basic Data Presentation - Michelanglo 廖

#### Requirement
+ Perform hive mapreduce work.
+ Use sqoop to transfer data from hive to MySQL. 
+ Use Python to analyze and visualize the data in MySQL, and save the analysis result figures to the Linux system.

### Task3 - Machine Learning using Spark - Henry Ma Yuchen

#### Requirement

+ Dataset selection . 
+ Input : train.csv
+ Machine learning using Spark .
  + Data Preprocessing & Feature Engineering
  + Train GBT classification model
  + Model evaluation (Accuracy, Precision, Recall, F1-score, ROC Curve, AUC)
  + Visualize Top10 important features 
+ Output :
  + Save model to HDFS
  + Load the model from HDFS, predict new customer will exist or not, save result to .csv file on Linux . 


### Task4 - web End Optimization - Frank 姜

#### Requirement

Input: Linux script analysis result picture MySQL data
Responsible for the web development of the entire system
Basic functions, such as registering, logging in, and retrieving passwords, are complete. Note that these functions must use the Mysql database on the Linux VM.
mysql list clause:
CREATE TABLE `db_account` (
`id` int NOT NULL AUTO_INCREMENT,
`username` varchar(255) DEFAULT NULL,
`email` varchar(255) DEFAULT NULL,
`password` varchar(255) DEFAULT NULL,
`role` varchar(255) DEFAULT NULL,
`register_time` datetime DEFAULT NULL,
PRIMARY KEY (`id`),
UNIQUE KEY `unique_email` (`email`),
UNIQUE KEY `unique_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

Front end vue page design and beautification, the front end is divided into four parts, the home page is a brief introduction of our bank loss analysis service, and scrolling pictures. The second part of the visual analysis design, the first user upload the previous user record data set, passed to the remote server for subsequent analysis, passed the results of visual analysis. Part 3, Training section Click Start training wait time and then pass in the results. In the fourth part, the prediction part uploads the new user behavior file for prediction, and the obtained result part can be displayed to the front-end. Users can click download to get the csv including the probability of user loss.
Back-end springboot user request logic processing and remote virtual machine connection and return value processing.
The back end springboot writes services to connect to remote servers, as well as user requests, MySQL database connections, etc. The controller accepts the call service by making front-end get and post requests.


### Task5 - PPT And SRS - Dream 赵

#### Requirement

+ 结合每个人的个人文档和总需求文档制作PPT(现在有ChatPPT辅助制作) . 
+ 结合每个人的个人文档和总需求文档制作SRS文档(可用大语言模型辅助) . 
