USE ITI

CREATE NONCLUSTERED INDEX I
ON Course(Crs_Name)



DECLARE C1 CURSOR
FOR SELECT St_Id, St_Fname  
	FROM Student 
	WHERE St_Address = 'cairo'
FOR READ ONLY

DECLARE @id INT, @name VARCHAR(50)
OPEN C1
FETCH C1 INTO @id, @name
WHILE @@FETCH_STATUS = 0
	BEGIN
		SELECT @id, @name
		FETCH C1 INTO @id, @name
	END
CLOSE C1
DEALLOCATE C1








DECLARE C2 CURSOR
FOR SELECT DISTINCT St_Fname
	FROM Student
	WHERE St_Fname IS NOT NULL 

FOR READ ONLY

DECLARE @Fname VARCHAR(50), @Stringresult VARCHAR(255) =''
OPEN C2
FETCH C2 INTO @Fname
WHILE @@FETCH_STATUS=0
	BEGIN
	SET @Stringresult = CONCAT(@Stringresult, ', ', @Fname ) 
	FETCH C2 INTO @Fname
	END
SELECT @Stringresult
CLOSE C2
DEALLOCATE C2


 

DECLARE c3 CURSOR
FOR SELECT Salary FROM dbo.Instructor
FOR UPDATE
DECLARE @sal INT
OPEN c3
FETCH c3 INTO @sal
WHILE @@FETCH_STATUS=0
	BEGIN
	IF @sal >= 3000
		UPDATE dbo.Instructor SET Salary = @sal * 1.20
		where current of c3
	ELSE IF @sal <3000
		UPDATE dbo.Instructor SET Salary = @sal * 1.10
		where current of c3
	ELSE
		DELETE FROM dbo.Instructor
		where current of c3

	FETCH c3 INTO @sal
	END
CLOSE c3
DEALLOCATE c3




DECLARE C4 CURSOR

FOR SELECT St_fname, lead(St_Fname) OVER( ORDER BY St_Id) FROM Student 
FOR UPDATE

DECLARE @name1 VARCHAR(50), @name2 VARCHAR(50), @counter INT
OPEN C4
FETCH C4  INTO @name2, @name2
WHILE @@FETCH_STATUS=0
	BEGIN
		IF @name1 = 'Ahmed' AND @name2='Amr'
			SET @counter += 1
		FETCH C4  INTO @name2, @name2
	END
SELECT @counter
CLOSE C4
DEALLOCATE C4
































































































































































































