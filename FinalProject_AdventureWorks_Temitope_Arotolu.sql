USE [AdventureWorks2022]


--SECTION 1: BEGINNER LEVEL TASKS 

--Task 1: List All Employees and Their Job Titles 
--• Objective: Retrieve basic employee information.
 
 select * from  [HumanResources].[Employee]
 select * from [Person].[Person]

SELECT 
    p.FirstName,
    p.LastName,
    e.JobTitle
FROM 
    HumanResources.Employee e
INNER JOIN 
    Person.Person p ON e.BusinessEntityID = p.BusinessEntityID



--Task 2: Display All Products and Their List Prices 
--• Objective: Extract product details.

select * from [Production].[Product]

SELECT 
    Name AS ProductName,
    ListPrice
FROM 
    Production.Product 
	



--Task 3: Retrieve Customers Who Placed Orders in 2021 
--• Objective: Identify active customers within a specific timeframe.

select * from [Sales].[SalesOrderHeader]
select * from [Sales].[Customer]
select * from [Person].[Person]

SELECT DISTINCT
    p.FirstName,
    p.LastName,
    c.CustomerID
FROM 
    Sales.SalesOrderHeader soh
INNER JOIN 
    Sales.Customer c ON soh.CustomerID = c.CustomerID
INNER JOIN 
    Person.Person p ON c.PersonID = p.BusinessEntityID
WHERE 
    YEAR(soh.OrderDate) = 2021
--There is no record of 2021 data in the AdventureWorks database, hence the empty table with only the header.

--Retrieve Customers Who Placed Orders in 2013 
SELECT DISTINCT
    p.FirstName,
    p.LastName,
    c.CustomerID
FROM 
    Sales.SalesOrderHeader soh
INNER JOIN 
    Sales.Customer c ON soh.CustomerID = c.CustomerID
INNER JOIN 
    Person.Person p ON c.PersonID = p.BusinessEntityID
WHERE 
    YEAR(soh.OrderDate) = 2013



--Task 4: List the Top 10 Most Expensive Products 
--• Objective: Identify high-value products.

select * from [Production].[Product]

SELECT TOP 10
    Name AS ProductName,
    ListPrice
FROM 
    Production.Product
WHERE 
    ListPrice > 0
ORDER BY 
    ListPrice DESC



--Task 5: Show the Total Number of Orders Placed in 2021 
--• Objective: Aggregate order data for a specific year.

select * from [Sales].[SalesOrderHeader]

SELECT 
    COUNT(*) AS TotalOrders2021
FROM 
    Sales.SalesOrderHeader
WHERE 
    YEAR(OrderDate) = 2021
--There is no record of 2021 data in the AdventureWorks database, hence the TotalOrder for 2021 is 0.

-- Show the Total Number of Orders Placed in 2014
SELECT 
    COUNT(*) AS TotalOrders2014
FROM 
    Sales.SalesOrderHeader
WHERE 
    YEAR(OrderDate) = 2014



--Task 6: List Sales Orders with TotalDue Greater Than $1,500 
--• Objective: Highlight high-value transactions.

select * from [Sales].[SalesOrderHeader]

SELECT 
    SalesOrderID,
    OrderDate,
    TotalDue
FROM 
    Sales.SalesOrderHeader
WHERE 
    TotalDue > 1500


--Task 7: Retrieve Products with ListPrice Between $100 and $500 
--• Objective: Filter products within a specific price range.

select * from [Production].[Product]

SELECT 
    ProductID,
    Name,
    ListPrice
FROM 
    Production.Product
WHERE 
    ListPrice BETWEEN 100 AND 500


--Task 8: Retrieve Customers from a Specific Region (e.g., "United States") 
--• Objective: Segment customers based on geographical location.

select * from [Sales].[Customer]
select * from [Person].[Person]
select * from [Person].[Address]

SELECT 
    c.CustomerID,
    p.FirstName,
    p.LastName,
    a.AddressLine1,
    a.City
    
FROM 
    Sales.Customer c
INNER JOIN 
    Person.Person p ON c.PersonID = p.BusinessEntityID
INNER JOIN 
    Person.BusinessEntityAddress bea ON p.BusinessEntityID = bea.BusinessEntityID
INNER JOIN 
    Person.Address a ON bea.AddressID = a.AddressID
WHERE 
    a.City = 'United States'
--There is no record of City = 'United States' in the AdventureWorks database, hence the empty table with only the header.

--Retrieve Customers from a Specific Region (e.g., "Bothell") 
SELECT 
    c.CustomerID,
    p.FirstName,
    p.LastName,
    a.AddressLine1,
    a.City
    
FROM 
    Sales.Customer c
INNER JOIN 
    Person.Person p ON c.PersonID = p.BusinessEntityID
INNER JOIN 
    Person.BusinessEntityAddress bea ON p.BusinessEntityID = bea.BusinessEntityID
INNER JOIN 
    Person.Address a ON bea.AddressID = a.AddressID
WHERE 
    a.City = 'Bothell'



--SECTION 2: INTERMEDIATE LEVEL TASKS 

--Task 9: Calculate Total Sales Amount for Each Year from 2020 to 2022 
--• Objective: Analyze sales trends over multiple years.

select * from [Sales].[SalesOrderHeader]

