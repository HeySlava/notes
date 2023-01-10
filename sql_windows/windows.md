## Ранжирование

dense_rank() - при ранге не делает пропусков в нумерации.
| rank | something | 
|:-----|:-|
| 1     | 10 | 
| 2     | 15 | 
| 2     | 15 | 
| 3         | 20 | 

dense_rank() - при ранге делает пропуски в нумерации.

| rank | something | 
|:-----|:-|
| 1     | 10 | 
| 2     | 15 | 
| 2     | 15 | 
| 4         | 20 | 


ntile(n) - разбивает на n групп, первые группы будут больше при неравном количестве

```bash
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

Размер секции фиксирован  
Размер фрейма зависит от текущей записи. Конец фрейма = последняя запись со значением равным текущему.

Результат last_value() для записи Леонид.

![alter text](https://kapitonov.tech/img/a23df2740bfc2da.png)

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
