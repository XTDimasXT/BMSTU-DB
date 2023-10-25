-- 1 задание
-- Выводит средний рейтинг всех отелей
SELECT AVG(rate) AS avg_rate FROM outlets;


-- 2 задание
-- Группирует строки по адресу, выводит в отдельном столбце средний рейтинг торговых точек по этому адресу
SELECT name_outlet, adress, date_registration, rate, avg(rate)
OVER (PARTITION BY adress) AS sum_rate
FROM outlets;


-- 3 задание
-- Удаляет из таблицы торговых точек те, где рейтинг меньше 5
DELETE FROM outlets
WHERE EXISTS (SELECT id FROM types_candies_outlets
              WHERE outlet_id = outlets.id AND outlets.rate < 5);