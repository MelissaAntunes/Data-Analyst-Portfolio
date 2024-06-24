/*
Covid 19 Data Exploration 

Skills usadas: Joins, CTE's, Temp Tables, Windows Functions, Aggregate Functions, Creating Views, Converting Data Types

*/

-- Vizualizar tabelas
SELECT *
FROM portfolio_project.dbo.CovidDeaths;

SELECT *
FROM portfolio_project.dbo.CovidVaccinations;

-- Seleciona os dados que serão utilizados
SELECT Location,
       date,
	   total_cases,
	   new_cases,
	   total_deaths,
	   population
FROM portfolio_project.dbo.CovidDeaths
ORDER BY 1, 2;

-- Total de Casos VS Total de Mortes <- MUNDIALMENTE
-- Mostra a probabilidade de morte se você contrair Covid-19
SELECT Location,
       date,
       SUM(total_cases) AS total_cases,
       SUM(total_deaths) AS total_deaths,
       (CAST(SUM(total_deaths) AS FLOAT) / NULLIF(CAST(SUM(total_cases) AS FLOAT), 0)) * 100 AS DeathPercentage
FROM portfolio_project.dbo.CovidDeaths
GROUP BY Location, date
ORDER BY Location, date;

-- Total de Casos VS Total de Mortes <- BRASIL
SELECT Location,
       date,
       SUM(total_cases) AS total_cases,
       SUM(total_deaths) AS total_deaths,
       (CAST(SUM(total_deaths) AS FLOAT) / NULLIF(CAST(SUM(total_cases) AS FLOAT), 0)) * 100 AS DeathPercentage
FROM portfolio_project.dbo.CovidDeaths
WHERE location = 'Brazil'
GROUP BY Location, date
ORDER BY Location, date;

-- Total de casos VS População <- MUNDIALMENTE
-- Mostra quantos porcento da população contraiu Covid-19
SELECT Location,
       date,
       SUM(total_cases) AS total_cases,
       SUM(population) AS population,
       (CAST(SUM(total_cases) AS FLOAT) / NULLIF(CAST(SUM(population) AS FLOAT), 0)) * 100 AS PopulationInfected
FROM portfolio_project.dbo.CovidDeaths
GROUP BY Location, date
ORDER BY Location, date;

-- Total de casos VS População <- BRAZIL
SELECT Location,
       date,
       SUM(total_cases) AS total_cases,
       SUM(population) AS population,
       (CAST(SUM(total_cases) AS FLOAT) / NULLIF(CAST(SUM(population) AS FLOAT), 0)) * 100 AS PopulationInfected
FROM portfolio_project.dbo.CovidDeaths
WHERE location = 'Brazil'
GROUP BY Location, date
ORDER BY Location, date;

-- Países com as maiores taxas de infecção comparado a população
SELECT Location,
       MAX(total_cases) AS total_cases,
       MAX(population) AS population,
       MAX(CAST(total_cases AS FLOAT) / NULLIF(CAST(population AS FLOAT), 0)) * 100 AS HighestInfection
FROM portfolio_project.dbo.CovidDeaths
GROUP BY Location, population
ORDER BY HighestInfection DESC;

-- Países com maiores contagens de morte por população
SELECT Location,
       MAX(total_deaths) AS total_death_count
FROM portfolio_project.dbo.CovidDeaths
GROUP BY Location
ORDER BY total_death_count DESC;

-- Números globais
SELECT SUM(new_cases) AS total_cases,
       SUM(new_deaths) total_deaths,
	   SUM(new_deaths) / NULLIF(SUM(CAST(new_cases AS FLOAT)), 0)*100 AS DeathPercentage
FROM portfolio_project.dbo.CovidDeaths
ORDER BY 1, 2;

-- -----------------------
-- ANÁLISE POR VACINAÇÃO
-- -----------------------

-- USAR expressão de tabela comum (CTE)
WITH pop_vs_vacc (continent, location, date, population, new_vaccinations, rolling_ppl_vaccinated)
AS
(
-- População total VS Vacinações
SELECT death.continent,
       death.location,
	   death.date,
	   death.population,
	   vacc.new_vaccinations,
	   SUM(vacc.new_vaccinations) OVER(PARTITION BY death.location ORDER BY death.location, death.date) AS rolling_ppl_vaccinated
FROM portfolio_project.dbo.CovidDeaths death
JOIN portfolio_project.dbo.CovidVaccinations vacc
     ON death.location = vacc.location
	 AND death.date = vacc.date
)

SELECT *,
	(rolling_ppl_vaccinated/NULLIF(population, 0))*100 AS percent_ppl_vaccinated
FROM pop_vs_vacc






