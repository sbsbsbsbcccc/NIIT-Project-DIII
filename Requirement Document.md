### Note

+ 每位成员进行自己的部分时 , 需将**自己部分的工作流程 , 难点**另记录在个人文档中 , 方便后面整合 , 制作PPT和SRS . 
+ 不懂如何具体实现时ChatGPT是很好的辅助 .
+ 链接：https://pan.baidu.com/s/1ZhLTO1j1PWfKSX8ybn8Faw 提取码：s2n3 ubuntu虚拟机 


### Task1 - Big Data Processing - Willson 余

#### Requirement

+ 配置ubuntu虚拟机 , 包括安装大数据环境 , 配置静态网络 , 扩大内存和安装和配置一些常用的工具如vim fzf等 .
+ 输入端 : 数据集 - 银行流失账户数据分析 数据集来源 : https://www.kaggle.com/competitions/playground-series-s4e1/data 参考分析 : https://www.kaggle.com/code/abdmental01/bank-churn-lightgbm-and-catboost-0-8945#8.-Lets-Visualize-the-data
+ 用Flume从Linux系统上转移到HDFS . 
+ 用Hive生成表格 , 加载HDFS上的文件并进行部分的Mapreduce工作(参考分析8.1-8.7) . 
+ 编写mysql相关 , flume相关 , hive相关 , sqoop相关shell脚本 , 运行shell命令 .
+ 输出端 : MySQL数据 SHELL脚本


### Task2 - Front End Basic Data Presentation - Michelanglo 廖

#### Requirement
+ 进行部分hive mapreduce工作 . 
+ 用sqoop将数据从hive传到mysql . 
+ 使用Python分析MySQL里的数据并可视化 , 分析结果图片保存到linux系统 .

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
