CREATE DATABASE praktikum3

USE praktikum3

-- NO 1
CREATE TABLE mahasiswa (
	nim VARCHAR(10) NOT NULL PRIMARY KEY,
	nama VARCHAR(50) NOT NULL,
	kelas CHAR(1) NOT NULL, 
	status VARCHAR(50) NOT NULL,
	nilai INT(11)
)

INSERT INTO mahasiswa (nim, nama, kelas, STATUS, nilai)
				VALUE ('H071241056', 'kotlina', 'A', 'hadir', 100),
				('H071241060', 'pitonia', 'A', 'alfa', 85),
				('H071241063', 'javano', 'A', 'hadir', 50),
				('H071241065', 'ciplus kuadra', 'B', 'hadir', 65),
				('H071241066', 'Pihap E', 'B', 'hadir', 85),
				('H071241067', 'ruby', 'B', 'alfa', 90);
			
SELECT* FROM mahasiswa	

-- NO 2
UPDATE mahasiswa
SET nilai = 0, kelas = 'c'
WHERE STATUS = 'alfa';
SELECT* FROM mahasiswa	

-- N0 3
DELETE FROM mahasiswa
WHERE nilai >90 AND kelas = 'A'
SELECT* FROM mahasiswa	

-- N0 4
INSERT INTO mahasiswa (nim, nama, kelas, STATUS)
				VALUE ('H071221103', 'Evangelista', 'D', 'Pindahan')
SELECT* FROM mahasiswa	
 
UPDATE mahasiswa
SET nilai = 50
WHERE STATUS = 'alfa';
SELECT* FROM mahasiswa	

UPDATE mahasiswa
SET kelas = 'A'
SELECT* FROM mahasiswa	

-- Soal tambahan NO 5
UPDATE mahasiswa
SET STATUS = 'Lulus' 
WHERE nilai >=70
SELECT* FROM mahasiswa	

UPDATE mahasiswa
SET STATUS = 'Mengulang' 
WHERE nilai <70
SELECT* FROM mahasiswa
