-- Global Numbers

SELECT
    SUM(new_cases) AS TotalCases,
    SUM(new_deaths) As TotalDeaths,
    (SUM(new_deaths)/SUM(new_cases))*100 AS DeathPercentage
FROM
    covid_deaths
WHERE continent IS NOT NULL;

/*
    [
  {
    "TotalCases": "775683246",
    "TotalDeaths": "7055166",
    "DeathPercentage": "0.9095"
  }
]
*/