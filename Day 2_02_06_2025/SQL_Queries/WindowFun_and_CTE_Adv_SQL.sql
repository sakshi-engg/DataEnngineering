USE AdvanceTraining
CREATE TABLE company_data (
id INT PRIMARY KEY,
employee VARCHAR (50),
region VARCHAR(50),
amount INT
);
CREATE TABLE sales (
id INT PRIMARY KEY,
employee VARCHAR (50),
region VARCHAR(50),
amount INT
);
insert into sales (id, employee, region, amount) values
(1, 'Alice', 'North',1000),
(2, 'John', 'South',1000),
(3, 'Mark', 'East',1000),
(4, 'Twain', 'North',1000);

--Window Function Concepts - it is used to perform a calculation across a set of table rows, that are somehow related to current row, unlike group by its doesn't collapse all the results in one row
--Total Sales by employees using Group By
select
  employee,
  sum(amount) as total_sales
  from sales 
  group by employee;

----It prints all rows along expected output. Total Sales by employees using Window function partition by
select 
  id,
  employee,
  region,
  amount,
  sum(amount) over (partition by employee ) as
  total_sales_per_employee
from sales;

--Rank() function 
select
id,
  employee,
  region,
  amount,
  RANK() over (partition by employee order by amount desc) as
  rank_in_Sales
  from sales;

-- recursive cte
with recursive number as  (
select 1 as num
union all
select num + 1
from numbers 
where num < 10 
 )
 select * from numbers;
