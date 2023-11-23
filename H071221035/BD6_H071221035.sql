USE classicmodels
# NO 1
SELECT
	CONCAT(e.firstName, ' ', e.lastName) AS `Nama Employee`, 
	GROUP_CONCAT(o.orderNumber SEPARATOR ' | ') AS `Nomor Orderan`,
	COUNT(o.orderNumber) AS `Jumlah Pesanan`
FROM employees AS e
JOIN customers AS c
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN orders AS o
USING(customerNumber)
JOIN orderdetails AS od
USING(orderNumber)
GROUP BY `Nama Employee`


#NO 2
SELECT
	p.productCode, 
	p.productName,
	p.quantityInStock, 
	o.orderDate 
FROM products AS p
JOIN orderdetails AS od
USING(productCode)
JOIN orders AS o
USING(orderNumber)
WHERE p.quantityInStock > 5000
GROUP BY p.productName ORDER BY o.orderdate ASC ;


#N0 3 
SELECT 
	o.addressLine1 AS Alamat,
	REPLACE(o.phone,RIGHT(o.phone,4),'*** **') AS `Nomor Telp`,
	COUNT(DISTINCT e.employeeNumber) AS `Jumlah Karyawan`,
	COUNT(DISTINCT c.customerNumber) AS `Jumlah Pelanggan`,
	ROUND(AVG(py.amount), 2) AS `Rata-rata Penghasilan`
FROM offices AS o
LEFT JOIN employees AS e
USING(officeCode)
LEFT JOIN customers AS c
ON e.employeeNumber = c.salesRepEmployeeNumber
LEFT JOIN payments AS py
USING(customerNumber)
GROUP BY o.addressLine1
ORDER BY o.phone ASC

SELECT * FROM offices

#NO 4 

SELECT 
	c.customerName,
   YEAR(o.orderDate) AS `tahun order`, 
   MONTH(o.orderDate) AS `bulan order`, 
   COUNT(od.orderNumber) AS `jumlah pesanan`, 
   SUM(od.priceEach * od.quantityOrdered) AS `uang total penjualan`
FROM customers AS c
JOIN orders AS o
USING (customerNumber)
JOIN orderdetails AS od 
USING(orderNumber)
WHERE YEAR(o.orderDate) = 2003
GROUP BY c.customerName, MONTH(o.orderDate)

Menampilkan rata-rata harga produk per kategori.
Output : (7rx2c)
productline, average_price

SELECT 
	products.productLine, 
	AVG(orderdetails.priceEach) 
	FROM products
JOIN orderdetails 
USING (productCode)
GROUP BY products.productLine

SELECT productline,
	AVG(buyPrice)
	FROM products
GROUP BY productline
	


SELECT * FROM productlines
SELECT * FROM products


