-- 1. Создаем БД
DROP DATABASE IF EXISTS lesson3; -- Удаляем БД, если она существует 
CREATE DATABASE IF NOT EXISTS lesson3; -- Создаем БД lesson3, если ее раньше не было

-- 2. Выбираем конкретную БД
USE lesson3;


DROP TABLE IF EXISTS tbl;
CREATE TABLE tbl (
  x INT,
  y INT,
  summ INT AS (x + y)
);

INSERT INTO
  tbl (x, y)
VALUES
  (1, 1), (5, 6), (11, 12);

SELECT * FROM tbl;
/*
По умолчанию значения в вычисляемом столбце не сохраняются на жесткий диск, 
они каждый раз вычисляются снова. Однако если добавить в определение столбца 
ключевое слово STORED, то такой столбец будет сохраняться на жесткий диск. */

DROP TABLE IF EXISTS tbl;
CREATE TABLE tbl (
  x INT,
  y INT,
  summ INT AS (x + y) STORED
);

INSERT INTO
  tbl (x, y)
VALUES
  (1, 1), (5, 6), (11, 12);
SELECT * FROM tbl;


-- 3. Создание таблицы
CREATE TABLE IF NOT EXISTS staff (
  id INT AUTO_INCREMENT PRIMARY KEY, 
  first_name VARCHAR(45), 
  last_name VARCHAR(45), 
  post VARCHAR(45), 
  seniority INT, 
  -- DECIMAL(общее количество знаков, количество знаков после запятой)
  -- DECIMAL(5,2) будут числа от -999.99 до 999.99
  salary DECIMAL(8, 2), 
  -- это числа от -999999.99 до 999999.99
  age INT
);

# Заполнение данными
INSERT staff(
  first_name, last_name, post, seniority, salary, age) 
VALUES 
  ("Пользователь", "Тестовый", "Тест", 30, 50000, 50);

INSERT  staff (first_name, last_name, post, seniority, salary, age)
VALUES
	 ('Вася', 'Петров', 'Начальник', 40, 100000, 60),
	 ('Петр', 'Власов', 'Начальник', 8, 70000, 30),
	 ('Катя', 'Катина', 'Инженер', 2, 70000, 25),
	 ('Саша', 'Сасин', 'Инженер', 12, 50000, 35),
	 ('Иван', 'Петров', 'Рабочий', 40, 30000, 59),
	 ('Петр', 'Петров', 'Рабочий', 20, 55000, 60),
	 ('Сидр', 'Сидоров', 'Рабочий', 10, 20000, 35),
	 ('Антон', 'Антонов', 'Рабочий', 8, 19000, 28),
	 ('Юрий', 'Юрков', 'Рабочий', 5, 15000, 25),
	 ('Максим', 'Петров', 'Рабочий', 2, 11000, 19),
	 ('Юрий', 'Петров', 'Рабочий', 3, 12000, 24),
	 ('Людмила', 'Маркина', 'Уборщик', 10, 10000, 49);
 
SELECT * FROM staff;


-- Сортировка - ORDER BY
-- Выведите все записи, отсортированные по полю "name"
SELECT * 
FROM staff
ORDER BY first_name, age DESC;

-- Выведите все записи, отсортированные по полю "salary"
SELECT salary, id
FROM staff
ORDER BY salary; -- ASC - по в-ю (дефолтное состояние, ASC необязательно)

-- Выполните сортировку по полям "name" и "age" по убыванию
SELECT * 
FROM staff
ORDER BY first_name DESC, age DESC; -- DESC - по убыванию


-- Сортировка в алф. порядке по убыванию (Я -> A) столбцов "фамилия" и "имя"
SELECT first_name, last_name, salary, id 
FROM staff
ORDER BY last_name DESC, first_name DESC;
 
 
-- DISTINCT , LIMIT
SELECT last_name
FROM staff;

SELECT DISTINCT last_name
FROM staff
ORDER BY last_name;

--  Только топ-5 уникальных фамилий, по во-ю от "А" до "Я"
-- LIMIT 5; -- id =1,2,3,4,5
SELECT DISTINCT last_name
FROM staff
ORDER BY last_name
LIMIT 5;

SELECT age 
FROM staff
ORDER BY age DESC
LIMIT 1; 

SELECT * FROM staff
WHERE age = 60;

SELECT * 
FROM staff
WHERE age = (SELECT age FROM staff ORDER BY age DESC LIMIT 1);

SELECT * 
FROM staff
WHERE age = (SELECT Max(age) FROM staff);

/*Чтобы извлечь следующие две записи, используется ключевое слово 
LIMIT с двумя числами. Первое указывает позицию, начиная с которой 
необходимо вернуть результат, а второе — количество извлекаемых записей.*/

-- Пропустить первые 4 строчки и вывести след-е 3 строчки
-- id = 5,6,7
SELECT id, last_name
FROM staff
LIMIT 4, 3;

/* Существует и альтернативная форма записи такого оператора, 
с использованием ключевого слова OFFSET:*/
SELECT id, last_name
FROM staff
LIMIT 5 OFFSET 4;


-- Пропустите две последнии строки (где id=12, id=11) и извлекаются
-- следующие за ними 3 строки (где id=10, id=9, id=8)
SELECT * 
FROM staff
ORDER BY id DESC
LIMIT 3, 3;


-- Агрегатные функции, группировка
-- В завимисимости от должности сотрудника найти:
-- мин зп, макс зп, среднюю зп, количество сотрудников, суммарную зп, 
-- разницу между макс и мин зп 
SELECT * FROM staff;

