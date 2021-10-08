CREATE DATABASE Pizzeria;

-----------------------------------------CREAZIONE TABELLE----------------------------------------
CREATE TABLE Pizza(
IdPizza INT IDENTITY(1,1) NOT NULL,
Nome NVARCHAR(30) NOT NULL,
Prezzo DECIMAL(5,2) NOT NULL,  --ho inserito (5,2) perchÈ ho letto su internet che in questo modo mi dar‡ le prime 2 cifre significative dopo la virgola, anche se sono entrambe 0
CONSTRAINT PK_Pizza PRIMARY KEY (IdPizza),
CONSTRAINT CHK_PrezzoPizza CHECK (Prezzo > 0)
);

CREATE TABLE Ingrediente(
IdIngrediente INT IDENTITY(1,1) NOT NULL,
Nome NVARCHAR(30) NOT NULL,
Costo DECIMAL(5,2) NOT NULL, 
QtaMagazzino INT NOT NULL,
CONSTRAINT PK_Ingrediente PRIMARY KEY (IdIngrediente),
CONSTRAINT CHK_CostoIngrediente CHECK (Costo > 0),
CONSTRAINT CHK_ScorteIngrediente CHECK (QtaMagazzino >= 0)
);

CREATE TABLE IngredientiPizza(
IdPizza INT NOT NULL,
IdIngrediente INT NOT NULL,
CONSTRAINT PK_PizzaIngrediente PRIMARY KEY (IdPizza,IdIngrediente),
CONSTRAINT FK_Pizza FOREIGN KEY (IdPizza) REFERENCES Pizza(IdPizza),
CONSTRAINT FK_Ingrediente FOREIGN KEY (IdIngrediente) REFERENCES Ingrediente(IdIngrediente)
);





-----------------------------------------INSERT----------------------------------------

INSERT INTO Pizza VALUES ('Margherita', 5)
INSERT INTO Pizza VALUES ('Bufala', 7)
INSERT INTO Pizza VALUES ('Diavola', 6)
INSERT INTO Pizza VALUES ('Quattro stagioni', 6.50)
INSERT INTO Pizza VALUES ('Porcini', 7)
INSERT INTO Pizza VALUES ('Dioniso', 8)
INSERT INTO Pizza VALUES ('Ortolana', 8)
INSERT INTO Pizza VALUES ('Patate e salsiccia', 6)
INSERT INTO Pizza VALUES ('Pomodorini', 6)
INSERT INTO Pizza VALUES ('Quattro formaggi', 7.50)
INSERT INTO Pizza VALUES ('Caprese', 7.50)
INSERT INTO Pizza VALUES ('Zeus', 7.50)

INSERT INTO PIZZA VALUES('Pizza', 0) --PER VERIFICARE CHECK


INSERT INTO Ingrediente VALUES ('Pomodoro', 3, 30)
INSERT INTO Ingrediente VALUES ('Mozzarella', 5, 40)
INSERT INTO Ingrediente VALUES ('Mozzarella di bufala', 7, 35)
INSERT INTO Ingrediente VALUES ('Spianata piccante', 4, 25)
INSERT INTO Ingrediente VALUES ('Funghi', 3, 30)
INSERT INTO Ingrediente VALUES ('Carciofi', 2.50, 10)
INSERT INTO Ingrediente VALUES ('Prosciutto cotto', 2.50, 12)
INSERT INTO Ingrediente VALUES ('Olive', 1.50, 9)
INSERT INTO Ingrediente VALUES ('Funghi Porcini', 4, 15)
INSERT INTO Ingrediente VALUES ('Stracchino', 2.50, 11)
INSERT INTO Ingrediente VALUES ('Speck', 2.50, 13)
INSERT INTO Ingrediente VALUES ('Rucola', 0.80, 20)
INSERT INTO Ingrediente VALUES ('Grana', 5.50, 33)
INSERT INTO Ingrediente VALUES ('Verdure di stagione', 1.50, 30)
INSERT INTO Ingrediente VALUES ('Patate', 0.90, 50)
INSERT INTO Ingrediente VALUES ('Salsiccia', 5.50, 15)
INSERT INTO Ingrediente VALUES ('Pomodorini', 1.50, 40)
INSERT INTO Ingrediente VALUES ('Ricotta', 3.50, 25)
INSERT INTO Ingrediente VALUES ('Provola', 4, 46)
INSERT INTO Ingrediente VALUES ('Gorgonzola', 3, 16)
INSERT INTO Ingrediente VALUES ('Pomodoro fresco', 1.50, 35)
INSERT INTO Ingrediente VALUES ('Basilico', 0.50, 28)
INSERT INTO Ingrediente VALUES ('Bresaola', 7.50, 21)

