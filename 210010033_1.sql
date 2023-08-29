--Q1
SELECT professor.pname 
FROM professor, department
WHERE professor.dname = department.dname and department.numphds<50;

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
SELECT student.sid, student.sname
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
FROM student, major, enroll, course
WHERE student.sid = major.sid AND student.sid = enroll.sid AND enroll.cno = course.cno AND enroll.dname = course.dname AND course.cname = 'Thermodynamics';


--Q7
SELECT department.dname 
FROM department 
WHERE department.dname NOT IN(SELECT DISTINCT major.dname
FROM student, major, enroll
WHERE student.sid = major.sid AND student.sid = enroll.sid AND enroll.cno = (SELECT course.cno FROM course WHERE course.cname='Compiler Construction')
);


--Q8
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
SELECT student.sname, student.gpa
FROM student, T
WHERE student.sid = T.sid AND T.no_of_cecourses_enrolled = (SELECT count(course.cno)
    FROM course
    WHERE course.dname = 'Civil Engineering');



--PART 2 


--Q4
SELECT Customer.CUST_NAME
FROM Customer
WHERE Customer.GRADE=2;

--Q5
SELECT Orders.ORD_NUM, Orders.ORD_DATE, Orders.ORD_DESCRIPTION
FROM Orders
ORDER BY Orders.ORD_DATE ASC;

--Q6
SELECT Orders.ORD_NUM, Orders.ORD_DATE, Orders.ORD_AMOUNT
FROM Orders
WHERE Orders.ORD_AMOUNT>=800
ORDER BY Orders.ORD_AMOUNT DESC;

--Q7
SELECT *
FROM Customer
ORDER BY WORKING_AREA, Customer.CUST_NAME DESC;

--Q8
SELECT Customer.CUST_NAME
FROM Customer
WHERE Customer.CUST_NAME LIKE'S%';

--Q9
SELECT Orders.ORD_NUM
FROM Orders
WHERE EXTRACT(MONTH FROM Orders.ORD_DATE)='03' AND  EXTRACT(YEAR FROM Orders.ORD_DATE)='2008'; 

--Q10
SELECT ORD_AMOUNT*1.1 AS amount
FROM orders;

--Q11
SELECT ORD_AMOUNT,(ORD_AMOUNT-ADVANCE_AMOUNT) as Balance
FROM Orders
WHERE ORD_AMOUNT BETWEEN 2000 and 4000;

--Q12
SELECT  DISTINCT Orders.CUST_CODE, Orders.ORD_NUM, Orders.ORD_AMOUNT
FROM Customer, Orders
WHERE Orders.ORD_AMOUNT IN (SELECT Orders.ORD_AMOUNT FROM Orders WHERE Orders.CUST_CODE = 'C00022');

--Q13
SELECT Agents.AGENT_NAME, Agents.AGENT_CODE
FROM Agents
WHERE Agents.COMMISSION > (SELECT max(Agents.COMMISSION) FROM Agents WHERE Agents.WORKING_AREA = 'Bangalore');

--Q14
SELECT Agents.AGENT_NAME, Agents.AGENT_CODE
FROM Agents
WHERE Agents.COMMISSION > (SELECT min(Agents.COMMISSION) FROM Agents WHERE Agents.WORKING_AREA = 'Bangalore');

--Q15
SELECT  Agents.AGENT_CODE 
FROM Agents
WHERE AGENT_CODE IN (SELECT Orders.AGENT_CODE FROM Orders); 

--Q16
SELECT Customer.CUST_NAME
FROM Customer
WHERE Customer.CUST_CODE NOT IN (SELECT Orders.CUST_CODE FROM Orders);

--Q17
SELECT DISTINCT Agents.AGENT_CODE 
FROM Agents, Orders
WHERE Agents.AGENT_CODE = Orders.AGENT_CODE AND Orders.ORD_AMOUNT > 800;

--Q18
SELECT DISTINCT Agents.AGENT_NAME 
FROM Agents, Orders
WHERE Agents.AGENT_CODE = Orders.AGENT_CODE AND Orders.ORD_AMOUNT > 800;

--Q19
SELECT Customer.CUST_NAME, Customer.CUST_CODE
FROM Customer 
WHERE Customer.CUST_CITY IN ( 'Paris', 'New York', 'Bangalore');

--Q20
SELECT Agents.AGENT_CODE
FROM Agents, Orders
WHERE Agents.AGENT_CODE = Orders.AGENT_CODE AND Orders.ORD_AMOUNT = 1000;

--Q21
SELECT sum(ORD_AMOUNT), avg(ORD_AMOUNT), min(ORD_AMOUNT), max(ORD_AMOUNT)
FROM Orders;

--Q22
SELECT count(CUST_CODE)
FROM Customer
WHERE CUST_CITY = 'New York';

--Q23
WITH N(amounts) AS (SELECT ORD_AMOUNT
    FROM Orders
    GROUP BY ORD_AMOUNT)
SELECT count(amounts)
FROM N;

--Q24
WITH C(code, ct) AS (SELECT AGENT_CODE, count(AGENT_CODE)
    FROM Orders
    GROUP BY Orders.AGENT_CODE)
SELECT Agents.AGENT_NAME, Agents.AGENT_CODE
FROM Agents, C
WHERE Agents.AGENT_CODE = C.code AND C.ct >= 2;

--Q25
SELECT Agents.WORKING_AREA, count(Agents.AGENT_CODE)
FROM Agents
GROUP BY Agents.WORKING_AREA;

--Q26
WITH C(wa,ct) AS (
    SELECT Customer.WORKING_AREA, count(Customer.WORKING_AREA)
    FROM Customer, Orders
    WHERE Customer.CUST_CODE = Orders.CUST_CODE
    GROUP BY Customer.WORKING_AREA)
SELECT Agents.AGENT_NAME
FROM Agents, C
WHERE Agents.WORKING_AREA = C.wa AND C.ct >= 2;

--Q27
WITH T(code, avg_amount) AS 
(SELECT Agents.AGENT_CODE, avg(Orders.ORD_AMOUNT)
FROM Orders, Agents
WHERE Orders.AGENT_CODE = Agents.AGENT_CODE
GROUP BY Agents.AGENT_CODE)
SELECT T.avg_amount
FROM Agents LEFT OUTER JOIN T ON T.code = Agents.AGENT_CODE;


--Q28
DELETE 
FROM Orders
WHERE Orders.AGENT_CODE IN (SELECT AGENT_CODE FROM Agents WHERE Agents.WORKING_AREA = 'Bangalore');

DELETE 
FROM Customer
WHERE Customer.AGENT_CODE IN (SELECT AGENT_CODE FROM Agents WHERE Agents.WORKING_AREA = 'Bangalore');

DELETE 
FROM Agents
WHERE Agents.WORKING_AREA = 'Bangalore';


--Q29
ALTER TABLE Customer  
ADD Address VARCHAR(50) DEFAULT NULL;

--Q30
ALTER TABLE Agents
DROP COUNTRY;

--Q31
DELETE FROM Orders;

--Q32
DROP TABLE Customer CASCADE;