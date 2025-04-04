-- 1. Создание БД
# DROP DATABASE IF EXISTS lesson2;		-- Удаляем БД с именем lesson2, если БД найдена
CREATE DATABASE IF NOT EXISTS lesson2; 	-- Создаем БД с именем lesson2, если она не была создана


USE lesson2; -- Подключаемся к конкретной БД

-- DDL: CREATE (СОЗДАНИЕ ОБЪЕКТА), drop (удаление), alter (внести изм-я), rename(переименовать), TRUNCATE (очищает табличку, оставляет только заголовки столбцов)

-- DML: INSERT(добавить какие-то данные), UPDATE (обновление данных), DELETE, SELECT

/*
1) DDL (Data Definition Language, язык описания данных) — 
позволяет выполнять различные операции с базой данных, 
такие как CREATE (создание), ALTER (изменение) и DROP (удаление объектов).

2) DML (Data Manipulation Language, язык управления данными) — 
позволяет получать доступ к данным и манипулировать ими, 
например, вставлять, обновлять, удалять и извлекать данные из базы данных.

3) DCL (Data Control Language, язык контролирования данных) — 
позволяет контролировать доступ к базе данных. 
Пример — GRANT (предоставить права), REVOKE (отозвать права).
*/

-- 2. Создание таблицы
CREATE TABLE IF NOT EXISTS movies (
  id INT UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
  title VARCHAR(45) NOT NULL,
  title_eng VARCHAR(45),
  year_movie YEAR,
  count_min INT UNSIGNED,
  storyline TEXT,
  producer_id INT UNSIGNED NOT NULL 
);

CREATE TABLE IF NOT EXISTS producers (
  id INT UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
  name VARCHAR(45) NOT NULL
);


DESC movies;

-- 2.1 Добавление связей
ALTER TABLE movies -- Потомок
  ADD CONSTRAINT movies_producers_id_fk 
    FOREIGN KEY (producer_id) REFERENCES producers(id) -- Предок
	  ON DELETE SET NULL -- CASCADE, SET NULL, NO ACTION, RESTRICT, SET DEFAULT
      ON UPDATE CASCADE;


-- DML: insert
-- 3. Заполним таблицу данными

-- Не очень удобный вариант
INSERT movies (
  title, title_eng, year_movie, count_min, storyline, producer_id) 
VALUES 
  ("Игры Разума", "A Beautiful Mind", 2001, 135, "...", 1);

-- Заполняем ограниченное количество столбцов
INSERT movies -- В таком случае заполняются АБСОЛЮТНО все столбцы из таблицы movie
VALUES 
  (2, "Игры Разума", "A Beautiful Mind", 2001, 135, "...", 1);


SELECT * FROM movies;


-- Заполним таблицу producers
INSERT INTO producers (name) 
VALUES
  ("Гай Ричи"),
  ("Квентин Тарантино"),
  ("Кристофер Нолан");


INSERT INTO movies (title, title_eng, year_movie, count_min, producer_id, storyline)
VALUES 
  ('Игры разума', 'A Beautiful Mind', 2001, 135, 1, 'От всемирной известности до греховных глубин — все это познал на своей шкуре Джон Форбс Нэш-младший. Математический гений, он на заре своей карьеры сделал титаническую работу в области теории игр, которая перевернула этот раздел математики и практически принесла ему международную известность. Однако буквально в то же время заносчивый и пользующийся успехом у женщин Нэш получает удар судьбы, который переворачивает уже его собственную жизнь.'),
  ('Форрест Гамп', 'Forrest Gump', 1994, 142, 3, 'Сидя на автобусной остановке, Форрест Гамп — не очень умный, но добрый и открытый парень — рассказывает случайным встречным историю своей необыкновенной жизни. С самого малолетства парень страдал от заболевания ног, соседские мальчишки дразнили его, но в один прекрасный день Форрест открыл в себе невероятные способности к бегу. Подруга детства Дженни всегда его поддерживала и защищала, но вскоре дороги их разошлись.'),
  ('Иван Васильевич меняет профессию', NULL, 1998, 128, 3, 'Инженер-изобретатель Тимофеев сконструировал машину времени, которая соединила его квартиру с далеким шестнадцатым веком - точнее, с палатами государя Ивана Грозного. Туда-то и попадают тезка царя пенсионер-общественник Иван Васильевич Бунша и квартирный вор Жорж Милославский. На их место в двадцатом веке «переселяется» великий государь. Поломка машины приводит ко множеству неожиданных и забавных событий...'),
  ('Назад в будущее', 'Back to the Future', 1985, 116, 2, 'Подросток Марти с помощью машины времени, сооружённой его другом-профессором доком Брауном, попадает из 80-х в далекие 50-е. Там он встречается со своими будущими родителями, ещё подростками, и другом-профессором, совсем молодым.'),
  ('Криминальное чтиво', 'Pulp Fiction', 1994, 154, 2, NULL);

SELECT * FROM movies;


-- RENAME - переименовать
-- RENAME TABLE old_name TO new_name;
RENAME TABLE movies TO cinema;

-- TRUNCATE (очистка таблицы от данных)
TRUNCATE cinema;

