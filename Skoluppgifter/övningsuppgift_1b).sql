UPDATE Users2
SET username = LOWER(LEFT(firstname, 2) + LEFT(lastname, 2));

-- Visa resultatet
SELECT * FROM Users2