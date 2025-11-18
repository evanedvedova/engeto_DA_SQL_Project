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

| Sloupec | Popis |
|---------|-------|
| record_id | id záznamu po kopírování do tabulky |
| record_type | Typ záznamu (`wages` pro mzdy nebo `prices` pro cenz potravin) |
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
