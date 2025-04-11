CREATE DATABASE TechShop;

USE TechShop;

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY ,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    Address VARCHAR(200)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY ,
    ProductName VARCHAR(100),
    Description VARCHAR(100),
    Price DECIMAL(10,2)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY ,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

CREATE TABLE Inventory (
    InventoryID INT PRIMARY KEY,
    ProductID INT,
    QuantityInStock INT,
    LastStockUpdate DATE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Customers (CustomerID, FirstName, LastName, Email, Phone, Address)VALUES 
(1, 'John', 'Doe', 'john@example.com', '1234567890', '123 Main St'),
(2, 'Jane', 'Smith', 'jane@example.com', '2345678901', '456 Oak Ave'),
(3, 'Alice', 'Johnson', 'alice@example.com', '3456789012', '789 Pine Rd'),
(4, 'Bob', 'Lee', 'bob@example.com', '4567890123', '101 Elm St'),
(5, 'Charlie', 'Kim', 'charlie@example.com', '5678901234', '202 Maple Dr'),
(6, 'Eva', 'White', 'eva@example.com', '6789012345', '303 Birch Blvd'),
(7, 'Frank', 'Brown', 'frank@example.com', '7890123456', '404 Cedar Ln'),
(8, 'Grace', 'Davis', 'grace@example.com', '8901234567', '505 Walnut Way'),
(9, 'Henry', 'Moore', 'henry@example.com', '9012345678', '606 Chestnut Ct'),
(10, 'Ivy', 'Green', 'ivy@example.com', '0123456789', '707 Ash Cir');

INSERT INTO Products (ProductName, Description, Price)VALUES 
('Smartphone A', 'High-performance smartphone', 699.99),
('Laptop B', '15-inch display laptop', 999.50),
('Tablet C', '10-inch tablet with stylus', 399.00),
('Smartwatch D', 'Fitness smartwatch', 199.99),
('Headphones E', 'Noise-cancelling headphones', 149.75),
('Camera F', 'DSLR camera with 18-55mm lens', 799.00),
('Monitor G', '27-inch 4K monitor', 299.99),
('Keyboard H', 'Mechanical gaming keyboard', 89.90),
('Mouse I', 'Wireless mouse', 49.99),
('Speaker J', 'Bluetooth portable speaker', 59.95);

INSERT INTO Orders (CustomerID, OrderDate, TotalAmount)VALUES 
(1, '2025-04-01', 749.98),
(2, '2025-04-02', 149.75),
(3, '2025-04-03', 199.99),
(4, '2025-04-04', 999.50),
(5, '2025-04-05', 399.00),
(6, '2025-04-06', 299.99),
(7, '2025-04-07', 699.99),
(8, '2025-04-08', 849.00),
(9, '2025-04-09', 139.89),
(10, '2025-04-10', 109.94);


INSERT INTO OrderDetails (OrderID, ProductID, Quantity)VALUES 
(1, 1, 1),
(1, 10, 1),
(2, 5, 1),
(3, 4, 1),
(4, 2, 1),
(5, 3, 1),
(6, 7, 1),
(7, 1, 1),
(8, 6, 1),
(9, 9, 1);

INSERT INTO Inventory (ProductID, QuantityInStock, LastStockUpdate)
VALUES 
(1, 50, '2025-04-01'),
(2, 20, '2025-04-01'),
(3, 30, '2025-04-01'),
(4, 25, '2025-04-01'),
(5, 40, '2025-04-01'),
(6, 15, '2025-04-01'),
(7, 10, '2025-04-01'),
(8, 35, '2025-04-01'),
(9, 45, '2025-04-01'),
(10, 60, '2025-04-01');


-- TASK 2 --
-- 1.  Retrieve names and emails of all customers --
SELECT FirstName, LastName, Email
FROM Customers;

-- 2. List all orders with order dates and customer names --
SELECT Orders.OrderID, Orders.OrderDate, Customers.FirstName, Customers.LastName
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID;

-- 3. Insert a new customer record --
INSERT INTO Customers (CustomerID, FirstName, LastName, Email, Phone, Address)
VALUES (13, 'Ryan', 'Thomas', 'ryan@example.com', '9876543210', '808 River Rd');

-- 4. Increase prices by 10% for all products -- 
ALTER TABLE Products
MODIFY COLUMN Price DECIMAL(10,2);
UPDATE Products
SET Price = ROUND(Price * 1.10, 2);


-- 5. Delete an order and its order details --
DELETE FROM OrderDetails
WHERE OrderID = 1001;
DELETE FROM Orders
WHERE OrderID = 1001;

-- 6. Insert a new order --
INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount)
VALUES (2002, 2, '2025-04-09', 0.00);

-- 7. Update contact info for a customer --
UPDATE Customers
SET Email = 'newemail@example.com',
Address = '123 New Street'
WHERE CustomerID = 3;

-- 8. Recalculate and update total amount in Orders -- 
UPDATE Orders
SET TotalAmount = (
SELECT SUM(OrderDetails.Quantity * Products.Price)
FROM OrderDetails, Products
WHERE OrderDetails.ProductID = Products.ProductID
AND OrderDetails.OrderID = Orders.OrderID
);

-- 9. Delete all orders and details for a customer --
DELETE FROM OrderDetails
WHERE OrderID IN (
SELECT OrderID FROM Orders WHERE CustomerID = 4
);
DELETE FROM Orders
WHERE CustomerID = 4;

-- 10. Insert a new product (gadget) --
INSERT INTO Products (ProductID, ProductName, Description, Price)
VALUES (501, 'Smart Watch', 'Fitness tracking watch with GPS', 149.99);

