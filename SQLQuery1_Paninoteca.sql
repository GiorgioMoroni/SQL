DROP TABLE IF EXISTS Panino;
CREATE TABLE Panino(
	idPanino INT PRIMARY KEY IDENTITY (1,1),
	Nome VARCHAR(250) NOT NULL,
	Descrizione VARCHAR(250),
	Prezzo DECIMAL(10,2) NOT NULL,
	Vegan BIT DEFAULT 0
);

INSERT INTO Panino(Nome, Descrizione, Prezzo, Vegan) VALUES
('Cheesburger', 'Panino con cheddar', 10.9, 0),
('Vegan', 'Panino con soia', 12.9, 1),
('Dakota', 'Panino OWW', 9.9, 0),
('Tofu', 'Panino al tofu', 7.9, 1);

SELECT * FROM Panino;