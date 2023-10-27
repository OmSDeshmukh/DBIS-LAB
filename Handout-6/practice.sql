--Q1
begin;

--Q2
INSERT INTO actor( act_id,act_fname,actor_lname,act_genders ) VALUES(125,'Sarth','Rajain','M');

--Q3
SELECT * FROM actor;

--Q4
COMMIT;

--Q5
SELECT * FROM actor;

--Q6
BEGIN;
INSERT INTO actor( act_id,act_fname,actor_lname,act_genders ) VALUES(125,'Sarth','Rajain','M');
SELECT * FROM actor;
ROLLBACK;

--Q7
BEGIN
INSERT INTO actor( act_id,act_fname,actor_lname,act_genders) VALUE(127,'Sa','in','F');
-- ERROR:  syntax error at or near "VALUE"
-- LINE 1: ... actor( act_id,act_fname,actor_lname,act_genders) VALUE(127,...
COMMIT
-- ROLLBACK   

--Q8

--q9
ALTER TABLE movie_cast ADD PRIMARY KEY (act_id, mov_id);

