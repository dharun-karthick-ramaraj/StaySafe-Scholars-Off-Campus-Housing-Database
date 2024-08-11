-- Create Database
CREATE DATABASE StaySafeScholars;
GO

-- Use the StaySafeScholars database
USE StaySafeScholars;
GO

-- Create Tables

-- Landlord Table
CREATE TABLE Landlord (
    LandlordID INT PRIMARY KEY,
    PropertyOwned NVARCHAR(100) NOT NULL,
    BankAccount NVARCHAR(50) NOT NULL,
    RentalIncome DECIMAL(18,2) NOT NULL
);

-- Tenant Table
CREATE TABLE Tenant (
    TenantID INT PRIMARY KEY,
    UniversityAffiliation NVARCHAR(100) NOT NULL,
    BudgetRange DECIMAL(18,2) NOT NULL,
    PreferredLocation NVARCHAR(50) NOT NULL,
    LeaseStartDate DATE NOT NULL,
    LeaseEndDate DATE NOT NULL
);

-- User Table
CREATE TABLE [User] (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    UserType NVARCHAR(10) NOT NULL, -- 'Tenant' or 'Landlord'
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) NOT NULL,
    Password NVARCHAR(100) NOT NULL,
    ContactNumber NVARCHAR(20),
    ProfilePicture VARBINARY(MAX),
    TenantID INT,
    LandlordID INT,
    --Encrypted_Password VARBINARY(MAX),
    CONSTRAINT CHK_UserType CHECK (UserType IN ('Tenant', 'Landlord')),
    CONSTRAINT FK_User_Tenant FOREIGN KEY (TenantID) REFERENCES Tenant(TenantID),
    CONSTRAINT FK_User_Landlord FOREIGN KEY (LandlordID) REFERENCES Landlord(LandlordID)
);


-- Create MessagingSystem table
CREATE TABLE MessagingSystem (
    MessageID INT PRIMARY KEY IDENTITY(1,1),
    SenderID INT NOT NULL,
    ReceiverID INT NOT NULL,
    MessageContent NVARCHAR(MAX),
    Timestamp DATETIME,
    FOREIGN KEY (SenderID) REFERENCES [User](UserID),
    FOREIGN KEY (ReceiverID) REFERENCES [User](UserID)
);


-- Billing System Table
CREATE TABLE BillingSystem (
    PaymentID INT PRIMARY KEY,
    PaymentAmount INT,
    PaymentDate DATE NOT NULL,
    PaymentStatus NVARCHAR(50) NOT NULL,
);

-- University Table
CREATE TABLE University (
    UniversityID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    Street NVARCHAR(255) NOT NULL,
    Zipcode NVARCHAR(10) NOT NULL,
    CONSTRAINT UC_UniversityName UNIQUE (Name)
);

-- PropertyOwned Table
CREATE TABLE PropertyOwned (
    PropertyID INT PRIMARY KEY IDENTITY(1,1),
    LandlordID INT NOT NULL,
    HouseNo NVARCHAR(20) NOT NULL,
    Street NVARCHAR(50) NOT NULL,
    Zipcode NVARCHAR(10) NOT NULL,
    
    CONSTRAINT FK_PropertyOwned_Landlord FOREIGN KEY (LandlordID) REFERENCES Landlord(LandlordID)
);

-- Accommodation Table
CREATE TABLE Accommodation (
    AccommodationID INT PRIMARY KEY IDENTITY(1,1),
    PropertyID INT NOT NULL,
    Title NVARCHAR(100) NOT NULL,
    Description NVARCHAR(MAX) NOT NULL,
    Type NVARCHAR(50) NOT NULL,
    Price DECIMAL(18,2) NOT NULL,
    AvailabilityStatus NVARCHAR(50) NOT NULL,
    
    CONSTRAINT FK_Accommodation_PropertyOwned FOREIGN KEY (PropertyID) REFERENCES PropertyOwned(PropertyID)
);

-- Amenities Table
CREATE TABLE Amenities (
    AmenitiesID INT PRIMARY KEY IDENTITY(1,1),
    AccommodationID INT NOT NULL,
    CentralizedAirConditioner BIT NOT NULL,
    Description NVARCHAR(MAX) NOT NULL,
    
    CONSTRAINT FK_Amenities_Accommodation FOREIGN KEY (AccommodationID) REFERENCES Accommodation(AccommodationID)
);

-- Distance Table
CREATE TABLE Distance (
    DistanceID INT PRIMARY KEY IDENTITY(1,1),
    UniversityID INT NOT NULL,
    AccommodationID INT NOT NULL,
    Distance DECIMAL(18,2) NOT NULL,
    
    CONSTRAINT FK_Distance_University FOREIGN KEY (UniversityID) REFERENCES University(UniversityID),
    CONSTRAINT FK_Distance_Accommodation FOREIGN KEY (AccommodationID) REFERENCES Accommodation(AccommodationID)
);

