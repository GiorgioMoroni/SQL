USE acc_lez28_esercitazione_eventi;
DROP TABLE IF EXISTS Partecipante;
DROP TABLE IF EXISTS Partecipante_Evento;
CREATE TABLE Partecipante(
	idPartecipante INT PRIMARY KEY IDENTITY (1,1),
	nomePar VARCHAR(250) NOT NULL,
	cognome VARCHAR(250),
	telefono VARCHAR(16) NOT NULL UNIQUE,
	email VARCHAR(50)
);

CREATE TABLE Evento(
	idEvento INT PRIMARY KEY IDENTITY(1,1),
	nomeEvento VARCHAR(250) NOT NULL,
	descrizione VARCHAR(250) NOT NULL,
	dataEvento DATETIME NOT NULL,
	luogo VARCHAR(250) NOT NULL,
	capacitaMax INT NOT NULL
);

CREATE TABLE Partecipante_Evento(
	partecipanteRIF INT NOT NULL,
	eventoRIF INT NOT NULL,
	FOREIGN KEY (partecipanteRIF) REFERENCES Partecipante(idPartecipante) ON DELETE CASCADE,
	FOREIGN KEY (eventoRIF) REFERENCES Evento(idEvento) ON DELETE CASCADE,
	PRIMARY KEY (eventoRIF, partecipanteRIF)
);

CREATE TABLE Risorse(
	idRisorsa INT PRIMARY KEY IDENTITY(1,1),
	tipologia VARCHAR(50) NOT NULL CHECK(tipologia IN('cibo', 'bevanda', 'attrezzatura')),
	quantita INT NOT NULL DEFAULT 0 CHECK(quantita >= 0),
	costo DECIMAL(10,2) NOT NULL,
	fornitore VARCHAR(250) NOT NULL,
	codice VARCHAR(10) NOT NULL UNIQUE
);

INSERT INTO Partecipante_Evento(partecipanteRIF, eventoRIF) VALUES
(1,1),
(2,1),
(3,1),
(3,2),
(4,1),
(4,2),
(5,1),
(6,2);

SELECT * FROM Partecipante;
SELECT * FROM Evento;
SELECT * FROM Partecipante_Evento;
SELECT * FROM Risorse;