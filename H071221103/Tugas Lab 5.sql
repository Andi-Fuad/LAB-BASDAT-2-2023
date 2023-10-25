USE classicmodels;

-- NOMOR 1
SELECT c.customername, p.productname, p2.paymentdate, o.status
FROM customers c
JOIN orders o USING (customernumber)
JOIN payments p2 USING (customernumber) 
JOIN orderdetails o2 USING (orderNumber) 
JOIN products p USING (productcode)
WHERE customername LIKE  "%Signal%" AND productname LIKE "%Ferrari%" AND STATUS = 'Shipped'

-- NOMOR 2
-- A.
SELECT c.customername, MONTHNAME (p.paymentdate) AS "Bulan", p.amount, CONCAT  (e.firstname," ",e.lastname) AS "Nama Karyawan"
FROM customers c JOIN payments p USING (customernumber)
JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber 
WHERE MONTHNAME (p.paymentdate) IN ("November")
-- pake ON karena forenkey yang ada dicustomers sama di employees itu berbeda

-- B
SELECT c.customername, MONTHNAME (p.paymentdate) AS "Bulan",p.amount, CONCAT (e.firstname, e.lastname)  AS "Nama Karyawan"
FROM customers c JOIN payments p USING (customernumber)
JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber 
WHERE MONTHNAME (p.paymentdate) IN ("November")
ORDER BY p.amount 
LIMIT 1

-- C
SELECT c.customername,p.productname
FROM customers c 
JOIN orders o USING (customernumber)
JOIN payments p2 USING (customernumber) 
JOIN orderdetails o2 USING (orderNumber) 
JOIN products p USING (productcode)
WHERE MONTHNAME (p2.paymentdate) IN ("November") AND c.customerName LIKE "Corporate%"

-- D
SELECT c.customerName, GROUP_CONCAT(p.productName) AS 'Nama Produk'
-- pake group concat supaya datanya tampil dalam satu baris kesamping
FROM payments p2
JOIN customers c
USING (customerNumber)
JOIN orders o
USING (customerNumber)
JOIN orderdetails o2
USING (orderNumber)
JOIN products p
USING (productCode)
WHERE MONTHNAME (p2.paymentDate) IN ("November") AND customerName LIKE ('Corporate%')

-- NOMOR 3
SELECT c.customername, o.orderdate, o.shippeddate, DATEDIFF (o.shippedDate, o.orderDate) AS 'Lama Hari'
-- pake datedif funsinya untuk melihat selisih tanggal
FROM customers c 
JOIN orders o USING (customernumber)
WHERE c.customername LIKE "%GiftsForHim.com%" AND o.orderDate IS NOT  NULL AND o.shippedDate IS NOT  NULL
-- dikasi notnull karena mau ditau tanggal kirim sama ordernya

-- NOMOR 4
USE world

SELECT CODE, NAME, lifeExpectancy
FROM country
WHERE CODE LIKE ('C%K') AND lifeExpectancy IS NOT NULL  
-- tidak boleh null karena yang diminta disoal harus yang ada expectany-nya
