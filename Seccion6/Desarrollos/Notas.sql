--USING SQL IN PL/SQL
	--COMO USAR SENTENCIAS SQL DENTRO DE PL/SQL --> SOLO SE PUEDE RECIBIR UN REGISTRO
	SELECT [COLUMNS]
	  INTO [VARIABLES POR COLUMNA DEVUELTA DONDE SE GUARDARA EL RESULTADO ]
	  FROM [TABLA]
	 WHERE [CONDITION];
	
	--DML OPERATIONS IN PL/SQL
	
	--USING SEQUENCES IN PL/SQL
	[VARIABLE|COLUMN] := SEQUENCE_NAME.[NEXTVAL|CURRVAL];
	
	SELECT SEQUENCE_NAME.[NEXTVAL|CURRVAL]
	  INTO [VARIABLE|COLUMN]
	  FROM [TABLA|DUAL];
	
	