SELECT 
    YEAR(OrderDate) AS SalesYear,
    SUM(TotalDue) AS TotalSalesAmount
FROM 
    Sales.SalesOrderHeader
WHERE 
    YEAR(OrderDate) BETWEEN 2020 AND 2022
GROUP BY 
    YEAR(OrderDate)
ORDER BY 
    SalesYear
--There is no record of data for 2020 and 2022 in the AdventureWorks database, hence the empty table.

--Calculate Total Sales Amount for Each Year from 2012 to 2014 
SELECT 
    YEAR(OrderDate) AS SalesYear,
    SUM(TotalDue) AS TotalSalesAmount
FROM 
    Sales.SalesOrderHeader
WHERE 
    YEAR(OrderDate) BETWEEN 2012 AND 2014
GROUP BY 
    YEAR(OrderDate)
ORDER BY 
    SalesYear


--Task 10: Display Number of Orders Placed by Each Customer 
--• Objective: Understand customer ordering behavior.

select * from [Sales].[SalesOrderHeader]
select * from [Sales].[Customer]
select * from [Person].[Person]

SELECT 
    c.CustomerID,
    p.FirstName + ' ' + p.LastName AS CustomerName,
    COUNT(soh.SalesOrderID) AS NumberOfOrders
FROM 
    Sales.SalesOrderHeader soh
INNER JOIN 
    Sales.Customer c ON soh.CustomerID = c.CustomerID
INNER JOIN 
    Person.Person p ON c.PersonID = p.BusinessEntityID
GROUP BY 
    c.CustomerID, p.FirstName, p.LastName
ORDER BY 
    NumberOfOrders DESC


--Task 11: List Products That Have Never Been Sold 
--• Objective: Identify unsold inventory.

select * from [Production].[Product]
select * from [Sales].[SalesOrderDetail]

SELECT 
    p.ProductID,
    p.Name
FROM 
    Production.Product p
LEFT JOIN 
    Sales.SalesOrderDetail sod ON p.ProductID = sod.ProductID
WHERE 
    sod.ProductID IS NULL



--Task 12: Find Total Number of Employees with the Title "Sales Representative" 
--• Objective: Assess the size of the sales team.

select * from [HumanResources].[Employee]

SELECT 
    COUNT(*) AS NumberOfSalesRepresentatives
FROM 
    HumanResources.Employee
WHERE 
    JobTitle = 'Sales Representative'



--Task 13: Retrieve Average ListPrice for All Products in the "Bikes" Category 
--• Objective: Determine pricing strategy for the Bikes category.

select * from [Production].[Product]
select * from [Production].[ProductSubcategory]
select * from [Production].[ProductCategory]

SELECT 
    AVG(p.ListPrice) AS AverageListPrice
FROM 
    Production.Product p
INNER JOIN 
    Production.ProductSubcategory ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
INNER JOIN 
    Production.ProductCategory pc ON ps.ProductCategoryID = pc.ProductCategoryID
WHERE 
    pc.Name = 'Bikes'



--Task 14: List Top 5 Customers Based on Total Order Amount 
--• Objective: Identify top-performing customers.

select * from [Sales].[SalesOrderHeader]
select * from [Sales].[Customer]
select * from [Person].[Person]

SELECT TOP 5
    c.CustomerID,
    p.FirstName + ' ' + p.LastName AS CustomerName,
    SUM(soh.TotalDue) AS TotalOrderAmount
FROM 
    Sales.SalesOrderHeader soh
INNER JOIN 
    Sales.Customer c ON soh.CustomerID = c.CustomerID
INNER JOIN 
    Person.Person p ON c.PersonID = p.BusinessEntityID
GROUP BY 
    c.CustomerID, p.FirstName, p.LastName
ORDER BY 
    TotalOrderAmount DESC


--Task 15: Display All Products Sold More Than 50 Times in 2023 
--• Objective: Highlight high-demand products.

select * from [Production].[Product]
select * from [Sales].[SalesOrderDetail]

SELECT 
    p.ProductID,
    p.Name,
    COUNT(sod.SalesOrderID) AS TimesSold
FROM 
    Production.Product p
INNER JOIN 
    Sales.SalesOrderDetail sod ON p.ProductID = sod.ProductID
INNER JOIN 
    Sales.SalesOrderHeader soh ON sod.SalesOrderID = soh.SalesOrderID
WHERE 
    YEAR(soh.OrderDate) = 2023
GROUP BY 
    p.ProductID, p.Name
HAVING 
    COUNT(sod.SalesOrderID) > 50
	--There is no record of data for 2023 in the AdventureWorks database, hence the empty table.

--Display All Products Sold More Than 50 Times in 2014 
SELECT 
    p.ProductID,
    p.Name,
    COUNT(sod.SalesOrderID) AS TimesSold
FROM 
    Production.Product p
INNER JOIN 
    Sales.SalesOrderDetail sod ON p.ProductID = sod.ProductID
INNER JOIN 
    Sales.SalesOrderHeader soh ON sod.SalesOrderID = soh.SalesOrderID
WHERE 
    YEAR(soh.OrderDate) = 2014
GROUP BY 
    p.ProductID, p.Name
HAVING 
    COUNT(sod.SalesOrderID) > 50