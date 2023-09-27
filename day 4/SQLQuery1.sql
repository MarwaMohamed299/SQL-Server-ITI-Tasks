use Company_SD
----1.	Display (Using Union Function) The name and the gender of the dependence that's gender is Female and depending on Female Employee And the male dependence that depends on Male Employee.-----
select Fname +' '+Lname AS 'employee name', Dependent_name as 'dependent name'
from Employee e inner join Dependent d
on e.SSN=d.ESSN and e.Sex='f' and d.Sex='f'
union all
select Fname +' '+Lname AS 'employess name', Dependent_name as 'dependent name'
from Employee e Inner join Dependent d
on e.SSN=d.ESSN and e.Sex='m' and d.Sex='m';

----2. 	For each project, list the project name and the total hours per week (for all employees) spent on that project.---
select sum(w.Hours), p.Pname 
from Works_for w, Project p
where p.Pnumber = w.Pno
group by p.Pname, w.Pno

---3.	Display the data of the department which has the smallest employee ID over all employees' ID.----
select d.*
from Departments D
join Employee E on Dnum=Dno
where SSN = (
select min(SSN) from Employee
)

----4.	For each department, retrieve the department name and the maximum, minimum and average salary of its employees.--
select d.Dname, max(e.Salary) as [max salary],min(e.Salary) as [min salary],avg(ISNULL(e.Salary, 0)) as [avg salary]
from Departments d, Employee e
where d.Dnum = e.Dno
group by d.Dname

-----5.	List the full name of all managers who have no dependents.---
select*
from Employee e inner join Departments d
on e.SSN = d.MGRSSN
where e.SSN not in (select ESSN  from Dependent)

----6.	For each department-- if its average salary is less than the average salary of all employees-
--- display its number, name and number of its employees.
select  Dname as [Department name], Dnum as [Department number],AVG(Salary) as [Average salary], count(SSN) As [Count ssn] 
from Departments d inner join Employee e
on d.Dnum = e.Dno
group by  Dname, Dnum
having AVG(salary)<(select AVG(salary) from Employee)


--7.	Retrieve a list of employee’s names and the projects names they are working on ordered by department number and within each department
-- ordered alphabetically by last name, first name.
select fname+' '+lname as [full name] , Pname
from Employee 
join works_for on ESSn = SSN
join project on pno = pnumber
order by dno, fname, lname
--8.SELECT MAX(salary) AS max_salary--
select max (salary) as maxsalary
from employee
where salary < (select max(salary) from employee)
union
select max (salary) AS maxsalary
from employee
where salary = (select max(salary) from employee)

---9.	Get the full name of employees that is similar to any dependent name--
select distinct concat(e.fname, ' ', e.lname) AS full_name
from employee e
join dependent d ON e.ssn = d.essn
where d.dependent_name like concat ('%', e.fname, '%')
   or d.dependent_name like concat('%', e.lname, '%');
--10.	Display the employee number and name if at least one of them have dependents (use exists keyword) self-study.--
select ssn,fname+' '+lname as [Full name]
from employee
where  exists (select essn from Dependent where essn = ssn)

--11.	In the department table insert new department called "DEPT IT”, with id 100, employee with SSN = 112233 as a manager for this department.
--The start date for this manager is '1-11-2006'---

insert into Departments(Dnum,Dname, MGRSSN,[MGRStart Date]) values(100,'DEPT IT',112233,'2006-11-1') 

---12.---Do what is required if you know that : Mrs.Noha Mohamed(SSN=968574)  moved to be the manager of the new department (id = 100), and they give you(your SSN =102672) her position (Dept. 20 manager) --

--a.	First try to update her record in the department table--
update departments set MGRSSN = 968574 where Dnum = 100
--b.	Update your record to be department 20 manager.--
update Departments set MGRSSN = 102672 where Dnum = 20
--c.	Update the data of employee number=102660 to be in your teamwork (he will be supervised by you) (your SSN =102672)--
update Employee set Superssn = 102672, Dno = 20 where SSN = 102660

---13.1	Unfortunately the company ended the contract with Mr. Kamel Mohamed (SSN=223344) so try to delete his data from your database in case you know that you will be temporarily in his position.
--Hint: (Check if Mr. Kamel has dependents, works as a department manager, supervises any employees --
begin try
	begin transaction
		delete from Dependent where ESSN = 223344
		Update Departments set MGRSSN = 102672 where MGRSSN = 223344
		update Employee set Superssn = 102672 where Superssn = 223344
		update Works_for set ESSn = 102672 where ESSn = 223344
		delete from Employee where SSN = 223344
	commit
end try
begin catch
	rollback
end catch

---14.	Try to update all salaries of employees who work in Project ‘Al Rabwah’ by 30%--
update employee
set Salary = Salary*1.3
from Employee
join works_for on ssn=essn
join Project on Pno=Pnumber
Where Pname ='Al Rabwah' 

