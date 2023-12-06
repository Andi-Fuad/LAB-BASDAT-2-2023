USE classicmodels;

-- No. 1
(
	SELECT c.customerName,
	GROUP_CONCAT(p.productName SEPARATOR '; ') 'productName',
	SUM(od.quantityOrdered) * p.buyPrice 'modal'
	FROM customers c
	JOIN orders o USING (customerNumber)
	JOIN orderdetails od USING (orderNumber)
	JOIN products p USING (productCode)
	GROUP BY c.customerNumber
	ORDER BY modal DESC
	LIMIT 3
)
UNION
(
	SELECT c.customerName,
	GROUP_CONCAT(p.productName SEPARATOR '; ') 'productName',
	SUM(od.quantityOrdered) * p.buyPrice 'modal'
	FROM customers c
	JOIN orders o USING (customerNumber)
	JOIN orderdetails od USING (orderNumber)
	JOIN products p USING (productCode)
	GROUP BY c.customerNumber
	ORDER BY modal ASC
	LIMIT 3
);


-- No. 2
(
	SELECT city, COUNT(e.employeeNumber) 'Total Orang' FROM offices o
	JOIN employees e USING (officeCode)
	GROUP BY city
	ORDER BY `Total Orang` DESC
	LIMIT 1
)
UNION
(
	SELECT city, COUNT(customerName) FROM customers c
	WHERE customerName LIKE "L%"
	GROUP BY city
);

SELECT c.city FROM offices o
JOIN employees e USING (officeCode)
JOIN customers c
ON e.employeeNumber = c.salesRepEmployeeNumber
WHERE c.customerName LIKE "L%"
GROUP BY c.city
ORDER BY COUNT(e.employeeNumber) DESC
LIMIT 1;

(SELECT o.city, COUNT(e.employeeNumber) 'total' FROM offices o
JOIN employees e USING (officeCode)
WHERE e.firstName LIKE "L%"
GROUP BY o.city)
UNION
(SELECT c.city, COUNT(c.customerNumber) FROM customers c
WHERE c.customerName LIKE "L%"
GROUP BY c.city)
ORDER BY `total` DESC

SELECT * FROM (
	(SELECT o.city, COUNT(e.employeeNumber) 'total' FROM offices o
	JOIN employees e USING (officeCode)
	WHERE e.firstName LIKE "L%"
	GROUP BY o.city)
	UNION
	(SELECT c.city, COUNT(c.customerNumber) FROM customers c
	WHERE c.customerName LIKE "L%"
	GROUP BY c.city)
	ORDER BY `total` DESC
) AS 'jumlah'


-- No. 3
SELECT CONCAT(e.firstName, ' ', e.lastName) 'Nama Karyawan/Pelanggan',
'karyawan' AS 'status'
FROM employees e
WHERE e.officeCode IN (
	SELECT officeCode FROM employees
	GROUP BY officeCode
	HAVING COUNT(employees.employeeNumber) = (
		SELECT COUNT(employees.employeeNumber) FROM offices
		JOIN employees USING (officeCode)
		GROUP BY officeCode
		ORDER BY COUNT(employees.employeeNumber)
		LIMIT 1
	)
)
UNION
SELECT c.customerName, 'pelanggan' FROM customers c
JOIN employees e
ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE e.officeCode IN (
	SELECT officeCode FROM employees
	GROUP BY officeCode
	HAVING COUNT(employees.employeeNumber) = (
		SELECT COUNT(employees.employeeNumber) FROM offices
		JOIN employees USING (officeCode)
		GROUP BY officeCode
		ORDER BY COUNT(employees.employeeNumber)
		LIMIT 1
	)
)
ORDER BY `Nama Karyawan/Pelanggan`;


-- No. 4
SELECT o.orderDate AS 'tanggal',
'membayar pesanan dan memesan barang' AS 'riwayat'
FROM orders o
JOIN customers c USING (customerNumber)
JOIN payments p ON o.orderDate = p.paymentDate
HAVING MONTH(`tanggal`) = 04 AND YEAR(`tanggal`) = 2003

UNION
SELECT orderDate, 'memesan barang' FROM orders
WHERE MONTH(orderDate) = 04 AND YEAR(orderDate) = 2003
AND orderDate NOT IN (  
	SELECT o.orderDate AS 'Tanggal'
	FROM orders o
	JOIN customers c USING (customerNumber)
	JOIN payments p ON o.orderDate = p.paymentDate
	HAVING MONTH(`Tanggal`) = 04 AND YEAR(`Tanggal`) = 2003
)

UNION
SELECT paymentDate, 'membayar pesanan' FROM payments
WHERE MONTH(paymentDate) = 04 AND YEAR(paymentDate) = 2003
AND paymentDate NOT IN (  
	SELECT p.paymentDate AS 'Tanggal'
	FROM orders o
	JOIN customers c USING (customerNumber)
	JOIN payments p ON o.orderDate = p.paymentDate
	HAVING MONTH(`Tanggal`) = 04 AND YEAR(`Tanggal`) = 2003
)
ORDER BY `tanggal`;


-- No. 5 (tambahan)
SELECT p.productCode, p.productName, SUM(od.quantityOrdered * od.priceEach) 'totalRevenue' FROM products p
JOIN orderdetails od USING (productCode)
GROUP BY p.productCode
UNION
SELECT p.productCode, p.productName, 0 FROM products p
WHERE p.productCode NOT IN (
	SELECT p.productCode FROM products p
	JOIN orderdetails od USING (productCode)
	GROUP BY p.productCode
)

SELECT p.productCode, p.productName, SUM(od.quantityOrdered * od.priceEach) 'totalRevenue' FROM products p
JOIN orderdetails od USING (productCode)
GROUP BY p.productCode
UNION
SELECT p.productCode, p.productName, 0 FROM products p
WHERE p.productCode NOT IN (
	SELECT DISTINCT productCode FROM orderdetails
)
















