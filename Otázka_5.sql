--5. Má výška HDP vliv na změny ve mzdách a cenách potravin? 
--Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin 
--či mzdách ve stejném nebo následujícím roce výraznějším růstem?

create view rf_gdp as
select year, 
		country,
		gdp,
		lag(gdp) over (order by year) as previous_year_gdp, 
		round((GDP - LAG(GDP) OVER (ORDER BY year))/LAG(GDP) OVER (ORDER BY year) * 100,2) as percent_change
from t_romana_fischer_project_sql_secondary_final rfsf
where country = 'Czech Republic';

-- vysledna tabulka: view pro gdp + view rf_result_question4(ze 4.otázky) mezirocni rust cen potravin a mezd
select rf_gdp.year,
	   rf_gdp.percent_change as gdp_percent_change_year,
	   rf_result_question4.payroll_difference as payroll_percent_change_year,
	   rf_result_question4.price_difference as price_percent_change_year	   	   
from rf_gdp
join rf_result_question4 on rf_gdp.year = rf_result_question4.year_2;















