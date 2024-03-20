---- DDL
--CREATE TABLE Employees (
--    EmployeeID INT PRIMARY KEY,
--    FirstName NVARCHAR(50),
--    LastName NVARCHAR(50),
--    Salary DECIMAL(10, 2)				-- 123456769.11
--);
 
---- DML
--INSERT INTO Employees (EmployeeID, FirstName, LastName, Salary) VALUES
--(1, 'John', 'Doe', 50000),
--(2, 'Jane', 'Smith', 60000),
--(3, 'Emily', 'Jones', 70000);

--SELECT * FROM Employees;

----SP he analizza ogni riga e può manipolarla

--DECLARE EmployeeCursor CURSOR FOR
--SELECT FirstNAME + ' ' + LastName, Salary FROM Employees

----Apri il cursore
--OPEN EmployeeCursor

--DECLARE @nominativo VARCHAR(250);
--DECLARE @salario DECIMAL (10,2)

----Recupero della prima riga
--FETCH NEXT FROM EmployeeCursor INTO @nominativo, @salario;

--WHILE @@FETCH_STATUS = 0
--BEGIN 
--	PRINT @nominativo + ' ' + CAST(@salario AS VARCHAR);

--	FETCH NEXT FROM EmployeeCursor INTO @nominativo, @salario;
--END
--CLOSE EmployeeCursor;
-------------------------------------------------------

-- DDL
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Salary DECIMAL(10, 2)				-- 123456769.11
);

DROP TABLE IF EXISTS Dipendenti;
CREATE TABLE Dipendenti(
	nominativo VARCHAR(250),
	salario DECIMAL (10,2),
	dipartimento VARCHAR(50)
);
 
-- DML
INSERT INTO Employees (EmployeeID, FirstName, LastName, Salary) VALUES
(1, 'John', 'Doe', 50000),
(2, 'Jane', 'Smith', 60000),
(3, 'Emily', 'Jones', 70000);

SELECT * FROM Employees;

--SP he analizza ogni riga e può manipolarla
CREATE PROCEDURE ExportEmployees
AS
BEGIN
	DECLARE EmployeeCursor CURSOR FOR
	SELECT FirstNAME + ' ' + LastName, Salary FROM Employees

	--Apri il cursore
	OPEN EmployeeCursor

	DECLARE @nominativo VARCHAR(250);
	DECLARE @salario DECIMAL (10,2)

	--Recupero della prima riga
	FETCH NEXT FROM EmployeeCursor INTO @nominativo, @salario;

	WHILE @@FETCH_STATUS = 0
	BEGIN 
		BEGIN TRY
			INSERT INTO Dipendenti(nominativo, salario) VALUES
			(@nominativo, @salario);
			PRINT @nominativo + ' ' + CAST(@salario AS VARCHAR);
		END TRY
		BEGIN CATCH
			PRINT 'Non sono riuscito ad inserire' + @nominativo
		END CATCH
		FETCH NEXT FROM EmployeeCursor INTO @nominativo, @salario;
	END
	CLOSE EmployeeCursor;
END

EXEC ExportEmployees;
SELECT * FROM Dipendenti;














