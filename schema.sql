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

COPY cities FROM '/resources/ETL_Project_Group2/cities.csv' CSV HEADER;

SELECT * FROM cities;

ALTER TABLE cities
DROP _2012metro;

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
		ci._2017metro, ci.wikipediametro,
		e.industryclassification, 
		e.description, e."2017 GDP"
		
FROM demo AS d
INNER JOIN cities AS ci ON
ci.state = d."State" and ci.city = d."City"
INNER JOIN econ AS e ON
e.geoname = ci._2017metro
		
