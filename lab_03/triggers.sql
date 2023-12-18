-- 1. Триггер AFTER
-- Триггер срабатывает после добавления новой записи в таблицу букмекеров
CREATE OR REPLACE FUNCTION bookmakers_insert()
RETURNS TRIGGER
AS $$
BEGIN
    RAISE NOTICE 'INSERTED new record to Bookmakers';
    RETURN new;
END
$$ LANGUAGE PLPGSQL;

CREATE OR REPLACE TRIGGER update_trigger
    AFTER INSERT ON lab.Bookmakers
    FOR each ROW
EXECUTE FUNCTION bookmakers_insert();

INSERT INTO lab.Bookmakers(bookmaker_name, profit, marketing_spent, users, active_users)
VALUES ('WINLINE', 75350250, 5850350, 20000, 15000);


-- 2. Триггер INSTEAD OF
-- Вместо удаления вида спорта запись помещается в конец таблицы и к названию вида спорта добавляется "deleted_"
CREATE VIEW bets_view AS SELECT * FROM lab.Bets;

CREATE OR REPLACE FUNCTION on_delete_bet()
RETURNS trigger 
AS $$
DECLARE
    old_name TEXT = old.kind_of_sport;
BEGIN
    UPDATE bets_view
    SET
        kind_of_sport = 'deleted_' || old_name
    WHERE id = old.id;
    RETURN old;
END
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER on_delete_bet
    INSTEAD of DELETE ON bets_view
    FOR each ROW
EXECUTE FUNCTION on_delete_bet();

DELETE FROM bets_view
WHERE kind_of_sport = 'TABLE TENNIS';

SELECT * FROM bets_view
WHERE kind_of_sport LIKE '%deleted%';

SELECT * FROM bets_view
WHERE kind_of_sport LIKE '%TABLE TENNIS%';