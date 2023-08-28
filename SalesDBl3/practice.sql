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
ORDER BY Customer.CUST_NAME DESC;

--Q8
SELECT Customer.CUST_NAME
FROM Customer
WHERE Customer.CUST_NAME LIKE'S%';

--Q9
SELECT Orders.ORD_DATE
FROM Orders
WHERE Orders.ORD_DATE LIKE 2008-03%

--Q10
SELECT ORD_AMOUNT*.10 as amount, *
FROM Orders;

--Q11
SELECT ORD_AMOUNT,(ORD_AMOUNT-ADVANCE_AMOUNT) as Balance
FROM Orders
WHERE ORD_AMOUNT > 2000 and ORD_AMOUNT < 4000;