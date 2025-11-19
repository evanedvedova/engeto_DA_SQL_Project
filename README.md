# Analýza dostupnosti základních potravin a mezd v ČR

## Autor
Eva Nedvědová 
evanedvedova@email.cz

## Úvod

Tento projekt se zaměřuje na analýzu dostupnosti základních potravin v České republice v kontextu průměrných mezd a ekonomických ukazatelů.  
Cílem je odpovědět na pět výzkumných otázek týkajících se vývoje mezd, cen potravin, jejich dostupnosti a souvislostí s makroekonomickými ukazateli (HDP).

Výstupem projektu jsou:

- dvě datové tabulky uložené v SQL databázi,
- sada analytických SQL dotazů k výzkumným otázkám,
- komentáře a interpretace výsledků.

---
## Datové zdroje

V projektu byly pouzity datové zdroje z databáze data_academy_2025_09_10.

Projekt využívá následující primární zdroje:
- **Česká data o mzdách** (`czechia_payroll`)
- **Česká data o cenách potravin** (`czechia_price`)
- **Katalogy kategorií** (`czechia_payroll_industry_branch`, `czechia_price_category`)
- **Makroekonomická data světových států** (`economies`, `countries`)

SQL dotazy používájí následující dvě tabulky, které byly vytvořeny pomocí primárních zdrojů:
- t_eva_nedvedova_project_SQL_primary_final
- t_eva_nedvedova_project_SQL_secondary_final

Data byla agregována a sjednocena tak, aby bylo možné provádět meziroční a mezikategoriální porovnání.

# Přehled datového workflow

# **Extrakce**
- Import dat z jednotlivých zdrojových tabulek.
- Filtrování pouze relevantních hodnot (např. pro mzdy value_type_code 5958, což odpovídá hrubé mzdě na zaměstnance, a calculation_code 200, tedy přepočtený počet na osoby., pro celostátní ceny potravin region_code null).

# **Transformace**
- Konsolidace mezd na úroveň čtvrtletí.
- Agregace cen potravin na průměrné čtvrtletní ceny.

# **Load**
- Vytvoření dvou finálních analytických tabulek:  
  - `t_eva_nedvedova_project_SQL_primary_final`  
  - `t_eva_nedvedova_project_SQL_secondary_final`

Tyto tabulky fungují jako jediný zdroj pravdy (Single Source of Truth) pro následné analýzy.

# Primární tabulka: `t_eva_nedvedova_project_SQL_primary_final`
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

# Sekundární tabulka: `t_eva_nedvedova_project_sql_secondary_final`

Obsahuje doplňující data o evropských státech včetně hrubého domácího produktu (gdp).

Vytvoření souboru je popsáno v souborech `20251118 create secondary table` a `20251118 secondary table generator`.

| Sloupec | Popis |
|---------|-------|
|country |	Název země|
|record_year |	Rok záznamu|
|gdp |	Hrubý domácí produkt|
|population	| Počet obyvatel|
|gini	|GINI koeficient|

---
# Jak projekt spustit (Setup & Execution)

#**Požadavky**
Databázový systém: PostgreSQL
(používány funkce regr_slope, regr_intercept, corr, CTE).

Dataset se strukturou odpovídající zdrojovým tabulkám.

#**Kroky spuštění**

Volitelné: vyvoření primární a sekundární tabulky
-Vytvořte primární tabulku pomocí souboru `20251118 create primary table` 
-Spusťte INSERT skript pro mzdy a spusťte INSERT skript pro ceny potravin pomocí souboru `20251118 primary table generator`
-Vytvořte sekundární tabulku pomocí souboru `20251118 create secondary table`
-Spusťte INSERT skript ekonomických dat pomocí souboru `20251125 secondary table generator`

Spustění výzkumných otázek

-Spouštějte jednotlivé analytické SQL dotazy dle výzkumných otázek.

---

### Výzkumné otázky a SQL dotazy

## 1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
SQL soubor: `20251118 u1`

Výsledek a komentář: Pro vyhodnocení dlouhodobého trendu mezd v jednotlivých sektorech byl použit fit daty lineární regresí. Sklon přímky (trend_sklon) vyjadřuje průmerný mezičtvdletní růst mzdy. Tento sklon je pro všechna odvětví kladný, což znamená, že dlouhodobě mezi sledovaným časovým úsekem 2000-2021 mzdy rostou ve všech odvětvích. Nejrychleji mzdy rostou v odvětví Informační a komunikační činnosti a nejpomaleji v odvětví Ubytování, stravování a pohostinství. Metrika kvality modelu R², která je velmi vysoká (0,85–0,97), což znamená, že čas skutečně vysvětluje většinu variability mezd a trend je robustní. 

## 2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období?
SQL soubor: `20251118 u2`

Výsledek a komentář:
Výsledky ukazují, že v roce 2006 v prvním kvartálu mohl průměrný zaměstnanec koupit přibližně 1243 bochníků chleba nebo 1287 litrů mléka, zatímco v roce 2018 v posledním kvartálu to bylo už 1425 bochníků chleba a 1747 litrů mléka. To znamená, že i přes nárůst cen potravin rostly mzdy rychleji, a kupní síla ve sledovaných kategoriích se tak zřetelně zvýšila. Nejvýraznější zlepšení je patrné u mléka, kde počet dostupných jednotek vzrostl o více než 35 %, což naznačuje, že zdražení mléka v daném období bylo relativně mírné ve srovnání s růstem mezd. 

## 3. Která kategorie potravin zdražuje nejpomaleji?

SQL soubor: `20251118 u3`


Výsledek a komentář:

## 4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (>10%)?

Výsledek a komentář:

## 5. Má výška HDP vliv na změny ve mzdách a cenách potravin?

Výsledek a komentář:

### Závěr

