SET SERVEROUTPUT ON;
/
--IF STATEMENT
DECLARE
    V_NUMBER NUMBER := 30;
BEGIN
    IF V_NUMBER < 10 THEN
		DBMS_OUTPUT.PUT_LINE('YO SOY MENOR DE 10 AÑOS');
	ELSIF V_NUMBER < 20 THEN
		DBMS_OUTPUT.PUT_LINE('YO SOY MENOR DE 20 AÑOS');
	ELSIF V_NUMBER < 30 THEN
		DBMS_OUTPUT.PUT_LINE('YO SOY MENOR DE 30 AÑOS');
	ELSE
		DBMS_OUTPUT.PUT_LINE('YO SOY IGUAL O MAYOR DE 30 AÑOS');
	END IF;
END;
/
DECLARE
    V_NUMBER NUMBER := NULL;
BEGIN
    IF V_NUMBER < 10 THEN
		DBMS_OUTPUT.PUT_LINE('YO SOY MENOR DE 10 AÑOS');
	ELSIF V_NUMBER < 20 THEN
		DBMS_OUTPUT.PUT_LINE('YO SOY MENOR DE 20 AÑOS');
	ELSIF V_NUMBER < 30 THEN
		DBMS_OUTPUT.PUT_LINE('YO SOY MENOR DE 30 AÑOS');
    ELSE    
        IF V_NUMBER IS NULL THEN
            DBMS_OUTPUT.PUT_LINE('EL NUMERO ES NULL');
        ELSE
            DBMS_OUTPUT.PUT_LINE('YO SOY IGUAL O MAYOR DE 30 AÑOS');
        END IF;
	END IF;
END;
/
DECLARE
    V_NUMBER    NUMBER := 5;
    V_NAME      VARCHAR2(30) := 'CAROL';
BEGIN
    IF V_NUMBER < 10 AND V_NAME = 'CAROL' THEN
		DBMS_OUTPUT.PUT_LINE('YO SOY MENOR DE 10 AÑOS');
	ELSIF V_NUMBER < 20 THEN
		DBMS_OUTPUT.PUT_LINE('YO SOY MENOR DE 20 AÑOS');
	ELSIF V_NUMBER < 30 THEN
		DBMS_OUTPUT.PUT_LINE('YO SOY MENOR DE 30 AÑOS');
    ELSE    
        IF V_NUMBER IS NULL THEN
            DBMS_OUTPUT.PUT_LINE('EL NUMERO ES NULL');
        ELSE
            DBMS_OUTPUT.PUT_LINE('YO SOY IGUAL O MAYOR DE 30 AÑOS');
        END IF;
	END IF;
END;
/
DECLARE
    V_NUMBER    NUMBER := 5;
    V_NAME      VARCHAR2(30) := 'ADAM';
BEGIN
    IF V_NUMBER < 10 AND V_NAME = 'CAROL' THEN
		DBMS_OUTPUT.PUT_LINE('YO SOY MENOR DE 10 AÑOS');
	ELSIF V_NUMBER < 20 THEN
		DBMS_OUTPUT.PUT_LINE('YO SOY MENOR DE 20 AÑOS');
	ELSIF V_NUMBER < 30 THEN
		DBMS_OUTPUT.PUT_LINE('YO SOY MENOR DE 30 AÑOS');
    ELSE    
        IF V_NUMBER IS NULL THEN
            DBMS_OUTPUT.PUT_LINE('EL NUMERO ES NULL');
        ELSE
            DBMS_OUTPUT.PUT_LINE('YO SOY IGUAL O MAYOR DE 30 AÑOS');
        END IF;
	END IF;
END;
/
DECLARE
    V_NUMBER    NUMBER := 5;
    V_NAME      VARCHAR2(30) := 'ADAM';
BEGIN
    IF V_NUMBER < 10 OR V_NAME = 'CAROL' THEN
		DBMS_OUTPUT.PUT_LINE('YO SOY MENOR DE 10 AÑOS');
	ELSIF V_NUMBER < 20 THEN
		DBMS_OUTPUT.PUT_LINE('YO SOY MENOR DE 20 AÑOS');
	ELSIF V_NUMBER < 30 THEN
		DBMS_OUTPUT.PUT_LINE('YO SOY MENOR DE 30 AÑOS');
    ELSE    
        IF V_NUMBER IS NULL THEN
            DBMS_OUTPUT.PUT_LINE('EL NUMERO ES NULL');
        ELSE
            DBMS_OUTPUT.PUT_LINE('YO SOY IGUAL O MAYOR DE 30 AÑOS');
        END IF;
	END IF;
END;
/

--CASE EXPRESSIONS
DECLARE
    V_JOB_CODE VARCHAR(10) := 'SA_MAN';
    V_SALARY_INCREASE NUMBER;
