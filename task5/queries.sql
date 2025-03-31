--1. Creating Subquery in the WHERE clause 
select * from employees where Salary > (Select AVG(Salary) from Employees);

Select Name, Department, Salary 
from Employees e 
where Salary > (select AVG(Salary) from Employees 
where Department = e.Department GROUP BY Department);

--2. Computing Dynamic Columns 

select Name, Department, Salary,
(SELECT AVG(Salary) from Employees) as AVG_Salary
from Employees
where Salary > AVG_salary;

--3. Non correlated subquery 

select * from Employees where 
department IN (SELECT Department from Employees
where age > 30);

