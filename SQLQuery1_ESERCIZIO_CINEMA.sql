USE acc_lez23_Esercizio_Cinema;
DROP TABLE IF EXISTS Ticket;
DROP TABLE IF EXISTS Theater;
DROP TABLE IF EXISTS Showtime;
DROP TABLE IF EXISTS Review;
DROP TABLE IF EXISTS Movie;
DROP TABLE IF EXISTS IncassiTotali;
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Cinema;

CREATE TABLE Cinema (
	CinemaID INT PRIMARY KEY,
	Name VARCHAR(100) NOT NULL,
	Address VARCHAR(255) NOT NULL,
	Phone VARCHAR(20)
);

CREATE TABLE Theater (
	TheaterID INT PRIMARY KEY,
	CinemaID INT,
	Name VARCHAR(50) NOT NULL,
	Capacity INT NOT NULL,
	ScreenType VARCHAR(50),
	FOREIGN KEY (CinemaID) REFERENCES Cinema(CinemaID)
);

CREATE TABLE Movie (
	MovieID INT PRIMARY KEY,
	Title VARCHAR(255) NOT NULL,
	Director VARCHAR(100),
	ReleaseDate DATE,
	DurationMinutes INT,
	Rating VARCHAR(5)
);

CREATE TABLE Showtime (
	ShowtimeID INT PRIMARY KEY,
	MovieID INT,
	TheaterID INT,
	ShowDateTime DATETIME NOT NULL,
	Price DECIMAL(5,2) NOT NULL,
	FOREIGN KEY (MovieID) REFERENCES Movie(MovieID),
	FOREIGN KEY (TheaterID) REFERENCES Theater(TheaterID)
);

CREATE TABLE Customer (
	CustomerID INT PRIMARY KEY,
	FirstName VARCHAR(50) NOT NULL,
	LastName VARCHAR(50) NOT NULL,
	Email VARCHAR(100),
	PhoneNumber VARCHAR(20)
);

