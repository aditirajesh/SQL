--1. Using aggregate functions 

--a. Count:
Select COUNT(*) from Employees;

--b. Sum:
Select SUM(Salary) from Employees where age < 30;

--Cross verification for if the sum is right:
select Name, Salary, 
(Select SUM(Salary) from Employees where age <30) as Total_Salary from Employees where age < 30;


--Adding additional rows:

INSERT into Employees VALUES
(106, 'Fiona', 'IT', 62000, 29),
(107, 'George', 'IT', 47000, 31),
108, 'Hannah', 'Marketing', 51000, 27),
(109, 'Ivan', 'IT', 54000, 34),
(110, 'Julia', 'Finance', 69000, 33);


--2. Using GROUP BY clause

Select Department, Count(*) from Employees GROUP BY Department;

--3. Using the HAVING clause:

Select Department, Count(*) from Employees
GROUP BY Department
HAVING Count(*) > 1;