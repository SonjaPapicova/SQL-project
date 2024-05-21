WITH avg_data AS (
	SELECT
		year ,
		AVG(price_value) AS avg_grocery_price,
		AVG(value) AS avg_wage
	FROM t_sonja_papicova_project_sql_primary_final_REV
	GROUP BY year
)
SELECT 
	year
FROM (
	SELECT
		year,
		LAG(avg_grocery_price) OVER (ORDER BY year) AS Avg_Grocery_Price_Prev_Year,
		LAG(avg_wage) OVER (ORDER BY year) AS Avg_Wage_Prev_Year,
		(avg_grocery_price - LAG(avg_grocery_price) OVER (ORDER BY year)) AS Avg_Grocery_Price_Diff,
		(avg_wage - LAG(avg_wage) OVER (ORDER BY year)) AS Avg_Wage_Diff
	FROM avg_data
) diff_data
WHERE Avg_Grocery_Price_Diff >= 0.1 * Avg_Wage_Diff;