create database airlines;
use airlines;
select * from maindata;

## Total Airlines
SELECT COUNT(DISTINCT `Carrier Name`) AS Total_Airlines FROM maindata;


## Avg Air Time in Hours
SELECT CONCAT(ROUND(AVG(`# Air Time`) / 60, 2), ' hrs') AS Avg_Air_Time FROM maindata;


## Load Factor Percentage (Yearly, Monthly, Quarterly)
SELECT `Year`, `Month (#)`, 
QUARTER(STR_TO_DATE(CONCAT(`Year`, '-', `Month (#)`, '-01'), '%Y-%m-%d')) AS Quarter, `Carrier Name`,
CONCAT(ROUND((SUM(`# Transported Passengers`) / NULLIF(SUM(`# Available Seats`), 0)) * 100, 2), '%') AS Load_Factor_Percentage
FROM maindata GROUP BY `Year`, `Month (#)`, `Carrier Name`
HAVING SUM(`# Available Seats`) > 0     -- Excludes rows where Available Seats is NULL or 0
ORDER BY `Year` ASC, `Month (#)` ASC, `Carrier Name` ASC;


## Load Factor by Carrier Name
SELECT `Carrier Name`, 
CONCAT(ROUND((SUM(`# Transported Passengers`) / NULLIF(SUM(`# Available Seats`), 0)) * 100, 2), '%') AS Load_Factor_Percentage
FROM maindata GROUP BY `Carrier Name` ORDER BY Load_Factor_Percentage DESC;


## Top Routes (From-To City) Based on Number of Flights
SELECT `From - To City`, 
CONCAT(ROUND(SUM(`# Departures Performed`) / 1000, 2), 'K') AS Total_Flights
FROM maindata GROUP BY `From - To City` ORDER BY SUM(`# Departures Performed`) DESC LIMIT 10;


## Top 10 Busiest Airlines 
SELECT `Carrier Name`, 
CONCAT(ROUND(SUM(`# Transported Passengers`) / 1000000, 2), 'M') AS Total_Passengers
FROM maindata GROUP BY `Carrier Name` ORDER BY SUM(`# Transported Passengers`) DESC LIMIT 10;


## Busiest Airports
SELECT `Origin Airport Code` AS Airport_Code, `Origin City` AS City, `Origin Country` AS Country,
CONCAT(ROUND(SUM(`# Departures Performed`) / 1000, 2), 'K') AS Total_Flights
FROM maindata GROUP BY `Origin Airport Code`, `Origin City`, `Origin Country` ORDER BY SUM(`# Departures Performed`) DESC LIMIT 10;
