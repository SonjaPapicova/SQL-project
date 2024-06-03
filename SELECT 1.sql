WITH yearly_avg_wages AS (
	SELECT 
		industry_branch_code,
		year,
		avg(value) AS avg_wage,
		lag(avg(value)) OVER(PARTITION BY industry_branch_code ORDER BY year) AS prev_year_avg_wage
	FROM t_sonja_papicova_project_sql_primary_final_REV 
	WHERE industry_branch_code IS NOT NULL
	GROUP BY industry_branch_code, 
			 year
)
SELECT 
	industry_branch_code,
	year,
	avg_wage,
	prev_year_avg_wage,
	CASE 
		WHEN avg_wage > prev_year_avg_wage  THEN 'increase'
		WHEN avg_wage < prev_year_avg_wage  THEN 'decrease'
		ELSE 'n/a'
	END AS wage_trend
FROM yearly_avg_wages;