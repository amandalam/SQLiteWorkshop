-- Calculate correlation coefficients between breakdown ratings with main rating (r)

SELECT * FROM 
(
	SELECT 
		ROUND((count(*) * sum(review_scores_rating * review_scores_accuracy) - sum(review_scores_rating) * sum(review_scores_accuracy)) / 
		(sqrt(count(*) * sum(review_scores_rating * review_scores_rating) - sum(review_scores_rating) * sum(review_scores_rating)) * 
		sqrt(count(*) * sum(review_scores_accuracy * review_scores_accuracy) - sum(review_scores_accuracy) * sum(review_scores_accuracy))),4) As Accuracy_r,
		
		ROUND((count(*) * sum(review_scores_rating * review_scores_cleanliness) - sum(review_scores_rating) * sum(review_scores_cleanliness)) / 
		(sqrt(count(*) * sum(review_scores_rating * review_scores_rating) - sum(review_scores_rating) * sum(review_scores_rating)) * 
		sqrt(count(*) * sum(review_scores_cleanliness * review_scores_cleanliness) - sum(review_scores_cleanliness) * sum(review_scores_cleanliness))),4) As Cleanliness_r,	
		
		ROUND((count(*) * sum(review_scores_rating * review_scores_checkin) - sum(review_scores_rating) * sum(review_scores_checkin)) / 
		(sqrt(count(*) * sum(review_scores_rating * review_scores_rating) - sum(review_scores_rating) * sum(review_scores_rating)) * 
		sqrt(count(*) * sum(review_scores_checkin * review_scores_checkin) - sum(review_scores_checkin) * sum(review_scores_checkin))),4) As Checkin_r,

		ROUND((count(*) * sum(review_scores_rating * review_scores_communication) - sum(review_scores_rating) * sum(review_scores_communication)) / 
		(sqrt(count(*) * sum(review_scores_rating * review_scores_rating) - sum(review_scores_rating) * sum(review_scores_rating)) * 
		sqrt(count(*) * sum(review_scores_communication * review_scores_communication) - sum(review_scores_communication) * sum(review_scores_communication))),4) As Comm_r,	
		
		ROUND((count(*) * sum(review_scores_rating * review_scores_location) - sum(review_scores_rating) * sum(review_scores_location)) / 
		(sqrt(count(*) * sum(review_scores_rating * review_scores_rating) - sum(review_scores_rating) * sum(review_scores_rating)) * 
		sqrt(count(*) * sum(review_scores_location * review_scores_location) - sum(review_scores_location) * sum(review_scores_location))),4) As Location_r,

		ROUND((count(*) * sum(review_scores_rating * review_scores_value) - sum(review_scores_rating) * sum(review_scores_value)) / 
		(sqrt(count(*) * sum(review_scores_rating * review_scores_rating) - sum(review_scores_rating) * sum(review_scores_rating)) * 
		sqrt(count(*) * sum(review_scores_value * review_scores_value) - sum(review_scores_value) * sum(review_scores_value))),4) As Value_r,
		
		COUNT(*) As N

	FROM Listings
) WHERE N >= 10;

-- Calculate cofficient of determination (r square) and the t value
SELECT Name, N,
Accuracy_r, ROUND(Accuracy_r * Accuracy_r, 4) As Accuracy_r2,
ROUND(Accuracy_r / sqrt((1 - Accuracy_r*Accuracy_r)/(N-2)),4) As Accuracy_t,
Cleanliness_r, ROUND(Cleanliness_r * Cleanliness_r, 4) As Cleanliness_r2,
ROUND(Cleanliness_r / sqrt((1 - Cleanliness_r*Cleanliness_r)/(N-2)),4) As Cleanliness_t,
Comm_r, ROUND(Comm_r * Comm_r, 4) As Comm_r2,
ROUND(Comm_r / sqrt((1 - Comm_r*Comm_r)/(N-2)),4) As Comm_t,
Location_r, ROUND(Location_r * Location_r, 4) As Location_r2,
ROUND(Location_r / sqrt((1 - Location_r*Location_r)/(N-2)),4) As Location_t,
Value_r, ROUND(Value_r * Value_r, 4) As Value_r2,
ROUND(Value_r / sqrt((1 - Value_r*Value_r)/(N-2)),4) As Value_t
FROM 
(
	SELECT 
		Name,
		
		ROUND((count(*) * sum(review_scores_rating * review_scores_accuracy) - sum(review_scores_rating) * sum(review_scores_accuracy)) / 
		(sqrt(count(*) * sum(review_scores_rating * review_scores_rating) - sum(review_scores_rating) * sum(review_scores_rating)) * 
		sqrt(count(*) * sum(review_scores_accuracy * review_scores_accuracy) - sum(review_scores_accuracy) * sum(review_scores_accuracy))),4) As Accuracy_r,
		
		ROUND((count(*) * sum(review_scores_rating * review_scores_cleanliness) - sum(review_scores_rating) * sum(review_scores_cleanliness)) / 
		(sqrt(count(*) * sum(review_scores_rating * review_scores_rating) - sum(review_scores_rating) * sum(review_scores_rating)) * 
		sqrt(count(*) * sum(review_scores_cleanliness * review_scores_cleanliness) - sum(review_scores_cleanliness) * sum(review_scores_cleanliness))),4) As Cleanliness_r,	
		
		ROUND((count(*) * sum(review_scores_rating * review_scores_checkin) - sum(review_scores_rating) * sum(review_scores_checkin)) / 
		(sqrt(count(*) * sum(review_scores_rating * review_scores_rating) - sum(review_scores_rating) * sum(review_scores_rating)) * 
		sqrt(count(*) * sum(review_scores_checkin * review_scores_checkin) - sum(review_scores_checkin) * sum(review_scores_checkin))),4) As Checkin_r,

		ROUND((count(*) * sum(review_scores_rating * review_scores_communication) - sum(review_scores_rating) * sum(review_scores_communication)) / 
		(sqrt(count(*) * sum(review_scores_rating * review_scores_rating) - sum(review_scores_rating) * sum(review_scores_rating)) * 
		sqrt(count(*) * sum(review_scores_communication * review_scores_communication) - sum(review_scores_communication) * sum(review_scores_communication))),4) As Comm_r,	
		
		ROUND((count(*) * sum(review_scores_rating * review_scores_location) - sum(review_scores_rating) * sum(review_scores_location)) / 
		(sqrt(count(*) * sum(review_scores_rating * review_scores_rating) - sum(review_scores_rating) * sum(review_scores_rating)) * 
		sqrt(count(*) * sum(review_scores_location * review_scores_location) - sum(review_scores_location) * sum(review_scores_location))),4) As Location_r,

		ROUND((count(*) * sum(review_scores_rating * review_scores_value) - sum(review_scores_rating) * sum(review_scores_value)) / 
		(sqrt(count(*) * sum(review_scores_rating * review_scores_rating) - sum(review_scores_rating) * sum(review_scores_rating)) * 
		sqrt(count(*) * sum(review_scores_value * review_scores_value) - sum(review_scores_value) * sum(review_scores_value))),4) As Value_r,
		
		COUNT(*) As N

	FROM Listings
	GROUP BY Name
) WHERE N >= 3;