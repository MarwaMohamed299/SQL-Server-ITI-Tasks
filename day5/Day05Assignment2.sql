use AdventureWorks2012


-- 1
select S.SalesOrderID, S.ShipDate
from Sales.SalesOrderHeader as S
where S.OrderDate  between '7/28/2002' and  '7/29/2014'

-- 2
select P.ProductID ,p.Name
from Production.Product P
where P.StandardCost < 110.00


-- 3
select P.ProductID ,p.Name
from Production.Product P
where P.Weight is  null 


-- 4
select P.*
from Production.Product P
where P.Color in ('Silver', 'Black', 'Red');

-- 5

select P.*
from Production.Product P
where P.Name like '[B]%'


-- 6 **
update Production.ProductDescription
	set Description = 'Chromoly steel_High of defects'
	where ProductDescriptionID = 3

select *
from Production.ProductDescription P
where p.Description like '%[_]%'


-- 7 
select sum(S.TotalDue) as TotalDue , S.OrderDate
from Sales.SalesOrderHeader as S
where S.OrderDate  between '7/28/2002' and  '7/29/2014'
group by S.OrderDate 



-- 8 
select distinct E.BirthDate
from HumanResources.Employee E


-- 9
select AVG(DISTINCT P.ListPrice)
from Production.Product P



-- 10
select concat('The' , P.Name , 'is only!' , P.ListPrice) 
from Production.Product P
where P.ListPrice between 100 and 120
order by P.ListPrice



-- 11

 --a)
	select rowguid, Name, SalesPersonID, Demographics into [sales.Store Archive]
	from Sales.Store

	select * from [sales.Store Archive]

-- b)
	select rowguid, Name, SalesPersonID, Demographics into [sales.Store Archive]
	from Sales.Store
	where 1 = 2



-- 12
SELECT
  CONVERT(date, GETDATE()) AS "Date",
  FORMAT(GETDATE(), 'yyyy-MM-dd') AS "YYYY-MM-DD",
  FORMAT(GETDATE(), 'MM/dd/yyyy') AS "MM/dd/yyyy",
  FORMAT(GETDATE(), 'dd-MM-yyyy') AS "dd-MM-yyyy"











