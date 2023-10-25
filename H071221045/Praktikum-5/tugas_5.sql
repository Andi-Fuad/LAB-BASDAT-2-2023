USE classicmodels;

# Nomor 1

SELECT c.customerName, p.productName, pm.paymentDate, o.`status`
FROM customers c
JOIN orders o
ON c.customerNumber = o.customerNumber
JOIN orderdetails od
ON o.orderNumber = od.orderNumber
JOIN products p
ON od.productCode = p.productCode
JOIN payments pm
ON c.customerNumber = pm.customerNumber
WHERE p.productName LIKE '%Ferrari%' AND o.`status`= "Shipped";

# Nomor 2

## Bagian a.

SELECT c.customerName 'nama customer', 
pm.paymentDate 'tanggal pembayaran terkait',
CONCAT(e.firstName, ' ', e.lastName) 'karyawan'
FROM customers c
JOIN payments pm
USING(customerNumber)
JOIN employees e
ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE pm.paymentDate LIKE '%-11-%';

## Bagian b.

SELECT c.customerName 'nama customer', 
pm.paymentDate 'tanggal pembayaran terkait',
CONCAT(e.firstName, ' ', e.lastName) 'karyawan',
pm.amount 'transaksi'
FROM customers c
JOIN payments pm
USING(customerNumber)
JOIN employees e
ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE pm.paymentDate LIKE '%-11-%'
ORDER BY pm.amount DESC
LIMIT 1;

## Bagian c.

SELECT c.customerName, p.productName
FROM customers c
JOIN orders o
USING(customerNumber)
JOIN orderdetails od
USING(orderNumber)
JOIN products p
USING(productCode)
JOIN payments pm
USING(customerNumber)
WHERE c.customerName = 'Corporate Gift Ideas Co.' AND pm.paymentDate LIKE '%-11-%';

## Bagian d.

SELECT c.customerName 'Nama Customer',
GROUP_CONCAT(p.productName SEPARATOR ', ') 'Nama Produk'
FROM customers c
JOIN orders o
USING(customerNumber)
JOIN orderdetails od
USING(orderNumber)
JOIN products p
USING(productCode)
JOIN payments pm
USING(customerNumber)
WHERE c.customerName = 'Corporate Gift Ideas Co.' AND pm.paymentDate LIKE '%-11-%';

# Nomor 3

SELECT c.customerName, o.orderDate, o.shippedDate, (o.shippedDate - o.orderDate) 'Delay'
FROM customers c
JOIN orders o
USING (customerNumber)
WHERE c.customerName = 'GiftsForHim.com'
ORDER BY (o.shippedDate - o.orderDate) DESC;

# Nomor 4

SELECT * FROM country;

SELECT c.Code, c.Name, c.LifeExpectancy
FROM country c
WHERE c.Code LIKE 'C%K' AND c.LifeExpectancy IS NOT NULL;

# Nomor 5

SELECT c.Code, c.Name, c.LifeExpectancy
FROM country c
ORDER BY c.LifeExpectancy DESC
LIMIT 3