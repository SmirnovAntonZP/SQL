USE Homework_2;

DROP TABLE IF EXISTS books;
CREATE TABLE books (
id INT AUTO_INCREMENT PRIMARY KEY,
title VARCHAR(255) NOT NULL,
author VARCHAR(255) NOT NULL,
year INT NOT NULL,
price DECIMAL(10, 2) NOT NULL
);

INSERT INTO books (title, author, year, price) VALUES
('Убить пересмешника', 'Харпер Ли', 1960, 300.00),
('1984', 'Джордж Оруэлл', 1949, 250.00),
('Великий Гэтсби', 'Ф. Скотт Фицджеральд', 1925, 200.00),
('Над пропастью во ржи', 'Дж. Д. Сэлинджер', 1951, 280.00),
('Моби Дик', 'Герман Мелвилл', 1851, 400.00),
('Скотный двор', 'Джордж Оруэлл', 1945, 220.00),
('Почти на Каталонии', 'Джордж Оруэлл', 1938, 180.00),
('Собака Баскервилей', 'Артур Конан Дойл', 1902, 350.00),
('Дневник Анны Франк', 'Анна Франк', 1947, 300.00),
('Краткая история времени', 'Стивен Хокинг', 1988, 320.00);

SELECT * FROM books;

/*Задание 1: Создание таблицы с жанрами книг
Создайте таблицу (сущность) с жанрами книг genres.
Перечень полей (атрибутов):
● id – числовой тип, автоинкремент, первичный ключ;
● name – строковый тип, обязательный к заполнению.
Заполните сущность genres следующими данными:*/

DROP TABLE IF EXISTS genres;

CREATE TABLE genres(
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL
);

Select * from genres;

INSERT INTO genres (name)
VALUES
('Художественная литература'),
('Нехудожественная литература'),
('Детектив'),
('Биография'),
('Наука');

/*Задание 2: Создание таблицы с авторами
Создайте таблицу (сущность) с авторами authors.
Перечень полей (атрибутов):
● id – числовой тип, автоинкремент, первичный ключ;
● name – строковый тип, обязательный к заполнению.
Заполните сущность authors данными из таблицы books.*/

DROP TABLE IF EXISTS author;
CREATE TABLE author(
	id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(45) NOT NULL
);

RENAME TABLE author TO authors;

INSERT INTO authors(name)
SELECT DISTINCT author
FROM books;

SELECT * FROM authors;

/*Задание 3: Добавление жанров и авторов в таблицу книг и вывод
книг по жанрам и авторам
Имеется таблица (сущность) с книгами books. У сущности имеются следующие поля
(атрибуты):
● id – идентификатор;
● title – название;
● author – автор;
● year – год издания;
● price – цена.
Создайте новые столбцы genre_id и author_id в таблице books и обновите
значения этих столбцов в соответствии с жанром и автором каждой книги:
Необходимо вывести название книг, их жанры и авторов*/
ALTER TABLE books
ADD genres_id int,
ADD author_id INT;

UPDATE books
SET genres_id = (SELECT id FROM genres WHERE name = 'Художественная литература')
WHERE title IN ('Убить пересмешника','1984','Великий Гэтсби','Над пропастью во ржи','Моби Дик','Скотный двор');

UPDATE books
SET genres_id = (SELECT id FROM genres WHERE name = 'Нехудожественная литература')
WHERE title = 'Почти на Каталонии';

UPDATE books
SET genres_id = (SELECT id FROM genres WHERE name = 'Детектив')
WHERE title = 'Собака Баскервилей';

UPDATE books
SET genres_id = (SELECT id FROM genres WHERE name = 'Биография')
WHERE title = 'Дневник Анны Франк';


UPDATE books
SET genres_id = (SELECT id FROM genres WHERE name = 'Наука')
WHERE title = 'Краткая история времени';

UPDATE books
SET author_id = (SELECT id FROM authors WHERE name = 'Харпер Ли')
WHERE title = 'Убить пересмешника';

UPDATE books
SET author_id = (SELECT id FROM authors WHERE name = 'Джордж Оруэлл')
WHERE title IN ('1984','Скотный двор','Почти на Каталонии');

UPDATE books
SET author_id = (SELECT id FROM authors WHERE name = 'Ф. Скотт Фицджеральд')
WHERE title  = 'Великий Гэтсби';

UPDATE books
SET author_id = (SELECT id FROM authors WHERE name = 'Дж. Д. Сэлинджер')
WHERE title  = 'Над пропастью во ржи';

UPDATE books
SET author_id = (SELECT id FROM authors WHERE name = 'Герман Мелвилл')
WHERE title  = 'Моби Дик';

UPDATE books
SET author_id = (SELECT id FROM authors WHERE name = 'Артур Конан Дойл')
WHERE title  = 'Собака Баскервилей';

UPDATE books
SET author_id = (SELECT id FROM authors WHERE name = 'Анна Франк')
WHERE title  = 'Дневник Анны Франк';

UPDATE books
SET author_id = (SELECT id FROM authors WHERE name = 'Стивен Хокинг')
WHERE title  = 'Краткая история времени';


SELECT * FROM books;
SELECT * FROM genres;
SELECT * FROM authors;
SELECT * FROM books, genres,authors;

/*
Задание 4: Обновление цен на книги
Имеется таблица (сущность) с книгами books. У сущности имеются следующие поля
(атрибуты):
● id – идентификатор;
● title – название;
● author – автор;
● year – год издания;
● price – цена.
Необходимо увеличить цену на все книги, изданные до 2000 года, на 10%.
*/
SELECT b.title AS book_title, g.name AS genre_name, a.name AS
author_name
FROM books b
JOIN genres g ON b.genres_id = g.id
JOIN authors a ON b.author_id = a.id;

SELECT * FROM books;

UPDATE books
SET price = price * 1.10
WHERE year < 2000;

/*Задание 5: Выборка книг по средней цене жанра
Имеется таблица (сущность) с книгами books и таблица с жанрами genres. У
сущностей имеются следующие поля (атрибуты):
● books.id – идентификатор;
● books.title – название;
● books.author – автор;
● books.year – год издания;
● books.price – цена;
● books.genre_id – идентификатор жанра;
● genres.id – идентификатор;
● genres.name – название жанра.
Необходимо вывести название жанра и среднюю цену книг в этом жанре для жанров,
где средняя цена выше 300.*/

SELECT genres.name AS genre_name, AVG(books.price) AS average_price
FROM books
JOIN genres ON books.genres_id = genres.id
GROUP BY genres.name
HAVING AVG(books.price) > 300;