INSERT INTO Ingrediente VALUES('Ingrediente', -10, 1)  --PER VERIFICARE CHECK
INSERT INTO Ingrediente VALUES('Ingrediente', 10, -4)  --PER VERIFICARE CHECK


SELECT * FROM Pizza
SELECT * FROM Ingrediente

--Per popolare la tabella IngredientiPizza invece di usare la INSERT utilizzo la PROCEDURE AssegnaIngredientePizza 

GO
CREATE PROCEDURE AssegnaIngredientiPizza
@NomePizza NVARCHAR(30),
@NomeIngrediente NVARCHAR(30)
AS

BEGIN
  BEGIN TRY
    INSERT INTO IngredientiPizza VALUES ((SELECT p.IdPizza FROM Pizza AS p WHERE p.Nome = @NomePizza), (SELECT i.IdIngrediente FROM Ingrediente AS i WHERE i.Nome = @NomeIngrediente))
  END TRY

  BEGIN CATCH
    SELECT ERROR_MESSAGE()
  END CATCH
END
GO

--In questa procedure ho scelto di fare la query direttamente nella INSERT, avrei potuto creare una variabile e farlo fuori

EXECUTE AssegnaIngredientiPizza 'Margherita', 'Pomodoro'
EXECUTE AssegnaIngredientiPizza 'Margherita', 'Mozzarella'

EXECUTE AssegnaIngredientiPizza 'Bufala', 'Pomodoro'
EXECUTE AssegnaIngredientiPizza 'Bufala', 'Mozzarella di bufala'

EXECUTE AssegnaIngredientiPizza 'Diavola', 'Pomodoro'
EXECUTE AssegnaIngredientiPizza 'Diavola', 'Mozzarella'
EXECUTE AssegnaIngredientiPizza 'Diavola', 'Spianata piccante'

EXECUTE AssegnaIngredientiPizza 'Quattro stagioni', 'Pomodoro'
EXECUTE AssegnaIngredientiPizza 'Quattro stagioni', 'Mozzarella'
EXECUTE AssegnaIngredientiPizza 'Quattro stagioni', 'Funghi'
EXECUTE AssegnaIngredientiPizza 'Quattro stagioni', 'Carciofi'
EXECUTE AssegnaIngredientiPizza 'Quattro stagioni', 'Prosciutto cotto'
EXECUTE AssegnaIngredientiPizza 'Quattro stagioni', 'Olive'

EXECUTE AssegnaIngredientiPizza 'Porcini', 'Pomodoro'
EXECUTE AssegnaIngredientiPizza 'Porcini', 'Mozzarella'
EXECUTE AssegnaIngredientiPizza 'Porcini', 'Funghi Porcini'

EXECUTE AssegnaIngredientiPizza 'Dioniso', 'Pomodoro'
EXECUTE AssegnaIngredientiPizza 'Dioniso', 'Mozzarella'
EXECUTE AssegnaIngredientiPizza 'Dioniso', 'Stracchino'
EXECUTE AssegnaIngredientiPizza 'Dioniso', 'Speck'
EXECUTE AssegnaIngredientiPizza 'Dioniso', 'Rucola'
EXECUTE AssegnaIngredientiPizza 'Dioniso', 'Grana'

