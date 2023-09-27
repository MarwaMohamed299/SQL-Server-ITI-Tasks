use ITI

-- 1
select  count(St_Id)
from Student
where St_Age is not null


-- 2
select DISTINCT  Ins_Name
from Instructor


-- 3
select S.St_Id as [Student ID], ISNULL((s.St_Fname + ' ' + S.St_Lname), ' ') as [Student Full Name], D.Dept_Name as [Department Name]
from Student S inner join Department D
	on S.Dept_Id = D.Dept_Id


-- 4

select I.* , D.Dept_Name
from Instructor I left outer join Department D
	on I.Dept_Id = D.Dept_Id


--5

select (S.St_Fname + ' ' + S.St_Lname) as [Student Full Name], C.Crs_Name
from Student S inner join Stud_Course SC
on S.St_Id = Sc.St_Id
inner join Course C
on SC.Crs_Id = C.Crs_Id
where Sc.Grade is not null


-- 6
select count(C.Crs_Id) as [Number of Courses], T.Top_Name
from Course C inner join Topic T
	on C.Top_Id = T.Top_Id
group by T.Top_Name


-- 7
select Max(Salary) as [Max Salary] , Min(Salary) as [Min Salary]
	from Instructor


-- 8
select I.Ins_Name 
from Instructor I
where I.Salary <(select AVG(Salary) from Instructor)


-- 9


select D.Dept_Name
from Instructor I inner join Department D
	on I.Dept_Id = D.Dept_Id
where i.Salary  = (select min(Salary) from Instructor)


-- 10
select * 
from (select *, Row_number() over (order by Salary desc) as RN
		from Instructor ) asnewtable
where RN = 1


-- 11 
select I.Ins_Name,coalesce(cast(I.Salary as varchar), 'Bouns')
from Instructor I


-- 12
select Avg(Salary)
from Instructor


-- 13

select Y.St_Fname
from Student X inner join Student Y
	on X.St_Id = Y.St_super


-----
SELECT S.St_Fname
from Student S INNER JOIN Instructor I
ON S.St_super = I.Ins_Id


-- 14 
select * 
from (select I.Ins_Name, I.Salary, I.Dept_Id,  Dense_rank() over(partition by I.Dept_Id order by I.Salary desc) DR
		from Instructor I  where I.Salary is not null) as newtable
where DR >= 2;


-- 15 
select *
from 
(select *, row_number() over(partition by S.Dept_Id order by newid())  as RN
from Student S  inner join Department D
on D.Dept_Id =S.Dept_Id ) as newtable
where RN = 1;





