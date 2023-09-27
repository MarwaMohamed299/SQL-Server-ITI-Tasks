USE ITI

-- 1
alter FUNCTION GetMonthName(@date date)
RETURNS NVARCHAR(50)
	BEGIN
		DECLARE @result NVARCHAR(50)
		select @result = FORMAT(eomonth(@date),'MMMM')
		RETURN @result
    END

DECLARE @d1 DATE = '2023-06-04';
SELECT dbo.GetMonthName(@d1)


---------------------------------------------------------------------------------------------

-- 2
CREATE FUNCTION GetValuesInBetween(@num1 int, @num2 int)
RETURNS @newTable TABLE
			(
				numbers int
			)
	AS
		BEGIN
			WHILE @num1 <= @num2
				BEGIN
					INSERT INTO @newtable(numbers) VALUES (@num1)
					SET @num1 += 1
				end
			RETURN
		END

SELECT * FROM GetValuesInBetween(5, 5)



---------------------------------------------------------------------------------------------

-- 3

CREATE FUNCTION GetStudFullDataAndDeptName(@St_num int)
RETURNS TABLE
AS
	RETURN
		(
			SELECT S.*, D.Dept_Name AS Dept_Name 
			FROM dbo.Student S INNER JOIN dbo.Department D
			on S.Dept_Id = D.Dept_Id
			WHERE S.St_Id = @St_num
		)

SELECT * FROM GetStudFullDataAndDeptName(1)



---------------------------------------------------------------------------------------------

-- 4

CREATE FUNCTION MessageToUser(@St_id int)
RETURNS VARCHAR(255)
AS
	BEGIN
		DECLARE @fname VARCHAR(50), @lname VARCHAR(50), @result VARCHAR(255)
		SELECT @fname=S.St_Fname, @lname=S.St_Lname 
		FROM dbo.Student S
		WHERE S.St_Id= @St_id

		IF  @fname IS  NULL  AND  @lname IS null
			SELECT	@result = 'First name & last name are null'
		
		ELSE IF @fname IS  NULL
			SELECT	@result = 'First name'
		
		ELSE IF @lname IS  NULL
			SELECT	@result = 'Last name'
		ELSE
			SELECT	@result = 'First name & last name are not null'

			RETURN @result
	END


SELECT dbo.MessageToUser(5)


---------------------------------------------------------------------------------------------

-- 5

CREATE FUNCTION GetManagerdata(@manger_id int)
RETURNS TABLE
AS
	RETURN
	(
		SELECT D.Dept_Name AS Dept_Name, I.Ins_Name AS Inst_Name, D.Manager_hiredate AS [Manger Hire Date]
		FROM dbo.Instructor I INNER JOIN dbo.Department D
		ON I.Ins_Id = D.Dept_Manager
		WHERE I.Ins_Id = @manger_id
	)


SELECT * FROM GetManagerdata(16)



---------------------------------------------------------------------------------------------

-- 6

CREATE FUNCTION GetStudentDate(@string varchar(50))
RETURNS @StudentData TABLE
		(
			St_Name varchar(255)	
		)
AS
    BEGIN
		IF @string = 'first name'
			INSERT INTO @StudentData 
			SELECT ISNULL(St_Fname, '') FROM dbo.Student
		
		ELSE IF @string = 'last name'
			INSERT INTO @StudentData 
			SELECT ISNULL(St_Lname, '') FROM dbo.Student
		
		ELSE IF @string = 'full name'
			INSERT INTO @StudentData 
			SELECT CONCAT( ISNULL(St_Fname, '') , ' ' , ISNULL(St_Lname, '')) FROM dbo.Student

	RETURN
	END

SELECT * FROM GetStudentDate('first name')
SELECT * FROM GetStudentDate('last name')
SELECT * FROM GetStudentDate('full name')


---------------------------------------------------------------------------------------------

-- 7   ********

SELECT St_Id,  LEFT(St_Fname, LEN(St_Fname)-1)
FROM dbo.Student



---------------------------------------------------------------------------------------------

-- 8


delete FROM dbo.Stud_Course
WHERE St_Id IN (
					SELECT S.St_Id
                    FROM dbo.Student S INNER JOIN dbo.Department D
					ON S.Dept_Id = D.Dept_Id
					WHERE D.Dept_Name = 'SD'
)




---------------------------------------------------------------------------------------------

-- 9

CREATE TABLE last_Transaction
(
	Xid INT PRIMARY KEY,
	transaction_amount int
)

CREATE TABLE Daily_Transaction
(
	Yid INT PRIMARY KEY,
	transaction_amount int
)

MERGE INTO dbo.last_Transaction AS T
USING dbo.Daily_Transaction AS S
ON T.Xid = S.Yid

WHEN MATCHED THEN 
	UPDATE
    SET T.transaction_amount = S.transaction_amount

WHEN NOT MATCHED THEN 
	INSERT
    VALUES(S.Yid, S.transaction_amount);


---------------------------------------------------------------------------------------------

-- 10
CREATE SCHEMA New

ALTER SCHEMA New TRANSFER dbo.Student
ALTER SCHEMA New TRANSFER dbo.Course

