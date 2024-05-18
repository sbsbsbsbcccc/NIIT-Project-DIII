### Note

+ 能抄即抄 ,节省时间 . 
+ 每位成员进行自己的部分时 , 需将**自己部分的工作流程 , 难点**另记录在个人文档中 , 方便后面整合 , 制作PPT和SRS . 
+ 不懂如何具体实现时ChatGPT是很好的辅助 . 



### Task 1 - Visit Log Data Fetch

#### Requirement

+ 需收集的数据 : 网站具体的分支名 , 访问IP , 访问时间等 ...
+ 访问IP如果可能的话把其与地区对应起来 . 
+ 需对数据进行的处理 : 将收集的数据格式化如`aaa | BBB | ccc \n` , 并清理脏数据 . 
+ 将处理后的数据储存在文件中 . 
+ 完成的状态 : 
  + 点击运行 , 就能收集近1000条网站的访问记录 , 并存储在Windows系统下的某个文件中 . 
  + 将文件的格式记录下来 . 



### Task2 - Big Data Processing - Willson 余

#### Requirement

+ 将Task1所收集到的文件用Flume从Windows系统上转移到HDFS . 
+ 用Hive生成表格 , 加载HDFS上的文件并进行Mapreduce工作 . 
+ 将Hive上的数据用Sqoop转移到同机Mysql . 



### Task3 - Front End Basic Data Presentation - Henry 马

#### Requirement

+ 从**Linux虚拟机的Mysql**上提取分析后的数据到网页前端 . 
+ 将Mysql的数据用Echart图表示 . 
+ 接入大语言模型接口(ChatGPT, Huggingface上开源模型等) , 输入Mysql数据 , 分析原因(如什么地区访问量最高的原因) , 呈现在网页上 . 



### Task4 - Front End Optimization

#### Requirement

+ 完成注册登录找回密码等基本功能(直接抄GITHUB) , 注意该功能需使用到Linux虚拟机上的Mysql数据库 . 
+ 融合Task3完成的所有代码 . 
+ 在网页上提供一键按钮 , 并在运行成功后给予反馈 . 
  + 一键获取数据 , 应该最后会是一键运行本机Python文件(先用Hello Word测试 , 之后添加参数`Size` , 用户在网页上输入以确定获取数据的数量 , 相当于c语言的args) .  
  + 一键执行多条Linux Shell命令 , 调用脚本(如start-all.sh就是执行多条命令) . 
+ 网页美化(直接抄GITHUB) . 



### Task5 - PPT And SRS - Dream 赵

#### Requirement

+ 结合每个人的个人文档和总需求文档制作PPT(现在有ChatPPT辅助制作) . 
+ 结合每个人的个人文档和总需求文档制作SRS文档(可用大语言模型辅助) . 
