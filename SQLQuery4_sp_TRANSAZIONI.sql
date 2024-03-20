-- DDL
DROP TABLE IF EXISTS OrderDetails;
DROP TABLE IF EXISTS Products;

CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY (1,1),
    ProductName NVARCHAR(100),
    Quantity INT NOT NULL CHECK(Quantity >= 0)
);
 
CREATE TABLE OrderDetails (
    OrderID INT PRIMARY KEY IDENTITY (1,1),
    ProductID INT,
    Quantity INT,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
 
-- DML
INSERT INTO Products (ProductName, Quantity) VALUES
('Tavolo', 10),
('Sedia', 20),
('Lampada', 30);

SELECT * FROM Products;

DROP PROCEDURE IF EXISTS CreateOrder;

CREATE PROCEDURE CreateOrder
	@idProductValue INT,
	@quantityValue INT

AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			IF(@quantityValue <= 0)
				THROW 50001, 'Quantit� non concessa', 1

			UPDATE Products 
			SET Quantity = Quantity - @quantityValue 
			WHERE ProductID = @idProductValue

			IF(@@ROWCOUNT = 0)
				THROW 50002, 'Oggetto non trovato o errore generico', 1

			INSERT INTO OrderDetails(ProductID, Quantity) VALUES
			(@idProductValue, @quantityValue);

			PRINT 'STAPPOOOOOOOOOO'
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION

		PRINT 'Errore riscontrato: ' + ERROR_MESSAGE()
	END CATCH

END

EXEC CreateOrder @idProductValue = 2, @quantityValue = 4;

SELECT * FROM Products;
SELECT * FROM OrderDetails;