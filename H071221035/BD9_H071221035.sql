USE classicmodels;

-- 1
SELECT YEAR(o.orderDate) 'tahun',
		COUNT(o.orderNumber) 'jumlah pesanan',
		CASE
			WHEN COUNT(o.orderNumber) > 150 THEN 'banyak'
			WHEN COUNT(o.orderNumber) < 75 THEN 'sedikit'
			
			ELSE 'sedang'
		END AS 'kategori pesanan'
FROM orders o
GROUP BY YEAR(o.orderDate);

-- 2
SELECT CONCAT(e.firstName,'',e.lastName) 'nama pagawai',
		SUM(py.amount) 'gaji',
		CASE
		WHEN SUM(py.amount) > (
										SELECT AVG(`total`)
										FROM (SELECT SUM(py2.amount) AS 'total' 
												FROM payments py2
												JOIN customers c2 USING(customerNumber)
												JOIN employees e2 ON c2.salesRepEmployeeNumber = e2.employeeNumber
												GROUP BY e2.employeeNumber) AS a)
										THEN 'diatas rata-rata'
		ELSE 'dibawah rata-rata'
		END AS 'kategori gaji'
FROM employees e
JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments py USING(customerNumber)
GROUP BY e.employeeNumber;

-- 3
SELECT
    c.customerName 'Nama Pelanggan',
    GROUP_CONCAT(LEFT(p.productName, 4)) 'Tahun Pembuatan Produk',
    COUNT(p.productCode) 'Jumlah Produk',
    SUM(DATEDIFF(o.shippedDate, o.orderDate)) 'Total Durasi Pengiriman',
    CASE
        WHEN 
            MONTH(o.orderDate) % 2 = 1 AND
            SUM(DATEDIFF(o.shippedDate, o.orderDate)) > (
                SELECT AVG(Total) 
                FROM (SELECT SUM(DATEDIFF(o2.shippedDate, o2.orderDate)) 'Total'
                		FROM orders o2
                		GROUP BY customernumber) AS a
            ) THEN 'TARGET 1'
        
        WHEN 
            MONTH(o.orderDate) % 2 = 0 AND
            SUM(DATEDIFF(o.shippedDate, o.orderDate)) > (
                SELECT AVG(Total) 
                FROM (SELECT SUM(DATEDIFF(o2.shippedDate, o2.orderDate)) 'Total'
                		FROM orders o2
                		GROUP BY customernumber) AS a
            ) THEN 'TARGET 2'
     END 'Keterangan'
FROM customers c
JOIN orders o 
USING (customernumber)
JOIN orderdetails od
USING (ordernumber)
JOIN products p
USING (productcode)
WHERE p.productName LIKE '18%'
GROUP BY c.customernumber
HAVING Keterangan IS NOT NULL

UNION

SELECT
    c.customerName 'Nama Pelanggan',
    GROUP_CONCAT(LEFT(p.productName, 4)) 'Tahun Pembuatan Produk',
    COUNT(p.productCode) 'Jumlah Produk',
    SUM(DATEDIFF(o.shippedDate, o.orderDate)) 'Total Durasi Pengiriman',
    CASE
        WHEN 
            MONTH(o.orderDate) % 2 = 1 AND
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
    END 'Keterangan'
FROM customers c
JOIN orders o 
USING (customernumber)
JOIN orderdetails od
USING (ordernumber)
JOIN products p
USING (productcode)
WHERE p.productName LIKE '19%'
GROUP BY c.customernumber
HAVING Keterangan IS NOT NULL

 	
UNION 

SELECT
    c.customerName 'Nama Pelanggan',
    GROUP_CONCAT(LEFT(p.productName, 4)) 'Tahun Pembuatan Produk',
    COUNT(p.productCode) 'Jumlah Produk',
    SUM(DATEDIFF(o.shippedDate, o.orderDate)) 'Total Durasi Pengiriman',
    	CASE
        WHEN 
            MONTH(o.orderDate) % 2 = 1 AND
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
WHERE productName LIKE '20%'
GROUP BY c.customernumber
HAVING Keterangan IS NOT NULL;


Perusahaan ingin melakukan diskon harga (MSRP bukan buyPrice) sebesar 30% untuk jangka waktu tertentu
khusus untuk product yang belum pernah terjual sama sekali.
-Kemudian pada tanggal 2005-05-31 seorang customer dengan customerNumber 119
-melakukan pemesanan sebanyak 14 produk, salah satu produknya adalah produk diskon dengan jumlah barang
sebanyak 40 dengan orderLineNumber 14


SELECT * FROM products
SELECT * from orderdetails 
GROUP BY productCode

SELECT p.productCode AS 'Kode Produk',
       p.productName AS 'Nama Produk',
       SUM(od.quantityOrdered * od.priceEach) AS 'Total Pendapatan'
FROM products p
INNER JOIN orderdetails od ON p.productCode = od.productCode
GROUP BY p.productCode, p.productName


SELECT * FROM products
SELECT * from orderdetails 

BEGIN;

UPDATE products
SET MSRP = MSRP * 0.7
WHERE productCode NOT IN (SELECT DISTINCT productCode FROM orderdetails);

INSERT INTO orderdetails (ordernumber, productcode, quantityordered, priceEach, orderlinenumber)
VALUES (@orderNumber, 'S18_3233', 40, (SELECT msrp FROM products WHERE productcode='S18_3233'), 14);

ROLLBACK;


BEGIN;

UPDATE products
SET MSRP = MSRP * 0.7
WHERE productCode NOT IN (SELECT DISTINCT productCode FROM orderdetails);
INSERT INTO orderdetails (ordernumber,productcode,quantityordered,priceEach,orderlinenumber)
VALUES (@orderNumber,'S18_3233',40, (SELECT msrp FROM products WHERE productCode = 'S18-3233'),14);

ROLLBACK;

BEGIN;

UPDATE products
SET MSRP = MSRP * 0.7
WHERE productCode NOT IN (SELECT DISTINCT productCode FROM orderdetails);

SELECT @orderNumber := MAX(orderNumber) + 1 FROM orders WHERE customerNumber = 119;

INSERT INTO orderdetails (orderNumber, productCode, quantityOrdered, priceEach, orderLineNumber)
VALUES (@orderNumber, 'S18_3233', 40, (SELECT MSRP FROM products WHERE productCode='S18_3233'), 14);

COMMIT;

SELECT * FROM products
order

Perusahaan ingin melakukan diskon harga (MSRP bukan buyPrice) sebesar 30% untuk jangka waktu tertentu
khusus untuk product yang belum pernah terjual sama sekali.
-Kemudian pada tanggal 2005-05-31 seorang customer dengan customerNumber 119
-melakukan pemesanan sebanyak 14 produk, salah satu produknya adalah produk diskon dengan jumlah barang
sebanyak 40 dengan orderLineNumber 14

SET autocommit = OFF;

START TRANSACTION;

SELECT @targetedProduct := (SELECT productCode FROM products
WHERE productCode NOT IN (SELECT DISTINCT productCode FROM orderdetails));

UPDATE products SET MSRP = MSRP * 0.7
WHERE productCode = @targetedProduct;

SELECT @newOrderNumber := MAX(orderNumber) FROM orders;

SELECT * FROM orderdetails WHERE orderNumber = @newOrderNumber;

INSERT INTO orderdetails VALUES (@newOrderNumber, @targetedProduct, 40, (
	SELECT MSRP FROM products WHERE productCode = @targetedProduct
), 14);

SELECT * FROM orderdetails WHERE orderNumber = @newOrderNumber;

SELECT * FROM orders
SELECT * FROM orderdetails

ROLLBACK;
