-- CREATE DATABASE Bokhandel;

CREATE TABLE Författare (
    FörfattareID INT IDENTITY(1,1) PRIMARY KEY,
    Förnamn VARCHAR(50),
    Efternamn VARCHAR(50),
    Födelsedatum DATE,
);

INSERT INTO Författare (Förnamn, Efternamn, Födelsedatum)
VALUES
    ('Astrid', 'Lindgren', '1907-11-14'),
    ('Ann', 'Rosman', '1973-02-27'),
    ('Camilla', 'Läckberg', '1974-08-30'),
    ('Leif GW', 'Persson', '1945-03-12');

-- SELECT * FROM Författare;

CREATE TABLE Böcker (
    ISBN13 CHAR(13) PRIMARY KEY,
    Titel VARCHAR(100),
    Språk VARCHAR(50),
    Pris DECIMAL(10, 2),
    Utgivningsdatum DATE,
    FörfattareID INT,
    CONSTRAINT FK_FörfattareID FOREIGN KEY (FörfattareID) REFERENCES Författare(FörfattareID)
);

INSERT INTO Böcker (ISBN13, Titel, Språk, Pris, Utgivningsdatum, FörfattareID)
VALUES
    ('9789127134311', 'Pippi Långstrump', 'Svenska', 249.00, '1945-11-26', 1),
    ('9789127134328', 'Ronja Rövardotter', 'Svenska', 189.00, '1981-11-26', 1),
    ('9789127134335', 'Bröderna Lejonhjärta', 'Svenska', 199.00, '1973-11-26', 1),
    ('9789127134342', 'Alla vi barn i Bullerbyn', 'Svenska', 149.00, '1949-11-26', 1),
    ('9789127134359', 'Fyrmästarens dotter', 'Svenska', 259.00, '2005-11-26', 2),
    ('9789127134366', 'Havskatten', 'Svenska', 249.00, '2006-11-26', 2),
    ('9789127134373', 'Isprinsessan', 'Svenska', 139.00, '2004-11-26', 3),
    ('9789127134380', 'Tjänarinnans dotter', 'Svenska', 129.00, '2005-11-26', 3),
    ('9789127134397', 'Den som dödar draken', 'Svenska', 189.00, '2006-11-26', 4),
    ('9789127134403', 'En pilgrims död', 'Svenska', 199.00, '2013-11-26', 4);


-- SELECT * FROM Böcker;

CREATE TABLE Butiker (
    ButikID INT IDENTITY(1,1) PRIMARY KEY,
    Butiksnamn VARCHAR(100),
    Adress VARCHAR(200),
    Postnummer VARCHAR(10),
    Ort VARCHAR(50),
);

INSERT INTO Butiker (Butiksnamn, Adress, Postnummer, Ort)
VALUES
    ('Jennys Hörna', 'Drottninggatan 1', '111 21', 'Stockholm'),
    ('Jennys Hörna', 'Avenyn 2', '411 36', 'Göteborg'),
    ('Jennys Hörna', 'Stortorget 3', '211 22', 'Malmö');

-- SELECT * FROM Butiker;

CREATE TABLE LagerSaldo (
    ButikID INT,
    ISBN CHAR(13),
    Antal INT,
    CONSTRAINT PK_LagerSaldo PRIMARY KEY (ButikID, ISBN),
    CONSTRAINT FK_ButikID FOREIGN KEY (ButikID) REFERENCES Butiker(ButikID),
    CONSTRAINT FK_ISBN FOREIGN KEY (ISBN) REFERENCES Böcker(ISBN13)
);

INSERT INTO LagerSaldo (ButikID, ISBN, Antal)
VALUES
    (1, '9789127134311', 5),
    (1, '9789127134328', 8),
    (1, '9789127134335', 3),
    (1, '9789127134342', 12),
    (1, '9789127134359', 9),
    (1, '9789127134366', 6),
    (1, '9789127134373', 11),
    (1, '9789127134380', 7),
    (1, '9789127134397', 4),
    (1, '9789127134403', 10),
    (2, '9789127134311', 9),
    (2, '9789127134328', 5),
    (2, '9789127134335', 11),
    (2, '9789127134342', 6),
    (2, '9789127134359', 8),
    (2, '9789127134366', 4),
    (2, '9789127134373', 10),
    (2, '9789127134380', 3),
    (2, '9789127134397', 12),
    (2, '9789127134403', 7),
    (3, '9789127134311', 11),
    (3, '9789127134328', 9),
    (3, '9789127134335', 5),
    (3, '9789127134342', 10),
    (3, '9789127134359', 6),
    (3, '9789127134366', 8),
    (3, '9789127134373', 4),
    (3, '9789127134380', 12),
    (3, '9789127134397', 3),
    (3, '9789127134403', 9);

