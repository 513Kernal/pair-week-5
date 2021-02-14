-- CAMPGROUND TABLE
-----------------------------------------------

-- select name and daily fee of all campgrounds

SELECT name, daily_fee
FROM campground;

-- select name and daily fee of all campgrounds ordered by campground name

SELECT name, daily_fee
FROM campground
ORDER BY name;

-- select name, open from month, open to month, and daily fee of the campgrounds where daily fee is less than $100

SELECT name, open_from_mm, open_to_mm, daily_fee
FROM campground
WHERE CAST (daily_fee AS NUMERIC) < 100;

-- select name and daily fee of the campgrounds where the campground is open all year long

SELECT name, daily_fee
FROM campground
WHERE open_from_mm = '01' AND open_to_mm = '12'; 

-- PARK TABLE
-----------------------------------------------

-- select name and description of all parks order by established date in descending order
SELECT name, description, establish_date
FROM park
ORDER BY establish_date DESC; 

-- select name and description of all parks in Ohio

SELECT name, description
FROM park
WHERE location = 'Ohio';

-- select name and description of all parks NOT in Ohio

SELECT name, description
FROM park
WHERE location != 'Ohio';


-- select the total number of visitors for all parks

SElECT SUM(visitors) AS total_num_of_visitors
FROM park;

SElECT visitors
FROM park;

--Unsure if wanted sum or total per

-- select the average number of visitors for all parks

SElECT AVG(visitors) AS avg_num_of_visitors
FROM park;


-- SITE TABLE
-----------------------------------------------

-- select all columns from site where utilities is true and order by max RV length with the largest coming first

SELECT site_id, campground_id, site_number, max_occupancy, accessible, max_rv_length, utilities
FROM site
WHERE utilities = true
ORDER BY max_rv_length DESC;

-- select total number of sites that have utilities hook up

SELECT site_id, site_number, utilities 
FROM site
WHERE utilities = true;


-- RESERVATION TABLE
-----------------------------------------------

-- select reservation id, site id, name, from date, to date of the reservations where the checkin date is between the first and last day of the current month (hard coded month is ok)

SELECT reservation_id, site_id, name, from_date, to_date
FROM reservation
WHERE CAST (from_date AS VARCHAR) LIKE '2021-02%';

-- select all columns from reservation where name includes 'Reservation'

SELECT reservation_id, site_id, name, from_date, to_date, create_date
FROM reservation
WHERE name ILIKE '%reservation%';


-- select the total number of reservations in the reservation table

SELECT COUNT(reservation_id) AS total_num_reservations
FROM reservation;

-- select reservation id, site id, name of the reservations where site id is in the list 9, 20, 24, 45, 46

SELECT reservation_id, site_id, name
FROM reservation
WHERE reservation_id IN (9, 20, 24, 45, 46);

-- select the date and number of reservations for each date orderd by from_date in ascending order

SELECT from_date, COUNT(reservation_id)
FROM reservation
GROUP BY from_date
ORDER BY from_date;
