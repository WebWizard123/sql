use classicmodels;

Day 3

1)	Show customer number, customer name, state and credit limit from customers table for below conditions. Sort the results by highest to lowest values of creditLimit.

●	State should not contain null values
●	credit limit should be between 50000 and 100000
Ans:


SELECT
    customerNumber,
    customerName,
    state,
    creditLimit
FROM
    Customers
WHERE
    state IS NOT NULL
    AND creditLimit BETWEEN 50000 AND 100000
ORDER BY
    creditLimit DESC;

2)	Show the unique productline values containing the word cars at the end from products table.
Ans:


SELECT DISTINCT
    productLine
FROM
    Products
WHERE
    productLine LIKE '%cars'
ORDER BY
    productLine;

Day 4

1)	Show the orderNumber, status and comments from orders table for shipped status only. If some comments are having null values then show them as “-“.

 SELECT
    orderNumber,
    status,
    COALESCE(comments, '-') AS comments
FROM
    Orders
WHERE
    status = 'Shipped';
          
       2)	Select employee number, first name, job title and job title abbreviation from employees table based on following conditions.
If job title is one among the below conditions, then job title abbreviation column should show below forms.
●	President then “P”
●	Sales Manager / Sale Manager then “SM”
●	Sales Rep then “SR”
●	Containing VP word then “VP”

       Ans:
       
        SELECT
    employeeNumber,
    firstName,
    jobTitle,
    CASE
        WHEN jobTitle = 'President' THEN 'P'
        WHEN jobTitle IN ('Sales Manager', 'Sale Manager') THEN 'SM'
        WHEN jobTitle = 'Sales Rep' THEN 'SR'
        WHEN jobTitle LIKE '%VP%' THEN 'VP'
        ELSE '-'
    END AS jobTitleAbbreviation
FROM
    Employees;
  

Day 5:

1)	For every year, find the minimum amount value from payments table
Ans:

SELECT
    YEAR(paymentDate) AS paymentYear,
    MIN(amount) AS minPaymentAmount
FROM
    payments
GROUP BY
    paymentYear;


2)	For every year and every quarter, find the unique customers and total orders from orders table. Make sure to show the quarter as Q1,Q2 etc
Ans:


SELECT
    YEAR(orderDate) AS orderYear,
    CONCAT('Q', QUARTER(orderDate)) AS orderQuarter,
    COUNT(DISTINCT customerNumber) AS uniqueCustomers,
    COUNT(orderNumber) AS totalOrders
FROM
    orders
GROUP BY
    orderYear, orderQuarter;

 3)	Show the formatted amount in thousands unit (e.g. 500K, 465K etc.) for every month (e.g. Jan, Feb etc.)
 with filter on total amount as 500000 to 1000000. Sort the output by total amount in descending mode. [ Refer. Payments Table]
 
 Ans:
 SELECT
    DATE_FORMAT(paymentDate, '%b') AS month,
    CONCAT(FORMAT(SUM(amount) / 1000, 0), 'K') AS formattedAmount
FROM
    payments
GROUP BY
    month
HAVING
    SUM(amount) BETWEEN 500000 AND 1000000
ORDER BY
    SUM(amount) DESC;

Day 6 (1)

CREATE TABLE Journey (
    Bus_ID INT NOT NULL,
    Bus_Name VARCHAR(255) NOT NULL,
    Source_Station VARCHAR(255) NOT NULL,
    Destination VARCHAR(255) NOT NULL,
    Email VARCHAR(255) NOT NULL UNIQUE,
    PRIMARY KEY (Bus_ID)
);

Day 6 (2)
CREATE TABLE Vendor (
    Vendor_ID INT NOT NULL UNIQUE,
    Name VARCHAR(255) NOT NULL,
    Email VARCHAR(255) NOT NULL UNIQUE,
    Country VARCHAR(255) DEFAULT 'N/A',
    PRIMARY KEY (Vendor_ID)
);

Day 6 (3)