-- Transportation Table
CREATE TABLE Transportation (
    TransportationID INT PRIMARY KEY IDENTITY(1,1),
    DistanceID INT,
    AccommodationID INT,
    UniversityID INT,
    ModeOfTransport NVARCHAR(50) NOT NULL,
    DepartureTime TIME,
    ArrivalTime TIME,
    Price DECIMAL(18,2) NOT NULL,
    
    CONSTRAINT FK_Transportation_Distance FOREIGN KEY (DistanceID) REFERENCES Distance(DistanceID),
    CONSTRAINT FK_Transportation_Accommodation FOREIGN KEY (AccommodationID) REFERENCES Accommodation(AccommodationID),
    CONSTRAINT FK_Transportation_University FOREIGN KEY (UniversityID) REFERENCES University(UniversityID)
);

-- Booking Table
CREATE TABLE Booking (
    BookingID INT PRIMARY KEY IDENTITY(1,1),
    TenantID INT NOT NULL,
    AccommodationID INT NOT NULL,
    PaymentID INT NOT NULL,
    BookingDate DATE NOT NULL,
    PaymentStatus NVARCHAR(50) NOT NULL,
    
    CONSTRAINT FK_Booking_Tenant FOREIGN KEY (TenantID) REFERENCES Tenant(TenantID),
    CONSTRAINT FK_Booking_Accommodation FOREIGN KEY (AccommodationID) REFERENCES Accommodation(AccommodationID),
    CONSTRAINT FK_Booking_BillingSystem FOREIGN KEY (PaymentID) REFERENCES BillingSystem(PaymentID)
);

-- Create ReviewAndRating Table
CREATE TABLE ReviewAndRating (
    ReviewID INT PRIMARY KEY IDENTITY(1,1),
    TenantID INT NOT NULL,
    AccommodationID INT NOT NULL,
    Ratings INT NOT NULL,
    Date DATE NOT NULL,
    Comments NVARCHAR(MAX) NOT NULL,
    
    CONSTRAINT FK_ReviewAndRating_Tenant FOREIGN KEY (TenantID) REFERENCES Tenant(TenantID),
    CONSTRAINT FK_ReviewAndRating_Accommodation FOREIGN KEY (AccommodationID) REFERENCES Accommodation(AccommodationID)
);


CREATE TABLE AccommodationAudit (
    AuditID INT PRIMARY KEY IDENTITY(1,1),
    AccommodationID INT NOT NULL,
    OldPrice DECIMAL(18,2) NOT NULL,
    NewPrice DECIMAL(18,2) NOT NULL,
    UpdatedDate DATETIME NOT NULL
);


SELECT * FROM [User];
SELECT * FROM Tenant;
SELECT * FROM Landlord;
SELECT * FROM Booking;
SELECT * FROM BillingSystem;
SELECT * FROM ReviewAndRating;
SELECT * FROM PropertyOwned;
SELECT * FROM Accommodation;
SELECT * FROM Amenities;
SELECT * FROM Transportation;
SELECT * FROM Distance;
SELECT * FROM University;
SELECT * FROM MessagingSystem;
SELECT * FROM AccommodationAudit;

-- Table Level Check Constraints

-- Check Constraint 1
ALTER TABLE [User]
ADD CONSTRAINT CHK_Password_Length
CHECK (LEN(Password) >= 8);

-- Check Constraint 2
ALTER TABLE BillingSystem
ADD CONSTRAINT CHK_PaymentStatus_Valid
CHECK (PaymentStatus IN ('Pending', 'Completed', 'Failed'));

-- Check Constraint 3
ALTER TABLE Accommodation
ADD CONSTRAINT CHK_AvailabilityStatus CHECK (AvailabilityStatus IN ('Available', 'Occupied', 'Under Maintenance'));

-- Check Constraint 4
ALTER TABLE [User]
ADD CONSTRAINT DF_ContactNumber DEFAULT 'N/A' FOR ContactNumber;

-- Check Constraint 5
ALTER TABLE Tenant
ADD CONSTRAINT CHK_LeaseDates CHECK (LeaseStartDate <= LeaseEndDate);

-- Non-Clustered Indexes

-- Index 1
CREATE NONCLUSTERED INDEX IX_User_Email
ON [User](Email);

-- Index 2
CREATE NONCLUSTERED INDEX IX_Tenant_PreferredLocation
ON Tenant(PreferredLocation);

-- Index 3
CREATE NONCLUSTERED INDEX IX_Accommodation_Type
ON Accommodation(Type);

-- Index 4
CREATE NONCLUSTERED INDEX IX_ReviewAndRating_Ratings
ON ReviewAndRating(Ratings);

-- Finalize the script
GO

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

-- Alter the Tenant table to add the computed column
ALTER TABLE Tenant
ADD TotalMonths AS dbo.CalculateTotalMonths(LeaseStartDate, LeaseEndDate);
SELECT * FROM Tenant;

