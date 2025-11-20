INSERT INTO t_eva_nedvedova_project_SQL_primary_final (
record_type, payroll_value, record_year, record_quarter, industry_branch, industry_branch_code,
value_type_code, calculation_code)
SELECT  						--- INSERT WAGES
'wages',
cp.value,
cp.payroll_year,
cp.payroll_quarter,
cpib.name,
cp.industry_branch_code,
cp.value_type_code,
cp.calculation_code
FROM czechia_payroll AS cp 
LEFT JOIN czechia_payroll_industry_branch AS cpib 
ON cp.industry_branch_code = cpib.code
WHERE cp.value_type_code = 5958 --hruba mzda na zamestnance
AND cp.calculation_code = 200 --prepocteny pocet
;
INSERT INTO t_eva_nedvedova_project_SQL_primary_final ( 					--- INSERT PRICES
record_type, category, record_year, record_quarter, price_value, category_code
)
SELECT
'prices',
cpc.name,
extract(year FROM date_from) AS prices_year,
extract(quarter FROM date_from) AS prices_quarter,
round(avg(value)::NUMERIC, 1) AS avg_price,
cp.category_code
FROM czechia_price AS cp 
LEFT JOIN czechia_price_category AS cpc 
ON cp.category_code = cpc.code 
WHERE cp.region_code IS NULL --for Czechia
GROUP BY prices_year, prices_quarter, cpc.name, cp.category_code
;