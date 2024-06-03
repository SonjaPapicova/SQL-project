WITH category_averages AS (
	SELECT
		price_category_name,
		AVG(price_value) AS avg_price
	FROM
		t_sonja_papicova_project_sql_primary_final_REV
	GROUP BY
		price_category_name,
		year
)
SELECT 
	price_category_name,
	ROUND(MIN(avg_price), 2) AS initial_avg_price,
	ROUND(MAX(avg_price), 2) AS final_avg_price,
	ROUND((MAX(avg_price) - MIN(avg_price)) / MIN(avg_price) * 100, 2) AS avg_percentage_increase
FROM
	category_averages
GROUP BY
	price_category_name
ORDER BY
	avg_percentage_increase;