CREATE DATABASE IF NOT EXISTS analysis;
USE analysis;
CREATE TABLE IF NOT EXISTS train (
    Id VARCHAR(255),
    CustomerId VARCHAR(255),
    Surname VARCHAR(255),
    Creditscore FLOAT,
    Geography VARCHAR(255),
    Gender VARCHAR(255),
    Age FLOAT,
    Tenure FLOAT,
    Balance FLOAT,
    Numofproducts FLOAT,
    Hascrcard FLOAT,
    Isactivemember FLOAT,
    Estimatedsalary FLOAT,
    Exited FLOAT
);
CREATE TABLE IF NOT EXISTS train_gender (
    Gender VARCHAR(255),
    count FLOAT
);
CREATE TABLE IF NOT EXISTS train_geography (
    Geography VARCHAR(255),
    count FLOAT
);
CREATE TABLE IF NOT EXISTS train_tenure (
    Tenure VARCHAR(255),
    count FLOAT
);
CREATE TABLE IF NOT EXISTS train_numofproducts (
    NumOfProducts VARCHAR(255),
    count FLOAT
);
CREATE TABLE IF NOT EXISTS train_hascrcard (
    HasCrCard VARCHAR(255),
    count FLOAT
);
CREATE TABLE IF NOT EXISTS train_isactivemember (
    IsActiveMember VARCHAR(255),
    count FLOAT
);
CREATE TABLE IF NOT EXISTS train_exited (
    Exited VARCHAR(255),
    count FLOAT
);

select * from train_exited;