EXECUTE AssegnaIngredientiPizza 'Ortolana', 'Pomodoro'
EXECUTE AssegnaIngredientiPizza 'Ortolana', 'Mozzarella'
EXECUTE AssegnaIngredientiPizza 'Ortolana', 'Verdure di stagione'

EXECUTE AssegnaIngredientiPizza 'Patate e salsiccia', 'Mozzarella'
EXECUTE AssegnaIngredientiPizza 'Patate e salsiccia', 'Patate'
EXECUTE AssegnaIngredientiPizza 'Patate e salsiccia', 'Salsiccia'

EXECUTE AssegnaIngredientiPizza 'Pomodorini', 'Mozzarella'
EXECUTE AssegnaIngredientiPizza 'Pomodorini', 'Pomodorini'
EXECUTE AssegnaIngredientiPizza 'Pomodorini', 'Ricotta'

EXECUTE AssegnaIngredientiPizza 'Quattro formaggi', 'Mozzarella'
EXECUTE AssegnaIngredientiPizza 'Quattro formaggi', 'Provola'
EXECUTE AssegnaIngredientiPizza 'Quattro formaggi', 'Gorgonzola'
EXECUTE AssegnaIngredientiPizza 'Quattro formaggi', 'Grana'

EXECUTE AssegnaIngredientiPizza 'Caprese', 'Mozzarella'
EXECUTE AssegnaIngredientiPizza 'Caprese', 'Pomodoro fresco'
EXECUTE AssegnaIngredientiPizza 'Caprese', 'Basilico'

EXECUTE AssegnaIngredientiPizza 'Zeus', 'Mozzarella'
EXECUTE AssegnaIngredientiPizza 'Zeus', 'Bresaola'
EXECUTE AssegnaIngredientiPizza 'Zeus', 'Rucola'



-----------------------------------------QUERY----------------------------------------
--1)Estrarre tutte le pizze con prezzo superiore a 6 euro --OK
SELECT *
FROM Pizza AS p
WHERE p.Prezzo > 6


--2)Estrarre la pizza/le pizze pi˘ costosa/e --OK
SELECT p.Nome, p.Prezzo
FROM Pizza AS p
WHERE p.Prezzo = 
              (SELECT MAX(p.Prezzo)
               FROM Pizza AS p)


--3)Estrarre le pizze ´biancheª  --ho inteso pizze con base bianca --OK
SELECT *
FROM Pizza AS p 
WHERE p.Nome NOT IN
                  (SELECT p.Nome
				   FROM Pizza AS p 
			        JOIN IngredientiPizza ingP ON ingP.IdPizza = p.IdPizza
				    JOIN Ingrediente i ON i.IdIngrediente = ingP.IdIngrediente
				   WHERE i.Nome='Pomodoro')


--4)Estrarre le pizze che contengono funghi (di qualsiasi tipo) --OK
SELECT p.Nome AS 'Pizza con funghi', i.Nome AS 'Tipologia'
FROM Pizza AS p
 JOIN IngredientiPizza ingP ON ingP.IdPizza = p.IdPizza
 JOIN Ingrediente i ON i.IdIngrediente = ingP.IdIngrediente
WHERE i.Nome like 'Funghi%'



-----------------------------------------PROCEDURE----------------------------------------
----1)Inserimento di una nuova pizza (parametri: nome, prezzo) --OK

GO
CREATE PROCEDURE InserisciPizza
@NomePizza NVARCHAR(30),
@PrezzoPizza DECIMAL(5,2)
AS
INSERT INTO Pizza VALUES (@NomePizza, @PrezzoPizza)

EXECUTE InserisciPizza 'Marinara', 3.50

SELECT * FROM Pizza



----2)Assegnazione di un ingrediente a una pizza (parametri: nome pizza, nome ingrediente) --OK
----GIA' CREATA PRIMA PER POPOLARE LA TABELLA IngredientiPizza

EXECUTE AssegnaIngredientiPizza 'Marinara', 'Pomodoro'



----3)Aggiornamento del prezzo di una pizza (parametri: nome pizza e nuovo prezzo) --OK

