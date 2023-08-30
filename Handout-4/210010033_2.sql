--Q1 no
WITH T(sec_id, number_of_enrolled,course_id, semester, year) AS
(SELECT sec_id, count(sec_id),course_id, semester, year
FROM takes
GROUP BY sec_id,course_id, semester, year)
SELECT min(number_of_enrolled), max(number_of_enrolled),
FROM T;

--Q2
WITH T(sec_id, number_of_enrolled,course_id, semester, year) AS
(SELECT sec_id, count(sec_id),course_id, semester, year
FROM takes
GROUP BY sec_id,course_id, semester, year)
SELECT *
FROM takes, T
WHERE takes.sec_id = T.sec_id AND T.number_of_enrolled = (SELECT max(number_of_enrolled) FROM T);

--Q4
SELECT * 
FROM course
WHERE course.course_id LIKE 'CS-1%';

--Q5 NO
SELECT instructor.ID, instructor.name, teaches.course_id
FROM instructor, teaches
WHERE instructor.ID = teaches.ID AND teaches.course_id IN (SELECT course.course_id 
        FROM course
        WHERE course.course_id LIKE 'CS-1%');


--Q6 NO
INSERT INTO student (SELECT ID, name, dept_name, 0 FROM instructor);


--Q8
WITH M(id,number_of_sections_taught) AS
    (WITH T(id, sid) AS 
        (SELECT DISTINCT instructor.ID, teaches.sec_id
        FROM instructor, teaches
        WHERE instructor.ID = teaches.ID)
    SELECT instructor.ID, count(sid)
    FROM instructor, T
    WHERE instructor.ID = T.id
    GROUP BY instructor.ID)
(SELECT instructor.ID, 10000 * M.number_of_sections_taught AS new_salary
FROM instructor, M
WHERE instructor.ID = M.id)


WITH M(id,number_of_sections_taught) AS
    (WITH T(id, sid) AS 
        (SELECT DISTINCT instructor.ID, teaches.sec_id
        FROM instructor, teaches
        WHERE instructor.ID = teaches.ID)
    SELECT instructor.ID, count(sid)
    FROM instructor, T
    WHERE instructor.ID = T.id
    GROUP BY instructor.ID)
UPDATE instructor
SET salary = CASE
                WHEN (instructor.ID IN ('10001')) THEN salary + salary*M.number_of_sections_taught
                ELSE instructor.salary
                END 


--Q9
CREATE VIEW failure AS
SELECT *
FROM student NATURAL JOIN takes
WHERE takes.grade = 'F';


--Q10
