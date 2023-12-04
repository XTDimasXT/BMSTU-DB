-- 1. Инструкция SELECT, использующая предикат сравнения.
-- Выводит столбцы суммы ставок и коэффициентов, где коэффициент <= 2.00, сортирует по коэффициенту
SELECT summ, coefficient
FROM lab.Bets
WHERE coefficient <= 2.00
ORDER BY coefficient;

-- 2. Инструкция SELECT, использующая предикат BETWEEN.
-- Выводит фамилию, имя работника и дату тикета, где тикеты были с 1990 по 2000 год
SELECT worker_last_name, worker_first_name, ticket_date
FROM lab.Tickets
WHERE ticket_date BETWEEN '1990-01-01' AND '2000-01-01';

-- 3. Инструкция SELECT, использующая предикат LIKE. 
-- Выводит список букмекерских контор начинающихся на BET
SELECT DISTINCT bookmaker_name
FROM lab.Bookmakers
WHERE bookmaker_name LIKE 'BET%';

-- 4. Инструкция SELECT, использующая предикат IN с вложенным подзапросом.
-- Выводит book_id, bet_id, transaction_id, ticket_id в таблице пользователей тех событий, где сумма ставки в таблице > 1000
SELECT book_id, bet_id, transaction_id, ticket_id
FROM lab.Users
WHERE bet_id IN (SELECT bet_id 
                 FROM lab.Bets 
                 WHERE summ > 1000);

-- 5. Инструкция SELECT, использующая предикат EXISTS с вложенным подзапросом.
-- Выводит первые 10 пользователей, у которых есть ставки в таблице lab.Bets

SELECT *
FROM lab.Users 
WHERE EXISTS (SELECT * 
              FROM lab.Bets 
              WHERE lab.Users.bet_id = lab.Bets.id)
LIMIT 10;


-- 6. Инструкция SELECT, использующая предикат сравнения с квантором.
-- Выводит транзакции, у которых сумма больше чем сумма всех транзакций в период с 2015-11-03
SELECT * 
FROM lab.Transactions
WHERE summ > ALL (SELECT summ 
                  FROM lab.Transactions 
                  WHERE transaction_date > '2015-11-03');

-- 7. Инструкция SELECT, использующая агрегатные функции в выражениях столбцов.
-- Выводит вид спорта и суммирует сумму ставок для каждого вида спорта
SELECT kind_of_sport, SUM(summ) 
AS total_sum 
FROM lab.Bets 
GROUP BY kind_of_sport;

-- 8. Инструкция SELECT, использующая скалярные подзапросы в выражениях столбцов.
-- Выбирает фамилии и имена пользователей, а также название букмекера, у которого они сделали ставку.
SELECT first_name, last_name, 
        (SELECT bookmaker_name 
         FROM lab.Bookmakers 
         WHERE lab.Users.book_id = lab.Bookmakers.id) AS bookmaker_name 
FROM lab.Users;

-- 9. Инструкция SELECT, использующая простое выражение CASE. 
-- Выбирает id транзакции и определяет направление транзакции (депозит, вывод или неизвестно).
SELECT id, 
    CASE 
        WHEN transaction_type = 'DEPOSIT' THEN 'Incoming' 
        WHEN transaction_type = 'WITHDRAW' THEN 'Outgoing' 
        ELSE 'Unknown' 
    END AS transaction_direction 
FROM lab.Transactions;

-- 10. Инструкция SELECT, использующая поисковое выражение CASE.
-- Выводит тип транзакции, банк и определяет результирующую стоимость транзакции
SELECT transaction_type, bank,
    CASE 
        WHEN summ < 15000 THEN 'Inexpensive' 
        WHEN summ < 30000 THEN 'Fair' 
        WHEN summ < 45000 THEN 'Expensive' 
        ELSE 'Very Expensive' 
    END AS res_transaction
FROM lab.Transactions;

-- 11. Создание новой временной локальной таблицы из результирующего набора данных инструкции SELECT.




-- 12. Инструкция SELECT, использующая вложенные коррелированные подзапросы в качестве производных таблиц в предложении FROM.




-- 13. Инструкция SELECT, использующая вложенные подзапросы с уровнем вложенности 3.




-- 14. Инструкция SELECT, консолидирующая данные с помощью предложения GROUP BY, но без предложения HAVING. 




-- 15. Инструкция SELECT, консолидирующая данные с помощью предложения GROUP BY и предложения HAVING.




-- 16. Однострочная инструкция INSERT, выполняющая вставку в таблицу одной строки значений.




-- 17. Многострочная инструкция INSERT, выполняющая вставку в таблицу результирующего набора данных вложенного подзапроса. 




-- 18. Простая инструкция UPDATE. 




-- 19. Инструкция UPDATE со скалярным подзапросом в предложении SET.




-- 20. Простая инструкция DELETE.




-- 21. Инструкция DELETE с вложенным коррелированным подзапросом в предложении WHERE.




-- 22. Инструкция SELECT, использующая простое обобщенное табличное выражение.




-- 23. Инструкция SELECT, использующая рекурсивное обобщенное табличное выражение.




-- 24. Оконные функции. Использование конструкций MIN/MAX/AVG OVER().




-- 25. Оконные фнкции для устранения дублей. Придумать запрос, в результате которого в данных появляются полные дубли. 
-- Устранить дублирующиеся строки с использованием функции ROW_NUMBER().
