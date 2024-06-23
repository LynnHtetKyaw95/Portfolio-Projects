-- Global Numbers per day

SELECT
    date,
    SUM(new_cases) AS TotalCases,
    SUM(new_deaths) As TotalDeaths,
    (SUM(new_deaths)/SUM(new_cases))*100 AS DeathPercentage
FROM
    covid_deaths
WHERE continent IS NOT NULL
GROUP BY `date`
ORDER BY `date`;

