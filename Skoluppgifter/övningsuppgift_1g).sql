
SELECT
    Integer,
    String
INTO TypesCopy
FROM Types;

SELECT
    *,
    Integer * 0.01 AS FloatValue,
    DATEADD(Minute, Integer, DATEADD(Day, Integer, '2018-12-31 09:00')) AS DateAndTime,
    Integer % 2 AS BinaryValue
FROM TypesCopy;