-- SELECT * FROM LagerSaldo;

CREATE TABLE Kunder (
    KundID INT IDENTITY(1,1) PRIMARY KEY,
    Förnamn VARCHAR(50),
    Efternamn VARCHAR(50),
    Epost VARCHAR(100),
    Telefonnummer VARCHAR(20),
    Adress VARCHAR(200),
    Postnummer VARCHAR(10),
    Ort VARCHAR(50),
);

INSERT INTO Kunder (Förnamn, Efternamn, Epost, Telefonnummer, Adress, Postnummer, Ort)
VALUES
    ('Anna', 'Larsson', 'anna.larsson@example.com', '070-1234567', 'Storgatan 1', '12345', 'Stockholm'),
    ('Petter', 'Hansson', 'petter.hansson@example.com', '070-9012345', 'Östra Hamngatan 4', '33333', 'Stockholm'),
    ('Erik', 'Johansson', 'erik.johansson@example.com', '070-9876543', 'Drottninggatan 2', '11111', 'Göteborg'),
    ('Sara', 'Lindström', 'sara.lindström@example.com', '070-1112222', 'Västra Hamngatan 5', '44444', 'Göteborg'),
    ('Lena', 'Andersson', 'lena.andersson@example.com', '070-5551234', 'Kungsgatan 3', '22222', 'Malmö'),
    ('Johan', 'Nilsson', 'johan.nilsson@example.com', '070-2223333', 'Norra Hamngatan 6', '55555', 'Malmö');

-- SELECT * FROM Kunder;

CREATE TABLE Ordrar (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    KundID INT,
    ButikID INT,
    Orderdatum DATE,
    Totalbelopp DECIMAL(10, 2),
    AntalBöcker INT,
    CONSTRAINT FK_KundID FOREIGN KEY (KundID) REFERENCES Kunder(KundID),
    CONSTRAINT FK_ButikID_ordrar FOREIGN KEY (ButikID) REFERENCES Butiker(ButikID)
);

INSERT INTO Ordrar (KundID, ButikID, Orderdatum, Totalbelopp, AntalBöcker)
VALUES
    (1, 1, '2024-12-15', 508.00, 2),
    (2, 1, '2025-01-05', 189.00, 1),
    (3, 2, '2025-02-10', 776.00, 4),
    (4, 2, '2025-04-08', 1045.00, 5),
    (5, 3, '2024-12-20', 1164.00, 6),
    (6, 3, '2025-03-18', 647.00, 3);

-- SELECT * FROM Ordrar;

CREATE TABLE Personal (
    PersonID INT IDENTITY(1,1) PRIMARY KEY,
    Förnamn VARCHAR(50),
    Efternamn VARCHAR(50),
    Telefonnummer VARCHAR(20),
    Epost VARCHAR(100),
    ButikID INT,
    Roll VARCHAR(50),
    Anställningsdatum DATE,
    CONSTRAINT FK_ButikID_Personal FOREIGN KEY (ButikID) REFERENCES Butiker(ButikID)
);

INSERT INTO Personal (Förnamn, Efternamn, Telefonnummer, Epost, ButikID, Roll, Anställningsdatum)
VALUES
    ('Rebecca', 'Olsson', '070-1234567', 'rebecca.olsson@example.com', 1, 'Butikschef', '2022-01-01'),
    ('Magnus', 'Persson', '070-9012345', 'magnus.persson@example.com', 1, 'Säljare', '2022-06-01'),
    ('Emma', 'Lundberg', '070-1112222', 'emma.lundberg@example.com', 2, 'Butikschef', '2021-03-01'),
    ('Fredrik', 'Svensson', '070-5551234', 'fredrik.svensson@example.com', 2, 'Säljare', '2021-09-01'),
    ('Sofia', 'Jönsson', '070-2223333', 'sofia.jonsson@example.com', 3, 'Butikschef', '2023-05-01'),
    ('Andreas', 'Lindgren', '070-3334444', 'andreas.lindgren@example.com', 3, 'Säljare', '2023-11-01');

