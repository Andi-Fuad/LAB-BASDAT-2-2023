USE classicmodels;

-- No. 1
SELECT c.customerName 'Nama Customer', c.country 'Negara', p.paymentDate 'tanggal' FROM customers c
JOIN payments p
ON c.customerNumber = p.customerNumber
WHERE p.paymentDate > '2004-12-31'
ORDER BY p.paymentDate ASC;

-- No. 2
SELECT DISTINCT c.customerName 'Nama customer', p.productName, p.productDescription FROM customers c
JOIN orders o
ON c.customerNumber = o.customerNumber
JOIN orderdetails od
ON o.orderNumber = od.orderNumber
JOIN products p
ON od.productCode = p.productCode
WHERE p.productName = 'The Titanic';

-- No. 3
SELECT p.productCode, p.productName, p.`status`, od.quantityOrdered FROM products p
JOIN orderdetails od
ON p.productCode = od.productCode
ORDER BY quantityOrdered DESC 
LIMIT 5;

ALTER TABLE products
ADD `status` VARCHAR(20);

UPDATE products 
SET `status` = 'best selling'
WHERE productCode = 'S12_4675';
#
UPDATE products p
JOIN orderdetails od
ON p.productCode = od.productCode
SET p.`status` = 'best selling'
ORDER BY quantityOrdered DESC 
LIMIT 1;

-- No. 4
SELECT * FROM customers c
JOIN orders o
ON c.customerNumber = o.customerNumber
WHERE `status` = 'Cancelled';

--------
ALTER TABLE orders
DROP FOREIGN KEY orders_ibfk_1;
--
ALTER TABLE orders
ADD FOREIGN KEY (customerNumber) REFERENCES customers (customerNumber) ON DELETE CASCADE;

ALTER TABLE orderdetails
DROP FOREIGN KEY orderdetails_ibfk_1;
--
ALTER TABLE orderdetails
ADD FOREIGN KEY (orderNumber) REFERENCES orders (orderNumber) ON DELETE CASCADE;

ALTER TABLE payments
DROP FOREIGN KEY payments_ibfk_1;
--
ALTER TABLE payments 
ADD FOREIGN KEY (customerNumber) REFERENCES customers (customerNumber) ON DELETE CASCADE;

DELETE c
FROM customers c
LEFT JOIN orders o
ON c.customerNumber = o.customerNumber
WHERE o.`status` = 'Cancelled';

--
DROP DATABASE classicmodels;
