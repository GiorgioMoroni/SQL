--DDL
DROP TABLE IF EXISTS Studente_Esame;
DROP TABLE IF EXISTS Studente;
DROP TABLE IF EXISTS Esame;

CREATE TABLE Studente(
	studenteID INT PRIMARY KEY IDENTITY(1,1),
	nominativo VARCHAR(250) NOT NULL,
	matricola VARCHAR(250) NOT NULL UNIQUE
);

CREATE TABLE Esame(
	esameID INT PRIMARY KEY IDENTITY(1,1),
	titolo VARCHAR(250) NOT NULL,
	data_esame DATE NOT NULL,
	crediti INT CHECK (crediti >= 0) NOT NULL
);

CREATE TABLE Studente_Esame(
	studenteRIF INT NOT NULL,
	esameRIF INT NOT NULL,
	FOREIGN KEY (studenteRIF) REFERENCES Studente(studenteID) ON DELETE CASCADE,
	FOREIGN KEY (esameRIF) REFERENCES Esame(esameID) ON DELETE CASCADE,
	PRIMARY KEY(studenteRIF, esameRIF)		-- EVITA LA RIPETZIONE DELLA ISCRIZIONE AD UN ESAME DI UNA PERSONA
);

-- DML
-- INSERIMENTO
INSERT INTO Studente(nominativo, matricola) VALUES
('Giovanni', 'AB1234'),
('Valeria', 'AB1235'),
('Mario', 'AB1236'),
('Marika', 'AB1237');

INSERT INTO Esame(titolo, data_esame, crediti) VALUES
('Analisi I', '2020-01-01', 6),
('Analisi I', '2020-02-02', 6),
('Fisica I', '2020-01-01', 6),
('Fisica I', '2020-02-02', 6),
('Dati', '2020-01-01', 6);

INSERT INTO Studente_Esame(studenteRIF, esameRIF) VALUES
(1,2),
(1,5),
(2,2),
(2,4),
(2,5);

-- SELEZIONARE TUTTI GLI ESAMI DI GIOVANNI PACE
SELECT *
	FROM Studente
	JOIN Studente_Esame ON Studente.studenteID = Studente_Esame.studenteRIF
	JOIN Esame ON Studente_Esame.esameRIF = Esame.esameID
	WHERE matricola = 'AB1234';

-- SELEZIONARE TUTTI GLI STUDENTI ICRITTI AD ANALISI I E DATA 2020/02/02
SELECT *
	FROM Esame
	JOIN Studente_Esame ON Esame.esameID = Studente_Esame.esameRIF
	JOIN Studente ON Studente_Esame.studenteRIF = Studente.studenteID
	WHERE titolo = 'Analisi I' AND data_esame = '2020-02-02';
	
-- TUTTI GLI STUDENTI ISCRITTI AD UN ESAME E QUELLI NON
SELECT *
	FROM Studente
	LEFT JOIN Studente_Esame ON Studente.studenteID = Studente_Esame.studenteRIF
	LEFT JOIN Esame ON Studente_Esame.esameRIF = Esame.esameID;

-- TUTTI GLI ESAMI CHE HANNO ISCRITTI E NON
SELECT *
	FROM Studente
	RIGHT JOIN Studente_Esame ON Studente.studenteID = Studente_Esame.studenteRIF
	RIGHT JOIN Esame ON Studente_Esame.esameRIF = Esame.esameID;

-- TUTTI GLI STUDENTI ISCRITTI AGLI ESAMI E NON + TUTTI GLI ESAMI CON ISCRITTI E NON
SELECT *
	FROM Studente
	FULL JOIN Studente_Esame ON Studente.studenteID = Studente_Esame.studenteRIF
	FULL JOIN Esame ON Studente_Esame.esameRIF = Esame.esameID;

-- COME SOPRA MA MENO PERFORMANTE
SELECT *
FROM Studente
	LEFT JOIN Studente_Esame ON Studente.studenteID = Studente_Esame.studenteRIF
	LEFT JOIN Esame ON Studente_Esame.esameRIF = Esame.esameID
UNION
SELECT *
	FROM Studente
	RIGHT JOIN Studente_Esame ON Studente.studenteID = Studente_Esame.studenteRIF
	RIGHT JOIN Esame ON Studente_Esame.esameRIF = Esame.esameID;