-- 11. Update order status --
ALTER TABLE Orders
ADD Status VARCHAR(20) DEFAULT 'Pending'; --
UPDATE Orders
SET Status = 'Shipped'
WHERE OrderID = 2002;


-- 12. Update number of orders placed by each customer -- 
SET SQL_SAFE_UPDATES = 0; 
UPDATE Customers
SET OrderCount = (SELECT COUNT(*)
FROM Orders
WHERE Orders.CustomerID = Customers.CustomerID
);




-- TASK 3 --
-- 1. List all orders with customer names --
SELECT Orders.OrderID, Orders.OrderDate, Customers.FirstName, Customers.LastName
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID;

-- 2. Total revenue generated by each product --
SELECT Products.ProductName, SUM(OrderDetails.Quantity * Products.Price) AS TotalRevenue
FROM OrderDetails
JOIN Products ON OrderDetails.ProductID = Products.ProductID
GROUP BY Products.ProductName;

-- 3. Customers who made at least one purchase --
SELECT DISTINCT Customers.FirstName, Customers.LastName, Customers.Email, Customers.Phone
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID;

-- 4. Most popular product (highest quantity sold) --
SELECT Products.ProductName, SUM(OrderDetails.Quantity) AS TotalQuantity
FROM OrderDetails
JOIN Products ON OrderDetails.ProductID = Products.ProductID
GROUP BY Products.ProductName
ORDER BY TotalQuantity DESC
LIMIT 1;

-- 5. List products with their categories --
ALTER TABLE Products
ADD Category VARCHAR(100);
SELECT ProductName, Category
FROM Products;

-- 6. Average order value per customer --
SELECT Customers.FirstName, Customers.LastName, AVG(Orders.TotalAmount) AS AverageOrderValue
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerID;

-- 7. Order with highest total revenue --
SELECT Orders.OrderID, Customers.FirstName, Customers.LastName, Orders.TotalAmount
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
ORDER BY Orders.TotalAmount DESC
LIMIT 1;

-- 8. Products and how many times each one was ordered --
SELECT Products.ProductName, COUNT(OrderDetails.OrderDetailID) AS TimesOrdered
FROM OrderDetails
JOIN Products ON OrderDetails.ProductID = Products.ProductID
GROUP BY Products.ProductName;

-- 9. Customers who bought a specific product --
SELECT DISTINCT Customers.FirstName, Customers.LastName, Customers.Email
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
JOIN Products ON OrderDetails.ProductID = Products.ProductID
WHERE Products.ProductName = 'Smart Watch';

-- 10. Total revenue between two dates --
SELECT SUM(TotalAmount) AS TotalRevenue
FROM Orders
WHERE OrderDate BETWEEN '2025-01-01' AND '2025-04-09';



-- TASK 4 --
-- 1. Customers who have not placed any orders --
SELECT FirstName, LastName
FROM Customers
WHERE CustomerID NOT IN (
    SELECT CustomerID FROM Orders
);

-- 2. Total number of products available for sale --
SELECT COUNT(*) AS TotalProducts
FROM Products;

-- 3. Total revenue generated by TechShop --
SELECT SUM(Quantity * Price) AS TotalRevenue
FROM (
SELECT OD.Quantity, P.Price
FROM OrderDetails OD
JOIN Products P ON OD.ProductID = P.ProductID
) AS OrderPrices;


-- 4. Average quantity ordered for products in a specific category --
SELECT AVG(Quantity) AS AvgQuantity
FROM (
SELECT OD.Quantity
FROM OrderDetails OD
JOIN Products P ON OD.ProductID = P.ProductID
WHERE P.Category = 'Mobile'
) AS CategoryOrders;


-- 5. Total revenue generated by a specific customer --
SELECT SUM(Quantity * Price) AS CustomerRevenue
FROM (
SELECT OD.Quantity, P.Price
FROM Orders O
JOIN OrderDetails OD ON O.OrderID = OD.OrderID
JOIN Products P ON OD.ProductID = P.ProductID
WHERE O.CustomerID = 1001
) AS CustomerOrders;


-- 6. Customers who placed the most orders --
SELECT CustomerID, OrderCount
FROM (
SELECT CustomerID, COUNT(*) AS OrderCount
FROM Orders
GROUP BY CustomerID
) AS CustomerOrders
ORDER BY OrderCount DESC
LIMIT 1;


-- 7. Most popular product category (highest quantity ordered) --
SELECT Category, TotalOrdered
FROM (
SELECT P.Category, SUM(OD.Quantity) AS TotalOrdered
FROM OrderDetails OD
JOIN Products P ON OD.ProductID = P.ProductID
GROUP BY P.Category
) AS CategorySales
ORDER BY TotalOrdered DESC
LIMIT 1;


-- 8. Customer who spent the most money --
SELECT CustomerID, TotalSpent
FROM (
SELECT O.CustomerID, SUM(OD.Quantity * P.Price) AS TotalSpent
FROM Orders O
JOIN OrderDetails OD ON O.OrderID = OD.OrderID
JOIN Products P ON OD.ProductID = P.ProductID
GROUP BY O.CustomerID
) AS CustomerSpending
ORDER BY TotalSpent DESC
LIMIT 1;


-- 9. Average order value (total revenue ÷ number of orders) --
SELECT TotalRevenue / TotalOrders AS AvgOrderValue
FROM (
SELECT SUM(OD.Quantity * P.Price) AS TotalRevenue,COUNT(DISTINCT O.OrderID) AS TotalOrders
FROM Orders O
JOIN OrderDetails OD ON O.OrderID = OD.OrderID
JOIN Products P ON OD.ProductID = P.ProductID
) AS OrderStats;


-- 10. Total number of orders placed by each customer --
SELECT CustomerID, COUNT(*) AS TotalOrders
FROM Orders
GROUP BY CustomerID;







