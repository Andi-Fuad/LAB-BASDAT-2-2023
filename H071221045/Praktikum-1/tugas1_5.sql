CREATE DATABASE db_praktikum;

CREATE TABLE students (
name VARCHAR(50) NOT NULL,
email VARCHAR(255) UNIQUE,
gender CHAR(1),
student_id INT(11) PRIMARY KEY NOT NULL
);

CREATE TABLE classes (
class_name VARCHAR(50),
class_id INT(11) AUTO_INCREMENT PRIMARY KEY NOT NULL
);

CREATE TABLE class_student (
grade CHAR(1) DEFAULT 'E',
student_id INT(11),
class_id INT(11),
enrollment_id INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,

FOREIGN KEY(student_id) REFERENCES students(student_id),
FOREIGN KEY(class_id) REFERENCES classes(class_id)
);

DESCRIBE students;
DESCRIBE classes;
DESCRIBE class_student;