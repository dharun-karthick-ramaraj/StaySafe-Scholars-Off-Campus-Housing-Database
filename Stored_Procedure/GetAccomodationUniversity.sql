CREATE PROCEDURE GetAccommodationsNearUniversity
    @UniversityName NVARCHAR(100),
    @MaxDistance DECIMAL(18,2)
AS
BEGIN
    SELECT A.Title, A.Description, A.Type, A.Price, A.AvailabilityStatus
    FROM Accommodation A
    INNER JOIN PropertyOwned P ON A.PropertyID = P.PropertyID
    INNER JOIN Distance D ON A.PropertyID = D.AccommodationID
    INNER JOIN University U ON D.UniversityID = U.UniversityID
    WHERE U.Name = @UniversityName AND D.Distance <= @MaxDistance;
END;