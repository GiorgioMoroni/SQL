-- DDL 
DROP TABLE IF EXISTS Carta;
DROP TABLE IF EXISTS Persona;

CREATE TABLE Persona(
	personaID INT PRIMARY KEY IDENTITY(1,1),
	nome VARCHAR(250) NOT NULL,
	cognome VARCHAR(250) NOT NULL,
	email VARCHAR(250) NOT NULL UNIQUE
);

CREATE TABLE Carta(
	cartaID INT PRIMARY KEY IDENTITY(1,1),
	codice VARCHAR(10) NOT NULL UNIQUE,
	scadenza VARCHAR(50) NOT NULL,
	personaRIF INT NOT NULL UNIQUE,
	FOREIGN KEY (personaRIF) REFERENCES Persona(personaID) ON DELETE CASCADE		-- CASCADE/SET NULL
);

-- DML
-- INSERIMENTO
INSERT INTO Persona(nome, cognome, email) VALUES
('Giovanni', 'Pace', 'gio@pace.com'),
('Valeria', 'Verdi', 'val@verdi.com'),
('Mario', 'Rossi', 'mar@rossi'),
('Marika', 'Mariko', 'mar@mariko.com');

INSERT INTO Carta(codice, scadenza, personaRIF) VALUES
('AB123', '2020-01-01', 1),
('AB124', '2020-01-01', 2),
('AB125', '2020-01-01', 3);

-- Voglio consultare la carta di identità di Valeria
SELECT *
	FROM Persona
	JOIN Carta ON Persona.personaID = Carta.personaRIF
	WHERE nome = 'Valeria';

-- Voglio sapere chi ha la carta numero AB125
SELECT *
	FROM Carta
	JOIN Persona ON Persona.personaID = Carta.personaRIF
	WHERE codice = 'AB125';

-- Voglio effetturare un JOIN che mi mostri tutti, anche chi non ha la carta
SELECT *
	FROM Carta 
	RIGHT JOIN Persona ON Carta.personaRIF = Persona.personaID;