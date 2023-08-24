--PL/SQL EXCEPTIONS
	--HANDLING EXCEPTIONS
		--Errores predefinidos por el servidor		
		--Errores no predefinidos por el servidor
		--Errores definidos por el usuario
	DECLARE
	BEGIN
		{'OCURRE LA EXCEPTION'}
	EXCEPTION
		WHEN EXCEPTION_NAME THEN
			[LOGICA]
		WHEN OTHERS THEN
			[LOGICA]
	END;
	
		--SQLCODE -> devuelve el codigo de errore de la EXCEPTION
		--SQLERRM -> es la abreviatura de SQL error message, devuelve el mensaje de error de nuestra EXCEPTION
	
	
	--NON-PREDEFINED EXCEPTIONS
		--PRAGMA	
		EXCEPTION_NAME EXCEPTION;
		PRAGMA EXCEPTION_INIT([EXCEPTION_NAME], ERROR_CODE)
	
	
	--HANDLING & RAISING USER-DEFINED EXCEPTIONS
		EXCEPTION_NAME EXCEPTION;
		
	--RAISE_APPLICATION_ERROR PROCEDURE
		RAISE_APPLICATION_ERROR([ERROR_NUMBER], [ERROR_MESSAGE[TRUE | FALSE]]);
		
	