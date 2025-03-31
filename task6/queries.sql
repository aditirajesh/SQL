--1. Finding difference in dates - using julianday:
Select OrderID,Product,Amount,
julianday('now') - julianday(Date) as DateDiff
from Orders;

-- Date Add - adjusting dates via an interval

select OrderId, CustomerId, DATE(Date, '+1 year') as ModifiedDate,
Product, Amount from Orders;


--Updated Orders: +1 year interval added 
UPDATE Orders 
SET Date = DATE(Date, '+1 year');

--Inserting extra data:
INSERT INTO Orders VALUES
(106, 103, '2025-03-25', 'Bluetooth Speaker', 2999),
(107, 101, '2025-03-10', 'Gaming Mouse', 1899),
(108, 104, '2025-03-02', 'Noise Cancelling Headphones', 4999);


--2. Placing an interval to filter records 
select * from Orders where julianday('now') - julianday(Date) < 30;

--3. Using strftime (To_char):
select OrderID, strftime("%Y",Date) as OrderYear,
Product, Amount
from Orders;