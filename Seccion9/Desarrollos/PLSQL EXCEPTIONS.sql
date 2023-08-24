--PL/SQL EXCEPTIONS
    SET SERVEROUTPUT ON;
    
    --HANDLING EXCEPTIONS
    /********************* EXAMPLE 1 *********************/ -- Handling the exception
    DECLARE
        V_NAME VARCHAR2(6);
    BEGIN
        SELECT FIRST_NAME
          INTO V_NAME
          FROM EMPLOYEES
         WHERE EMPLOYEE_ID = 50;
    
        DBMS_OUTPUT.PUT_LINE('Hello');
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('There is no employee with the selected id');
    END;
    /
    /********************* EXAMPLE 2 *********************/ -- Handling multiple exceptions
    DECLARE
        V_NAME            VARCHAR2(6);
        V_DEPARTMENT_NAME VARCHAR2(100);
    BEGIN
        SELECT FIRST_NAME
          INTO V_NAME
          FROM EMPLOYEES
         WHERE EMPLOYEE_ID = 100;
    
        SELECT DEPARTMENT_ID
          INTO V_DEPARTMENT_NAME
          FROM EMPLOYEES
         WHERE FIRST_NAME = V_NAME;
    
        DBMS_OUTPUT.PUT_LINE('Hello ' || V_NAME || '. Your department id is : ' || V_DEPARTMENT_NAME);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('There is no employee with the selected id');
        WHEN TOO_MANY_ROWS THEN
            DBMS_OUTPUT.PUT_LINE('There are more than one employees with the name ' || V_NAME);
            DBMS_OUTPUT.PUT_LINE('Try with a different employee');
    END;
    /
    /********************* EXAMPLE 3 *********************/ -- when others then example
    DECLARE
        V_NAME            VARCHAR2(6);
        V_DEPARTMENT_NAME VARCHAR2(100);
    BEGIN
        SELECT FIRST_NAME
          INTO V_NAME
          FROM EMPLOYEES
         WHERE EMPLOYEE_ID = 103;
    
        SELECT DEPARTMENT_ID
          INTO V_DEPARTMENT_NAME
          FROM EMPLOYEES
         WHERE FIRST_NAME = V_NAME;
    
        DBMS_OUTPUT.PUT_LINE('Hello ' || V_NAME || '. Your department id is : ' || V_DEPARTMENT_NAME);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('There is no employee with the selected id');
        WHEN TOO_MANY_ROWS THEN
            DBMS_OUTPUT.PUT_LINE('There are more than one employees with the name ' || V_NAME);
            DBMS_OUTPUT.PUT_LINE('Try with a different employee');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('An unexpected error happened. Connect with the programmer..');
    END;
    /
    /********************* EXAMPLE 4 *********************/ -- sqlerrm & sqlcode example
    DECLARE
        V_NAME            VARCHAR2(6);
        V_DEPARTMENT_NAME VARCHAR2(100);
    BEGIN
        SELECT FIRST_NAME
          INTO V_NAME
          FROM EMPLOYEES
         WHERE EMPLOYEE_ID = 103;
    
        SELECT DEPARTMENT_ID
          INTO V_DEPARTMENT_NAME
          FROM EMPLOYEES
         WHERE FIRST_NAME = V_NAME;
    
        DBMS_OUTPUT.PUT_LINE('Hello ' || V_NAME || '. Your department id is : ' || V_DEPARTMENT_NAME);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('There is no employee with the selected id');
        WHEN TOO_MANY_ROWS THEN
            DBMS_OUTPUT.PUT_LINE('There are more than one employees with the name ' || V_NAME);
            DBMS_OUTPUT.PUT_LINE('Try with a different employee');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('An unexpected error happened. Connect with the programmer..');
            DBMS_OUTPUT.PUT_LINE(SQLCODE || ' ---> ' || SQLERRM);
    END;
    /
    /********************* EXAMPLE 5 *********************/ -- Inner block exception example
    DECLARE
        V_NAME            VARCHAR2(6);
        V_DEPARTMENT_NAME VARCHAR2(100);
    BEGIN
            SELECT FIRST_NAME
              INTO V_NAME
              FROM EMPLOYEES
             WHERE EMPLOYEE_ID = 100;
        BEGIN
            SELECT DEPARTMENT_ID
              INTO V_DEPARTMENT_NAME
              FROM EMPLOYEES
             WHERE FIRST_NAME = V_NAME;
        
        EXCEPTION
            WHEN TOO_MANY_ROWS THEN
                V_DEPARTMENT_NAME := 'Error in department_name';
        END;
    
        DBMS_OUTPUT.PUT_LINE('Hello ' || V_NAME || '. Your department id is : ' || V_DEPARTMENT_NAME);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('There is no employee with the selected id');
        WHEN TOO_MANY_ROWS THEN
            DBMS_OUTPUT.PUT_LINE('There are more than one employees with the name ' || V_NAME);
            DBMS_OUTPUT.PUT_LINE('Try with a different employee');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('An unexpected error happened. Connect with the programmer..');
            DBMS_OUTPUT.PUT_LINE(SQLCODE || ' ---> ' || SQLERRM);
    END;
    /
    
    --NON-PREDEFINED EXCEPTIONS
    BEGIN
        UPDATE EMPLOYEES_COPY
           SET EMAIL = NULL
         WHERE EMPLOYEE_ID = 100;
    END;
    /
    /********************* EXAMPLE 1 *********************/ -- HANDLING a nonpredefined exception
    DECLARE
        CANNOT_UPDATE_TO_NULL EXCEPTION;
        PRAGMA EXCEPTION_INIT ( CANNOT_UPDATE_TO_NULL, -01407 );
    BEGIN
        UPDATE EMPLOYEES_COPY
           SET EMAIL = NULL
         WHERE EMPLOYEE_ID = 100;
    EXCEPTION
        WHEN CANNOT_UPDATE_TO_NULL THEN
            DBMS_OUTPUT.PUT_LINE('You cannot update with a null value!');
    END;
    /
    
    
    --HANDLING & RAISING USER-DEFINED EXCEPTIONS
    /*************** Creating a User defined Exception *****************/
   DECLARE
        TOO_HIGH_SALARY EXCEPTION;
        V_SALARY_CHECK PLS_INTEGER;
    BEGIN
        SELECT SALARY
          INTO V_SALARY_CHECK
          FROM EMPLOYEES
         WHERE EMPLOYEE_ID = 100;
    
        IF V_SALARY_CHECK > 20000 THEN
            RAISE TOO_HIGH_SALARY;
        END IF;
        --we do our business if the salary is under 2000
        DBMS_OUTPUT.PUT_LINE('The salary is in an acceptable range');
    EXCEPTION
        WHEN TOO_HIGH_SALARY THEN
            DBMS_OUTPUT.PUT_LINE('This salary is too high. You need to decrease it.');
    END;
    /
    /**************** Raising a Predefined Exception *******************/
    DECLARE
        TOO_HIGH_SALARY EXCEPTION;
        V_SALARY_CHECK PLS_INTEGER;
    BEGIN
        SELECT SALARY
          INTO V_SALARY_CHECK
          FROM EMPLOYEES
         WHERE EMPLOYEE_ID = 100;
    
        IF V_SALARY_CHECK > 20000 THEN
            RAISE INVALID_NUMBER;
        END IF;
        --we do our business if the salary is under 2000
        DBMS_OUTPUT.PUT_LINE('The salary is in an acceptable range');
    EXCEPTION
        WHEN INVALID_NUMBER THEN
            DBMS_OUTPUT.PUT_LINE('This salary is too high. You need to decrease it.');
    END;
    /
    /****************** Raising Inside of the Exception ****************/
    DECLARE
        TOO_HIGH_SALARY EXCEPTION;
        V_SALARY_CHECK PLS_INTEGER;
    BEGIN
        SELECT SALARY
          INTO V_SALARY_CHECK
          FROM EMPLOYEES
         WHERE EMPLOYEE_ID = 100;
    
        IF V_SALARY_CHECK > 20000 THEN
            RAISE INVALID_NUMBER;
        END IF;
        --we do our business if the salary is under 2000
        DBMS_OUTPUT.PUT_LINE('The salary is in an acceptable range');
    EXCEPTION
        WHEN INVALID_NUMBER THEN
            DBMS_OUTPUT.PUT_LINE('This salary is too high. You need to decrease it.');
            RAISE;
    END;
    /
    
    --RAISE_APPLICATION_ERROR PROCEDURE
    /********************* EXAMPLE 1 *********************/
    DECLARE
        TOO_HIGH_SALARY EXCEPTION;
        V_SALARY_CHECK PLS_INTEGER;
    BEGIN
        SELECT SALARY
          INTO V_SALARY_CHECK
          FROM EMPLOYEES
         WHERE EMPLOYEE_ID = 100;
    
        IF V_SALARY_CHECK > 20000 THEN
        --raise too_high_salary;
            RAISE_APPLICATION_ERROR(-20243, 'The salary of the selected employee is too high!');
        END IF;
        --we do our business if the salary is under 2000
        DBMS_OUTPUT.PUT_LINE('The salary is in an acceptable range');
    EXCEPTION
        WHEN TOO_HIGH_SALARY THEN
            DBMS_OUTPUT.PUT_LINE('This salary is too high. You need to decrease it.');
    END;
    /
    /********************* EXAMPLE 2 *********************/ -- raise inside of the exception section
    DECLARE
        TOO_HIGH_SALARY EXCEPTION;
        V_SALARY_CHECK PLS_INTEGER;
    BEGIN
        SELECT SALARY
              INTO V_SALARY_CHECK
              FROM EMPLOYEES
             WHERE EMPLOYEE_ID = 100;
    
        IF V_SALARY_CHECK > 20000 THEN
            RAISE TOO_HIGH_SALARY;
        END IF;
        --we do our business if the salary is under 2000
        DBMS_OUTPUT.PUT_LINE('The salary is in an acceptable range');
    EXCEPTION
        WHEN TOO_HIGH_SALARY THEN
            DBMS_OUTPUT.PUT_LINE('This salary is too high. You need to decrease it.');
            RAISE_APPLICATION_ERROR(-01403, 'The salary of the selected employee is too high!', TRUE);
    END;
    /   