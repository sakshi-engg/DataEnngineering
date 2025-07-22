create database company;
use company;

create table departments(
 department_id INT PRIMARY KEY,
 department_name VARCHAR(50) NOT NULL
);

CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(50) NOT NULL,
    start_date DATE,
    end_date DATE
);

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    department VARCHAR(50),
    salary INT CHECK (salary >= 0),
    join_date DATE NOT NULL,
    manager_id INT NULL,
    project_id INT NULL,

    CONSTRAINT FK_Manager FOREIGN KEY (manager_id) REFERENCES employees(emp_id),
    CONSTRAINT FK_Project FOREIGN KEY (project_id) REFERENCES projects(project_id)
);

INSERT INTO departments (department_id, department_name) VALUES
(1, 'Engineering'),
(2, 'Human Resources'),
(3, 'Marketing'),
(4, 'Sales'),
(5, 'Finance');

INSERT INTO projects (project_id, project_name, start_date, end_date) VALUES
(101, 'Apollo Revamp', '2024-01-15', '2024-07-15'),
(102, 'Neon AI Suite', '2024-03-01', '2024-12-01'),
(103, 'Brand Blitz', '2024-02-10', '2024-08-10'),
(104, 'Sales Dashboard', '2024-04-01', '2024-10-01'),
(105, 'Finance Forecast', '2024-05-01', '2024-11-01');

INSERT INTO employees (emp_id, first_name, last_name, department, salary, join_date, manager_id, project_id) VALUES
(1, 'Alice', 'Smith', 'Engineering', 95000, '2023-01-10', NULL, 101),
(2, 'Bob', 'Johnson', 'Engineering', 85000, '2023-02-20', 1, 101),
(3, 'Carol', 'Williams', 'Human Resources', 70000, '2023-03-15', NULL, NULL),
(4, 'David', 'Brown', 'Marketing', 80000, '2022-11-01', NULL, 103),
(5, 'Eva', 'Davis', 'Sales', 75000, '2023-04-12', 4, 104),
(6, 'Frank', 'Miller', 'Finance', 88000, '2023-06-10', NULL, 105),
(7, 'Grace', 'Wilson', 'Engineering', 90000, '2023-07-05', 1, 102),
(8, 'Henry', 'Moore', 'Marketing', 77000, '2023-05-01', 4, 103),
(9, 'Ivy', 'Taylor', 'Sales', 73000, '2023-08-01', 5, 104),
(10, 'Jake', 'Anderson', 'Finance', 89000, '2023-09-15', 6, 105);

select * from employees
select * from departments
select * from projects


--====String Functions===----

--1. Find employees whose last name starts with 'S'.
SELECT * 
FROM employees 
WHERE last_name LIKE 'S%';

--2. Display first_name and last_name concatenated as full_name in uppercase.
SELECT UPPER(first_name + ' ' + last_name) AS full_name 
FROM employees;

--3. Show employees with a 5-character first name.
SELECT * 
FROM employees 
WHERE LEN(first_name) = 5;


---=== Date Functions ===---

--4. List employees who joined in the last 2 years.
SELECT * 
FROM employees 
WHERE join_date >= DATEADD(YEAR, -2, GETDATE());

--5. Show number of days since each employee joined.
SELECT emp_id, first_name, last_name, DATEDIFF(DAY, join_date, GETDATE()) AS days_since_joined 
FROM employees;

--6. Find the month name and year from each employee's join_date.
SELECT emp_id, first_name, last_name, 
       DATENAME(MONTH, join_date) AS join_month, 
       YEAR(join_date) AS join_year 
FROM employees;

---=== Maths Functions ===---
INSERT INTO employees (emp_id, first_name, last_name, department, salary, join_date, manager_id, project_id) VALUES
(11, 'Mark', 'Twain', 'Engineering', 95459, '2025-01-10', NULL, 104);

--7. Round off each employee's salary to the nearest thousand.
SELECT emp_id, first_name, last_name, 
       salary, ROUND(salary, -3) AS rounded_salary 
FROM employees;

--8. Find employees whose salary is above the average salary.
SELECT * 
FROM employees 
WHERE salary > (SELECT AVG(salary) FROM employees);

