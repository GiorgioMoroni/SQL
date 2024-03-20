
CREATE TABLE Reparto(
	repartoID INT PRIMARY KEY IDENTITY(1,1),
	nome VARCHAR(250) NOT NULL UNIQUE,
	num_letti INT NOT NULL CHECK(num_letti>0)
);

INSERT INTO Reparto(nome, num_letti) VALUES
('Cardiologia', 250),
('Gastroenterologia', 250),
('Neurologia', 250);

CREATE TABLE Paziente(
	pazienteID INT PRIMARY KEY IDENTITY(1,1),
	nominativo VARCHAR(50) NOT NULL,
	cod_fis CHAR(16) NOT NULL UNIQUE,	
	telefono VARCHAR(250) NOT NULL,
	email VARCHAR(100) NOT NULL,
);

INSERT INTO Paziente(nominativo, cod_fis, telefono, email) VALUES
('Giovanni Pace', 'PCAGNN', '+39123', 'gio@pace.com'),
('Valeria Verdi', 'VLRVRD', '+39456', 'val@verdi.com'),
('Mario Rossi', 'MRRRSS', '+39789', 'mar@rossi.com');

CREATE TABLE Esame(
	esameID INT PRIMARY KEY IDENTITY(1,1),
	tipo VARCHAR(50) NOT NULL CHECK(tipo IN('urine', 'sangue', 'midollo')),
	data_esame DATETIME DEFAULT CURRENT_TIMESTAMP,
	esito TEXT,
	pazienteRIF INT NOT NULL,
	FOREIGN KEY (pazienteRIF) REFERENCES Paziente(pazienteID) ON DELETE CASCADE
);

INSERT INTO Esame(tipo, esito, pazienteRIF) VALUES
('urine', 'Stappooooooo', 1),
('urine', 'Stappooooooo', 2),
('urine', 'Stappooooooo', 3),
('urine', 'Tutto ok', 1);


CREATE TABLE Medico(
	medicoID INT PRIMARY KEY IDENTITY(1,1),
	nominativo VARCHAR(50) NOT NULL,
	cod_identificativo CHAR(10) NOT NULL UNIQUE,	
	isPrimario TINYINT NOT NULL CHECK(isPrimario IN (0,1)) DEFAULT 0,
	repartoRIF INT NOT NULL,
	FOREIGN KEY (repartoRIF) REFERENCES Reparto(repartoID) -- SONO OBBLIGATO A TOGLIERE PRIMA I MEDICI E POI TOGLIERE IL REPARTO
);

INSERT INTO Medico(cod_identificativo, nominativo, isPrimario, repartoRIF) VALUES
('AA1234', 'Marina Massironi', 1, 1),
('AA1235', 'Billi Ballo', 0, 1),
('AA1236', 'Herbert Ballerina', 0, 1),
('AA1237', 'Puffo', 1, 2),
('AA1238', 'Micio Micio', 0,2);


CREATE TABLE Ricovero(
	ricoveroID INT PRIMARY KEY IDENTITY (1,1),
	data_ingresso DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	data_uscita DATETIME,
	lettino VARCHAR(50) NOT NULL DEFAULT 'N.D',
	pazienteRIF INT NOT NULL,
	repartoRIF INT NOT NULL,
	FOREIGN KEY (pazienteRIF) REFERENCES Paziente(pazienteID) ON DELETE CASCADE,
	FOREIGN KEY (repartoRIF) REFERENCES Reparto(repartoID) ON DELETE CASCADE
);

ALTER TABLE Ricovero ADD CONSTRAINT CHK_data_uscita CHECK(data_uscita >= data_ingresso);
-- DEVO MODIFICARE LA TABBELLA AGGIUNGENDO IL CONSTRAINT SUCCESSIVAMENTE ALTRIMENTI NON CREA LA TABELLA

INSERT INTO Ricovero(data_uscita, lettino, pazienteRIF, repartoRIF) VALUES
(null, '3F', 1, 1),
('2024-05-05', '5T', 2, 2),
('2024-05-06', '5F', 3, 2);

CREATE TABLE Visita(
	visitaID INT PRIMARY KEY IDENTITY(1,1),
	data_visita DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	note TEXT,
	medicoRIF INT NOT NULL,
	ricoveroRIF INT NOT NULL,
	FOREIGN KEY (medicoRIF) REFERENCES Medico(medicoID) ON DELETE CASCADE,
	FOREIGN KEY (ricoveroRIF) REFERENCES Ricovero(ricoveroID) ON DELETE CASCADE
);

INSERT INTO Visita(note, medicoRIF, ricoveroRIF) VALUES
('Tutto bene!', 1, 1);

SELECT * FROM Reparto; 
SELECT * FROM Paziente; 
SELECT * FROM Esame; 
SELECT * FROM Medico; 
SELECT * FROM Ricovero; 
SELECT * FROM Visita;

SELECT Paziente.nominativo AS 'Nome Paziente', nome AS 'Nome Reparto', Medico.nominativo AS 'Nome Medico'
	FROM Paziente 
	JOIN Ricovero ON Paziente.pazienteID = Ricovero.pazienteRIF
	JOIN Reparto ON Ricovero.ricoveroID = Reparto.repartoID
	JOIN Medico ON Reparto.repartoID = Medico.repartoRIF
	WHERE cod_fis = 'VLRVRD';

