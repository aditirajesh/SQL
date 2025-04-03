-- Creating table customers and inserting records

CREATE table Customers( 
    CustomerID INT(1) PRIMARY KEY,
    Name varchar(50),
    Email varchar(20),
    Phone varchar(15),
    City varchar(30)
    );

INSERT into Customers VALUES
    (1, 'Alice', 'alice@mail.com', '1234567890', 'New York'),
    (2, 'Bob', 'bob@mail.com', '2345678901', 'Chicago'),
    (3, 'Charlie', 'charlie@mail.com', '3456789012', 'Los Angeles'),
    (4, 'Diana', 'diana@mail.com', '4567890123', 'Seattle'),
    (5, 'Ethan', 'ethan@mail.com', '5678901234', 'Houston'),
    (6, 'Fiona', 'fiona@mail.com', '6789012345', 'Boston'),
    (7, 'George', 'george@mail.com', '7890123456', 'Phoenix');

-- implementing 2NF By making table cities with a city id
CREATE table CITIES(
    CityID INT(3) PRIMARY KEY,
    CityName varchar(30)
    );

INSERT into CITIES VALUES(
    (1, 'New York'),
    (2, 'Chicago'),
    (3, 'Los Angeles'),
    (4, 'Seattle'),
    (5, 'Houston'),
    (6, 'Boston'),
    (7, 'Phoenix');

-- updating customers table 
ALTER TABLE Customers
    ADD column CityID INT(3) REFERENCES CITIES(CityID);

UPDATE Customers SET CityID = 1 WHERE City = 'New York';
UPDATE Customers SET CityID = 2 WHERE City = 'Chicago';
UPDATE Customers SET CityID = 3 WHERE City = 'Los Angeles';
UPDATE Customers SET CityID = 4 WHERE City = 'Seattle';
UPDATE Customers SET CityID = 5 WHERE City = 'Houston';
UPDATE Customers SET CityID = 6 WHERE City = 'Boston';
UPDATE Customers SET CityID = 7 WHERE City = 'Phoenix';

-- dropping city from customers table
 ALTER TABLE Customers DROP City;


-- creating table products and inserting values
CREATE table Products(
    ProductID INT(3) PRIMARY KEY,
    Name varchar(30),
    Price int(5),
    Stock int(5)
    );

INSERT into Products VALUES
    (101, 'Keyboard', 500, 40),
    (102, 'Mouse', 300, 60),
    (103, 'Monitor', 8000, 20),
    (104, 'Webcam', 1200, 30),
    (105, 'Laptop Stand', 900, 25),
    (106, 'USB Hub', 650, 50),
    (107, 'Desk Lamp', 1100, 15);

-- creating table Orders, with primary key and foreign keys and inserting values
CREATE table Orders(
    OrderID INT(3) PRIMARY KEY,
    CustomerID INT(1) REFERENCES Customers(CustomerID), 
    OrderDate DATE
    );

INSERT into Orders VALUES
    (201, 1, '2024-03-01'),
    (202, 2, '2024-03-02'),
    (203, 3, '2024-03-03'),
    (204, 4, '2024-03-04'),
    (205, 5, '2024-03-05'),
    (206, 6, '2024-03-06'),
    (207, 7, '2024-03-07');

-- creating table orderdetails with referential foreign keys
CREATE table OrderDetails(
    OrderID INT(3) REFERENCES Orders(OrderID),
    ProductID INT(3) REFERENCES Products(ProductID),
    Quantity INT(5),
    TotalPrice INT(8)
    );

INSERT into OrderDetails VALUES
    (201, 101, 2, 1000),
    (201, 102, 1, 300),
    (202, 103, 1, 8000),
    (203, 104, 2, 2400),
    (204, 105, 1, 900),
    (205, 106, 3, 1950),
    (206, 107, 1, 1100);

-- adding multi attribute primary key to satisfy 2NF
ALTER TABLE OrderDetails
    ADD CONSTRAINT PK_Order PRIMARY KEY (OrderID, ProductID);

-- 2.Creating Indexes

-- creating an index to ensure no redundant emails 
CREATE UNIQUE INDEX customer_email
    ON Customers(Email);

-- checking if the index works:
INSERT into Customers VALUES
    (8,'Aditi','alice@mail.com',7634527893,2);

-- checking to see if index is being used whenever email is a constraint 
 EXPLAIN QUERY PLAN 
    Select Name, Email, Phone 
    from Customers 
    where email='alice@mail.com';


-- creating an index on a foreign key to make JOIN operations more faster
sqlite> CREATE UNIQUE INDEX orderdetails_pid_index ON OrderDetails(ProductID);


-- eg: finding the orderdetails - such as orderid, quantity for a product given the name
 EXPLAIN QUERY PLAN
    SELECT od.OrderID, p.ProductID, p.Name, od.Quantity
    from OrderDetails od
    JOIN Products p
    ON od.ProductID = p.ProductID
    WHERE p.Name = 'Keyboard';


-- creating query to update total price whenever the price of the item changes. 
CREATE TRIGGER update_od_price UPDATE OF Price on Products
BEGIN 
UPDATE OrderDetails SET TotalPrice = Quantity*new.Price WHERE ProductID = old.ProductID;
END;

-- updating products to see if the trigger worked:
UPDATE Products SET Price = 1000 WHERE ProductID=101;


-- creating a trigger to ensure total price = quantity x price
CREATE TRIGGER validate_total_price
    BEFORE INSERT ON OrderDetails
    BEGIN
    SELECT
    CASE
    WHEN new.TotalPrice != (SELECT Price from Products where ProductID = new.ProductID) * new.Quantity
    THEN RAISE(ABORT, 'TotalPrice does not match Quantity x Price')
    END;
    END;

-- checking with a false insert
INSERT INTO OrderDetails VALUES
    (201,103,1,5000);

-- 4. Transactions - commit
BEGIN TRANSACTION;
UPDATE Products SET Price = Price + 10;

-- checking the update:
SELECT * FROM Products;

--making the commit
COMMIT;


-- 4. Transaction -- rollback
BEGIN TRANSACTION;
UPDATE Products 
    SET Stock = Stock - 20;

-- making the rollback
ROLLBACK;

-- creating views to simplify joins
CREATE TEMP VIEW total_customer_details AS
SELECT 
    c.CustomerID, 
    c.Name, 
    c.Email, 
    c.Phone, 
    ci.CityName, 
    o.OrderID, 
    od.ProductID, 
    p.Name AS ProductName, 
    od.TotalPrice, 
    o.OrderDate
FROM Customers c 
JOIN Cities ci ON c.CityID = ci.CityID
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON od.OrderID = o.OrderID
JOIN Products p ON od.ProductID = p.ProductID;
