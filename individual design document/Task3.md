### Step1:安装python3.7 必须安装3.7及以下版本，更高版本与pyspark不兼容

+ 添加 deadsnakes PPA 存储库 deadsnakes PPA 存储库包含多个 Python 版本

```
sudo add-apt-repository ppa:deadsnakes/ppa
```

```
sudo apt update
```

+ 安装 Python 3.7 及其相关包

```
sudo apt install python3.7 python3.7-venv python3.7-dev
```

+ 验证安装

```
python3.7 --version
```

+ 设置 Python 3.7 为默认版本

```
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.7 1
```

```
sudo update-alternatives --config python3
```

+ 创建一个符号链接，将 python3 连接到 python，这样在终端中输入 python 时，实际上会调用 python3

```
sudo ln -s /usr/bin/python3 /usr/bin/python
```

+ 安装numpy

```
pip install numpy
```

+ 安装matplotlib

```
pip install matplotlib
```

+ 更新pillow

```
pip install -U Pillow
```

+ 安装scikit-learn

```
pip install scikit-learn
```

### Step2:上传文件到hdfs，先采用hdfs dfs -put方式，后续可能使用flume

```
start-all.sh
```

```
hdfs dfs -mkdir /model
```

```
hdfs dfs -mkdir /model/dataset
```

```
hdfs dfs -mkdir /model/plots 
```

```
cd ~/training/dataset
```

```
hdfs dfs -put train.csv /model/dataset/train.csv
```

```
hdfs dfs -put test.csv /model/dataset/test.csv
```



### Step3:将GBDT.py, prediction.py 放入 /training

### Step4:开启spark

```
~/training/spark-2.3.0/sbin/start-all.sh
```



### Step5：运行GBDT.py

+ 此步骤使用train.csv数据集，训练集和测试集8：2，训练的模型保存在hdfs:///model/gbdt_model

```
spark-submit --master yarn GBDT.py
```

+ 模型evaluation results保存在本地文件夹file:///home/willson/training/evaluation_results.csv
+ 将本地file:///home/willson/training/evaluation_results/中csv文件合并成一个文件，保存为training目录下的merged_evaluation.csv
```
awk '(NR == 1) || (FNR > 1)' evaluation_results.csv/*.csv > merged_evaluation.csv
```


### Step6:对全新数据（csv文件形式）进行预测，运行prediction.py

+ 数据使用test.csv数据集，加载hdfs:///model/gbdt_model 模型，预测结果保存在本地文件夹file:///home/willson/training/predictions.csv
```
spark-submit --master yarn prediction.py
```

+ 将本地file:///home/willson/training/predictions.csv/中csv文件合并成一个文件，保存为training目录下的merged_predictions.csv
```
awk '(NR == 1) || (FNR > 1)' predictions.csv/*.csv > merged_predictions.csv
```