-- Alter the Transportation table to add the computed column
ALTER TABLE Transportation
ADD TotalTime AS dbo.CalculateTotalTime(DepartureTime, ArrivalTime);
SELECT * FROM Transportation;

--ADD FUNCTIONS
CREATE FUNCTION dbo.GetTenantBookings(@tenantID INT)
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM Booking
    WHERE TenantID = @tenantID
);

CREATE FUNCTION dbo.GetAccommodationDetails(@accommodationID INT)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        A.AccommodationID,
        A.Title,
        A.Description,
        A.Type,
        A.Price,
        A.AvailabilityStatus,
        P.HouseNo,
        P.Street,
        P.Zipcode
    FROM 
        Accommodation A
    JOIN 
        PropertyOwned P ON A.PropertyID = P.PropertyID
    WHERE 
        A.AccommodationID = @accommodationID
);

CREATE FUNCTION dbo.GetConversationHistory(@senderID INT, @receiverID INT, @pageSize INT = 0, @pageNumber INT = 1)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        MessageID,
        SenderID,
        ReceiverID,
        MessageContent,
        Timestamp
    FROM 
        MessagingSystem
    WHERE 
        (SenderID = @senderID AND ReceiverID = @receiverID)
        OR
        (SenderID = @receiverID AND ReceiverID = @senderID)
    ORDER BY 
        Timestamp DESC
    OFFSET (@pageNumber - 1) * @pageSize ROWS
    FETCH NEXT @pageSize ROWS ONLY
);

--Function Testing

SELECT * FROM dbo.GetTenantBookings(11);

-- Retrieve the first page of conversation history (e.g., 10 messages)
SELECT * FROM dbo.GetConversationHistory(1, 11, 10, 1); -- Replace 1 and 2 with actual SenderID and ReceiverID

-- Retrieve the second page of conversation history (e.g., messages 11 to 20)
SELECT * FROM dbo.GetConversationHistory(10, 20, 10, 1); -- Replace 1 and 2 with actual SenderID and ReceiverID

SELECT * FROM dbo.GetAccommodationDetails(3);


--All procedures
-- Stored Procedure to Get Payment Summary
CREATE PROCEDURE GetPaymentSummary
    @TotalPending INT OUTPUT,
    @TotalCompleted INT OUTPUT,
    @TotalAmount DECIMAL(18, 2) OUTPUT
AS
BEGIN
    SELECT
        @TotalPending = COUNT(CASE WHEN PaymentStatus = 'Pending' THEN 1 END),
        @TotalCompleted = COUNT(CASE WHEN PaymentStatus = 'Completed' THEN 1 END),
        @TotalAmount = SUM(PaymentAmount)
    FROM
        BillingSystem;
END;

CREATE PROCEDURE CalculateAverageRatings
    @AccommodationID INT
AS
BEGIN
    SELECT AVG(Ratings) AS AverageRating
    FROM ReviewAndRating
    WHERE AccommodationID = @AccommodationID;
END;

CREATE PROCEDURE GetAccommodationsNearUniversity
    @UniversityName NVARCHAR(100),
    @MaxDistance DECIMAL(18,2)
AS
BEGIN
    SELECT A.Title, A.Description, A.Type, A.Price, A.AvailabilityStatus
    FROM Accommodation A
    INNER JOIN PropertyOwned P ON A.PropertyID = P.PropertyID
    INNER JOIN Distance D ON A.PropertyID = D.AccommodationID
    INNER JOIN University U ON D.UniversityID = U.UniversityID
    WHERE U.Name = @UniversityName AND D.Distance <= @MaxDistance;
END;

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

--Procedure Testing
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

--Create Triggers

CREATE TRIGGER trgEnforceBudgetRange
ON Tenant
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted WHERE BudgetRange < 500 OR BudgetRange > 5000)
    BEGIN
        PRINT 'Budget range must be between $500 and $5000. Rolling back transaction.';
        ROLLBACK;
    END
END;

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

--Trigger Testing 
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



--Create views

CREATE VIEW UserWithRole AS
SELECT
    U.UserID,
    U.FirstName,
    U.LastName,
    U.Email,
    U.ContactNumber,
    'Tenant' AS Role
FROM [User] U
INNER JOIN Tenant T ON U.UserID = T.TenantID
UNION
SELECT
    U.UserID,
    U.FirstName,
    U.LastName,
    U.Email,
    U.ContactNumber,
    'Landlord' AS Role
FROM [User] U
INNER JOIN Landlord L ON U.UserID = L.LandlordID;

-- This view combines information from the User, Tenant, and Landlord tables to provide a unified view with a role indicator.

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

--View Testing
--TESTING

SELECT * FROM UserWithRole;

SELECT * FROM TenantBookings;

SELECT * FROM LandlordProperties;

SELECT * FROM AccommodationsWithAmenities;

