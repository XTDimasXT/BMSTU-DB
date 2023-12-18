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
-- Создает временную таблицу BannedAccounts из забаненных аккаунтов
SELECT id, last_name, first_name
INTO TEMP TABLE BannedAccounts
FROM lab.Users
WHERE ban_status = 'BANNED';


-- 12. Инструкция SELECT, использующая вложенные коррелированные подзапросы в качестве производных таблиц в предложении FROM.
-- Выводит пользователей, у кого присутствуют ставки
SELECT u.id, first_name, last_name
FROM lab.Users u JOIN 
                (SELECT id, COUNT(id) as bets_count
                 FROM lab.Bets
                 GROUP BY id) as d
ON u.id = d.id
WHERE bets_count > 0;


-- 13. Инструкция SELECT, использующая вложенные подзапросы с уровнем вложенности 3.
-- Выбирает пользователей, которые сделали депозиты, делали ставку на футбол и имели тикет в поддержку после 1 января 2000 года
SELECT id, last_name, first_name
FROM lab.Users
WHERE book_id IN (SELECT id 
                  FROM lab.Bets 
                  WHERE kind_of_sport = 'FOOTBALL' AND id IN 
                                                          (SELECT id 
                                                           FROM lab.Transactions 
                                                           WHERE transaction_type = 'DEPOSIT' AND id IN
                                                                                                     (SELECT id
                                                                                                     FROM lab.Tickets
                                                                                                     WHERE ticket_date > '2000-01-01'
                                                                                                     )
                                                          )
                 );


-- 14. Инструкция SELECT, консолидирующая данные с помощью предложения GROUP BY, но без предложения HAVING.
-- Выводит спорт с итоговым количеством ставок на него
SELECT kind_of_sport, COUNT(*) AS total_bets
FROM lab.Bets
GROUP BY kind_of_sport;


-- 15. Инструкция SELECT, консолидирующая данные с помощью предложения GROUP BY и предложения HAVING.
-- Выводит спорт с итоговым количеством ставок на него, если количество ставок больше 145
SELECT kind_of_sport, COUNT(*) AS total_bets
FROM lab.Bets
GROUP BY kind_of_sport
HAVING COUNT(*) > 145;


-- 16. Однострочная инструкция INSERT, выполняющая вставку в таблицу одной строки значений.
-- Добавляет в таблицу ставок строку с указанными данными
INSERT INTO lab.Bets (kind_of_sport, summ, coefficient, bet_status, bet_type)
VALUES ('TABLE TENNIS', 5000, 2.52, 'WON', 'SINGLE');


-- 17. Многострочная инструкция INSERT, выполняющая вставку в таблицу результирующего набора данных вложенного подзапроса.
-- Добавляет в таблицу ставок строку с указанными данными
INSERT INTO lab.Bets (kind_of_sport, summ, coefficient, bet_status, bet_type)
SELECT (SELECT kind_of_sport
        FROM lab.Bets
        WHERE coefficient > 24.98),
summ, coefficient, 'WON', 'SINGLE'
FROM lab.Bets
WHERE coefficient > 24.98;


-- 18. Простая инструкция UPDATE.
-- Умножает коэффициенты выигранных ставок на 1.5
UPDATE lab.Bets
SET coefficient = coefficient * 2
WHERE bet_status = 'WON';


-- 19. Инструкция UPDATE со скалярным подзапросом в предложении SET.
-- Устанавливает средний коэффициент для выигранных ставок
UPDATE lab.Bets
SET coefficient = (SELECT AVG(coefficient)
                   FROM lab.Bets
                   WHERE bet_status = 'WON')
WHERE bet_status = 'WON';


-- 20. Простая инструкция DELETE.
-- Удаляет строки програнных ставок
DELETE FROM lab.Bets
WHERE bet_status = 'LOST'


-- 21. Инструкция DELETE с вложенным коррелированным подзапросом в предложении WHERE.
-- Удаляет пользователей, у которых идентификатор букмекера находится в подзапросе, который выбирает id, где сумма ставки больше 15000
DELETE FROM lab.Users
WHERE book_id IN (SELECT id 
                  FROM lab.Bets
                  WHERE summ > 15000);


