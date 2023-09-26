# Nomor 1
USE classicmodels;

SELECT customerName, city, country
FROM customers
WHERE country='usa';

# Nomor 2
SELECT DISTINCT productVendor
FROM products;

# Nomor 3
SELECT customerNumber, checknumber, paymentdate, amount
FROM payments
WHERE customernumber='124'
ORDER BY paymentdate DESC;

# Nomor 4
SELECT productname 'Nama produk', buyprice 'Harga beli', quantityinstock 'Jumlah dalam stock'
FROM products
WHERE quantityinstock BETWEEN 1000 AND 3000
ORDER BY buyprice ASC
LIMIT 10 OFFSET 5;

# Nomor 5
SELECT * FROM customers;

SELECT customernumber, customername, addressline1, addressline2, creditlimit
FROM customers
WHERE country='usa' 
	AND addressline2 IS NOT NULL
	AND creditlimit BETWEEN 50000 AND 200000
LIMIT 5;
