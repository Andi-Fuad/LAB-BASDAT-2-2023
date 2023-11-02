# Nomor 1
SELECT o.addressline1, o.addressLine2, o.city, o.country 
FROM employees e
SELECT o.addressline1, o.addressLine2, o.city, o.country 
FROM employees e
JOIN customers c
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN offices o
USING(officeCode)
JOIN payments p
USING(customernumber)
GROUP BY c.customerNumber
HAVING COUNT(p.amount) = (SELECT COUNT(amount) FROM payments GROUP BY customernumber ORDER BY COUNT(amount) LIMIT 1);

# Nomor 2
SELECT CONCAT(e.firstName, ' ', e.lastName) 'nama employee', sum(p.amount) 'pendapatan'
FROM employees e
JOIN customers c
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments p
USING (customernumber)
GROUP BY e.employeeNumber
HAVING sum(p.amount) = 
(SELECT sum(amount) FROM payments join customers using(customernumber) JOIN employees ON customers.salesRepEmployeeNumber = employees.employeeNumber
 GROUP BY employeenumber ORDER BY SUM(amount) DESC LIMIT 1) 
OR sum(p.amount) = 
(SELECT sum(amount) FROM payments join customers using(customernumber) JOIN employees ON customers.salesRepEmployeeNumber = employees.employeeNumber
 GROUP BY employeenumber ORDER BY SUM(amount) LIMIT 1);

# Nomor 3
SELECT country.code, country.continent, countrylanguage.language, country.name, country.population, countrylanguage.percentage FROM countrylanguage
JOIN country
ON country.code = countrylanguage.CountryCode
WHERE language='Arabic';

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
    c.`Name` 'Negara',
    (c.Population * (cl.Percentage/100)) 'Pengguna Bahasa'
FROM country c
JOIN countrylanguage cl
ON c.`Code` = cl.CountryCode
WHERE cl.`language` = 
		(SELECT countrylanguage.`language`
		FROM countrylanguage
		JOIN country
		ON country.`Code` = countrylanguage.CountryCode
		WHERE country.Continent = 'Asia'
		GROUP BY countrylanguage.`language`
		ORDER BY COUNT(countrylanguage.`language`) DESC
		LIMIT 1)
ORDER BY (c.Population * (cl.Percentage/100));

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
GROUP BY c.customerNumber;

-- kalau gunakan payments.amount
SELECT c.customerName, SUM(pm.amount) AS 'Total pembayaran',
SUM(od.quantityOrdered) 'banyak barang',
GROUP_CONCAT(p.productName SEPARATOR '; ')'produk yang dibeli'
FROM payments pm
JOIN customers c 
USING (customerNumber)
JOIN orders o 
USING (customerNumber)
JOIN orderdetails od 
USING (orderNumber)
JOIN products p 
USING (productCode)
GROUP BY customerNumber
HAVING SUM(pm.amount) > (
	SELECT AVG(payments.amount) FROM payments
)
ORDER BY c.customername;

# Nomor 5
SELECT c.Name, (SELECT COUNT(*) FROM city WHERE city.countrycode='USA') 'NumberOfCities'
FROM country c
WHERE CODE='USA';