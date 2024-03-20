-- CREAZIONE TABELLE
CREATE TABLE Museo(
	museoID INT PRIMARY KEY IDENTITY(1,1),
	nome VARCHAR(250) NOT NULL,
	indirizzo VARCHAR(250) NOT NULL,
	citta VARCHAR(250) NOT NULL,
	direttore VARCHAR(250) NOT NULL
);

CREATE TABLE Artista(
	artistaID INT PRIMARY KEY IDENTITY(1,1),
	nome VARCHAR(250) NOT NULL,
	nazionalita VARCHAR(250) NOT NULL,
	data_nascita DATE NOT NULL,
	data_morte DATE
);

CREATE TABLE Dipinto(
	dipintoID INT PRIMARY KEY IDENTITY(1,1),
	titolo VARCHAR(50) NOT NULL,
	anno_creazione VARCHAR(250) NOT NULL,
	codice VARCHAR(250) NOT NULL UNIQUE,
	tipo_pittura VARCHAR(250) NOT NULL,
	dimensione VARCHAR(250) NOT NULL,
	museoRIF INT,
	FOREIGN KEY (museoRIF) REFERENCES Museo(museoID) ON DELETE SET NULL
);

CREATE TABLE Artista_Dipinto(
	artistaRIF INT NOT NULL,
	dipintoRIF INT NOT NULL,
	FOREIGN KEY (artistaRIF) REFERENCES Artista(artistaID) ON DELETE CASCADE,
	FOREIGN KEY (dipintoRIF) REFERENCES Dipinto(dipintoID) ON DELETE CASCADE,
	PRIMARY KEY (artistaRIF, dipintoRIF)
);

--CREATE TABLE Scultura(
--	sculturaID INT PRIMARY KEY IDENTITY(1,1),
--	titolo VARCHAR(50) NOT NULL,
--	anno_creazione VARCHAR(250) NOT NULL,
--	codice VARCHAR(250) NOT NULL UNIQUE,
--	materiale VARCHAR(250) NOT NULL,
--	altezza VARCHAR(250) NOT NULL,
--	peso VARCHAR(250) NOT NULL,
--	FOREIGN KEY (sculturaRIF) REFERENCES Museo(museoID) ON DELETE SET NULL
--);

--CREATE TABLE Scultura_Artista(
--	artistaRIF INT NOT NULL,
--	sculturaRIF INT NOT NULL,
--	FOREIGN KEY (artistaRIF) REFERENCES Artista(artistaID) ON DELETE CASCADE,
--	FOREIGN KEY (sculturaRIF) REFERENCES Dipinto(dipintoID) ON DELETE CASCADE,
--	PRIMARY KEY (artistaRIF, sculturaRIF)
--);

CREATE TABLE Personaggio(
	personaggioID INT PRIMARY KEY IDENTITY(1,1),
	nome VARCHAR(250) NOT NULL
);

CREATE TABLE Personaggio_Dipinto(
	personaggioRIF INT NOT NULL,
	dipintoRIF INT NOT NULL,
	FOREIGN KEY (personaggioRIF) REFERENCES Artista(artistaID) ON DELETE CASCADE,
	FOREIGN KEY (dipintoRIF) REFERENCES Dipinto(dipintoID) ON DELETE CASCADE,
	PRIMARY KEY (personaggioRIF, dipintoRIF)
);

--CREATE TABLE Personaggio_Scultura(
--	personaggioRIF INT NOT NULL,
--	sculturaRIF INT NOT NULL,
--	FOREIGN KEY (personaggioRIF) REFERENCES Artista(artistaID) ON DELETE CASCADE,
--	FOREIGN KEY (sculturaRIF) REFERENCES Scultura(sculturaID) ON DELETE CASCADE,
--	PRIMARY KEY (personaggioRIF, sculturaRIF)
--);