SELECT 
	post,
	MIN(salary) AS "Мин зп",
    MAX(salary) AS "Макс зп",
    ROUND(AVG(salary),2) AS "Средняя зп",
    COUNT(salary) AS "Количество сотрудников",
    SUM(salary) AS "Суммарная зп",
    MAX(salary) - MIN(salary) AS "Разница между самой большой и самой маленькой ЗП"
FROM staff
WHERE post != "начальник" -- до формирования групп (до группировки) происходит фильтрация
GROUP BY post;
-- HAVING AVG(salary) > 25000; -- Условие наложили на сгруппированные данные (после группировки)




-- Группировка и агрегация, первая таблица
CREATE TABLE `employee_tbl` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `employee_id` int unsigned NOT NULL,
  `name` varchar(45) NOT NULL,
  `work_date` date NOT NULL,
  `daily_typing_pages` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
);
  
INSERT INTO `employee_tbl` (`employee_id`, `name`, `work_date`, `daily_typing_pages`) VALUES ('1', 'John', '2007-01-24', '250');
INSERT INTO `employee_tbl` (`employee_id`, `name`, `work_date`, `daily_typing_pages`) VALUES ('2', 'Ram', '2007-05-27', '220');
INSERT INTO `employee_tbl` (`employee_id`, `name`, `work_date`, `daily_typing_pages`) VALUES ('3', 'Jack', '2007-05-06', '170');
INSERT INTO `employee_tbl` (`employee_id`, `name`, `work_date`, `daily_typing_pages`) VALUES ('3', 'Jack', '2007-04-06', '100');
INSERT INTO `employee_tbl` (`employee_id`, `name`, `work_date`, `daily_typing_pages`) VALUES ('4', 'Jill', '2007-04-06', '220');
INSERT INTO `employee_tbl` (`employee_id`, `name`, `work_date`, `daily_typing_pages`) VALUES ('5', 'Zara', '2007-06-06', '300');
INSERT INTO `employee_tbl` (`employee_id`, `name`, `work_date`, `daily_typing_pages`) VALUES ('5', 'Zara', '2007-02-06', '350');

SELECT * 
FROM employee_tbl;


SELECT name 
FROM employee_tbl
GROUP BY name;

SELECT name, 300 FROM employee_tbl;

SELECT name, COUNT(300), ANY_VALUE(daily_typing_pages), MAX(daily_typing_pages)
FROM employee_tbl
GROUP BY name;


SELECT work_date FROM employee_tbl;

SELECT id, name, SUBSTRING(work_date, 6, 2) 
FROM employee_tbl;

SELECT id, name, SUBSTRING(work_date, 6, 2) AS decade, work_date
FROM employee_tbl ORDER BY decade DESC;



SELECT 
  id, 
  name, 
  SUBSTRING(work_date, 6, 2) AS decade
FROM employee_tbl 
GROUP BY decade;

SELECT SUBSTRING(work_date, 6, 2) AS decade, COUNT(*) 
FROM employee_tbl GROUP BY decade;

SELECT DAY(work_date) AS decade, COUNT(*) 
FROM employee_tbl GROUP BY decade;

SELECT MONTHNAME(work_date) AS decade, COUNT(*) 
FROM employee_tbl GROUP BY decade;

SELECT 
  MONTHNAME(work_date) AS decade, 
  SUM(daily_typing_pages) AS namedfsdfasd
FROM employee_tbl 
GROUP BY decade;


-- Давайте подробнее остановимся на реакции агрегационных функций на NULL-значение. 
-- Для этого создадим таблицу, содержащую два столбца — id и value:
DROP TABLE IF EXISTS tbl;
CREATE TABLE tbl (
  id INT NOT NULL,
  value INT DEFAULT NULL
);

INSERT INTO tbl VALUES (1, 230);
INSERT INTO tbl VALUES (2, NULL);
INSERT INTO tbl VALUES (3, 405);
INSERT INTO tbl VALUES (4, NULL);

SELECT *, 13 FROM tbl;

-- Давайте применим функцию COUNT() к обоим столбцам:
SELECT COUNT(id), COUNT(value) FROM tbl;

-- Это связано с тем, что COUNT игнорирует NULL-поля.
-- Если вместо имени столбца используется звездочка, значения NULL не влияют на результат:
SELECT COUNT(*) FROM tbl;



SELECT * FROM employee_tbl;


SELECT 
  name,
  COUNT(1) AS count_group,
  SUM(daily_typing_pages) AS sum_daily_typing_pages
FROM employee_tbl
GROUP BY name
HAVING count_group > 2
ORDER BY name DESC;


SELECT 
  MONTHNAME(work_date) AS month_name,
  COUNT(*)
FROM employee_tbl
WHERE NOT(MONTHNAME(work_date) = "May" AND name = "Jack")
GROUP BY month_name;

SELECT 
  MONTHNAME(work_date) AS month_name,
  COUNT(*) AS count_group
FROM employee_tbl
WHERE NOT(MONTHNAME(work_date) = "May" AND name = "Jack")
GROUP BY month_name
HAVING count_group = 2;


SELECT 
  MONTHNAME(work_date) AS month_name,
  COUNT(1) AS count_group,
  SUM(daily_typing_pages) AS sum_daily_typing_pages
FROM employee_tbl
WHERE mployee_id <> 3
GROUP BY month_name
WITH ROLLUP
HAVING sum_daily_typing_pages > 300
ORDER BY sum_daily_typing_pages DESC;


SELECT 
  MONTHNAME(work_date) AS decade, 
  COUNT(*) AS count
FROM employee_tbl 
GROUP BY decade
WITH ROLLUP
ORDER BY count DESC;