-- Write queries to return the following:
-- Make the following changes in the "world" database.

-- 1. Add Superman's hometown, Smallville, Kansas to the city table. The
-- countrycode is 'USA', and population of 45001.
INSERT INTO city(name, countrycode, district, population)
VALUES ('Smallville', 'USA', 'Kansas', 45001);

SELECT *
FROM city
WHERE name = 'Smallville';


-- 2. Add Kryptonese to the countrylanguage table. Kryptonese is spoken by 0.0001
-- percentage of the 'USA' population.

INSERT INTO countrylanguage(countrycode, language, isofficial, percentage)
VALUES ('USA', 'Kryptonese', false, 0.0001);

SELECT *
FROM countrylanguage
WHERE language = 'Kryptonese';

-- 3. After heated debate, "Kryptonese" was renamed to "Krypto-babble." Change
-- the appropriate record accordingly.

UPDATE countrylanguage
SET language = 'Krypto-babble'
WHERE language = 'Kryptonese';

-- 4. Set the US capital to Smallville, Kansas in the country table.

UPDATE country
SET capital = (SELECT id FROM city WHERE name = 'Smallville')
WHERE code = 'USA';

SELECT country.code AS country, city.name AS capital
FROM country
JOIN city ON country.capital = city.id
WHERE code = 'USA';


-- 5. Delete Smallville, Kansas from the city table. (Did it succeed? Why?)
DELETE FROM city
WHERE name = 'Smallville';

--It didn't succeed because it violates the foreign key constraint. 
--It's used on country table for the capital.

-- 6. Return the US capital to Washington.
UPDATE country
SET capital = (SELECT id FROM city WHERE name = 'Washington')
WHERE code = 'USA';

SELECT country.code AS country, city.name AS capital
FROM country
JOIN city ON country.capital = city.id
WHERE code = 'USA';

-- 7. Delete Smallville, Kansas from the city table. (Did it succeed? Why?)

DELETE FROM city
WHERE name = 'Smallville';
--Smallville was removed from the country table, therefore it is able to be deleted from the city table

-- 8. Reverse the "is the official language" setting for all languages where the
-- country's year of independence is within the range of 1800 and 1972
-- (exclusive).
-- (590 rows affected)

UPDATE countrylanguage
SET isofficial = NOT isofficial
FROM country
WHERE countrylanguage.countrycode = country.code AND country.indepyear > 1800 AND country.indepyear < 1972; 

-- 9. Convert population so it is expressed in 1,000s for all cities. (Round up to
-- the nearest integer value.)
-- (4079 rows affected)

UPDATE city
SET population = ceiling(population / 1000);

-- 10. Assuming a country's surfacearea is expressed in square miles, convert it to
-- square meters for all countries where French is spoken by more than 20% of the
-- population.
-- (7 rows affected)

UPDATE country
SET surfacearea = surfacearea * 2.59e+6
FROM countrylanguage
WHERE countrylanguage.countrycode = country.code AND countrylanguage.language = 'French' AND countrylanguage.percentage > 20.0;
