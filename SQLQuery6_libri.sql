/*
	Creare una tabella di libri caratterizzata da Titolo, autore, ed il codice ISBN.
	- Inserire almeno 6 libri
	- Ricercare tutti i libri di un autore
	- Ricercare tutti i libri che hanno la sequenza "ci" al loro interno
	- Ricerca per ISBN
*/

DROP TABLE IF EXISTS Libro;

CREATE TABLE Libro(
	codiceID INT PRIMARY KEY IDENTITY(1,1),
	titolo VARCHAR(50),
	autore VARCHAR(50),
	isbn CHAR(10) NOT NULL UNIQUE
);


INSERT INTO Libro(titolo, autore, isbn) VALUES
('Il signore degli anelli', 'Tolkien', '123_123'),
('Il codice da vinci', 'Dan Brown', '456_123'),
('l''odissea', 'Omero', '789_123'),
('L''era glaciale', 'Bho', '123_456'),
('Angeli e demoni', 'Dan Brown', '456_456'),
('Le due torri', 'Tolkien', '789_456');

SELECT * FROM Libro;

SELECT * FROM Libro WHERE autore = 'Dan Brown';
SELECT * FROM Libro WHERE autore LIKE '%ki%';
SELECT * FROM libro WHERE isbn = '123_456';


