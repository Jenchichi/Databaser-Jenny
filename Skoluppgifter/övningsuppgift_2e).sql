SELECT
    Region,
    COUNT(*) AS AntalLänder,
    SUM(CAST(Population as float)) AS [TotalInvånare],
    SUM(CAST([Area (sq# mi#)] as float)) AS [TotalArea],
    ROUND(SUM(CAST(Population as float)) * 1.0 / SUM(CAST([Area (sq# mi#)] AS FLOAT)), 2) AS Befolkningstäthet,
    ROUND(AVG(CAST(REPLACE([Infant mortality (per 1000 births)], ',', '.') AS FLOAT)) * 100, 0) AS [Spädbarnsdödlighet per 100 000]

FROM Countries
GROUP BY Region
ORDER BY Region;