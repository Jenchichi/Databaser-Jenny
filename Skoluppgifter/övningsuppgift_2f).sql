SELECT
    RTRIM(RIGHT([Location served], CHARINDEX(',', REVERSE([Location served]) + ',') -1)) AS Land,

    COUNT(IATA) AS AntalFlygplatser,

    SUM(CASE WHEN ICAO IS NULL THEN 1 ELSE 0 END) AS SaknarICAO,

    FORMAT(
        SUM(CASE WHEN ICAO IS NULL THEN 1 ELSE 0 END) * 1.0 / NULLIF(COUNT(IATA), 0),
        'P'
    ) AS ProcentAndelUtanICAO

FROM Airports
GROUP BY
    RTRIM(RIGHT([Location served], CHARINDEX(',', REVERSE([Location served]) + ',') -1))

ORDER BY Land;