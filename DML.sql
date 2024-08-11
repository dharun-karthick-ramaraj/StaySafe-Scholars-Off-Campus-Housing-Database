use StaySafeScholars

-- Insert into University
INSERT INTO University (Name, Street, Zipcode)
VALUES 
('Harvard University', '123 Main Street', '02138'),
('MIT', '456 Tech Avenue', '02139'),
('Boston University', '789 College Road', '02215'),
('Northeastern University', '101 Huntington Ave', '02199'),
('Tufts University', '1 The Green', '02135'),
('Suffolk University', '8 Ashburton Pl', '02108'),
('Emerson College', '120 Boylston St', '02116'),
('Boston College', '140 Commonwealth Ave', '02467'),
('University of Massachusetts Boston', '100 William T. Morrissey Blvd', '02125'),
('Bentley University', '175 Forest St', '02452');

-- Insert into Landlord
INSERT INTO Landlord (LandlordID, PropertyOwned, BankAccount, RentalIncome)
VALUES
(1, '123 Main Street', '1234567890', 2000.00),
(2, '456 Tech Avenue', '2345678901', 2500.00),
(3, '789 College Road', '3456789012', 1800.00),
(4, '101 Huntington Ave', '4567890123', 2200.00),
(5, '1 The Green', '5678901234', 1900.00),
(6, '8 Ashburton Pl', '6789012345', 2100.00),
(7, '120 Boylston St', '7890123456', 2400.00),
(8, '140 Commonwealth Ave', '8901234567', 2600.00),
(9, '100 William T. Morrissey Blvd', '9012345678', 2300.00),
(10, '175 Forest St', '0123456789', 2000.00);

-- Insert into Tenant
INSERT INTO Tenant (TenantID, UniversityAffiliation, BudgetRange, PreferredLocation, LeaseStartDate, LeaseEndDate)
VALUES
(11, 'Harvard University', 2500.00, 'Cambridge', '2023-01-01', '2023-12-31'),
(12, 'MIT', 2200.00, 'Cambridge', '2023-02-01', '2023-12-31'),
(13, 'Boston University', 2000.00, 'Boston', '2023-03-01', '2023-12-31'),
(14, 'Northeastern University', 2300.00, 'Boston', '2023-04-01', '2023-12-31'),
(15, 'Tufts University', 2100.00, 'Medford', '2023-05-01', '2023-12-31'),
(16, 'Suffolk University', 2400.00, 'Boston', '2023-06-01', '2023-12-31'),
(17, 'Emerson College', 1800.00, 'Boston', '2023-07-01', '2023-12-31'),
(18, 'Boston College', 2600.00, 'Chestnut Hill', '2023-08-01', '2023-12-31'),
(19, 'University of Massachusetts Boston', 1900.00, 'Boston', '2023-09-01', '2023-12-31'),
(20, 'Bentley University', 2000.00, 'Waltham', '2023-10-01', '2023-12-31');


-- Insert into [User] for Tenants
INSERT INTO [User] (UserType, FirstName, LastName, Email, Password, ContactNumber, LandlordID, ProfilePicture)
VALUES
('Landlord', 'David', 'Williams', 'david.williams@example.com','password808', '123-456-7890', 1, NULL),
('Landlord', 'Olivia', 'Johnson', 'olivia.johnson@example.com', 'password909', '234-567-8901', 2, NULL),
('Landlord', 'Daniel', 'Davis', 'daniel.davis@example.com', 'password010', '345-678-9012', 3, NULL),
('Landlord', 'Sophia', 'Brown', 'sophia.brown@example.com', 'password111', '456-789-0123', 4, NULL),
('Landlord', 'Carter', 'Martin', 'carter.martin@example.com', 'password212', '567-890-1234', 5, NULL),
('Landlord', 'Zoe', 'Thompson', 'zoe.thompson@example.com', 'password313', '678-901-2345', 6, NULL),
('Landlord', 'Leo', 'White', 'leo.white@example.com', 'password414', '789-012-3456', 7, NULL),
('Landlord', 'Mia', 'Miller', 'mia.miller@example.com', 'password515', '890-123-4567', 8, NULL),
('Landlord', 'Isaac', 'Garcia', 'isaac.garcia@example.com', 'password616', '901-234-5678', 9, NULL),
('Landlord', 'Lily', 'Lee', 'lily.lee@example.com', 'password717', '012-345-6789', 10, NULL);

