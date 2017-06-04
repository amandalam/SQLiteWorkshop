-- Search all the listings table and find out which ones contain the word '公寓'
SELECT * FROM Listings_FTS WHERE Listings_FTS MATCH '公寓';

-- Search all the name column values of the listings table and 
-- find out which ones contain the words sea, view, flat
-- and return only the name column and the ranking. Results sorted by ranking.
SELECT name, rank FROM Listings_FTS WHERE Listings_FTS MATCH '{name} : sea view flat'
ORDER BY rank;

-- Search all the name column values of the listings table and
-- find out which ones contain the words room and apartment within 5 phrases distance
SELECT name, rank FROM Listings_FTS WHERE Listings_FTS MATCH '{name} : NEAR(room apartment, 5)'
ORDER BY rank;

-- Search all the name column values of the listings table and
-- find out which ones contain the words room and apartment within 2 phrases distance
SELECT name, rank FROM Listings_FTS WHERE Listings_FTS MATCH '{name} : NEAR(room apartment, 2)'
ORDER BY rank;

-- Search all the amenities column values of the listings table, 
-- return all records that contain the words "Wireless Internet" and/or "Cable TV",
-- AND those with 1 or more bed, >=300 square feets, with 80 or above review score ratings and with 5 or more reviews.
SELECT * FROM Listings_FTS 
WHERE Listings_FTS MATCH '{amenities} : "Wireless Internet" "Cable TV"'
AND beds>=1 AND square_feet>=300 AND review_scores_rating >= 80 AND number_of_reviews >= 5;

-- Search all the amenities column values of the listings table, 
-- return all records that contain the words "Wireless Internet" and/or "Cable TV",
-- AND those that are available on 2017-03-27.
-- Output ID, Name, Amenities, Availability Date, Availability, Price and URL as output columns.
SELECT Listings.ID As ID, Name, Amenities, Availability.Date As 'Available Date', 
	CASE WHEN Available = 't' THEN 'Yes' ELSE 'No' END As Available, 
	Availability.Price As Price, Listings_url As URL,
	GROUP_CONCAT(Reviews.comments) As Comments
FROM Listings,
	( SELECT * FROM Calendar WHERE date='2017-03-27' AND available='t' ) Availability,
	Reviews
WHERE Listings.id = Availability.Listings_id AND Listings.id = Reviews.Listings_id
AND Listings.id IN
	(SELECT id FROM Listings_FTS WHERE Listings_FTS MATCH '{amenities} : "Wireless Internet" "Cable TV"')
GROUP BY Listings.ID;
	
-- Show the mostly mentioned keywords of the summary column in the listings table,
-- excluding common stopwords. Results sorted by more number of mentions first.
SELECT term, cnt 
FROM Listings_FTS_V_Col 
WHERE col='summary' AND ABS(term)=0.0 AND LENGTH(term)>1 AND NOT term IN (SELECT Stopword FROM Stopwords) 
ORDER BY cnt DESC;
	
-- Show the mostly mentioned keywords in the listings table, excluding common stopwords.
-- Results sorted by the more number of records containing the keywords first.
SELECT term, doc 
FROM Listings_FTS_V_Row 
WHERE ABS(term)=0.0 AND LENGTH(term)>1 AND NOT term IN (SELECT Stopword FROM Stopwords)  
ORDER BY doc DESC;

-- Show the mostly mentioned keywords of the comments column in the Reviews table,
-- excluding common stopwords. Results sorted by more number of mentions first.
SELECT term, cnt 
FROM Reviews_FTS_V_Col 
WHERE col='comments' AND ABS(term)=0.0 AND LENGTH(term)>1 AND NOT term IN (SELECT Stopword FROM Stopwords) 
ORDER BY cnt DESC;

-- Show the mostly mentioned keywords in the Reviews table, excluding common stopwords. 
-- Results sorted by more number of mentions first.
SELECT term, cnt 
FROM Reviews_FTS_V_Row
WHERE ABS(term)=0.0 AND LENGTH(term)>1 AND NOT term IN (SELECT Stopword FROM Stopwords) 
ORDER BY cnt DESC;
