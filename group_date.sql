/*
Write an SQL query to generate a report of period_state for each continuous interval of days in the period from 2019-01-01 to 2019-12-31.
*/

with Succee_date_cte as (
select *,
row_number() over(order by Succee_date asc) as rn ,
DATEADD(day,-1*row_number() over(order by Succee_date asc) , Succee_date)  as group_date
from Succeeded 
where Succee_date between '2019-01-01' and '2019-12-31'),
Fail_date_cte as (
select *,
row_number() over(order by fail_date asc) as rn ,
DATEADD(day,-1*row_number() over(order by fail_date asc) , fail_date)  as group_date
from Failed 
where fail_date between '2019-01-01' and '2019-12-31')

select min(Succee_date) start_date , max(Succee_date) end_date , 'succeeded' from Succee_date_cte
group by group_date
union all
select min(fail_date) start_date , max(fail_date) end_date , 'Failed' from Fail_date_cte
group by group_date

