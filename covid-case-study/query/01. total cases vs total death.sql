-- Looking at Total cases vs total deaths
-- Shows likelihood of dying if you contract Covid in my country

SELECT
    location,
    date,
    total_cases,
    total_deaths,
    (total_deaths/total_cases)*100 AS DeathPercentage
FROM
    covid_deaths
WHERE location LIKE 'Myan%';