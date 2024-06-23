-- Showing Country with highest death count per population

SELECT
    location,
    population,
    MAX(total_deaths),
    (MAX(total_deaths)/population)*100 AS HighestDeathRate
FROM  
    covid_deaths
GROUP BY
    location, population
ORDER BY
    4 DESC
LIMIT 5;

/*
[
  {
    "location": "Peru",
    "population": "34049588",
    "MAX(total_deaths)": "220831",
    "HighestDeathRate": "0.6486"
  },
  {
    "location": "Bulgaria",
    "population": "6781955",
    "MAX(total_deaths)": "38700",
    "HighestDeathRate": "0.5706"
  },
  {
    "location": "Bosnia and Herzegovina",
    "population": "3233530",
    "MAX(total_deaths)": "16388",
    "HighestDeathRate": "0.5068"
  },
  {
    "location": "Hungary",
    "population": "9967304",
    "MAX(total_deaths)": "49051",
    "HighestDeathRate": "0.4921"
  },
  {
    "location": "North Macedonia",
    "population": "2093606",
    "MAX(total_deaths)": "9977",
    "HighestDeathRate": "0.4765"
  }
]
*/