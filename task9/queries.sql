--MYSQL Syntax - since SQLite does not support Procedures
-- creating table orders
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    Product VARCHAR(50),
    Amount DECIMAL(10,2),
    Date DATE
);

-- inserting data into orders
INSERT INTO Orders (CustomerID, Product, Amount, Date) VALUES
(1, 'Keyboard', 500.00, '2024-03-01'),
(2, 'Mouse', 300.00, '2024-03-03'),
(1, 'Monitor', 7000.00, '2024-03-05'),
(3, 'Laptop', 45000.00, '2024-03-15'),
(4, 'Mousepad', 150.00, '2024-03-20');



-- creating the procedure
DELIMITER //

CREATE PROCEDURE GetTotalSales(
    IN StartDate DATE,
    IN EndDate DATE
)
BEGIN
    SELECT SUM(Amount) AS TotalSales
    FROM Orders
    WHERE Date BETWEEN StartDate AND EndDate;
END //

DELIMITER ;


--calling procedure 
CALL GetTotalSales('2024-03-01', '2024-03-10');


-- creating function to calculate bonus given amount 
CREATE FUNCTION CalculateBonus(amount INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE bonus INT;
    SET bonus = amount * 0.1;
    RETURN bonus;
END //

DELIMITER ;

--calling the function
SELECT CalculateBonus(5000);