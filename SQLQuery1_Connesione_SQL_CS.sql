USE acc_lez24_citta;
CREATE TABLE Citta(
	cittaID INT PRIMARY KEY IDENTITY (1,1),
	nome VARCHAR(250) NOT NULL,
	prov VARCHAR(3)
);

ALTER TABLE Citta ADD CONSTRAINT CHK_Nome UNIQUE(nome);

INSERT INTO Citta(nome, prov) VALUES
('Pescara', 'PE'),
('L''aquila', 'AQ');

CREATE TABLE Utenti(
	userId INT PRIMARY KEY IDENTITY(1,1),
	usern VARCHAR(250) NOT NULL,
	passw VARCHAR(250) NOT NULL
);

INSERT INTO Utenti(usern, passw) VALUES
('ciccio', 'pasticcio'),
('bo', 'passwordo'),
('ceppa', 'blu');

CREATE PROCEDURE CheckUserPass
	@userValue VARCHAR(250),
	@passValue VARCHAR(250)
AS
BEGIN
	SELECT * FROM Utenti WHERE usern = @userValue AND passw = @passValue
END;

SELECT * FROM Citta;