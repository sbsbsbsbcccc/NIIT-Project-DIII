#### WordCount

##### CreditScore analysis

```hive
-- 创建新表 train_creditscore，使用 INT 类型
CREATE TABLE train_creditscore (
    CreditScore INT
);
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ',';
```

```sql
use analysis;

CREATE TABLE train_creditscore (
    CreditScore INT
);
```

```hive
-- 从母表 train 中插入数据到新表 train_hascrcard
INSERT INTO TABLE train_creditscore
SELECT CreditScore
FROM train;
```

##### Age analysis

```hive
-- 创建新表 train_age，使用 INT 类型
CREATE TABLE train_age (
    Age INT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ',';
```

```sql
use analysis;

CREATE TABLE train_age (
    Age INT
);
```

```hive
-- 从母表 train 中插入数据到新表 train_age
INSERT INTO TABLE train_age
SELECT Age
FROM train;
```

##### Balance analysis

```hive
-- 创建新表 train_balance，使用 FLOAT 类型
CREATE TABLE train_balance (
    Balance FLOAT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ',';
```

```hive
CREATE TABLE train_balance (
    Balance FLOAT
);
```

```hive
-- 从母表 train 中插入数据到新表 train_balance
INSERT INTO TABLE train_balance
SELECT CAST(Balance AS FLOAT) AS Balance
FROM train;
```

##### Estimatedsalary analysis

```hive
-- 创建新表 train_estimatedsalary，使用 FLOAT 类型
CREATE TABLE train_estimatedsalary (
    Estimatedsalary FLOAT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ',';
```

```sql
CREATE TABLE train_estimatedsalary (
    Estimatedsalary FLOAT
);
```

```hive
INSERT INTO TABLE train_estimatedsalary
SELECT CAST(Estimatedsalary AS FLOAT) AS Salary
FROM train;
```

#### Export To MySQL

Note:

- When use INT datatype in hive, it will be float type.
- Need to change the default delimeter of hive.
- when transferring data from Hive to MySQL, if there are decimal values, you should use float. Using decimal will cause the transfer to fail.

```bash
sqoop export \
  --connect jdbc:mysql://localhost/analysis \
  --username root \
  --password 123456 \
  --table train_creditscore \
  --export-dir /user/hive/warehouse/analysis.db/train_creditscore \
  --input-fields-terminated-by ','
```

```bash
sqoop export \
  --connect jdbc:mysql://localhost/analysis \
  --username root \
  --password 123456 \
  --table train_age \
  --export-dir /user/hive/warehouse/analysis.db/train_age \
  --input-fields-terminated-by ','

```

```bash
sqoop export \
  --connect jdbc:mysql://localhost/analysis \
  --username root \
  --password 123456 \
  --table train_balance \
  --export-dir /user/hive/warehouse/analysis.db/train_balance \
  --input-fields-terminated-by ','
```

```bash
sqoop export \
  --connect jdbc:mysql://localhost/analysis \
  --username root \
  --password 123456 \
  --table train_estimatedsalary \
  --export-dir /user/hive/warehouse/analysis.db/train_estimatedsalary \
  --input-fields-terminated-by ','
```

#### Data Analysis and Visualization

Python Package:

- pip install SQLAlchemy
- pip install PyMySQL
- pip install apyori
- pip install mysql-connector-python 
- pip install matplotlib
- pip install pandas

##### Import the necessary packages

```python
import mysql.connector
from sqlalchemy import create_engine 
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
import os
```

##### Connect to MySQL

```
#connection = mysql.connector.connect(
#    host="192.168.8.128",  
#   user="root",           
#    password="123456",     
#    database="analysis"   
#)

connection = create_engine('mysql+pymysql://root:123456@192.168.8.128/analysis')
```

##### Export visualized charts

```python
save_dir = r'D:\ProgramDVI'
if not os.path.exists(save_dir):
    os.makedirs(save_dir)
```

##### Generate a bar chart for train_exited

