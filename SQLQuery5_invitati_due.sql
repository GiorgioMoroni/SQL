-- DDL
DROP TABLE IF EXISTS Contatto;

CREATE TABLE Contatto(
	contattoID INT PRIMARY KEY IDENTITY(1,1),
	nome VARCHAR(50) NOT NULL,
	cognome VARCHAR(50) NOT NULL,
	email VARCHAR(100) NOT NULL,
	cod_fis CHAR(16) NOT NULL UNIQUE
);

-- DML
-- INSERIMENTO
-- TRANSAZIONE: NEL PRIMO CASO LUI ESEGUE COME UN' UNICA ISTRUZIONE E QUINDI SI BLOCCA NON INSERENDO NESSUN DATO. PIU' VELOCITA' PIU' MEMORIA UTILIZZATA
--INSERT INTO Contatto(nome, cognome, email, cod_fis) VALUES
--('Giovanni', 'Pace', 'gio@pace.com', 'PCAGNN'),
--('Valeria', 'Verdi', 'val@verdi.com', 'VLRVRD'),
--('Mario', 'Rossi', 'mar@rossi.com', 'PCAGNN'),
--('Marika', 'Mariko', 'mar@mariko.com', 'MARMAR');

-- IN QUESTO CASO INVECE LUI ESEGUE 4 OPERAZIONI DIVERSE, NON INSERENDO NELLA TABELLA SOLO MARIO ROSSI. MENO VELOCITA' MENO MEMORIA UTILIZZATA
INSERT INTO Contatto(nome, cognome, email, cod_fis) VALUES
('Giovanni', 'Pace', 'gio@pace.com', 'PCAGNN');
INSERT INTO Contatto(nome, cognome, email, cod_fis) VALUES
('Valeria', 'Verdi', 'val@verdi.com', 'VLRVRD');
INSERT INTO Contatto(nome, cognome, email, cod_fis) VALUES
('Mario', 'Rossi', 'mar@rossi.com', 'MRRRSS');
INSERT INTO Contatto(nome, cognome, email, cod_fis) VALUES
('Marika', 'Mariko', 'mar@mariko.com', 'MARMAR');
INSERT INTO Contatto(nome, cognome, email, cod_fis) VALUES
('Mario', 'Mariottide', 'mar@td.com', 'MRRMTD');
INSERT INTO Contatto(nome, cognome, email, cod_fis) VALUES
('Maria', 'Mariani', 'mar@mariani.com', 'MRRMRN');
INSERT INTO Contatto(nome, cognome, email, cod_fis) VALUES
('Mariolino', 'Mariottide', 'mariolino@td.com', 'MARINOMTD');

SELECT * FROM Contatto;

-- SELEZIONA SOLO LE COLONNE SCELTE
SELECT nome, cognome, email FROM Contatto;

-- ALIAS
SELECT nome AS 'First Name', cognome AS 'Last Name', email AS Email FROM Contatto;

-- RICERCA
SELECT * FROM Contatto WHERE nome = 'Mario';
SELECT * FROM Contatto WHERE nome = 'Mario' AND cognome = 'Rossi';
SELECT * FROM Contatto WHERE nome = 'Mario' OR nome = 'Giovanni' OR nome = 'Marika';
SELECT * FROM Contatto WHERE nome IN ('Mario', 'Giovanni', 'Marika');		-- UGUALE A SOPRA, SHORT END PER EVITARE ESANSIONE ORIZZONTALE
SELECT * FROM Contatto WHERE nome <> 'Mario';		-- CARATTERE PER DIVERSO (PRENDERA' TUTTE LE RIGHE DOVE IL NOME E' DIVERSA DA MARIO)

-- LIKE
-- TUTTO CIO' CHE INIZIA PER MA...
SELECT * FROM COntatto WHERE nome LIKE 'Ma%';

-- TUTTO CIO' CHE FINISCE PER ...IO
SELECT * FROM Contatto WHERE nome LIKE '%io';

-- TUTTO CIO' CHE CONTIENE ALMENO UNA VOLTA ...IO...
SELECT * FROM Contatto WHERE nome LIKE '%io%';

-- RICERCA PUNTUALE (UNA SOLA LETTERA PER UNDERSCORE)
SELECT * FROM Contatto WHERE nome LIKE 'Mari_';
SELECT * FROM Contatto WHERE nome LIKE '_a_i_____';

/*
	Creare una tabella di libri caratterizzata da Titolo, autore, ed il codice ISBN.
	- Inserire almeno 6 libri
	- Ricercare tutti i libri di un autore
	- Ricercare tutti i libri che hanno la sequenza "an" al loro interno
	- Ricerca per ISBN
*/