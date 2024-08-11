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