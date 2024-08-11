CREATE TRIGGER trgAccommodationAudit
ON Accommodation
AFTER UPDATE
AS
BEGIN
    INSERT INTO AccommodationAudit (AccommodationID, OldPrice, NewPrice, UpdatedDate)
    SELECT 
        inserted.AccommodationID,
        deleted.Price AS OldPrice,
        inserted.Price AS NewPrice,
        GETDATE() AS UpdatedDate
    FROM deleted
    INNER JOIN inserted ON deleted.AccommodationID = inserted.AccommodationID;
END;
