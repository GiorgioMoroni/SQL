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

CREATE TABLE Iscrizione(
	studenteRIF INT NOT NULL,
	esameRIF INT NOT NULL,
	data_iscr DATETIME DEFAULT CURRENT_TIMESTAMP,
	note TEXT,
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

INSERT INTO Iscrizione(studenteRIF, esameRIF) VALUES
(1,2),
(1,5),
(2,2),
(2,4),
(2,5);

SELECT *
	FROM Studente
	JOIN Iscrizione ON Studente.studenteID = Iscrizione.studenteRIF
	JOIN Esame ON Iscrizione.esameRIF = Esame.esameID;