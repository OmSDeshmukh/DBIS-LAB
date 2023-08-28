-- Q1
SELECT dir_fname AS fname,dir_lname AS lname FROM director
UNION 
SELECT act_fname AS fname,act_lname AS lname FROM actor;

--Q2
SELECT reviewer.rev_name, movie.mov_title, rating.rev_stars
FROM reviewer, movie, rating
WHERE (reviewer.rev_id = rating.rev_id) AND 
    (movie.mov_id = rating.mov_id) AND (rating.rev_stars>=7);

--Q3
SELECT movie.mov_title
FROM movie
WHERE movie.mov_id NOT IN (SELECT rating.mov_id FROM rating);

--Q4
SELECT movie.mov_title, movie.mov_year, movie.mov_duration, movie.mov_rel_date, movie.mov_rel_country
FROM movie
WHERE movie.mov_rel_country <> 'USA';

--Q5
SELECT DISTINCT rev_name 
FROM reviewer
WHERE reviewer.rev_id <> SOME(SELECT rating.rev_id FROM rating);

--Q6
SELECT reviewer.rev_name, movie.mov_title, rating.rev_stars
FROM reviewer, rating, movie
WHERE reviewer.rev_id = rating.rev_id AND movie.mov_id = rating.mov_id AND rating.rev_stars IS NOT NULL;

--Q7
SELECT reviewer.rev_name, movie.mov_title 
FROM reviewer, rating, movie 
WHERE reviewer.rev_id = rating.rev_id AND rating.mov_id=movie.mov_id AND reviewer.rev_id 
IN ( SELECT rating.rev_id FROM rating GROUP BY rating.rev_id HAVING COUNT(rating.rev_id) > 1);

--Q8
-- SELECT movie.mov_title
-- FROM movie, rating, reviewer
-- WHERE movie.mov_id = rating.mov_id AND reviewer.rev_id = rating.rev_id and reviewer.rev_name <> 'Paul Monks'
-- UNION
-- SELECT mov_title
-- FROM movie
-- WHERE movie.mov_id NOT IN (SELECT rating.mov_id FROM rating);

--Q8
SELECT movie.mov_title
FROM movie 
WHERE movie.mov_title NOT IN (SELECT movie.mov_title FROM movie, rating, reviewer WHERE movie.mov_id = rating.mov_id AND reviewer.rev_id = rating.rev_id and reviewer.rev_name = 'Paul Monks');


--Q9
SELECT reviewer.rev_name, movie.mov_title, rating.rev_stars
FROM reviewer, movie, rating
WHERE movie.mov_id = rating.mov_id AND reviewer.rev_id = rating.rev_id and rating.rev_stars = (SELECT min(rev_stars) FROM rating);

--Q10
SELECT movie.mov_title
FROM movie, movie_direction, director
WHERE movie.mov_id = movie_direction.mov_id AND director.dir_id = movie_direction.dir_id AND director.dir_fname='James' AND director.dir_lname='Cameron';

--Q11
SELECT reviewer.rev_name 
FROM reviewer, rating
WHERE reviewer.rev_id = rating.rev_id AND rating.rev_stars IS NULL;

--Q12
SELECT actor.act_fname, actor.act_lname
FROM actor, movie_cast, movie
WHERE actor.act_id = movie_cast.act_id AND movie_cast.mov_id = movie.mov_id 
        AND movie.mov_id NOT IN (SELECT movie.mov_id
                            FROM movie
                            WHERE movie.mov_year >=1990 and movie.mov_year <=2000)
UNION
(SELECT actor.act_fname, actor.act_lname
FROM actor
WHERE actor.act_id NOT IN (SELECT movie_cast.act_id FROM movie_cast));

--Q13
SELECT director.dir_fname, director.dir_lname, genres.gen_title, count(genres.gen_title) 
FROM director, movie, movie_genres, genres, movie_direction
WHERE director.dir_id=movie_direction.dir_id AND movie.mov_id=movie_direction.mov_id AND movie.mov_id=movie_genres.mov_id AND genres.gen_id=movie_genres.gen_id 
GROUP BY director.dir_fname, director.dir_lname, genres.gen_title
ORDER BY director.dir_fname,director.dir_lname;

--Q14
SELECT movie.mov_title, movie.mov_year, genres.gen_title, director.dir_fname, director.dir_lname
FROM movie, genres, director, movie_genres, movie_direction
WHERE movie.mov_id = movie_genres.mov_id AND movie_genres.gen_id = genres.gen_id and 
        movie.mov_id = movie_direction.mov_id AND director.dir_id = movie_direction.dir_id;

