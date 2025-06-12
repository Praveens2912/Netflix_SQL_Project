--1.Count the number of Movies vs TV Shows

SELECT 
	type,
	COUNT(*)
	FROM netflix
	group BY 1


--2. A) Find the most common rating for movies and TV shows


SELECT
	type,
	rating
FROM
(   SELECT 
	Type,
	rating,
	COUNT(*),
	RANK() OVER(PARTITION BY type ORDER BY COUNT(*) DESC) AS Ranking
    FROM netflix
    GROUP BY 1,2
) as t1
WHERE 
	 ranking = 1

--B)Find the most common genre for movies and for TV shows separately.
	
SELECT 
	type,
	listed_in
FROM	
(
SELECT 
	type,
	listed_in,
	COUNT(*),
	RANK() OVER(PARTITION BY type ORDER BY COUNT(*)DESC) AS genre
FROM netflix
GROUP BY 1,2  
) AS t1
WHERE 
	 genre = 1

--3.List All Movies Released in a Specific Year (e.g., 2020)

SELECT
	release_year,
	*
FROM netflix
WHERE
	release_year = '2020'

--4.Find the top 5 countries with the most content on Netflix

SELECT 
	UNNEST(STRING_TO_ARRAY(country,',')) AS new_country,
	COUNT(show_id) AS total_content
FROM netflix
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

--5. Identify the longest movie


SELECT 
	duration,
    *
FROM netflix
WHERE 
	duration is not null
	AND
	type = 'Movie'
ORDER BY SPLIT_PART(duration, ' ', 1)::INT DESC;


--6. Find content added in the last 5 years

SELECT *
FROM netflix
WHERE TO_DATE(date_added, 'Month DD, YYYY') >= CURRENT_DATE - INTERVAL '5 years';

--7. Find All Movies/TV Shows by Director 'Rajiv Chilaka'

	SELECT *
FROM (
    SELECT 
        *,
        UNNEST(STRING_TO_ARRAY(director, ',')) AS director_name
    FROM netflix
) AS t
WHERE director_name = 'Rajiv Chilaka';

--8. List all the TV Show more then 5 seasons

SELECT * FROM netflix
WHERE 
     type = 'TV Show'
	AND  
     SPLIT_PART(duration,' ',1)::numeric > 5

--9. COUNT THE NUMBER OF ITEMS IN EACH GENRE

SELECT 
	 UNNEST(STRING_TO_ARRAY(listed_in,',')) AS Genre,
	Count(show_id)
FROM netflix
Group BY 1


--10. FIND EACH YEAR AND THERE AVERAGE NUMBER OF CONTENT RELASED BY INDIA ON NETFLIX. RETURN TOP 5 YEAR WITH HIGHEST AVERAGE CONTENT RELEASE.  

SELECT * FROM netflix
	
SELECT 
     EXTRACT ( YEAR  FROM TO_DATE(date_added,'MONTH DD, YYYY')) As year,
	COUNT(*) as yearly,
	ROUND(
	COUNT(*)::numeric/ (SELECT COUNT(*) FROM netflix WHERE country = 'India')::numeric * 100
    ,2)	as avg_content_per_year 
FROM netflix
WHERE
country = 'India'
GROUP BY 1


11--List all the movies that are documentaries
SELECT * FROM netflix

SELECT 	
	type,
	*
FROM netflix
WHERE 
Listed_in = 'Documentaries'

SELECT * FROM netflix
WHERE 
     listed_in like '%Documentaries%'

--12.FIND ALL THE CONTENTS WITHOUT DIRECTORS

SELECT * FROM netflix
WHERE 
	director is null

--13. FIND HOW 	MANY MOVIES ACTO 'SALMAN KHAN' APPEARED IN LAST 10 YEARS
	
SELECT * FROM netflix
WHERE 
     casts ILIKE '%Salman Khan%'
     AND 
     release_year > EXTRACT (year from current_date) - 15


--14. FIND THE TOP 10 ACTORS WHO HAVE APPEARED IN THE HIGHEST NUMBER OF MOVIE PRODUCED IN INDIA


SELECT 
--show_id,
--casts,
UNNEST(STRING_TO_ARRAY(casts,',')) as actors,
COUNT(*) as total_contents
FROM netflix
WHERE COUNTRY ILIKE '%India'	
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10

--15. Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
the description field. Label content containing these keywords as 'Bad' and all other 
content as 'Good'. Count how many items fall into each category.

WITH New_Table
	AS
(
SELECT 
	*,
	CASE
   	WHEN 
	 description ILIKE '%kill%' OR
	 description ILIKE '%Violence%' THEN 'BAD_CONTENT'
	ELSE'GOOD_CONTENT'
END category
	FROM netflix
)
SELECT
   category,
   COUNT(*) as total_content
FROM New_Table
GROUP BY 1