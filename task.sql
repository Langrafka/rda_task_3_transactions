-- Use our database
USE ShopDB; 

-- Data to be created outside the transaction.
-- We can add a customer and product here, as these operations
-- don't require atomicity with the order creation.
INSERT INTO Customers (ID, FirstName, LastName, Email, Address)
VALUES (1, 'John', 'Doe', 'john.doe@example.com', '123 Main St');

INSERT INTO Products (ID, Name, Description, Price, WarehouseAmount)
VALUES (1, 'AwersomeProduct', 'A truly awesome product!', 100, 10);

-- Start the transaction
START TRANSACTION;

-- And data to be created inside the transaction.
-- This part creates the order and updates the product quantity.
-- If any of these operations fail, all changes inside the transaction will be rolled back.
INSERT INTO Orders (CustomerID, Date)
VALUES (1, '2023-01-01');

INSERT INTO OrderItems (OrderID, ProductID, Count)
VALUES (1, 1, 1);

UPDATE Products
SET WarehouseAmount = WarehouseAmount - 1
WHERE ID = 1;

COMMIT;