```python
# Querying data from MySQL database
query = "SELECT Exited, count FROM train_exited"
df1 = pd.read_sql(query, connection)

# Converting 'Exited' column to integer type
df1['Exited'] = df1['Exited'].astype(int)

# Defining color palette for visualization
palette = sns.color_palette("Set2", 2)

# Replacing numerical 'Exited' values with categorical labels
labels = df1['Exited'].replace({0: 'Not Exited', 1: 'Exited'})
values = df1['count']

# Creating a bar plot
plt.figure(figsize=(10, 10))
plt.bar(labels, values, color=palette, edgecolor='black')

# Adding title and labels to the plot
plt.title('Customer Churn Analysis')
plt.xlabel('Customer Status')
plt.ylabel('Number of Customers')

# Adding text labels on top of each bar
for i, v in enumerate(values):
    plt.text(i, v + 2100, str(v), ha='center', va='bottom')
    
# Saving the plot to a specified directory
save_path = os.path.join(save_dir, 'train_exited.png')
plt.savefig(save_path, transparent=True)

# Displaying the plot
plt.show()
```


##### Generate a bar chart for train_gender

```python
# Querying data from MySQL database
query = "SELECT Gender, count FROM train_gender"
df2 = pd.read_sql(query, connection)

# Defining color palette for visualization
palette = sns.color_palette("Set2", 2)

# Extracting labels and values for plotting
labels = df2['Gender']
values = df2['count']

# Creating a bar plot
plt.figure(figsize=(10, 10))
plt.bar(labels, values, color=palette, edgecolor='black')

# Adding title and labels to the plot
plt.title('Customer Gender Analysis')
plt.xlabel('Gender')
plt.ylabel('Number of Customers')

# Adding text labels on top of each bar
for i, v in enumerate(values):
    plt.text(i , v + 1000, str(v), ha='center', va='bottom')

# Specifying the path to save the plot
save_path = os.path.join(save_dir, 'train_gender.png')
plt.savefig(save_path, transparent=True)

# Displaying the plot
plt.show()
```


##### Generate a bar chart for train_geography

```python
# Querying data from MySQL database
query = "SELECT Geography, count FROM train_geography"
df3 = pd.read_sql(query, connection)

# Defining color palette for visualization
palette = sns.color_palette("Set2", 3)

# Extracting labels and values for plotting
labels = df3['Geography']
values = df3['count']

# Creating a bar plot
plt.figure(figsize=(10,10))
plt.bar(labels, values, color=palette, edgecolor='black')

# Adding title and labels to the plot
plt.title('Customer Geography Analysis')
plt.xlabel('Country')
plt.ylabel('Number of Customers')

# Adding text labels on top of each bar
for i, v in enumerate(values):
    plt.text(i, v + 1500, str(v), ha='center', va='bottom')
    
# Specifying the path to save the plot
save_path = os.path.join(save_dir, 'train_geography.png')
plt.savefig(save_path, transparent=True)

# Displaying the plot
plt.show()
```


##### Generate a bar chart for train_hascrcard

```python
# Querying data from MySQL database
query = "SELECT HasCrCard, count FROM train_hascrcard"
df4 = pd.read_sql(query, connection)

# Converting 'HasCrCard' column to integer type
df4['HasCrCard'] = df4['HasCrCard'].astype(int)

# Defining color palette for visualization
palette = sns.color_palette("Set2", 2)

# Mapping labels for better interpretation
labels = df4['HasCrCard'].replace({0: 'No Credit Card', 1: 'Has Credit Card'})
values = df4['count']

# Creating a bar plot
plt.figure(figsize=(10, 8))
plt.bar(labels, values, color=palette, edgecolor='black')

# Adding title and labels to the plot
plt.title('Customer Credit Card Analysis')
plt.xlabel('Has Credit Card')
plt.ylabel('Number of Customers')

# Adding text labels on top of each bar
for i, v in enumerate(values):
    plt.text(i, v + 2000, str(v), ha='center', va='bottom')
    
# Specifying the path to save the plot
save_path = os.path.join(save_dir, 'train_hascrcard.png')
plt.savefig(save_path, transparent=True)

# Displaying the plot
plt.show()
```


##### Generate a bar chart for train_isactivemember

