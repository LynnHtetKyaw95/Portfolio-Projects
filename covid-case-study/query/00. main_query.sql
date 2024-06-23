-- Select column that we are going to use
SELECT
    location,
    date,
    population,
    total_cases,
    new_cases,
    total_deaths
FROM
    covid_deaths
ORDER BY
    location, date;

SELECT
    count(*)
FROM
    covid_deaths;

SELECT
    MIN(date),
    MAX(date)
FROM
    covid_deaths;


SELECT
    MAX(date)
FROM
    covid_deaths
WHERE
    location LIKE 'Myan%'