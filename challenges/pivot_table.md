# Singles Chart Pivot Table

## Learning Objectives

Continue learning about databases and data manipulation by building a pivot table to display some data. To complete the challenge, you'll need to be able to:

- Insert data from a CSV file into a database table
- Aggregate data in the table using GROUP BY and corresponding aggregate functions. 
- Sort data in the table both in ascending and descending order
- Make design decisions about structuring dynamic database queries to maintain best OO and DRY practices

## Specification

The linked file contains sales data for the top 200 singles across 6 countries between 2000 and 2010. 

https://chart2000.com/data/chart2000-song-2010-decade-0-3-0039.csv

## Specification
Create a web page with a single table to display the information in the file:
- By default, the table displays raw data for the fields: ```Artist | Song | Sales | Position overall```
- The user can apply a filter to the data to display the top songs by country, i.e: ```Artist | Song | Sales | Position by country```
- The user can apply a filter to the data to aggregate by artist, showing the total number of songs and total number of sales, i.e: ```Artist | Total Number of Songs | Total Sales```
- The user can click on any header and sort the table by the data in that column

## Extensions
A number of other data files are available - for example, you can get the top 100 songs for every year (https://chart2000.com/data/chart2000-songyear-0-3-0039.csv) or the top 50 songs for each mong (https://chart2000.com/data/chart2000-songmonth-0-3-0039.csv). A full list of sources is given on https://chart2000.com/about.htm. 

- Try extending the app such that you can specify a date range and aggregate by year or by month. 
- Try adding paging to the table, so you see only 20 results at a time and can click forwards or backwards to see e.g. results 21 to 40, 41 to 60 etc. 
- Try adding the option to view albums rather than songs. 
