USE classicmodels;

# Nomor 1
SELECT YEAR(orderDate) 'tahun',
       COUNT(*) 'jumlah pesanan',
       CASE
           WHEN COUNT(*) > 150 THEN 'Banyak'
           WHEN COUNT(*) < 75 THEN 'Sedikit'
           ELSE 'Sedang'
       END 'kategori pesanan'
FROM orders
GROUP BY YEAR(orderDate);

# Nomor 2
SELECT CONCAT(e.firstName, ' ', e.lastName) 'nama pegawai',
       sum(p.amount) 'gaji',
       CASE
           WHEN sum(p.amount) > (select AVG(total) FROM (SELECT SUM(payments.amount) total FROM payments
			  JOIN customers USING(customernumber) JOIN employees ON employees.employeenumber = customers.salesrepemployeenumber
			  GROUP BY employees.employeenumber) as table_total)
			  THEN 'Di atas rata-rata'
           ELSE 'Di bawah rata-rata'
       END 'kategori gaji'
FROM employees e
JOIN customers c
ON c.salesRepEmployeeNumber = e.employeenumber
LEFT JOIN payments p
USING (customernumber)
GROUP BY e.employeeNumber
ORDER BY gaji desc;

# Nomor 3

SELECT 
    c.customerName 'Nama Pelanggan',
    GROUP_CONCAT(LEFT(p.productName, 4)) 'Tahun Pembuatan Produk',
    COUNT(*) 'Jumlah Produk',
    DATEDIFF(o.shippedDate, o.orderDate) 'Total Durasi Pengiriman',
    CASE
        WHEN 
            LEFT(p.productName, 2) LIKE '18%' AND
            MONTH(o.orderDate) % 2 <> 0 AND
            DATEDIFF(o.shippedDate, o.orderDate) > (
                SELECT AVG(DATEDIFF(o2.shippedDate, o2.orderDate)) 
                FROM orders o2
            ) THEN 'TARGET 1'
        
        WHEN 
            LEFT(p.productName, 2) LIKE '18%' AND
            MONTH(o.orderDate) % 2 = 0 AND
            DATEDIFF(o.shippedDate, o.orderDate) > (
                SELECT AVG(DATEDIFF(o2.shippedDate, o2.orderDate)) 
                FROM orders o2
            ) THEN 'TARGET 2'
        
        WHEN 
            LEFT(p.productName, 2) LIKE '19%' AND
            MONTH(o.orderDate) % 2 <> 0 AND
            COUNT(p.productCode) > 10 * (
                SELECT AVG(product_count)
                FROM (
					 SELECT COUNT(p2.productCode) AS product_count
                    FROM products p2
                    GROUP BY p2.productCode
					 ) AS counts
				)   
				THEN 'TARGET 3'
        
        WHEN 
            LEFT(p.productName, 2) LIKE '19%' AND
            MONTH(o.orderDate) % 2 = 0 AND
            COUNT(p.productCode) > 10 * (
                SELECT AVG(product_count)
                FROM (
					 SELECT COUNT(p2.productCode) AS product_count
                    FROM products p2
                    GROUP BY p2.productCode
					 ) AS counts
				)   
            THEN 'TARGET 4'
        
        WHEN 
            LEFT(p.productName, 2) LIKE '20%' AND
            MONTH(o.orderDate) % 2 <> 0 AND
            COUNT(p.productCode) > 3 * (
                SELECT MIN(product_count)
                FROM (
                    SELECT COUNT(p2.productCode) AS product_count
                    FROM products p2
                    GROUP BY p2.productCode
                ) AS counts
				)
            THEN 'TARGET 5'
        
        WHEN 
            LEFT(p.productName, 2) LIKE '20%' AND
            MONTH(o.orderDate) % 2 = 0 AND
            COUNT(p.productCode) > 3 * (
                SELECT MIN(product_count)
                FROM (
                    SELECT COUNT(p2.productCode) AS product_count
                    FROM products p2
                    GROUP BY p2.productCode
                ) AS counts
				)
            THEN 'TARGET 6'
    END 'Keterangan'
FROM customers c
JOIN orders o 
USING (customernumber)
JOIN orderdetails od
USING (ordernumber)
JOIN products p
USING (productcode)
WHERE p.productName LIKE '18%' OR p.productName LIKE '19%' OR p.productName LIKE '20%'
GROUP BY c.customernumber;

