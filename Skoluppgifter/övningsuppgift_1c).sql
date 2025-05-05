UPDATE airports2
SET 
    Time = ISNULL(Time, '-'),
    DST = ISNULL(DST, '-');

-- Visa resultatet
SELECT * FROM airports2;