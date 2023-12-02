-- 1. Запрос выбирает название региона и кол-во санаториев, находящихся в каждом регионе
SELECT DISTINCT name_reg, COUNT(*) 
OVER (PARTITION BY region_id) AS sanatorium_count
FROM Region
LEFT JOIN Sanatorium ON Region.id = Sanatorium.region_id;


-- 2. Запрос выбирает фио отдыхающих, которые посещали какие-либо санатории
SELECT fio
FROM Vacationer v
WHERE EXISTS (
    SELECT 1
    FROM Sanatorium_Vacationer sv
    WHERE sv.vacationer_id = v.id
);


-- 3. Запрос выбирает названия санаториев, которые были посещены хотя бы 2 раза
SELECT name_san
FROM Sanatorium
WHERE id IN (
    SELECT sanatorium_id
    FROM Sanatorium_Vacationer
    GROUP BY sanatorium_id
    HAVING COUNT(*) >= 2
);