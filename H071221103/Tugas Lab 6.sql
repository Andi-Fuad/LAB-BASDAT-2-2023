USE classicmodels;

SELECT * FROM customers

-- Nomor 1
SELECT CONCAT(firstname,' ',e.lastname) AS "Nama Karyawan",GROUP_CONCAT(o.orderNumber) AS "Nomor Orderan",COUNT(od.quantityOrdered) AS "Jumlah pesanan"
FROM employees e JOIN customers c ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN orders o USING (customerNumber)
JOIN orderdetails od USING (ordernumber)
GROUP BY e.employeenumber
HAVING COUNT(od.quantityOrdered) > 10;
--  count fungsinya untuk menghitung total pesanan 

-- Nomor 2
SELECT o.productCode, p.productname, p.quantityInStock, o2.orderdate 
FROM orders o2
join orderdetails o
USING (orderNumber)
JOIN products p
USING (productCode)
GROUP BY productcode
HAVING quantityInStock >5000
ORDER BY orderdate

-- Nomor 3
SELECT oc.addressLine1 AS "Alamat Pertama", CONCAT(LEFT(oc.phone,9), '* ****') AS "No Telp", COUNT(DISTINCT e.employeeNumber) AS "Jumlah Karyawan",
COUNT(DISTINCT c.customerNumber) AS Jumlah_Pelanggan, FORMAT(AVG(p.amount),2) AS "Rata-Rata Penghasilan"
FROM offices oc LEFT JOIN employees e USING (officecode)
JOIN customers c ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN payments p USING (customernumber)
GROUP BY oc.officeCode
ORDER BY oc.phone;
-- left digunakan untuk mengambil sejumlah karakter tertentu
-- left join digunakan unutk memasukan semua baris dari tabel offices
SELECT * FROM offices

-- Nomor 4
SELECT c.customername AS CustomerName, YEAR(o.orderdate) AS TahunOrder , MONTH(o.orderdate) AS BulanOrder, COUNT(o.ordernumber) AS "Jumlah Pesanan", 
SUM(od.priceEach * od.quantityordered) AS "Uang total penjualan"
FROM customers c 
JOIN orders o USING (customernumber) 
JOIN orderdetails od USING (ordernumber)
WHERE YEAR(o.orderdate) = 2003
GROUP BY CustomerName,BulanOrder;
-- sum berfungsi untuk menjumlahkan semua hasil dari perkalian

-- tambahan soal 5
SELECT YEAR(o.orderdate) AS `YEAR` , SUM(od.quantityordered) AS total_sold
FROM orders o
JOIN orderdetails od USING (ordernumber)
GROUP BY YEAR(o.orderDate)
