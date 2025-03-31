# TASK 2: Basic Filtering and Sorting

## a) Use the WHERE clause to filter records based on a condition (e.g., WHERE Department = 'Sales').

### Query:

```
Select * from Employees where Salary > 50000;
```

![](task2_ex1.png)

## b) Apply the ORDER BY clause to sort the results (e.g., by LastName or Salary).

### Query:

```
Select * from Employees where Salary > 50000 ORDER BY Department;
```

![](task2_ex2.png)

## c) Experiment with multiple conditions using AND/OR.

### Query:

#### AND:

```
Select * from Employees where Salary > 50000 AND age < 30;
```

![](task2_ex3_AND.png)

#### OR:

```
Select * from Employees where Salary > 50000 OR age < 30;
```

![](task2_ex3_OR.png)
