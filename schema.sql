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

