------------------------------ filter demo table to 2017--------------------------------------------------------	
ALTER TABLE demo 
DROP "NUMBER", DROP "2010 Total Population",
DROP "2018 Population Estimate";

SELECT * FROM demo

------------------------------filter econ --------------------------------------------------------
ALTER TABLE econ
DROP "2007", DROP "2008", DROP "2009",
DROP "2010", DROP "2011", DROP "2012",
DROP "2013",DROP "2014", DROP "2015", 
DROP "2016", DROP "NUMBER"

------------------------------ Make 2017 integers--------------------------------------------------------
ALTER TABLE econ ADD "2017 GDP" FLOAT;
UPDATE econ SET "2017 GDP" = CAST("2017" AS FLOAT);

------------------------------drop columns--------------------------------------------------------
ALTER TABLE econ
DROP "2017", DROP newcol
SELECT * FROM econ

------------------------------find average GDP-------------------------------------------------------- 
SELECT AVG("2017 GDP")
FROM econ

------------------------------find industryclassification, description, geoname where GDP above AVG----------------------------
SELECT e.geoname, e.description,
		e.industryclassification,
		e."2017 GDP" 
FROM econ AS e
ORDER BY e."2017 GDP" DESC;
---highest GDP is in New York City in Finance,Insurance Field

------------------------------find city with the highest median income--------------------------------------------------------
SELECT d."City",
		d."State",
		d."Number of Companies",
		d."Median Household Income"
FROM demo AS d
ORDER BY d."Median Household Income" desc;
--HIGHEST: San Jose, CA; income: $96,662; # of companies: 77,832
--LOWEST: Detriot, MI; income: $27,838; # of companies: 61,868

------------------------------find GDPs in San Jose CA------------------------------------------------------------
SELECT e."2017 GDP", e.description
FROM econ AS e
WHERE e.geoname LIKE 'San Jose%'
ORDER BY e."2017 GDP" desc;
--HIGHEST GDP: $71,454.1 in Manufactoring; second: $48,407.2 in Information
--4th: Finance, Insurance $31,7555.5

------------------------------find city with highest number of companies--------------------------------------------------------
SELECT d."City",
		d."State",
		d."Number of Companies",
		d."Median Household Income"
FROM demo AS d
ORDER BY d."Number of Companies" asc;
--HIGHEST: Philadelphia, PA; # of companies: 104,439; income: $40,649
--LOWEST: Miami, FL; # of companies: 98,222; income: $52,782

----------------------------find maximum amount of each race and what city--------------------------------------------------------
SELECT MAX("White Alone")
FROM demo;

SELECT "City"
FROM demo
WHERE "White Alone" = 5232835;
---WHITE MAX: 5,232,835 in Los Angeles, CA

SELECT MAX("African American Alone")
FROM demo;

SELECT "City"
FROM demo
WHERE "African American Alone" = 2081507;
---AFRICAN AM MAX: 2,081,507 in New York 

SELECT MAX("American Indian/Alaska Native Alone")
FROM demo;

SELECT "City"
FROM demo
WHERE "American Indian/Alaska Native Alone" = 68211;
---AMERICAN INDIAN MAX: 68,211 in Los Angeles

SELECT MAX("Native Hawaiian Alone")
FROM demo;

SELECT "City"
FROM demo
WHERE "Native Hawaiian Alone" = 27691
---HAWAIIAN MAX: 27,691 in Los Angeles

SELECT MAX("Some Other Race Alone")
FROM demo

SELECT "City"
FROM demo
WHERE "Some Other Race Alone" = 2101084
---OTHER ALONE MAX: 2,101,084 in Los Angeles

SELECT MAX("Two or More Races")
FROM demo

SELECT "City"
FROM demo
WHERE "Two or More Races" = 386412
---MIXED MAX: 386,412 in Los Angeles

SELECT MAX("Hispanic")
FROM demo

SELECT "City"
FROM demo
WHERE "Hispanic" = 4893579
---HISPANIC MAX: 4,893,579 in Los Angeles


------------------------------find what race is most prominent in highest med income-------------------------------------------------------- 
SELECT d."City",
		d."Median Household Income",
		d."White Alone",
		d."African American Alone",
		d."American Indian/Alaska Native Alone",
		d."Native Hawaiian Alone",
		d."Some Other Race Alone",
		d."Two or More Races",
		d."Hispanic"
FROM demo AS d
ORDER BY d."Median Household Income" desc;		
--MOST: WHITE: 416,127 and HISPANIC: 330,827