```python
# Querying data from MySQL database
query = "SELECT IsActiveMember, count FROM train_isactivemember"
df5 = pd.read_sql(query, connection)

# Converting 'IsActiveMember' column to integer type
df5['IsActiveMember'] = df5['IsActiveMember'].astype(int)

# Defining color palette for visualization
palette = sns.color_palette("Set2", 2)

# Mapping labels for better interpretation
labels = df5['IsActiveMember'].replace({0: 'Inactive Member', 1: 'Active Member'})
values = df5['count']

# Creating a bar plot
plt.figure(figsize=(10, 10))
plt.bar(labels, values, color=palette, edgecolor='black')

# Adding title and labels to the plot
plt.title('Customer Active Membership Analysis')
plt.xlabel('Membership Status')
plt.ylabel('Number of Customers')

# Adding text labels on top of each bar
for i, v in enumerate(values):
    plt.text(i, v + 1000, str(v), ha='center', va='bottom')
    
# Specifying the path to save the plot
save_path = os.path.join(save_dir, 'train_isactivemember.png')
plt.savefig(save_path, transparent=True)

# Displaying the plot
plt.show()
```


##### Generate a bar chart for train_numofproducts

```python
# Querying data from MySQL database
query = "SELECT NumOfProducts, count FROM train_numofproducts"
df6 = pd.read_sql(query, connection)

# Defining color palette for visualization
palette = sns.color_palette("Set2", 4)

# Extracting labels and values
labels = df6['NumOfProducts']
values = df6['count']

# Creating a bar plot
plt.figure(figsize=(10, 8))
plt.bar(labels, values, color=palette, edgecolor='black')

# Adding title and labels to the plot
plt.title('Customer Product Analysis')
plt.xlabel('Number of Purchased Products')
plt.ylabel('Number of Customers')

# Adding text labels on top of each bar
for i, v in enumerate(values):
    plt.text(i, v + 1000, str(v), ha='center', va='bottom')
    
# Specifying the path to save the plot
save_path = os.path.join(save_dir, 'train_numofproducts.png')
plt.savefig(save_path, transparent=True)

# Displaying the plot
plt.show()
```


##### Generate a bar chart for train_tenure

```python
# Querying data from MySQL database
query = "SELECT Tenure, count FROM train_tenure"
df7 = pd.read_sql(query, connection)

# Defining color palette for visualization
palette = sns.color_palette("Set2", len(labels))
single_color = palette[2]

# Extracting labels and values
labels = df7['Tenure']
values = df7['count']

# Creating a bar plot
plt.figure(figsize=(12, 10))
bars = plt.bar(labels, values, color=single_color, edgecolor='black')   

# Adding title and labels to the plot
plt.title('Customer Tenure Analysis')
plt.xlabel('Tenure')
plt.ylabel('Number of Customers')

# Adding text labels on top of each bar
for i, v in enumerate(values):
    plt.text(i, v , str(v), ha='center', va='bottom')
    
# Specifying the path to save the plot
save_path = os.path.join(save_dir, 'train_tenure.png')
plt.savefig(save_path, transparent=True)

# Displaying the plot
plt.show()
```


##### Generate a pie chart for train_exited

```python
# Querying data from MySQL database
query = "SELECT Exited, count FROM train_exited"
df1 = pd.read_sql(query, connection)

# Defining color palette for visualization
palette = sns.color_palette("Set2", 2)

# Converting 'Exited' column to integer type
df1['Exited'] = df1['Exited'].astype(int)

# Mapping labels for visualization
labels = df1['Exited'].replace({0: 'Not Exited', 1: 'Exited'})
values = df1['count']

# Creating a pie chart
plt.figure(figsize=(8, 8))
plt.pie(values, labels=labels, colors=palette, autopct='%1.1f%%', startangle=140)

# Adding count labels on the pie chart
for i, (label, value) in enumerate(zip(labels, values)):
    plt.text(0, -1.2 - i * 0.1, f"{label}: {value}", ha='center')

# Adding title to the plot
plt.title('Customer Churn Analysis')

# Specifying the path to save the plot
save_path = os.path.join(save_dir, 'train_exited(1).png')
plt.savefig(save_path, transparent=True)

# Displaying the plot
plt.show()
```


##### Generate a pie chart for train_gender

