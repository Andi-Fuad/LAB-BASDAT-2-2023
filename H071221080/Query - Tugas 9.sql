USE classicmodels;

-- No. 1
SELECT YEAR(o.orderDate) 'tahun', COUNT(o.orderNumber)'jumlah pesanan',
CASE
	WHEN COUNT(o.orderNumber) > 150 THEN 'banyak'
	WHEN COUNT(o.orderNumber) < 75 THEN 'sedikit'
	ELSE 'sedang'
END AS 'kategori pesanan'
FROM orders o
GROUP BY YEAR(o.orderDate);


-- No. 2
SELECT CONCAT(e.firstName, ' ', e.lastName) 'nama pegawai',
SUM(p.amount) 'gaji',
CASE
	WHEN SUM(p.amount) > (
		SELECT AVG(total)
		FROM (
			SELECT SUM(payments.amount) AS 'total' FROM employees
			JOIN customers
			ON employees.employeeNumber = customers.salesRepEmployeeNumber
			JOIN payments USING (customerNumber)
			GROUP BY employees.employeeNumber
		) AS a
	) THEN 'di atas rata-rata'
	ELSE 'di bawah rata-rata'
END AS 'kategori gaji'
FROM employees e
JOIN customers c
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments p USING (customerNumber)
GROUP BY e.employeeNumber;


-- No. 3
(
	SELECT c.customerName 'Pelanggan',
	GROUP_CONCAT(LEFT(p.productName, 4)) 'Tahun Pembuatan',
	COUNT(p.productCode) 'Jumlah Produk',
	SUM(DATEDIFF(o.shippedDate, o.orderDate)) 'Total Durasi Pengiriman',
	CASE
		WHEN MONTH(o.orderDate) % 2 = 1 AND
			  SUM(DATEDIFF(o.shippedDate, o.orderDate)) > (
			  		SELECT AVG(total) FROM (
				  		SELECT SUM(DATEDIFF(orders.shippedDate, orders.orderDate)) 'total'
						FROM orders
						GROUP BY orders.customerNumber
					) AS a
			  ) THEN 'Target 1'
		WHEN MONTH(o.orderDate) % 2 = 0 AND
			  SUM(DATEDIFF(o.shippedDate, o.orderDate)) > (
			  		SELECT AVG(total) FROM (
				  		SELECT SUM(DATEDIFF(orders.shippedDate, orders.orderDate)) 'total'
						FROM orders
						GROUP BY orders.customerNumber
					) AS a
			  ) THEN 'Target 2'
	END 'Keterangan'
	FROM customers c
	JOIN orders o USING (customerNumber)
	JOIN orderdetails od USING (orderNumber)
	JOIN products p USING (productCode)
	WHERE p.productName LIKE "18%"
	GROUP BY c.customerNumber
	HAVING `Keterangan` IS NOT NULL
)
UNION
(
	SELECT c.customerName 'Pelanggan',
	GROUP_CONCAT(LEFT(p.productName, 4)) 'Tahun Pembuatan',
	COUNT(p.productCode) 'Jumlah Produk',
	SUM(DATEDIFF(o.shippedDate, o.orderDate)) 'Total Durasi Pengiriman',
	CASE
		WHEN MONTH(o.orderDate) % 2 = 1 AND
			  COUNT(p.productCode) > 10 * (
			  		SELECT AVG(count_products) FROM (
					  	SELECT COUNT(products.productCode) AS 'count_products' FROM products
					  	GROUP BY products.productCode
					) AS a
			  ) THEN 'Target 3'
		WHEN MONTH(o.orderDate) % 2 = 0 AND
			  COUNT(p.productCode) > 10 * (
			  		SELECT AVG(count_products) FROM (
					  	SELECT COUNT(products.productCode) AS 'count_products' FROM products
					  	GROUP BY products.productCode
					) AS a
			  ) THEN 'Target 4'
	END 'Keterangan'
	FROM customers c
	JOIN orders o USING (customerNumber)
	JOIN orderdetails od USING (orderNumber)
	JOIN products p USING (productCode)
	WHERE p.productName LIKE "19%"
	GROUP BY c.customerNumber
	HAVING `Keterangan` IS NOT NULL
)
UNION
(
	SELECT c.customerName 'Pelanggan',
	GROUP_CONCAT(LEFT(p.productName, 4)) 'Tahun Pembuatan',
	COUNT(p.productCode) 'Jumlah Produk',
	SUM(DATEDIFF(o.shippedDate, o.orderDate)) 'Total Durasi Pengiriman',
	CASE
		WHEN MONTH(o.orderDate) % 2 = 1 AND
			  COUNT(p.productCode) > 3 * (
			  		SELECT MIN(count_products) FROM (
					  	SELECT COUNT(products.productCode) AS 'count_products' FROM products
					  	GROUP BY products.productCode
					) AS a
			  ) THEN 'Target 5'
		WHEN MONTH(o.orderDate) % 2 = 0 AND
			  COUNT(p.productCode) > 3 * (
			  		SELECT MIN(count_products) FROM (
					  	SELECT COUNT(products.productCode) AS 'count_products' FROM products
					  	GROUP BY products.productCode
					) AS a
			  ) THEN 'Target 6'
	END 'Keterangan'
	FROM customers c
	JOIN orders o USING (customerNumber)
	JOIN orderdetails od USING (orderNumber)
	JOIN products p USING (productCode)
	WHERE p.productName LIKE "20%"
	GROUP BY c.customerNumber
	HAVING `Keterangan` IS NOT NULL
);


-- No. 5 (Soal Tambahan)
SET autocommit = OFF;

START TRANSACTION;

SELECT @targetedProduct := (SELECT productCode FROM products
WHERE productCode NOT IN (SELECT DISTINCT productCode FROM orderdetails));

UPDATE products SET MSRP = MSRP * 0.7
WHERE productCode = @targetedProduct;

SELECT @newOrderNumber := MAX(orderNumber) FROM orders;

-- INSERT INTO orders (orderNumber, orderDate, requiredDate, `status`, customerNumber)
-- VALUES (@newOrderNumber, '2005-05-31', '2005-06-07', 'In Process', 119);

SELECT * FROM orderdetails WHERE orderNumber = @newOrderNumber;

INSERT INTO orderdetails VALUES (@newOrderNumber, @targetedProduct, 40, (
	SELECT MSRP FROM products WHERE productCode = @targetedProduct
), 14);

SELECT * FROM orderdetails WHERE orderNumber = @newOrderNumber;

ROLLBACK;









