USE classicmodels;

-- No. 1
SELECT o.officeCode, o.addressLine1, o.addressLine2,
o.city, o.country, GROUP_CONCAT(c.customerNumber) AS 'Melayani'
FROM offices o
JOIN employees e USING (officeCode)
JOIN customers c
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments p USING (customernumber)
GROUP BY c.customerNumber
HAVING COUNT(p.amount) = (
	SELECT COUNT(p.amount) FROM payments p
	JOIN customers c USING (customerNumber)
	GROUP BY c.customerNumber
	ORDER BY COUNT(p.amount) ASC
	LIMIT 1
);


-- No. 2
SELECT CONCAT(e.firstName, ' ', e.lastName) 'nama employee',
SUM(p.amount) 'pendapatan' FROM employees e
JOIN customers c
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments p USING (customerNumber)
GROUP BY e.employeeNumber
HAVING SUM(p.amount) = (
	SELECT SUM(p.amount) FROM employees e
	JOIN customers c
	ON e.employeeNumber = c.salesRepEmployeeNumber
	JOIN payments p USING (customerNumber)
	GROUP BY e.employeeNumber
	ORDER BY SUM(p.amount) ASC
	LIMIT 1
) OR SUM(p.amount) = (
	SELECT SUM(p.amount) FROM employees e
	JOIN customers c
	ON e.employeeNumber = c.salesRepEmployeeNumber
	JOIN payments p USING (customerNumber)
	GROUP BY e.employeeNumber
	ORDER BY SUM(p.amount) DESC
	LIMIT 1
);


-- No. 3
USE world;

# Cek bahasa apa saja yang digunakan di benua Asia
SELECT cl.`Language`, GROUP_CONCAT(c.`Name` SEPARATOR '; ')
'Negara-negara yang menggunakan',
COUNT(c.`Name`) 'Jumlah negara yang menggunakan'
FROM countrylanguage cl
JOIN country c
ON cl.CountryCode = c.`Code`
WHERE c.Continent = 'Asia'
GROUP BY cl.`Language`
ORDER BY COUNT(c.`Name`) DESC;

## Arabic
SELECT c.`Name`, (c.Population * cl.Percentage)/100 'Pengguna Bahasa'
FROM country c
JOIN countrylanguage cl
ON c.`Code` = cl.CountryCode
WHERE cl.`Language` = (
	SELECT cl.`Language`
	FROM countrylanguage cl
	JOIN country c
	ON cl.CountryCode = c.`Code`
	WHERE c.Continent = 'Asia'
	GROUP BY cl.`Language`
	ORDER BY COUNT(c.`Name`) DESC
	LIMIT 1
);


-- No. 4
USE classicmodels;

SELECT c.customerName, SUM(pm.amount) AS 'Total pembayaran',
COUNT(od.quantityOrdered) 'banyak barang',
GROUP_CONCAT(p.productName SEPARATOR '; ')'produk yang dibeli'
FROM payments pm
JOIN customers c USING (customerNumber)
JOIN orders o USING (customerNumber)
JOIN orderdetails od USING (orderNumber)
JOIN products p USING (productCode)
GROUP BY c.customerNumber
HAVING SUM(pm.amount) > (
	SELECT AVG(amount) FROM payments
);


-- No. 5 (Soal tambahan)
USE world;

SELECT * FROM country;

SELECT `Code` AS kode, `Name`, (
	SELECT COUNT(`Name`) FROM city
	WHERE countryCode = kode
) 'Jumlah Kota' FROM country
WHERE `Name` = 'American Samoa';

SELECT * FROM city
WHERE countryCode = 'ASM'