GO
CREATE PROCEDURE AggiornaPrezzoPizza
@NomePizza NVARCHAR(30),
@NuovoPrezzo DECIMAL(5,2)
AS

BEGIN
  DECLARE @IdPizzaScelta INT

  SELECT @IdPizzaScelta = p.IdPizza
  FROM Pizza AS p
  WHERE p.Nome = @NomePizza

    BEGIN TRY
        UPDATE Pizza SET Prezzo = @NuovoPrezzo WHERE IdPizza = @IdPizzaScelta
    END TRY

    BEGIN CATCH
        SELECT ERROR_MESSAGE()
    END CATCH
END

EXECUTE AggiornaPrezzoPizza 'Marinara', 3

SELECT * FROM Pizza



----4)Eliminazione di un ingrediente da una pizza (parametri: nome pizza, nome ingrediente) --OK

GO
CREATE PROCEDURE EliminaIngredientePizza
@NomePizza NVARCHAR(30),
@NomeIngrediente NVARCHAR(30)
AS
BEGIN
 BEGIN TRY

  DELETE FROM IngredientiPizza 
         WHERE IngredientiPizza.IdPizza = (SELECT p.IdPizza
                                           FROM Pizza p
                                           WHERE p.Nome = @NomePizza)
										  
        AND IngredientiPizza.IdIngrediente = (SELECT i.IdIngrediente
                                              FROM Ingrediente i
                                              WHERE i.Nome = @NomeIngrediente)
 END TRY

 BEGIN CATCH
  SELECT ERROR_MESSAGE()
 END CATCH
END

EXECUTE EliminaIngredientePizza 'Marinara', 'Pomodoro'


----5)Incremento del 10% del prezzo delle pizze contenenti un ingrediente (parametro: nome ingrediente) --OK
GO
CREATE PROCEDURE AumentaPrezzo
@NomeIngrediente NVARCHAR(30)
AS

BEGIN
  BEGIN TRY

     UPDATE Pizza SET Prezzo = Prezzo + (Prezzo*0.1)
                  WHERE IdPizza IN (
			                   SELECT p.IdPizza
				               FROM Pizza AS p 
			                    JOIN IngredientiPizza ingP ON ingP.IdPizza = p.IdPizza
				                JOIN Ingrediente i ON i.IdIngrediente = ingP.IdIngrediente
				               WHERE i.Nome = @NomeIngrediente)
   END TRY

   BEGIN CATCH
   SELECT ERROR_MESSAGE()
   END CATCH

END

EXECUTE AumentaPrezzo 'Grana'

SELECT p.Nome, p.Prezzo
FROM Pizza p
  JOIN IngredientiPizza ingP ON ingP.IdPizza = p.IdPizza
  JOIN Ingrediente i ON i.IdIngrediente = ingP.IdIngrediente
WHERE i.Nome = 'Grana'




-----------------------------------------FUNZIONI----------------------------------------
----1)Tabella listino pizze (nome, prezzo)(parametri: nessuno)  --OK
GO
CREATE FUNCTION ListinoPizze()
RETURNS TABLE
AS

  RETURN (SELECT p.Nome, p.Prezzo 
          FROM Pizza AS p);
GO
SELECT *
FROM dbo.ListinoPizze()



----2)Tabella listino pizze (nome, prezzo) contenenti un ingrediente (parametri: nome ingrediente) --OK
GO
CREATE FUNCTION ListinoPizzeConIngrediente(@NomeIngrediente NVARCHAR(30))
RETURNS TABLE
AS
    RETURN (SELECT p.Nome, p.Prezzo 
            FROM Pizza AS p
			  JOIN IngredientiPizza ingP ON ingP.IdPizza = p.IdPizza
              JOIN Ingrediente i ON i.IdIngrediente = ingP.IdIngrediente
			 WHERE i.Nome = @NomeIngrediente);
GO
SELECT *
FROM dbo.ListinoPizzeConIngrediente('Grana')



