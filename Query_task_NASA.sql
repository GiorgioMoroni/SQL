USE acc_lez34_task_Nasa;

DROP TABLE IF EXISTS SistemaOggetto;
DROP TABLE IF EXISTS Sistema;
DROP TABLE IF EXISTS OggettoCeleste;

CREATE TABLE Sistema(
	sistemaId INT PRIMARY KEY IDENTITY (1,1),
	nomeSistema VARCHAR(250) NOT NULL,
	codiceSistema VARCHAR(250) NOT NULL UNIQUE,
	tipo VARCHAR(250) NOT NULL

);

CREATE TABLE OggettoCeleste(
	oggettoId INT PRIMARY KEY IDENTITY (1,1),
	nome VARCHAR(250) NOT NULL,
	codice VARCHAR(250) NOT NULL UNIQUE,
	scoperta DATE NOT NULL,
	scopritore VARCHAR(250) DEFAULT 'Sconosciuto',
	tipologia VARCHAR(250) NOT NULL,
	distanza DECIMAL(30,2) NOT NULL,
	raggio DECIMAL (10,2),
	angoloAzimutale DECIMAL (10,2)
);

CREATE TABLE SistemaOggetto (
    sistemaRIF INT,
    oggettoRIF INT,
    FOREIGN KEY (sistemaRIF) REFERENCES Sistema(sistemaId),
    FOREIGN KEY (oggettoRIF) REFERENCES OggettoCeleste(oggettoId),
    PRIMARY KEY (sistemaRIF, oggettoRIF)
);

INSERT INTO Sistema (nomeSistema, codiceSistema, tipo) VALUES
('Via Lattea', 'G1', 'Galassia'),
('Andromeda', 'G2', 'Galassia'), 
('Sistema Solare', 'S1', 'Sistema Planetario'),
('Gemelli', 'C1', 'Costellazione'),
('Scorpione', 'C2', 'Costellazione');



INSERT INTO OggettoCeleste (nome, codice, scoperta, scopritore, tipologia, distanza, raggio, angoloAzimutale) VALUES
('Sole', 'SO01', '1610-01-10', DEFAULT, 'Stella', 149.6, 6.95, 90.00),
('Terra', 'TE01', '1543-07-15', DEFAULT, 'Pianeta', 0, 0, 0),
('Marte', 'MA01', '1781-04-26', 'Andrea Anselmi', 'Pianeta', 1.52, 2.80, 200.00),
('Giove', 'GI01', '1817-12-24', 'Giovanni Pace', 'Pianeta', 5.20, 4.00, 45.00),
('Saturno', 'SA01', '1815-12-24', 'Giorgio Moroni', 'Pianeta', 9.58, 3.50, 120.00),
('Urano', 'UR01', '1817-06-24', 'Mario Rossi', 'Pianeta', 30.07, 6.20, 270.00),
('Antares', 'AN01', '1900-01-01', 'Valeria Verdi', 'Stella', 550, 45, 220.30),
('Polluce', 'PO01', '1900-01-01', 'Marika Mariko', 'Stella', 33.78, 35, 320.00),
('M32', 'AB12', '1743-12-01', 'Guillaume Le Gentil', 'Satellite', 2.90, 70, 250.00);

INSERT INTO SistemaOggetto (sistemaRIF, oggettoRIF) VALUES
(1,1),
(1,2),
(1,3),
(3,4),
(3,5),
(2,6),
(5,7),
(4,8),
(2,9);

SELECT * FROM Sistema;
SELECT * FROM OggettoCeleste;
SELECT * FROM SistemaOggetto;