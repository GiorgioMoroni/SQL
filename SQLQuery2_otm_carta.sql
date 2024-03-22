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
	negozio VARCHAR(50) NOT NULL,
	personaRIF INT NOT NULL,
	FOREIGN KEY (personaRIF) REFERENCES Persona(personaID) ON DELETE CASCADE		-- CASCADE/SET NULL
);

-- DML
-- INSERIMENTO
INSERT INTO Persona(nome, cognome, email) VALUES
('Giovanni', 'Pace', 'gio@pace.com'),
('Valeria', 'Verdi', 'val@verdi.com'),
('Mario', 'Rossi', 'mar@rossi'),
('Marika', 'Mariko', 'mar@mariko.com');


INSERT INTO Carta(codice, negozio, personaRIF) VALUES
('AB123', 'Coop', 1),
('AB124', 'Coop', 2),
('AB125', 'Coop', 3),
('CC123', 'Conad', 3),
('CC124', 'Conad', 1),
('CC125', 'Conad', 2),
('TT123', 'Tigotà', 1);

-- DELETE FROM Persona WHERE personaID = 1;		-- Permessa grazie a ON DELETE CASCADE

SELECT * FROM Carta;
SELECT * FROM Persona;

-- Cerco tutte le carte di Giovanni Pace
SELECT * FROM
	Persona JOIN Carta ON Persona.personaID = Carta.personaRIF 
	WHERE personaID = 1;

-- Cerco tutte le carte di Giovanni Pace specificando le colonne di dati che voglio visualizzare
SELECT nome, cognome, email, codice, negozio
	FROM Persona JOIN Carta ON Persona.personaID = Carta.personaRIF 
	WHERE personaID = 1;

-- Voglio sapere a chi appartiene la CC125
SELECT *
	FROM Carta
	JOIN Persona On Carta.personaRIF = Persona.personaID
	WHERE codice = 'CC125';

-- INNER JOIN
SELECT *
	FROM Persona
	INNER JOIN Carta ON Persona.personaID = Carta.personaRIF;

-- LEFT JOIN
SELECT *
	FROM Persona
	LEFT JOIN Carta ON Persona.personaID = Carta.personaRIF;

-- RIGHT JOIN = INNER JOIN

SELECT * FROM Persona;



