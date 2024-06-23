-- Looking at country with highest infection rate compared to population

SELECT
    location,
    population,
    MAX(total_cases),
    (MAX(total_cases)/population)*100 AS HighestInfectionRate
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
    "location": "Cyprus",
    "population": "896007",
    "MAX(total_cases)": "691252",
    "HighestInfectionRate": "77.1481"
  },
  {
    "location": "Brunei",
    "population": "449002",
    "MAX(total_cases)": "344797",
    "HighestInfectionRate": "76.7919"
  },
  {
    "location": "San Marino",
    "population": "33690",
    "MAX(total_cases)": "25292",
    "HighestInfectionRate": "75.0727"
  },
  {
    "location": "Austria",
    "population": "8939617",
    "MAX(total_cases)": "6082354",
    "HighestInfectionRate": "68.0382"
  },
  {
    "location": "South Korea",
    "population": "51815808",
    "MAX(total_cases)": "34571873",
    "HighestInfectionRate": "66.7207"
  }
]
*/