SELECT
    Symbol,
    Name,
    CASE
        WHEN LEFT(Name, len(Symbol)) = Symbol THEN 'Yes'
        ELSE 'No'
    END AS StartsWithSymbol
INTO elementscheck
FROM elements;

-- Visa resultatet
SELECT * FROM elementscheck;