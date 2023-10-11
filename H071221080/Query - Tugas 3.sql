DROP DATABASE praktikum3;

-- No. 1
CREATE DATABASE praktikum3;
USE praktikum3;

CREATE TABLE mahasiswa (
	NIM VARCHAR(10) NOT NULL PRIMARY KEY UNIQUE,
	Nama VARCHAR(50) NOT NULL,
	Kelas CHAR(1) NOT NULL,
	`status` VARCHAR(50) NOT NULL,
	Nilai INT(11)
);

INSERT INTO mahasiswa
VALUES ('H071241056', 'Kotlina', 'A', 'Hadir', 100),
		 ('H071241060', 'Pitonia', 'A', 'Alfa', 85),
		 ('H071241063', 'Javano', 'A', 'Hadir', 50),
		 ('H071241065', 'Ciplus Kuadra', 'B', 'Hadir', 65),
		 ('H071241066', 'Pihap E', 'B', 'Hadir', 85),
		 ('H071241079', 'Ruby', 'B', 'Alfa', 90);
		 
-- No. 2
UPDATE mahasiswa SET Nilai = 0, Kelas = 'C' WHERE `status` = 'Alfa';

-- No. 3
DELETE FROM mahasiswa WHERE Kelas = 'A' AND Nilai > 90;

-- No. 4
INSERT INTO mahasiswa(NIM, Nama, Kelas, `status`)
VALUES ('H071221080', 'Muh. Adnan Putra Amiruddin', 'B', 'Pindahan');

UPDATE mahasiswa SET Nilai = 50 WHERE Nilai = 0 AND `status` = 'Alfa';

UPDATE mahasiswa SET Kelas = 'A';

-- Tes
INSERT INTO mahasiswa VALUES ('H071221081', 'Muh. Adnan Putra Amiruddin', 'B', 'Pindahan', NULL);

-- --
SELECT * FROM mahasiswa;

-- No. 5
USE classicmodels;

UPDATE customers SET addressLine2 = 'None' WHERE contactLastName = 'Young' AND addressLine2 IS NULL;

SELECT * FROM customers WHERE contactLastName = 'Young';
