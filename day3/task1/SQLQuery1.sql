use Company_SD

-------
SELECT d.Dnum, d.Dname, d.MGRSSN, e.Fname+' '+e.Lname AS manager_name
from Departments d 
inner join employee e  on d.MGRSSN = SSN


-----------
select d.Dname , p.pname 
from Departments d
inner join project p on d.Dnum = P.Dnum

-------

select d.* , e.Fname
from Dependent d inner join Employee e
on e.SSN = d.ESSN

-------
select pnumber , pname , plocation
from project
where city in ('cairo' , 'alex')

-------
select *
from Project
where pname like 'a%'

-------
select * 
from Employee
where Dno = 30 and Salary between 1000 and 2000

--------
select  Fname + ' ' + Lname as 'full name' from Employee
inner join Works_for on Hours>=10
inner join Project on Pname='AL Rabwah'
where Dno=10

-------
select e.Fname 
from employee e, Employee s
where e.SSN = s.Superssn and  S.Fname = 'Kamel' and S.Lname = 'Mohamed'

---------
select  Fname + ' ' + Lname as 'full same'
from Employee e inner join Project P
on e.Dno =P.Dnum order by Pname 

---------

select p.Pnumber , d.Dname, e.Lname, e.Bdate, e.Address
from project p 
inner join departments d
on p.city ='cairo' and d.dnum=p.dnum
inner join employee e
on e.SSN=d.MGRSSN 

--------------
select *
from Employee e left outer join Dependent d
on d.ESSN = e.SSN
--------------

select *
from employee e
left outer join dependent d
on d.ESSN=e.SSN

----------------
 insert into Employee 
values('marwa','mohamed',102672,'23/10/1999','zagazig','F',3000,112233,30)

---------------
insert into Employee (Fname,Lname,SSN,Bdate,Address,Sex,Dno)
  values('marwa','taha',603141,'15/6/1998','cairo','F',25)

  ------------
update Employee
set Salary+=Salary*.2
where SSN = 102672







