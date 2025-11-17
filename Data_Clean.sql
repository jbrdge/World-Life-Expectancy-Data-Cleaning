# First, import data from CSV using table import wizard
# Second, import a duplicate for transforming table

# View data
SELECT
	* 
FROM world_life_expectancy;


# Identify duplicate rows
SELECT
	Country,
    Year,
    CONCAT(Country, Year),
    COUNT(CONCAT(COUNTRY, Year)) count_of
FROM world_life_expectancy
GROUP BY Country, Year, CONCAT(Country, Year)
HAVING count_of > 1
;

# Give Row Numbers to identify duplicates
SELECT 
	*
FROM (
	SELECT
		ROW_ID,
		CONCAT(Country, Year),
        ROW_NUMBER() OVER(
			PARTITION BY CONCAT(Country, Year) 
            ORDER BY CONCAT(Country, Year)
		) as Row_Num
	FROM world_life_expectancy
) AS Row_table
WHERE Row_Num > 1
;

# Make sure there is a backup, now delete the duplicate rows
DELETE FROM world_life_expectancy
WHERE
	ROW_ID IN (
		SELECT ROW_ID
		FROM (
        	SELECT
				ROW_ID,
				CONCAT(Country, Year),
				ROW_NUMBER() OVER(
					PARTITION BY CONCAT(Country, Year) 
					ORDER BY CONCAT(Country, Year)
				) as Row_Num
		FROM world_life_expectancy
	) AS Row_table
	WHERE Row_Num > 1
)
;

# Now we identify empty 'Status' rows
SELECT 
	*
FROM world_life_expectancy
WHERE Status = ''
;

# We Want to identify distinct status which are not empty
# Results are (Developing, Developed)
SELECT
	DISTINCT(Status)
FROM world_life_expectancy
WHERE Status <> ''
;


# We can look at  a list of developing countries
SELECT DISTINCT(Country)
FROM world_life_expectancy
WHERE Status = 'Developing'
;

# Or a list of developed countries
SELECT DISTINCT(Country)
FROM world_life_expectancy
WHERE Status = 'Developed'
;

# We want to use that knowledge to update the table.
# We have to use conditional and a self-join to do look through the first table, find empty 'Status' rows
# if the status is empty, check the second table to see if the same country has a non-empty status.
# Use this info to fill empty row with 'Developing' or 'Developed'
UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country
SET t1.Status = 'Developing'
WHERE t1.Status = ''
AND t2.Status <> ''
AND t2.Status = 'Developing'
;

UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country
SET t1.Status = 'Developed'
WHERE t1.Status = ''
AND t2.Status <> ''
AND t2.Status = 'Developed'
;

# Now we want to clean empty life expectancy rows.
SELECT
	Country,
    Year,
    `Life expectancy`
FROM world_life_expectancy
WHERE `Life expectancy` = ''
;


# Will use previous and next Life expectancy to fill empties with average
# check math by adding new column, carry this forward with an UPDATE
SELECT 
	t1.Country, t1.Year, t1.`Life expectancy`,
	t2.Country, t2.Year, t2.`Life expectancy`,
	t3.Country, t3.Year, t3.`Life expectancy`,
    ROUND((t2.`Life expectancy` + t3.`Life expectancy`) /2,1)
FROM world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country
    AND t1.Year = t2.Year - 1
JOIN world_life_expectancy t3
	ON t1.Country = t3.Country
    AND t1.Year = t3.Year + 1
WHERE t1.`Life expectancy` = ''
;


UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country
    AND t1.Year = t2.Year - 1
JOIN world_life_expectancy t3
	ON t1.Country = t3.Country
    AND t1.Year = t3.Year + 1
SET t1.`Life expectancy` = ROUND((t2.`Life expectancy` + t3.`Life expectancy`) /2,1)
WHERE t1.`Life expectancy` = ''
;


# Now we can do some analysis

# Determine greatest delta in 15 years
SELECT 
	Country,
	MIN(`Life expectancy`),
	MAX(`Life expectancy`),
    ROUND(MAX(`Life expectancy`) - MIN(`Life expectancy`),1) AS Life_Increase_15_Years
FROM world_life_expectancy
GROUP BY country
HAVING MIN(`Life expectancy`) <> 0
AND MAX(`Life expectancy`) <> 0
ORDER BY Life_Increase_15_Years DESC
;

# Determine greatest yearly averages
SELECT
	Year,
	ROUND(AVG(`Life expectancy`),2)
FROM world_life_expectancy
WHERE `Life expectancy` <> 0
AND `Life expectancy` <> 0
GROUP BY Year
ORDER BY Year
;


# We can inspect the data to observe that Greater GDP correlates with Greater Life expectancy
SELECT
	Country,
	ROUND(AVG(`Life expectancy`),1) AS Life_Exp,
    ROUND(AVG(GDP),1) AS GDP
FROM world_life_expectancy
GROUP BY Country
HAVING Life_Exp > 0
AND GDP > 0
ORDER BY GDP ASC
;


# We can also group upper and lower GDPs and find an average life expectancy for them
SELECT
	SUM(CASE WHEN GDP >= 1150 THEN 1 ELSE 0 END) High_GDP_Count,
	AVG(CASE WHEN GDP <= 1150 THEN `Life expectancy` ELSE NULL END) High_GDP_Life_Expectancy,
	SUM(CASE WHEN GDP <= 1150 THEN 1 ELSE 0 END) Low_GDP_Count,
	AVG(CASE WHEN GDP >= 1150 THEN `Life expectancy` ELSE NULL END) High_GDP_Life_Expectancy
FROM lifeexpectancy.world_life_expectancy
;

