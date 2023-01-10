select
  city,
  department,
  salary,
  sum(sum(salary)) over (partition by city) as x,
  sum(sum(salary)) over () as y
from
  employees
group by city, department
order by city, department;
