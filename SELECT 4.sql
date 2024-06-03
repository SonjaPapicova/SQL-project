WITH yearly_averages AS (
    SELECT
        year,
        round(AVG(price_value),2) AS avg_food_prices,
        round(AVG(value),2) AS avg_wages
    FROM t_sonja_papicova_project_sql_primary_final_rev tsppspfr
    GROUP BY year
)
SELECT
    year,
    avg_food_prices,
    avg_wages,
    LAG(avg_food_prices) OVER (ORDER BY year) AS avg_food_prices_prev_year,
    LAG(avg_wages) OVER (ORDER BY year) AS avg_wages_prev_year,
    ROUND((avg_food_prices - LAG(avg_food_prices) OVER (ORDER BY year)) / LAG(avg_food_prices) OVER (ORDER BY year) * 100, 2) AS food_price_perc_diff,
    ROUND((avg_wages - LAG(avg_wages) OVER (ORDER BY year)) / LAG(avg_wages) OVER (ORDER BY year) * 100, 2) AS wages_perc_diff,
    CASE
        WHEN (avg_food_prices - LAG(avg_food_prices) OVER (ORDER BY year)) / LAG(avg_food_prices) OVER (ORDER BY year) * 100 > 10
             AND (avg_food_prices - LAG(avg_food_prices) OVER (ORDER BY year)) / LAG(avg_food_prices) OVER (ORDER BY year) > (avg_wages - LAG(avg_wages) OVER (ORDER BY year))
        THEN 'significantly higher'
        ELSE 'not significantly higher'
    END AS food_prices_increase
FROM yearly_averages;