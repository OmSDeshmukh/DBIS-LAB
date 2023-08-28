--Q1
SELECT professor.pname 
FROM professor, department
WHERE professor.dname = department.dname and department.numphds>50;

--Q2
SELECT student.sname
FROM student
WHERE student.gpa = (SELECT max(student.gpa) FROM student);

--Q3
SELECT course.cno,avg(student.gpa)
FROM course, enroll, student
WHERE student.sid = enroll.sid AND enroll.cno = course.cno AND  enroll.dname= course.dname AND  course.dname='Computer Sciences'
GROUP BY course.cno;

--Q4
WITH T(sid,sname,ce) AS
    (SELECT student.sid, student.sname, count(enroll.sid) 
    FROM student, enroll
    WHERE student.sid = enroll.sid 
    GROUP BY enroll.sid,student.sid) 
SELECT student.sid, student.sname, T.ce AS number_of_courses_enrolled
FROM student, T
WHERE student.sid = T.sid AND T.ce =(SELECT max(T.ce) FROM T);


--Q5
WITH T(dname, count_of_prof) AS 
    (SELECT department.dname, count(professor.pname)
    FROM department, professor
    WHERE department.dname = professor.dname
    GROUP BY  department.dname)
SELECT T.dname
FROM T
WHERE T.count_of_prof=(SELECT max(T.count_of_prof) FROM T);

--Q6 
SELECT student.sname, major.dname
FROM student, major, enroll
WHERE student.sid = major.sid AND student.sid = enroll.sid AND enroll.cno = (SELECT course.cno FROM course WHERE course.cname='Thermodynamics');


--Q7
SELECT department.dname 
FROM department 
WHERE department.dname NOT IN(SELECT DISTINCT major.dname
FROM student, major, enroll
WHERE student.sid = major.sid AND student.sid = enroll.sid AND enroll.cno = (SELECT course.cno FROM course WHERE course.cname='Compiler Construction')
);


--Q8 no
(SELECT student.sname 
FROM student, enroll
WHERE student.sid = enroll.sid AND enroll.dname = 'Civil Engineering')
INTERSECT
(WITH T(sid, no_of_mcourses_enrolled) AS 
(SELECT student.sid , count(enroll.cno)
FROM student, enroll
WHERE student.sid = enroll.sid AND enroll.dname = 'Mathematics'
GROUP BY student.sid) 
SELECT student.sname
FROM student, T
WHERE student.sid = T.sid AND T.no_of_mcourses_enrolled < 3);


--Q9
SELECT avg(student.gpa), department.dname
FROM student, department, major 
WHERE student.sid = major.sid AND department.dname = major.dname AND department.dname IN (
    SELECT department.dname
    FROM student, department, major
    WHERE student.sid = major.sid AND department.dname = major.dname AND student.gpa<1.5
    GROUP BY department.dname)
GROUP BY department.dname;

--Q10
WITH T(sid, no_of_cecourses_enrolled) AS 
(SELECT student.sid , count(enroll.cno)
FROM student, enroll
WHERE student.sid = enroll.sid AND enroll.dname = 'Civil Engineering'
GROUP BY student.sid) 
SELECT student.sname
FROM student, T
WHERE student.sid = T.sid AND T.no_of_cecourses_enrolled = (SELECT count(course.cno)
    FROM course
    WHERE course.dname = 'Civil Engineering');

