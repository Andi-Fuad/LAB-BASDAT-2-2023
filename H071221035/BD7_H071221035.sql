USE classicmodels;
DROP clas

# NO 1
SELECT offices.addressline1, 
		offices.addressLine2, 
		offices.city, 
		offices.country 
FROM employees 
JOIN customers 
ON employees.employeeNumber = customers.salesRepEmployeeNumber
JOIN offices 
USING(officeCode)
WHERE customers.customerNumber IN (
												SELECT customerNumber FROM payments
												GROUP BY customernumber
												HAVING COUNT(*) = 
																	(SELECT COUNT(*) FROM payments
																	GROUP BY customernumber
																	ORDER BY COUNT(*)
																	LIMIT 1));


#1	
SELECT offices.addressLine1,offices.addressLine2,offices.city, offices.country
FROM offices
JOIN employees
USING (officeCode)
JOIN customers
ON customers.salesRepEmployeeNumber = employees.employeeNumber
JOIN payments
USING (customerNumber)
GROUP BY customers.customerNumber
	HAVING COUNT(*) = 
	(SELECT COUNT(*)
	FROM payments
	GROUP BY customerNumber
	ORDER BY COUNT(*)
	LIMIT 1);



# No 2
SELECT CONCAT(e.firstName, ' ', e.lastName) 'nama employee', 
		SUM(p.amount) 'pendapatan'
FROM employees e
JOIN customers c
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments p
USING (customernumber)
GROUP BY e.employeeNumber
HAVING SUM(p.amount) = 
		(SELECT SUM(p.amount) FROM payments p
		JOIN customers c
		USING (customernumber)
		JOIN employees e
		ON e.employeeNumber = c.salesRepEmployeeNumber
		GROUP BY e.employeeNumber
		ORDER BY SUM(p.amount) DESC
		LIMIT 1)
OR SUM(p.amount) = 
		(SELECT SUM(p.amount) FROM payments p
		JOIN customers c
		USING (customernumber)
		JOIN employees e
		ON e.employeeNumber = c.salesRepEmployeeNumber
		GROUP BY e.employeeNumber
		ORDER BY SUM(p.amount)
		LIMIT 1);

# No 3
USE  world;

SELECT
    c.`Name` 'Negara',
    (c.Population * cl.Percentage)/100 'Pengguna Bahasa'
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
ORDER BY (c.Population * cl.Percentage);
##

##
# No 4
USE classicmodels;

SELECT c.customerName, 
		SUM(p.amount) AS 'Total pembayaran', 
		SUM(od.quantityOrdered) 'banyak barang', 
		GROUP_CONCAT(pr.productName SEPARATOR '; ')'produk yang dibeli'
FROM payments p
JOIN customers c
USING (customerNumber)
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
JOIN products pr
USING (productcode)
GROUP BY customerNumber
HAVING SUM(p.amount) > 
		(SELECT AVG(jumlah)
			FROM (
			SELECT SUM(amount) 'jumlah'
			FROM payments
			GROUP BY customernumber) AS a)
ORDER BY c.customerName; 

-- tambahan
SELECT name AS 'name',
							(SELECT COUNT(*) FROM city WHERE countrycode = 'USA') AS 'numberOfcities'
	FROM country
	WHERE code = 'USA';
