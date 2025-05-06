DECLARE @info VARCHAR(MAX) = '';

SELECT @info = @info +
    FORMATMESSAGE(
        'Säsong %d sändes från %s till %s %d. Totalt sändes %d avsnitt, som i genomsnitt sågs av %s miljoner människor i USA.',
        Season,
        FORMAT(MIN([Original Air Date]), 'MMMM', 'sv'),
        FORMAT(MAX([Original Air Date]), 'MMMM', 'sv'),
        YEAR(MAX([Original Air Date])),
        COUNT(*),
        FORMAT(AVG(CAST([U.S. viewers(millions)] AS float)), 'N1')
    ) + CHAR(13) + CHAR(10)
FROM GameOfThrones
GROUP BY Season
ORDER BY Season;

PRINT @info;
