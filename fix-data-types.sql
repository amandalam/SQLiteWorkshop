-- Convert the numeric columns to the right data types

UPDATE Listings SET host_response_rate = REPLACE(host_response_rate ,'%','') * 1.0 ;
UPDATE Listings SET host_acceptance_rate = REPLACE(host_acceptance_rate ,'%','') * 1.0 ;
UPDATE Listings SET host_listings_count = host_listings_count * 1.0 ;
UPDATE Listings SET host_total_listings_count = host_total_listings_count * 1.0 ;
UPDATE Listings SET latitude = latitude * 1.0 ;
UPDATE Listings SET longitude = longitude * 1.0 ;
UPDATE Listings SET accommodates = accommodates * 1.0 ;
UPDATE Listings SET bathrooms = bathrooms * 1.0 ;
UPDATE Listings SET bedrooms = bedrooms * 1.0 ;
UPDATE Listings SET beds = beds * 1.0 ;
UPDATE Listings SET square_feet = square_feet * 1.0 ;
UPDATE Listings SET price = REPLACE(price ,'$','') * 1.0 ;
UPDATE Listings SET weekly_price = REPLACE(weekly_price ,'$','') * 1.0 ;
UPDATE Listings SET monthly_price = REPLACE(monthly_price ,'$','') * 1.0 ;
UPDATE Listings SET security_deposit = REPLACE(security_deposit ,'$','') * 1.0 ;
UPDATE Listings SET cleaning_fee = REPLACE(cleaning_fee ,'$','') * 1.0 ;
UPDATE Listings SET guests_included = guests_included * 1.0 ;
UPDATE Listings SET extra_people = REPLACE(extra_people ,'$','') * 1.0 ;
UPDATE Listings SET minimum_nights = minimum_nights * 1.0 ;
UPDATE Listings SET maximum_nights = maximum_nights * 1.0 ;
UPDATE Listings SET availability_30 = availability_30 * 1.0 ;
UPDATE Listings SET availability_60 = availability_60 * 1.0 ;
UPDATE Listings SET availability_90 = availability_90 * 1.0 ;
UPDATE Listings SET availability_365 = availability_365 * 1.0 ;
UPDATE Listings SET number_of_reviews = number_of_reviews * 1.0 ;
UPDATE Listings SET review_scores_rating = review_scores_rating * 1.0 ;
UPDATE Listings SET review_scores_accuracy = review_scores_accuracy * 1.0 ;
UPDATE Listings SET review_scores_cleanliness = review_scores_cleanliness * 1.0 ;
UPDATE Listings SET review_scores_checkin = review_scores_checkin * 1.0 ;
UPDATE Listings SET review_scores_communication = review_scores_communication * 1.0 ;
UPDATE Listings SET review_scores_location = review_scores_location * 1.0 ;
UPDATE Listings SET review_scores_value = review_scores_value * 1.0 ;
UPDATE Listings SET calculated_host_listings_count = calculated_host_listings_count * 1.0 ;
UPDATE Listings SET reviews_per_month = reviews_per_month * 1.0 ;

UPDATE calendar SET price = REPLACE(price ,'$','') * 1.0 ;

-- Verify the updates are working as expected

SELECT * FROM Listings WHERE price<=400 AND review_scores_rating >= 80;