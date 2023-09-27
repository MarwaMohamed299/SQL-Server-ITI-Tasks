use Company_SD

select * from Employee
------

select Fname , Lname , Salary , Dno
from Employee 
----------

select Pname , Plocation ,Dname 
from Departments,Project
where Project.Dnum = Departments.Dnum
-----
select Fname + ' ' + Lname as 'fullname',
Salary*0.1 as "annual commision" 
from Employee 

--------
select Fname + ' ' + Lname as 'name' from Employee 
where salary > 1000 

----------
select Fname + ' ' + Lname as 'name' from Employee 
where salary *12 /10 >10000

-------

select Fname + ' ' + Lname as 'name' from Employee 
where sex = 'f'

-----------
select Dnum , Dname 
from Departments
where MGRSSN = 968574

---------------

select Pnumber , Pname , Plocation 
from Project
where Dnum=10



