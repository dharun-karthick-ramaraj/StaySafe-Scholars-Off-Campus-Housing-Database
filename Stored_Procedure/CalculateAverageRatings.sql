CREATE PROCEDURE CalculateAverageRatings
    @AccommodationID INT
AS
BEGIN
    SELECT AVG(Ratings) AS AverageRating
    FROM ReviewAndRating
    WHERE AccommodationID = @AccommodationID;
END;

