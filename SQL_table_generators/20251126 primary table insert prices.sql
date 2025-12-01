INSERT INTO
    t_eva_nedvedova_project_SQL_primary_final (
        --- INSERT PRICES
        record_type,
        category,
        record_year,
        record_quarter,
        price_value,
        category_code
    )
SELECT
    'prices',
    cpc.name,
    extract(
        year
        FROM
            date_from
    ) AS prices_year,
    extract(
        quarter
        FROM
            date_from
    ) AS prices_quarter,
    round(avg(value) :: NUMERIC, 1) AS avg_price,
    cp.category_code
FROM
    czechia_price AS cp
    LEFT JOIN czechia_price_category AS cpc ON cp.category_code = cpc.code
WHERE
    cp.region_code IS NULL --for Czechia
    and record_year >= 2006
    and record_year <= 2018
GROUP BY
    prices_year,
    prices_quarter,
    cpc.name,
    cp.category_code;