CREATE TABLE Ticket (
	TicketID INT PRIMARY KEY,
	ShowtimeID INT,
	SeatNumber VARCHAR(10) NOT NULL,
	PurchasedDateTime DATETIME NOT NULL,
	CustomerID INT,
	FOREIGN KEY (ShowtimeID) REFERENCES Showtime(ShowtimeID),
	FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

CREATE TABLE Review (
	ReviewID INT PRIMARY KEY,
	MovieID INT,
	CustomerID INT,
	ReviewText TEXT,
	Rating INT CHECK (Rating >= 1 AND Rating <= 5),
	ReviewDate DATETIME NOT NULL,
	FOREIGN KEY (MovieID) REFERENCES Movie(MovieID),
	FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

CREATE TABLE Employee (
	EmployeeID INT PRIMARY KEY,
	CinemaID INT,
	FirstName VARCHAR(50) NOT NULL,
	LastName VARCHAR(50) NOT NULL,
	Position VARCHAR(50),
	HireDate DATE,
	FOREIGN KEY (CinemaID) REFERENCES Cinema(CinemaID)
);

-------------------------------------------------------------------

INSERT INTO Cinema (CinemaID, Name, Address, Phone)
VALUES
(1, 'Cinema Paradiso', 'Via Roma 123', '06 1234567'),
(2, 'Cinema inferno', 'Via Napoli 222', '+ 06 8574635');
 
INSERT INTO Theater (TheaterID, CinemaID, Name, Capacity, ScreenType)
VALUES
(1, 1, 'Sala 1', 100, '2D'),
(2, 1, 'Sala 2', 80, '3D'),
(3, 2, 'Sala 3', 150, 'IMAX'),
(4, 2, 'Sala 4', 120, '2D');
 
INSERT INTO Movie (MovieID, Title, Director, ReleaseDate, DurationMinutes, Rating)
VALUES
(1, 'The Shawshank Redemption', 'Frank Darabont', '1994-09-23', 142, '4'),
(2, 'Inception', 'Christopher Nolan', '2010-07-16', 148, '4'),
(3, 'Pulp Fiction', 'Quentin Tarantino', '1994-10-14', 154, '5');
 
INSERT INTO Showtime (ShowtimeID, MovieID, TheaterID, ShowDateTime, Price)
VALUES
(1, 1, 1, '2024-03-2 18:00:00', 10.00),
(2, 2, 3, '2024-03-2 20:00:00', 12.50),
(3, 3, 2, '2024-03-2 19:30:00', 11.00);
 
INSERT INTO Customer (CustomerID, FirstName, LastName, Email, PhoneNumber)
VALUES
(1, 'Mario', 'Rossi', 'mrossi@example.com', '3334657889'),
(2, 'Valerio', 'Bianchi', 'valbianch@example.com', '336970699');
 
INSERT INTO Ticket (TicketID, ShowtimeID, SeatNumber, PurchasedDateTime, CustomerID)
VALUES
(1, 1, 'A1', '2024-03-01 15:30:00', 1),
(2, 2, 'B5', '2024-03-01 10:45:00', 2);
 
INSERT INTO Review (ReviewID, MovieID, CustomerID, ReviewText, Rating, ReviewDate)
VALUES
(1, 1, 1, 'Bellissimo film,uno dei migliori!', 5, '2024-03-01 09:15:00'),
(2, 2, 2, 'Film dell''anno.', 4, '2024-03-01 22:30:00');
 
INSERT INTO Employee (EmployeeID, CinemaID, FirstName, LastName, Position, HireDate)
VALUES
(1, 1, 'Franco', 'Rossi', 'Manager', '2020-01-15'),
(2, 2, 'Luca', 'Gialli', 'Cassiere', '2022-03-01');

---------------------------------------------------------------------

/*
	Creare una vista FilmsInProgrammation che mostri i titoli dei film, la data di inizioprogrammazione, 
	la durata e la classificazione per et�. Questa vista aiuter� il personale e i clienti a
	vedere rapidamente quali film sono attualmente in programmazione.
*/
CREATE VIEW FilmsInProgrammation AS
	SELECT Movie.Title, Showtime.ShowDateTime, Movie.DurationMinutes, Movie.Rating
	FROM Cinema
	JOIN Theater ON Theater.CinemaID = Cinema.CinemaID
	JOIN Movie ON Movie.MovieID = Theater.TheaterID
	JOIN Showtime ON Showtime.ShowtimeID = Movie.MovieID;

SELECT * FROM FilmsInProgrammation;

-----------------------------------------------------------

/*
	Creare una vista AvailableSeatsForShow che, per ogni spettacolo, mostri il numero totale di
	posti nella sala e quanti sono ancora disponibili. Questa vista � essenziale per il personale alla
	biglietteria per gestire le vendite dei biglietti.
*/
DROP VIEW IF EXISTS AvailableSeatsForShow;
CREATE VIEW AvailableSeatsForShow AS
	SELECT Theater.TheaterID AS 'Sala', Theater.Capacity AS 'Posti Totali', (Theater.Capacity - COUNT (Ticket.TicketID)) AS 'Posti Disponibili'
	FROM Theater
	JOIN Movie ON Theater.TheaterID = Movie.MovieID
	JOIN Showtime ON Movie.MovieID = Showtime.MovieID
	JOIN Ticket ON Showtime.ShowtimeID = Ticket.ShowtimeID
	GROUP BY Theater.TheaterID, Theater.Capacity;

SELECT * FROM AvailableSeatsForShow;

-----------------------------------------------------------------

/*
	Generare una vista TotalEarningsPerMovie che elenchi ogni film insieme agli incassi totali generati. 
	Questa informazione � cruciale per la direzione per valutare il successo commerciale dei film.
*/

DROP VIEW IF EXISTS TotalEarningsPerMovie;
CREATE VIEW TotalEarningsPerMovie AS
	SELECT Title AS 'Titolo', SUM(Showtime.Price) AS 'Guadagno totale'
	FROM Movie
	JOIN Showtime ON Movie.MovieID = Showtime.ShowtimeID
	JOIN Ticket ON Showtime.ShowtimeID = Ticket.ShowtimeID
	GROUP BY Movie.Title;

SELECT * FROM TotalEarningsPerMovie;

----------------------------------------------------------------------

/*
	Creare una vista RecentReviews che mostri le ultime recensioni lasciate dai clienti, 
	includendo il titolo del film, la valutazione, il testo della recensione e la data. 
	Questo permetter� al personale e alla direzione di monitorare il feedback dei clienti in tempo reale.
*/

CREATE VIEW RecentReviews AS
	SELECT Movie.Title AS 'Titolo', Review.Rating AS 'Valutazione', Review.ReviewText AS 'Commento'
	FROM Movie
	JOIN Review ON Movie.MovieID = Review.MovieID;

SELECT * FROM RecentReviews;

----------------------------------------------------------------------------------------------------

/*
	Creare una stored procedure PurchaseTicket che permetta di acquistare un biglietto per uno spettacolo, 
	specificando l'ID dello spettacolo, il numero del posto e l'ID del cliente. 
	La procedura dovrebbe verificare la disponibilit� del posto e registrare l'acquisto.
*/
DROP PROCEDURE IF EXISTS PurchaseTicket;
CREATE PROCEDURE PurchaseTicket
	@ticketID INT,
	@spettacoloID INT,
	@numeroPosto VARCHAR(10),
	@clienteID INT
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			IF EXISTS (SELECT 1 FROM Ticket WHERE @spettacoloID = ShowtimeID AND @numeroPosto = SeatNumber)
				
				THROW 50001, 'Posto gi� occupato', 1
				
			ELSE
				BEGIN
					INSERT INTO Ticket(TicketID, ShowtimeID, SeatNumber, PurchasedDateTime, CustomerID) VALUES
					(@ticketID, @spettacoloID, @numeroPosto, CURRENT_TIMESTAMP, @clienteID)

					PRINT 'Inserimento Effettuato con successo'
				END
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION

		PRINT 'Errore riscontrato: ' + ERROR_MESSAGE()
	END CATCH
END;

EXEC PurchaseTicket @clienteID = 1, @ticketID = 3, @spettacoloID = 1, @numeroPosto = 'A2';

SELECT * FROM Ticket;

------------------------------------------------------------------------------

/*
	Implementare una stored procedure UpdateMovieSchedule che permetta di aggiornare gli orari degli spettacoli per un determinato film.
	Questo include la possibilit� di aggiungere o rimuovere spettacoli dall'agenda.
*/

CREATE PROCEDURE UpdateMovieSchedule
	@spettacoloID INT,
	@filmID INT,
	@salaID INT,
	@orario DATETIME,
	@prezzo DECIMAL (10,2)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			IF EXISTS (SELECT 1 FROM Showtime WHERE @spettacoloID = ShowtimeID AND @salaID = TheaterID AND @orario = ShowDateTime )
				
				THROW 50002, 'Spettacolo gi� esistente', 1
				
			ELSE
				INSERT INTO Showtime(ShowtimeID, MovieID, TheaterID, ShowDateTime, Price) VALUES
				(@spettacoloID, @filmID, @salaID, @orario, @prezzo)

				PRINT 'Inserimento Effettuato con successo'

		COMMIT TRANSACTION

	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION

		PRINT 'Errore riscontrato: ' + ERROR_MESSAGE()
	END CATCH

END;

EXEC UpdateMovieSchedule @spettacoloID = 4, @filmID = 3, @salaID = 2, @orario = '2024-03-2 18:00:00', @prezzo = 9.90;

SELECT * FROM Showtime;

--------------------------------------------------------------------------------------------------

/*
	Sviluppare una stored procedure InsertNewMovie che consenta di inserire un nuovo film nel sistema, 
	richiedendo tutti i dettagli pertinenti come titolo, regista, data di uscita, durata e classificazione.
*/

CREATE PROCEDURE InsertNewMovie
	@filmID INT,
	@titolo VARCHAR(50),
	@direttore VARCHAR(50), 
	@dataUscita DATE, 
	@durata INT, 
	@valutazione VARCHAR(5)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			IF EXISTS (SELECT 1 FROM Movie WHERE @filmID = MovieID)
				
				THROW 50003, 'Film gi� inserito', 1
			ELSE
				INSERT INTO Movie (MovieID, Title, Director, ReleaseDate, DurationMinutes, Rating) VALUES
				(@filmID, @titolo, @direttore, @dataUscita, @durata, @valutazione)

				PRINT 'Inserimento Effettuato con successo'

		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH

	END CATCH
END;

EXEC InsertNewMovie @filmID = 4, @titolo = 'Il padrino pt. 1', @direttore = 'Fracis Ford Coppola', @dataUscita ='1972-01-01', @durata = 175, @valutazione = '5';

SELECT * FROM Movie;