INSERT INTO [User] (UserType, FirstName, LastName, Email, Password, ContactNumber, TenantID, ProfilePicture)
VALUES
('Tenant', 'John', 'Doe', 'john.doe@example.com', 'password123', '123-456-7890', 11, NULL),
('Tenant', 'Jane', 'Smith', 'jane.smith@example.com', 'password456', '234-567-8901', 12, NULL),
('Tenant', 'Bob', 'Johnson', 'bob.johnson@example.com', 'password789', '345-678-9012', 13, NULL),
('Tenant', 'Alice', 'Williams', 'alice.williams@example.com', 'password101', '456-789-0123', 14, NULL),
('Tenant', 'Charlie', 'Brown', 'charlie.brown@example.com', 'password202', '567-890-1234', 15, NULL),
('Tenant', 'Eva', 'Lee', 'eva.lee@example.com', 'password303', '678-901-2345', 16, NULL),
('Tenant', 'Frank', 'Miller', 'frank.miller@example.com', 'password404', '789-012-3456', 17, NULL),
('Tenant', 'Grace', 'Davis', 'grace.davis@example.com', 'password505', '890-123-4567', 18, NULL),
('Tenant', 'Henry', 'Taylor', 'henry.taylor@example.com', 'password606', '901-234-5678', 19, NULL),
('Tenant', 'Ivy', 'Martin', 'ivy.martin@example.com', 'password707', '012-345-6789', 20, NULL);

-- -*******************************************ENCRYPTION***************************************************
-- Create Master KEY
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'masterkey@1';

-- Create a self - signed certificate for Column level SQL encyrption
CREATE CERTIFICATE Certificate_test WITH SUBJECT = 'Protect My Data';

--Configure a symmetric key for column level SQL Server encryption
CREATE SYMMETRIC KEY SymKey_test WITH ALGORITHM = AES_256 ENCRYPTION BY CERTIFICATE Certificate_test;

-- Open the symmetric key and decrypt using the certficate 
OPEN SYMMETRIC KEY SymKey_test DECRYPTION BY CERTIFICATE Certificate_test;
--Data Encryption
UPDATE [User] SET [Password] = ENCRYPTBYKEY(KEY_GUID('SymKey_test'),[Password]) FROM [User];

-- Close Symmetric key
-- If we do  not close the key , it remains open untill the session is terminated
CLOSE SYMMETRIC KEY SymKey_test;
-- Output
-- SELECT * FROM [User];
-- *********************************************************************************************************

-- Insert into PropertyOwned for Landlords
INSERT INTO PropertyOwned (LandlordID, HouseNo, Street, Zipcode)
VALUES
(1, '123A', 'Main Street', '02138'),
(2, '456B', 'Tech Avenue', '02139'),
(3, '789C', 'College Road', '02215'),
(4, '101D', 'Huntington Ave', '02199'),
(5, '1E', 'The Green', '02135'),
(6, '8F', 'Ashburton Pl', '02108'),
(7, '120G', 'Boylston St', '02116'),
(8, '140H', 'Commonwealth Ave', '02467'),
(9, '100I', 'William T. Morrissey Blvd', '02125'),
(10, '175J', 'Forest St', '02452');

-- Insert into Accommodation for Landlords
INSERT INTO Accommodation (PropertyID, Title, Description, Type, Price, AvailabilityStatus)
VALUES
(1, 'Cozy Apartment near Harvard', 'A comfortable apartment with all amenities.', 'Apartment', 2000.00, 'Available'),
(2, 'Modern Condo in Tech District', 'A sleek and modern condo for professionals.', 'Condo', 2500.00, 'Available'),
(3, 'Spacious House with Yard', 'A family-friendly house with a beautiful yard.', 'House', 1800.00, 'Available'),
(4, 'Luxury Living in the City', 'Luxurious apartment with city views.', 'Apartment', 2200.00, 'Available'),
(5, 'Charming Studio in The Green', 'A charming studio near the university.', 'Studio', 1900.00, 'Available'),
(6, 'Downtown Penthouse', 'Penthouse with stunning city skyline views.', 'Penthouse', 2100.00, 'Available'),
(7, 'Historic Brownstone Apartment', 'Classic apartment in a historic brownstone.', 'Apartment', 2400.00, 'Available'),
(8, 'Elegant Condo with Park Views', 'Condo with views of the park.', 'Condo', 2600.00, 'Available'),
(9, 'Modern Apartment near UMass', 'Contemporary living close to the university.', 'Apartment', 2300.00, 'Available'),
(10, 'Spacious Townhouse in Waltham', 'Townhouse with ample space and amenities.', 'Townhouse', 2000.00, 'Available');

