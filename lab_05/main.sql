-- 1. Извлечь данные в JSON

\copy (SELECT json_agg(row_to_json(b))::text FROM lab.Bets b) TO 'D:/BMSTU-DB/lab_05/json_data/bets.json';
\copy (SELECT json_agg(row_to_json(bm))::text FROM lab.Bookmakers bm) TO 'D:/BMSTU-DB/lab_05/json_data/bookmakers.json';
\copy (SELECT json_agg(row_to_json(t))::text FROM lab.Tickets t) TO 'D:/BMSTU-DB/lab_05/json_data/tickets.json';
\copy (SELECT json_agg(row_to_json(tr))::text FROM lab.Transactions tr) TO 'D:/BMSTU-DB/lab_05/json_data/transactions.json';
\copy (SELECT json_agg(row_to_json(u))::text FROM lab.Users u) TO 'D:/BMSTU-DB/lab_05/json_data/users.json';

-- 2. Выполнить загрузку и сохранение JSON файла в таблицу

CREATE TABLE IF NOT EXISTS tmp_data(
    data jsonb
);

CREATE TABLE IF NOT EXISTS lab.Bets_copy(
    id SERIAL PRIMARY KEY,
    kind_of_sport TEXT NOT NULL,
    summ INT NOT NULL,
    coefficient DECIMAL(5, 2),
    bet_status TEXT NOT NULL,
    bet_type TEXT NOT NULL
);

copy tmp_data(data) FROM 'D:/BMSTU-DB/lab_05/json_data/bets.json';
--SELECT * FROM tmp_data;

select jsonb_array_elements(data::jsonb) as json_data from tmp_data;

insert into lab.Bets_copy(kind_of_sport, summ, coefficient, bet_status, bet_type)
select dt.data->>'kind_of_sport', (dt.data->>'summ')::INT, (dt.data->>'coefficient')::DECIMAL(5, 2), dt.data->>'bet_status', dt.data->>'bet_type' from (select jsonb_array_elements(data::jsonb) as data from tmp_data)
as dt;

SELECT *
FROM lab.Bets_copy;

select * from lab.Bets except (select * from lab.Bets_copy);


-- 3. Создать таблицу, в которой будет атрибут с типом JSON, или добавить к уже существующей таблице

create table if not exists lab.json_table(
    id serial primary key,
    name text not null,
    data json not null
);

insert into lab.json_table(name, data) values
    ('Dmitriy', '{"kind_of_sport": "Basketball", "profit": 15000}'::json),
    ('Alex', '{"kind_of_sport": "Tennis", "profit": 5000}'::json),
    ('Mellstroy', '{"kind_of_sport": "Football", "profit": 1200000}'::json);

select * from lab.json_table;

-- 4. Выполнить набор действий

--- 4.1. Извлечь JSON фрагмент из JSON документа

create table if not exists lab.bet_description(
    kind_of_sport text,
    profit int
);

select * from lab.json_table, json_populate_record(null::lab.bet_description, data);

select
    data->'kind_of_sport' as kind_of_sport,
    data->'profit' as profit
from lab.json_table;

--- 4.2. Извлечь значения конкретных узлов или атрибутов JSON документа

create table if not exists lab.Bookmakers_tmp(
    data jsonb
);

insert into lab.Bookmakers_tmp (data) values
        ('{
        "bookmaker_name": "FONBET",
        "profit": 15000000,
        "city": "Moscow",
        "users":  {
                  "live_users": 3000000,
                  "banned_users": 250000
                  }
        }'),
        ('{
        "bookmaker_name": "PARI",
        "profit": 11000000,
        "city": "Moscow",
        "users":  {
                  "live_users": 2250000,
                  "banned_users": 108000
                  }
        }'),
        ('{
        "bookmaker_name": "WINLINE",
        "profit": 18500000,
        "city": "Saint-Petersburg",
        "users":  {
                  "live_users": 4500000,
                  "banned_users": 485000
                  }
        }');

select
    data->'users'->'live_users' as live_users,
    data->'profit' as profit
from lab.Bookmakers_tmp;

--4.3. Выполнить проверку существования узла или атрибута

select exists(
    select *
    from lab.Bookmakers_tmp
    where data::jsonb ? 'os_labs');

--4.4. Изменить JSON документ
update lab.Bookmakers_tmp
    set data = data || '{"city": "MSC"}'::jsonb
where (data->>'city')::text = 'Moscow';

select * from lab.Bookmakers_tmp;

--4.5. Разделить JSON документ на несколько строк по узлам

create table if not exists lab.Bets_tmp(
    data jsonb
);

insert into lab.Bets_tmp values
    ('[{"name": "Gazik", "age": 20, "bet_status": "WON"},
       {"name": "Mellstroy", "age": 25, "bet_status": "WON"},
       {"name": "Popov", "age": 48, "bet_status": "LOST"}]'::jsonb);

SELECT jsonb_array_elements(data::jsonb)
FROM lab.Bets_tmp;


-- Пример добавления

-- cat bets.json | jq '.[] |= . + { "ban_status": "true" }'

-- .[] - применить ко всем элементам
-- |= - оператор обновления
-- . + { "age": 30 }