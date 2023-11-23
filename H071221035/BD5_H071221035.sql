USE classicmodels

#1
SELECT customers.customerName, products.productName, payments.paymentDate, orders.`status`
FROM products
JOIN OrderDetails
USING (productCode)
JOIN orders
USING (ordernumber)
JOIN customers
USING (customerNumber)
JOIN payments
USING (customerNumber)
WHERE productName LIKE '%Ferrari%' AND `status` = "Shipped"
LIMIT 3

#2A
SELECT customers.customerName,payments.paymentDate,employees.lastName,employees.firstName
FROM employees
JOIN customers
ON customers.salesRepEmployeeNumber = employees.employeeNumber
JOIN payments
USING (customerNumber)
WHERE payments.paymentDate LIKE '%-11-%'

#2b
SELECT customers.customerName,payments.amount,payments.paymentdate, CONCAT(employees.firstname,employees.lastName)
FROM employees
JOIN customers
ON customers.salesRepEmployeeNumber = employees.employeeNumber
JOIN payments
USING (customerNumber)
WHERE payments.paymentDate LIKE '%-11-%'
ORDER BY  amount DESC 
LIMIT 1

#2c

SELECT 
	c.customerName,
	p.productName
FROM payments AS py
JOIN customers AS c
USING (customerNumber)
JOIN orders AS o
USING (customerNumber)
JOIN orderdetails AS od
USING (orderNumber)
JOIN products AS p
USING(productCode)
WHERE c.customerName = 'Corporate Gift Ideas Co.' AND MONTH(py.paymentDate) = '11' AND YEAR (o.orderDate) = 2004;

#2d
SELECT 
	c.customerName,
	GROUP_CONCAT(p.productName) AS productName
FROM payments AS py
JOIN customers AS c
USING (customerNumber)
JOIN orders AS o
USING (customerNumber)
JOIN orderdetails AS od
USING (orderNumber)
JOIN products AS p
USING(productCode)
WHERE c.customerName = 'Corporate Gift Ideas Co.' AND MONTH(py.paymentDate) = '11'

#3
SELECT customers.customername,orders.shippedDate,orders.orderdate ,orders.shippedDate-orders.orderdate AS "Lama menunggu"
FROM orders
JOIN customers
USING (customernumber)
WHERE customers.customername = 'GiftsForHim.com'

ORDER BY orders.orderdate DESC 

#4
USE world

SELECT *from country

SELECT Code, lifeExpectancy FROM country
WHERE code LIKE 'C%K' AND  LifeExpectancy is NOT NULL;


#berikan data pemesanan 2004
SELECT * from orders
WHERE orderDate LIKE "2004%"

