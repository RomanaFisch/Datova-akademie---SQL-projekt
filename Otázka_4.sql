-- 4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší
-- než růst mezd (větší než 10 %)?

create view rf_tab1 as 
select year as year_1,
		round(avg(avg_payroll_value)::numeric,0) as avg_payroll_1,
		round(avg (avg_value)::numeric,1) as avg_price_1
from t_romana_fischer_project_sql_primary_final
group by year
order by year;

create view rf_tab2 as
select year as year_2,
		round(avg(avg_payroll_value)::numeric,0) as avg_payroll_2,
		round(avg (avg_value)::numeric,1) as avg_price_2
from t_romana_fischer_project_sql_primary_final
group by year
order by year;

create view rf_result_question4 as
SELECT *,
    round((avg_payroll_2 - avg_payroll_1) / avg_payroll_1 * 100, 2) as payroll_difference,
    round((avg_price_2 - avg_price_1) / avg_price_1 * 100, 2) as price_difference
from rf_tab1 
join rf_tab2 on year_1 = year_2 - 1;

-- vysledná tabulka:
select year_1 as year,
	   payroll_difference as payroll_year_difference,
	   price_difference as price_year_difference
from rf_result_question4;





