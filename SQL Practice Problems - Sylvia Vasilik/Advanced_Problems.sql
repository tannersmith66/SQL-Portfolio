use Northwind;

-- # 32 - High-value customers 
-- Defining high-value customers as those who've made at least 1 order with a total value (not including the discount) equal to $10,000 or more. We only want to consider orders made in the year 2016.

select 
	c.CustomerID, c.CompanyName, o.OrderID, sum(od.UnitPrice * od.Quantity) AS TotalOrderAmount 
from Customers c
join Orders o
	on c.CustomerID = o.CustomerID
join OrderDetails od
	on o.OrderID = od.OrderID
where 
	Year(o.OrderDate) = 2016
group by 
	c.CustomerID, c.CompanyName, o.OrderID
having 
	sum(od.UnitPrice * od.Quantity) >= 10000
order by 
	TotalOrderAmount desc;

-- # 33 - High-value customers - Total Orders
-- Instead of requiring that customers have at least one individual orders totaling $10,000 or more, they want to define high-value customers as those who have orders totaling $15,000 or more in 2016.

select 
	c.CustomerID, c.CompanyName, sum(od.UnitPrice * od.Quantity) AS TotalOrderAmount 
from Customers c
join Orders o
	on c.CustomerID = o.CustomerID
join OrderDetails od
	on o.OrderID = od.OrderID
where 
	Year(o.OrderDate) = 2016
group by 
	c.CustomerID, c.CompanyName
having 
	sum(od.UnitPrice * od.Quantity) >= 15000
order by 
	TotalOrderAmount desc;

-- # 34 High-value customers - with discount
-- Change the above query to use the discount when calculating high-value customers. Order by the total amount which includes the discount.

select
	c.CustomerID, c.CompanyName, TotalsWithoutDiscount = sum(od.UnitPrice * od.Quantity), TotalsWithDiscount = sum  (od.UnitPrice * od.Quantity * (1 - od.Discount))
from Customers c
join Orders o
	on c.CustomerID = o.CustomerID
join OrderDetails od
	on o.OrderID = od.OrderID
where 
	Year(o.OrderDate) = 2016
group by 
	c.CustomerID, c.CompanyName
having 
	sum(od.UnitPrice * od.Quantity * (1 - od.Discount)) >= 10000
order by 
	TotalsWithDiscount desc;

-- # 35 - Month End Orders 
-- Show all orders made on the last day of the month. Order by EmployeeID and OrderID

select 
	EmployeeID, OrderID, OrderDate 
from Orders

where 
	OrderDate = (EOMONTH(OrderDate))

Order By 
	EmployeeID, OrderID

-- 36 - Orders with many line items
-- Show the 10 orders with the most line items, in order of total line items

select TOP 10
	o.OrderID, count(Od.OrderID) as TotalOrderDetails  
from Orders o

join OrderDetails od
	on o.OrderID = od.OrderID

group by 
	o.OrderID
order by TotalOrderDetails desc

-- 37 - Orders - random assortment
-- Show a random set of 2% of all the orders

select 
TOP 2 PERCENT OrderID
from Orders

Order by NEWID()