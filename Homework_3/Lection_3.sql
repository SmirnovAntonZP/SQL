USE myfirstdb;

SELECT * FROM products 
ORDER BY price;

SELECT * FROM products 
ORDER BY price DESC;

SELECT ProductName, ProductCOunt * Price AS TotalSum
From products
ORDER BY price;

-- COUNT
SELECT COUNT(*)
FROM products;

SELECT COUNT(*) AS SUM
FROM products;

-- TOP(LIMIT)
SELECT * FROM Products
LIMIT 5;

SELECT * FROM Products
LIMIT 1,2;

-- LIMIT 3 - выводит нужное кол-во строк (3)
SELECT * FROM products
LIMIT 3;

-- LIMIT 2,3  - выводит 3 строки пропуская 2 первые
SELECT * FROM products
LIMIT 2,3;

-- SUM
SELECT SUM(Price) AS TotalSum FROM Products;

-- MIN/MAX

SELECT MIN(price) 
FROM Products
WHERE Manufacturer = 'Apple';

SELECT 
		MIN(Price),
		MAX(Price),
		AVG(Price) 
FROM products
WHERE manufacturer = 'Samsung';

-- выводит уникальные значения (повторяющиеся отфильтровываются)
SELECT distinct manufacturer,productcount from products;

SELECT distinct manufacturer from products;

SELECT Manufacturer, COUNT(*) AS ModelsCount 
FROM Products
GROUP BY Manufacturer;

-- AVG,SUM,MIN,MAX,COUNT - агрегатные функции 
SELECT AVG(price) AS Average_price FROM products;

SELECT AVG(price) FROM products
WHERE manufacturer = 'Apple';

SELECT count(*) FROM products;

-- HAVING фильтрует сгруппированные
SELECT Manufacturer,COUNT(*) AS ModelCount
FROM Products
GROUP BY Manufacturer
HAVING COUNT(*) > 1;

SELECT Manufacturer,COUNT(*) AS ModelCount
FROM Products
WHERE price * ProductCount > 80000
GROUP BY Manufacturer
HAVING COUNT(*) > 1;

SELECT Manufacturer,COUNT(*) AS Models, SUM(ProductCount) AS Units
FROM Products
WHERE price * ProductCount > 80000
GROUP BY Manufacturer
HAVING SUM(ProductCount) > 2
ORDER BY Units DESC;

SELECT * FROM products;


