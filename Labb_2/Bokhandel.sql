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
    ('978-91-27-13431-1', 'Pippi Långstrump', 'Svenska', 249.00, '1945-11-26', 1),
    ('978-91-27-13432-8', 'Ronja Rövardotter', 'Svenska', 189.00, '1981-11-26', 1),
    ('978-91-27-13433-5', 'Bröderna Lejonhjärta', 'Svenska', 199.00, '1973-11-26', 1),
    ('978-91-27-13434-2', 'Alla vi barn i Bullerbyn', 'Svenska', 149.00, '1949-11-26', 1),
    ('978-91-27-13435-9', 'Fyrmästarens dotter', 'Svenska', 259.00, '2005-11-26', 2),
    ('978-91-27-13436-6', 'Havskatten', 'Svenska', 249.00, '2006-11-26', 2),
    ('978-91-27-13437-3', 'Isprinsessan', 'Svenska', 139.00, '2004-11-26', 3),
    ('978-91-27-13438-0', 'Tjänarinnans dotter', 'Svenska', 129.00, '2005-11-26', 3),
    ('978-91-27-13439-7', 'Den som dödar draken', 'Svenska', 189.00, '2006-11-26', 4),
    ('978-91-27-13440-3', 'En pilgrims död', 'Svenska', 199.00, '2013-11-26', 4);
-- inte körd än.
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
    (1, '978-91-27-13431-1', 10),
    (2, '978-91-27-13431-1', 10),
    (3, '978-91-27-13431-1', 10),
    


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

-- SELECT * FROM Ordrar;

CREATE TABLE Förlag (
    FörlagsID INT IDENTITY(1,1) PRIMARY KEY,
    Förlagsnamn VARCHAR(100),
    Adress VARCHAR(200),
    Postnummer VARCHAR(10),
    Ort VARCHAR(50),
    Telefonnummer VARCHAR(20),
    Epost VARCHAR(100)
);

-- SELECT * FROM Förlag;

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

-- SELECT * FROM Försäljning;

