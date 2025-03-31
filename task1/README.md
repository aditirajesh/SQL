# TASK 1: Creating and Populating Tables

## a) Use CREATE TABLE to define a table (e.g., Employees or Products) with appropriate data types and constraints.

### Query:

```
Create table Employees(ID int(3) PRIMARY KEY,
  Name varchar(20),
  Department varchar(10),
  Salary int(7),
  age int(2));

```

![](task1_ex1.png)

## b) Populate the table using INSERT INTO with multiple rows of sample data.

```
INSERT INTO Employees VALUES
  (101, 'Alice', 'Sales', 45000, 28),
  (102, 'Bob', 'HR', 52000, 32),
  (103, 'Charlie', 'IT', 65000, 26),
  (104, 'Diana', 'Finance', 70000, 35),
  (105, 'Ethan', 'Marketing', 48000, 30);
```

## c) Execute a basic SELECT \* FROM TableName; query to verify the data insertion.

![](task1_ex1.png)
