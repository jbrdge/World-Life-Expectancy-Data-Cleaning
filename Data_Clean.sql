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
SELECT *
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
