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
