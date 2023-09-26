#1
SELECT customerName, city, country FROM customers WHERE country = "USA";

#2
SELECT DISTINCT productVendor FROM products;

#3
SELECT customerNumber, checkNumber, paymentDate,amount FROM payments WHERE customerNumber = 124 ORDER BY paymentDate DESC;

#4
SELECT productName AS `nama produk`, buyPrice AS  "harga beli", quantityInstock AS "jumlah dalam stok" from products WHERE quantityInstock >=1000 AND quantityInstock <=3000 ORDER BY buyPrice ASC LIMIT 5,10; 

#5
SELECT productCode,productName,productLine,productScale, quantityInstock AS kuantitas,buyprice FROM products WHERE buyprice >=72.56 AND productScale = "1:18" ORDER BY buyPrice ASC LIMIT 5 ;
