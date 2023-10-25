USE classicmodels;

# Nomor 1

SELECT CONCAT(e.firstName, ' ', e.lastName) AS 'nama employee', 
		GROUP_CONCAT(o.orderNumber) AS 'Nomor Orderan', 
		COUNT(o.orderNumber) AS 'Jumlah pesanan'
FROM employees e
JOIN customers c 
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN orders o 
USING (customerNumber)
GROUP BY e.employeeNumber HAVING COUNT(o.orderNumber) > 10;

# Nomor 2

SELECT p.productCode, p.productName, p.quantityInStock, o.orderDate
FROM products p
JOIN orderdetails od
USING (productCode)
JOIN orders o
USING (orderNumber)
GROUP BY p.productCode HAVING p.quantityInStock > 5000
ORDER BY o.orderDate ASC;

# Nomor 3

SELECT 
    os.addressLine1 Alamat,
    CONCAT(SUBSTRING(os.phone, 1, LENGTH(os.phone) - 6), '* ****') 'Nomor Telp',
    COUNT(DISTINCT e.employeeNumber) 'Jumlah Karyawan',
    COUNT(DISTINCT c.customerNumber) 'Jumlah Pelanggan', 
    format(AVG(p.amount), 2) 'Rata-rata Penghasilan'
FROM offices os
LEFT JOIN employees e
USING (officeCode)
LEFT JOIN customers c
ON e.employeeNumber = c.salesRepEmployeeNumber
LEFT JOIN payments p
USING (customerNumber)
GROUP BY os.addressLine1
ORDER BY os.phone;

# Nomor 4

SELECT 
	 c.customerName, 
	 YEAR(o.orderDate) 'tahun order', 
	 MONTH(o.orderDate) 'bulan order', 
	 COUNT(o.orderNumber) 'jumlah penjualan', 
	 SUM(p.amount) 'uang total penjualan'
FROM customers c
JOIN orders o
USING (customerNumber)
JOIN payments p
USING (customerNumber)
WHERE YEAR(o.orderDate) = 2003
GROUP BY c.customerNumber, MONTH(o.orderDate)
ORDER BY MONTH(o.orderDate) ASC;

# Nomor 5

SELECT SUM(od.quantityOrdered * od.priceEach) 'total harga pesanan', YEAR(o.orderDate) 'tahun pesan'
from orders o
JOIN orderdetails od
USING (orderNumber)
GROUP BY YEAR(o.orderDate);

