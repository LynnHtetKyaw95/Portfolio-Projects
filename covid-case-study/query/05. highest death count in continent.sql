-- Showing contientens with the highest death count per population

SELECT
    continent,
    MAX(total_deaths)AS HighestDeathCount
FROM
    covid_deaths
WHERE continent IS NOT NULL
GROUP BY
    continent
ORDER BY
    2 DESC
LIMIT 5;

/*
    [
  {
    "continent": "North America",
    "HighestDeathCount": "1188935"
  },
  {
    "continent": "South America",
    "HighestDeathCount": "702116"
  },
  {
    "continent": "Asia",
    "HighestDeathCount": "533619"
  },
  {
    "continent": "Europe",
    "HighestDeathCount": "403000"
  },
  {
    "continent": "Africa",
    "HighestDeathCount": "102595"
  }
]
*/