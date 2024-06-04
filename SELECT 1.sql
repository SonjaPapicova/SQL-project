-- 1. otázka: Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?

WITH yearly_avg_wages AS (
	SELECT 
		industry_branch_name,
		year,
		avg(value) AS avg_wage,
		lag(avg(value)) OVER(PARTITION BY industry_branch_name ORDER BY year) AS prev_year_avg_wage
	FROM t_sonja_papicova_project_sql_primary_final_REV 
	WHERE industry_branch_name IS NOT NULL
	GROUP BY industry_branch_name, 
			 year
)
SELECT 
	industry_branch_name,
	year,
	avg_wage,
	prev_year_avg_wage,
	CASE 
		WHEN avg_wage > prev_year_avg_wage  THEN 'increase'
		WHEN avg_wage < prev_year_avg_wage  THEN 'decrease'
		ELSE 'n/a'
	END AS wage_trend
FROM yearly_avg_wages;

-- dodatečný průzkum: u kterého odvětví došlo nejčastěji k poklesu mezd
WITH yearly_avg_wages AS (
    SELECT 
        industry_branch_name,
        year,
        avg(value) AS avg_wage,
        lag(avg(value)) OVER(PARTITION BY industry_branch_name ORDER BY year) AS prev_year_avg_wage
    FROM t_sonja_papicova_project_sql_primary_final_REV 
    WHERE industry_branch_name IS NOT NULL
    GROUP BY industry_branch_name, year
)
SELECT 
    industry_branch_name,
    COUNT(CASE WHEN avg_wage < prev_year_avg_wage THEN 1 END) AS decrease_count
FROM yearly_avg_wages
GROUP BY industry_branch_name
ORDER BY decrease_count DESC;

-- dodatečný průzkum č.2: ve kterém roce došlo nejčastěji k poklesu mezd, napříč odvětvími
WITH yearly_avg_wages AS (
    SELECT 
        industry_branch_name,
        year,
        avg(value) AS avg_wage,
        lag(avg(value)) OVER(PARTITION BY industry_branch_name ORDER BY year) AS prev_year_avg_wage
    FROM t_sonja_papicova_project_sql_primary_final_REV 
    WHERE industry_branch_name IS NOT NULL
    GROUP BY industry_branch_name, year
)
SELECT 
    year,
    COUNT(CASE WHEN avg_wage < prev_year_avg_wage THEN 1 END) AS decrease_count
FROM yearly_avg_wages
GROUP BY year
ORDER BY decrease_count DESC;

