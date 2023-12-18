-- 1. Скалярная функция
-- Возвращает максимальную ставку из таблицы ставок
CREATE OR REPLACE FUNCTION get_max_bet()
RETURNS INT AS $$
    SELECT max(summ) 
    FROM lab.Bets;
$$ LANGUAGE SQL;

SELECT get_max_bet() AS max_bet;


-- 2. Подставляемая табличная функция
-- Возвращает таблицу людей, кто имеет ставку на конкретный вид спорта
CREATE OR REPLACE FUNCTION get_users_current_sport(sport TEXT)
RETURNS TABLE
(
    id INT,
    last_name TEXT,
    first_name TEXT
)
AS $$
    SELECT u.id, u.last_name, u.first_name
    FROM lab.Users u
    JOIN lab.Bets b
    ON u.bet_id = b.id
    WHERE b.kind_of_sport = sport;
$$ LANGUAGE SQL;

SELECT * FROM get_users_current_sport('TENNIS');


-- 3. Многооператорная табличная функция
-- Возвращает таблицы людей, кто имеет ставку на конкретный вид спорта последовательно (сначала всех со ставкой на теннис, потом на баскетбол и т.д.)
CREATE OR REPLACE FUNCTION get_needed_sports()
RETURNS TABLE
(
    id INT,
    last_name TEXT,
    first_name TEXT
)
AS $$
BEGIN
    RETURN QUERY SELECT * from get_users_current_sport('TENNIS');
    RETURN QUERY SELECT * from get_users_current_sport('BASKETBALL');
    RETURN QUERY SELECT * from get_users_current_sport('FOOTBALL');
    RETURN QUERY SELECT * from get_users_current_sport('TABLE TENNIS');
    RETURN QUERY SELECT * from get_users_current_sport('HOCKEY');
END ;
$$ LANGUAGE PLPGSQL;

SELECT * FROM get_needed_sports();

-- 4. Рекурсивная функция
-- Вычисляются числа Фибоначчи до max
CREATE OR REPLACE FUNCTION find_fib(first_fib INT, second_fib INT, max_fib INT)
RETURNS TABLE
(
    cur INT,
    next_fib INT,
    sum INT
) 
AS $$
BEGIN
    RETURN QUERY
        SELECT first_fib, second_fib, first_fib + second_fib;
    if second_fib <= max_fib then
        RETURN QUERY
            SELECT *
            FROM find_fib(second_fib, first_fib + second_fib, max_fib);
    end if;
END;
$$ LANGUAGE PLPGSQL;

SELECT * FROM find_fib(1, 1, 21);