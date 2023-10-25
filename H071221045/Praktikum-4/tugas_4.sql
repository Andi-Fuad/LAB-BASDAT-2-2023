USE classicmodels

# Nomor 1

SELECT c.customerName 'Nama Customer', c.country 'Negara', p.paymentDate 'tanggal'
FROM customers c
JOIN payments p
ON c.customerNumber = p.customerNumber
WHERE p.paymentDate >= '2005-01-01'
ORDER BY p.paymentDate ASC;

# Nomor 2

SELECT DISTINCT c.customerName 'Nama Customer', p.productName, pl.textDescription
FROM customers c
JOIN orders o
ON c.customerNumber = o.customerNumber
JOIN orderdetails od
ON o.orderNumber = od.orderNumber
JOIN products p
ON od.productCode = p.productCode
JOIN productlines pl
ON p.productLine = pl.productLine
WHERE p.productName = 'The Titanic';

# Nomor 3

SELECT * FROM orderdetails
ORDER BY quantityOrdered DESC;

SELECT * FROM products
WHERE productCode = "S12_4675";

ALTER TABLE products
ADD COLUMN status VARCHAR(20);

UPDATE products AS upd
  JOIN
    ( SELECT p.productCode
      FROM products AS p
        JOIN
           orderdetails AS od ON od.productCode = p.productCode
      ORDER BY od.quantityOrdered DESC
      LIMIT 1
    ) AS sel
    ON sel.productCode = upd.productCode
SET 
   upd.`status` = 'best selling' ;

SELECT p.productCode, p.productName, od.quantityOrdered, p.`status`
FROM products p
JOIN orderdetails od
ON p.productCode = od.productCode
WHERE p.`status`='best selling'
ORDER BY od.quantityOrdered DESC
LIMIT 1;

SELECT * FROM products

--

UPDATE products
SET `status`='best selling'
WHERE productCode='S12_4675';

SELECT p.productCode
      FROM products p
        JOIN orderdetails od ON od.productCode = p.productCode
      ORDER BY od.quantityOrdered DESC
      LIMIT 1

# Nomor 4

SELECT * FROM customers;

SELECT * FROM orders;

SELECT c.customerNumber, o.`status`
FROM customers c
JOIN orders o
ON c.customerNumber = o.customerNumber
WHERE o.`status`='cancelled';

ALTER TABLE payments DROP FOREIGN KEY payments_ibfk_1;     
ALTER TABLE payments ADD FOREIGN KEY (customerNumber) REFERENCES customers (customerNumber) ON DELETE CASCADE;

ALTER TABLE orders DROP FOREIGN KEY orders_ibfk_1;     
ALTER TABLE orders ADD FOREIGN KEY (customerNumber) REFERENCES customers (customerNumber) ON DELETE CASCADE;

ALTER TABLE orderdetails DROP FOREIGN KEY orderdetails_ibfk_1;     
ALTER TABLE orderdetails ADD FOREIGN KEY (orderNumber) REFERENCES orders (orderNumber) ON DELETE CASCADE;

DELETE c
FROM customers c
LEFT JOIN orders o
ON c.customerNumber = o.customerNumber
WHERE o.`status`='Cancelled';
