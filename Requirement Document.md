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


### Task4 - Front End Optimization - Frank 姜

#### Requirement

+ 输入端 : Linux脚本 分析结果图片 MySQL数据
+ 设计网页的框架(包括网页美化)
+ 完成注册登录找回密码等基本功能(直接抄GITHUB) , 注意该功能需使用到Linux虚拟机上的Mysql数据库 . 
+ 融合Task3完成的所有代码 . 
+ 在网页上提供一键按钮 , 并在运行成功后给予反馈 . 
  + 一键获取数据 , 应该最后会是一键运行本机Python文件(先用Hello Word测试 , 之后添加参数`Size` , 用户在网页上输入以确定获取数据的数量 , 相当于c语言的args) .  
  + 一键执行多条Linux Shell命令 , 调用脚本(如start-all.sh就是执行多条命令) .
+ 在网页上插入ChatGPT插件 .
+ 输出端 : 网页整合


### Task5 - PPT And SRS - Dream 赵

#### Requirement

+ 结合每个人的个人文档和总需求文档制作PPT(现在有ChatPPT辅助制作) . 
+ 结合每个人的个人文档和总需求文档制作SRS文档(可用大语言模型辅助) . 
