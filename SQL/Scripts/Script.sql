create extension postgis;

--DROP TABLE bike_accidents_sql;

--ALTER TABLE bike_accidents_sql ADD COLUMN geom geometry;

SELECT "WKT" from bike_accidents_sql LIMIT 5;
ALTER TABLE bike_accidents_sql ADD COLUMN geom geometry;


UPDATE bike_accidents_sql SET geom = st_geomfromewkt("WKT") where geom IS NULL;

ALTER TABLE bike_accidents_sql
 ALTER COLUMN geom TYPE geometry(POINT,4326) 
  USING ST_SetSRID(geom,4326);
 
SELECT * FROM bike_accidents_sql; 

SELECT a.geom as geom1, st_srid(a.geom), b.geom as geom2, st_srid(b.geom) from bike_accidents_geo as a, bike_accidents_sql as b LIMIT 5