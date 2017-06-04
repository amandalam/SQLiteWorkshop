-- Select all columns from the Listings table

SELECT * 
FROM Listings;

-- Select only the id, name and price columns from the Listing table

SELECT id, name, price 
FROM Listings;

-- Select all the records with price <= 400, and output only the id, name and price columns from the Listing table

SELECT id, name, price 
FROM Listings
WHERE price <= 400;

-- Select all the records with price <= 400 AND review score rating >= 80, and output only the id, name, price and review_scores_rating columns from the Listing table

SELECT id, name, price, review_scores_rating
FROM Listings
WHERE price <= 400
 AND review_scores_rating >= 80;

-- Same criteria as above, but rename columns for better readability

SELECT id As ID, name As Name, price As Price, review_scores_rating As Rating
FROM Listings
WHERE price <= 400
 AND review_scores_rating >= 80;

-- Group listings by Room Type and show the no. of listings, minimum, average and maximum prices

SELECT room_type, COUNT(id) As 'Count', MIN(price) As 'Mininum Price', AVG(price) As 'Average Price', MAX(price) As 'Maximum Price'
FROM Listings
GROUP BY room_type;

-- Group listings by Room Type and show the no. of listings, minimum, average and maximum prices, rounding to 2 decimal places

SELECT room_type, COUNT(id) As 'Count', ROUND(MIN(price),2) As 'Mininum Price', ROUND(AVG(price),2) As 'Average Price', ROUND(MAX(price),2) As 'Maximum Price'
FROM Listings
GROUP BY room_type;

-- Get listings with price <= 400 and rating >= 80, as well as their review dates
-- Inner joining two tables with one-to-many relationships, causing duplicated results

SELECT Listings.id As ID, name As Name, price As Price, review_scores_rating As Rating, Reviews.date As 'Review Date'
FROM Listings, Reviews
WHERE Listings.id = Reviews.listing_id 
 AND price <= 400
 AND review_scores_rating >= 80;

-- Get listings with price <= 400 and rating >= 80, as well as their latest review dates
-- Inner joining two tables with one-to-many relationships, but since we're only getting the latest review date from the Reviews table, it becomes one-to-one relationship

SELECT Listings.id As ID, name As Name, price As Price, review_scores_rating As Rating, MAX(Reviews.date) As 'Latest Review Date'
FROM Listings, Reviews
WHERE Listings.id = Reviews.listing_id 
 AND price <= 400
 AND review_scores_rating >= 80
GROUP BY Listings.ID, Name, Price, Rating;

-- Get distinct list of property types

SELECT DISTINCT property_type
FROM Listings
ORDER BY property_type ASC;

-- Get distinct values of latitude and longitude pairs that are rounded to 3 decimal places
SELECT DISTINCT ROUND(latitude, 3) As Lat, ROUND(longitude, 3) As Long
FROM Listings
ORDER BY Lat, Long ASC;

-- Get all listings that are available on 2017-03-27, and have ID, Name, Availability Date, Availability, Price of that date and the listing URL as output columns
-- Inner joining the Listings table and a sub-query result of the Calendar table

SELECT ID, Name, Availability.date As Date, Availability.available As Available, Availability.price As Price, Listing_url As URL
FROM Listings, 
	( SELECT * FROM Calendar WHERE date='2017-03-27' AND available='t' ) Availability
WHERE Listings.id = Availability.Listing_id 
ORDER BY Availability.price ASC;

-- Get all listings that have received reviews since 2016-08-01
-- Sub-query in the WHERE conditions

SELECT ID, Name, Price
FROM Listings 
WHERE Listings.id IN
	( SELECT listing_id FROM Reviews WHERE date >= '2016-08-01' )


-- Counting the listings with square feet info by different size ranges
-- An example for Case When and Sub-query
SELECT SUM(LessThan300) As Mini, SUM(From300to699) As Small, SUM(From700to999) As Medium, SUM(From1000) As Large
FROM
(
	SELECT 		
		CASE WHEN square_feet < 300 THEN 1 ELSE 0 END As LessThan300,
		CASE WHEN square_feet >= 300 AND square_feet < 700 THEN 1 ELSE 0 END As From300to699,
		CASE WHEN square_feet >= 700 AND square_feet < 1000 THEN 1 ELSE 0 END As From700to999,
		CASE WHEN square_feet >= 1000 THEN 1 ELSE 0 END From1000
	FROM Listings
	WHERE square_feet > 0
);

-- Adding percentage columns
-- This demonstrates calculations of the return values of aggregate functions, data type casting, rounding and string concatenation

SELECT SUM(LessThan300) As Mini, ROUND(SUM(LessThan300)*1.0/COUNT(*)*100,2) || '%' As '%',
	SUM(From300to699) As Small, ROUND(SUM(From300to699)*1.0/COUNT(*)*100,2) || '%' As '%',
	SUM(From700to999) As Medium, ROUND(SUM(From700to999)*1.0/COUNT(*)*100,2) || '%' As '%',
	SUM(From1000) As Large, ROUND(SUM(From1000)*1.0/COUNT(*)*100,2) || '%' As '%',
	COUNT(*) As 'Total'
FROM
(
	SELECT 		
		CASE WHEN square_feet < 300 THEN 1 ELSE 0 END As LessThan300,
		CASE WHEN square_feet >= 300 AND square_feet < 700 THEN 1 ELSE 0 END As From300to699,
		CASE WHEN square_feet >= 700 AND square_feet < 1000 THEN 1 ELSE 0 END As From700to999,
		CASE WHEN square_feet >= 1000 THEN 1 ELSE 0 END From1000
	FROM Listings
	WHERE square_feet > 0
);