BEGIN
    V_SALARY_INCREASE := CASE V_JOB_CODE
                             WHEN 'SA_MAN' THEN 0.2
                             WHEN 'SA_REP' THEN 0.3
                             ELSE 0
                         END;
    DBMS_OUTPUT.PUT_LINE('EL INCREMENTO SALARIAL ES DE: ' ||V_SALARY_INCREASE);
END;
/
DECLARE
    V_JOB_CODE VARCHAR(10) := 'SA_REP';
    V_SALARY_INCREASE NUMBER;
BEGIN
    V_SALARY_INCREASE := CASE V_JOB_CODE
                             WHEN 'SA_MAN' THEN 0.2
                             WHEN 'SA_REP' THEN 0.3
                             ELSE 0
                         END;
    DBMS_OUTPUT.PUT_LINE('EL INCREMENTO SALARIAL ES DE: ' ||V_SALARY_INCREASE);
END;
/
DECLARE
    V_JOB_CODE VARCHAR(10) := 'SA_REPT';
    V_SALARY_INCREASE NUMBER;
BEGIN
    V_SALARY_INCREASE := CASE V_JOB_CODE
                             WHEN 'SA_MAN' THEN 0.2
                             WHEN 'SA_REP' THEN 0.3
                             ELSE 0
                         END;
    DBMS_OUTPUT.PUT_LINE('EL INCREMENTO SALARIAL ES DE: ' ||V_SALARY_INCREASE);
END;
/
DECLARE
    V_JOB_CODE VARCHAR(10) := 'SA_MAN';
    V_SALARY_INCREASE NUMBER;
BEGIN
    V_SALARY_INCREASE := CASE V_JOB_CODE
                             WHEN 'SA_MAN' THEN 0.2 --SI HAY DON CONDICIONES IGUALES SOLO EJECURATA LA PRIMERA
                             WHEN 'SA_MAN' THEN 0.3
                             ELSE 0
                         END;
    DBMS_OUTPUT.PUT_LINE('EL INCREMENTO SALARIAL ES DE: ' ||V_SALARY_INCREASE);
END;
/
DECLARE
    V_JOB_CODE VARCHAR(10) := 'IT_PROG';
    V_SALARY_INCREASE NUMBER;
BEGIN
    V_SALARY_INCREASE := CASE 
                             WHEN V_JOB_CODE = 'SA_MAN' THEN 0.2
                             WHEN V_JOB_CODE IN ('SA_REP', 'IT_PROG' ) THEN 0.3
                             ELSE 0
                         END;
    DBMS_OUTPUT.PUT_LINE('EL INCREMENTO SALARIAL ES DE: ' ||V_SALARY_INCREASE);
END;
/
DECLARE
  V_JOB_CODE        VARCHAR2(10) := 'IT_PROG';
  V_DEPARTMENT      VARCHAR2(10) := 'IT';
  V_SALARY_INCREASE NUMBER;
BEGIN
  CASE
    WHEN V_JOB_CODE = 'SA_MAN' THEN
      V_SALARY_INCREASE := 0.2;
      DBMS_OUTPUT.PUT_LINE('The salary increase for a Sales Manager is: '|| V_SALARY_INCREASE);
    WHEN V_DEPARTMENT = 'IT' AND V_JOB_CODE = 'IT_PROG' THEN
      V_SALARY_INCREASE := 0.3;
      DBMS_OUTPUT.PUT_LINE('The salary increase for a Sales Manager is: '|| V_SALARY_INCREASE);
    ELSE
      V_SALARY_INCREASE := 0;
      DBMS_OUTPUT.PUT_LINE('The salary increase for this job code is: '|| V_SALARY_INCREASE);
  END CASE;
END;
/

--LOOPS
    --BASIC LOOPS
    DECLARE
        V_COUNTER NUMBER(2) := 1;
    BEGIN
        LOOP
            DBMS_OUTPUT.PUT_LINE('MI CONTADOR ES: '|| V_COUNTER);
            V_COUNTER := V_COUNTER + 1;
            IF V_COUNTER = 10 THEN
                DBMS_OUTPUT.PUT_LINE('SE EJECUTO LA MAXIMA CANTIDAD DE VECES PERMITIDAS: '|| V_COUNTER);
                EXIT;
            END IF;
        END LOOP;
    END;
    /
    DECLARE
        V_COUNTER NUMBER(2) := 1;
    BEGIN
        LOOP
            DBMS_OUTPUT.PUT_LINE('MI CONTADOR ES: '|| V_COUNTER);
            V_COUNTER := V_COUNTER + 1;
            EXIT WHEN V_COUNTER >10;
        END LOOP;
    END;
    /
    --WHILE LOOPS
    DECLARE
        V_COUNTER NUMBER(2) := 1;
    BEGIN
        WHILE V_COUNTER <= 10 LOOP
            DBMS_OUTPUT.PUT_LINE('MI CONTADOR ES: '|| V_COUNTER);
            V_COUNTER := V_COUNTER + 1;
        END LOOP;
    END;
    /
    --FOR LOOPS
    BEGIN
        FOR i IN 1..3 LOOP
            DBMS_OUTPUT.PUT_LINE('MI CONTADOR ES: '|| i);
        END LOOP;
    END;
    /
    BEGIN
        FOR i IN REVERSE 1..3 LOOP
            DBMS_OUTPUT.PUT_LINE('MI CONTADOR ES: '|| i);
        END LOOP;
    END;
    /

