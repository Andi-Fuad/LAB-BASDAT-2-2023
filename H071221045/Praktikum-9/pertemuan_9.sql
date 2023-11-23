USE classicmodels;

SELECT * FROM payments;

# AUTOCOMMIT
SET autocommit = off;

UPDATE payments 
SET amount=2000 
WHERE customernumber = 103;
COMMIT;

#1.Mulai transaction baru
START TRANSACTION;
#2. Mendapatkan order number terbaru
SELECT @orderNumber:=max(orderNumber)+1 from orders;
# 3. Menambahkan order baru untuk customer 145
INSERT INTO orders(orderNumber, orderDate, requiredDate, shippedDate,
status, customerNumber)
VALUES(@orderNumber,
'2005-05-31',
'2005-06-10',
'2005-06-11',
'In Process',
145);
# 4.Commit Perubahan
COMMIT;

# ROLLBACk
SELECT * FROM payments;

UPDATE payments 
SET amount=2000 
WHERE customernumber = 103;

ROLLBACK;

# INDEX

CREATE INDEX idx_customer_order_date ON orders(customernumber, orderdate)

# CONTROL FLOW

SELECT ordernumber, status,
CASE
WHEN status = 'shipped' THEN 'dikirim'
WHEN status = 'cancelled' THEN 'batal'
ELSE 'unknown'
END
AS pesan
FROM orders;

SELECT checknumber, amount,
case
when amount > 50000 then 'banyak'
ELSE 'sedikit'
END
FROM payments;

SELECT * FROM payments;