CREATE TABLE Movies (
    Movie_ID INT NOT NULL UNIQUE,
    Name VARCHAR(255) NOT NULL,
    Release_Year VARCHAR(4) DEFAULT '-',
    Cast VARCHAR(255) NOT NULL,
    Gender ENUM('Male', 'Female') NOT NULL,
    No_of_shows INT CHECK (No_of_shows >= 0) NOT NULL,
    PRIMARY KEY (Movie_ID)
);

Day 6 (4)a

CREATE TABLE Product (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(255) NOT NULL UNIQUE,
    description TEXT,
    supplier_id INT,
    FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id)
);

(4)b

CREATE TABLE Suppliers (
    supplier_id INT PRIMARY KEY AUTO_INCREMENT,
    supplier_name VARCHAR(255),
    location VARCHAR(255)
);
(4)c
CREATE TABLE Stock (
    id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    balance_stock INT,
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

Day 7(1)
Ans:
SELECT
    e.employeeNumber,
    CONCAT(e.firstName, ' ', e.lastName) AS SalesPerson,
    COUNT(DISTINCT c.customerNumber) AS UniqueCustomers
FROM
    Employees e
JOIN
    Customers c ON e.employeeNumber = c.salesRepEmployeeNumber
GROUP BY
    e.employeeNumber, SalesPerson
ORDER BY
    UniqueCustomers DESC;

Day 7(2)
ans:
SELECT
    c.customerNumber,
    c.customerName,
    p.productCode,
    p.productName,
    SUM(od.quantityOrdered) AS "Order qty",
    p.quantityInStock AS "Total Inventory",
    (p.quantityInStock - SUM(od.quantityOrdered)) AS "Left Qty"
FROM
    Customers c
JOIN
    Orders o ON c.customerNumber = o.customerNumber
JOIN
    OrderDetails od ON o.orderNumber = od.orderNumber
JOIN
    Products p ON od.productCode = p.productCode
GROUP BY
    c.customerNumber, p.productCode, p.productName, "Total Inventory"
ORDER BY
    c.customerNumber;

Day 7 (3)


-- Create Laptop table
CREATE TABLE Laptop (
    Laptop_Name VARCHAR(255)
);

-- Insert data into Laptop table
INSERT INTO Laptop (Laptop_Name)
VALUES
    ('Dell'),
    ('HP');

-- Create Colours table
CREATE TABLE Colours (
    Colour_Name VARCHAR(255)
);

-- Insert data into Colours table
INSERT INTO Colours (Colour_Name)
VALUES
    ('White'),
    ('Silver'),
    ('Black');



-- Perform cross join and show laptop name and color name
SELECT
    'Dell' AS Laptop_Name,
    Colour_Name
FROM
    Colours
UNION ALL
SELECT
    'HP' AS Laptop_Name,
    Colour_Name
FROM
    Colours;

Day 7 (4)

-- Create Project table
CREATE TABLE Project (
    EmployeeID INT,
    FullName VARCHAR(255),
    Gender VARCHAR(10),
    ManagerID INT
);

-- Insert data into Project table
INSERT INTO Project VALUES(1, 'Priyanka', 'Female', 1);
INSERT INTO Project VALUES(2, 'Priyanka', 'Female', 1);
INSERT INTO Project VALUES(3, 'Preety', 'Female', NULL);
INSERT INTO Project VALUES(4, 'Anurag', 'Male', 1);
INSERT INTO Project VALUES(5, 'Sambit', 'Male', 1);
INSERT INTO Project VALUES(6, 'Rajesh', 'Male', 3);
INSERT INTO Project VALUES(7, 'Hina', 'Female', 3);

-- Find out the names of employees and their related managers

SELECT
    Manager.FullName AS ManagerName,
    Employee.FullName AS EmpName
FROM
    Project AS Employee
INNER JOIN
    Project AS Manager ON  Manager.EmployeeID = Employee.ManagerID
ORDER BY
    ManagerName, EmpName;

Day 8

-- Create the facility table
CREATE TABLE facility (
    Facility_ID INT AUTO_INCREMENT,
    Name VARCHAR(255),
    State VARCHAR(255),
    Country VARCHAR(255),
    PRIMARY KEY (Facility_ID)
);

-- Add a new column 'City' after 'Name' with data type varchar that does not accept null values
ALTER TABLE facility
ADD COLUMN City VARCHAR(255) NOT NULL AFTER Name;

DESCRIBE facility;

Day 9

-- Create the 'university' table
CREATE TABLE university (
    ID INT,
    Name VARCHAR(255)
);

-- Insert data into the 'university' table
INSERT INTO university (ID, Name)
VALUES 
(1, "       Pune          University     "), 
(2, "  Mumbai          University     "),
(3, "     Delhi   University     "),
(4, "Madras University"),
(5, "Nagpur University");

-- Update the column values to remove spaces
UPDATE university
SET Name = REPLACE(TRIM(BOTH ' ' FROM Name), ' ', ' ');

SET SQL_SAFE_UPDATES = 0;
-- Display the updated data
SELECT * FROM university;

Day 10

CREATE VIEW products_status2 AS
SELECT
    Year,
    SUM(Sale) AS total_value,
    CONCAT(SUM(Sale), ' (', FORMAT(SUM(Sale) / SUM(SUM(Sale)) OVER (), 'P'), ')') AS percentage
FROM
    Sales
GROUP BY
    Year
ORDER BY
    Year DESC;
SELECT * FROM products_status2;






Day 11
DELIMITER //

CREATE PROCEDURE GetCustomerLevel(IN customerNumber INT)
BEGIN
    DECLARE customerCreditLimit DECIMAL(10, 2);

    -- Get the creditLimit for the provided customerNumber
    SELECT creditLimit INTO customerCreditLimit
    FROM Customers
    WHERE customerNumber = customerNumber;

    -- Determine customer level based on creditLimit
    IF customerCreditLimit > 100000 THEN
        SELECT 'Platinum' AS CustomerLevel;
    ELSEIF customerCreditLimit BETWEEN 25000 AND 100000 THEN
        SELECT 'Gold' AS CustomerLevel;
    ELSE
        SELECT 'Silver' AS CustomerLevel;
    END IF;
END //

DELIMITER ;

ii)
use classicmodels;
DELIMITER //

