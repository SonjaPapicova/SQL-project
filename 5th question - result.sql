SELECT
    YEAR,
    GDP,
    ROUND(AVG(value), 2) AS avg_wages,
    ROUND(AVG(price_value), 2) AS avg_food_prices,
    ROUND((GDP - LAG(GDP) OVER (ORDER BY YEAR)) / LAG(GDP) OVER (ORDER BY YEAR) * 100, 2) AS GDP_growth_percent,
    ROUND((AVG(value) - LAG(AVG(value)) OVER (ORDER BY YEAR)) / LAG(AVG(value)) OVER (ORDER BY YEAR) * 100, 2) AS wage_growth_percent,
    ROUND((AVG(price_value) - LAG(AVG(price_value)) OVER (ORDER BY YEAR)) / LAG(AVG(price_value)) OVER (ORDER BY YEAR) * 100, 2) AS food_price_growth_percent
FROM t_sonja_papicova_project_sql_primary_final_rev
GROUP BY YEAR, GDP;