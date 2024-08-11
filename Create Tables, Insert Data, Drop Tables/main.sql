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

