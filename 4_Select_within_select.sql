-- 1. List each country name where the population is larger than that of 'Russia'.
SELECT name FROM world
  WHERE population >
     (SELECT population FROM world
      WHERE name='Russia')
      
-- 2. Show the names of countries in Europe with a per capita GDP greater than 'United Kingdom'.
SELECT name from world
  WHERE gdp/population > (SELECT gdp/population from world where name='United Kingdom') and continent ='Europe'
  
-- 3. List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country.
SELECT name, continent from world
  WHERE continent = (SELECT continent from world WHERE name='Argentina')
  OR continent = (SELECT continent from world WHERE name='Australia')
  ORDER BY name, continent

-- 4. Which country has a population that is more than Canada but less than Poland? Show the name and the population.
SELECT name, population from world
  WHERE population > (SELECT population FROM world where name='Canada')
    AND population < (SELECT population FROM world where name='Poland')
    
-- 5. Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany.
SELECT name,CONCAT(ROUND(population/ (SELECT population from world where name='Germany')*100,0),'%') from world
  WHERE continent = 'Europe'
  
-- 6. Which countries have a GDP greater than every country in Europe? [Give the name only.] (Some countries may have NULL gdp values)
SELECT name from world 
  WHERE gdp >(SELECT MAX(gdp) from world WHERE continent='Europe')

-- 7. Find the largest country (by area) in each continent, show the continent, the name and the area:
SELECT continent, name, area FROM world x
  WHERE area >= ALL
    (SELECT area FROM world y
        WHERE y.continent=x.continent
          AND area>0)
          
-- 8. List each continent and the name of the country that comes first alphabetically.
SELECT DISTINCT(continent) cont,(SELECT name from world WHERE continent=cont LIMIT 1) from world 

-- 9. Find the continents where all countries have a population <= 25000000. Then find the names of the countries associated with these continents. Show name, continent and population.

