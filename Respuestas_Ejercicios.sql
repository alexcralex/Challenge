
/**************EJERCICIOS***********/
--(1)-------------------------------
--VARIABLE CONDICIONAL
DECLARE @FLAG INT = 0;
--CONTADOR
DECLARE @COUNT INT = 0;
--SUMA 
DECLARE @SUM INT = 0;
--NUMERO N
DECLARE @N INT= 2;
--LOOP
WHILE @FLAG <> @N
BEGIN
	SET @COUNT = @COUNT + 1;
	SET @SUM = @SUM + @COUNT;
IF @COUNT = @N BEGIN SET @FLAG = @N END;
END
--SELECT @COUNT AS CONTADOR;
--RESULTADO
SELECT @SUM AS SUMA;
--(2)-------------------------------

--DATOS
DECLARE @NUMVAL TABLE(ID INT IDENTITY(1,1), VAL INT);

INSERT INTO 
@NUMVAL
SELECT 100  UNION ALL  
SELECT 45	UNION ALL
SELECT 24	UNION ALL 
SELECT 94	UNION ALL
SELECT 2	UNION ALL
SELECT 45	UNION ALL
SELECT 5;

SELECT * FROM @NUMVAL

--Quicksort Pseudocodigo
/*







*/


--(3)-------------------------------
IF OBJECT_ID('dbo.tPersona', 'U') IS NOT NULL DROP TABLE dbo.tPersona; 
CREATE TABLE tPersona(
 rut VARCHAR(10),
 NomCompleto VARCHAR(255) NOT NULL,
 fechaNacimiento DATE NULL,
 vivo BIT,
 rutPadre VARCHAR(10) NULL,
 rutMadre VARCHAR(10) NULL
 )
 -- 
ALTER TABLE tPersona ALTER COLUMN RUT VARCHAR(10) NOT NULL;
ALTER TABLE tPersona ADD CONSTRAINT pk_rut PRIMARY KEY(rut);



INSERT INTO [dbo].[tPersona]
           ([rut]
           ,[NomCompleto]
           ,[fechaNacimiento]
           ,[vivo]
           ,[rutPadre]
           ,[rutMadre])
		   SELECT 'A','A','1993-05-09',1,'D','E'
		   UNION ALL
		   SELECT 'B','B','1993-05-09',0,'D','E'
		    UNION ALL
		   SELECT 'C','C','1993-05-09',1,'D','E'
		    UNION ALL
		   SELECT 'D','D','1800-01-01',1,NULL,NULL
		    UNION ALL
		   SELECT 'E','E','1800-01-01',1,NULL,NULL
		    UNION ALL
		   SELECT 'F','F','1900-01-01',1,'G',NULL
		   union all
		    SELECT 'H','H','1993-05-09',1,'E','I'
		   UNION ALL
		   SELECT 'I','I','1800-01-01',1,'J','K'
		    UNION ALL
		   SELECT 'J','J','1993-05-09',1,'D','E'
		    UNION ALL
		   SELECT 'K','K','1899-01-01',0,NULL,NULL



		   SELECT * FROM [tPersona]
--a)


DECLARE @GLAF INT = 0;
DECLARE @RUTS TABLE (RUT VARCHAR(10));
DECLARE @RUT VARCHAR(10);
DECLARE @RUTP VARCHAR(10);
DECLARE @RUTM VARCHAR(10);
DECLARE @NACP DATE
DECLARE @NACM DATE;
DECLARE @RESPUESTA_A TABLE (RUT VARCHAR(10));
DECLARE @RESPUESTA_B TABLE (NomCompleto VARCHAR(255));


INSERT INTO @RUTS SELECT rut FROM tPersona ORDER BY rut ASC;

SELECT * from @RUTS

WHILE @GLAF = 0
BEGIN

SET @RUT = (SELECT TOP 1 rut FROM @RUTS);

--desarrollo a
SET @RUTM = (SELECT [rutMadre] FROM tPersona WHERE rut = @RUT);
SET @RUTP = (SELECT [rutPadre] FROM tPersona WHERE rut = @RUT);

SET @NACP = (SELECT fechaNacimiento FROM tPersona WHERE rut = @RUTM);
SET @NACM = (SELECT fechaNacimiento FROM tPersona WHERE rut = @RUTP);

IF @NACP = @NACM
BEGIN
INSERT INTO @RESPUESTA_A SELECT @RUT
END

--desarrollo b

IF (CAST((SELECT vivo FROM tPersona WHERE rut = @RUTM) AS INT) + CAST((SELECT vivo FROM tPersona WHERE rut = @RUTP) AS INT)) = 1
BEGIN
INSERT INTO @RESPUESTA_B SELECT NomCompleto FROM tPersona WHERE rut = @RUT
END

--Loop
DELETE TOP (1) FROM @RUTS;
IF NOT EXISTS (SELECT 1 FROM  @RUTS) BEGIN SET @GLAF = 1 END;
END

--a)
SELECT * from @RESPUESTA_A
--b)
SELECT * FROM @RESPUESTA_B
--c) 
UPDATE tPersona
SET rutPadre = 'algo'
WHERE
rutPadre is null and rut = 'D'
