USE Homework_4;

-- Создание таблицы Сотрудники
CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(255)
);

-- Создание таблицы Заказы
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    employee_id INT,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
);

-- Создание таблицы Клиенты
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(255)
);

-- Наполнение таблиц данными
INSERT INTO Employees (employee_id, employee_name) VALUES
(1, 'Алексей Иванов'), (2, 'Марина Петрова'), (3, 'Сергей Коваленко'), 
(4, 'Ольга Смирнова'), (5, 'Иван Кузнецов');

INSERT INTO Customers (customer_id, customer_name) VALUES
(1, 'Андрей Попов'), (2, 'Елена Иванова'), (3, 'Алексей Иванов'), 
(4, 'Марина Петрова'), (5, 'Сергей Коваленко'), (6, 'Ольга Смирнова'), 
(7, 'Иван Кузнецов'), (8, 'Виктория Сидорова'), (9, 'Дмитрий Орлов'), 
(10, 'Наталья Федорова');

INSERT INTO Orders (order_id, employee_id, customer_id, order_date, total_amount) VALUES
(1, 1, 1, '2023-01-15', 550.00),
(2, 2, 2, '2023-02-20', 600.00),
(3, 3, 3, '2023-03-10', 300.00),
(4, 4, 4, '2023-04-25', 750.00),
(5, 5, 5, '2023-05-18', 450.00),
(6, 1, 6, '2023-06-12', 500.00),
(7, 2, 7, '2023-07-21', 700.00),
(8, 3, 8, '2023-08-30', 620.00),
(9, 4, 9, '2023-09-14', 480.00),
(10, 5, 10, '2023-10-03', 510.00);

-- Показать все данные из таблицы Employees
SELECT * FROM Employees;

-- Показать все данные из таблицы Orders
SELECT * FROM Orders;

-- Показать все данные из таблицы Customers
SELECT * FROM Customers;

-- Задание 1: Получение заказов по сотруднику
CREATE PROCEDURE GetEmployeeOrders(IN emp_id INT)
BEGIN
    SELECT 
        o.order_id, 
        o.order_date, 
        c.customer_name
    FROM 
        Orders o
    JOIN 
        Customers c ON o.customer_id = c.customer_id
    WHERE 
        o.employee_id = emp_id
END;

-- Задание 2: Создание представления для суммы заказов по сотрудникам
CREATE VIEW EmployeeOrderSummary AS
SELECT 
    e.employee_name,
    SUM(o.total_amount) AS total_sales
FROM 
    Employees e
JOIN 
    Orders o ON e.employee_id = o.employee_id
GROUP BY 
    e.employee_name;

SELECT * FROM EmployeeOrderSummary;

-- Задание 3: Использование оконных функций для ранжирования заказов
SELECT 
    e.employee_name,
    o.order_id,
    o.total_amount,
    RANK() OVER (PARTITION BY e.employee_id ORDER BY o.total_amount DESC) AS order_rank
FROM 
    Employees e
JOIN 
    Orders o ON e.employee_id = o.employee_id;
    
    -- Задание 4: Получение предыдущего и следующего заказа для каждого заказа
SELECT 
    order_id,
    order_date,
    LAG(order_date) OVER (ORDER BY order_date) AS prev_order_date,
    LEAD(order_date) OVER (ORDER BY order_date) AS next_order_date
FROM 
    Orders;
    
    -- Задание 5: Аналитические функции для среднего, минимального и максимального значения заказов
SELECT 
    e.employee_name,
    o.order_id,
    o.total_amount,
    AVG(o.total_amount) OVER (PARTITION BY e.employee_id) AS avg_amount,
    MIN(o.total_amount) OVER (PARTITION BY e.employee_id) AS min_amount,
    MAX(o.total_amount) OVER (PARTITION BY e.employee_id) AS max_amount
FROM 
    Employees e
JOIN 
    Orders o ON e.employee_id = o.employee_id;
    
    -- Задание 6: Комплексный анализ заказов
CREATE VIEW OrderAnalysis AS
SELECT 
    e.employee_name,
    c.customer_name,
    o.order_id,
    o.total_amount,
    RANK() OVER (PARTITION BY e.employee_id ORDER BY o.total_amount DESC) AS order_rank,
    AVG(o.total_amount) OVER (PARTITION BY e.employee_id) AS avg_amount,
    MIN(o.total_amount) OVER (PARTITION BY e.employee_id) AS min_amount,
    MAX(o.total_amount) OVER (PARTITION BY e.employee_id) AS max_amount,
    LAG(o.order_date) OVER (ORDER BY o.order_date) AS prev_order_date,
    LEAD(o.order_date) OVER (ORDER BY o.order_date) AS next_order_date
FROM 
    Employees e
JOIN 
    Orders o ON e.employee_id = o.employee_id
JOIN 
    Customers c ON o.customer_id = c.customer_id;

SELECT * FROM OrderAnalysis;

CALL GetEmployeeOrders(1);



