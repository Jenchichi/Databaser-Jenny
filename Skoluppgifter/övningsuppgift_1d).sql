DELETE from elements2
WHERE
    Name in ('Erbium', 'Helium', 'Nitrogen', 'Platinum', 'Selenium')
    or LOWER(LEFT(name, 1)) IN ('d', 'k', 'm', 'o', 'u');

-- Visa resultatet
SELECT * FROM elements2;