-- SELECT * FROM Personal;

CREATE TABLE Försäljning (
    FörsäljningsID INT IDENTITY(1,1) PRIMARY KEY,
    PersonID INT,
    ButikID INT,
    OrderID INT,
    BokID CHAR(13),
    Försäljningsdatum DATE,
    Antal INT,
    Totalbelopp DECIMAL(10, 2),
    CONSTRAINT FK_PersonID FOREIGN KEY (PersonID) REFERENCES Personal(PersonID),
    CONSTRAINT FK_ButikID_Försäljning FOREIGN KEY (ButikID) REFERENCES Butiker(ButikID),
    CONSTRAINT FK_OrderID FOREIGN KEY (OrderID) REFERENCES Ordrar(OrderID),
    CONSTRAINT FK_BokID FOREIGN KEY (BokID) REFERENCES Böcker(ISBN13)
);

INSERT INTO Försäljning (PersonID, ButikID, OrderID, BokID, Försäljningsdatum, Antal, Totalbelopp)
VALUES
    (1, 1, 1, '9789127134311', '2024-12-15', 1, 249.00),
    (1, 1, 1, '9789127134359', '2024-12-15', 1, 259.00),
    (2, 1, 2, '9789127134328', '2025-01-05', 1, 189.00),
    (3, 2, 3, '9789127134366', '2025-02-10', 1, 249.00),
    (3, 2, 3, '9789127134373', '2025-02-10', 1, 139.00),
    (3, 2, 3, '9789127134397', '2025-02-10', 1, 189.00),
    (3, 2, 3, '9789127134403', '2025-02-10', 1, 199.00),
    (4, 2, 4, '9789127134311', '2025-04-08', 1, 249.00),
    (4, 2, 4, '9789127134359', '2025-04-08', 1, 259.00),
    (4, 2, 4, '9789127134342', '2025-04-08', 1, 149.00),
    (4, 2, 4, '9789127134335', '2025-04-08', 1, 199.00),
    (4, 2, 4, '9789127134328', '2025-04-08', 1, 189.00),
    (5, 3, 5, '9789127134359', '2024-12-20', 1, 259.00),
    (5, 3, 5, '9789127134366', '2024-12-20', 1, 249.00),
    (5, 3, 5, '9789127134373', '2024-12-20', 1, 139.00),
    (5, 3, 5, '9789127134380', '2024-12-20', 1, 129.00),
    (5, 3, 5, '9789127134397', '2024-12-20', 1, 189.00),
    (5, 3, 5, '9789127134403', '2024-12-20', 1, 199.00),
    (6, 3, 6, '9789127134366', '2025-03-18', 1, 249.00),
    (6, 3, 6, '9789127134335', '2025-03-18', 1, 199.00),
    (6, 3, 6, '9789127134403', '2025-03-18', 1, 199.00);

-- SELECT * FROM Försäljning;

GO

CREATE VIEW TitlarPerFörfattare AS
SELECT
    F.Förnamn + ' ' + F.Efternamn AS Namn,
    DATEDIFF(YEAR, F.Födelsedatum, GETDATE()) AS Ålder,
    COUNT(DISTINCT B.ISBN13) AS Titlar,
    SUM(B.Pris * LS.Antal) AS LagerVärde
FROM
    Författare F
LEFT JOIN
    Böcker B ON F.FörfattareID = B.FörfattareID
LEFT JOIN
    LagerSaldo LS ON B.ISBN13 = LS.ISBN
GROUP BY
    F.FörfattareID, F.Förnamn, F.Efternamn, F.Födelsedatum;

GO

-- SELECT top 1 * FROM TitlarPerFörfattare;
-- SELECT * FROM TitlarPerFörfattare;

CREATE PROCEDURE FlyttaBok
    @FromButikID INT,
    @ToButikID INT,
    @ISBN CHAR(13),
    @Antal INT = 1
