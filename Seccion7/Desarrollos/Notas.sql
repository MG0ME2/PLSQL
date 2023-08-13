--COMPOSITE DATA TYPES
	--PL/SQL RECORDS --> SOLO DEBE DEVOLVER UN REGISTRO
	[R_NAME] [TABLE_NAME]%ROWTYPE;
	TYPE [T_NAME] IS RECORD [(VARIABLE_NAME VARIABLE_TYPE, [VARIABLE_NAME VARIABLE_TYPE], ...)];
	
	--EASY DML WITH RECORDS
	
	--COLLECTIONS		
		--VARRAYs
		TYPE [V_NAME] VARRAY[(5)] OF [VARCHAR2(50)];
		--NESTED TABLES
		TYPE [TYPE_NAME] AS TABLE OF [VALUE_DATA_TYPE()[NOT NULL]];
		--ASSOCIATYVE ARRAYs
		TYPE [TYPE_NAME] AS TABLE OF [VALUE_DATA_TYPE()[NOT NULL]] INDEX BY [PLS_INTEGER | BINARY_INTEGER | VARCHAR2(SIZE)];
		-- STORING COLLECTIONS IN TABLES
		