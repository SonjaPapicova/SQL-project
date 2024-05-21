CREATE OR REPLACE TABLE t_sonja_papicova_project_sql_primary_final_REV AS
SELECT
	cp.value,
	cp.industry_branch_code,
	cpib.name AS industry_branch_name, 
	cp.payroll_year AS year,
	cpri.value AS price_value, 
	cpri.category_code, 
	cpc.name AS price_category_name,
	e.GDP AS GDP
FROM czechia_payroll cp
JOIN czechia_price cpri ON cp.payroll_year = EXTRACT(YEAR FROM cpri.date_from)
JOIN czechia_payroll_industry_branch cpib ON cp.industry_branch_code = cpib.code
JOIN czechia_price_category cpc ON cpri.category_code = cpc.code
JOIN economies e ON cp.payroll_year = e.year
WHERE value_type_code = 5958
AND unit_code = 200
AND calculation_code = 200
AND country = 'Czech Republic';