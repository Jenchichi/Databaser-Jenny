-- CREATE DATABASE Bokhandel;

CREATE TABLE Författare (
    FörfattareID INT IDENTITY(1,1) PRIMARY KEY,
    Förnamn VARCHAR(50),
    Efternamn VARCHAR(50),
    Födelsedatum DATE,
);

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

-- SELECT * FROM Böcker;

CREATE TABLE Butiker (
    ButikID INT IDENTITY(1,1) PRIMARY KEY,
    Butiksnamn VARCHAR(100),
    Adress VARCHAR(200),
    Postnummer VARCHAR(10),
    Ort VARCHAR(50),
);

-- SELECT * FROM Butiker;

CREATE TABLE LagerSaldo (
    ButikID INT,
    ISBN CHAR(13),
    Antal INT,
    CONSTRAINT PK_LagerSaldo PRIMARY KEY (ButikID, ISBN),
    CONSTRAINT FK_ButikID FOREIGN KEY (ButikID) REFERENCES Butiker(ButikID),
    CONSTRAINT FK_ISBN FOREIGN KEY (ISBN) REFERENCES Böcker(ISBN13)
);

-- SELECT * FROM LagerSaldo;

