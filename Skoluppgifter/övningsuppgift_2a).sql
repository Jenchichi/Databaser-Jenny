SELECT
    Period,
    MIN(Number) AS [From],
    MAX(Number) AS [To],
    FORMAT(AVG(CONVERT(float, Stableisotopes)), 'N2') AS [average isotopes],
    STRING_AGG(Symbol, ',') WITHIN GROUP (ORDER by Number) AS symbols
FROM Elements
GROUP BY Period
ORDER BY Period; 