CREATE OR REPLACE FUNCTION count_lates(d DATE)
RETURNS TABLE
(
    mins numeric,
    persons bigint
)
AS $$
BEGIN
    RETURN QUERY
    SELECT mins_late, count(*)
    FROM (SELECT *, row_number() OVER (PARTITION BY i_o.id_worker, i_o.cur_day order by i_o.cur_time) as num,
            extract(minutes from i_o.cur_time - '9:00') as mins_late
          FROM workers w
          JOIN in_out i_o 
          ON w.id = i_o.id_worker
          WHERE i_o.cur_type = 1 AND i_o.cur_day = d) as tmp
    WHERE num = 1 AND mins_late > 0
    GROUP BY mins_late;
END;
$$ LANGUAGE PLPGSQL;

SELECT * FROM count_lates('2023-12-19');