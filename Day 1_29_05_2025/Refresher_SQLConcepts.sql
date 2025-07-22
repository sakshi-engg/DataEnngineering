CREATE database AdvanceTraining;
USE AdvanceTraining;
CREATE TABLE students (
id INT PRIMARY KEY,
name VARCHAR (50),
grade VARCHAR(10),
admission_date date,
mobile_no INT
);
 
SELECT * FROM students;

INSERT INTO students (id ,name ,grade,admission_date, mobile_no)
VALUES
(1,'Alice','A','2023-06-01', 923524),
(2,'ram','b','2023-06-01', 97347),
(3,'shyam','c','2023-06-01', 97327);
 
UPDATE students
SET grade = 'A+'
WHERE name = 'ram';
 
set SQL_SAFE_UPDATES=0;
 
SELECT * FROM students;
 
SELECT  * FROM students
ORDER BY name DESC;
 
SELECT TOP 2 * FROM students; --SELECT * FROM students LIMIT 2;

select distinct grade from students;

------------------Filtering Columns using Having Clause-----------
SELECT 
    grade, 
    COUNT(*) AS num_students
FROM 
    students
GROUP BY 
    grade
HAVING 
    COUNT(*) > 0;
--Group By students based on grades 


--------------CASE Statement----
SELECT 
    id,
    grade,
    CASE 
        WHEN grade IN ('A', 'B', 'C') THEN 'Passed'
        WHEN grade IN ('E', 'F', 'G') THEN 'Failed'
        ELSE 'Unknown'
    END AS result
FROM 
    students;


--Task Add 3 Columns & Rank students

ALTER TABLE students
ADD 
    marks INT,
    subject VARCHAR(50),
    rank INT;

UPDATE students
SET 
    marks = CASE 
        WHEN name = 'Alice' THEN 90
        WHEN name = 'ram' THEN 85
        WHEN name = 'shyam' THEN 78
        ELSE NULL
    END,
    subject = CASE 
        WHEN name = 'Alice' THEN 'Mathematics'
        WHEN name = 'ram' THEN 'Science'
        WHEN name = 'shyam' THEN 'History'
        ELSE NULL
    END;

	SELECT * FROM students;

	---Rank() function to rank students
	select
id,
  name,
  marks,
  subject,
  RANK() over (partition by name order by marks desc) as
  rank_in_marks
  from students;

  ----CTE 
 -- With student as(
--Select * from students where marks > 90 
--)
--SELECT marks, name, grade from students;


