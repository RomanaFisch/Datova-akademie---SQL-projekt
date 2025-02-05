--2) Vytvoření tabulky pro dodatečná data o dalších evropských státech

create table t_romana_fischer_project_SQL_secondary_final AS 
select  c.country,
		c.population,
		e.year,
		round((e.gdp)::numeric,0) as gdp,
		e.gini
from countries c 
join economies e on e.country = c.country
where c.continent = 'Europe' and year >='2006' and year <='2018' -- pouze státy Evropy a sledované roky 
order by e.year, c.country;



-- tabulka hotová a existuje v databázi data_academy_2024_12_20 - data_academy_content
select *
from t_romana_fischer_project_SQL_secondary_final;


