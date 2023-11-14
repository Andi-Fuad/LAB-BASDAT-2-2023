USE classicmodels;

-- No. 1
SELECT c.customerName, p.productName, pm.paymentDate, o.`status`
FROM customers c
JOIN payments pm
USING (customerNumber)
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
JOIN products p
USING (productCode)
WHERE p.productName LIKE "%Ferrari%" AND o.`status` = 'Shipped';


-- No. 2
# a
SELECT c.customerName, pm.paymentDate, e.firstName, e.lastName
FROM customers c
JOIN payments pm
USING (customerNumber)
JOIN employees e
ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE pm.paymentDate LIKE "%-11-%";

# b
SELECT c.customerName, pm.paymentDate, CONCAT(e.firstName, " ", e.lastName) 'Employee Name', pm.amount
FROM customers c
JOIN payments pm
USING (customerNumber)
JOIN employees e
ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE pm.paymentDate LIKE "%-11-%"
ORDER BY pm.amount DESC
LIMIT 1;

#####
SELECT c.customerNumber, c.customerName, pm.paymentDate, e.firstName, e.lastName
FROM customers c
JOIN payments pm
USING (customerNumber)
JOIN employees e
ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE pm.paymentDate LIKE "%-11-%"
GROUP BY c.customerNumber
ORDER BY COUNT(c.customerNumber) DESC;
#####

# c
## Cek siapa customer-nya
SELECT c.customerNumber, c.customerName, pm.paymentDate, pm.amount
FROM customers c
JOIN payments pm
USING (customerNumber)
JOIN employees e
ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE pm.paymentDate LIKE "%-11-%"
ORDER BY pm.amount DESC
LIMIT 1;
##

SELECT c.customerName, p.productName
FROM customers c
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
JOIN products p
USING (productCode)
WHERE c.customerNumber = 321;

# d
SELECT DISTINCT c.customerName, GROUP_CONCAT(p.productName SEPARATOR '; ') 'All Products'
FROM customers c
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
JOIN products p
USING (productCode)
WHERE c.customerNumber = 321 AND o.`status` = 'Shipped';


-- No. 3
SELECT c.customerName, o.orderDate, o.shippedDate, (o.shippedDate - o.orderDate) 'Delay', o.`status`
FROM customers c
JOIN orders o
USING (customerNumber)
WHERE c.customerName = 'GiftsForHim.com'
ORDER BY (o.shippedDate - o.orderDate) DESC;


-- No. 4
USE world;

SELECT `Name`, lifeExpectancy FROM country
WHERE `Code` LIKE "C%K" AND lifeExpectancy IS NOT NULL;


-- NO. 5 (Soal Tambahan)
SELECT * FROM orders
WHERE orderDate LIKE "%10";
