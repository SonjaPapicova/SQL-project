SELECT
	year,
	price_category_name AS product,
	round(avg(value), 2) AS avg_wage,
	round(avg(price_value), 2) AS avg_product_price,
	round((avg(value) / avg(price_value)), 2) AS how_much_can_be_bought
FROM t_sonja_papicova_project_sql_primary_final_REV 
WHERE category_code IN ('114201', '111301')
AND (year = (SELECT MIN(year) FROM t_sonja_papicova_project_sql_primary_final_rev tsppspfr)
       OR year = (SELECT MAX(year) FROM t_sonja_papicova_project_sql_primary_final_rev tsppspfr))
GROUP BY price_category_name,
		 year;