--Q1
WITH T(sec_id, number_of_enrolled,course_id, semester, year) AS
    (SELECT sec_id, count(sec_id),course_id, semester, year
    FROM takes
    GROUP BY sec_id,course_id, semester, year)
SELECT min(number_of_enrolled), max(number_of_enrolled)
FROM T;


--Q2
WITH T(sec_id, number_of_enrolled,course_id, semester, year) AS
(SELECT sec_id, count(sec_id),course_id, semester, year
FROM takes
GROUP BY sec_id,course_id, semester, year)
SELECT *
FROM T
WHERE T.number_of_enrolled = (SELECT max(number_of_enrolled) FROM T);


--Q3
--a
(SELECT sec_id, count(sec_id),course_id, semester, year
FROM takes
GROUP BY sec_id,course_id, semester, year)
UNION
(SELECT sec_id, 0, course_id, semester, year
FROM section
WHERE (section.sec_id, section.course_id, section.semester, section.year) NOT IN 
(SELECT takes.sec_id, takes.course_id, takes.semester, takes.year FROM takes));

--b
SELECT section.sec_id, count(takes.sec_id), section.course_id, section.semester, section.year
FROM section NATURAL LEFT OUTER JOIN takes
GROUP BY section.sec_id, section.course_id, section.semester, section.year;


--Q4
SELECT * 
FROM course
WHERE course.course_id LIKE 'CS-1%';


--Q5 
--part A
SELECT i.ID, i.name
FROM instructor AS i
WHERE NOT EXISTS(
    (SELECT course.course_id 
    FROM course
    WHERE course.course_id LIKE 'CS-1%')
    EXCEPT(
        SELECT teaches.course_id
        FROM teaches, instructor as ins
        WHERE teaches.ID = ins.ID AND i.ID = ins.ID));

--part B
WITH C(course_id) AS 
    (SELECT course.course_id 
    FROM course
    WHERE course.course_id LIKE 'CS-1%'),
    T(ID, num) AS 
    (SELECT instructor.ID, count(DISTINCT teaches.course_id) 
    FROM instructor, teaches
    WHERE instructor.ID = teaches.ID AND teaches.course_id IN (SELECT course_id FROM C)
    GROUP BY instructor.ID)
SELECT instructor.ID, instructor.name
FROM instructor, T
WHERE instructor.ID = T.ID AND T.num =(SELECT count(course_id) FROM C);



--Q6 NO
INSERT INTO student (SELECT ID, name, dept_name, 0 FROM instructor);
-- ERROR:  duplicate key value violates unique constraint "student_pkey"
-- DETAIL:  Key (id)=(76543) already exists.

--Q7
DELETE 
FROM student
WHERE student.ID IN (SELECT instructor.ID FROM instructor);


--Q8
WITH M(id,number_of_sections_taught) AS(
    SELECT instructor.ID, count(instructor.ID)
    FROM instructor ,teaches, section
    WHERE instructor.ID = teaches.ID AND teaches.sec_id = section.sec_id AND teaches.year = section.year AND teaches.course_id = section.course_id AND teaches.semester = section.semester
    GROUP BY instructor.ID)
UPDATE instructor
SET salary = CASE
                WHEN EXISTS (SELECT 1 FROM M WHERE instructor.ID = M.id) THEN  10000 * (SELECT M.number_of_sections_taught FROM M WHERE instructor.ID = M.id)
                ELSE instructor.salary
                END 

-- ERROR:  new row for relation "instructor" violates check constraint "instructor_salary_check"
-- DETAIL:  Failing row contains (12121, Wu, Finance, 10000.00).


--Q9
CREATE VIEW failure AS
SELECT *
FROM student NATURAL JOIN takes
WHERE takes.grade = 'F';


--Q10
WITH T(ID, number_of_failed) AS 
    (SELECT ID, count(ID)
    FROM failure
    GROUP BY ID)
SELECT T.ID, T.number_of_failed
FROM T
WHERE T.number_of_failed>=2;


--Q11
CREATE TABLE Grade_mapping(
    grade VARCHAR(2),
    points NUMERIC(4,0),
    PRIMARY KEY(grade)

);

INSERT INTO  Grade_mapping VALUES('A',10);
INSERT INTO  Grade_mapping VALUES('A+',10);
INSERT INTO  Grade_mapping VALUES('A-',10);
INSERT INTO  Grade_mapping VALUES('B',8);
INSERT INTO  Grade_mapping VALUES('B+',8);
INSERT INTO  Grade_mapping VALUES('B-',8);
INSERT INTO  Grade_mapping VALUES('C',6);
INSERT INTO  Grade_mapping VALUES('C+',6);
INSERT INTO  Grade_mapping VALUES('C-',6);
INSERT INTO  Grade_mapping VALUES('D',4);
INSERT INTO  Grade_mapping VALUES('D+',4);
INSERT INTO  Grade_mapping VALUES('D-',4);
INSERT INTO  Grade_mapping VALUES('F',0);
INSERT INTO  Grade_mapping VALUES('F+',0);
INSERT INTO  Grade_mapping VALUES('F-',0);


--Q12
SELECT student.ID, avg(Grade_mapping.points)
FROM student, takes, Grade_mapping
WHERE student.ID = takes.ID AND takes.grade = Grade_mapping.grade
GROUP BY student.ID;


--Q13 
SELECT DISTINCT room_number
FROM  section
GROUP BY building, room_number,time_slot_id
HAVING count(sec_id) >=2;


--Q14
CREATE VIEW FACULTY AS
SELECT ID, name, dept_name
FROM instructor;

--Q15
CREATE VIEW CSinsturctors AS 
SELECT * 
FROM instructor
WHERE instructor.dept_name = 'Comp. Sci.';

--Q16
INSERT INTO faculty VALUES(15151 , 'Adi',  'Biology');
-- ERROR:  duplicate key value violates unique constraint "instructor_pkey"
-- DETAIL:  Key (id)=(15151) already exists.

INSERT INTO faculty VALUES(12122 , 'Wu','Finance');
-- INSERT 0 1

INSERT INTO CSinsturctors VALUES(45566 ,'ZENDAYA' ,'Comp. Sci.', 35000.00);
-- INSERT 0 1

INSERT INTO CSinsturctors VALUES(45567 ,'Arjum' ,'Computer Science', 35000.00);
-- ERROR:  insert or update on table "instructor" violates foreign key constraint "instructor_dept_name_fkey"
-- DETAIL:  Key (dept_name)=(Computer Science) is not present in table "department".


--Q17
CREATE USER Om;
GRANT SELECT ON student TO Om;