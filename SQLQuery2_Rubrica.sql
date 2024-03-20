-- Sono un commento 
/*
	Sono un 
	commento multilinea
*/

-- DDL
-- Si chiama query tab
CREATE TABLE Persona(
	nome VARCHAR(50) NOT NULL, 
	cognome VARCHAR(50) NOT NULL, 
	telefono VARCHAR(50),
	cod_fis CHAR(16) NOT NULL, -- UNIQUE
	UNIQUE(cod_fis)
);

-- Elimina la tabella
-- DROP TABLE Persona;

-- Aggiunta di una colonna
ALTER TABLE Persona ADD email VARCHAR(50) NOT NULL;

-- Rimozione di una colonna (devo specificare in questo caso il dato column)
ALTER TABLE Persona DROP COLUMN email;

-- Modifica di una colonna
ALTER TABLE Persona ALTER COLUMN email VARCHAR(100) NOT NULL;

SELECT * FROM Persona;

-- DML
INSERT INTO Persona(nome, cognome, telefono, cod_fis) VALUES
('Giovanni', 'Pace', '+39123456', 'PCAGNN'),
('Valeria', 'Verdi', '+39456789', 'VLRVRD');

-- QL
SELECT * FROM Persona;
