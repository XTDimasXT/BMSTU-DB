-- 1. Найти самого старшего сотрудника бухгалтерии
SELECT id, fio, birthday
FROM workers
WHERE department = 'Бухгалтерия'
ORDER BY birthday
LIMIT 1;


-- 2. Найти сотрудников, которые отсутствовали на рабочем месте с 13:00 до 14:00
SELECT id_worker, fio, cur_day
FROM workers
JOIN in_out 
ON workers.id = in_out.id_worker
WHERE (
    (extract(hour from cur_time) < 13 AND cur_type = 2)
    AND
    (extract(hour from cur_time) >= 14 AND cur_type = 1)
);


-- 3. Найти сотрудников бухгалтерии, приходящих на работу раньше 9:00
SELECT DISTINCT w.id, w.fio
FROM workers w
JOIN in_out i_o
ON w.id = i_o.id_worker
WHERE i_o.cur_time < '9:00' AND i_o.cur_type = 1 AND w.department = 'Бухгалтерия'
ORDER BY i_o.cur_day;