CREATE TABLE Studente(
	studenteId INT PRIMARY KEY IDENTITY(1,1),
	nominativo VARCHAR(250) NOT NULL,
	matricola VARCHAR(10) NOT NULL
);

CREATE TABLE Docente(
	docenteId INT PRIMARY KEY IDENTITY (1,1),
	nominativo VARCHAR(250) NOT NULL,
	dipartimento VARCHAR(250) NOT NULL
);

SELECT * FROM Studente;