```python
# Querying data from MySQL database
query = "SELECT Gender, count FROM train_gender"
df2 = pd.read_sql(query, connection)

# Defining color palette for visualization
palette = sns.color_palette("Set2", 2)

# Extracting labels and values
labels = df2['Gender']
values = df2['count']

# Creating a pie chart
plt.figure(figsize=(8, 8))
plt.pie(values, labels=labels, colors=palette, autopct='%1.1f%%', startangle=140)

# Adding count labels on the pie chart
for i, (label, value) in enumerate(zip(labels, values)):
    plt.text(0, -1.2 - i * 0.1, f"{label}: {value}", ha='center')

# Adding title to the plot
plt.title('Customer Gender Analysis')

# Specifying the path to save the plot
save_path = os.path.join(save_dir, 'train_gender(1).png')
plt.savefig(save_path, transparent=True)

# Displaying the plot
plt.show()
```


##### Generate a pie chart for train_geography

```python
query = "SELECT Geography, count FROM train_geography"
df3 = pd.read_sql(query, connection)

palette = sns.color_palette("Set2", 3)

labels = df3['Geography']
values = df3['count']

plt.figure(figsize=(8, 8))
plt.pie(values, labels=labels, colors=palette, autopct='%1.1f%%', startangle=140)

for i, (label, value) in enumerate(zip(labels, values)):
    plt.text(0, -1.2 - i * 0.1, f"{label}: {value}", ha='center')

plt.title('Customer Geography Analysis')

save_path = os.path.join(save_dir, 'train_geography(1).png')

plt.savefig(save_path, transparent=True)

plt.show()
```


##### Generate a pie chartfor train_hasCrcard:

```python
# Converting 'HasCrCard' column to integer type
df4['HasCrCard'] = df4['HasCrCard'].astype(int)

# Defining color palette for visualization
palette = sns.color_palette("Set2", 2)

# Mapping labels for visualization
labels = df4['HasCrCard'].replace({0: 'No Credit Card', 1: 'Has Credit Card'})
values = df4['count']

# Creating a pie chart
plt.figure(figsize=(8, 8))
plt.pie(values, labels=labels, colors=palette, autopct='%1.1f%%', startangle=140)

# Adding count labels on the pie chart
for i, (label, value) in enumerate(zip(labels, values)):
    plt.text(0, -1.2 - i * 0.1, f"{label}: {value}", ha='center')

# Adding title to the plot
plt.title('Customer Credit Card Analysis')

# Specifying the path to save the plot
save_path = os.path.join(save_dir, 'train_hasCrcard(1).png')
plt.savefig(save_path, transparent=True)

# Displaying the plot
plt.show()
```


##### Generate a pie chartfor train_isactivemember:

```python
# Executing SQL query to fetch data
query = "SELECT IsActiveMember, count FROM train_isactivemember"
df5 = pd.read_sql(query, connection)

# Defining color palette for visualization
palette = sns.color_palette("Set2", 2)

# Converting 'IsActiveMember' column to integer type
df5['IsActiveMember'] = df5['IsActiveMember'].astype(int)

# Mapping labels for visualization
labels = df5['IsActiveMember'].replace({0: 'Inactive Member', 1: 'Active Member'})
values = df5['count']

# Creating a pie chart
plt.figure(figsize=(8, 8))
plt.pie(values, labels=labels, colors=palette, autopct='%1.1f%%', startangle=140)

# Adding count labels on the pie chart
for i, (label, value) in enumerate(zip(labels, values)):
    plt.text(0, -1.2 - i * 0.1, f"{label}: {value}", ha='center')

# Adding title to the plot
plt.title('Customer Active Membership Analysis')

# Specifying the path to save the plot
save_path = os.path.join(save_dir, 'train_isactivemember(1).png')
plt.savefig(save_path, transparent=True)

# Displaying the plot
plt.show()
```


##### Generate a pie chartfor train_numofproducts:

```python
query = "SELECT NumOfProducts, count FROM train_numofproducts"
df6 = pd.read_sql(query, connection)

palette = sns.color_palette("Set2", 4)

labels = df6['NumOfProducts']
values = df6['count']

plt.figure(figsize=(8, 8))
plt.pie(values, labels=labels, colors=palette, autopct='%1.1f%%', startangle=140)

for i, (label, value) in enumerate(zip(labels, values)):
    plt.text(0, -1.2 - i * 0.1, f"{label}: {value}", ha='center')

plt.title('Customer Product Analysis')

save_path = os.path.join(save_dir, 'train_numofproducts(1).png')

plt.savefig(save_path, transparent=True)

plt.show()
```

