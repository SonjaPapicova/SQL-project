CREATE OR REPLACE TABLE t_sonja_papicova_project_sql_secondary_final AS
SELECT
	c.country,
	c.population,
	year,
	GDP,
	gini
FROM countries c 
JOIN economies e2 ON c.country = e2.country
WHERE c.continent = "Europe"
AND year BETWEEN 2006 AND 2018;