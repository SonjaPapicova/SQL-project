-- 2. otázka: Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?

-- milk

SELECT
	year,
	round(avg(value), 2) AS avg_wage,
	round(avg(price_value), 2) AS avg_price,
	round((avg(value) / avg(price_value)), 2) AS litres_of_milk
FROM t_sonja_papicova_project_sql_primary_final_REV 
WHERE year = (SELECT MIN(year) FROM t_sonja_papicova_project_sql_primary_final_REV)
AND category_code = '114201'
UNION
SELECT
	year,
	round(avg(value), 2) AS avg_wage,
	round(avg(price_value), 2) AS avg_price,
	round((avg(value) / avg(price_value)), 2) AS litres_of_milk
FROM t_sonja_papicova_project_sql_primary_final_REV 
WHERE year = (SELECT MAX(year) FROM t_sonja_papicova_project_sql_primary_final_REV)
AND category_code = '114201';

-- bread

SELECT
	year,
	round(avg(value), 2) AS avg_wage,
	round(avg(price_value), 2) AS avg_price,
	round((avg(value) / avg(price_value)), 2) AS kg_of_bread
FROM t_sonja_papicova_project_sql_primary_final_REV 
WHERE year = (SELECT MIN(year) FROM t_sonja_papicova_project_sql_primary_final_REV)
AND category_code = '111301'
UNION 
SELECT
	year,
	round(avg(value), 2) AS avg_wage,
	round(avg(price_value), 2) AS avg_price,
	round((avg(value) / avg(price_value)), 2) AS kg_of_bread
FROM t_sonja_papicova_project_sql_primary_final_REV 
WHERE year = (SELECT MAX(year) FROM t_sonja_papicova_project_sql_primary_final_REV)
AND category_code = '111301';