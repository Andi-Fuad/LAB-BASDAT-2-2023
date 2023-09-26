USE classicmodels;

#nomor 1
SELECT customerName, city, country
FROM customers
WHERE country = 'usa';

#nomor 2
SELECT DISTINCT productVendor
FROM products;

#nomor 3
SELECT customerNUmber, checkNumber, paymentdate, amount
FROM payments
WHERE customernumber = '124'
ORDER BY paymentdate DESC;

#nomor 4
SELECT productname AS 'Nama produk', buyprice AS 'Harga beli', quantityinstock AS 'Jumlah dalam stock'
FROM products
WHERE quantityinstock > 1000 AND quantityinstock <3000
ORDER BY buyprice
LIMIT 5,10;

#nomor 5
SELECT productCode, productName, productLine, productScale, quantityInStock, buyPrice 
FROM products
WHERE productScale = '1:18' AND buyPrice > 70 
ORDER BY buyPrice DESC;

  
SELECT *FROM products
