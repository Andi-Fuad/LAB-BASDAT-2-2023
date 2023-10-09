CREATE DATABASE praktikum3;

# No. 1

CREATE TABLE mahasiswa (
NIM VARCHAR(10) PRIMARY KEY NOT NULL,
Nama VARCHAR(50) NOT NULL,
kelas CHAR(1) NOT NULL,
status VARCHAR(50) NOT NULL,
Nilai INT(11)
);

DESCRIBE mahasiswa;

-- 

INSERT INTO mahasiswa
VALUES ('H071241056', 'Kotlina', 'A', 'Hadir', 100),
		 ('H071241060', 'Pitonia', 'A', 'Alfa', 85),
		 ('H071241063', 'Javano', 'A', 'Hadir', 50),
		 ('H071241065', 'Ciplus Kuadra', 'B', 'Hadir', 65),
		 ('H071241066', 'Pihap E', 'B', 'Hadir', 85),
		 ('H071241079', 'Ruby', 'B', 'Alfa', 90);

SELECT * FROM mahasiswa;

# No. 2

UPDATE mahasiswa
SET Nilai=0, Kelas='C'
WHERE status='Alfa';

SELECT * FROM mahasiswa;

# No.3

DELETE FROM mahasiswa
WHERE Kelas='A' AND Nilai>90;

SELECT * FROM mahasiswa;

# No. 4

INSERT INTO mahasiswa
VALUES ('H071221045', 'Henokh Abhinaya Tjahjadi', 'B', 'pindahan', NULL);

UPDATE mahasiswa
SET Nilai=50
WHERE status='Alfa';

UPDATE mahasiswa
SET Kelas='A';

SELECT * FROM mahasiswa;

# No. 5

USE classicmodels;
SELECT * FROM customers;

UPDATE customers
SET country='America'
WHERE country='USA';

SELECT * FROM customers
WHERE country='America'
ORDER BY CreditLimit ASC
LIMIT 5;