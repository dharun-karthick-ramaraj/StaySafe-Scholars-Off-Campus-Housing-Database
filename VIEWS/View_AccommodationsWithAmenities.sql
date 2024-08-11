CREATE VIEW AccommodationsWithAmenities AS
SELECT
    A.AccommodationID,
    A.Title,
    A.Description,
    A.Type,
    A.Price,
    A.AvailabilityStatus,
    Am.CentralizedAirConditioner,
    Am.Description AS AmenityDescription
FROM Accommodation A
LEFT JOIN Amenities Am ON A.AccommodationID = Am.AccommodationID;
--This view combines information from the Accommodation and Amenities tables, showing details about each accommodation and its associated amenities.