# Analýza dostupnosti základních potravin a mezd v ČR

## Autor
Eva Nedvědová
evanedvedova@email.cz

## Popis projektu
Cílem tohoto projektu je poskytnout datové podklady pro tiskové oddělení, které se bude zabývat dostupností základních potravin v České republice. Projekt zahrnuje:  

- Primární data: průměrné mzdy a ceny vybraných potravin v ČR za srovnatelná období.
- Sekundární data: HDP, GINI koeficient a populace vybraných evropských států ve stejných obdobích.
- Analytické SQL dotazy, které odpovídají na definované výzkumné otázky.

---

## Databázové tabulky
Dostupné v databázi data_academy_2025_09_10

### Primární tabulka: `t_eva_nedvedova_project_SQL_primary_final`
Obsahuje data o mzdách a cenách potravin v ČR.

Vytvoření souboru je popsané v souboru `20251118 primary table generator`.

Z tabulky czechia payroll byly pouzity hodnoty s value_type_code 5958, což odpovídá hrubé mzdě na zaměstnance, a calculation_code 200, tedy přepočtený počet na osoby.

Při kopírování dat z tabulky czechia_price byly hodnoty aggregovány podle kvartálu.

| Sloupec | Popis |
|---------|-------|
| record_id | id záznamu po kopírování do tabulky |
| record_type | Typ záznamu (`wages` pro mzdy nebo `prices` pro ceny potravin) |
| payroll_value | Hodnota mzdy (pro `wages`) |
| record_year | Rok záznamu |
| record_quarter | Čtvrtletí záznamu |
| industry_branch | Odvětví (pro mzdy) |
| industry_branch_code | Kód odvětví (pro mzdy) |
| value_type_code | Typ hodnoty (pro mzdy) |
| calculation_code | Kód výpočtu (pro mzdy) |
| category | Kategorie potraviny (pro `prices`) |
| price_value | Cena potraviny (průměr, pro `prices`) |
| category_code | Kód kategorie potraviny |

### Sekundární tabulka: `t_eva_nedvedova_project_sql_secondary_final`

Obsahuje doplňující data o evropských státech včetně hrubého domácího produktu (gdp).

Vytvoření souboru je popsáno v souborech `20251118 create secondary table` a `20251118 secondary table generator`.

| Sloupec | Popis |
|---------|-------|
|country |	Název země|
|record_year |	Rok záznamu|
|gdp |	Hrubý domácí produkt|
|population	| Počet obyvatel|
|gini	|GINI koeficient|

### Výzkumné otázky a SQL dotazy

## 1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
SQL soubor: `20251118 u1`

Výsledek a komentář:

## 2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období?
SQL soubor: `20251118 u2`


Výsledek a komentář:

## 3. Která kategorie potravin zdražuje nejpomaleji?

SQL soubor: `20251118 u3`


Výsledek a komentář:

## 4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (>10%)?

Výsledek a komentář:

## 5. Má výška HDP vliv na změny ve mzdách a cenách potravin?

Výsledek a komentář:

