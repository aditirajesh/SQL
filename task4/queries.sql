--1. Creating tables w/ relation

--Creating table Customer:
CREATE TABLE Customer(CustomerID INT(3) PRIMARY KEY,
Name Varchar(20),
Email Varchar(20),
Phone Varchar(10),
City Varchar(30));

--Creating table Orders:
CREATE TABLE Orders(OrderID INT(4) PRIMARY KEY,
CustomerID INT(3) REFERENCES Customer(CustomerID),
Date DATE,
Product Varchar(20),
Amount INT(5));

--Inserting values into Customer:
INSERT INTO Customer VALUES
(101, 'Alice', 'alice@example.com', '9876543210', 'New York'),
(102, 'Bob', 'bob@example.com', '8765432109', 'Los Angeles'),
(103, 'Charlie', 'charlie@example.com', '7654321098', 'Chicago'),
(104, 'Diana', 'diana@example.com', '6543210987', 'Houston'),
(105, 'Ethan', 'ethan@example.com', '5432109876', 'Miami');


--Inserting values into Orders:
INSERT INTO Orders VALUES 
(2001, 101, '2023-11-10', 'Wireless Mouse', 45),
(2002, 102, '2023-11-11', 'Bluetooth Speaker', 70),
(2003, 103, '2023-11-12', 'Laptop Stand', 100),
(2004, 101, '2023-11-13', 'USB-C Hub', 60),
(2005, 104, '2023-11-14', 'Noise Cancelling Headphones', 120);

--2. INNER JOIN:

Select c.CustomerID, o.OrderID, o.Product, o.Date, o.Amount
from Customer as c
INNER JOIN Orders as o
ON c.CustomerID = o.CustomerID;

Select CustomerID OrderID, Product, Date, Amount 
from Customer 
NATURAL JOIN Orders;

--3. OTHER JOINS:

--Cross join:
select * from Customer, Orders;

Select Name, OrderID from Customer CROSS JOIN Orders;

--left outer join:
Select c.CustomerID, o.OrderID, o.Product, o.Amount
from CUSTOMER c
LEFT OUTER JOIN Orders o
ON c.CustomerID = o.CustomerID;

Select c.CustomerID, o.OrderID, o.Product, o.Amount
from ORDERS o 
LEFT OUTER JOIN Customer c 
ON o.CustomerID = c.CustomerID;

   
