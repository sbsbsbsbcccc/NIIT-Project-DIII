### Note

- Each member, when working on their part, needs to document their **workflow and challenges** separately in their personal document. This will facilitate later integration, as well as the creation of the PPT and SRS.
- If you don't know how to implement something specifically, ChatGPT is a great assistant.
- Link: https://pan.baidu.com/s/1ZhLTO1j1PWfKSX8ybn8Faw Code: s2n3 Ubuntu Virtual Machine

### Task1 - Big Data Processing - Willson Yu

#### Requirement

- Configure the Ubuntu virtual machine, including installing the big data environment, configuring a static network, expanding memory, and installing and configuring some commonly used tools like vim and fzf.
- Input: Dataset - Bank Churn Analysis Dataset source: https://www.kaggle.com/competitions/playground-series-s4e1/data
- Use Flume to transfer data from the Linux system to HDFS.
- Use Hive to create tables, load files from HDFS, and perform some MapReduce operations (refer to analysis 8.1-8.7).
- Write shell scripts related to MySQL, Flume, Hive, and Sqoop, and run shell commands.
- Output: MySQL data, SHELL scripts

### Task2 - Front End Basic Data Presentation - Michelanglo Liao

#### Requirement

- Perform part of the Hive MapReduce work.
- Use Sqoop to transfer data from Hive to MySQL.
- Use Python to analyze data in MySQL and visualize it, saving the analysis result images to the Linux system.

### Task3 - Machine Learning using Spark - Henry Ma Yuchen

#### Requirement

- Dataset selection.
- Input: train.csv
- Machine learning using Spark:
  - Data Preprocessing & Feature Engineering
  - Train GBT classification model
  - Model evaluation (Accuracy, Precision, Recall, F1-score, ROC Curve, AUC)
  - Visualize the Top 10 important features
- Output:
  - Save the model to HDFS
  - Load the model from HDFS, predict whether a new customer will churn or not, and save the result to a .csv file on Linux.

### Task4 - Front End Optimization - Frank Jiang

#### Requirement

- Input: Linux scripts, analysis result images, MySQL data
- Design the webpage framework (including page beautification)
- Complete basic functions such as registration, login, and password recovery (directly copied from GITHUB), and note that these functions need to use the MySQL database on the Linux virtual machine.
- Integrate all the code completed in Task3.
- Provide a one-click button on the webpage and give feedback upon successful operation:
  - One-click data retrieval, which should eventually be a one-click run of a local Python file (test with "Hello World" first, then add parameter `Size`, which the user enters on the webpage to determine the amount of data to retrieve, similar to C language args).
  - One-click execution of multiple Linux Shell commands, calling scripts (like start-all.sh, which executes multiple commands).
- Insert ChatGPT plugin on the webpage.
- Output: Webpage integration

### Task5 - PPT And SRS - Dream Zhao

#### Requirement

- Combine each person’s personal document and the overall requirement document to create the PPT (now there is ChatPPT to assist with creation).
- Combine each person’s personal document and the overall requirement document to create the SRS document (can use large language models for assistance).