##### Output:

![df6(1)](D:\ProgramDVI\df6(1).png)

##### Generate a pie chartfor train_tenure:

```python
query = "SELECT Tenure, count FROM train_tenure"
df7 = pd.read_sql(query, connection)

#palette = sns.color_palette("Set2", 2)
palette = sns.color_palette("Accent", 11)
#import matplotlib.cm as cm  
#colors = cm.get_cmap('viridis', len(labels))(range(len(labels)))  

labels = df7['Tenure']
values = df7['count']

plt.figure(figsize=(8, 8))
plt.pie(values, labels=labels, colors=palette , autopct='%1.1f%%', startangle=140)

for i, (label, value) in enumerate(zip(labels, values)):
    plt.text(0, -1.2 - i * 0.1, f"{label}: {value}", ha='center')

plt.title('Customer Tenure Analysis')

save_path = os.path.join(save_dir, 'train_tenure(1).png')

plt.savefig(save_path, transparent=True)

plt.show()
```


##### Generate a histogram displaying the frequency distribution of "CreditScore", including a kernel density estimation curve. The chart also includes dashed lines representing the mean and median values, with these statistical values displayed in the legend

```python
# Executing SQL query to fetch data
query = "SELECT CreditScore FROM train_creditscore"
df8 = pd.read_sql(query, connection)

# Creating a figure for plotting
fig = plt.figure(figsize=(10, 6))

# Creating a histogram plot
histplot = sns.histplot(data=df8, x="CreditScore", bins=20, color='#26090b', edgecolor='#26090b', kde=True)

# Setting color for the kernel density line
histplot.get_lines()[0].set_color('#26090b')

# Calculating mean and median values
mean_value = df8["CreditScore"].mean()
median_value = df8["CreditScore"].median()

# Adding vertical lines for mean and median
plt.axvline(mean_value, color='red', linestyle='dashed', linewidth=2, label=f'Mean: {mean_value:.2f}')
plt.axvline(median_value, color='blue', linestyle='dashed', linewidth=2, label=f'Median: {median_value:.2f}')

# Adding title and labels to the plot
plt.title("Distribution of CreditScore in df8 with Mean and Median")
plt.xlabel("CreditScore")
plt.ylabel("Count")

# Adding legend to the plot
plt.legend()

# Specifying the path to save the plot
save_path = os.path.join(save_dir, 'train_creditscore.png')
plt.savefig(save_path, transparent=True)

# Displaying the plot
plt.show()
```


##### generates a histogram displaying the frequency distribution of ages in the "train_age" dataset. It includes a kernel density estimation curve, along with dashed lines representing the mean and median age values. These statistical values are also displayed in the legend

```python
query = "SELECT Age FROM train_age"
df9 = pd.read_sql(query, connection)

plt.figure(figsize=(10, 6))
histplot = sns.histplot(data=df9, x="Age", bins=20, color='#26090b', edgecolor='#26090b', kde=True)

histplot.get_lines()[0].set_color('#26090b')

mean_value = df9["Age"].mean()
median_value = df9["Age"].median()

plt.axvline(mean_value, color='red', linestyle='dashed', linewidth=2, label=f'Mean: {mean_value:.2f}')
plt.axvline(median_value, color='blue', linestyle='dashed', linewidth=2, label=f'Median: {median_value:.2f}')

plt.title("Distribution of Age in train_age with Mean and Median")
plt.xlabel("Age")
plt.ylabel("Count")

plt.legend()

save_path = os.path.join(save_dir, 'train_age.png')

plt.savefig(save_path, transparent=True)

plt.show()

```


##### generates a histogram that illustrates the distribution of ages within the "train_age" dataset. Additionally, it includes a kernel density estimation (KDE) curve. The dashed red line represents the mean age, while the dashed blue line represents the median age. These statistical values are also shown in the legend

