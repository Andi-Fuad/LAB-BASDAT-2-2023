# Nomor 1

(SELECT c.customerName, p.productName, (p.buyPrice * sum(od.quantityOrdered)) 'modal'
FROM customers c
JOIN orders 
USING (customernumber)
JOIN orderdetails od 
USING (ordernumber)
JOIN products p 
USING (productcode)
GROUP BY c.customerNumber
ORDER BY `modal` DESC
LIMIT 3)
UNION
(SELECT customers.customerName, products.productName, (products.buyPrice * sum(orderdetails.quantityOrdered)) 'modal'
FROM customers
JOIN orders 
USING (customernumber)
JOIN orderdetails
USING (ordernumber)
JOIN products
USING (productcode)
GROUP BY customerNumber
ORDER BY `modal`
LIMIT 3);

# Nomor 2
SELECT `Kota` from
(SELECT CONCAT(e.firstName, ' ', e.lastName) AS 'Nama Pelanggan/Karyawan', o.city AS 'Kota'
	FROM offices AS o
	JOIN employees AS e 
	USING (officeCode)
	WHERE e.firstName LIKE 'L%'
UNION
	SELECT c.customerName, c.city AS 'Kota' FROM customers AS c
	WHERE c.customerName LIKE 'L%') AS a
GROUP BY `Kota`
ORDER BY COUNT(`Nama Pelanggan/Karyawan`) DESC
LIMIT 1

	

# Nomor 3

SELECT CONCAT(e.firstName, ' ', e.lastName) 'Nama Karyawan/Pelanggan',
'Karyawan' AS 'Status'
FROM employees e
WHERE e.officeCode IN (
	SELECT officeCode FROM employees
	GROUP BY officeCode
	HAVING COUNT(employees.employeeNumber) = (
		SELECT COUNT(employees.employeeNumber) 
		FROM offices
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

# Nomor 4

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

# Nomor 5

SELECT p.productCode, p.productName, sum(od.quantityOrdered * od.priceEach) AS 'Total'
FROM products p
JOIN orderdetails od
USING (productcode)
GROUP BY p.productcode
UNION
SELECT p.productCode, p.productName, '0.0' AS 'Total'
FROM products p
WHERE p.productCode NOT IN (
	SELECT od.productCode FROM orderdetails od
	GROUP BY od.productCode)
GROUP BY p.productcode;
