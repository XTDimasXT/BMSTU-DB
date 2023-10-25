-- 1. Инструкция SELECT, использующая предикат сравнения.
-- Выводит столбцы суммы ставок и коэффициентов, где коэффициент <= 2.00, сортирует по коэффициенту.
SELECT summ, coefficient
FROM lab.Bets
WHERE coefficient <= 2.00
ORDER BY coefficient;

-- 2. Инструкция SELECT, использующая предикат BETWEEN.
-- Выводит фамилию, имя работника и дату тикета, где тикеты были с 1990 по 2000 год.
SELECT worker_last_name, worker_first_name, ticket_date
FROM lab.Tickets
WHERE ticket_date BETWEEN '1990-01-01' AND '2000-01-01';

-- 3. Инструкция SELECT, использующая предикат LIKE. 
-- Выводит список букмекерских контор начинающихся на BET
SELECT DISTINCT bookmaker_name
FROM lab.Bookmakers
WHERE bookmaker_name LIKE 'BET%';

-- 4. Инструкция SELECT, использующая предикат IN с вложенным подзапросом.
-- Выводит book_id, bet_id, transaction_id, ticket_id в таблице пользователей тех событий, где сумма ставки в таблице  > 1000
SELECT book_id, bet_id, transaction_id, ticket_id
FROM lab.Users
WHERE bet_id IN (SELECT bet_id 
                 FROM lab.Bets 
                 WHERE summ > 1000);
