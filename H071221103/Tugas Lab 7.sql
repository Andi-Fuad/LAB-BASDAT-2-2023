USE classicmodelss;

#nomor 1
SELECT o.addressLine1, o.addressLine2, o.city, c.country AS 'Alamat Kantor'
FROM offices AS o
JOIN employees AS e USING (officeCode)
JOIN customers AS c ON e.employeeNumber = c.salesRepEmployeeNumber
WHERE c.customerNumber IN (
    SELECT customerNumber
    FROM payments
    GROUP BY customernumber
    HAVING COUNT(*)= (SELECT COUNT(amount) AS 'jumlah pembayaran' FROM payments
GROUP BY customernumber
ORDER BY COUNT(*) LIMIT 1));
	
#nomor 2	
SELECT CONCAT(firstname, ' ', lastname) AS 'Nama Employee',
		 FORMAT(SUM(py.amount),2) AS 'Pendapatan'
FROM employees e
JOIN customers c
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments py
USING (customerNumber)
GROUP BY e.employeeNumber
HAVING SUM(py.amount) = (
	SELECT MAX(amounttotal) 
	FROM (
		SELECT SUM(py.amount) AS amounttotal 
		FROM customers c 
		JOIN payments py
		USING (CustomerNumber)
		GROUP BY c.salesRepEmployeeNumber
	) AS MaxPembayaran) 
OR SUM(py.amount) = (
	SELECT MIN(amounttotal) 
	FROM (
		SELECT SUM(py.amount) AS amounttotal
		FROM customers c
		JOIN payments py
		USING (CustomerNumber)
		GROUP BY c.salesRepEmployeeNumber
	) AS MinPembayaran);


#nomor 3
USE world 

SELECT c.Name AS 'Negara', (c.Population * cl.Percentage/100) AS 'Pengguna Bahasa'
FROM country AS c
JOIN countrylanguage AS cl ON c.Code = cl.CountryCode
WHERE cl.Language = ( SELECT cl.Language
								FROM countrylanguage AS cl
								JOIN country AS c ON cl.CountryCode = c.Code
								WHERE c.Continent = 'Asia'
								GROUP BY cl.Language
								ORDER BY COUNT(cl.Language) DESC
								LIMIT 1)
ORDER BY `pengguna bahasa` DESC;


								
# nomor 4
SELECT c.customerName, 
		SUM(p.amount) AS 'Total pembayaran', 
		SUM(od.quantityOrdered) AS 'banyak barang', 
		GROUP_CONCAT(pr.productName SEPARATOR ', ') AS 'produk yang dibeli'
FROM customers AS c
JOIN payments AS p USING (customerNumber)
JOIN orders AS o USING (customerNumber)
JOIN orderdetails AS od USING (orderNumber)
JOIN products AS pr USING (productCode)
GROUP BY c.customerNumber
HAVING SUM(p.amount) > (SELECT AVG(total)
FROM (SELECT SUM(payments.amount) AS total
FROM payments 
GROUP BY customernumber) AS totalpembayaran);

-- Soal Tambahan No.5--
SELECT c.customerName, COUNT(o.orderNumber) AS order_count
FROM customers c
JOIN orders o USING(customerNumber)
GROUP BY c.customerName
HAVING COUNT(o.orderNumber) > 1;

