-- Alter the Tenant table to add the computed column
ALTER TABLE Tenant
ADD TotalMonths AS dbo.CalculateTotalMonths(LeaseStartDate, LeaseEndDate);
SELECT * FROM Tenant;

-- Alter the Transportation table to add the computed column
ALTER TABLE Transportation
ADD TotalTime AS dbo.CalculateTotalTime(DepartureTime, ArrivalTime);
SELECT * FROM Transportation;