----3)Tabella listino pizze (nome, prezzo) che non contengono un certo ingrediente(parametri: nome ingrediente) --OK
GO
CREATE FUNCTION ListinoPizzeSENZAIngrediente(@NomeIngrediente NVARCHAR(30))
RETURNS TABLE
AS
    RETURN (SELECT p.Nome, p.Prezzo 
            FROM Pizza AS p
		  	WHERE p.Nome NOT IN (
			                    SELECT p.Nome 
                                FROM Pizza AS p
			                      JOIN IngredientiPizza ingP ON ingP.IdPizza = p.IdPizza
                                  JOIN Ingrediente i ON i.IdIngrediente = ingP.IdIngrediente
			                     WHERE i.Nome = @NomeIngrediente));
GO
SELECT *
FROM dbo.ListinoPizzeSENZAIngrediente('Pomodoro')


----4)Calcolo numero pizze contenenti un ingrediente (parametri nome ingrediente) --OK
GO
CREATE FUNCTION CalcoloNumPizzeIngrediente(@NomeIngrediente NVARCHAR(30))
RETURNS INT
AS  
   BEGIN 
     DECLARE @NumeroPizze INT

	 SELECT @NumeroPizze = COUNT(p.IdPizza)
	 FROM Pizza AS p
	  JOIN IngredientiPizza ingP ON ingP.IdPizza = p.IdPizza
      JOIN Ingrediente i ON i.IdIngrediente = ingP.IdIngrediente
	 WHERE i.Nome = @NomeIngrediente
    
	   RETURN @NumeroPizze
	END
GO

SELECT dbo.CalcoloNumPizzeIngrediente('Pomodoro') AS 'Numero di Pizze con ingrediente inserito'



----5)Calcolo numero pizze che non contengono un ingrediente (parametri codice ingrediente) ---OK
GO
CREATE FUNCTION CalcoloNumPizzeSENZAIngrediente(@IdIngrediente INT)
RETURNS INT
AS  
   BEGIN 
     DECLARE @NumeroPizze INT

	 SELECT @NumeroPizze = COUNT(p.IdPizza)
	 FROM Pizza AS p
	  WHERE p.Nome NOT IN ( SELECT p.Nome 
                            FROM Pizza AS p
			                   JOIN IngredientiPizza ingP ON ingP.IdPizza = p.IdPizza
                               JOIN Ingrediente i ON i.IdIngrediente = ingP.IdIngrediente
			                 WHERE i.IdIngrediente = @IdIngrediente)
	   RETURN @NumeroPizze
	END
GO

SELECT dbo.CalcoloNumPizzeSENZAIngrediente(1) AS 'Numero di Pizze senza ingrediente inserito' --risultato = 6 perchÈ ho anche la marinara a cui prima ho rimosso il pomodoro


----6)Calcolo numero ingredienti contenuti in una pizza (parametri nome pizza) --OK
GO
CREATE FUNCTION NumIngredientiPizza(@NomePizza NVARCHAR(30))
RETURNS INT
AS  
   BEGIN 
     DECLARE @NumeroIngredienti INT

	 SELECT @NumeroIngredienti = COUNT(*)
	 FROM Pizza AS p
	  JOIN IngredientiPizza ingP ON ingP.IdPizza = p.IdPizza
     WHERE p.Nome = @NomePizza
	  
	  RETURN @NumeroIngredienti
	END
GO
SELECT dbo.NumIngredientiPizza('Quattro formaggi') AS 'Numero di Ingredienti nella pizza scelta'




-----------------------------------------VIEW----------------------------------------
-- Realizzare una view che rappresenta il men˘ con tutte le pizze

---VADO PRIMA A CREARE UNA FUNZIONE CHE MI PERMETTE DI AGGREGARE FRA LORO GLI INGREDIENTI
GOCREATE FUNCTION ListaIngredientiPizza(@NomePizza NVARCHAR(30))RETURNS NVARCHAR(MAX)AS BEGIN   DECLARE @ElencoIngredienti NVARCHAR(MAX)   SELECT @ElencoIngredienti = COALESCE(@ElencoIngredienti + ', ' + i.Nome, i.Nome) --la funzione COALESCE resituisce il primo valore non nullo in una lista   FROM Pizza AS p
	 JOIN IngredientiPizza ingP ON ingP.IdPizza = p.IdPizza
     JOIN Ingrediente i ON i.IdIngrediente = ingP.IdIngrediente
   WHERE p.Nome = @NomePizza

  RETURN @ElencoIngredienti
