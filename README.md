# World Life Expectancy Data Cleaning Project
This project is a data cleaning walkthrough example from analystbuilder.com
This README represents my notes.

## 1) The first process, removing duplicate rows, goes as follows:
- Import data from CSV using table import wizard
- Import a duplicate for transforming table  
  <img align="center" src="https://raw.githubusercontent.com/jbrdge/World-Life-Expectancy-Data-Cleaning/main/imgs/001.png">
- Identify duplicate rows by first creating unique identifier column (no true duplicates because of row number)
- Remove Duplicates  
<img align="center" src="https://raw.githubusercontent.com/jbrdge/World-Life-Expectancy-Data-Cleaning/main/imgs/002a.png">


## 2) Second, we fill empty 'Status' rows
- identify empty 'Status' rows  
  <img align="center" src="https://raw.githubusercontent.com/jbrdge/World-Life-Expectancy-Data-Cleaning/main/imgs/003.png">
- identify distinct status which are not empty
- look at  a list of developing/developed countries  
  <img align="center" src="https://raw.githubusercontent.com/jbrdge/World-Life-Expectancy-Data-Cleaning/main/imgs/004.png">
- compare table against itself with self-join  
- use that knowledge to update the table
  <img align="center" src="https://raw.githubusercontent.com/jbrdge/World-Life-Expectancy-Data-Cleaning/main/imgs/005.png">  
  <img align="center" src="https://raw.githubusercontent.com/jbrdge/World-Life-Expectancy-Data-Cleaning/main/imgs/006.png">


## 3) Finally, we fill empty Life Expectancy rows
- use average of previous and next  
  <img align="center" src="https://raw.githubusercontent.com/jbrdge/World-Life-Expectancy-Data-Cleaning/main/imgs/007.png">  
  <img align="center" src="https://raw.githubusercontent.com/jbrdge/World-Life-Expectancy-Data-Cleaning/main/imgs/008.png">


# Exploratory Data Analysis

## 4) We can observe who has had the greatest change in life expectancy
<img align="center" src="https://raw.githubusercontent.com/jbrdge/World-Life-Expectancy-Data-Cleaning/main/imgs/009.png">


## 5) We can observe who has had the yearly average life expectancy
<img align="center" src="https://raw.githubusercontent.com/jbrdge/World-Life-Expectancy-Data-Cleaning/main/imgs/010.png">

## 6) We can inspect the data to observe that Greater GDP correlates with Greater Life expectancy

<img align="center" src="https://raw.githubusercontent.com/jbrdge/World-Life-Expectancy-Data-Cleaning/main/imgs/011.png">
<img align="center" src="https://raw.githubusercontent.com/jbrdge/World-Life-Expectancy-Data-Cleaning/main/imgs/012.png">

### You would use Tableau or Power BI and plug in this query to verify  
I export this Query to CSV  
<img align="center" src="https://raw.githubusercontent.com/jbrdge/World-Life-Expectancy-Data-Cleaning/main/imgs/013.png">

Sidequest: Import data to Tableau
### [View in my Tableau Public page](https://public.tableau.com/app/profile/jacob.breckenridge/viz/WorldLifeExpectancyExploratoryDataAnalysis/Dashboard1?publish=yes)

Use this Window Correlation Function
<img align="center" src="https://raw.githubusercontent.com/jbrdge/World-Life-Expectancy-Data-Cleaning/main/imgs/014.png">

We get a corrrelation of 0.6134, which means it's mostly a positive correlation, which matches our inspection.  
<img align="center" src="https://raw.githubusercontent.com/jbrdge/World-Life-Expectancy-Data-Cleaning/main/imgs/015.png">



