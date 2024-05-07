DROP TABLE IF EXISTS Evento;
 
CREATE TABLE Evento(
	eventoId INT PRIMARY KEY IDENTITY(1, 1),
	nome VARCHAR(250) NOT NULL,
	descrizione VARCHAR(250),
	dataEvento DATETIME NOT NULL,
	luogo VARCHAR(250) NOT NULL,
	capMax INT CHECK (capMax >= 0) NOT NULL
);
 
DROP TABLE IF EXISTS Partecipante;
 
CREATE TABLE Partecipante(
	partecipanteId INT PRIMARY KEY IDENTITY(1, 1),
	nome VARCHAR(250) NOT NULL,
	telefono VARCHAR(10) NOT NULL UNIQUE, 
);
 
DROP TABLE IF EXISTS Compone;
 
CREATE TABLE Evento_Partecipante(
	eventoRif INT NOT NULL,
	partecipanteRif INT NOT NULL
	FOREIGN KEY (eventoRif) REFERENCES Evento (eventoId) ON DELETE CASCADE,
	FOREIGN KEY (partecipanteRif) REFERENCES Partecipante (partecipanteId) ON DELETE CASCADE,
	PRIMARY KEY (eventoRif, partecipanteRif)
);
 
DROP TABLE IF EXISTS Risorsa;
 
CREATE TABLE Risorsa(
	risorsaId INT PRIMARY KEY IDENTITY(1, 1),
	tipo VARCHAR(250) NOT NULL CHECK (tipo IN ('attrezzatura', 'cibo', 'bevande')), 
	quantita INT CHECK (quantita >= 0) NOT NULL,
	costo INT NOT NULL,
	fornitore VARCHAR(250),
	eventoRif INT NOT NULL,
	FOREIGN KEY (eventoRif) REFERENCES Evento (eventoId) ON DELETE CASCADE
);
 
INSERT INTO Evento (nome, descrizione, dataEvento, luogo, capMax) VALUES

('Festa del Grazie', 'Abbiamo rubato la festa del ringraziamento', '22-03-2024 21:30:00', 'Roma', 55),

('Festa per il 111esimo compleanno di Bilbo', 'Sarà una festa indimenticabile', '21-09-2023 19:00:00', 'Hobbiville', 100);
 
INSERT INTO Partecipante (nome, telefono) VALUES

('Davide', '+39558874'),

('Mario', '+39661138');
 
INSERT INTO Risorsa (tipo, quantita, costo, fornitore, eventoRif) VALUES

('cibo', 1, 13, 'Dolci Preziosi', 1),

('attrezzatura', 1, 89, 'Scale solide', 2);
 
 
SELECT * FROM Evento;

SELECT * FROM Partecipante;

SELECT * FROM Risorsa;