END
GO
SELECT dbo.ListaIngredientiPizza('Margherita')


--------MENU'--------
GO
CREATE VIEW Men˘(Pizza, Prezzo, Ingredienti)
 AS

  SELECT DISTINCT p.Nome AS 'Pizza', p.Prezzo, dbo.ListaIngredientiPizza(p.Nome) AS 'Ingredienti'
  FROM Pizza AS p
	 JOIN IngredientiPizza ingP ON ingP.IdPizza = p.IdPizza
     JOIN Ingrediente i ON i.IdIngrediente = ingP.IdIngrediente
GO


SELECT * FROM Men˘;



--------------------------------------PROCEDURA OPZIONALE: ORDINE--------------------------------------

--Ho per prima cosa creato una tabella ordine, in cui memorizzare il numero del tavolo da cui si ordina, le pizze scelte
--e la somma del prezzo delle singole pizze, che verr‡ calcolato nella Procedura

CREATE TABLE Ordine(
NumTavolo INT NOT NULL,  
NomePizza NVARCHAR(30) NOT NULL,
Quantit‡ INT NOT NULL,
TotalePerPizza DECIMAL(5,2),
IdPizza INT NOT NULL,
CONSTRAINT FK_Ordine FOREIGN KEY (IdPizza) REFERENCES Pizza(IdPizza),
CONSTRAINT CHK_Quantit‡Pizza CHECK (Quantit‡ > 0)
);


--In questa procedura si inserisce il numero di tavolo, il nome della pizza, e la quantit‡ di ogni pizza
--La procedura calcola il costo della somma delle singole pizze facendo PrezzoPizza*Quantit‡Scelta
--Il tutto viene salvato nella tabella ordine

GO
CREATE PROCEDURE OrdinePizze
@NumTavolo INT,
@NomePizza NVARCHAR(30),
@Quantit‡ INT

AS

DECLARE @IdPizzaScelta INT
DECLARE @PrezzoPizza DECIMAL(5,2)

SELECT @IdPizzaScelta = p.IdPizza
FROM Pizza p
WHERE p.Nome = @NomePizza 

SELECT @PrezzoPizza = p.Prezzo
FROM Pizza p
WHERE p.IdPizza = @IdPizzaScelta


INSERT INTO Ordine VALUES (@NumTavolo, @NomePizza, @Quantit‡, NULL, @IdPizzaScelta)

UPDATE Ordine SET Ordine.TotalePerPizza = @PrezzoPizza*@Quantit‡ WHERE IdPizza = @IdPizzaScelta AND NumTavolo = @NumTavolo
		
GO

EXECUTE OrdinePizze 1, 'Margherita', 2
EXECUTE OrdinePizze 1, 'Ortolana', 1
EXECUTE OrdinePizze 1, 'Diavola', 2

EXECUTE OrdinePizze 2, 'Margherita', 2
EXECUTE OrdinePizze 2, 'Porcini', 1
EXECUTE OrdinePizze 2, 'Caprese', 1
EXECUTE OrdinePizze 2, 'Bufala', 2


SELECT * FROM Ordine

--Con questa funzione stampo il totale da pagare del tavolo inserito in Input

GO
CREATE FUNCTION StampaScontrino(@NumTavolo INT)
RETURNS DECIMAL(5,2)
AS  
   BEGIN
      DECLARE @Totale DECIMAL(5,2)
    
	        
        SELECT @Totale = SUM(o.TotalePerPizza) 
        FROM Ordine o
        WHERE o.NumTavolo = @NumTavolo

		RETURN @Totale
     END
GO  
	
	SELECT dbo.StampaScontrino(1) AS 'Totale Tavolo Scelto'


