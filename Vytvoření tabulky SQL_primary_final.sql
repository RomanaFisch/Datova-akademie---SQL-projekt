--1) Vytvoření tabulky pro data mezd a cen potravin za Českou republiku sjednocených za
-- za totožné porovnatelné období - společné roky.

-- Vytvořila jsem si dvě viewčka (payroll a price) a ty jsem pak spojila
-- ve výslednou tabulku t_romana_fischer_project_SQL_primary_final.

-- view payroll
create view v_tabulka_payroll_rf as
select cp.payroll_year as year, 
		round(avg(cp.value),0) as avg_payroll_value,
		cpib.name as industry_name,
		cpib.code 
from czechia_payroll cp
left join czechia_payroll_industry_branch cpib on cp.industry_branch_code = cpib.code
where cp.value_type_code = 5958  -- data mzdy
and cp.calculation_code = 200  --data pro přepočtený počet zaměstnanců na plný úvazek
and cp.industry_branch_code is not null
and cp.payroll_year >= '2006' and cp.payroll_year <='2018' -- společné roky 
group by cp.payroll_year, cpib.name, cpib.code 
order by payroll_year, avg_payroll_value;

-- view price
create view v_tabulka_price_rf as
select date_part('year', date_from) as year, 
		cp.category_code, 
		cpc.name as product_name, 
		round(avg(cp.value)::numeric,0) as avg_value,
		cpc.price_value as amount,
		cpc.price_unit
from czechia_price cp 
join czechia_price_category cpc on cp.category_code = cpc.code
group by date_part('year', date_from), cp.category_code, cpc.name, cpc.price_value, cpc.price_unit
order by year, product_name;	


--Vytvoření tabulky z view payroll a view price
create table t_romana_fischer_project_SQL_primary_final as
select tpa.year,
		tpa.industry_name,
		tpa.code,
		tpa.avg_payroll_value,
		tpr.category_code, 
		tpr.product_name, 
		tpr.avg_value,
		tpr.amount,
		tpr.price_unit
from v_tabulka_payroll_rf tpa
join v_tabulka_price_rf tpr on tpa.year = tpr.year
order by year;

-- tabulka hotová a existuje v databázi data_academy_2024_12_20 - data_academy_content
select *
from t_romana_fischer_project_SQL_primary_final;




