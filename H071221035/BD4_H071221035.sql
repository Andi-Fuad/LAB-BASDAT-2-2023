#NO 1

DROP DATABASE classicmodels;
#inner join
SELECT customers.customerName AS "nama customer",
		customers.country AS "negara",
		payments.paymentDate AS "tanggal" FROM customers
JOIN payments
ON customers.customerNumber = payments.customerNumber
WHERE payments.paymentDate >= '2005-01-01'
ORDER BY payments.paymentDate ;


#NO 2 
#inner dan left join mamang
SELECT *from productlines
SELECT * FROM orderdetails
SELECT * from products
SELECT DISTINCT
    c.customerName AS "nama customer",
    p.productName AS "productName",
    pl.textDescription AS "textDescription"
    
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

#NO 3
SELECT * FROM products
SELECT * FROM orders
SELECT * FROM orderdetails
ORDER BY quantityOrdered DESC
-- Tambahkan kolom 'status' ke tabel products
ALTER TABLE products
ADD COLUMN status VARCHAR(20);

UPDATE products
SET `status` = "Best Selling"
WHERE productCode = "S12_4675"

SELECT p.productCode,p.productName,od.quantityOrdered,p.`status` FROM products p
JOIN orderdetails od
ON p.productCode = od.productcode
WHERE p.`status` = "Best Selling" ORDER BY quantityOrdered DESC LIMIT 1;

#in case this query goes wrong run this query muehe
ALTER TABLE products
DROP COLUMN status;

#NO 4
SELECT * FROM orders
ALTER TABLE orders DROP FOREIGN KEY orders_ibfk_1;
ALTER TABLE orders ADD FOREIGN KEY (customerNumber) REFERENCES customers(customerN) ON DELETE CASCADE;

ALTER TABLE payments DROP FOREIGN KEY payments_ibfk_1;
ALTER TABLE payments ADD  FOREIGN KEY (customerNumber) REFERENCES customers(customerNumber) ON DELETE CASCADE;

ALTER TABLE orderdetails DROP FOREIGN KEY orderdetails_ibfk_1;
ALTER TABLE orderdetails ADD FOREIGN KEY (orderNumber) REFERENCES orders(orderNumber) ON DELETE CASCADE;

DELETE c FROM customers AS c
JOIN orders AS o
ON c.customerNumber = o.customerNumber
WHERE o.`status` = 'Cancelled';

SELECT * FROM orders
WHERE STATUS = "Cancelled"
SELECT * FROM orders

SELECT * FROM customers