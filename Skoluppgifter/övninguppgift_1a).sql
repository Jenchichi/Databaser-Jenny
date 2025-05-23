
-- 1a) 
SELECT
    Title,
    'S' + FORMAT(Season, '00') + 'E' + FORMAT(EpisodeInSeason, '00') AS Episode
FROM
    GameOfThrones
ORDER BY
    Season, EpisodeInSeason;

SELECT symbol, [name]
FROM elements
WHERE left([name], len(symbol)) = symbol;