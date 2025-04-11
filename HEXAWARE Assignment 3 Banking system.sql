-- TASK 1 --
CREATE DATABASE HMBank;

USE HMBank;

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    DOB DATE,
    email VARCHAR(100),
    phone_number VARCHAR(20),
    address VARCHAR(255)
);

CREATE TABLE Accounts (
    account_id INT PRIMARY KEY,
    customer_id INT,
    account_type VARCHAR(50),
    balance DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Transactions (
    transaction_id INT PRIMARY KEY,
    account_id INT,
    transaction_type VARCHAR(50),
    amount DECIMAL(10, 2),
    transaction_date DATE,
    FOREIGN KEY (account_id) REFERENCES Accounts(account_id)
);

-- TASK 2 a. ) --
-- INSERTING THE VALUES --
INSERT INTO Customers (customer_id, first_name, last_name, DOB, email, phone_number, address)
VALUES
(1, 'Alice', 'Smith', '1990-05-14', 'alice@example.com', '1234567890', '123 Maple St'),
(2, 'Bob', 'Johnson', '1985-07-22', 'bob@example.com', '2345678901', '456 Oak St'),
(3, 'Charlie', 'Brown', '1992-03-10', 'charlie@example.com', '3456789012', '789 Pine St'),
(4, 'David', 'Williams', '1978-11-30', 'david@example.com', '4567890123', '321 Elm St'),
(5, 'Eva', 'Taylor', '1988-01-05', 'eva@example.com', '5678901234', '654 Cedar St'),
(6, 'Frank', 'Lee', '1995-06-18', 'frank@example.com', '6789012345', '987 Birch St'),
(7, 'Grace', 'Martin', '1983-09-25', 'grace@example.com', '7890123456', '741 Cherry St'),
(8, 'Helen', 'Davis', '1991-12-03', 'helen@example.com', '8901234567', '852 Walnut St'),
(9, 'Ian', 'Clark', '1980-02-15', 'ian@example.com', '9012345678', '963 Poplar St'),
(10, 'Jane', 'Miller', '1993-04-20', 'jane@example.com', '0123456789', '159 Spruce St');

INSERT INTO Accounts (account_id, customer_id, account_type, balance) VALUES
(101, 1, 'savings', 5000.00),
(102, 2, 'current', 12000.50),
(103, 3, 'zero_balance', 0.00),
(104, 4, 'savings', 1500.75),
(105, 5, 'current', 8200.00),
(106, 6, 'savings', 4300.20),
(107, 7, 'zero_balance', 0.00),
(108, 8, 'current', 9900.60),
(109, 9, 'savings', 2200.00),
(110, 10, 'savings', 300.00);

INSERT INTO Transactions (transaction_id, account_id, transaction_type, amount, transaction_date)
VALUES
(1001, 101, 'deposit', 1000.00, '2024-04-01'),
(1002, 101, 'withdrawal', 500.00, '2024-04-03'),
(1003, 102, 'deposit', 2000.00, '2024-04-04'),
(1004, 103, 'deposit', 500.00, '2024-04-05'),
(1005, 104, 'withdrawal', 300.00, '2024-04-06'),
(1006, 105, 'deposit', 1000.00, '2024-04-07'),
(1007, 106, 'withdrawal', 200.00, '2024-04-08'),
(1008, 107, 'deposit', 800.00, '2024-04-09'),
(1009, 108, 'transfer', 1500.00, '2024-04-10'),
(1010, 109, 'deposit', 600.00, '2024-04-11');

-- TASK 2 b.) --
-- 1. Retrieve the name, account type, and email of all customers --
SELECT first_name, last_name, account_type, email
FROM Customers
JOIN Accounts ON Customers.customer_id = Accounts.customer_id;

-- 2. List all transactions with customer details --
SELECT first_name, last_name, transaction_type, amount, transaction_date
FROM Customers
JOIN Accounts ON Customers.customer_id = Accounts.customer_id
JOIN Transactions ON Accounts.account_id = Transactions.account_id;

-- 3. Increase the balance of a specific account by a certain amount --
UPDATE Accounts
SET balance = balance + 500
WHERE account_id = 101;

-- 4. Combine first and last names of customers as a full_name --
SELECT customer_id, first_name, last_name, 
CONCAT(first_name, ' ', last_name) AS full_name
FROM Customers;

-- 5. Remove accounts with a balance of zero where the account type is savings --
DELETE FROM Accounts
WHERE balance = 0 AND account_type = 'savings';

-- 6. Find customers living in a specific city --
SELECT * FROM Customers
WHERE address LIKE '%Maple%';

-- 7. Get the account balance for a specific account --
SELECT account_id, balance
FROM Accounts
WHERE account_id = 105;

-- 8. List all current accounts with a balance greater than $1,000 --
SELECT * FROM Accounts
WHERE account_type = 'current' AND balance > 1000;

-- 9. Retrieve all transactions for a specific account --
SELECT * FROM Transactions
WHERE account_id = 108;

-- 10. Calculate the interest accrued on savings accounts --
SELECT account_id, balance, balance * 0.05 AS interest
FROM Accounts
WHERE account_type = 'savings';

-- 11. Identify accounts where the balance is less than a specified overdraft limit --
SELECT * FROM Accounts
WHERE balance < 100;

-- 12. Find customers not living in a specific city --
SELECT * FROM Customers
WHERE address NOT LIKE '%Maple%';



