/*
Covid 19 Data Exploration 

Skills usadas: Joins, CTE's, Temp Tables, Windows Functions, Aggregate Functions, Creating Views, Converting Data Types

*/

-- Vizualizar tabelas
SELECT *
FROM portfolio_project.dbo.CovidDeaths;

SELECT *
FROM portfolio_project.dbo.CovidVaccinations;

-- Seleciona os dados que ser�o utilizados
SELECT Location,
       date,
	   total_cases,
	   new_cases,
	   total_deaths,
	   population
FROM portfolio_project.dbo.CovidDeaths
ORDER BY 1, 2;

-- Total de Casos VS Total de Mortes <- MUNDIALMENTE
-- Mostra a probabilidade de morte se voc� contrair Covid-19
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

-- Total de casos VS Popula��o <- MUNDIALMENTE
-- Mostra quantos porcento da popula��o contraiu Covid-19
SELECT Location,
       date,
       SUM(total_cases) AS total_cases,
       SUM(population) AS population,
       (CAST(SUM(total_cases) AS FLOAT) / NULLIF(CAST(SUM(population) AS FLOAT), 0)) * 100 AS PopulationInfected
FROM portfolio_project.dbo.CovidDeaths
GROUP BY Location, date
ORDER BY Location, date;

-- Total de casos VS Popula��o <- BRAZIL
SELECT Location,
       date,
       SUM(total_cases) AS total_cases,
       SUM(population) AS population,
       (CAST(SUM(total_cases) AS FLOAT) / NULLIF(CAST(SUM(population) AS FLOAT), 0)) * 100 AS PopulationInfected
FROM portfolio_project.dbo.CovidDeaths
WHERE location = 'Brazil'
GROUP BY Location, date
ORDER BY Location, date;

-- Pa�ses com as maiores taxas de infec��o comparado a popula��o
SELECT Location,
       MAX(total_cases) AS total_cases,
       MAX(population) AS population,
       MAX(CAST(total_cases AS FLOAT) / NULLIF(CAST(population AS FLOAT), 0)) * 100 AS HighestInfection
FROM portfolio_project.dbo.CovidDeaths
GROUP BY Location, population
ORDER BY HighestInfection DESC;

-- Pa�ses com maiores contagens de morte por popula��o
SELECT Location,
       MAX(total_deaths) AS total_death_count
FROM portfolio_project.dbo.CovidDeaths
GROUP BY Location
ORDER BY total_death_count DESC;

-- N�meros globais
SELECT SUM(new_cases) AS total_cases,
       SUM(new_deaths) total_deaths,
	   SUM(new_deaths) / NULLIF(SUM(CAST(new_cases AS FLOAT)), 0)*100 AS DeathPercentage
FROM portfolio_project.dbo.CovidDeaths
ORDER BY 1, 2;

-- -----------------------
-- AN�LISE POR VACINA��O
-- -----------------------

-- USAR express�o de tabela comum (CTE)
WITH pop_vs_vacc (continent, location, date, population, new_vaccinations, rolling_ppl_vaccinated)
AS
(
-- Popula��o total VS Vacina��es
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