CREATE PROCEDURE Get_country_payments2(IN inputYear INT, IN inputCountry VARCHAR(255))
BEGIN
    SELECT
        YEAR(paymentDate) AS year,
        country,
        CONCAT(FORMAT(SUM(amount) / 1000, 0), 'K') AS total_amount
    FROM
        Payments
    JOIN
        Customers ON Payments.customerNumber = Customers.customerNumber
    WHERE
        YEAR(paymentDate) = inputYear
        AND country = inputCountry
    GROUP BY
        year, country;
END //

DELIMITER ;
CALL Get_country_payments2(2003, 'France');

Day 12
SELECT
  year,
  month,
  PY AS total_orders,
  LAG(CONCAT(ROUND(((CY - PY) / PY) * 100), "%")) OVER (ORDER BY year) AS `% YOY change`
FROM (
  SELECT
    YEAR(orderDate) AS year,
    MONTHNAME(orderDate) AS month,
    MONTH(orderDate) AS mno,
    COUNT(orderNumber) AS PY,
    LEAD(COUNT(orderNumber)) OVER (ORDER BY YEAR(orderDate)) AS CY
  FROM orders
  GROUP BY year, month, mno
  ORDER BY year, mno
) asd;
2)

CREATE TABLE emp_udf (
  Emp_ID INT AUTO_INCREMENT PRIMARY KEY,
  Name VARCHAR(20),
  DOB DATE
);

INSERT INTO Emp_UDF(Name, DOB)
VALUES
  ("Piyush", "1990-03-30"),
  ("Aman", "1992-08-15"),
  ("Meena", "1998-07-28"),
  ("Ketan", "2000-11-21"),
  ("Sanjay", "1995-05-21");

