USE classicmodels;

SET autocommit = OFF;

SELECT * FROM offices;
SELECT * FROM employees
JOIN offices
USING (officecode)
WHERE offices.city = 'London'

START TRANSACTION

DELETE FROM employees
WHERE 'employee name' IN (
	SELECT CONCAT(e.firstname, ' ', e.lastName) as 'employee name'
	FROM employees e
	JOIN offices o
	USING (officecode)
	WHERE o.city = 'London'
	)
UPDATE offices
SET city = 'New Boston'
WHERE city = 'Boston';

ROLLBACK;

# Nomor 2
select sum(quantityOrdered),
case
when sum(quantityOrdered) > 900 then "laku"
else "kurang laku"
end as status
from products p
join orderdetails o on p.productCode = o.productCode
group by o.productCode;

# Nomor 3
select count(customerNumber) as jumlah_client, employeeNumber,
case
when count(customerNumber) > 7 then "rajin"
else "makan gaji buta"
end as status
from employees e
join customers c on e.employeeNumber = c.salesRepEmployeeNumber
group by e.employeeNumber;
