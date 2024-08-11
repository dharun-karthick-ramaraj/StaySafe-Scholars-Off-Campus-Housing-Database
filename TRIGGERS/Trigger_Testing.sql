-- Test the trgEnforceBudgetRange trigger with an invalid budget range
INSERT INTO Tenant (TenantID, UniversityAffiliation, BudgetRange, PreferredLocation, LeaseStartDate, LeaseEndDate)
VALUES
(21, 'Test University', 100, 'Test Location', '2023-01-01', '2023-12-31');


-- Test the trgAccommodationAudit trigger with an UPDATE
UPDATE Accommodation
SET Price = 3000.00
WHERE AccommodationID = 1;


-- Display contents of the AccommodationAudit table
SELECT * FROM Accommodation;
SELECT * FROM AccommodationAudit;

