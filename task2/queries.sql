--1. Using WHERE clause to select data based on a certain condition:

Select * from Employees where Salary > 50000;

--2. Using ORDER BY to sort the result:

Select * from Employees where Salary > 50000 ORDER BY Department;

--3. Using AND/OR clauses:

--AND:
Select * from Employees where Salary > 50000 AND age < 30;

--OR: 
Select * from Employees where Salary > 50000 OR age < 30;

