use Northwind;

-- # 20 - Categories, and the total products in each category

select CategoryName, count(Products.ProductID) AS TotalProducts from Categories

join Products
	on Categories.CategoryID = Products.CategoryID

group by CategoryName
order by TotalProducts desc;

-- # 21 - Total Customers per country/city

select Country, City, count(City) AS 'TotalCustomer' from Customers
group by Country, City
order by TotalCustomer desc;

-- # 22 - Products that need reordering

select ProductID, ProductName, UnitsInStock, ReorderLevel from Products
Where ReorderLevel > UnitsInStock;

-- # 23 - Products that need reordering, continued

select ProductID, ProductName, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued from Products
Where (UnitsInStock + UnitsOnOrder) <= ReorderLevel
	AND Discontinued = 0

-- # 24 - Customer list by region

Select CustomerID, CompanyName, Region from Customers

order by coalesce([Region], 'ZZZZZZZ'), CustomerID;

-- # 25 - High freight charges

select top 3 ShipCountry, avg(Freight) as AverageFreight from Orders 
group by ShipCountry
order by AverageFreight desc

-- # 26 - High freight charges - 2015

select top 3 ShipCountry, avg(Freight) as AverageFreight from Orders
where year(OrderDate) = $2015
group by ShipCountry
order by AverageFreight desc

-- # 27 - High freight charges with between

Select top 3 ShipCountry, AverageFreight = avg(freight) from Orders
Where OrderDate between '1/1/2015' and '1/1/2016'
Group By ShipCountry
Order By AverageFreight desc;

-- # 28 - High freight charges - last year

select top 3 ShipCountry, avg(Freight) as AverageFreight from Orders
Where OrderDate > Dateadd(yy, -1, (Select Max(OrderDate) from Orders))
group by ShipCountry
order by AverageFreight desc;

-- # 29 - Inventory List

select Orders.EmployeeID, LastName, Orders.OrderID, ProductName, Quantity from Orders

join Employees
	on Orders.EmployeeID = Employees.EmployeeID
join OrderDetails
	on Orders.OrderID = OrderDetails.OrderID
join Products
	on OrderDetails.ProductID = Products.ProductID

order by Orders.OrderID, Products.ProductID

-- # 30 - Customers with no orders

select Customers_CustomerID = Customers.CustomerID, Orders_CustomerID = Orders.CustomerID from Customers

left join Orders
on Customers.CustomerID = Orders.CustomerID

where Orders.CustomerID IS NULL;

-- # 31 - Customers with no orders for EmployeeID 4

select Customers_CustomerID = Customers.CustomerID, Orders_CustomerID = Orders.CustomerID from Customers

left join Orders
on Customers.CustomerID = Orders.CustomerID
	And Orders.EmployeeID = 4

where Orders.CustomerID IS NULL
	