AS
BEGIN
    -- Kontrollera att butikerna existerar
    IF NOT EXISTS (SELECT * FROM Butiker WHERE ButikID = @FromButikID)
        RAISERROR ('Butiken som skall flyttas från finns inte.', 16, 1);
    IF NOT EXISTS (SELECT * FROM Butiker WHERE ButikID = @ToButikID)
        RAISERROR ('Butiken som skall flyttas till finns inte', 16, 1);
    
    -- Kontrollera att boken existerar
    IF NOT EXISTS (SELECT * FROM Böcker WHERE ISBN13 = @ISBN)
        RAISERROR ('Boken som skall flyttas finns inte i systemet', 16, 1);
        
    -- Kontrollera att det finns tillräckligt många böcker i lager
    IF (SELECT Antal FROM LagerSaldo WHERE ButikID = @FromButikID AND ISBN = @ISBN) < @Antal
    BEGIN
        RAISERROR ('Det finns inte tillräckligt många exemplar av boken i butiken.', 16, 1);
    END
    ELSE
    BEGIN
        -- Uppdatera lagersaldot
        UPDATE LagerSaldo
        SET Antal = Antal - @Antal
        WHERE ButikID = @FromButikID AND ISBN = @ISBN;

        IF EXISTS (SELECT * FROM LagerSaldo WHERE ButikID = @ToButikID AND ISBN = @ISBN)
        BEGIN
            UPDATE LagerSaldo
            SET Antal = Antal + @Antal
            WHERE ButikID = @ToButikID AND ISBN = @ISBN;
        END
        ELSE
        BEGIN
            INSERT INTO LagerSaldo (ButikID, ISBN, Antal)
            VALUES (@ToButikID, @ISBN, @Antal);
        END
    END
END;

GO

-- SELECT * FROM LagerSaldo;

-- EXEC FlyttaBok Från butik 2, Till Butik 3, ISBN='9789127134397' (Den som dödar draken), Antal=1
-- EXEC FlyttaBok @FromButikID = 3, @ToButikID = 2, @ISBN = '9789127134397', @Antal = 10;
-- SELECT * FROM LagerSaldo WHERE ISBN = '9789127134397';

CREATE TABLE FörfattareBöcker (
    FörfattareID INT,
    BokID CHAR(13),
    PRIMARY KEY (FörfattareID, BokID),
    FOREIGN KEY (FörfattareID) REFERENCES Författare(FörfattareID),
    FOREIGN KEY (BokID) REFERENCES Böcker(ISBN13)
);

INSERT INTO FörfattareBöcker (FörfattareID, BokID)
VALUES
    (2, '9789127134359'),
    (3, '9789127134359'),
    (4, '9789127134403'),
    (1, '9789127134403'),
    (1, '9789127134328'),
    (2, '9789127134328');

-- SELECT * FROM FörfattareBöcker;

SELECT F.Förnamn, F.Efternamn, B.Titel
FROM Författare F
JOIN FörfattareBöcker FB ON F.FörfattareID = FB.FörfattareID
JOIN Böcker B ON FB.BokID = B.ISBN13;

SELECT B.Titel, STRING_AGG(F.Förnamn + ' ' + F.Efternamn, ', ') AS Författare
FROM Böcker B
JOIN FörfattareBöcker FB ON B.ISBN13 = FB.BokID
JOIN Författare F ON FB.FörfattareID = F.FörfattareID
GROUP BY B.Titel;

GO
-- Denna vy hjälper bokhandeln att identifiera sina mest lönsamma kunder,
-- vilket gör det möjligt att rikta marknadsföringsinsatser mer effektivt.
-- Genom att analysera kundernas köpbeteende och köpmönster kan bokhandeln 
-- fatta bättre beslut kring kampanjer, lojalitetsprogram och kundrelationer.

CREATE VIEW TopKunder AS
SELECT TOP 10
    K.Förnamn,
    K.Efternamn,
    COUNT(O.OrderID) AS AntalOrdrar,
    SUM(F.Totalbelopp) AS Totalförsäljningsbelopp
FROM
    Kunder K
JOIN Ordrar O ON K.KundID = O.KundID
JOIN Försäljning F ON O.OrderID = F.OrderID
GROUP BY
    K.Förnamn,
    K.Efternamn
ORDER BY
    Totalförsäljningsbelopp DESC;

GO

-- SELECT * FROM TopKunder;
-- SELECT TOP 3 * FROM TopKunder;