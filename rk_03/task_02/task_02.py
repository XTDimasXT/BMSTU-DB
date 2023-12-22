from peewee import *

con = PostgresqlDatabase(database='postgres',
                         user='user',
                         password='3234',
                         host='localhost',
                         port=5432)

class BaseModel(Model):
    class Meta:
        database = con


class Worker(BaseModel):
    id = IntegerField(column_name='id')
    fio = CharField(column_name='fio')
    birthday = DateField(column_name='birthday')
    department = CharField(column_name='department')

    class Meta:
        table_name = 'worker'
        

class Record(BaseModel):
    id_worker = ForeignKeyField(Worker, on_delete="cascade")
    cur_day = DateField(column_name='cur_day')
    week_day = CharField(column_name='week_day')
    cur_time = TimeField(column_name='cur_time')
    cur_type = IntegerField(column_name='cur_type')

    class Meta:
        table_name = 'record'


def output(cur):
    rows = cur.fetchall()
    for elem in rows:
        print(*elem)
    print()


def print_query(query):
    u_b = query.dicts().execute()
    for elem in u_b:
        print(elem)


def task_2_1():
    global con
    cur = con.cursor()
    query = """
        SELECT id, fio, birthday
        FROM workers
        WHERE department = 'Бухгалтерия'
        ORDER BY birthday
        LIMIT 1;
    """
    cur.execute(query)
    print("Самый старший сотрудник в бухгалтерии:")
    output(cur)
    

def task_2_2():
    global con
    cur = con.cursor()
    query = """
        SELECT id_worker, fio, cur_day
        FROM workers
        JOIN in_out 
        ON workers.id = in_out.id_worker
        WHERE (
            (extract(hour from cur_time) < 13 AND cur_type = 2)
            AND
            (extract(hour from cur_time) >= 14 AND cur_type = 1)
        );
    """
    cur.execute(query)
    print("Сотрудники, которые отсутствовали на рабочем месте с 13 00 до 14 00:")
    output(cur)
    
    
def task_2_3():
    global con
    cur = con.cursor()
    query = """
        SELECT DISTINCT w.id, w.fio
        FROM workers w
        JOIN in_out i_o
        ON w.id = i_o.id_worker
        WHERE i_o.cur_time < '9:00' AND i_o.cur_type = 1 AND w.department = 'Бухгалтерия';
    """
    cur.execute(query)
    print("Сотрудники бухгалтерии, приходящие на работу раньше 9 00:")
    output(cur)


def main():
    task_2_1()
    task_2_2()
    task_2_3()
    
if __name__ == '__main__':
    main()