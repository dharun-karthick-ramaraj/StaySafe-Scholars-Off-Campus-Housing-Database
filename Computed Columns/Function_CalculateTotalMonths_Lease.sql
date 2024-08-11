-- Create the user-defined function (UDF)
CREATE FUNCTION dbo.CalculateTotalMonths
(
    @LeaseStartDate DATE,
    @LeaseEndDate DATE
)
RETURNS INT
AS
BEGIN
    DECLARE @TotalMonths INT;

    -- Your logic to calculate total months goes here
    -- Assuming each month has 30 days for simplicity
    SET @TotalMonths = DATEDIFF(DAY, @LeaseStartDate, @LeaseEndDate) / 30;

    RETURN @TotalMonths;
END;


