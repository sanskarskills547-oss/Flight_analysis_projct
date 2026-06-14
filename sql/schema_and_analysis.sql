use flight_analysis;
SELECT 
    *
FROM
    meta_data;

CREATE TABLE airline (
    airline_id INT PRIMARY KEY,
    unique_carrier VARCHAR(10),
    unique_carrier_name VARCHAR(100),
    unique_carrier_Entity VARCHAR(10)
);

CREATE TABLE airport (
    airport_id INT PRIMARY KEY,
    airport_seq_id INT,
    city_market_id INT,
    airport_code VARCHAR(10),
    city_name VARCHAR(100),
    state_abr CHAR(2),
    state_fips INT,
    state_nm VARCHAR(100),
    wac INT
);


CREATE TABLE flight (
    flight_id INT AUTO_INCREMENT PRIMARY KEY,
    airline_id INT,
    origin_airport_id INT,
    dest_airport_id INT,
    distance FLOAT,
    distance_group INT,
    year INT,
    quarter INT,
    month INT,
    class CHAR(1),
    FOREIGN KEY (airline_id)
        REFERENCES airline (airline_id),
    FOREIGN KEY (origin_airport_id)
        REFERENCES airport (airport_id),
    FOREIGN KEY (dest_airport_id)
        REFERENCES airport (airport_id)
);


CREATE TABLE flightmetrics (
    flight_id INT,
    passengers FLOAT,
    freight FLOAT,
    mail FLOAT,
    FOREIGN KEY (flight_id)
        REFERENCES flight (flight_id)
);
 
CREATE TABLE city (
    cityID INT AUTO_INCREMENT PRIMARY KEY,
    cityname VARCHAR(100),
    state_abr CHAR(2),
    state_nm VARCHAR(100),
    UNIQUE (cityname , state_abr)
);

SELECT 
    *
FROM
    airline;
insert ignore into airline(airline_id,unique_carrier,unique_carrier_name,unique_carrier_Entity) 
select distinct airline_id,unique_carrier,unique_carrier_name,unique_carrier_Entity from meta_data
where airline_id is not null ;
SELECT 
    *
FROM
    meta_data;
insert ignore into airport(airport_id,airport_seq_id,city_market_id,airport_code,city_name,state_abr,state_fips,state_nm,wac)
select distinct 
ORIGIN_AIRPORT_ID,
ORIGIN_AIRPORT_SEQ_ID,
ORIGIN_CITY_MARKET_ID,
ORIGIN,
ORIGIN_CITY_NAME,
ORIGIN_STATE_ABR,
ORIGIN_STATE_FIPS,
ORIGIN_STATE_NM,
ORIGIN_WAC
from meta_data;


insert into airport(airport_id,airport_seq_id,city_market_id,airport_code,city_name,state_abr,state_fips,state_nm,wac)
select distinct 
DEST_AIRPORT_ID,
DEST_AIRPORT_SEQ_ID,
DEST_CITY_MARKET_ID,
DEST,
DEST_CITY_NAME,
DEST_STATE_ABR,
DEST_STATE_FIPS,
DEST_STATE_NM,
DEST_WAC
from meta_data
where DEST_AIRPORT_ID not in (select airport_id from airport);

SELECT 
    *
FROM
    meta_data;

insert into flight( airline_id, origin_airport_id, dest_airport_id, distance, distance_group, year, quarter, month, class)
select AIRLINE_ID,ORIGIN_AIRPORT_ID,DEST_AIRPORT_ID,distance,DISTANCE_GROUP,Year,quarter,month,class from meta_data;

SELECT 
    *
FROM
    meta_data;
alter table city add column state_nm varchar(100);
  insert into city( cityname, state_abr,state_nm)
  select 
  distinct ORIGIN_CITY_NAME,ORIGIN_STATE_ABR,ORIGIN_STATE_NM from meta_data
  union 
  select distinct DEST_CITY_NAME,DEST_STATE_ABR,DEST_STATE_NM from meta_data;
  
INSERT ignore INTO FlightMetrics( FLIGHT_ID, PASSENGERS, FREIGHT, MAIL )
SELECT f.FLIGHT_ID, m.PASSENGERS, m.FREIGHT, m.MAIL 
FROM Meta_Data m 
JOIN Flight f ON f.AIRLINE_ID = m.AIRLINE_ID 
AND 
f.ORIGIN_AIRPORT_ID = m.ORIGIN_AIRPORT_ID 
AND 
f.DEST_AIRPORT_ID = m.DEST_AIRPORT_ID 
AND 
f.YEAR = m.YEAR 
AND 
f.MONTH = m.MONTH 
AND 
f.QUARTER = m.QUARTER 
AND 
f.DISTANCE = m.DISTANCE;

