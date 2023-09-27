use Company_SD

-- 1-- 	Create a stored procedure without parameters to show the number of students per department name.[use ITI DB] 

create procedure StudentNumberInDepartment
with encryption
as
select  count(S.St_Id) 
from Student S inner join Department D
	on S.Dept_Id = D.Dept_Id
	group by D.Dept_Name 



StudentNumberInDepartment



--------------------------------------------------------------------------------------------------------------------------
-- 2-- 	Create a stored procedure that will check for the # of employees in the project p1 
		-- IF they are more than 3 print message to the user “'The number of employees in the project p1 is 3 or more'” 
		-- IF they are less display a message to the user “'The following employees work for the project p1'” 
		-- in addition to the first name and last name of each one. [Company DB] 


alter proc NumberOfEmployeeWorksForP1
with encryption
as
	begin
	declare @number int
	select @number=count(E.SSN)
	from [Human Resource Schema].Employee E inner join Works_for W
		on E.SSN = W.ESSn
		inner join [Company Schema ].Project P
		on P.Pnumber = W.Pno
		where P.Pname = 'AL Solimaniah'
		group by P.Pname
	
	if @number > 3
		SELECT 'The number of employees in  AL Solimaniah is 3 OR more'
	else
		SELECT 'The Following Employees Work For The Project AL Solimaniah: '
		select E.Fname, E.Lname
		from [Human Resource Schema].Employee E inner join Works_for W
			on E.SSN = W.ESSn
			inner join [Company Schema ].Project P
			on P.Pnumber = W.Pno
			where P.Pname = 'AL Solimaniah'
			
	end



NumberOfEmployeeWorksForP1



--------------------------------------------------------------------------------------------------------------------------
-- 3 --    Create a stored procedure that will be used in case there is an old employee has left the project and a new one become instead of him.
			-- The procedure should take 3 parameters 
			-- (old Emp. number, new Emp. number and the project number) and it will be used to update works_on table. [Company DB]


create proc UpdateWorksTable @old_Emp int, @new_Emp int, @proj_No int
with encryption
as
	update Works_for
		set ESSn = @new_Emp 
		where ESSn=@old_Emp and Pno = @proj_No 


UpdateWorksTable  101020, 191910, 100




--------------------------------------------------------------------------------------------------------------------------
-- 4 --	add column budget in project table and insert any draft values in it then 
			--then Create an Audit table with the following structure 

			-- ProjectNo 	UserName 	ModifiedDate 	Budget_Old 	Budget_New 
			-- p2 	Dbo 	2008-01-31	95000 	200000 

			-- This table will be used to audit the update trials on the Budget column (Project table, Company DB)
			--Example:
			--If a user updated the budget column then the project number, user name that made that update, 
			--the date of the modification and the value of the old and the new budget will be inserted into the Audit table
			--Note: This process will take place only if the user updated the budget column


alter table [Company Schema ].Project add  budget int

create table [Audit] 
(
ProjectNo int,
[User name] varchar(50),
[Modified Date] date,
[Budget old] int,
[Budget New] int
)

create trigger WhenBudgetColumnUpdated
on [Company Schema ].Project
after update
as
	declare @projectNo int, @old_budget int, @new_budget int

	if UPDATE(budget)
	begin
		select @projectNo = (select Pnumber from deleted)	
		select @old_budget= (select budget from deleted)
		select @new_budget= (select budget from inserted)
		insert into [Audit] 
		values(@projectNo, SUSER_NAME(), GETDATE(), @old_budget, @new_budget)
	end

update [Company Schema ].Project
	set budget = 120120
	where Pnumber =100



--------------------------------------------------------------------------------------------------------------------------
-- 5 -- 	Create a trigger to prevent anyone from inserting a new record in the Department table [ITI DB]
			-- “Print a message for user to tell him that he can’t insert a new record in that table”


create trigger PreventAnyoneFromInsertingOnDepartment
on Department
instead of insert 
as
	select 'can’t insert a new record in that Department'
	
	


insert into Department(Dept_Id, Dept_Name, Dept_Desc, Dept_Location) values (80, 'AI', 'Artificial Intiligence', 'Cairo')



--------------------------------------------------------------------------------------------------------------------------
-- 6 -- Create a trigger that prevents the insertion Process for Employee table in March [Company DB].


create trigger PreventsInsertionOnEmployeeInMarch 
on [Human Resource Schema].Employee
after insert
as
	if FORMAT(GETDATE(), 'MMMM') = 'March'
		begin
			select 'Sorry!!! You Can Not Make Any Insertion process On March!!!!!'
			delete from Employee where SSN = (select SSN from inserted)
		end

	else
		begin
			insert into Employee
			select * from inserted
		end
--------------------------------------------------------------------------------------------------------------------------
-- 7 -- 	Create a trigger on student table after insert to add Row in Student Audit table (Server User Name , Date, Note) 
			-- where note will be “[username] Insert New Row with Key=[Key Value] in table [table name]”
			-- Server User Name		Date    Note 

			

create table [Student Audit]
(
[Server User Name] varchar(255),
[Date] date,
[Note] varchar(255)
)

create trigger  StudentTableAfterInsert 
on Student
after insert
as
	 declare @key int
	 select @key = (select St_Id from inserted )
	 insert into [Student Audit]
	 values(@@SERVERNAME, GETDATE(), CONCAT(suser_name(), ' Insert New Row with Key= ', @key, ' in table Student.'))


insert into Student values(127, 'Div', 'Malan', 'Alex', 25, 30, 9)


--------------------------------------------------------------------------------------------------------------------------
-- 8 -- Create a trigger on student table instead of delete to add Row in Student Audit table 
		--(Server User Name, Date, Note) where note will be“ try to delete Row with Key=[Key Value]”

create trigger StudentTableInsteadDeleting
on Student
instead of delete
as
	 declare @key int
	 select @key = (select St_Id from deleted )
	 insert into [Student Audit]
	 values(@@SERVERNAME, GETDATE(), CONCAT(suser_name(), ' try to delete Row with Key = ', @key, ' in table Student.'))


delete from Student where St_Id = 1


