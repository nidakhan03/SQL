CREATE DATABASE PROJECT;

USE PROJECT; 

SELECT TOP 10 *FROM MOVIES;
SELECT TOP 10 *FROM RATINGS;

--how many movies and ratings exists
SELECT COUNT(*) AS total_movies FROM MOVIES;
SELECT COUNT(*) AS total_ratings FROM RATINGS;

--finding average rating of each movie
SELECT m.title,
       AVG(r.rating) AS avg_rating
FROM
MOVIES AS m
INNER JOIN 
RATINGS AS r
ON m.movieid=r.movieid
GROUP BY m.title
ORDER BY avg_rating DESC;

--Counting ratings per movie
SELECT*FROM MOVIES;
SELECT*FROM RATINGS;

SELECT m.title,
       r.movieid,
       COUNT(rating) AS total_ratings
FROM RATINGS AS r
INNER JOIN MOVIES AS m
ON r.movieid=m.movieid
GROUP BY r.movieid,m.title
ORDER BY total_ratings DESC;


--finding movies with no ratings
SELECT m.title
FROM MOVIES AS m
LEFT JOIN RATINGS AS r
ON m.movieid=r.movieid
WHERE r.rating IS NULL;

--Overall Average rating
SELECT AVG(rating) AS overall_avg_rating
FROM ratings;

--Top movie in each genre 
WITH MovieAvg AS
(
SELECT 
m.title,
m.genres,
AVG(r.rating) AS avg_rating
FROM MOVIES AS m
INNER JOIN RATINGS AS r
ON m.movieid=r.movieid
GROUP BY m.title,m.genres
),
RankedMovies AS
(
SELECT *,
RANK()OVER (PARTITION BY genres ORDER BY avg_rating DESC) AS genre_rank
FROM MovieAvg
)
SELECT
title,
genres,
avg_rating
FROM RankedMovies
WHERE genre_rank=1;
