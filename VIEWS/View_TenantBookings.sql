CREATE VIEW TenantBookings AS
SELECT
    T.TenantID,
    T.PreferredLocation,
    B.BookingID,
    B.BookingDate,
    A.Title AS AccommodationTitle,
    A.Description AS AccommodationDescription,
    A.Price
FROM Tenant T
INNER JOIN Booking B ON T.TenantID = B.TenantID
INNER JOIN Accommodation A ON B.AccommodationID = A.AccommodationID;

--This view displays booking information for each tenant, including preferred location, booking details, and accommodation information.