-- Insert into Amenities for Accommodations
INSERT INTO Amenities (AccommodationID, CentralizedAirConditioner, Description)
VALUES
(1, 1, 'Centralized air conditioning, Wi-Fi, fully furnished'),
(2, 0, 'Wi-Fi, modern appliances, security system'),
(3, 1, 'Spacious backyard, parking space, fully furnished'),
(4, 1, 'City views, luxury finishes, high-speed internet'),
(5, 0, 'Close to university, fully furnished'),
(6, 1, 'Penthouse views, modern amenities, gym access'),
(7, 0, 'Historic charm, classic architecture, fully furnished'),
(8, 1, 'Park views, high-end appliances, security system'),
(9, 1, 'Close to UMass campus, modern finishes'),
(10, 1, 'Spacious townhouse, parking, fully furnished');

INSERT INTO Distance (UniversityID, AccommodationID, Distance)
VALUES
(1, 1, 2.5),
(2, 2, 1.8),
(3, 3, 3.2),
(4, 4, 1.5),
(5, 5, 0.9),
(6, 6, 2.7),
(7, 7, 1.2),
(8, 8, 2.0),
(9, 9, 2.8),
(10, 10, 3.5);

INSERT INTO Transportation (DistanceID, AccommodationID, UniversityID, ModeOfTransport, DepartureTime, ArrivalTime, Price)
VALUES
(1, 1, 1, 'Bus', '08:00', '09:00', 5.00),
(2, 2, 2, 'Subway', '09:30', '10:15', 3.50),
(3, 3, 3, 'Train', '08:45', '12:00', 6.00),
(4, 4, 4, 'Bus', '10:00', '11:00', 4.00),
(5, 5, 5, 'Walking', NULL, NULL, 2.50),
(6, 6, 6, 'Car', '11:30', '12:30', 5.50),
(7, 7, 7, 'Bus', '10:15', '11:00', 3.00),
(8, 8, 8, 'Subway', '09:00', '09:45', 4.50),
(9, 9, 9, 'Train', '12:30', '14:30', 6.50),
(10, 10, 10, 'Bus', '11:45', '12:30', 7.00);

-- Insert into BillingSystem
INSERT INTO BillingSystem (PaymentID, PaymentAmount, PaymentDate, PaymentStatus)
VALUES
(1, 500.00, '2023-12-01', 'Completed'),
(2, 450.00, '2023-12-02', 'Completed'),
(3, 400.00, '2023-12-03', 'Pending'),
(4, 480.00, '2023-12-04', 'Completed'),
(5, 350.00, '2023-12-05', 'Pending'),
(6, 550.00, '2023-12-06', 'Completed'),
(7, 300.00, '2023-12-07', 'Pending'),
(8, 420.00, '2023-12-08', 'Completed'),
(9, 600.00, '2023-12-09', 'Pending'),
(10, 700.00, '2023-12-10', 'Completed');

-- Corrected INSERT INTO Booking
INSERT INTO Booking (TenantID, AccommodationID, PaymentID, BookingDate, PaymentStatus)
VALUES
(11, 1, 1, '2023-12-01', 'Completed'),
(12, 2, 2, '2023-12-02', 'Completed'),
(13, 3, 3, '2023-12-03', 'Pending'),
(14, 4, 4, '2023-12-04', 'Completed'),
(15, 5, 5, '2023-12-05', 'Pending'),
(16, 6, 6, '2023-12-06', 'Completed'),
(17, 7, 7, '2023-12-07', 'Pending'),
(18, 8, 8, '2023-12-08', 'Completed'),
(19, 9, 9, '2023-12-09', 'Pending'),
(20, 10, 10, '2023-12-10', 'Completed');

