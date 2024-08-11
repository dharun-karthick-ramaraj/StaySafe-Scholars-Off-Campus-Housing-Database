CREATE FUNCTION dbo.GetAccommodationDetails(@accommodationID INT)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        A.AccommodationID,
        A.Title,
        A.Description,
        A.Type,
        A.Price,
        A.AvailabilityStatus,
        P.HouseNo,
        P.Street,
        P.Zipcode
    FROM 
        Accommodation A
    JOIN 
        PropertyOwned P ON A.PropertyID = P.PropertyID
    WHERE 
        A.AccommodationID = @accommodationID
);