--Q15
SELECT genres.gen_title, avg(movie.mov_duration) as average_duration, count(movie.mov_id) as number_of_movies
FROM genres, movie, movie_genres
WHERE movie.mov_id = movie_genres.mov_id AND genres.gen_id = movie_genres.gen_id
GROUP BY genres.gen_title;

--Q16
SELECT movie.mov_title, movie.mov_year, director.dir_fname, director.dir_lname, actor.act_fname,actor.act_lname, movie_cast.role
FROM movie, movie_cast, actor, director, movie_direction
WHERE movie.mov_id = movie_cast.mov_id AND  movie.mov_id = movie_direction.mov_id AND actor.act_id=movie_cast.act_id AND director.dir_id=movie_direction.dir_id AND movie.mov_duration=(SELECT min(mov_duration) FROM movie);

--Q17
SELECT reviewer.rev_name, movie.mov_title, rating.rev_stars
FROM reviewer, movie, rating
WHERE reviewer.rev_id= rating.rev_id AND movie.mov_id=rating.mov_id
ORDER BY reviewer.rev_name, movie.mov_title, rating.rev_stars;

--Q18
SELECT movie.mov_title, director.dir_fname, director.dir_lname, rating.rev_stars
FROM movie, director, movie_direction, rating, reviewer
WHERE director.dir_id= movie_direction.dir_id AND movie.mov_id=movie_direction.mov_id AND movie.mov_id=rating.mov_id AND reviewer.rev_id=rating.rev_id AND rating.num_o_rating>0;

--Q19
SELECT director.dir_fname as fname, director.dir_lname as fname, movie.mov_title as movie, movie_cast.role as role
FROM movie, movie_cast, movie_direction, director, actor
WHERE movie.mov_id=movie_direction.mov_id AND movie.mov_id=movie_cast.mov_id AND movie_direction.dir_id=director.dir_id AND actor.act_id=movie_cast.act_id AND director.dir_fname=actor.act_fname AND director.dir_lname=actor.act_lname;

--Q20
SELECT actor.act_fname, actor.act_lname
FROM movie_cast, actor, movie
WHERE movie_cast.mov_id=movie.mov_id AND movie_cast.act_id=actor.act_id AND movie.mov_title='Chinatown';

--Q21
SELECT movie.mov_title
FROM movie, movie_cast, actor
WHERE movie_cast.mov_id=movie.mov_id AND movie_cast.act_id=actor.act_id AND actor.act_fname='Harrison' AND actor.act_lname='Ford';

--Q22
SELECT movie.mov_title, movie.mov_year, rating.rev_stars
FROM movie, movie_genres,rating, genres
WHERE movie.mov_id=movie_genres.mov_id AND movie.mov_id=rating.mov_id AND movie_genres.gen_id=genres.gen_id AND genres.gen_title='Mystery';

--Q23
SELECT movie.mov_title, actor.act_fname, actor.act_lname, movie.mov_year, movie_cast.role, genres.gen_title, director.dir_fname, director.dir_lname, movie.mov_rel_date, rating.rev_stars
FROM actor, movie_cast, genres, director, movie, movie_genres, movie_direction, rating
WHERE actor.act_id=movie_cast.act_id AND movie.mov_id=movie_cast.mov_id AND movie.mov_id=movie_direction.mov_id AND director.dir_id=movie_direction.dir_id AND movie.mov_id=movie_genres.mov_id AND movie.mov_id=rating.mov_id AND genres.gen_id=movie_genres.gen_id AND actor.act_gender='F';

--Q24
SELECT actor.act_fname, actor.act_lname
FROM actor, movie, movie_cast
WHERE actor.act_id=movie_cast.act_id AND movie.mov_id=movie_cast.mov_id AND movie.mov_year = ALL(
SELECT movie.mov_year
FROM movie, director, movie_direction
WHERE director.dir_id=movie_direction.dir_id AND movie.mov_id=movie_direction.mov_id AND director.dir_fname='Stanley' AND director.dir_lname='Kubrick');

-- SELECT S.act_fname, S.act_lname 
-- FROM actor as S
-- WHERE
-- ((SELECT movie.mov_year
-- FROM actor, movie, movie_cast
-- WHERE actor.act_id=movie_cast.act_id AND movie.mov_id=movie_cast.mov_id) 
-- INTERSECT
-- (SELECT movie.mov_year
-- FROM movie, director, movie_direction
-- WHERE director.dir_id=movie_direction.dir_id AND 
-- movie.mov_id=movie_direction.mov_id AND 
-- director.dir_fname='Stanley' AND director.dir_lname='Kubrick')= 
-- ALL(SELECT movie.mov_year
-- FROM movie, director, movie_direction
-- WHERE director.dir_id=movie_direction.dir_id AND 
-- movie.mov_id=movie_direction.mov_id AND 
-- director.dir_fname='Stanley' AND director.dir_lname='Kubrick'));