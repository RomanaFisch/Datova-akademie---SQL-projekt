--3. Která kategorie potravin zdražuje nejpomaleji 
-- (je u ní nejnižší percentualní meziroční nárůst)?

with cte_1 AS(
select distinct year,
		product_name,
		avg_value,
		amount,
		price_unit		
from t_romana_fischer_project_sql_primary_final
order by product_name, year),
cte_2 AS (
SELECT 
	*,
	LAG(avg_value, 1) OVER (PARTITION BY product_name ORDER BY year ASC) AS previous_price_value
FROM cte_1
),
cte_3 AS (
SELECT 
	*,
	round(((avg_value - previous_price_value)/ previous_price_value) * 100, 2) AS percentage_increase
FROM cte_2
)
SELECT
	product_name,
	round(avg(percentage_increase), 2) AS percentage_increase_final
FROM cte_3
GROUP BY product_name 
ORDER BY percentage_increase_final asc;
