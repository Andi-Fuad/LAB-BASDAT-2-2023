USE classicmodels;

-- No. 1
SELECT CONCAT(e.firstName, ' ', e.lastName) 'nama employee',
GROUP_CONCAT(o.orderNumber SEPARATOR '; ') 'Nomor Orderan',
COUNT(o.orderNumber) 'Jumlah pesanan'
FROM employees e
JOIN customers c
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN orders o
USING (customerNumber)
GROUP BY e.employeeNumber
HAVING COUNT(o.orderNumber) > 10;


-- No. 2
SELECT p.productCode, p.productName, p.quantityInStock, MIN(o.orderDate)
FROM products p
JOIN orderdetails od
USING (productCode)
JOIN orders o
USING (orderNumber)
GROUP BY p.productCode
HAVING p.quantityInStock > 5000;


-- No. 3
SELECT ofc.addressLine1 'Alamat', CONCAT(LEFT(ofc.phone, 6), '* **') 'Nomor Telp',
COUNT(DISTINCT e.employeeNumber) 'Jumlah Karyawan',
COUNT(DISTINCT c.customerNumber) 'Jumlah Pelanggan',
FORMAT(AVG(p.amount), 2) 'Rata-rata Penghasilan'
FROM offices ofc
JOIN employees e
USING (officeCode)
LEFT JOIN customers c
ON e.employeeNumber = c.salesRepEmployeeNumber
LEFT JOIN payments p
USING (customerNumber)
GROUP BY ofc.officeCode
ORDER BY ofc.phone;


-- No. 4
SELECT c.customerName, YEAR(o.orderDate) 'tahun order',
MONTHNAME(o.orderDate) 'bulan order',
COUNT(p.checkNumber) 'jumlah pesanan',
SUM(p.amount) 'uang total penjualan'
FROM customers c
JOIN orders o
USING (customerNumber)
JOIN payments p
USING (customerNumber)
WHERE YEAR(o.orderDate) = 2003
GROUP BY c.customerNumber, MONTHNAME(o.orderDate);


-- No. 5 (Tambahan)
SELECT p.productName, SUM(od.quantityOrdered) 'Jumlah Pesanan'
FROM products p
JOIN orderdetails od
USING (productCode)
JOIN orders o
USING (orderNumber)
GROUP BY p.productCode;
