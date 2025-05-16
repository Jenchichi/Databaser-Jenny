-- SELECT * FROM MoonMissions;

SELECT
    Spacecraft,
    [Launch date],
    [Carrier rocket],
    Operator,
    [Mission type]
INTO SuccessfulMissions
FROM MoonMissions
WHERE Outcome = 'Successful';

GO

UPDATE SuccessfulMissions
SET [Operator] = LTRIM([Operator]); 

GO

UPDATE SuccessfulMissions
SET Spacecraft = LTRIM(LEFT(Spacecraft, CHARINDEX('(', Spacecraft + '()') -1));

GO

SELECT
    Operator,
    [Mission type],
    COUNT(*) AS [Mission count]
FROM 
    SuccessfulMissions
GROUP BY 
    Operator,
    [Mission type]
HAVING
    COUNT(*) > 1
ORDER BY
    Operator,
    [Mission type];

GO

SELECT 
    ID,
    UserName,
    Password,
    Email,
    Phone,
    FirstName + ' ' + LastName AS Name,
    CASE
        WHEN CAST(SUBSTRING(ID, 10, 1) AS INT) % 2 = 0 THEN 'Female'
        ELSE 'Male'
    END AS Gender
INTO NewUsers
FROM Users;

GO

SELECT
    UserName,
    COUNT(*) AS DublicateCount
FROM
    NewUsers
GROUP BY
    UserName
HAVING COUNT(*) > 1;

GO

WITH Duplicates AS (
    SELECT
        ID,
        UserName,
        ROW_NUMBER() OVER (PARTITION BY UserName ORDER BY ID) AS RowNum
    FROM NewUsers
)
UPDATE NewUsers
SET UserName = CONCAT(LEFT(Duplicates.UserName, 50), Duplicates.RowNum)
FROM NewUsers
JOIN Duplicates ON NewUsers.ID = Duplicates.ID
AND Duplicates.RowNum > 1;

GO

DELETE FROM NewUsers
WHERE Gender = 'Female'
AND CAST(LEFT(ID, 2) AS INT) < 70;

GO

INSERT INTO NewUsers (
    ID, UserName, Password, Email, Phone, Name, Gender
)
VALUES (
    '900324-1243',
    'karsko',
    'password123',
    'karolina.skoglund@test.com',
    '0701234567',
    'Karolina Skoglund',
    'Female'
);

GO

SELECT
    CASE
        WHEN SUBSTRING(RIGHT(ID, 2), 1, 1)  % 2 = 0 THEN 'Female'
        ELSE 'Male'
    END AS 'Gender',
    CAST(AVG(FLOOR(DATEDIFF(DAY, CONVERT(date, LEFT(ID, 6)), GETDATE()) / 365.25)) AS INT) AS 'Average Age'
FROM
    NewUsers
GROUP BY
    CASE
        WHEN SUBSTRING(RIGHT(ID, 2), 1, 1) % 2 = 0 THEN 'Female'
        ELSE 'Male'
    END;

GO

SELECT
    p.Id AS Id,
    p.ProductName AS Product,
    s.CompanyName AS Supplier,
    c.CategoryName AS Category
FROM
    company.products p
JOIN
    company.suppliers s ON p.SupplierId = s.Id
JOIN
    company.categories c ON p.CategoryId = c.Id;

GO

SELECT 
    r.RegionDescription AS Region,
    COUNT(DISTINCT et.EmployeeId) AS [Antal Anställda]
FROM 
    company.territories t
INNER JOIN 
    company.regions r ON t.RegionId = r.Id
INNER JOIN 
    company.employee_territory et ON t.Id = et.TerritoryId
GROUP BY 
    r.RegionDescription
ORDER BY
    r.RegionDescription;

GO

SELECT
    e.Id AS [Id],
    CONCAT(e.title, ', ', e.FirstName, ' ', e.LastName) AS [Namn],
    CASE
        WHEN m.Id IS NULL THEN 'Nobody!'
        ELSE CONCAT(m.title, ' ', m.FirstName, ' ', m.LastName)
    END AS [Reports to]
FROM
    company.employees e
LEFT JOIN
    company.employees m ON e.ReportsTo = m.Id
ORDER BY
    e.Id;

GO