-- TASK 3 --
-- 1. Average account balance for all customers --
SELECT AVG(balance) AS average_balance
FROM Accounts;

-- 2. Top 10 highest account balances --
SELECT * FROM Accounts
ORDER BY balance DESC
LIMIT 10;

-- 3. Total Deposits for All Customers on a specific date --
SELECT SUM(amount) AS total_deposits
FROM Transactions
WHERE transaction_type = 'deposit'
AND transaction_date = '2025-04-01';

-- 4. Oldest Customer --
SELECT * FROM Customers
ORDER BY DOB ASC
LIMIT 1;

-- 4. Newest Customer --
SELECT * FROM Customers
ORDER BY DOB DESC
LIMIT 1;

-- 5. Transaction details with account type --
SELECT t.transaction_id, t.transaction_type, t.amount, t.transaction_date, a.account_type
FROM Transactions t
JOIN Accounts a ON t.account_id = a.account_id;

-- 6. Customers with their account details --
SELECT c.customer_id, c.first_name, c.last_name, a.account_id, a.account_type, a.balance
FROM Customers c
JOIN Accounts a ON c.customer_id = a.customer_id;

-- 7. Transaction details + customer info for a specific account --
SELECT transaction_id, transaction_type, amount, transaction_date,first_name, last_name
FROM Transactions
JOIN Accounts ON Transactions.account_id = Accounts.account_id
JOIN Customers ON Accounts.customer_id = Customers.customer_id
WHERE Transactions.account_id = 101;


-- 8. Customers with more than one account --
SELECT customer_id, COUNT(*) AS account_count
FROM Accounts
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- 9. Difference between total deposits and total withdrawals --
SELECT SUM(amount) AS total_deposit
FROM Transactions
WHERE transaction_type = 'deposit';
SELECT SUM(amount) AS total_withdrawal
FROM Transactions
WHERE transaction_type = 'withdrawal';
SELECT (SELECT SUM(amount) FROM Transactions WHERE transaction_type = 'deposit') -
(SELECT SUM(amount) FROM Transactions WHERE transaction_type = 'withdrawal') AS difference;


-- 10. Average daily balance per account --
SELECT account_id, AVG(balance) AS avg_daily_balance
FROM Accounts
WHERE account_id IN (
SELECT account_id FROM Transactions
WHERE transaction_date BETWEEN '2025-04-01' AND '2025-04-30'
)
GROUP BY account_id;

-- 11. Total balance for each account type --
SELECT account_type, SUM(balance) AS total_balance
FROM Accounts
GROUP BY account_type;

-- 12. Accounts with most transactions --
SELECT account_id, COUNT(*) AS transaction_count
FROM Transactions
GROUP BY account_id
ORDER BY transaction_count DESC;

-- 13. Customers with high total balance per account type --
SELECT c.customer_id, c.first_name, c.last_name, a.account_type, SUM(a.balance) AS total_balance
FROM Customers c
JOIN Accounts a ON c.customer_id = a.customer_id
GROUP BY c.customer_id, a.account_type
HAVING SUM(a.balance) > 5000;

-- 14. Duplicate transactions --
SELECT account_id, amount, transaction_date, COUNT(*) AS duplicate_count
FROM Transactions
GROUP BY account_id, amount, transaction_date
HAVING COUNT(*) > 1;


-- TASK 4 --
-- 1. Customers with the highest account balance --
SELECT * FROM Customers
WHERE customer_id IN (
SELECT customer_id FROM Accounts
WHERE balance = (SELECT MAX(balance) FROM Accounts)
);

-- 2. Average account balance for customers with more than one account --
SELECT AVG(balance) AS avg_balance
FROM Accounts
WHERE customer_id IN (
SELECT customer_id FROM Accounts
GROUP BY customer_id
HAVING COUNT(*) > 1
);

-- 3. Accounts with transactions greater than average transaction amount --
SELECT * FROM Transactions
WHERE amount > (
SELECT AVG(amount) FROM Transactions
);

-- 4. Customers with no transactions --
SELECT * FROM Customers
WHERE customer_id NOT IN (
SELECT DISTINCT customer_id FROM Accounts
WHERE account_id IN (
SELECT DISTINCT account_id FROM Transactions
  )
);

-- 5. Total balance of accounts with no transactions --
SELECT SUM(balance) AS total_balance_without_transactions
FROM Accounts
WHERE account_id NOT IN (
SELECT DISTINCT account_id FROM Transactions
);

-- 6. Transactions for accounts with the lowest balance --
SELECT * FROM Transactions
WHERE account_id IN (
SELECT account_id FROM Accounts
WHERE balance = (SELECT MIN(balance) FROM Accounts)
);

-- 7. Customers with accounts of multiple types
SELECT customer_id FROM Accounts
GROUP BY customer_id
HAVING COUNT(DISTINCT account_type) > 1;

-- 8. Percentage of each account type out of total accounts --
SELECT account_type,(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Accounts)) AS percentage
FROM Accounts
GROUP BY account_type;

-- 9. All transactions for a customer with given customer_id --
SELECT * FROM Transactions
WHERE account_id IN (
SELECT account_id FROM Accounts
WHERE customer_id = 1
);

-- 10. Total balance for each account type using subquery in SELECT --
SELECT account_type,
       SUM(balance) AS total_balance
FROM Accounts
GROUP BY account_type;