INSERT INTO cinema (title, title_eng, year_movie, count_min, producer_id, storyline)
VALUES 
  ('Игры разума', 'A Beautiful Mind', 2001, 135, 1, 'От всемирной известности до греховных глубин — все это познал на своей шкуре Джон Форбс Нэш-младший. Математический гений, он на заре своей карьеры сделал титаническую работу в области теории игр, которая перевернула этот раздел математики и практически принесла ему международную известность. Однако буквально в то же время заносчивый и пользующийся успехом у женщин Нэш получает удар судьбы, который переворачивает уже его собственную жизнь.'),
  ('Форрест Гамп', 'Forrest Gump', 1994, 142, 3, 'Сидя на автобусной остановке, Форрест Гамп — не очень умный, но добрый и открытый парень — рассказывает случайным встречным историю своей необыкновенной жизни. С самого малолетства парень страдал от заболевания ног, соседские мальчишки дразнили его, но в один прекрасный день Форрест открыл в себе невероятные способности к бегу. Подруга детства Дженни всегда его поддерживала и защищала, но вскоре дороги их разошлись.'),
  ('Иван Васильевич меняет профессию', NULL, 1998, 128, 3, 'Инженер-изобретатель Тимофеев сконструировал машину времени, которая соединила его квартиру с далеким шестнадцатым веком - точнее, с палатами государя Ивана Грозного. Туда-то и попадают тезка царя пенсионер-общественник Иван Васильевич Бунша и квартирный вор Жорж Милославский. На их место в двадцатом веке «переселяется» великий государь. Поломка машины приводит ко множеству неожиданных и забавных событий...'),
  ('Назад в будущее', 'Back to the Future', 1985, 116, 2, 'Подросток Марти с помощью машины времени, сооружённой его другом-профессором доком Брауном, попадает из 80-х в далекие 50-е. Там он встречается со своими будущими родителями, ещё подростками, и другом-профессором, совсем молодым.'),
  ('Криминальное чтиво', 'Pulp Fiction', 1994, 154, 2, NULL);
  
SELECT * FROM cinema;

ALTER TABLE cinema
ADD test INT DEFAULT 100, -- Добавляем столбец test самой последней колонкой и задаем дефолтное значение 100
ADD price INT DEFAULT 0 AFTER id; -- Столбец price находится ПОСЛЕ столбца id


ALTER TABLE cinema
DROP test; -- Удалили столбец test

SELECT * FROM cinema;

-- UPDATE 
UPDATE cinema
SET price = price + 150
WHERE title LIKE '%Джон%';

/* Error Code: 1175. 
You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column. 
To disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect.


https://stackoverflow.com/questions/11448068/mysql-error-code-1175-during-update-in-mysql-workbench

SET SQL_SAFE_UPDATES = 0;


Follow the following steps before executing the UPDATE command: In MySQL Workbench

Go to Edit --> Preferences
Click "SQL Editor" tab and uncheck "Safe Updates" check box
Query --> Reconnect to Server // logout and then login
Now execute your SQL query
p.s., No need to restart the MySQL daemon! */


DELETE FROM cinema
WHERE title = 'Криминальное чтиво';


-- Доп. столбец: 0 - заказ не оплачен, 1 - заказ оплатили через Интернет
ALTER TABLE cinema
ADD film_status INT;

UPDATE cinema
SET film_status = RAND(); -- Или 0, или 1

SELECT *
FROM cinema;


-- CASE
SELECT id, title, film_status, -- Перед CASE ставится запятая
CASE
	WHEN film_status = 0 THEN "Нет доступа"
    WHEN film_status = 1 THEN "Приятного просмотра"
    ELSE "Error 404"
END AS result
FROM cinema;


-- IF (условие, ист_знч, ложное_знч)
SELECT IF (200 > 100, "200 больше, чем 100", "200 меньше, чем 100") AS result;
-- В зависимости от про-ти фильма вывести его тип:
-- До 50 минут - короткометражка
-- 50-140 - среднеметражка
-- 141-150 - полнометражка
-- 150+ - "очень долгий фильм :)"

SELECT
	id AS "Номер фильма",
    title AS "Название фильма",
    count_min AS "Продолжительность",
    IF(count_min < 50, "короткометражка", 
		IF(count_min BETWEEN 50 AND 140, "среднеметражка",
			IF(count_min BETWEEN 141 AND 150, "полнометражка", "очень долгий фильм :)")))
	AS "Тип фильма"
FROM cinema;



/* Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем. */

-- Cоздаём таблицу пользователй
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

-- Заполняем таблицу данными
INSERT INTO users (name, birthday_at, created_at, updated_at) VALUES
  ('Геннадий', '1990-10-05', NULL, NULL),
  ('Наталья', '1984-11-12', DEFAULT, NULL),
  ('Александр', '1985-05-20', NULL, NULL),
  ('Сергей', '1988-02-14', DEFAULT, DEFAULT),
  ('Иван', '1998-01-12', NULL, NULL),
  ('Мария', '1992-08-29', NULL, DEFAULT);

-- Проверяем данные
SELECT * FROM users;

-- Заполняем пустые значения. Разделим один запрос на два, чтоб исключить все ситуации:
UPDATE users SET created_at = NOW() WHERE created_at IS NULL;
UPDATE users SET updated_at = NOW() WHERE updated_at IS NULL;

-- Проверяем данные
SELECT * FROM users;