## Nomor 3
SELECT customerName 'pelanggan', 
    GROUP_CONCAT(LEFT(productName,4) SEPARATOR ', ') 'tahun pembuatan', 
    COUNT(productCode) 'jumlah produk', 
    SUM(DATEDIFF(shippedDate, orderDate)) 'total durasi pengiriman', 
CASE 
WHEN 
	MONTH(orderDate) % 2 = 1 AND 
	SUM(DATEDIFF(shippedDate, orderDate)) > (
	SELECT AVG(total) FROM (
	SELECT SUM(DATEDIFF(shippedDate, orderDate)) AS total 
	FROM orders GROUP BY customerNumber)a1) 
	THEN 'TARGET 1' 
WHEN 
	MONTH(orderDate) % 2 = 0 AND 
	SUM(DATEDIFF(shippedDate, orderDate)) > (
	SELECT AVG(total) FROM (
	SELECT SUM(DATEDIFF(shippedDate, orderDate)) AS total 
	FROM orders GROUP BY customerNumber)a) 
	THEN 'TARGET 2' 
END 'keterangan' 
FROM orders
JOIN customers USING (customerNumber)
JOIN orderdetails USING (orderNumber)
JOIN products USING (productCode)
WHERE LEFT(productName,2) = '18'
GROUP BY customerName
HAVING `keterangan` IS NOT NULL

UNION  

SELECT customerName 'pelanggan', 
    GROUP_CONCAT(LEFT(productName,4) SEPARATOR ', ') 'tahun pembuatan', 
    COUNT(productCode) 'jumlah produk', 
    SUM(DATEDIFF(shippedDate, orderDate)) 'total durasi pengiriman', 
CASE 
WHEN 
	MONTH(orderDate) % 2 = 1 AND 
	COUNT(productCode) > (
	SELECT AVG(jumlah)*10 
	FROM (SELECT COUNT(productname) AS jumlah 
	FROM products GROUP BY productCode)b1) 
	THEN 'TARGET 3' 
WHEN 
	MONTH(orderDate) % 2 = 0 AND 
	COUNT(productCode) > (
	SELECT AVG(jumlah)*10 
	FROM (SELECT COUNT(productname) AS jumlah 
	FROM products GROUP BY productCode)b) 
	THEN 'TARGET 4' 
END 'keterangan' 
FROM orders
JOIN customers USING (customerNumber)
JOIN orderdetails USING (orderNumber)
JOIN products USING (productCode)
WHERE LEFT(productName,2) = '19'
GROUP BY customerName
HAVING `keterangan` IS NOT NULL

UNION  

SELECT customerName 'pelanggan', 
    GROUP_CONCAT(LEFT(productName,4) SEPARATOR ', ') 'tahun pembuatan', 
    COUNT(productCode) 'jumlah produk', 
    SUM(DATEDIFF(shippedDate, orderDate)) 'total durasi pengiriman', 
CASE 
WHEN 
	MONTH(orderDate) % 2 = 1 AND COUNT(productCode) > 
	(SELECT MIN(jumlah)*3 FROM (
	SELECT COUNT(productname) AS jumlah 
	FROM products GROUP BY productCode)c1) 
	THEN 'TARGET 5' 
WHEN 
	MONTH(orderDate) % 2 = 0 AND COUNT(productCode) > 
	(SELECT MIN(jumlah)*3 FROM (
	SELECT COUNT(productname) AS jumlah 
	FROM products GROUP BY productCode)c) 
	THEN 'TARGET 6' 
END 'keterangan' 
FROM orders
JOIN customers USING (customerNumber)
JOIN orderdetails USING (orderNumber)
JOIN products USING (productCode)
WHERE LEFT(productName,2) = '20'
GROUP BY customerName
HAVING `keterangan` IS NOT NULL;

## Nomor 5
SELECT * FROM products
WHERE productCode NOT IN (SELECT DISTINCT productCode FROM orderdetails);
SELECT * FROM orderdetails;

SELECT * FROM orderdetails
ORDER BY ordernumber DESC;
SELECT * FROM orders
ORDER BY ordernumber DESC;


BEGIN;

UPDATE products
SET MSRP = MSRP * 0.7
WHERE productCode NOT IN (SELECT DISTINCT productCode FROM orderdetails);

INSERT INTO orderdetails (ordernumber, productcode, quantityordered, priceEach, orderlinenumber)
VALUES (@orderNumber, 'S18_3233', 40, (SELECT msrp FROM products WHERE productcode='S18_3233'), 14);

ROLLBACK;