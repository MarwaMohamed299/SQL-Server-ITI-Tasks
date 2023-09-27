-- 10

SELECT * FROM new.Course
SELECT * FROM new.Student

INSERT INTO New.Course(Crs_Id, Crs_Name, Crs_Duration, Top_Id) VALUES (99, 'AI', 50, 1)
INSERT INTO New.Student(St_Id, St_Fname, St_Lname, St_Address, St_Age, Dept_Id, St_super) VALUES (0, 'Alioo', 'Mohh', 'Cairo', 24, 20, 1)


UPDATE New.Course
	SET Crs_Name = 'AI'
	WHERE Crs_Id = 99

DELETE FROM New.Course WHERE Crs_Id = 99


UPDATE New.Student
	SET St_Fname = 'Kaka'
	WHERE St_Id = 0

DELETE FROM New.Student WHERE St_Id= 0