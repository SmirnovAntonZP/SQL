# Урок 4. SQL – работа с несколькими таблицами

## Задание 1: 
Получение заказов по сотруднику

## Задание 2: 
Создание представления для суммы заказов по сотрудникам

## Задание 3: 
Использование оконных функций для ранжирования заказов

## Задание 4: 
Получение предыдущего и следующего заказа для каждого заказа


## Задание 5: 
Аналитические функции для среднего, минимального и максимального значения заказов

## Задание 6: Комплексный анализ заказов

-----
# Урок 5

## Задача 1
- Создайте таблицу users_old, аналогичную таблице users. 
- Создайте процедуру, с помощью которой можно переместить любого (одного) пользователя из таблицы users в таблицу users_old. (использование транзакции с выбором commit или rollback – обязательно).

## Задача 2
- Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. 
- С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", 
- с 12:00 до 18:00  функция должна возвращать фразу "Добрый день",
- с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 "Доброй ночи".
