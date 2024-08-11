-- Get Payment Summary Procedure

-- Declare variables to capture output
DECLARE @TotalPending INT, @TotalCompleted INT, @TotalAmount DECIMAL(18, 2);

-- Execute the stored procedure with output parameters
EXEC GetPaymentSummary
    @TotalPending OUTPUT,
    @TotalCompleted OUTPUT,
    @TotalAmount OUTPUT;

-- View the captured output
SELECT
    'Total Pending' AS Status,
    @TotalPending AS Count
UNION ALL
SELECT
    'Total Completed' AS Status,
    @TotalCompleted AS Count
UNION ALL
SELECT
    'Total Amount' AS Status,
    @TotalAmount AS Amount;


--GetAccommodationsNearUniversity Procedure
-- Declare a variable for the university name
DECLARE @UniversityName NVARCHAR(100) = 'Harvard University';

-- Declare a variable for the maximum distance
DECLARE @MaxDistance DECIMAL(18,2) = 3.0; -- Replace with your desired maximum distance
EXEC GetAccommodationsNearUniversity @UniversityName, @MaxDistance;

--CalculateAverageRatings Procedure

-- Execute the stored procedure
-- Declare a variable for the accommodation ID
DECLARE @AccommodationID INT = 1; -- Replace with the actual AccommodationID you want to use

-- Execute the stored procedure with the provided parameter
EXEC CalculateAverageRatings @AccommodationID;