-- Insert into ReviewAndRating
INSERT INTO ReviewAndRating (TenantID, AccommodationID, Ratings, Date, Comments)
VALUES
(11, 1, 4, '2023-12-01', 'Great place, very convenient location.'),
(12, 2, 5, '2023-12-02', 'Excellent accommodation, highly recommended.'),
(13, 3, 3, '2023-12-03', 'Average experience, could be better.'),
(14, 4, 4, '2023-12-04', 'Good value for the price.'),
(15, 5, 5, '2023-12-05', 'Outstanding service and facilities.'),
(16, 6, 2, '2023-12-06', 'Not satisfied with cleanliness.'),
(17, 7, 4, '2023-12-07', 'Comfortable stay, friendly staff.'),
(18, 8, 5, '2023-12-08', 'Perfect for students, close to campus.'),
(19, 9, 3, '2023-12-09', 'Issues with amenities, need improvement.'),
(20, 10, 4, '2023-12-10', 'Enjoyed the stay, would come back.'),
(11, 3, 5, '2023-12-11', 'Fantastic property, exceeded expectations.'),
(12, 5, 4, '2023-12-12', 'Lovely studio, great amenities.'),
(13, 7, 3, '2023-12-13', 'Historic charm, but needs modern upgrades.'),
(14, 9, 5, '2023-12-14', 'Top-notch apartment, highly recommended.'),
(15, 2, 4, '2023-12-15', 'Modern condo with convenient location.'),
(16, 4, 2, '2023-12-16', 'Disappointed with the cleanliness and service.'),
(17, 6, 4, '2023-12-17', 'Penthouse living at its best.'),
(18, 8, 3, '2023-12-18', 'Good for students, but a bit overpriced.'),
(19, 10, 5, '2023-12-19', 'Great townhouse, spacious and well-maintained.'),
(20, 1, 4, '2023-12-20', 'Cozy apartment, perfect for my needs.');

-- Insert into MessagingSystem
INSERT INTO MessagingSystem (SenderID, ReceiverID, MessageContent, Timestamp)
VALUES
(11, 1, 'Hi, I am interested in your property.', '2023-12-01 08:30:00'),
(1, 11, 'Sure, lets discuss the details.', '2023-12-01 09:00:00'),
(12, 2, 'Is the apartment still available?', '2023-12-02 10:15:00'),
(2, 12, 'Yes, it is still available. When would you like to move in?', '2023-12-02 10:45:00'),
(13, 3, 'I have a few questions about the house.', '2023-12-03 11:30:00'),
(3, 13, 'Feel free to ask. I am here to help!', '2023-12-03 12:00:00'),
(14, 4, 'What utilities are included in the rent?', '2023-12-04 13:45:00'),
(4, 14, 'Water and internet are included. Electricity is separate.', '2023-12-04 14:15:00'),
(15, 5, 'Can I bring my pet to the studio?', '2023-12-05 15:30:00'),
(5, 15, 'Sorry, no pets allowed in the studio.', '2023-12-05 16:00:00'),
(16, 6, 'Tell me more about the amenities in the penthouse.', '2023-12-06 17:15:00'),
(6, 16, 'The penthouse has a gym, rooftop access, and modern appliances.', '2023-12-06 17:45:00'),
(17, 7, 'I am interested in renting your historic apartment.', '2023-12-07 18:30:00'),
(7, 17, 'Great choice! Lets schedule a viewing.', '2023-12-07 19:00:00'),
(18, 8, 'Is the condo suitable for two students?', '2023-12-08 20:45:00'),
(8, 18, 'Yes, the condo has two bedrooms. It is perfect for two students.', '2023-12-08 21:15:00'),
(19, 9, 'I am considering your apartment near UMass. Any student discounts?', '2023-12-09 22:30:00'),
(9, 19, 'Yes, we offer student discounts. Lets discuss the details.', '2023-12-09 23:00:00'),
(20, 10, 'I am looking forward to the townhouse viewing!', '2023-12-10 14:00:00'),
(10, 20, 'I will make sure it is arranged. See you at the viewing!', '2023-12-10 14:30:00');



