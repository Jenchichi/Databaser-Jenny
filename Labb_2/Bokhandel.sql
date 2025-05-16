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

