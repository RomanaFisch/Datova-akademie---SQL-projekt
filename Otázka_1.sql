--1. otázka: Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
create view v1_romana_fischer as
select  year,
		industry_name,
		avg_payroll_value,
		lag(avg_payroll_value) over (partition by industry_name order by year) as avg_payroll_previous_year,
		avg_payroll_value - lag(avg_payroll_value) over (partition by industry_name order by year) as difference,
		case
			when avg_payroll_value - lag(avg_payroll_value) over (partition by industry_name order by year) > 0 then 'increasing'
			when avg_payroll_value - lag(avg_payroll_value) over (partition by industry_name order by year) is null then 'not evaluated'
			else 'decreasing'
		end as trend
from t_romana_fischer_project_sql_primary_final rfpf
group by year, industry_name, avg_payroll_value
order by year, industry_name;

-- tabulka dat, kde mzdy v letech a odvětvých klesaly:
select *
from t_rf_mzdy
where trend != 'not evaluated' and trend = 'decreasing';


