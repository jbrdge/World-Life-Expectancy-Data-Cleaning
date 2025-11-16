# World Life Expectancy Data Cleaning Project
This project is a data cleaning walkthrough example from analystbuilder.com

## 1) The first process, removing duplicate rows, goes as follows:
- Import data from CSV using table import wizard
- Import a duplicate for transforming table  
  <img align="center" src="https://raw.githubusercontent.com/jbrdge/World-Life-Expectancy-Data-Cleaning/main/imgs/001.png">
- Identify duplicate rows by first creating unique identifier column (no true duplicates because of row number)
- Remove Duplicates
  

## 2) Second, we fill empty 'Status' rows
- identify empty 'Status' rows
  <img align="center" src="https://raw.githubusercontent.com/jbrdge/World-Life-Expectancy-Data-Cleaning/main/imgs/003.png">
- identify distinct status which are not empty
- look at  a list of developing/developed countries
  <img align="center" src="https://raw.githubusercontent.com/jbrdge/World-Life-Expectancy-Data-Cleaning/main/imgs/004.png">
- compare table against itself with self-join
  <img align="center" src="https://raw.githubusercontent.com/jbrdge/World-Life-Expectancy-Data-Cleaning/main/imgs/005.png">
- use that knowledge to update the table
  <img align="center" src="https://raw.githubusercontent.com/jbrdge/World-Life-Expectancy-Data-Cleaning/main/imgs/006.png">


## 3) Finally, we fill empty Life Expectancy rows
- use average of previous and next
  <img align="center" src="https://raw.githubusercontent.com/jbrdge/World-Life-Expectancy-Data-Cleaning/main/imgs/007.png">
  <img align="center" src="https://raw.githubusercontent.com/jbrdge/World-Life-Expectancy-Data-Cleaning/main/imgs/008.png">
