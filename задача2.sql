/* 2. Создайте базу данных example, разместите в ней таблицу users,
 состоящую из двух столбцов, числового id и строкового name.*/
 
 create database example;
 create table IF not exists users (
	id int auto_increment not null primary key,
    name varchar(100)
);
 
