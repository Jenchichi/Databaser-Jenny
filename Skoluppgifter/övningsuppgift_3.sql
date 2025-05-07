-- 1
SELECT
    CAST(COUNT(Distinct od.ProductID) * 100.0 / 77 AS DECIMAL(5,2)) AS [Antal Produkter Till London] 

FROM
    company.order_details od
JOIN
    company.orders o ON od.OrderID = o.Id
WHERE
    o.ShipCity = 'London';


-- 2
SELECT
    o.ShipCity,
    COUNT(distinct od.ProductID) AS [Unika Produkter]
FROM
    company.orders o
JOIN
    company.order_details od ON od.OrderId = o.Id
GROUP BY
    o.ShipCity
ORDER BY
    [Unika Produkter] DESC;

-- 3

