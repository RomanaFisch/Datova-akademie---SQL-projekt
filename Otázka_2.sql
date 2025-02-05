-- 2. otázka: Kolik je možné si koupit litrů mléka a kilogramů chleba
-- za první a poslední srovnatelné období v dostupných datech cen a mezd?
create view v2_romana_fischer as
select year, 
		product_name,
		avg_value,
		price_unit,
		round(avg(avg_payroll_value)::numeric,0) as avg__salary_all_branch,
		round(avg(avg_payroll_value)/avg_value,2) as among	
from t_romana_fischer_project_sql_primary_final
where category_code in (111301 , 114201) and year in (2006 , 2018)
group by year, product_name, avg_value, price_unit
order by year, product_name;

-- vysledna tabulka:

select *
from v2_romana_fischer
order by product_name;



