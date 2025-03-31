-- 1. Ranking Employees by Salary in Each Department
SELECT ID, Name, Department, Salary,
RANK() OVER(PARTITION BY Department ORDER BY Salary DESC) as Rank
from Employees;

-- Using ROW_NUMBER()
SELECT ID, Name, Department, Salary,
ROW_NUMBER() OVER(PARTITION BY Department ORDER BY Salary DESC)
from Employees;

-- Using DENSE_RANK()
SELECT ID, Name, Department, Salary,
DENSE_RANK() OVER(PARTITION BY Department ORDER BY Salary DESC)
from Employees;

-- 2. USING OVER AND PARTITION BY + ORDER BY
SELECT ID, Name, Department, Salary,
AVG(Salary) OVER(PARTITION BY Department) as AVG_Salary
from Employees ORDER BY AVG_Salary;

SELECT ID, Name, Department, Salary,
AVG(Salary) OVER(PARTITION BY Department ORDER BY Salary DESC) as AVG_Salary
from Employees;

--3. Using LAG to get the next highest salary for each person according to department 
Select ID, Name, Department, Salary, 
LAG(Salary) OVER(PARTITION BY Department ORDER BY Salary DESC) as Next_Salary
from Employees;

-- Using LEAD 
Select ID, Name, Department, Salary,
LEAD(Salary) OVER(PARTITION BY Department ORDER BY Salary DESC) as Previous_Salary
from Employees;

