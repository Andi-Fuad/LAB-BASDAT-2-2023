-- NO 1
CREATE DATABASE praktikum3;
USE praktikum3;

CREATE TABLE mahasiswa (
		NIM VARCHAR (10) PRIMARY KEY,
		Nama VARCHAR (50) NOT NULL,
		Kelas CHAR (1) NOT NULL,
	   `Status` VARCHAR (50) NOT NULL,
		Nilai INT (11) 
);
SELECT * FROM mahasiswa;

INSERT INTO mahasiswa
VALUES 
    ('H071241056','Harry', 'A', 'Hadir', 100),
    ('H071241060', 'Hermione', 'A', 'Alfa', 85),
    ('H071241063', 'Albus', 'A', 'Hadir', 50),
    ('H071241065', 'Severus', 'B', 'Hadir', 65),
    ('H071241066', 'Sirius', 'B', 'Hadir', 85),
    ('H071241079', 'Ronal', 'B', 'Alfa', 90);
    
SELECT * FROM mahasiswa;

-- NO 2
UPDATE mahasiswa
SET nilai = 0, kelas= 'C'
WHERE STATUS = 'alfa';

SELECT * FROM mahasiswa

-- NO 3
DELETE FROM mahasiswa 
WHERE kelas = 'A' AND nilai > 90;

SELECT * FROM mahasiswa


-- NO 4
INSERT INTO mahasiswa
VALUES ('H071221002', 'Ardika', 'C', 'Pindahan', NULL );

UPDATE mahasiswa 
SET nilai = 50
WHERE `status` = 'alfa';

UPDATE mahasiswa 
SET kelas = 'A'

SELECT * FROM mahasiswa;


-- NO 5
UPDATE mahasiswa
SET `status` = 'Mengulang'
WHERE nilai < 70;

UPDATE mahasiswa
SET `status` = 'Lulus'
WHERE nilai >= 70;

SELECT *FROM mahasiswa;

    

