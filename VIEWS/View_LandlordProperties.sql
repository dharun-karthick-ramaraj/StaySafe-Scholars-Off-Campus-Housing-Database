CREATE VIEW LandlordProperties AS
SELECT
    L.LandlordID,
    L.PropertyOwned,
    P.HouseNo,
    P.Street,
    P.Zipcode,
    A.Title AS AccommodationTitle,
    A.Description AS AccommodationDescription,
    A.Price
FROM Landlord L
INNER JOIN PropertyOwned P ON L.LandlordID = P.LandlordID
INNER JOIN Accommodation A ON P.PropertyID = A.PropertyID;

--This view provides a summary of properties owned by each landlord, including details of each accommodation.