```python
query = "SELECT Balance FROM train_balance"
df10 = pd.read_sql(query, connection)

fig = plt.figure(figsize=(10, 6))

histplot = sns.histplot(data=df10, x="Balance", bins=20, color='#26090b', edgecolor='#26090b', kde=True)

if len(histplot.get_lines()) > 0:
    histplot.get_lines()[0].set_color('#26090b')

mean_value = df10["Balance"].mean()
median_value = df10["Balance"].median()

plt.axvline(mean_value, color='red', linestyle='dashed', linewidth=2, label=f'Mean: {mean_value:.2f}')
plt.axvline(median_value, color='blue', linestyle='dashed', linewidth=2, label=f'Median: {median_value:.2f}')

plt.title("Distribution of Balance in train with Mean and Median")
plt.xlabel("Balance")
plt.ylabel("Count")

plt.legend()

save_path = os.path.join(save_dir, 'train_balance.png')

plt.savefig(save_path, transparent=True)

plt.show()

```


##### generates a histogram illustrating the distribution of estimated salaries within the "train_estimatedsalary" dataset. It includes a kernel density estimation (KDE) curve. The dashed red line represents the mean estimated salary, while the dashed blue line represents the median estimated salary. These statistical values are also shown in the legend

```python
query = "SELECT Estimatedsalary FROM train_estimatedsalary"
df11 = pd.read_sql(query, connection)

fig = plt.figure(figsize=(10, 6))

histplot = sns.histplot(data=df11, x="Estimatedsalary", bins=20, color='#26090b', edgecolor='#26090b', kde=True)

if len(histplot.get_lines()) > 0:
    histplot.get_lines()[0].set_color('#26090b')

mean_value = df11["Estimatedsalary"].mean()
median_value = df11["Estimatedsalary"].median()

plt.axvline(mean_value, color='red', linestyle='dashed', linewidth=2, label=f'Mean: {mean_value:.2f}')
plt.axvline(median_value, color='blue', linestyle='dashed', linewidth=2, label=f'Median: {median_value:.2f}')

plt.title("Distribution of EstimatedSalary in df11 with Mean and Median")
plt.xlabel("EstimatedSalary")
plt.ylabel("Count")

plt.legend()

save_path = os.path.join(save_dir, 'train_estimatedsalary.png')

plt.savefig(save_path, transparent=True)

plt.show()

```



##### generates a chart with multiple subplots, each displaying a count plot of different categorical variables colored based on the target variable "Exited". Each row of the chart contains two subplots, and if the number of categorical variables is not even, the last row will have only one subplot. The title of each subplot shows the corresponding categorical variable's name and indicates the coloring based on the target variable

```python
# SQL query to fetch data
query = "SELECT Id, CustomerId, Surname, Creditscore, Geography, Gender, Age, Tenure, Balance, Numofproducts, Hascrcard, Isactivemember, Estimatedsalary, Exited FROM train"  
df = pd.read_sql_query(query, connection)  

# Categorical and numerical columns
cat_cols = ['Geography', 'Gender', 'Tenure', 'Numofproducts', 'Hascrcard', 'Isactivemember']  
num_cols = ['Creditscore', 'Age', 'Balance', 'Estimatedsalary'] 
target = 'Exited'  

# Palette for visualizations
palette = sns.color_palette("Set2", 2)  

# Number of rows for subplots
nrows = len(cat_cols) // 2 + (len(cat_cols) % 2 > 0)  

# Creating subplots
fig, axes = plt.subplots(nrows=nrows, ncols=2, figsize=(14, nrows*3))  
fig.subplots_adjust(hspace=0.5)  

# Flattening axes if there are multiple rows
axes = axes.flatten() if nrows > 1 else [axes]  

# Plotting count plots for categorical variables
for i, col in enumerate(cat_cols):  
    ax = axes[i]  
    sns.countplot(x=col, hue=target, data=df, palette=palette, ax=ax)    
    ax.set_title(f"{col} countplot by {target}", fontweight='bold')  

# Adjusting layout
plt.tight_layout() 

# Specifying the path to save the plot
save_path = os.path.join(save_dir, 'countplots.png')

# Saving the plot
plt.savefig(save_path, transparent=True)

# Displaying the plot
plt.show()
```
