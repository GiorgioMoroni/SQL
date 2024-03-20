-- DDL
DROP TABLE IF EXISTS Prodotto;

CREATE TABLE Prodotto(
	prodottoID INT IDENTITY(1,1),
	nome VARCHAR(150) NOT NULL,
	descrizione TEXT,
	categoria VARCHAR(50) DEFAULT 'Non definito',
	codice VARCHAR(10) NOT NULL,
	prezzo DECIMAL(5,2),
	data_scadenza DATE,											-- 'YYYY-MM-DD'
	data_inserimento DATETIME DEFAULT CURRENT_TIMESTAMP			-- 'YYYY-MM-DD hh:mm:ss'
	PRIMARY KEY(prodottoID),
	UNIQUE(codice),
	CONSTRAINT CHK_prezzo CHECK(prezzo >=0),
	CONSTRAINT CHK_scadenza CHECK(data_scadenza BETWEEN '1970-01-01' AND '2100-01-01')

);

-- RIMOZIONE ED INSERIMENTO CONSTRAINT
ALTER TABLE Prodotto DROP CONSTRAINT CHK_scadenza;
ALTER TABLE Prodotto ADD CONSTRAINT CHK_scadenza CHECK(data_scadenza BETWEEN '1970-01-01' AND '2100-01-01');
ALTER TABLE Prodotto ADD CONSTRAINT CHK_categoria CHECK(categoria IN ('alimento', 'illuminazione', 'mobilio'));

--DML
INSERT INTO Prodotto (nome, descrizione, codice, prezzo, data_scadenza) VALUES
('Biscotti', 'Molto buoni', 'BIS123', 12.5, '2050-01-01');
INSERT INTO Prodotto (nome, descrizione, codice, prezzo, data_scadenza, categoria) VALUES
('Nutella', 'Calooooorica', 'NUT123', 5.5, '2028-01-01', 'alimento'),
('Lampada', 'Luminosa', 'LUM123', 75.5, '2028-01-01', 'illuminazione'),
('Divano', 'Comoda', 'DIV123', 895.5, '2028-01-01', 'mobilio');

SELECT * FROM Prodotto;


