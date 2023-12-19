-- 1. Хранимая процедура с параметрами
-- Добавляет пользователя в таблицу пользоватеелй
CREATE OR REPLACE PROCEDURE insert_user
(
    book_id INT,
    bet_id INT,
    transaction_id INT,
    ticket_id INT,
    last_name TEXT,
    first_name TEXT,
    passport_series INT,
    passport_number INT,
    ban_status TEXT
)
AS $$
    INSERT INTO lab.Users(book_id, bet_id, transaction_id, ticket_id, last_name, first_name, passport_series, passport_number, ban_status)
    VALUES (book_id, bet_id, transaction_id, ticket_id, last_name, first_name, passport_series, passport_number, ban_status);
$$ LANGUAGE SQL;

CALL insert_user(
    852,
    451,
    812,
    712,
    'Pisarenko',
    'Dmitriy',
    4610,
    153925,
    'NOT BANNED'
);

SELECT * FROM lab.Users
WHERE first_name = 'Dmitriy';


-- 2. Рекурсивная процедура
-- Вычисляются числа Фибоначчи до max
CREATE OR REPLACE PROCEDURE fib_find
(
    max_fib int,
    res inout INT,
    cur_fib INT,
    next_fib INT
) 
AS $$
DECLARE
    sum int;
BEGIN
    sum = cur_fib + next_fib;
    if sum <= max_fib then
        res = sum;
        RAISE INFO '%', next_fib;
        call fib_find(max_fib, res, next_fib, sum);
    end if;
END;
$$ LANGUAGE PLPGSQL;

call fib_find(20, null, 1, 1);


-- 3. Хранимая процедура с курсором
-- Выводятся суммы транзакций людей после определенной даты
CREATE OR REPLACE PROCEDURE get_sum_transactions_from_date(need_date date)
AS $$
DECLARE
    cur CURSOR FOR 
        SELECT summ
        FROM lab.Transactions
        WHERE Transactions.transaction_date >= need_date;
    sum INT;
BEGIN
    OPEN cur;
    LOOP
        FETCH cur INTO sum;
        EXIT WHEN NOT FOUND;
        RAISE NOTICE 'SUM: %', sum;
    END LOOP;
    CLOSE cur;
END;
$$ LANGUAGE plpgsql;

call get_sum_transactions_from_date('2021-01-01');


-- 4. Хранимая процедура доступа к метаданным
-- Выводит атрибуты и их типы таблицы, которая принимается в качестве параметра
CREATE OR REPLACE PROCEDURE meta_data(name_table text)
AS $$
DECLARE
    elem record;
BEGIN
    FOR elem IN (SELECT column_name, data_type
                 FROM information_schema.columns
                 WHERE table_name = name_table)
        LOOP
            RAISE INFO 'COLUMN = %', elem;
        END LOOP;
END
$$ LANGUAGE PLPGSQL;

call meta_data('bets');