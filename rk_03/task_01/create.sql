create table if not exists workers(
	id SERIAL PRIMARY KEY,
	fio TEXT,
	birthday DATE,
	department TEXT
);

create table if not exists in_out(
	id_worker INTEGER REFERENCES workers,
	cur_day DATE,
	week_day TEXT,
	cur_time TIME,
	cur_type INTEGER
);

insert into workers(fio, birthday, department) values('Иванов Иван Иванович', '25-09-1990', 'ИТ');
insert into workers(fio, birthday, department) values('Петров Петр Петрович', '12-11-1987', 'Бухгалтерия');


insert into in_out(id_worker, cur_day, week_day, cur_time, cur_type) values(1, '19-12-2023', 'Вторник', '9:00', 1);
insert into in_out(id_worker, cur_day, week_day, cur_time, cur_type) values(1, '19-12-2023', 'Вторник', '9:20', 2);
insert into in_out(id_worker, cur_day, week_day, cur_time, cur_type) values(1, '19-12-2023', 'Вторник', '9:25', 1);
insert into in_out(id_worker, cur_day, week_day, cur_time, cur_type) values(2, '19-12-2023', 'Вторник', '9:05', 1);
insert into in_out(id_worker, cur_day, week_day, cur_time, cur_type) values(2, '19-12-2023', 'Вторник', '12:50', 2);
insert into in_out(id_worker, cur_day, week_day, cur_time, cur_type) values(2, '19-12-2023', 'Вторник', '14:30', 1);

SELECT * FROM workers;

SELECT * FROM in_out;