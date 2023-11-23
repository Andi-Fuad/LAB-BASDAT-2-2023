CREATE DATABASE praktikum3;
USE praktikum3;
CREATE TABLE mahasiswa(
	NIM VARCHAR (10) PRIMARY KEY,
	Nama VARCHAR (50) NOT NULL ,
	Kelas CHAR (1)NOT NULL,
	`status` VARCHAR (50)NOT NULL,
	Nilai INT (11)
);

INSERT INTO mahasiswa
VALUES ('H071241056','Kotlina', 'A', 'Hadir', 100),
('H071241060', 'Pitonia', 'A', 'Alfa', 85),
('H071241063','Javano','A', 'Hadir', 50),
('H071241065', 'CiplusKuadra', 'B', 'Hadir', 65),
('H071241066', 'Pihap E', 'B', 'Hadir', 85),
('H071241079', 'Ruby', 'B', 'Alfa', 90);

SELECT * FROM  mahasiswa;

DROP table mahasiswa;

UPDATE mahasiswa
SET Kelas = 'C',Nilai= 0
WHERE status = 'Alfa';


DELETE FROM mahasiswa
WHERE Kelas = "A" and Nilai >90;


INSERT INTO mahasiswa
VALUES ('H071221035','Muh.Ilham Maulana Ramlan','A','pindahan',NULL)

UPDATE mahasiswa
SET Nilai = 50
WHERE STATUS  = "Alfa";

UPDATE mahasiswa
SET Kelas = 'A';

UPDATE mahasiswa 
SET STATUS = 'lulus'
WHERE Nilai >=70 ;

UPDATE mahasiswa 
SET STATUS = 'Mengulang'
WHERE Nilai  <=70;

SELECT * FROM  mahasiswa;

#selesai