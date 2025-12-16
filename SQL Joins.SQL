-- ============================
-- 1. Setup: Create Tables
-- ============================
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    City VARCHAR(50)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    Amount INT
);

CREATE TABLE Payments (
    PaymentID VARCHAR(10) PRIMARY KEY,
    CustomerID INT,
    PaymentDate DATE,
    Amount INT
);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(50),
    ManagerID INT
);

-- ============================
-- 2. Insert Data
-- ============================
INSERT INTO Customers VALUES 
(1, 'John Smith', 'New York'),
(2, 'Mary Johnson', 'Chicago'),
(3, 'Peter Adams', 'Los Angeles'),
(4, 'Nancy Miller', 'Houston'),
(5, 'Robert White', 'Miami');

INSERT INTO Orders VALUES 
(101, 1, '2024-10-01', 250),
(102, 2, '2024-10-05', 300),
(103, 1, '2024-10-07', 150),
(104, 3, '2024-10-10', 450),
(105, 6, '2024-10-12', 400); 

INSERT INTO Payments VALUES
('P001', 1, '2024-10-02', 250),
('P002', 2, '2024-10-06', 300),
('P003', 3, '2024-10-11', 450),
('P004', 4, '2024-10-15', 200);

INSERT INTO Employees VALUES
(1, 'Alex Green', NULL),
(2, 'Brian Lee', 1),
(3, 'Carol Ray', 1),
(4, 'David Kim', 2),
(5, 'Eva Smith', 2);

-- ============================
-- 3. Solution Queries
-- ============================

-- Q1. Customers who placed at least one order
SELECT Customers.CustomerName, Orders.OrderID 
FROM Customers 
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID;

-- Q2. All customers, even those without orders
SELECT Customers.CustomerName, Orders.OrderID 
FROM Customers 
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID;

-- Q3. All orders, even those without matching customers 
SELECT Customers.CustomerName, Orders.OrderID 
FROM Customers 
RIGHT JOIN Orders ON Customers.CustomerID = Orders.CustomerID;

-- Q4. All customers and all orders
SELECT Customers.CustomerName, Orders.OrderID 
FROM Customers 
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
UNION
SELECT Customers.CustomerName, Orders.OrderID 
FROM Customers 
RIGHT JOIN Orders ON Customers.CustomerID = Orders.CustomerID;

-- Q5. Customers who have NOT placed any orders 
SELECT Customers.CustomerName 
FROM Customers 
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID 
WHERE Orders.OrderID IS NULL;

-- Q6. Customers who paid but did NOT order 
SELECT Customers.CustomerName 
FROM Customers 
INNER JOIN Payments ON Customers.CustomerID = Payments.CustomerID 
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID 
WHERE Orders.OrderID IS NULL;

-- Q7. All possible combinations
SELECT Customers.CustomerName, Orders.OrderID 
FROM Customers 
CROSS JOIN Orders;

-- Q8. Customers with Order Amount AND Payment Amount 
SELECT Customers.CustomerName, Orders.Amount AS OrderAmt, Payments.Amount AS PayAmt
FROM Customers 
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
LEFT JOIN Payments ON Customers.CustomerID = Payments.CustomerID;

-- Q9. Customers who both ordered AND paid (Double INNER JOIN)
SELECT Customers.CustomerName 
FROM Customers 
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID
INNER JOIN Payments ON Customers.CustomerID = Payments.CustomerID;