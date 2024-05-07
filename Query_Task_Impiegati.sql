

CREATE TABLE Provincia(
	provId INT PRIMARY KEY IDENTITY(1,1),
	codice_prov VARCHAR(5) UNIQUE NOT NULL,
	nome_prov VARCHAR(50) NOT NULL
);

CREATE TABLE Citta(
	cittaId INT PRIMARY KEY IDENTITY(1,1),
	codice_citta VARCHAR(5) UNIQUE NOT NULL,
	nome_citta VARCHAR(50) NOT NULL,
	provRIF INT NOT NULL,
	FOREIGN KEY (provRIF) REFERENCES Provincia(provId)
);

CREATE TABLE Reparto(
	repartoId INT PRIMARY KEY IDENTITY(1,1),
	codice_rep VARCHAR(50) UNIQUE NOT NULL,
	nome_rep VARCHAR(50) NOT NULL
);

CREATE TABLE Impiegato(
	impiegatoId INT PRIMARY KEY IDENTITY(1,1),
	matricola VARCHAR(50) UNIQUE NOT NULL,
	nome_imp VARCHAR(50) NOT NULL,
	cognome VARCHAR(50) NOT NULL,
	data_nascita DATE NOT NULL,
	ruolo VARCHAR (50) NOT NULL,
	reparto VARCHAR(50) NOT NULL,
	indirizzo VARCHAR(50) NOT NULL,
	citta VARCHAR(50) NOT NULL,
	provincia VARCHAR(50) NOT NULL
);

INSERT INTO Provincia (codice_prov, nome_prov) VALUES
('PD', 'Padova'),
('RM', 'Roma'),
('MI', 'Milano'),
('NA', 'Napoli'),
('TO', 'Torino');

INSERT INTO Citta (codice_citta, nome_citta, provRIF) VALUES
('PD001', 'Padova', 1),
('RM001', 'Roma', 2),
('MI001', 'Milano', 3),
('NA001', 'Napoli', 4),
('TO001', 'Torino', 5);

INSERT INTO Reparto (codice_rep, nome_rep) VALUES
('HR', 'Risorse Umane'),
('IT', 'Tecnologia dell''Informazione'),
('SALES', 'Vendite'),
('FIN', 'Finanza'),
('OPS', 'Operazioni');

INSERT INTO Impiegato (matricola, nome_imp, cognome, data_nascita, ruolo, reparto, indirizzo, citta, provincia) VALUES
('EMP001', 'Mario', 'Rossi', '1980-05-15', 'Manager', 'HR', 'Via Roma 123', 'Roma', 'RM'),
('EMP002', 'Laura', 'Bianchi', '1985-08-20', 'Analista', 'IT', 'Via Milano 456', 'Milano', 'MI'),
('EMP003', 'Giovanni', 'Verdi', '1990-03-10', 'Venditore', 'SALES', 'Via Napoli 789', 'Napoli', 'NA'),
('EMP004', 'Elena', 'Russo', '1988-12-05', 'Contabile', 'FIN', 'Via Torino 101', 'Torino', 'TO'),
('EMP005', 'Luca', 'Ferrari', '1982-07-25', 'Operatore', 'OPS', 'Via Padova 246', 'Padova', 'PD');



