-- Create the user-defined function (UDF)
CREATE FUNCTION dbo.CalculateTotalTime
(
    @DepartureTime TIME,
    @ArrivalTime TIME
)
RETURNS TIME
AS
BEGIN
    DECLARE @TotalTime TIME;

    -- Your logic to calculate total time goes here
    SET @TotalTime = CONVERT(TIME, DATEADD(SECOND, DATEDIFF(SECOND, @DepartureTime, @ArrivalTime), 0));

    RETURN @TotalTime;
END;