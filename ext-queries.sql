-- These scripts are to verify if the extension-functions has already been loaded successfully.

-- Try out the extended math functions
SELECT LOG10(100), SIN(radians(90)), COS(radians(0)), TAN(radians(45)), SQUARE(12), SQRT(4), PI();

-- Try out the extended string functions
SELECT LTRIM('   This is a test.', ' '), RTRIM('This is a test. Hahahaha','a'), PROPER('This is a test.'), CHARINDEX('test','This is a test');

-- Try out the extended aggregate functions
SELECT AVG(price), STDEV(price), VARIANCE(price), MODE(price), MEDIAN(price), LOWER_QUARTILE(price), UPPER_QUARTILE(price)
FROM Listings;
