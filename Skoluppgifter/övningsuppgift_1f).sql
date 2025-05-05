SELECT
    [Name],
    Red,
    Green,
    Blue
INTO Colors2
FROM Colors;

ALTER TABLE Colors2
ADD Code AS (
    '#' +
    FORMAT(Red, 'X2') +
    FORMAT(Green, 'X2') +
    FORMAT(Blue, 'X2')
);

-- Visa resultatet
SELECT * FROM Colors2;