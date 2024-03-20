-- DDL
CREATE TABLE Contatto(
	contattoID INT PRIMARY KEY IDENTITY(1,1),
	nome VARCHAR(50) NOT NULL,
	cognome VARCHAR(50) NOT NULL,
	email VARCHAR(100) NOT NULL,
	cod_fis CHAR(16) NOT NULL UNIQUE
);

-- DML
-- INSERIMENTO
INSERT INTO Contatto(nome, cognome, email, cod_fis) VALUES
('Giovanni', 'Pace', 'gio@pace.com', 'PCAGNN'),
('Valeria', 'Verdi', 'val@verdi.com', 'VLRVRD'),
('Mario', 'Rossi', 'mar@rossi.com', 'MRRRSS');

DELETE FROM Contatto WHERE contattoID = 3;

INSERT INTO Contatto(nome, cognome, email, cod_fis) VALUES
('Marika', 'Mariko', 'mar@mariko.com', 'MARMAR');

SELECT * FROM Contatto;