--NESTED LOOPS & LOOP LABELING -> BUCLES ANIDADOS
    --NESTED LOOPS
    DECLARE
        V_INNER NUMBER := 1;
    BEGIN
        FOR V_OUTER IN 1..5 LOOP
        DBMS_OUTPUT.PUT_LINE('MI CONTADOR ES : ' || V_OUTER );
            V_INNER := 1;
            LOOP
                V_INNER := V_INNER+1;
                DBMS_OUTPUT.PUT_LINE('  MI CONTADOR INTERNO ES : ' || V_INNER );
                EXIT WHEN V_INNER * V_OUTER >= 15;
            END LOOP;
        END LOOP;
    END;
    /
    --NESTED LOOPS WITH LABELS
    DECLARE
        V_INNER NUMBER := 1;
    BEGIN
        <<OUTER_LOOP>>
        FOR V_OUTER IN 1..5 LOOP
            DBMS_OUTPUT.PUT_LINE('MI CONTADOR EXTERNO ES : ' || V_OUTER );
            V_INNER := 1;
            
            <<INNER_LOOP>>
            LOOP
                V_INNER := V_INNER+1;
                DBMS_OUTPUT.PUT_LINE('  MI CONTADOR INTERNO ES : ' || V_INNER );
                EXIT OUTER_LOOP WHEN V_INNER * V_OUTER >= 16;
                EXIT WHEN V_INNER * V_OUTER >= 15;
            END LOOP INNER_LOOP;
            
        END LOOP OUTER_LOOP;
    END;
    /

--CONTINUE STATEMENT
    DECLARE
        V_INNER NUMBER := 1;
    BEGIN
        FOR V_OUTER IN 1..10 LOOP
            DBMS_OUTPUT.PUT_LINE('MI CONTADOR EXTERNO ES : ' || V_OUTER );
            V_INNER := 1;
            WHILE V_INNER * V_OUTER < 15 LOOP
                V_INNER := V_INNER + 1;
                CONTINUE WHEN MOD(V_INNER * V_OUTER,3) = 0;
                DBMS_OUTPUT.PUT_LINE('  MI CONTADOR INTERNO ES : ' || V_INNER );
            END LOOP;
        END LOOP;
    END;
    /
    DECLARE
        V_INNER NUMBER := 1;
    BEGIN
        <<OUTER_LOOP>>
        FOR V_OUTER IN 1..10 LOOP
            DBMS_OUTPUT.PUT_LINE('MI CONTADOR EXTERNO ES : ' || V_OUTER );
            V_INNER := 1;
            <<INNER_LOOP>>
            LOOP
                V_INNER := V_INNER + 1;
                CONTINUE OUTER_LOOP WHEN V_INNER = 10;
                DBMS_OUTPUT.PUT_LINE('  MI CONTADOR INTERNO ES : ' || V_INNER );
            END LOOP INNER_LOOP;
        END LOOP OUTER_LOOP;
    END;
    /

--GOTO STATEMENT

DECLARE
    v_searched_number NUMBER  := 22;
    v_is_prime        BOOLEAN := true;
BEGIN
    FOR x IN 2..v_searched_number-1 LOOP
        IF v_searched_number MOD x = 0 THEN
          dbms_output.put_line(v_searched_number|| ' is not a prime number..');
          v_is_prime := false;
          GOTO end_point;
        END IF;
    END LOOP;
        IF v_is_prime THEN 
            dbms_output.put_line(v_searched_number|| ' is a prime number..');
        END IF;
    <<end_point>>
    dbms_output.put_line('Check complete..');
END;
/
DECLARE
    v_searched_number NUMBER  := 31357;
    v_is_prime        BOOLEAN := TRUE;
    x                 NUMBER  := 2;
BEGIN
    <<start_point>>
    IF v_searched_number MOD x = 0 THEN
        dbms_output.put_line(v_searched_number|| ' is not a prime number..');
        v_is_prime := FALSE;
        GOTO end_point;
    END IF;
    
    x := x+1;
    
    IF x = v_searched_number THEN
        GOTO prime_point;
    END IF;
    
    GOTO start_point;
    
    <<prime_point>>
    IF v_is_prime THEN
        dbms_output.put_line(v_searched_number || ' is a prime number..');
    END IF;
    
    <<end_point>>
    dbms_output.put_line('Check complete..');
END;
/

    
    