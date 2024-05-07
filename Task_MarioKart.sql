USE acc_lez36_task_MarioKart;

DROP TABLE IF EXISTS Torneo;
DROP TABLE IF EXISTS Squadra;
DROP TABLE IF EXISTS Personaggio;

CREATE TABLE Personaggio(
	idPersonaggio INT PRIMARY KEY IDENTITY (1,1) NOT NULL,
	nome VARCHAR(50) NOT NULL,
	categoria VARCHAR(50) NOT NULL,
	costo INT CHECK(costo > 0 AND costo <= 4) NOT NULL
);

CREATE TABLE Squadra(
	idSquadra INT PRIMARY KEY IDENTITY (1,1) NOT NULL,
	nome VARCHAR(250) NOT NULL,
	budget INT DEFAULT 10,
	persUnoRIF INT,
    persDueRIF INT,
    persTreRIF INT,
    FOREIGN KEY (persUnoRIF) REFERENCES Personaggio(idPersonaggio),
    FOREIGN KEY (persDueRIF) REFERENCES Personaggio(idPersonaggio),
    FOREIGN KEY (persTreRIF) REFERENCES Personaggio(idPersonaggio)
);

CREATE TABLE Torneo(
	idTorneo INT PRIMARY KEY IDENTITY (1,1) NOT NULL,
	nomeTorneo VARCHAR(250) NOT NULL,
	squadraUnoRIF INT,
    squadraDueRIF INT,
    squadraTreRIF INT,
    FOREIGN KEY (squadraUnoRIF) REFERENCES Squadra(idSquadra),
    FOREIGN KEY (squadraDueRIF) REFERENCES Squadra(idSquadra),
    FOREIGN KEY (squadraTreRIF) REFERENCES Squadra(idSquadra)
);


CREATE TRIGGER verifica_costo
ON Squadra
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @costo_totale INT;
    SELECT @costo_totale = (SELECT costo FROM Personaggio WHERE idPersonaggio = inserted.persUnoRIF) +
                           (SELECT costo FROM Personaggio WHERE idPersonaggio = inserted.persDueRIF) +
                           (SELECT costo FROM Personaggio WHERE idPersonaggio = inserted.PersTreRIF)
    FROM inserted;

    IF @costo_totale > 10
    BEGIN
        RAISERROR ('Il costo totale dei personaggi supera il budget massimo di 10 crediti.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;

INSERT INTO Personaggio(nome, categoria, costo) VALUES
('Mario', '50cc', 4),
('Luigi', '100cc', 4),
('Toad', '150cc', 4),
('Yoshi','50cc', 4),
('Wario', '100cc', 3),
('Warluigi', '150cc', 3),
('Peach', '50cc', 3), 
('Daisy', '100cc', 3),
('Bowser', '150cc', 2), 
('Koopa Troopa', '50cc', 2), 
('Donkey Kong', '100cc', 2),
('Rosalina', '150cc', 2);

INSERT INTO Squadra(nome, persUnoRIF, persDueRIF, persTreRIF) VALUES
('Squadra Giorgio', 1, 2, 3);
--('Squadra Davide', 'Peach', 'Wario', 'Warluigi'),
--('Squadra Johel', 'Yoshi', 'Toad', 'Victoria');