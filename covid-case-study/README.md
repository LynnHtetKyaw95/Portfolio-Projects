# Introduction
Dive into the data covid case. Focusing on data analyst role, this project explore the interesting findings and analysis. 

🔍 SQL queries: Check them out here: [Query](query).

📊 Tableau visulization: Check it out here: [Tableau](https://public.tableau.com/app/profile/lynn.htet.kyaw/viz/Covid-19Dashboard_17190712554910/Dashboard1?publish=yes)

# Background
The purpose of this project was to practice and manipulating data in reference to COVID-19 pandemic. After extracting various SQL queries from tables, I created a visual dashboard in Tableau to showcase the amount of cases, deaths and vaccinations in various countries/ continents have reported from 2020-01-01 to 2024-06-21.

For this project, I used the PostgreSQL and Microsoft Visual Studio (VS Code) to explore the analysis. There are 2 datasets;
- Covid Death - This table explains the cases and deaths related with date and countries.
- Covd Vaccination - This table explains the vaccinations related with date adnd countries.

Dataset can be downloaded here: [Dataset](dataset). Full Dataset can be found from https://ourworldindata.org/covid-deaths.

The questions I wanted to answer through my SQL queries:

1. What is the daily percentage of total cases vs total deaths?
2. What is daily the percentage of total cases vs population?
3. Which contries has the overall highest infection rate?
4. Which counties has the overall highest death count?
5. Which continent has the overall  highest death count?
6. What is the percentage of overall death all over the world?
7. What is the percentage of daily death all over the world?
8. What percentage of population vaccinated day by day?

Let's get started.

# Tools I Used
For my deep dive into the data analyst job market, I harnessed the power of several key tools:

- SQL: The backbone of my analysis, allowing me to query the database and unearth critical insights.
- PostgreSQL: The chosen database management system, ideal for handling the job posting data.
- Visual Studio Code: My go-to for database management and executing SQL queries.
- Git & GitHub: Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.
- Tableau: visual dashboard in Tableau to showcase the amount of cases, deaths and vaccinations in various countries/ continents

# The Analysis

Each query for this project aimed at investigating specific aspects of the COVID-19 pandemic. Here’s how I approached each question:

### 1. What is the daily percentage of total cases vs total deaths?

To identify the total death percentage, I have to divide the total deaths with total cases. This is the insights of how many percentage of population died because of COVID-19 infection.

```sql
    SELECT
        location,
        date,
        total_cases,
        total_deaths,
        (total_deaths/total_cases)*100 AS DeathPercentage
    FROM
        covid_deaths
    WHERE location LIKE 'Myan%';
```

### 2. What is daily the percentage of total cases vs population?

To identify the total case percentage, I have to divide the total cases with population. This is the insights of how many percentage of population infected the COVID-19.

```sql
    SELECT
        location,
        date,
        population,
        total_cases,
        (total_cases/population)*100 AS PopulationInfectedPercentage
    FROM
        covid_deaths
    WHERE location LIKE 'Myan%';
```

### 3. Which contries has the overall highest infection rate?

According to the analysis, Cyprus has the highest infection rate.
- Cyprus: 77.15%
- Brunei: 76.79%
- San Marino: 75.07%
- Austria: 68.04%
- South Korea: 66.72%

```sql
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
        4 DESC;
```

| Location      | Population | Total Cases | Highest Infection Rate |
|---------------|------------|-------------|------------------------|
| Cyprus        | 896,007    | 691,252     | 77.1481                |
| Brunei        | 449,002    | 344,797     | 76.7919                |
| San Marino    | 33,690     | 25,292      | 75.0727                |
| Austria       | 8,939,617  | 6,082,354   | 68.0382                |
| South Korea   | 51,815,808 | 34,571,873  | 66.7207                |

### 4. Which counties has the overall highest death count?

Accroding to the analysis, Peru has the highest death count.
- Peru: 0.65%
- Bulgaria: 0.57%
- Bosnia and Herzegovina: 0.51%
- Hungary: 0.49%
- North Macedonia: 0.48%

```sql
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
```

| Location                  | Population | Total Deaths | Highest Death Rate |
|---------------------------|------------|--------------|--------------------|
| Peru                      | 34,049,588 | 220,831      | 0.6486             |
| Bulgaria                  | 6,781,955  | 38,700       | 0.5706             |
| Bosnia and Herzegovina    | 3,233,530  | 16,388       | 0.5068             |
| Hungary                   | 9,967,304  | 49,051       | 0.4921             |
| North Macedonia           | 2,093,606  | 9,977        | 0.4765             |

### 5. Which continent has the overall  highest death count?

According to the analysis, North America (continent) has rhe highest death count.

```sql
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
```

| Continent     | Highest Death Count |
|---------------|---------------------|
| North America | 1,188,935           |
| South America | 702,116             |
| Asia          | 533,619             |
| Europe        | 403,000             |
| Africa        | 102,595             |

### 6. What is the percentage of overall death all over the world?

```sql
    SELECT
        SUM(new_cases) AS TotalCases,
        SUM(new_deaths) As TotalDeaths,
        (SUM(new_deaths)/SUM(new_cases))*100 AS DeathPercentage
    FROM
        covid_deaths
    WHERE continent IS NOT NULL;
```

| Total Cases | Total Deaths | Death Percentage |
|-------------|--------------|------------------|
| 775,683,246 | 7,055,166    | 0.9095%          |

### 7. What is the percentage of daily death all over the world?

```sql
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
```

### 8. What percentage of population vaccinated day by day?

```sql
    WITH PopvsVac AS (
        SELECT
            dea.continent,
            dea.location,
            dea.date,
            dea.population,
            vac.new_vaccinations,
            SUM(new_vaccinations) OVER (
                PARTITION BY dea.location
                ORDER BY dea.location, dea.date
            ) AS RollingPeopleVaccinated
        FROM
            covid_deaths AS dea
        JOIN covid_vacs AS vac
            ON dea.location = vac.location
            AND dea.date = vac.date
        WHERE dea.continent IS NOT NULL
        ORDER BY
            2,3
    )
    SELECT
        *,
        (RollingPeopleVaccinated/population)*100 AS RollingPeopleVaccinatedPercentage
    FROM
        PopvsVac;
```

# What I learned

Throughout this adventure, I've turbocharged my SQL toolkit with some serious firepower:

- 🧩 Complex Query Crafting: Mastered the art of advanced SQL, merging tables like a pro and wielding WITH clauses for ninja-level temp table maneuvers.
- 📊 Data Aggregation: Got cozy with GROUP BY and turned aggregate functions like SUM() and AVG() into my data-summarizing sidekicks.
- 💡 Analytical Wizardry: Leveled up my real-world puzzle-solving skills, turning questions into actionable, insightful SQL queries.

# Conclusion

This project enhanced my SQL skills and provided valuable insights into the COVID-19 pandemic. The findings from the analysis serve as a guide to prioritizing skill development and job search efforts. This exploration highlights the importance of continuous learning and adaptation to emerging trends in the field of data analytics.