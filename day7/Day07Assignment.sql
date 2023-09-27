USE ITI

-- 1-- Create a view that displays student full name, course name if the student has a grade more than 50. 
CREATE VIEW StudCourceGradeMoreThan50 ([Student Full Name], [Course Name])
WITH encryption 
as
SELECT CONCAT(S.St_Fname, ' ', S.St_Lname), C.Crs_Name
FROM dbo.Student S INNER JOIN dbo.Stud_Course SC
	ON S.St_Id = SC.St_Id
	INNER JOIN dbo.Course C
	ON C.Crs_Id = SC.Crs_Id
WHERE SC.Grade >= 50
WITH check OPTION


SELECT * FROM StudCourceGradeMoreThan50

-----------------------------------------------------------------------------------------------------------

-- 2 -- Create an Encrypted view that displays manager names and the topics they teach. 

CREATE VIEW ManagerTopics ([Manager Names], Topics)
WITH encryption 
AS
SELECT I.Ins_Name, T.Top_Name
FROM dbo.Department D INNER JOIN dbo.Instructor I
	ON D.Dept_Manager = I.Ins_Id
	INNER JOIN dbo.Ins_Course IC
	ON IC.Ins_Id = I.Ins_Id
	INNER JOIN dbo.Course C
	ON C.Crs_Id = IC.Crs_Id
	INNER JOIN dbo.Topic T
	ON T.Top_Id = C.Top_Id


sp_helptext ManagerTopics


-----------------------------------------------------------------------------------------------------------

-- 3 -- Create a view that will display Instructor Name, Department Name for the ‘SD’ or ‘Java’ Department 

CREATE VIEW InsNameAndDeptNameSDORJava ([Instructor Name], [Department Name])
WITH encryption
as
SELECT I.Ins_Name, D.Dept_Name
FROM dbo.Department D INNER JOIN dbo.Instructor I
	ON I.Dept_Id = D.Dept_Id
	WHERE D.Dept_Name in ('SD' , 'Java')
	WITH CHECK option


SELECT * FROM InsNameAndDeptNameSDORJava



-----------------------------------------------------------------------------------------------------------

-- 4 -- Create a view “V1” that displays student data for student who lives in Alex or Cairo. 
				--Note: Prevent the users to run the following query 
				--Update V1 set st_address=’tanta’
				--Where st_address=’alex’;

create VIEW V1
WITH encryption
as
	SELECT S.* 
	FROM dbo.Student S
WHERE S.St_Address IN ('Alex', 'Cairo')
WITH CHECK option
SELECT * FROM V1

Update V1 set st_address='tanta'
Where st_address='alex'



-----------------------------------------------------------------------------------------------------------

-- 5 -- Create a view that will display the project name and the number of employees work on it. “Use Company DB”

USE Company_SD
CREATE VIEW ProjectNameAndNumberOfEmployees([Project Name], [Number Of Employees Work on it])
WITH encryption 
as
SELECT P.Pname, COUNT(E.SSN)
FROM Employee E INNER JOIN dbo.Works_for WF
	ON E.SSN = WF.ESSn
	INNER JOIN dbo.Project P
	ON P.Pnumber = WF.Pno
	GROUP BY P.Pname
WITH CHECK option


SELECT * FROM ProjectNameAndNumberOfEmployees



-----------------------------------------------------------------------------------------------------------

-- 6 -- 	Create the following schema and transfer the following tables to it 
					-- a -- Company Schema 
						--i.	Department table (Programmatically)
						--ii.	Project table (by wizard)
					-- b -- Human Resource Schema
						--i.	  Employee table (Programmatically)

-- a --
CREATE SCHEMA [Company Schema ]

ALTER SCHEMA [Company Schema ] TRANSFER dbo.Departments
--ALTER SCHEMA [Company Schema ] TRANSFER dbo.Project

-----------

-- b --

CREATE SCHEMA [Human Resource Schema]

ALTER SCHEMA [Human Resource Schema] TRANSFER dbo.Employee


-----------------------------------------------------------------------------------------------------------

-- 7 -- Create index on column (manager_Hiredate) that allow u to cluster the data in table Department. What will happen?  - Use ITI DB
CREATE CLUSTERED INDEX Dept_Clustered
ON dbo.Department(Manager_hiredate)

-- Cannot create more than one clustered index on table 'dbo.Department'
-- because it have PK and by default have clustered index 




-----------------------------------------------------------------------------------------------------------

-- 8

CREATE UNIQUE INDEX UniqAges
ON Student(St_Age) 

-- this query will terminated
--	because Student has column called St_Age and contain dublicated values (21) 




-----------------------------------------------------------------------------------------------------------

-- 9 -- Create a cursor for Employee table that increases Employee 
--		salary by 10% if Salary <3000 and increases it by 20% if Salary >=3000. Use company DB

USE Company_SD

DECLARE C1 CURSOR
FOR SELECT Salary  FROM dbo.Employee 
FOR UPDATE
DECLARE @sal INT
OPEN C1
FETCH C1 INTO @sal
WHILE @@FETCH_STATUS=0
	BEGIN
		IF @sal  <3000
			UPDATE dbo.Employee
				SET Salary = @sal * 1.10
			WHERE current of c1
		ELSE IF @sal >= 3000
			UPDATE dbo.Employee
				SET Salary = @sal * 1.20
			WHERE current of c1

	FETCH C1 INTO @sal
	END
CLOSE C1
DEALLOCATE C1







-----------------------------------------------------------------------------------------------------------

-- 10 -- Display Department name with its manager name using cursor. Use ITI DB

DECLARE C2 CURSOR
FOR SELECT I.Ins_Name, D.Dept_Name
	FROM dbo.Instructor i INNER JOIN dbo.Department D
		ON i.Ins_Id = D.Dept_Manager 

FOR READ ONLY
DECLARE @Ins_name VARCHAR(50), @Dept_name VARCHAR(50)
OPEN C2
FETCH C2 INTO @Ins_name, @Dept_name
WHILE @@FETCH_STATUS=0
	BEGIN
		SELECT @Ins_name, @Dept_name
		FETCH C2 INTO @Ins_name, @Dept_name
	END
SELECT @Ins_name, @Dept_name
CLOSE C2
DEALLOCATE C2




-----------------------------------------------------------------------------------------------------------

-- 10 --  Try to display all instructor names in one cell separated by comma. Using Cursor . Use ITI DB

DECLARE C3 CURSOR
FOR SELECT Ins_Name
	FROM dbo.Instructor 
FOR READ ONLY
DECLARE @name VARCHAR(50), @string VARCHAR(50)=''
OPEN C3
FETCH C3 INTO @name
WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @string = CONCAT(@string, ', ', @name)
	FETCH C3 INTO @name
	END
SELECT @string
CLOSE C3
DEALLOCATE C3














