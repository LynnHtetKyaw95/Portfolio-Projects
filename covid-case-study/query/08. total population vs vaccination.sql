-- Looking at Total Population vs Vaccinations
-- Join two tables
-- Use CTE

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