-- 22. Инструкция SELECT, использующая простое обобщенное табличное выражение.
-- Выводит среднюю сумму ставки из top_bets
WITH top_bets (id, kind_of_sport, summ)
AS (SELECT
    id, kind_of_sport, summ
    FROM lab.Bets
    GROUP BY id
    HAVING summ BETWEEN 50000 AND 60000
    )
SELECT AVG(summ)
FROM top_bets;


-- 23. Инструкция SELECT, использующая рекурсивное обобщенное табличное выражение.
CREATE TABLE temp
(
    id SERIAL PRIMARY KEY,
    kind_of_sport VARCHAR(50),
    summ INT,
    next_id INT
);

-- Заполнение таблицы значениями.
INSERT INTO temp(kind_of_sport, summ, next_id) VALUES
    ('FOOTBALL', 10000, 2),
    ('TABLE TENNIS', 15000, NULL),
    ('FOOTBALL', 14300, 3);

-- Определение обобщенного табличного выражения
WITH RECURSIVE tempnew(id, kind_of_sport, summ, next_id)
    AS
    (
        -- Определение закрепленного элемента
        SELECT id, kind_of_sport, summ, next_id
        FROM temp
        WHERE id = 1
        UNION ALL
        -- Определение рекурсивного элемента
        SELECT t.id, t.kind_of_sport, t.summ, t.next_id
        FROM temp AS t
            JOIN tempnew AS tn ON tn.next_id = t.id
    )

-- Инструкция, использующая обобщенное табличное выражение
SELECT id, kind_of_sport, summ, next_id
FROM tempnew;


-- 24. Оконные функции. Использование конструкций MIN/MAX/AVG OVER().
-- Выводит среднюю, минимальную и максимальную серию паспорта, группируя по банку
SELECT t.id, t.bank, t.summ, u.passport_series,
    AVG(u.passport_series) OVER (PARTITION BY t.bank) AS avg_series,
    MIN(u.passport_series) OVER (PARTITION BY t.bank) AS min_series,
    MAX(u.passport_series) OVER (PARTITION BY t.bank) AS max_series
FROM lab.Transactions t JOIN lab.Users u
    ON t.id = u.transaction_id;


-- 25. Оконные фнкции для устранения дублей. Придумать запрос, в результате которого в данных появляются полные дубли. 
-- Устранить дублирующиеся строки с использованием функции ROW_NUMBER().
INSERT INTO lab.Tickets (worker_last_name, worker_first_name, theme, ticket_status, ticket_date) 
VALUES ('Bbbbb', 'Aaaaaa', 'VERIFICATION', 'SOLVED', '1989-01-05')

WITH temp
    AS
    (
        SELECT *
        FROM lab.Tickets
        UNION ALL
        SELECT *
        FROM lab.Tickets
    ),
    delete_twin
    AS
    (
        SELECT *, ROW_NUMBER() OVER (PARTITION BY worker_last_name, worker_first_name, theme, ticket_status, ticket_date) AS i
        FROM temp
    )

SELECT *
FROM delete_twin;


WITH temp
    AS
    (
        SELECT *
        FROM lab.Tickets
        UNION ALL
        SELECT *
        FROM lab.Tickets
    ),
    delete_twin
    AS
    (
        SELECT *, ROW_NUMBER() OVER (PARTITION BY worker_last_name, worker_first_name, theme, ticket_status, ticket_date) AS i
        FROM temp
    )

SELECT *
FROM delete_twin
WHERE i = 1;



-- Защита
-- Вывести имя всех пользователей, которые делали ставки на теннис, при этом ставка = 'WON', у него был тикет который 'NOT SOLVED'
SELECT u.id, u.first_name
FROM lab.Users u
JOIN lab.Bets b ON u.bet_id = b.id
JOIN lab.Tickets t ON u.ticket_id = t.id
WHERE b.kind_of_sport = 'TENNIS' 
AND b.bet_status = 'WON'
AND t.ticket_status = 'NOT SOLVED';
