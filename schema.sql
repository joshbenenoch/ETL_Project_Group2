-- Database: ETL_project

-- DROP DATABASE "ETL_project";

CREATE DATABASE "ETL_project"
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'C'
    LC_CTYPE = 'C'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;
	
-- CREATE econ TABLE

DROP TABLE IF EXISTS econ;

CREATE TABLE econ (
	"NUMBER" VARCHAR(30),
	GeoName VARCHAR(200),
	IndustryClassification VARCHAR(200),
	Description VARCHAR(200),
	"2007" VARCHAR(30),
	"2008" VARCHAR(30),
	"2009" VARCHAR(30),
	"2010" VARCHAR(30),
	"2011" VARCHAR(30),
	"2012" VARCHAR(30),
	"2013" VARCHAR(30),
	"2014" VARCHAR(30),
	"2015" VARCHAR(30),
	"2016" VARCHAR(30),
	"2017" VARCHAR(30)
);

SELECT * FROM econ;

-- IMPORT econ_df.csv INTO econ 

COPY econ_df FROM '/resources/ETL_Project_Group2/econ_df.csv' CSV HEADER

--FILTER econ TABLE 

ALTER TABLE econ
DROP "2007", DROP "2008", DROP "2009",
DROP "2010", DROP "2011", DROP "2012",
DROP "2013",DROP "2014", DROP "2015", 
DROP "2016", DROP "NUMBER"

-- ALTER TABLE strings INTO floats

ALTER TABLE econ ADD "2017 GDP" FLOAT;
UPDATE econ SET "2017 GDP" = CAST("2017" AS FLOAT);

-- DROP extra column

ALTER TABLE econ
DROP "2017", DROP newcol
SELECT * FROM econ

-- CREATE demo TABLE

DROP TABLE IF EXISTS demo;

CREATE TABLE demo (
	"NUMBER" VARCHAR(30),
	"City" VARCHAR(30),
	"State" VARCHAR(5),
	"2010 Total Population" INT,
	"2018 Population Estimate" VARCHAR(30),
	"2017 Population Estimate" INT,
	"Median Age" VARCHAR(30),
	"Number of Companies" VARCHAR(30),
	"Education (HS or Higher)" VARCHAR(30),
	"Total Housing Units" INT,
	"Median Household Income" INT,
	"Foreign Born Population" INT,
	"White Alone" INT,
	"African American Alone" INT,
	"American Indian/Alaska Native Alone" INT,
	"Asian Alone" INT,
	"Native Hawaiian Alone" INT,
	"Some Other Race Alone" INT,
	"Two or More Races" INT,
	"Hispanic" INT,
	"White Alone (Not Hispanic or Latino)" INT,
	"Veterans" INT
);

SELECT * FROM demo;

-- IMPORT demo_df.csv INTO econ

COPY demo_df FROM '/resources/ETL_Project_Group2/demo_df.csv' CSV HEADER

--FILTER demo TABLE

ALTER TABLE demo 
DROP "NUMBER", DROP "2010 Total Population",
DROP "2018 Population Estimate";

SELECT * FROM demo

-- Table: public.cities

-- DROP TABLE public.cities;

CREATE TABLE public.cities
(
    _2012metro text COLLATE pg_catalog."default",
    _2017metro text COLLATE pg_catalog."default",
    wikipediametro text COLLATE pg_catalog."default",
    city text COLLATE pg_catalog."default",
    state text COLLATE pg_catalog."default"
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.cities
    OWNER to postgres;

-- IMPORT cities.csv into TABLE

COPY cities FROM '/resources/ETL_Project_Group2/cities.csv' CSV HEADER;

SELECT * FROM cities;

-- FILTER cities TABLE

ALTER TABLE cities
DROP _2012metro;

-- CREATE housing TABLE 

DROP TABLE IF EXISTS housing;

CREATE TABLE housing (
	"Date" VARCHAR(30),
	"Atlanta" FLOAT,
	"Boston" FLOAT,
	"Charlotte" FLOAT,
	"Chicago" FLOAT,
	"Cleveland" FLOAT,
	"Dallas" FLOAT,
	"Denver" FLOAT,
	"Detroit" FLOAT,
	"Las Vegas" FLOAT,
	"Los Angeles" FLOAT,
	"Miami" FLOAT,
	"Minneapolis" FLOAT,
	"New York City" FLOAT,
	"Pheonix" FLOAT,
	"Portland" FLOAT,
	"San Diego" FLOAT,
	"San Francisco" FLOAT,
	"Seattle" FLOAT,
	"Tampa Bay Area" FLOAT,
	"Washington" FLOAT
);

-- IMPORT housedata.csv INTO TABLE housing

COPY housing FROM '/resources/ETL_Project_Group2/housedata.csv' CSV HEADER;

-- CREATE attendance TABLE 

CREATE TABLE attendance (
	"City" VARCHAR(50),
	"Team" VARCHAR(50),
	"League" VARCHAR(50),
	"Year" INT,
	"Home_GMS" INT,
	"Home_AVG" TEXT,
	"Home_PCT" TEXT,
	"Road_GMS" INT,
	"Road_AVG" TEXT,
	"Road_PCT" FLOAT,
	"Over_GMS" INT,
	"Over_AVG" TEXT,
	"Over_PCT" FLOAT
);

-- IMPORT attendance.csv INTO TABLE attendance 

COPY attendance FROM '/resources/ETL_Project_Group2/attendance/attendance.csv' CSV HEADER;

-- CREATE TABLE sport_city

DROP TABLE IF EXISTS sport_city;

CREATE TABLE sport_city (
	"Metro" TEXT,
	"City" TEXT,
	"State" VARCHAR(5),
	"NFL" TEXT,
	"MLB" TEXT,
	"NBA" TEXT,
	"NHL" TEXT
);

-- IMPORT sport_city.csv INTO TABLE sport_city

COPY sport_city FROM '/resources/ETL_Project_Group2/attendance/sport_city.csv' CSV HEADER;

-- CREATE INNER JOIN FOR cities, demo, housing, attendance and econ TABLES

SELECT d."City", d."State",
		d."2017 Population Estimate",
		d."Median Age", d."Number of Companies",
		d."Education (HS or Higher)", 
		d."Median Household Income", 
		d."Foreign Born Population", 
		d."White Alone", 
		d."African American Alone", 
		d."American Indian/Alaska Native Alone", 
		d."Asian Alone",
		d."Native Hawaiian Alone", 
		d."Some Other Race Alone",
		d."Two or More Races", d."Hispanic",
		d."White Alone (Not Hispanic or Latino)", 
		d."Veterans",
		ci._2017metro,
		e.industryclassification, 
		e.description, e."2017 GDP",
		s."NFL", s."MLB",
		s."NBA", s."NHL",
		a."Team", a."League",
		a."Year", a."Home_GMS",
		a."Road_GMS", a."Over_GMS",
		a."Home_AVG", a."Road_AVG",
		a."Over_AVG", a."Home_PCT",
		a."Road_PCT", a."Over_PCT"
FROM demo AS d
INNER JOIN cities AS ci ON
ci.city = d."City" and ci.state = d."State"
INNER JOIN econ AS e ON
e.geoname = ci._2017metro
INNER JOIN sport_city AS s ON
s."State" = d."State"
INNER JOIN attendance AS a ON
a."City" = d."City"
;

