CREATE DATABASE tugas01;

CREATE TABLE books(
id INT(11) PRIMARY KEY,
isbn VARCHAR(50) UNIQUE,
title VARCHAR(50) NOT NULL,
pages INT,
summary TEXT,
genre VARCHAR(50) NOT NULL
);

SHOW TABLES;

ALTER TABLE books
MODIFY isbn CHAR(13);

ALTER TABLE books DROP summary;

DESCRIBE books;