DESC EMPLOYEES;
/
SET SERVEROUTPUT ON;
/
DECLARE
    V_TYPE EMPLOYEES.JOB_ID%TYPE;
    V_TYPE2 V_TYPE%TYPE;
    V_TYPE3 EMPLOYEES.JOB_ID%TYPE;
BEGIN
    V_TYPE := 'IT_PROG';
    V_TYPE2 := 'SA_MAN';
    V_TYPE3 := NULL;
    DBMS_OUTPUT.PUT_LINE(V_TYPE);
    DBMS_OUTPUT.PUT_LINE(V_TYPE2);
    DBMS_OUTPUT.PUT_LINE('HELLO' || V_TYPE3);
END;