SELECT 
    f.origin_airport_id,
    F.DEST_airport_id,
    a1.city_name AS origin_city,
    a2.city_name AS dest_city,
    SUM(fm.passengers)
FROM
    flight f
        JOIN
    flightmetrics fm ON f.flight_id = fm.flight_id
        JOIN
    airport a1 ON f.origin_airport_id = a1.airport_id
        JOIN
    airport a2 ON f.dest_airport_id = a2.airport_id
GROUP BY f.origin_airport_id , F.DEST_airport_id
ORDER BY SUM(fm.passengers) DESC
LIMIT 10;

SELECT 
    f.year, f.month, SUM(fm.passengers) / 10000000 AS total
FROM
    flight F
        JOIN
    flightmetrics fm ON f.flight_id = fm.flight_id
GROUP BY f.year , f.month;

/* determine average passengers per flight for various routes and airport */

SELECT 
    f.origin_airport_id,
    a.city_name AS origin_city,
    COUNT(f.flight_id) AS total_flights,
    SUM(fm.passengers) AS total_passengers,
    ROUND(AVG(fm.passengers), 2) AS avg_passengers_per_flight
FROM
    flight f
        JOIN
    flightmetrics fm ON f.flight_id = fm.flight_id
        JOIN
    airport a ON f.origin_airport_id = a.airport_id
GROUP BY f.origin_airport_id , a.city_name;
SELECT 
    f.dest_airport_id,
    a.city_name AS origin_city,
    COUNT(f.flight_id) AS total_flights,
    SUM(fm.passengers) AS total_passengers,
    ROUND(AVG(fm.passengers), 2) AS avg_passengers_per_flight
FROM
    flight f
        JOIN
    flightmetrics fm ON f.flight_id = fm.flight_id
        JOIN
    airport a ON f.dest_airport_id = a.airport_id
GROUP BY f.dest_airport_id , a.city_name
ORDER BY avg_passengers_per_flight DESC;

/* assess flight frequency and identify high traffic corridors */

SELECT 
    f.origin_airport_id,
    f.dest_airport_id,
    a1.city_name AS origin_city,
    a2.city_name AS dest_city,
    COUNT(f.flight_id) AS total_flight
FROM
    flight f
        JOIN
    airport a1 ON f.origin_airport_id = a1.airport_id
        JOIN
    airport a2 ON f.dest_airport_id = a2.airport_id
GROUP BY f.origin_airport_id , f.dest_airport_id
ORDER BY COUNT(f.flight_id) DESC
LIMIT 10;

SELECT 
    a.city_name AS origin_city,
    SUM(fm.passengers) AS total_passengers,
    COUNT(f.flight_id) AS total_flight
FROM
    flight f
        JOIN
    flightmetrics fm ON f.flight_id = fm.flight_id
        JOIN
    airport a ON f.origin_airport_id = a.airport_id
GROUP BY a.city_name
ORDER BY total_flight DESC;

SELECT 
    a.city_name AS dest_city,
    SUM(fm.passengers) AS total_passengers,
    COUNT(f.flight_id) AS total_flight
FROM
    flight f
        JOIN
    flightmetrics fm ON f.flight_id = fm.flight_id
        JOIN
    airport a ON f.dest_airport_id = a.airport_id
GROUP BY a.city_name
ORDER BY total_flight DESC;

### corelation between population and air_traffic###
use flight_analysis;

UPDATE city 
SET 
    cityname = SUBSTRING_INDEX(cityname, ',', 1);
set sql_safe_updates=0;
CREATE TABLE new_city AS SELECT cityID, cityname, state_abr, state_nm, population FROM
    city c
        LEFT JOIN
    world.city t1 ON c.cityname = t1.name;
SELECT 
    nc.cityname,
    nc.population,
    SUM(fm.passengers) AS total_Passengers,
    ROUND(nc.population / SUM(fm.passengers) * 100,
            2) AS pass_pop_ratio_pct
FROM
    new_city nc
        JOIN
    airport a ON a.city_name = nc.cityname
        JOIN
    flight f ON f.origin_airport_id = a.airport_id
        JOIN
    flightmetrics fm ON f.flight_id = fm.flight_id
GROUP BY nc.cityname , nc.population
ORDER BY total_passengers DESC;

SELECT 
    nc.cityname,
    nc.population,
    SUM(fm.passengers) AS total_Passengers,
    ROUND(nc.population / SUM(fm.passengers) * 100,
            2) AS pass_pop_ratio_pct
FROM
    new_city nc
        JOIN
    airport a ON a.city_name = nc.cityname
        JOIN
    flight f ON f.dest_airport_id = a.airport_id
        JOIN
    flightmetrics fm ON f.flight_id = fm.flight_id
GROUP BY nc.cityname , nc.population
ORDER BY total_passengers DESC;



