-- Looking at Total Cases vs population
-- Show percentage of population got Covid

SELECT
    location,
    date,
    population,
    total_cases,
    (total_cases/population)*100 AS PopulationInfectedPercentage
FROM
    covid_deaths
WHERE location LIKE 'Myan%';