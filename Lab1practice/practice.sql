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

--Q4 no
SELECT student.sid, student.sname, count(enroll.sid) 
FROM student, enroll
WHERE student.sid = enroll.sid 
GROUP BY enroll.sid,student.sid
ORDER BY count(enroll.sid) DESC;

--Q5 no
SELECT department.dname, count(professor.pname)
FROM department, professor
WHERE department.dname = professor.dname
GROUP BY  professor.pname,department.dname;

--Q6 
SELECT student.sname, major.dname
FROM student, course, major
WHERE student.sid = major.sid AND major.dname= course.dname AND course.cname = 'Thermodynamics';

--Q7 no
SELECT course.dname
FROM major, course,  student, enroll
WHERE course.dname = major.dname AND student.sid=enroll.sid AND enroll.cno = course.cno AND enroll.dname = course.dname AND enroll.cno = (SELECT course.cno FROM )
GROUP BY course.dname;

--Q8 no
SELECT student.sname, course.cname
FROM student, enroll, course 
WHERE student.sid = enroll.sid AND course.cno = enroll.cno AND enroll.dname = course.dname AND 

--Q9
SELECT avg(student.gpa), department.dname
FROM student, department, major 
WHERE student.sid = major.sid AND department.dname = major.dname AND department.dname IN (SELECT department.dname
FROM student, department, major
WHERE student.sid = major.sid AND department.dname = major.dname AND student.gpa<1.5
GROUP BY department.dname)
GROUP BY department.dname;

--Q10
SELECT student.sid, student.sname, student.gpa, course.cname
FROM student, enroll, course
WHERE student.sid = enroll.sid AND enroll.cno=course.cno AND course.dname= enroll.dname AND course.dname = 'Civil Engineering'
GROUP BY student.sid

SELECT  count(course.cname)
FROM student, enroll, course
WHERE student.sid = enroll.sid AND enroll.cno=course.cno AND course.dname= enroll.dname AND course.dname = 'Civil Engineering'
GROUP BY student.sid;


