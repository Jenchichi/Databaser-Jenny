-- Uppgift 1a)
SELECT symbol, [name]
FROM elements
WHERE left([name], len(symbol)) = symbol;

-- Uppgift 1b)
SELECT symbol, [name]
FROM elements
WHERE [name] LIKE '[hlb]%' OR [name] IN ('Carbon', 'Nitrogen', 'Oxygen');

-- Uppgift 1c)
SELECT symbol, [name]
FROM elements
WHERE [number] < 5

-- Uppgift 2)
SELECT
  Period,
  min(Number) as 'from',
  max(Number) as 'to',
  string_agg(Symbol, ',') as 'Elements'
FROM
  elements
GROUP BY
  Period;

-- Uppgift 3a) - kör ej denna kod.
INSERT INTO periodic_elements (Period, [from], [to], Elements)
SELECT
  Period,
  min(Number) as 'from',
  max(Number) as 'to',
  string_agg(Symbol, ',') as 'Elements'
FROM
  elements
GROUP BY
  Period;

-- 3b)
-- Tabellen periodic_elements är inte i någon hög normalform. Den bryter mot 1NF eftersom kolumnen "Elements" 
-- innehåller flera värden (kommaseparerad lista). För att vara i 1NF måste varje attribut innehålla endast 
-- atomära (odelabara) värden. 
-- För att en tabell ska uppfylla 2NF eller 3NF måste den först uppfylla 1NF. Eftersom tabellen periodic_elements 
-- inte uppfyller 1NF (på grund av den icke-atomära kolumnen "Elements" och avsaknaden av en definierad primärnyckel), 
-- kan den inte heller uppfylla 2NF eller 3NF.

-- Normalformer bygger på varandra hierarkiskt:
-- För att vara i 2NF måste en tabell först vara i 1NF
-- För att vara i 3NF måste en tabell först vara i 2NF
-- Så svaret är nej, tabellen uppfyller varken 2NF eller 3NF eftersom den inte ens uppfyller kraven för 1NF.

-- Uppgift 4)
SELECT
  Period,
  Number
FROM
  Elements
GROUP BY
  Period;
-- Saknas en aggregering på Number, ex. COUNT(), AVG(), SUM(), MIN(), MAX(), STRING_AGG(), 
-- så att vi kan se hur många element som finns i varje period. 
-- Alt. lägga till Number i GROUP BY-satsen. Vi kan alltså inte endast ha Period i GROUP BY-satsen, utan att inkludera Number.
SELECT
    Period,
    COUNT(Number) AS 'Number of Elements'
FROM
    Elements
GROUP BY
    Period;

-- Uppgift 5)
-- De givna tabelldefinitionerna är i 3NF (tredje normalform) eftersom:
-- De är i 1NF: Alla attribut innehåller atomära värden.
-- De är i 2NF: Alla icke-nyckelberoende attribut är helt beroende av primärnyckeln.
-- De är i 3NF: Inga transitiva beroenden finns (inga attribut beror på andra attribut som inte är nycklar).
-- Tabellen student_grade använder en sammansatt primärnyckel (courseID, studentID) och grade är beroende av denna sammansatta nyckel.

CREATE TABLE course (
    courseID int primary key,
    [name] nvarchar(120),
    credits int
);
-- 1NF (Första normalformen):
-- ✅ Alla attribut innehåller ett ensamt attribut (värde)
-- ✅ Det finns en primärnyckel (courseID)
-- ✅ Inga upprepade grupper av kolumner

-- 2NF (Andra normalformen):
-- ✅ Tabellen är i 1NF
-- ✅ Alla icke-nyckelberoende attribut är helt funktionellt beroende av hela primärnyckeln
-- Eftersom primärnyckeln är enkel (bara courseID) och inte sammansatt, är detta krav automatiskt uppfyllt

-- 3NF (Tredje normalformen):
-- ✅ Tabellen är i 2NF
-- ✅ Inga transitiva beroenden finns
-- name och credits beror direkt på courseID, inte på varandra eller någon annan icke-nyckel
-- Slutsats: Tabellen course är i 3NF.

CREATE TABLE student (
    studentID int primary key,
    [name] nvarchar(32)
);
-- 1NF:
-- ✅ Alla attribut innehåller atomära värden
-- ✅ Det finns en primärnyckel (studentID)
-- ✅ Inga upprepade grupper av kolumner

-- 2NF:
-- ✅ Tabellen är i 1NF
-- ✅ Alla icke-nyckelberoende attribut är helt funktionellt beroende av hela primärnyckeln
-- Eftersom primärnyckeln är enkel (bara studentID), är detta krav automatiskt uppfyllt

-- 3NF:
-- ✅ Tabellen är i 2NF
-- ✅ Inga transitiva beroenden finns
-- name beror direkt på studentID, inte på någon annan icke-nyckel
-- Slutsats: Tabellen student är i 3NF.

CREATE TABLE student_grade (
    courseID int references course,
    studentID int references student,
    grade nvarchar(2)
);
-- 1NF:
-- ✅ Alla attribut innehåller atomära värden
-- ✅ Det finns en primärnyckel (även om den inte är explicit definierad, är den sammansatta nyckeln (courseID, studentID) implicit)
-- ✅ Inga upprepade grupper av kolumner

-- 2NF:
-- ✅ Tabellen är i 1NF
-- ✅ Alla icke-nyckelberoende attribut är helt funktionellt beroende av hela primärnyckeln
-- grade beror på hela den sammansatta nyckeln (courseID, studentID), inte bara på en del av den
-- Ett betyg är specifikt för en viss student i en viss kurs

-- 3NF:
-- ✅ Tabellen är i 2NF
-- ✅ Inga transitiva beroenden finns
-- grade beror direkt på den sammansatta nyckeln (courseID, studentID), inte på någon annan icke-nyckel
-- Slutsats: Tabellen student_grade är i 3NF.

-- Uppgift 6)
SELECT 
    s.[name] AS StudentName,
    c.[name] AS CourseName,
    sg.grade AS Grade
FROM 
    student s
JOIN 
    student_grade sg ON s.studentID = sg.studentID
JOIN 
    course c ON sg.courseID = c.courseID
ORDER BY 
    s.[name], c.[name];
