CREATE FUNCTION dbo.GetTenantBookings(@tenantID INT)
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM Booking
    WHERE TenantID = @tenantID
);