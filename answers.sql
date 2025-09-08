-- Question 1: Achieving 1NF (First Normal Form)

-- Transform the ProductDetail table to 1NF by splitting the Products column
SELECT 
    OrderID,
    CustomerName,
    TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Products, ',', n), ',', -1)) AS Product
FROM ProductDetail
CROSS JOIN (
    SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5
) numbers
WHERE n <= LENGTH(Products) - LENGTH(REPLACE(Products, ',', '')) + 1
ORDER BY OrderID, Product;

-- Question 2: Achieving 2NF (Second Normal Form)

-- Create Orders table to remove partial dependency (CustomerName depends only on OrderID)
CREATE TABLE Orders AS
SELECT DISTINCT OrderID, CustomerName 
FROM OrderDetails;

-- Create OrderItems table with full dependency on composite key (OrderID + Product)
CREATE TABLE OrderItems AS
SELECT OrderID, Product, Quantity 
FROM OrderDetails;
