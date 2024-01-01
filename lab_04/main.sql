CREATE EXTENSION IF NOT EXISTS plpython3u;
SELECT * FROM pg_language;

-- 1. Определяемая пользователем скалярная функция CLR
-- Выводит сумму ставки по ее идентификатору
CREATE OR REPLACE FUNCTION get_bet_summ(id_ INT) RETURNS VARCHAR
AS $$
    result = plpy.execute(f" \
        SELECT summ \
        FROM lab.Bets  \
        WHERE id = {id_}")

    return result[0]["summ"]
$$ language plpython3u;

SELECT get_bet_summ(12);


-- 2. Пользовательская агрегатная функция CLR
-- Выводит среднюю сумму ставки
CREATE OR REPLACE FUNCTION get_avg_summ() RETURNS float
AS $$
    result = plpy.execute(f" \
        SELECT AVG(summ) \
        FROM lab.bets")

    return result[0]["avg"]
$$ LANGUAGE plpython3u;

SELECT get_avg_summ();


-- 3. Определяемая пользователем табличная функция CLR
-- Выводит букмекеров с профитом больше заданного
CREATE OR REPLACE FUNCTION get_bookmakers_greater_profit(profit_ INT)
    RETURNS TABLE
        (
            bookmaker_name TEXT,
            profit INT,
            users INT
        )
AS $$
    table = plpy.execute(f"\
        SELECT bookmaker_name, profit, users \
        FROM lab.Bookmakers \
        WHERE profit > {profit_} \
        ORDER BY profit;")
    result = []

    for elem in table:
        result.append((elem["bookmaker_name"], elem["profit"], elem["users"]))

    return result
$$ LANGUAGE plpython3u;

SELECT get_bookmakers_greater_profit(20000000);


-- 4. Хранимая процедура CLR
-- Увеличивает коэффициент в полтора раза для ставок на теннис
SELECT *
INTO bets_tmp
FROM lab.Bets;

CREATE OR REPLACE PROCEDURE bonus_coefficient_tennis()
AS $$
    plpy.execute(f"\
        UPDATE bets_tmp \
        SET coefficient = coefficient * 1.5 \
        WHERE kind_of_sport = 'TENNIS'; \
    ")
$$ LANGUAGE plpython3u;

SELECT *
FROM bets_tmp
WHERE kind_of_sport = 'TENNIS';

call bonus_coefficient_tennis();


-- 5. Триггер CLR
-- Вместо удаления тикета со статусом 'SOLVED' изменяет его статус
CREATE VIEW tmp_users as
SELECT *
FROM lab.Users
WHERE bet_id < 200;

CREATE OR REPLACE FUNCTION delete_users()
    RETURNS TRIGGER LANGUAGE plpython3u
AS $$
    plpy.execute(f'''
        UPDATE tmp_users
        SET ban_status = 'BANNED'
        WHERE tmp_users.bet_id = {TD["old"]["bet_id"]};
        ''')
    return "MODIFY"
$$;

CREATE TRIGGER del_status_trigger
    INSTEAD of DELETE ON tmp_users
    FOR each ROW
    EXECUTE PROCEDURE delete_users();

select * from tmp_users;

DELETE FROM tmp_users
WHERE bet_id < 200;

SELECT id, bet_id, last_name, first_name, ban_status
FROM tmp_users;

-- 6. Определяемый пользователем тип данных CLR
-- Создает типы "финансы" с дополнительным полем "profit_total"
CREATE TYPE Financials AS
(
    id INT,
    bookmaker_name TEXT,
    profit INT,
    marketing_spent INT,
    profit_total INT
);

CREATE OR REPLACE FUNCTION get_financials()
    RETURNS setof Financials LANGUAGE plpython3u
AS $$
    result = plpy.cursor(f"\
        SELECT id, bookmaker_name, profit, marketing_spent \
        FROM lab.bookmakers \
        ORDER BY profit")

    for elem in map(lambda elem: (elem['id'], elem['bookmaker_name'], elem['profit'], elem['marketing_spent'], elem['profit'] - elem['marketing_spent']), result):
        yield elem
$$;

SELECT *
FROM get_financials();