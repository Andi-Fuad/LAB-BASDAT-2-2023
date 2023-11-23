USE classicmodels

# NO 1
(SELECT 
	c.customerName, 
	p.productName, 
	p.buyPrice * SUM(od.quantityOrdered) AS Modal
FROM customers AS c
JOIN orders AS o
USING(customerNumber)
JOIN orderdetails AS od
USING(orderNumber)
JOIN products AS p
USING(productCode)
GROUP BY customerNumber
ORDER BY Modal DESC LIMIT 3)
UNION
(SELECT 
	c.customerName, 
	p.productName, 
	p.buyPrice * SUM(od.quantityOrdered) AS Modal
FROM customers AS c
JOIN orders AS o
USING(customerNumber)
JOIN orderdetails AS od
USING(orderNumber)
JOIN products AS p
USING(productCode)
GROUP BY customerNumber
ORDER BY Modal ASC LIMIT 3)


# NO 2 
SELECT Kota FROM (
	SELECT 
		CONCAT(e.firstName, ' ', e.lastName) AS `Nama Karyawan`,
		o.city AS Kota
	FROM employees AS e
	JOIN offices AS o
	WHERE CONCAT(e.firstName, ' ', e.lastName) LIKE 'L%'
	UNION
	SELECT 
		customerName, 
		city AS Kota
	FROM customers
	WHERE customerName LIKE 'L%'
) AS a
GROUP BY Kota
ORDER BY COUNT(`Nama Karyawan`) DESC LIMIT 1



# NO 3
(SELECT 
	c.customerName AS `Nama Karyawan/Pelanggan`,
	'Pelanggan' AS `Status`
FROM customers AS c
JOIN employees AS e
ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN offices AS o
USING(officeCode)
WHERE o.officeCode IN 
	(SELECT o.officeCode 
	FROM employees AS e
	JOIN offices AS o
	USING(officeCode)
	GROUP BY o.officeCode
	HAVING COUNT(e.employeeNumber) = 
		(SELECT COUNT(e.employeeNumber)
		FROM employees AS e
		JOIN offices AS o
		USING(officeCode)
		GROUP BY o.officeCode
		ORDER BY COUNT(e.employeeNumber) LIMIT 1)
		))
UNION
(SELECT 
	CONCAT(e.firstName, ' ', e.lastName) AS `Nama Karyawan/Pelanggan`,
	'Karyawan' AS `Status`
FROM employees AS e
JOIN offices AS o
USING(officeCode)
WHERE o.officeCode IN 
	(SELECT o.officeCode 
	FROM employees AS e
	JOIN offices AS o
	USING(officeCode)
	GROUP BY o.officeCode
	HAVING COUNT(e.employeeNumber) = 
		(SELECT COUNT(e.employeeNumber)
		FROM employees AS e
		JOIN offices AS o
		USING(officeCode)
		GROUP BY o.officeCode
		ORDER BY COUNT(e.employeeNumber) LIMIT 1)
		))
		

# NO 4
SELECT * FROM orders
SELECT DISTINCT
	paymentDate AS Tanggal,
	'Membayar Pesanan' AS riwayat 
FROM payments
WHERE 
	YEAR(paymentDate) = '2003' AND
	MONTH(paymentDate) = '04' AND
	paymentDate NOT IN 
		(SELECT
		orderDate
		FROM orders
		WHERE YEAR(orderDate) = '2003' AND MONTH(orderDate) = '04')
		#mencari tanggal yang tidak memesan barang 
UNION 
SELECT
	orderDate AS Tanggal,
	'Memesan Barang' AS riwayat
FROM orders
WHERE 
	YEAR(orderDate) = '2003' AND 
	MONTH(orderDate) = '04' AND
	orderDate NOT IN
		(SELECT DISTINCT
		paymentDate 
		FROM payments
		WHERE YEAR(paymentDate) = '2003' AND MONTH(paymentDate) = '04')
		#mencari tanggal yang tidak membayar barang
UNION 
SELECT 
	o.orderDate AS Tanggal,
	'Membayar Pesanan dan Memesan Barang' AS Riwayat
FROM orders AS o
WHERE o.orderDate IN 
	(SELECT DISTINCT
	paymentDate
	FROM payments
	WHERE YEAR(paymentDate) = '2003' AND MONTH(paymentDate) = '04')
ORDER BY Tanggal ASC 

##
SELECT `Tanggal`, GROUP_CONCAT(`riwayat` SEPARATOR ' dan ') AS riwayat
FROM 
	(SELECT DISTINCT 'memesan barang' AS riwayat,
	orderDate AS tanggal
	FROM orders
	WHERE YEAR(orderDate) = 2003 AND MONTH(orderDate) = 4
	UNION
	SELECT DISTINCT 'membayar pesanan' AS riwayat,
	paymentDate AS tanggal
	FROM payments
	WHERE YEAR(paymentDate) = 2003 AND MONTH(paymentDate) = 4) AS a
GROUP BY `Tanggal`



# SOAL TAMBAHAN
#Tampilkan kode produk, nama prouk, dan total pendapatan produk tersebut
SELECT productCode AS 'Kode Produk',
		 productName AS 'Nama Produk' FROM products
UNION 
SELECT totalpendapatan FROM(
	SELECT SUM (quantityOrdered * priceEach) AS totalpendapatan 
	FROM orderdetails)



SELECT * from products
SELECT * FROM orderdetails

SELECT productcode  FROM orderdetails
GROUP BY productcode



SELECT p.productCode AS 'Kode Produk',
       p.productName AS 'Nama Produk',
       SUM(od.quantityOrdered * od.priceEach) AS 'Total Pendapatan'
FROM products p
INNER JOIN orderdetails od ON p.productCode = od.productCode
GROUP BY p.productCode, p.productName
UNION
SELECT productCode AS 'Kode Produk',
       productName AS 'Nama Produk',
       0 AS 'Total Pendapatan'
FROM products p
WHERE productCode NOT IN (SELECT productCode FROM orderdetails);



