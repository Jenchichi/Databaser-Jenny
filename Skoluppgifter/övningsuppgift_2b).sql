SELECT
    Region,
    Country,
    City,
    COUNT(*) AS 'Number of customers'
FROM
    company.customers
GROUP BY
    Region,
    Country,
    City
HAVING
    COUNT(*) > 1
ORDER BY
    COUNT(*);