--9. Show absolute difference from company average salary.
SELECT AVG(salary) as average_sal FROM employees;

SELECT  emp_id, first_name, last_name, salary,
       ABS(salary - (SELECT AVG(salary) FROM employees)) AS salary_diff_from_avg 
FROM employees;

---==== Aggregate Functions ===----

--10. Find departments with more than 3 employees.
SELECT department, COUNT(*) AS employee_count 
FROM employees 
GROUP BY department 
HAVING COUNT(*) > 3;

--11. Show total and average salary per department with avg salary > 60000.
select department, sum(salary) as total_sal, avg(salary) as avg_sal
from employees
group by department 
having  avg(salary)  > 60000;

---=== Subqueries ===---
--12. Find the employee(s) with the maximum salary.
select 
 max(salary) as max_salary
	from employees;

/* SELECT * 
FROM employees 
WHERE salary = (SELECT MAX(salary) FROM employees); */

--13.  List employees earning more than avg salary in their department
SELECT * 
FROM employees e
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
    WHERE department = e.department
);

--14. Show employees who joined before the earliest join date in IT.
SELECT * 
FROM employees 
WHERE join_date < (
    SELECT MIN(join_date)
    FROM employees
    WHERE department = 'Engineering'
);

---=== Joins ===---
--15. Show each employee's name and manager's name.

SELECT e.first_name + ' ' + e.last_name AS employee_name,
       m.first_name + ' ' + m.last_name AS manager_name
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.emp_id;

--16. List employees with their department name.
SELECT e.first_name, e.last_name, d.department_name
FROM employees e
JOIN departments d ON e.department = d.department_name;

--17. List employees not assigned any project.
SELECT * 
FROM employees 
WHERE project_id IS NULL;

---=== Window Functions ===---
--18. Assign a row number to employees in each department based on salary.
SELECT salary, emp_id, first_name, last_name, department,
       ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary DESC) AS row_num
FROM employees;

--19. Show running total salary within each department.
SELECT emp_id, first_name, department, salary,
       SUM(salary) OVER (PARTITION BY department ORDER BY emp_id) AS running_total
FROM employees;

--20. Show difference in salary between employee and previous by join date.
SELECT emp_id, first_name, join_date, salary,
       salary - LAG(salary) OVER (ORDER BY join_date) AS salary_diff
FROM employees;

---=== Common Table Expressions (CTEs) ===---
--21. Use CTE to calculate total salary per department, filter total > 200000.
WITH DeptSalary AS (
    SELECT department, SUM(salary) AS total_salary
    FROM employees
    GROUP BY department
)
SELECT * 
FROM DeptSalary
WHERE total_salary > 200000;

--22. Create a recursive CTE to generate numbers 1 to 10.
WITH Numbers AS (
    SELECT 1 AS num
    UNION ALL
    SELECT num + 1 FROM Numbers WHERE num < 10
)
SELECT * FROM Numbers;

---=== CASE Statements ===---
--24. Label employees as 'Junior', 'Mid', or 'Senior' based on salary.
SELECT first_name, last_name, salary,
       CASE 
           WHEN salary < 10000 THEN 'Junior'
           WHEN salary BETWEEN 20000 AND 90000 THEN 'Mid'
           ELSE 'Senior'
       END AS level
FROM employees;

--25. Count employees in salary categories using CASE.

SELECT 
    COUNT(CASE WHEN salary < 60000 THEN 1 END) AS junior_count,
    COUNT(CASE WHEN salary BETWEEN 60000 AND 90000 THEN 1 END) AS mid_count,
    COUNT(CASE WHEN salary > 90000 THEN 1 END) AS senior_count
FROM employees;

---=== Null Functions ===---
--26. Replace NULL department values with 'Unknown'.

SELECT emp_id, first_name, last_name,
       ISNULL(department, 'Unknown') AS department
FROM employees;

--27. Show employees with no department.
SELECT * 
FROM employees 
WHERE department IS NULL;

--28. Use COALESCE to provide default for missing projects.
SELECT emp_id, first_name, last_name,
       COALESCE(project_id, 0) AS project_id
FROM employees;
