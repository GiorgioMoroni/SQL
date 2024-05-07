CREATE TABLE Utente (
	utenteID INT PRIMARY KEY IDENTITY (1,1),
	nomeUtente VARCHAR (50) NOT NULL,
	password VARCHAR (32) NOT NULL
);
 
CREATE TABLE Stanza (
	stanzaID INT PRIMARY KEY IDENTITY (1,1),
	nome VARCHAR (50) NOT NULL
);
 
 
CREATE TABLE Messaggi (
	messaggioID INT PRIMARY KEY IDENTITY(1,1),
	testoMessaggio TEXT NOT NULL,
	utenteRIF INT,
	stanzaRIF INT,
	FOREIGN KEY (utenteRIF) REFERENCES Utente(utenteID),
	FOREIGN KEY (stanzaRIF) REFERENCES Stanza (stanzaID),
	Timestamp DATETIME NOT NULL DEFAULT GETDATE () --timestamp occorre per sapere in che data e ora è stato registrato il messaggio
);