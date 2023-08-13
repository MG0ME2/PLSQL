--COMPOSITE DATA TYPES
	--PL/SQL RECORDS
    SET SERVEROUTPUT ON;
    /************************ Example 1 *************************/
    DECLARE        
        R_EMP EMPLOYEES%ROWTYPE;
    BEGIN
        SELECT *
          INTO R_EMP  
          FROM EMPLOYEES 
         WHERE EMPLOYEE_ID = 101;
        --R_EMP.SALARY := 2000;
        DBMS_OUTPUT.PUT_LINE(R_EMP.FIRST_NAME || ' ' || R_EMP.LAST_NAME || ' EARNS ' || R_EMP.SALARY || ' AND HIRED AT: ' || R_EMP.HIRE_DATE);
    END;
    /
    /************************ Example 2 *************************/
    DECLARE        
        TYPE T_EMP IS RECORD (FIRST_NAME VARCHAR2(50),
                              LAST_NAME  EMPLOYEES.LAST_NAME%TYPE,
                              SALARY     EMPLOYEES.SALARY%TYPE,
                              HIRE_DATE  DATE);
        R_EMP T_EMP;
    BEGIN        
        R_EMP.FIRST_NAME    := 'MIGUEL';
        R_EMP.LAST_NAME     := 'GOMEZ';
        R_EMP.SALARY        := 2000;
        R_EMP.HIRE_DATE     := SYSDATE;
        
        DBMS_OUTPUT.PUT_LINE(R_EMP.FIRST_NAME || ' ' || R_EMP.LAST_NAME || ' EARNS ' || R_EMP.SALARY || ' AND HIRED AT: ' || R_EMP.HIRE_DATE);
    END;
    /
    /************************ Example 3 *************************/
    DECLARE        
        TYPE T_EMP IS RECORD (FIRST_NAME VARCHAR2(50),
                              LAST_NAME  EMPLOYEES.LAST_NAME%TYPE,
                              SALARY     EMPLOYEES.SALARY%TYPE,
                              HIRE_DATE  DATE);
        R_EMP T_EMP;
    BEGIN
        SELECT FIRST_NAME
              ,LAST_NAME
              ,SALARY
              ,HIRE_DATE
          INTO R_EMP  
          FROM EMPLOYEES 
         WHERE EMPLOYEE_ID = 101;        
        DBMS_OUTPUT.PUT_LINE(R_EMP.FIRST_NAME || ' ' || R_EMP.LAST_NAME || ' EARNS ' || R_EMP.SALARY || ' AND HIRED AT: ' || R_EMP.HIRE_DATE);
    END;
    /
    /************************ Example 4 *************************/
    DECLARE        
        TYPE T_EDU IS RECORD(PRIMARY_SCHOOL    VARCHAR2(100),
                             HIGH_SCHOOL       VARCHAR2(100),
                             UNIVERSITY        VARCHAR2(100),
                             UNI_GRADUATE_DATE DATE
                            );
                            
        TYPE T_EMP IS RECORD(FIRST_NAME       VARCHAR2(50),
                             LAST_NAME        EMPLOYEES.LAST_NAME%TYPE,
                             SALARY           EMPLOYEES.SALARY%TYPE  NOT NULL DEFAULT 1000,
                             HIRE_DATE        DATE,
                             DEPT_ID          EMPLOYEES.DEPARTMENT_ID%TYPE,
                             DEPARTMENT       DEPARTMENTS%ROWTYPE,
                             EDUCATION        T_EDU
                            );
        
        R_EMP T_EMP;
    BEGIN
        SELECT FIRST_NAME, LAST_NAME, SALARY, HIRE_DATE, DEPARTMENT_ID 
          INTO R_EMP.FIRST_NAME, R_EMP.LAST_NAME, R_EMP.SALARY, R_EMP.HIRE_DATE, R_EMP.DEPT_ID 
          FROM EMPLOYEES
         WHERE EMPLOYEE_ID = '146';
  
        SELECT * 
          INTO R_EMP.DEPARTMENT 
          FROM DEPARTMENTS 
         WHERE DEPARTMENT_ID = R_EMP.DEPT_ID;
         
        R_EMP.EDUCATION.HIGH_SCHOOL       := 'Beverly Hills';
        R_EMP.EDUCATION.UNIVERSITY        := 'Oxford';
        R_EMP.EDUCATION.UNI_GRADUATE_DATE := SYSDATE;
        
        DBMS_OUTPUT.PUT_LINE(R_EMP.FIRST_NAME || ' '                || 
                             R_EMP.LAST_NAME  || ' earns '          || 
                             R_EMP.SALARY     || ' and hired at : ' ||
                             R_EMP.HIRE_DATE);
                             
        DBMS_OUTPUT.PUT_LINE('She graduated from '        || 
                              R_EMP.EDUCATION.UNIVERSITY  || 
                              ' at '                      ||  
                              R_EMP.EDUCATION.UNI_GRADUATE_DATE);
                               
        DBMS_OUTPUT.PUT_LINE('Her Department Name is : '|| R_EMP.DEPARTMENT.DEPARTMENT_NAME);
    END;
    /
    
    --EASY DML WITH RECORDS
    /************************************************************/
    CREATE TABLE RETIRED_EMPLOYEES AS SELECT * FROM EMPLOYEES WHERE 1=2;
     
    SELECT * FROM RETIRED_EMPLOYEES;
    
    /
    /************************ Example 1 *************************/
    DECLARE
        R_EMP EMPLOYEES%ROWTYPE;
    BEGIN
        SELECT * 
          INTO R_EMP 
          FROM EMPLOYEES 
         WHERE EMPLOYEE_ID = 104;
        
        R_EMP.SALARY         := 0;
        R_EMP.COMMISSION_PCT := 0;
        
        INSERT INTO RETIRED_EMPLOYEES VALUES R_EMP;
    END;
    /
    /************************ Example 2 *************************/
    DECLARE
        R_EMP EMPLOYEES%ROWTYPE;
    BEGIN
        SELECT * 
          INTO R_EMP 
          FROM EMPLOYEES 
         WHERE EMPLOYEE_ID = 104;
     
        R_EMP.SALARY         := 10;
        R_EMP.COMMISSION_PCT := 0;
     
        --insert into retired_employees values r_emp;
        UPDATE RETIRED_EMPLOYEES 
           SET ROW = R_EMP 
         WHERE EMPLOYEE_ID = 104;
    END;
    /
    DELETE FROM RETIRED_EMPLOYEES;
    
    --COLLECTIONS		
		--VARRAYs
        /**************** A Simple Working Example ******************/
        DECLARE
            TYPE E_LIST IS VARRAY(5) OF VARCHAR2(50);
            EMPLOYEES E_LIST;
        BEGIN
            EMPLOYEES := E_LIST('Alex','Bruce','John','Bob','Richard');
            FOR I IN 1..5 LOOP
                DBMS_OUTPUT.PUT_LINE(EMPLOYEES(I));
            END LOOP;
        END;
        /
        /************** Limit Exceeding Error Example ***************/
        DECLARE
            TYPE E_LIST IS VARRAY(4) OF VARCHAR2(50);
            EMPLOYEES E_LIST;
        BEGIN
            EMPLOYEES := E_LIST('Alex','Bruce','John','Bob','Richard');
            FOR I IN 1..5 LOOP
                DBMS_OUTPUT.PUT_LINE(EMPLOYEES(I));
            END LOOP;
        END;
        /
        /*********** Subscript Beyond Count Error Example ***********/
        DECLARE
            TYPE E_LIST IS VARRAY(5) OF VARCHAR2(50);
            EMPLOYEES E_LIST;
        BEGIN
            EMPLOYEES := E_LIST('Alex','Bruce','John','Bob');
            FOR I IN 1..5 LOOP
                DBMS_OUTPUT.PUT_LINE(EMPLOYEES(I));
            END LOOP;
        END;
        /
        /**************** A Working count() Example *****************/
        DECLARE
            TYPE E_LIST IS VARRAY(5) OF VARCHAR2(50);
            EMPLOYEES E_LIST;
        BEGIN
            EMPLOYEES := E_LIST('Alex','Bruce','John','Bob');
            FOR I IN 1..EMPLOYEES.COUNT() LOOP
                DBMS_OUTPUT.PUT_LINE(EMPLOYEES(I));
            END LOOP;
        END;
        /
        /************ A Working first() last() Example **************/
        DECLARE
            TYPE E_LIST IS VARRAY(5) OF VARCHAR2(50);
            EMPLOYEES E_LIST;
        BEGIN
            EMPLOYEES := E_LIST('Alex','Bruce','John','Bob');
            FOR I IN EMPLOYEES.FIRST()..EMPLOYEES.LAST() LOOP
                DBMS_OUTPUT.PUT_LINE(EMPLOYEES(I));
            END LOOP;
        END;
        /
        /*************** A Working exists() Example *****************/
        DECLARE
            TYPE E_LIST IS VARRAY(5) OF VARCHAR2(50);
            EMPLOYEES E_LIST;
        BEGIN
            EMPLOYEES := E_LIST('Alex','Bruce','John','Bob');
            FOR I IN 1..5 LOOP
                IF EMPLOYEES.EXISTS(I) THEN
                    DBMS_OUTPUT.PUT_LINE(EMPLOYEES(I));
                END IF;
            END LOOP;
        END;
        /
        /**************** A Working limit() Example *****************/
        DECLARE
            TYPE E_LIST IS VARRAY(5) OF VARCHAR2(50);
            EMPLOYEES E_LIST;
        BEGIN
            EMPLOYEES := E_LIST('Alex','Bruce','John','Bob');
            DBMS_OUTPUT.PUT_LINE(EMPLOYEES.LIMIT());
        END;
        /
        /****** A Create-Declare at the Same Time Error Example *****/
        DECLARE
            TYPE E_LIST IS VARRAY(5) OF VARCHAR2(50);
            EMPLOYEES E_LIST('Alex','Bruce','John','Bob');
        BEGIN
            --employees := e_list('Alex','Bruce','John','Bob');
            FOR I IN 1..5 LOOP
                IF EMPLOYEES.EXISTS(I) THEN
                    DBMS_OUTPUT.PUT_LINE(EMPLOYEES(I));
                END IF;
            END LOOP;
        END;
        /
        /************** A Post Insert Varray Example ****************/
        DECLARE
            TYPE E_LIST IS VARRAY(15) OF VARCHAR2(50);
            EMPLOYEES E_LIST := E_LIST();
            IDX NUMBER := 1;
        BEGIN
            FOR I IN 100..110 LOOP
                EMPLOYEES.EXTEND;
                
                SELECT FIRST_NAME 
                  INTO EMPLOYEES(IDX) 
                  FROM EMPLOYEES 
                 WHERE EMPLOYEE_ID = I;
                 
                IDX := IDX + 1;
            END LOOP;
            
            FOR X IN 1..EMPLOYEES.COUNT() LOOP
                DBMS_OUTPUT.PUT_LINE(EMPLOYEES(X));
            END LOOP;
        END;
        /
        /******* An Example for the Schema-Level Varray Types *******/
        CREATE TYPE E_LIST IS VARRAY(15) OF VARCHAR2(50);
        /
        CREATE OR REPLACE TYPE E_LIST AS VARRAY(20) OF VARCHAR2(100);
        /
        DECLARE
            EMPLOYEES E_LIST := E_LIST();
            IDX       NUMBER := 1;
        BEGIN
            FOR I IN 100..110 LOOP
                EMPLOYEES.EXTEND;
                
                SELECT FIRST_NAME 
                  INTO EMPLOYEES(IDX) 
                  FROM EMPLOYEES 
                 WHERE EMPLOYEE_ID = I;
                 
                IDX := IDX + 1;
            END LOOP;
          
            FOR X IN 1..EMPLOYEES.COUNT() LOOP
                DBMS_OUTPUT.PUT_LINE(EMPLOYEES(X));
            END LOOP;
        END;
        /
        DROP TYPE E_LIST;
        
        --NESTED TABLES
        /*********** The Simple Usage of Nested Tables **************/
        DECLARE
            TYPE E_LIST IS TABLE OF VARCHAR2(50);
            EMPS E_LIST;
        BEGIN
            EMPS := E_LIST('Alex','Bruce','John');
            FOR I IN 1..EMPS.COUNT() LOOP
                DBMS_OUTPUT.PUT_LINE(EMPS(I));
            END LOOP;
        END;
        /
        /************************************************************
        Adding a New Value to a Nested Table After the Initialization
        *************************************************************/
        DECLARE
            TYPE E_LIST IS TABLE OF VARCHAR2(50);
            EMPS E_LIST;
        BEGIN
            EMPS := E_LIST('Alex','Bruce','John');
            EMPS.EXTEND;
            EMPS(4) := 'Bob';
            FOR I IN 1..EMPS.COUNT() LOOP
                DBMS_OUTPUT.PUT_LINE(EMPS(I));
            END LOOP;
        END;
        /
        /*************** Adding Values From a Table *****************/
        DECLARE
            TYPE E_LIST IS TABLE OF EMPLOYEES.FIRST_NAME%TYPE;
            EMPS E_LIST := E_LIST();
            IDX  PLS_INTEGER:= 1;
        BEGIN
            FOR X IN 100 .. 110 LOOP
                EMPS.EXTEND;
                SELECT FIRST_NAME INTO EMPS(IDX) 
                  FROM EMPLOYEES 
                 WHERE EMPLOYEE_ID = X;
                IDX := IDX + 1;
          END LOOP;
          FOR I IN 1..EMPS.COUNT() LOOP
            DBMS_OUTPUT.PUT_LINE(EMPS(I));
          END LOOP;
        END;
        /
        /********************* Delete Example ***********************/
        DECLARE
            TYPE E_LIST IS TABLE OF EMPLOYEES.FIRST_NAME%TYPE;
            EMPS E_LIST := E_LIST();
            IDX  PLS_INTEGER := 1;
        BEGIN
            FOR X IN 100 .. 110 LOOP
                EMPS.EXTEND;
                SELECT FIRST_NAME INTO EMPS(IDX) 
                  FROM EMPLOYEES 
                 WHERE EMPLOYEE_ID = X;
                IDX := IDX + 1;
            END LOOP;
            EMPS.DELETE(3);
            FOR I IN 1..EMPS.COUNT() LOOP
                IF EMPS.EXISTS(I) THEN 
                    DBMS_OUTPUT.PUT_LINE(EMPS(I));
                END IF;
            END LOOP;
        END;
        /
        
        --ASSOCIATYVE ARRAYs
        /********************* The First Example ********************/
        DECLARE
            TYPE e_list IS TABLE OF employees.first_name%TYPE INDEX BY PLS_INTEGER;
            emps e_list;
        BEGIN
            FOR x IN 100 .. 110 LOOP
                SELECT first_name 
                  INTO emps(x) 
                  FROM employees 
                 WHERE employee_id = x ;
            END LOOP;
            FOR i IN emps.first()..emps.last() LOOP
                dbms_output.put_line(emps(i));
            END LOOP; 
        END;
        /
        /********* Error Example for the SELECT INTO Clause *********/
        DECLARE
            TYPE e_list IS TABLE OF employees.first_name%TYPE INDEX BY PLS_INTEGER;
            emps e_list;
        BEGIN
            FOR x IN 100 .. 110 LOOP
                SELECT first_name 
                  INTO emps(x) 
                  FROM employees 
                 WHERE employee_id   = x 
                   AND department_id = 60;
            END LOOP;
            FOR i IN emps.first()..emps.last() LOOP
                dbms_output.put_line(i);
            END LOOP; 
        END;
         
        /******* Error Example about Reaching an Empty Index ********/
        DECLARE
            TYPE e_list IS TABLE OF employees.first_name%TYPE INDEX BY PLS_INTEGER;
            emps e_list;
        BEGIN
            emps(100) := 'Bob';
            emps(120) := 'Sue';
            FOR i IN emps.first()..emps.last() LOOP
                dbms_output.put_line(emps(i));
            END LOOP; 
        END;
        /
        /*************************************************************
        An Example of Iterating in Associative Arrays with WHILE LOOPs
        *************************************************************/
        DECLARE
            TYPE e_list IS TABLE OF employees.first_name%TYPE INDEX BY PLS_INTEGER;
            emps e_list;
            idx  PLS_INTEGER;
        BEGIN
            emps(100) := 'Bob';
            emps(120) := 'Sue';
            idx       := emps.first;
         
            WHILE idx IS NOT NULL LOOP 
                dbms_output.put_line(emps(idx));
                idx := emps.next(idx);
            END LOOP; 
        END;
        /
        /*************************************************************
        An Example of Using String-based Indexes with Associative Arrays
        *************************************************************/
        DECLARE
            TYPE e_list IS TABLE OF employees.first_name%TYPE INDEX BY employees.email%type;
            emps         e_list;
            idx          employees.email%TYPE;
            v_email      employees.email%TYPE;
            v_first_name employees.first_name%TYPE;
        BEGIN
            FOR x IN 100 .. 110 LOOP
                SELECT first_name, email 
                  INTO v_first_name, v_email 
                  FROM employees
                 WHERE employee_id = x;
                emps(v_email) := v_first_name;
            END LOOP;
            
            idx := emps.first;
            
            WHILE idx IS NOT NULL LOOP 
                dbms_output.put_line('The email of '|| emps(idx) ||' is : '|| idx);
                idx := emps.next(idx);
            END LOOP; 
        END;
        /
        /*** An Example of Using Associative Arrays with Records ****/
        DECLARE
            TYPE e_list IS TABLE OF employees%rowtype INDEX BY employees.email%TYPE;
            emps e_list;
            idx  employees.email%type;
        BEGIN
            FOR x IN 100 .. 110 LOOP
                SELECT * 
                  INTO emps(x) 
                  FROM employees
                 WHERE employee_id = x;
            END LOOP;
         
            idx := emps.first;
          
            WHILE idx IS NOT NULL LOOP 
                dbms_output.put_line('The email of '       || 
                                      emps(idx).first_name || ' '     ||
                                      emps(idx).last_name  || ' is : '|| emps(idx).email);
                idx := emps.next(idx);
            END LOOP; 
        END;
        /
        /* An Example of Using Associative Arrays with Record Types */
        DECLARE
            TYPE e_type IS RECORD (first_name employees.first_name%TYPE,
                                   last_name  employees.last_name%TYPE,
                                   email      employees.email%TYPE);
            TYPE e_list IS TABLE OF e_type INDEX BY employees.email%TYPE;
            emps e_list;
            idx  employees.email%type;
        BEGIN
            FOR x IN 100 .. 110 LOOP
                SELECT first_name,last_name,email 
                  INTO emps(x) 
                  FROM employees
                 WHERE employee_id = x;
            END LOOP;
         
            idx := emps.first;
         
            WHILE idx IS NOT NULL LOOP
                dbms_output.put_line('The email of '       || 
                                      emps(idx).first_name || ' ' ||
                                      emps(idx).last_name  || ' is : ' || 
                                      emps(idx).email);
                idx := emps.next(idx);
            END LOOP; 
        END;
        /
        /**** An Example of Printing From the Last to the First *****/
        DECLARE
            TYPE e_type IS RECORD (first_name employees.first_name%TYPE,
                                   last_name  employees.last_name%TYPE,
                                   email      employees.email%TYPE);
            TYPE e_list IS TABLE OF e_type INDEX BY employees.email%TYPE;
            emps e_list;
            idx  employees.email%type;
        BEGIN
            FOR x IN 100 .. 110 LOOP
                SELECT first_name,last_name, email 
                  INTO emps(x) 
                  FROM employees
                 WHERE employee_id = x;
            END LOOP;
          
            --emps.delete(100,104);
            idx := emps.last;
          
            WHILE idx IS NOT NULL LOOP 
                dbms_output.put_line('The email of '       || 
                                      emps(idx).first_name || ' '     ||
                                      emps(idx).last_name  ||' is : ' || 
                                      emps(idx).email);
                idx := emps.prior(idx);
            END LOOP; 
        END;
        /
        /***** An Example of Inserting with Associative Arrays ******/
        CREATE TABLE employees_salary_history 
        AS SELECT * FROM employees WHERE 1=2;
         
        ALTER TABLE employees_salary_history ADD insert_date DATE;
         
        SELECT * FROM employees_salary_history;
        /
        DECLARE
            TYPE e_list IS TABLE OF employees_salary_history%rowtype INDEX BY PLS_INTEGER;
            emps e_list;
            idx  PLS_INTEGER;
        BEGIN
            FOR x IN 100 .. 110 LOOP
                SELECT e.*,'01-JUN-20' 
                  INTO emps(x) 
                  FROM employees e
                 WHERE employee_id = x;
            END LOOP;
          
            idx := emps.first;
          
            WHILE idx IS NOT NULL LOOP 
                emps(idx).salary := emps(idx).salary + emps(idx).salary*0.2;
                INSERT INTO employees_salary_history VALUES emps(idx);
                dbms_output.put_line('The employee '       || emps(idx).first_name ||
                                     ' is inserted to the history table');
                idx := emps.next(idx);
            END LOOP; 
        END;
        /
        DROP TABLE employees_salary_history;
        
        
        -- STORING COLLECTIONS IN TABLES
        /***************** Storing Varray Example *******************/
        CREATE OR REPLACE TYPE t_phone_number AS OBJECT(p_type   VARCHAR2(10), 
                                                        p_number VARCHAR2(50)
                                                       );
        /
        CREATE OR REPLACE TYPE v_phone_numbers AS VARRAY(3) OF t_phone_number;
        /
        CREATE TABLE emps_with_phones(employee_id  NUMBER,
                                      first_name   VARCHAR2(50),
                                      last_name    VARCHAR2(50),
                                      phone_number v_phone_numbers);
        /
        SELECT * FROM emps_with_phones;
        /
        INSERT INTO emps_with_phones
        VALUES(10,'Alex','Brown',v_phone_numbers(t_phone_number('HOME','111.111.1111'),
                                                 t_phone_number('WORK','222.222.2222'),
                                                 t_phone_number('MOBILE','333.333.3333'))
                                                 );
        INSERT INTO emps_with_phones
        VALUES(11,'Bob','Green',v_phone_numbers(t_phone_number('HOME','000.000.000'),
                                                 t_phone_number('WORK','444.444.4444'))
                                                 );                 
        /*************** Querying the Varray Example ****************/
        SELECT e.first_name,
               last_name,
               p.p_type,
               p.p_number 
        FROM emps_with_phones e, table(e.phone_number) p;         
        /
        
        /****** The Code For the Storing Nested Table Example *******/
        CREATE OR REPLACE TYPE n_phone_numbers AS TABLE OF t_phone_number;
        /
        CREATE TABLE emps_with_phones2(employee_id  NUMBER,
                                       first_name   VARCHAR2(50),
                                       last_name    VARCHAR2(50),
                                       phone_number n_phone_numbers)
                                       NESTED TABLE phone_number STORE AS phone_numbers_table;
        /
        SELECT * FROM emps_with_phones2;
        /
        INSERT INTO emps_with_phones2 
        VALUES(10,'Alex','Brown',n_phone_numbers(t_phone_number('HOME','111.111.1111'),
                                                 t_phone_number('WORK','222.222.2222'),
                                                 t_phone_number('MOBILE','333.333.3333'))
                                                 );
        INSERT INTO emps_with_phones2
        VALUES(11,'Bob','Green',n_phone_numbers(t_phone_number('HOME','000.000.000'),
                                                t_phone_number('WORK','444.444.4444'))
                                                );      
        /
        SELECT e.first_name, last_name, p.p_type, p.p_number 
          FROM emps_with_phones2 e, table(e.phone_number) p;         
        /***************** New Insert and Update ********************/
        INSERT INTO emps_with_phones2 
        VALUES(11,'Bob','Green',n_phone_numbers(t_phone_number('HOME','000.000.000'),
                                                t_phone_number('WORK','444.444.4444'),
                                                t_phone_number('WORK2','444.444.4444'),
                                                t_phone_number('WORK3','444.444.4444'),
                                                t_phone_number('WORK4','444.444.4444'),
                                                t_phone_number('WORK5','444.444.4444'))
                                                );    
        SELECT * FROM emps_with_phones2;
         
        UPDATE emps_with_phones2 
           SET phone_number = n_phone_numbers(t_phone_number('HOME','000.000.000'),
                                              t_phone_number('WORK','444.444.4444'),
                                              t_phone_number('WORK2','444.444.4444'),
                                              t_phone_number('WORK3','444.444.4444'),
                                              t_phone_number('WORK4','444.444.4444'),
                                              t_phone_number('WORK5','444.444.4444'))
         WHERE employee_id = 11;
        /
        
        /**** Adding a New Value into a Nested Inside of a Table ****/
        DECLARE
            p_num n_phone_numbers;
        BEGIN
            SELECT phone_number 
              INTO p_num 
              FROM emps_with_phones2 
             WHERE employee_id = 10;
          
            p_num.extend;
            p_num(5) := t_phone_number('FAX','999.99.9999');
          
            UPDATE emps_with_phones2 
               SET phone_number = p_num
             WHERE  employee_id  = 10;
        END;
        
        
        