SELECT
    FirstName + ' ' + LastName AS Name,

    -- Ålder
    CAST(DATEDIFF(YEAR, CAST(
        '19' + LEFT(ID, 2) + '-' + SUBSTRING(ID, 3, 2) + '-' + SUBSTRING(ID, 5, 2)
    AS DATE), GETDATE()) AS varchar) + ' år' AS Ålder,

    -- Kön baserat på tredje sista siffran
    CASE 
        WHEN CAST(SUBSTRING(ID, 10, 1) AS INT) % 2 = 1 THEN 'Man'
        ELSE 'Kvinna'
    END AS Kön

FROM Users
ORDER BY FirstName, LastName;