use Northwind;

-- # 1 - Which shippers do we have?

select * from Shippers;

-- # 2 - Certain fields from Categories

select CategoryName, Description from Categories;

-- # 3 - Sales Representatives

select FirstName, LastName, HireDate from Employees

where Title = 'Sales Representative';

-- # 4 - Sales Representatives in the US

select FirstName, LastName, HireDate from Employees

where Title = 'Sales Representative'
AND Country = 'USA';

-- # 5 - Orders placed by specific EmployeeID

select OrderID, OrderDate from Orders
where EmployeeID = 5;

-- # 6 - Suppliers and ContactTitles

select SupplierID, ContactName, ContactTitle from Suppliers
where not ContactTitle = 'Marketing Manager';

-- # 7 - Products with 'queso' in ProductName

select ProductID, ProductName from Products
where ProductName like '%queso%';

-- # 8 - Orders Shipping to France or Belgium 

select OrderID, CustomerID, ShipCountry from Orders
where ShipCountry = 'France'
OR ShipCountry = 'Belgium';

-- # 9 - Orders shipping to any country in Latin America

select OrderID, CustomerID, ShipCountry from Orders
where ShipCountry in ('Brazil', 'Mexico', 'Argentina', 'Venezuela')

-- # 10 - Employees, in order of age

select FirstName, LastName, Title, BirthDate from Employees
order by BirthDate Asc;

-- # 11 - Showing only the Date with a DateTime field

select FirstName, LastName, Title, Convert(Date, BirthDate) AS BirthDate from Employees
order by BirthDate Asc;

-- # 12 - Employees full name

select FirstName, LastName, CONCAT(FirstName, ' ', LastName) AS FullName  from Employees

-- # 13 - OrderDetails amount per line item

Select OrderID, ProductID, UnitPrice, Quantity, (UnitPrice * Quantity) AS TotalPrice  from OrderDetails
order by OrderID, ProductID;

-- # 14 - How many customers?

select count(DISTINCT(CustomerID))AS TotalCustomers from Customers;

-- # 15 - What was the first order? 

select min(OrderDate) from Orders;

-- # 16 - Countries where there are customers

select distinct Country from Customers; 

-- # 17 - Contact titles for customers

select ContactTitle, count(ContactTitle) AS 'TotalContactTitle' from Customers
group by ContactTitle
Order by TotalContactTitle desc;

-- # 18 - Products with associated supplier names

select Products.ProductID, Products.ProductName, Suppliers.CompanyName from Products
join Suppliers
	on Products.SupplierID = Suppliers.SupplierID;

-- # 19 - Orders and the Shipper that was used

select OrderID, convert(Date, OrderDate) AS 'OrderDate', Shippers.ShipperID from Orders
join Shippers
	on Orders.ShipVia = Shippers.ShipperID
	where OrderID < 10300;