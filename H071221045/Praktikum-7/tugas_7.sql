# Nomor 1
SELECT o.addressLine1, o.addressLine2, o.city, o.country
FROM offices o
JOIN employees e
USING (officecode)
JOIN customers c
ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE c.customerNumber =
(SELECT customers.customerNumber
FROM customers
JOIN payments
USING (customerNumber)
GROUP BY customers.customernumber
ORDER BY sum(payments.amount)
LIMIT 1);

# Nomor 2
SELECT CONCAT(e.firstName, ' ', e.lastName) 'nama employee', p.amount 'pendapatan'
FROM employees e
JOIN customers c
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments p
USING (customernumber)
WHERE p.amount = 
(SELECT MAX(amount) FROM payments) 
OR p.amount = 
(SELECT MIN(amount) FROM payments);

# Nomor 3
-- memperlihatkan bahasa yang paling banyak digunakan di benua asia
SELECT 
    c.Continent,
    cl.Language,
    COUNT(cl.Language) 'banyak negara'
FROM country c
JOIN countrylanguage cl 
ON c.Code = cl.CountryCode
WHERE c.Continent = 'Asia'
GROUP BY cl.Language
ORDER BY COUNT(cl.language) DESC
LIMIT 1;

SELECT
    c.Name 'Negara',
    c.Population 'Pengguna Bahasa'
FROM country c
JOIN countrylanguage cl
ON c.Code = cl.CountryCode
WHERE cl.language = 
(SELECT countrylanguage.language
FROM countrylanguage
JOIN country
ON country.Code = countrylanguage.CountryCode
WHERE country.Continent = 'Asia'
GROUP BY countrylanguage.language
ORDER BY COUNT(countrylanguage.language) DESC
LIMIT 1);

# Nomor 4
SELECT c.customerName,
    SUM(od.priceEach * od.quantityOrdered) 'Total pembayaran',
	 COUNT(od.productCode) 'banyak barang',
    GROUP_CONCAT(p.productName SEPARATOR ', ') 'produk yang dibeli'
FROM customers c
JOIN orders o
USING (customernumber)
JOIN orderdetails od
USING (ordernumber)
JOIN products p
USING (productcode)
WHERE c.customerNumber IN 
(SELECT orders.customerNumber
FROM orders
JOIN orderdetails
USING (ordernumber)
GROUP BY orders.customerNumber
HAVING AVG(orderdetails.priceEach * orderdetails.quantityOrdered) > 
(SELECT AVG(orderdetails.priceEach * orderdetails.quantityOrdered) 
FROM orderdetails))
GROUP BY c.customerNumber

