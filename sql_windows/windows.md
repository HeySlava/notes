# [Оконные функции SQL](https://stepik.org/course/95367?auth=login)


## Ранжирование

dense_rank() - при ранге не делает пропусков в нумерации.
| dense_rank | something | 
|:-----|:-|
| 1     | 10 | 
| 2     | 15 | 
| 2     | 15 | 
| 3         | 20 | 

rank() - при ранге делает пропуски в нумерации.

| rank | something | 
|:-----|:-|
| 1     | 10 | 
| 2     | 15 | 
| 2     | 15 | 
| 4         | 20 | 

| dense_rank | rank     | something | 
|:-----------|:-----|:-|
| 1           | 1 | 10 | 
| 2           | 2 | 15 | 
| 2           | 2 | 15 | 
| 3           | 4 | 20 | 

![rank vs dense_rank](https://kapitonov.tech/img/8f9e67417b618fd.png)


ntile(n) - разбивает на n групп, первые группы будут больше при неравном количестве

```bash
-- Есть таблица сотрудников employees.
-- В компании работают сотрудники из Москвы и Самары.
-- Мы хотим разбить их на две группы по зарплате в каждом из городов
select
  ntile(3) over w as tile,
  name, department, salary
from employees
window w as (order by salary desc)
order by salary desc, id;
```

| Функция      | Описание                                                                           |
| :--------    | :-                                                                                 |
| row_number() | порядковый номер строки                                                            |
| dense_rank() | ранг строки                                                                        |
| rank()       | тоже ранг, но с пропусками                                                         |
| ntile(n)     | разбивает все строки на n групп и возвращает номер группы, в которую попала строка |


## Смещение

| Функция             | Описание                                                              |
| :--------           | :-                                                                    |
| lag(value, offset)  | значение value из строки, отстоящей на offset строк назад от текущей  |
| lead(value, offset) | значение value из строки, отстоящей на offset строк вперед от текущей |
| first_value(value)  | значение value из первой строки фрейма                                |
| last_value(value)   | значение value из последней строки фрейма                             |
| nth_value(value, n) | значение value из n-й строки фрейма                                   |

## Окно, секция, фрейм

```bash
rows between X preceding and Y following
```
Где `X` — количество строк перед текущей, а `Y` — количество строк после текущей:
Если указать вместо X или Y значение `unbounded` — это значит «граница секции»:
Если указать вместо `X preceding` или `Y following` значение `current row` — это значит «текущая запись»:
Фрейм никогда не выходит за границы секции, если столкнулся с ней — обрезается:

Размер секции фиксирован  
Размер фрейма зависит от текущей записи. Конец фрейма = последняя запись со значением равным текущему.
Секция фиксирована, фрейм же зависит от текущей записи и постоянно меняется:

![alter text](https://kapitonov.tech/img/395abf759d06ef9.png)


Результат last_value() для записи Леонид.

![alter text](https://kapitonov.tech/img/a23df2740bfc2da.png)


```bash
-- Есть таблица сотрудников employees. Мы хотим для каждого сотрудника увидеть, сколько процентов составляет его зарплата от максимальной в городе:
-- Сортировка результата: city, salary

select
  name, city, salary,
  round(
  salary * 100.0 / (last_value(salary) over w)
  ) as percent
from employees
window w as (
  partition by city
  order by salary
  rows between unbounded preceding and unbounded following
)
order by city, salary, id;
```


Подытожим принцип, по которому работают `first_value()` и `last_value()`:

- Есть окно, которое состоит из одной или нескольких секций (partition by department).
- Внутри секции записи упорядочены по конкретному столбцу (order by salary).
- У каждой записи в секции свой фрейм. По умолчанию начало фрейма совпадает с началом секции, а конец для каждой записи свой.
- Конец фрейма можно приклеить к концу секции, чтобы фрейм в точности совпадал с секцией.
- Функция first_value() возвращает значение из первой строки фрейма.
- Функция last_value() возвращает значение из последней строки фрейма.


## Агрегация

| Функция                       | Описание                                                             |
| :--------                     | :-                                                                   |
| min(value)                    | минимальное value среди строк, входящих в окно                       |
| max(value)                    | максимальное value                                                   |
| count(value)                  | количество value , не равных null                                    |
| avg(value)                    | среднее значение по всем value                                       |
| sum(value)                    | сумма значений value                                                 |
| group_concat(value, separator)| строка, которая соединяет значения value через разделитель separator поддерживается в SQLite и MySQL |
| string_agg(value, separator)  | аналог group_concat() в PostgreSQL и MS SQL                          |


Base syntax

```sql
select
  some_func() over w as rank
from employees
window w as (
  partition by department
  order by salary desc
)
```


```sql
-- Есть таблица сотрудников employees. Мы хотим для каждого сотрудника увидеть:
-- сколько человек трудится в его отделе (emp_cnt);
-- какая средняя зарплата по отделу (sal_avg);
-- на сколько процентов отклоняется его зарплата от средней по отделу (diff).
-- department, salary, id

select
  name, department, salary,
  count(*) over w emp_cnt,
  round(avg(salary) over w) sal_avg,
  round(
    100.0 * (salary - avg(salary) over w) / avg(salary) over w
  ) as diff
from employees
window w as (
  partition by department
)
order by department, salary, id;
```


```sql
-- Есть таблица доходов-расходов expenses. Мы хотим рассчитать скользящее среднее по доходам за предыдущий и текущий месяц:
-- year │ month │ income │ roll_avg
-- Сортировка результата: year, month

select year, month, income,
  avg(income) over w as roll_avg
from expenses
window w as (
  order by year, month
  rows between 1 preceding and current row
)
order by year, month;
```


```sql
-- Посчитаем доходы и расходы по месяцам нарастающим итогом (кумулятивно)
select
  year, month, income, expense,
  sum(income) over w as t_income,
  sum(expense) over w as t_expense,
  (sum(income) over w) - (sum(expense) over w) as t_profit
from expenses
window w as (
  order by year, month
  rows between unbounded preceding and current row
)
order by year, month;
```


```sql
-- Мы хотим посчитать фонд оплаты труда нарастающим итогом независимо для каждого департамента:
--  │   name   │ department │ salary │ total │
-- Сортировка результата: department, salary, id

select id, name, department, salary
  , sum(salary) over w as total
from employees
window w as (
  partition by department
  order by salary
  rows between unbounded preceding and current row
)
order by department, salary, id;
```


### Фрейм по умолчанию

![alter text](https://kapitonov.tech/img/68b6d4cbdf0430e.png)



### cume_dist()


```sql
select
  name, salary,
  cume_dist() over w as perc
from employees
window w as (order by salary)
order by salary, id;
```

Вот что делает `cume_dist()` :

- Располагает записи в порядке, указанном в order by окна (в нашем случае — по возрастанию зарплаты).
- Находит текущую запись в общем ряду (зарплату текущего сотрудника среди всех зарплат).
- Считает, сколько записей ≤ текущей по значению столбца из order by (сколько людей получают такую же или меньшую зарплату).
- Делит на общее количество записей (на количество сотрудников).

```bash
cume_dist = количество записей ≤ текущей / общее количество записей
```

В результате `cume_dist` возвращает процент записей со значением ≤ текущего (процент людей, которые получают такую же или меньшую зарплату).


### Фреймы


В общем виде определение фрейма выглядит так:

```bash
ROWS BETWEEN frame_start AND frame_end
```


Начало фрейма (frame_start) может быть:
- `current row` — начиная с текущей строки;
- `N preceding `— начиная с N-й строки перед текущей;
- `N following` — начиная с N-й строки после текущей;
- `unbounded preceding` — начиная с границы секции.

Аналогично, конец фрейма (frame_end) может быть:
- `current row` — начиная с текущей строки;
- `N preceding `— начиная с N-й строки перед текущей;
- `N following` — начиная с N-й строки после текущей;
- `unbounded preceding` — начиная с границы секции.



#### GROUPS-фреймы
```bash
ROWS BETWEEN frame_start AND frame_end
```

На самом деле, кроме фрейма по строкам (ROWS) бывают еще фреймы по группам (GROUPS) и диапазону (RANGE):
```bash
ROWS BETWEEN frame_start AND frame_end
GROUPS BETWEEN frame_start AND frame_end
RANGE BETWEEN frame_start AND frame_end
```
Разница в том, что rows-фрейм оперирует индивидуальными записями, а groups-фрейм — группами записей, у которых одинаковое значение столбца order by (в данном случае — одинаковый департамент):


#### RANGE-фреймы

![alter text](https://kapitonov.tech/img/61f607423184a2b.png)



1. **Только один столбец в order by**

Поскольку range-фрейм динамически рассчитывается по вхождению в диапазон `between .. and ..`, то в order by должен быть ровно один столбец.
2. **Только числа или даты для N preceding / following**
Условия `N preceding` и `N following` работают только для числовых столбцов и столбцов с датами.

3. **current row — как у groups-фрейма**

Условие `current row` для range-фрейма работает так же, как для groups-фрейма — включает строки с одинаковым значением столбца из order by. Условия `unbounded preceding` и `unbounded following` для всех типов фреймов работают одинаково — включает строки от начала секции (unbounded preceding) и до конца секции (unbounded following).


![alter text](https://kapitonov.tech/img/3b1b87880cc355b.png)
![alter text](https://kapitonov.tech/img/f259ace6d5c2f32.png)
![alter text](https://kapitonov.tech/img/26f1e7bf004034f.png)



