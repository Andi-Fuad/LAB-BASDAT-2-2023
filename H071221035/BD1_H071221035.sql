+CREATE DATABASE db_praktikum

USE db_praktikum;
CREATE TABLE students(
	name VARCHAR (50) NOT NULL ,
	email VARCHAR (255) UNIQUE ,
	gender CHAR (1),
	student_id INT (11) PRIMARY KEY AUTO_INCREMENT 
	);
	
	DROP table students;
	DESCRIBE students;

CREATE TABLE classes(
	class_name VARCHAR (50),
	class_id INT (11) PRIMARY KEY AUTO_INCREMENT 
);

	DESCRIBE classes;

CREATE TABLE class_student(
	enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
	grade CHAR (1) DEFAULT 'E',
	Id_Student INT (11),
	Id_Class INT (11),
	
	FOREIGN KEY (Id_Student) REFERENCES students (student_id),
	FOREIGN KEY (Id_Class) REFERENCES classes (class_id)
	);
	
	DESCRIBE class_student;
	
USE db_praktikum
SHOW TABLES;
DESCRIBE class_student; 

#no 1
CREATE DATABASE library
USE library;

CREATE TABLE books(
	id INT PRIMARY KEY,
	isbn VARCHAR (50) UNIQUE,
	title VARCHAR(50) NOT NULL,
	pages INT,
	summary TEXT,
	genre VARCHAR (50) NOT NULL
	);
	
 ALTER TABLE books
 MODIFY isbn CHAR (13);
 
 ALTER TABLE books
 DROP COLUMN summary;
 
 SHOW TABLES;
 DESCRIBE books;
 
 DROP DATABASE library;