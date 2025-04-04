USE Homework_1;

SELECT *
FROM books;

-- Задание 2
-- Необходимо вывести название, автора и цену для книг, которые были изданы после
-- 1950 года в порядке возрастания цены

SELECT title,author, price
FROM books
WHERE year > 1950
ORDER BY price ASC;

-- Задание 3
--  Необходимо вывести идентификатор, название, автора, год издания и цену для книг, у
-- которых автор «Джордж Оруэлл» и изданные после 1940 года..

select idbooks, title, author, year, price 
FROM books 
WHERE author = 'Джордж Оруэлл' 
	AND year > 1940;
    
-- Задание 4*: Анализ и статистика по книгам

-- Необходимо выполнить следующие задачи:

-- 1. Подсчитать общее количество книг в таблице.
Select count(*) AS total_books
FROM books;

-- 2. Найти среднюю цену книг.
SELECT avg(price) AS average_books
FROM books;
-- 3. Вывести автора, у которого самая дорогая книга.
SELECT author
FROM books
WHERE price = (SELECT MAX(price) FROM books);

-- 4. Подсчитать количество книг для каждого автора и вывести
-- авторов, у которых более одной книги.
SELECT author, COUNT(*) AS book_count
FROM books
GROUP by author
HAVING COUNT(*) > 1;

-- 5. Найти книги, изданные до 1950 года, и вывести их названия и
-- авторов в алфавитном порядке авторов.
SELECT title, author
FROM books
WHERE year > 1950
ORDER BY author;


