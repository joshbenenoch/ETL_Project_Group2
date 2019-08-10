# ETL_Project_Group2

* Beatriz Rodriguez
* Ezra Kenigsberg
* Josh Benenoch

## OBJECTIVE:
### Our objective is to perform ETL on various data sets to be able to analyze the difference in average attendance in sporting events for large market cities versus small market cities, how average attendance has changed over time in the cities and how demographic/economical change in those cities plays a factor.

## DATA SOURCES:

Our data sources are:
   - **ESPN** - Sporting event attendance data
   - **St. Louis Fed** - Case-Shiller Home Price Index
   - **U.S. Census** - American Community Survey
   - **U.S. Department of Commerce** - Bureau of Economic Analysis - Regional Economic Accounts
   - **Wikipedia** - list of teams by metropolitan area

## DATA CLEANUP AND TRANSFORMATION:

   We will utilize Python pandas for our data transformation and will load the transformed data into PostgreSQL.

## PROJECT REPORT:

Our project report will include:
   - our raw data files from its various sources
   - our transformation jupyter notebook .ipynb files with comments explaining transformation process
   - our final PostgreSQL table(s) in schema.sql form

## PROJECT STEP-BY-STEP:
* [**The procedural steps are best viewed in its original Google Sheets format.**](https://docs.google.com/spreadsheets/d/1o01a_iAf8WX7i2Q-2Ek58JelQoEaH1QxlbUXwEeRIA8/edit?usp=sharing)
* Alternately, view the [PDF version within this GitHub repo](https://github.com/joshbenenoch/ETL_Project_Group2/blob/master/ETL%20Team%202%20Steps.pdf).
* Alternately alternately, the Google Sheet has been translated into a Markdown table below, but it's tough to read:

|  **Step** | **Input** | **➔** | **Process** | **➔** | **Output** | **Description** |
| :--- | :--- | :---: | :--- | :---: | :--- | :------------------- |
|  1 | [Wikipedia: Teams by Metropolitan Area](https://en.wikipedia.org/wiki/List_of_American_and_Canadian_cities_by_number_of_major_professional_sports_franchises#Teams_by_metropolitan_area "Wikipedia: Teams by Metropolitan Area") | **➔** | Save to CSV | **➔** | cities.csv | **Create Master List of Cities.**<br/>1) Navigate to Wikipedia page,<br/>2) copy & paste results into CSV. Fields:<br/>    • WikipediaMetro<br/>    • City<br/>    • State |
|  2 | [US Census:<br/>➔American FactFinder:<br/>➔➔Community Facts](https://factfinder.census.gov/faces/nav/jsf/pages/community_facts.xhtml "US Census:<br/>➔American FactFinder:<br/>➔➔Community Facts") | **➔** | Save to CSV | **➔** | City_Demographic.csv | **Create Demographic Data Set.**<br/>1) Navigate to FactFinder UI,<br/>2) search for each city,<br/>3) copy & paste results into CSV |
|  3 | • cities.csv<br/>• City_Demographic.csv | **➔** | [Run Jupyter Notebook<br/>"demo_df.ipynb"](https://github.com/joshbenenoch/ETL_Project_Group2/blob/master/demo_df.ipynb) | **➔** | demo_df.csv | **Cleanse Demographic Data Set.** Run Jupyter Notebook to<br/>1) replace "None"s with nulls,<br/>2) save results as a Postgres-ready CSV |
|  4 | [Bureau of Economic Analysis:<br/>➔Regional Economic Accounts:<br/>➔➔Annual GDP by Metropolitan Statistical Area](https://apps.bea.gov/regional/downloadzip.cfm "Bureau of Economic Analysis:<br/>➔Regional Economic Accounts:<br/>➔➔Annual GDP by Metropolitan Statistical Area") | **➔** | Save to CSV | **➔** | MAGDP9_2001_2017_<br/>ALL_AREAS.csv | **Create Economic Data Set.**<br/>1) Navigate to BEA download page,<br/>2) choose "Annual GDP by Metropolitan Statistical Area",<br/>3) extract Real GDP file from downloaded zip |
|  5 | [St. Louis Fed:<br/>➔Case-Shiller House Price Indexes:<br/>➔➔A-L Cities](https://fred.stlouisfed.org/graph/?id=ATXRSA,BOXRSA,CRXRSA,CHXRSA,CEXRSA,DAXRSA,DNXRSA,DEXRSA,LVXRSA,LXXRSA "St. Louis Fed:<br/>➔Case-Shiller House Price Indexes:<br/>➔➔A-L Cities") | **➔** | Save to CSV | **➔** | fredgraph1.csv | **Create House Price Data Set (A-L Cities).**<br/>1) Navigate to Fred graph page,<br/>2) click "Download" to create CSV. |
|  6 | [St. Louis Fed:<br/>➔Case-Shiller House Price Indexes:<br/>➔➔M-Z Cities](https://fred.stlouisfed.org/graph/?id=MIXRSA,MNXRSA,NYXRSA,PHXRSA,POXRSA,SDXRSA,SFXRSA,SEXRSA,TPXRSA,WDXRSA "St. Louis Fed:<br/>➔Case-Shiller House Price Indexes:<br/>➔➔M-Z Cities") | **➔** | Save to CSV | **➔** | fredgraph2.csv | **Create House Price Data Set (M-Z Cities).**<br/>1) Navigate to Fred graph page,<br/>2) click "Download" to create CSV. |
|  7 | cities.csv | **➔** | Enrich Master List of Cities with 2017 Metropolitan Area names | **➔** | cities.csv | Modify Master List of Cities.<br/>Manually add new field to cities.csv to accommodate mapping to 2017 economic data. Field:<br/>    • 2017Metro |
|  8 | • cities.csv<br/>• fredgraph1.csv<br/>• fredgraph2.csv<br/>• MAGDP9_2001_2017_ALL_AREAS.csv | **➔** | [Run Jupyter Notebook<br/>"econdata.ipynb"](https://github.com/joshbenenoch/ETL_Project_Group2/blob/master/econdata.ipynb) | **➔** | • econdata.csv<br/>• housedata.csv | **Cleanse Economic Data Set (1).** Run Jupyter Notebook to<br/>1) merge Case-Shiller data sets,<br/>2) drop unneeded Case-Shiller columns,<br/>3) drop unneeded Real GDP cities,<br/>4) drop low-level Real GDP industry classifications,<br/>5) drop pre-2007 Real GDP data,<br/>6) save results as intermediate CSVs. |
|  9 | econdata.csv | **➔** | [Run Jupyter Notebook<br/>"econ_df.ipynb"](https://github.com/joshbenenoch/ETL_Project_Group2/blob/master/econ_df.ipynb) | **➔** | econ_df.csv | **Cleanse Economic Data Set (2)**. Run Jupyter Notebook to<br/>1) replace "None"s with nulls,<br/>2) cast 2017 column as a float,<br/>3) save results as a Postgres-ready CSV. |
|  10 | [ESPN MLB Attendance](http://www.espn.com/mlb/attendance/_/year/2018 "ESPN MLB Attendance") | **➔** | Save to CSV | **➔** | mlb_attendance.csv | **Create Attendance Data Set (MLB).**<br/>1) Navigate to ESPN site,<br/>2) search for each city,<br/>3) copy & paste results into CSV |
|  11 | [ESPN NBA Attendance](http://www.espn.com/nba/attendance "ESPN NBA Attendance") | **➔** | Save to CSV | **➔** | nba_attendance.csv | **Create Attendance Data Set (NBA).**<br/>1) Navigate to ESPN site,<br/>2) search for each city,<br/>3) copy & paste results into CSV |
|  12 | [ESPN NFL Attendance](http://www.espn.com/nfl/attendance/_/year/2018 "ESPN NFL Attendance") | **➔** | Save to CSV | **➔** | nfl_attendance.csv | **Create Attendance Data Set (NFL).**<br/>1) Navigate to ESPN site,<br/>2) search for each city,<br/>3) copy & paste results into CSV |
|  13 | [ESPN NHL Attendance](http://www.espn.com/nhl/attendance "ESPN NHL Attendance") | **➔** | Save to CSV | **➔** | nhl_attendance.csv | **Create Attendance Data Set (NHL).**<br/>1) Navigate to ESPN site,<br/>2) search for each city,<br/>3) copy & paste results into CSV |
|  14 | cities.csv | **➔** | Enrich Master List of Cities with sports teams names | **➔** | sports_city.csv | **Create Sports_City Data Set.**<br/>1) modify team neams in CSV to avoid data redundancy. |
|  15 | • mlb_attendance.csv<br/>• nba_attendance.csv<br/>• nfl_attendance.csv<br/>• nhl_attendance.csv<br/>• sports_city.csv | **➔** | [Run Jupyter Notebook<br/>"attendance_transformation.ipynb"](https://github.com/joshbenenoch/ETL_Project_Group2/blob/master/attendance/attendance_transformation.ipynb) | **➔** | attendance.csv | **Create Attendance Data Set.**<br/>1) import dependencies and read all attendance CSV files,<br/>2) create LEAGUE column to identify associated sports,<br/>3) concatenate all imported attendance data CSV files into single dataframe,<br/>4) create dictionary from sports_city.csv to hold team and city association,<br/>4) create function to loop through dictionary and identify team names and associated city,<br/>5) add CITY column to dataframe and apply function to add city to column based on team name,<br/>6) drop unwanted columns from dataframe,<br/>7) rename and re-order columns |
|  16 | • attendance.csv<br/>• cities.csv<br/>• demo_df.csv<br/>• econ_df.csv<br/>• housedata.csv | **➔** | [Run Postgres script<br/>"schema.sql"](https://github.com/joshbenenoch/ETL_Project_Group2/blob/master/schema.sql) | **➔** | Postgres Tables<br/>• attendance<br/>• cities<br/>• demo<br/>• econ<br/>• housing<br/>• sport_city | **Create Postgres Tables.**<br/>1) create each individual table and add column names<br/>with specific data types, <br/>2) import CSVs into tables, <br/>3) alter tables by dropping unwated columns, <br/>4) combine all tables by creating an inner join through <br/>mutual columns. |

## RESULTS:
* Sample Screenshot #0, showing merged demographic data
![Sample Screenshot from Postgres #0](https://github.com/joshbenenoch/ETL_Project_Group2/blob/master/Postgres%20Screenshot.png "Postgres Sample Screenshot #0")
* Sample Screenshot #1, showing merged attendance and GDP Industry data
![Sample Screenshot from Postgres #1](https://github.com/joshbenenoch/ETL_Project_Group2/blob/master/Postgres%20Screenshot1.png "Postgres Sample Screenshot #1")