DELIMITER $$
CREATE FUNCTION `CALCULATE_AGE`(DOB DATE)
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
  DECLARE years INT;
  DECLARE months INT;
  DECLARE age VARCHAR(100);
  SET years = TIMESTAMPDIFF(YEAR, dob, CURDATE());
  SET months = TIMESTAMPDIFF(MONTH, dob, CURDATE()) % 12;
  SET age = CONCAT(years, ' years ', months, ' months');
  RETURN AGE;
END$$

DELIMITER ;

SELECT *, `CALCULATE_AGE`(DOB) AS AGE FROM emp_udf;

-- Day 13
-- Task 1
SELECT
  customernumber,
  customername
FROM customers
WHERE customernumber NOT IN (SELECT customernumber FROM orders);

-- Task 2
SELECT
  a.customernumber,
  a.customername,
  COUNT(b.orderNumber) AS `total orders`
FROM customers AS a
LEFT JOIN orders AS b ON a.customernumber = b.customernumber
GROUP BY a.customernumber, a.customername
UNION
SELECT
  a.customernumber,
  a.customername,
  COUNT(b.orderNumber) AS `total orders`
FROM customers AS a
RIGHT JOIN orders AS b ON a.customernumber = b.customernumber
GROUP BY a.customernumber, a.customername;

-- Task 3
SELECT
  ordernumber,
  MAX(quantityordered) AS `Quantity ordered`
FROM (
  SELECT
    ordernumber,
    quantityOrdered,
    DENSE_RANK() OVER (PARTITION BY ORDERNUMBER ORDER BY quantityOrdered DESC) AS NUM
  FROM ORDERDETAILS
) ABC
WHERE NUM = 2
GROUP BY ordernumber;

-- Task 4
SELECT
  MAX(ORDERS) AS `MAX TOTAL`,
  MIN(ORDERS) AS `MINI TOTAL`
FROM (
  SELECT
    ORDERNUMBER,
    COUNT(PRODUCTCODE) AS ORDERS
  FROM ORDERDETAILS
  GROUP BY ORDERNUMBER
) ABC;

-- Task 5
SELECT
  PRODUCTLINE,
  COUNT(productline) AS `total`
FROM products
WHERE buyprice > (SELECT AVG(buyprice) FROM products)
GROUP BY productline
ORDER BY TOTAL DESC;

-- Day 14
CREATE TABLE Emp_EH (
  EmpID INT PRIMARY KEY,
  EmpName VARCHAR(20),
  EmailAddress VARCHAR(100)
);

SELECT * FROM Emp_EH;

DELIMITER $$

CREATE PROCEDURE INSERT_EMP(id INT, NAME VARCHAR(30), MAIL VARCHAR(40))
BEGIN
  DECLARE exit handler FOR 1062
    SELECT "error occurred" AS message;
  BEGIN
    INSERT INTO Emp_EH VALUES(id, NAME, MAIL);
  END;
END$$

DELIMITER ;

CALL INSERT_EMP(1, "ashish", "ashish@gmail.com");
CALL INSERT_EMP(2, "mahe", "mahendra@gmail.com");
CALL INSERT_EMP(2, "rohit", "rohit@gmail.com");

-- Day 15
CREATE TABLE Emp_BIT (
  Name VARCHAR(20),
  Occupation VARCHAR(20),
  Working_date DATE,
  Working_hours INT
);

DELIMITER $$

CREATE TRIGGER `Working_hours` BEFORE INSERT ON Emp_BIT FOR EACH ROW
BEGIN
  IF NEW.Working_hours < 0 THEN
    SET NEW.Working_hours = ABS(NEW.Working_hours);
  END IF;
END$$

DELIMITER ;

INSERT INTO Emp_BIT VALUES
  ('Robin', 'Scientist', '2020-10-04', -12),
  ('Warner', 'Engineer', '2020-10-04', -10),
  ('Peter', 'Actor', '2020-10-04', 13),
  ('Marco', 'Doctor', '2020-10-04', 14),
  ('Brayden', 'Teacher', '2020-10-04', 12),
  ('Antonio', 'Business', '2020-10-04', 11);

SELECT * FROM emp_bit;

        .....................................................................End.......................................................................
