--PL/SQL CURSORS
    SET SERVEROUTPUT ON;
    --EXPLICITOS
     /********************* EXAMPLE 1 *********************/
    DECLARE
        CURSOR C_EMPS IS SELECT FIRST_NAME,LAST_NAME FROM EMPLOYEES;
        V_FIRST_NAME EMPLOYEES.FIRST_NAME%TYPE;
        V_LAST_NAME EMPLOYEES.LAST_NAME%TYPE;
    BEGIN
        OPEN C_EMPS;
        FETCH C_EMPS INTO V_FIRST_NAME,V_LAST_NAME;
        FETCH C_EMPS INTO V_FIRST_NAME,V_LAST_NAME;
        FETCH C_EMPS INTO V_FIRST_NAME,V_LAST_NAME;
        DBMS_OUTPUT.PUT_LINE(V_FIRST_NAME|| ' ' || V_LAST_NAME);
        FETCH C_EMPS INTO V_FIRST_NAME,V_LAST_NAME;
        DBMS_OUTPUT.PUT_LINE(V_FIRST_NAME|| ' ' || V_LAST_NAME);
        CLOSE C_EMPS;
    END;
    /
    /********************* EXAMPLE 2 *********************/
    DECLARE
        CURSOR C_EMPS IS
            SELECT FIRST_NAME,LAST_NAME, DEPARTMENT_NAME FROM EMPLOYEES
              JOIN DEPARTMENTS USING (DEPARTMENT_ID)
             WHERE DEPARTMENT_ID BETWEEN 30 AND 60;

        V_FIRST_NAME EMPLOYEES.FIRST_NAME%TYPE;
        V_LAST_NAME EMPLOYEES.LAST_NAME%TYPE;
        V_DEPARTMENT_NAME DEPARTMENTS.DEPARTMENT_NAME%TYPE;
    BEGIN
        OPEN C_EMPS;
        FETCH C_EMPS INTO V_FIRST_NAME, V_LAST_NAME,V_DEPARTMENT_NAME;
        DBMS_OUTPUT.PUT_LINE(V_FIRST_NAME|| ' ' || V_LAST_NAME|| ' in the department of '|| V_DEPARTMENT_NAME);
        CLOSE C_EMPS;
    END;
    /
    
    --USING CURSORS WITH RECORDS
    /********************* EXAMPLE 1 *********************/
    DECLARE
        TYPE R_EMP IS RECORD ( V_FIRST_NAME EMPLOYEES.FIRST_NAME%TYPE,
                               V_LAST_NAME EMPLOYEES.LAST_NAME%TYPE);
        V_EMP R_EMP;
        CURSOR C_EMPS IS SELECT FIRST_NAME,LAST_NAME FROM EMPLOYEES;
    BEGIN
        OPEN C_EMPS;
        FETCH C_EMPS INTO V_EMP;
        DBMS_OUTPUT.PUT_LINE(V_EMP.V_FIRST_NAME|| ' ' || V_EMP.V_LAST_NAME);
        CLOSE C_EMPS;
    END;
    /
    /********************* EXAMPLE 2 *********************/ -- An example for using cursors table rowtype
    DECLARE
        V_EMP EMPLOYEES%ROWTYPE;
        CURSOR C_EMPS IS SELECT FIRST_NAME,LAST_NAME FROM EMPLOYEES;
    BEGIN
        OPEN C_EMPS;
        FETCH C_EMPS INTO V_EMP.FIRST_NAME,V_EMP.LAST_NAME;
        DBMS_OUTPUT.PUT_LINE(V_EMP.FIRST_NAME|| ' ' || V_EMP.LAST_NAME);
        CLOSE C_EMPS;
    END;
    /
    /********************* EXAMPLE 3 *********************/ -- An example for using cursors with cursor%rowtype.
    DECLARE
        CURSOR C_EMPS IS SELECT FIRST_NAME,LAST_NAME FROM EMPLOYEES;
        V_EMP C_EMPS%ROWTYPE;
    BEGIN
        OPEN C_EMPS;
        FETCH C_EMPS INTO V_EMP.FIRST_NAME,V_EMP.LAST_NAME;
        DBMS_OUTPUT.PUT_LINE(V_EMP.FIRST_NAME|| ' ' || V_EMP.LAST_NAME);
        CLOSE C_EMPS;
    END;
    /
    
    --LOOPING WITH CURSORS
    /********************* EXAMPLE 1 *********************/
    DECLARE
        CURSOR C_EMPS IS SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID = 30;
        V_EMPS C_EMPS%ROWTYPE;
    BEGIN
        OPEN C_EMPS;
        LOOP
            FETCH C_EMPS INTO V_EMPS;
            DBMS_OUTPUT.PUT_LINE(V_EMPS.EMPLOYEE_ID|| ' ' ||V_EMPS.FIRST_NAME|| ' ' ||V_EMPS.LAST_NAME);
        END LOOP;
        CLOSE C_EMPS;
    END;
    /
    /********************* EXAMPLE 2 *********************/ --%notfound example
    DECLARE
        CURSOR C_EMPS IS SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID = 30;
        V_EMPS C_EMPS%ROWTYPE;
    BEGIN
        OPEN C_EMPS;
        LOOP
            FETCH C_EMPS INTO V_EMPS;
            EXIT WHEN C_EMPS%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE(V_EMPS.EMPLOYEE_ID|| ' ' ||V_EMPS.FIRST_NAME|| ' ' ||V_EMPS.LAST_NAME);
        END LOOP;
        CLOSE C_EMPS;
    END;
    /
    /********************* EXAMPLE 3 *********************/ --while loop example
    DECLARE
        CURSOR C_EMPS IS SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID = 30;
        V_EMPS C_EMPS%ROWTYPE;
    BEGIN
        OPEN C_EMPS;
        FETCH C_EMPS INTO V_EMPS;
        WHILE C_EMPS%FOUND LOOP
            DBMS_OUTPUT.PUT_LINE(V_EMPS.EMPLOYEE_ID|| ' ' ||V_EMPS.FIRST_NAME|| ' ' ||V_EMPS.LAST_NAME);
            FETCH C_EMPS INTO V_EMPS;
        END LOOP;
        CLOSE C_EMPS;
    END;
    /
    /********************* EXAMPLE 4 *********************/ --for loop with cursor example
    DECLARE
        CURSOR C_EMPS IS SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID = 30;
        V_EMPS C_EMPS%ROWTYPE;
    BEGIN
        OPEN C_EMPS;
        FOR I IN 1..6 LOOP
            FETCH C_EMPS INTO V_EMPS;
            DBMS_OUTPUT.PUT_LINE(V_EMPS.EMPLOYEE_ID|| ' ' ||V_EMPS.FIRST_NAME|| ' ' ||V_EMPS.LAST_NAME);
        END LOOP;
        CLOSE C_EMPS;
    END;
    /
    /********************* EXAMPLE 5 *********************/ --FOR..IN clause example
    DECLARE
        CURSOR C_EMPS IS SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID = 30;
    BEGIN
        FOR I IN C_EMPS LOOP
            DBMS_OUTPUT.PUT_LINE(I.EMPLOYEE_ID|| ' ' ||I.FIRST_NAME|| ' ' ||I.LAST_NAME);
        END LOOP;
    END;
    /
    /********************* EXAMPLE 6 *********************/ --FOR..IN with select example
    BEGIN
        FOR I IN (SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID = 30) LOOP
            DBMS_OUTPUT.PUT_LINE(I.EMPLOYEE_ID|| ' ' ||I.FIRST_NAME|| ' ' ||I.LAST_NAME);
        END LOOP;
    END;
    /
    
    --CURSORS WITH PARAMETERS
    /********************* EXAMPLE 1 *********************/ 
    DECLARE
        CURSOR C_EMPS (P_DEPT_ID NUMBER)
        IS 
            SELECT FIRST_NAME,LAST_NAME,DEPARTMENT_NAME
              FROM EMPLOYEES JOIN DEPARTMENTS USING (DEPARTMENT_ID)
             WHERE DEPARTMENT_ID = P_DEPT_ID;

        V_EMPS C_EMPS%ROWTYPE;
    BEGIN
        OPEN C_EMPS(20);
        FETCH C_EMPS INTO V_EMPS;
            DBMS_OUTPUT.PUT_LINE('The employees in department of '|| V_EMPS.DEPARTMENT_NAME|| ' are :');
        CLOSE C_EMPS;
        
        OPEN C_EMPS(20);
        LOOP
            FETCH C_EMPS INTO V_EMPS;
            EXIT WHEN C_EMPS%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE(V_EMPS.FIRST_NAME|| ' ' ||V_EMPS.LAST_NAME);
        END LOOP;
        CLOSE C_EMPS;
    END;
    /
    /********************* EXAMPLE 2 *********************/ -- bind variables as parameters
    DECLARE
        CURSOR C_EMPS (P_DEPT_ID NUMBER)
        IS
            SELECT FIRST_NAME,LAST_NAME,DEPARTMENT_NAME 
              FROM EMPLOYEES JOIN DEPARTMENTS USING (DEPARTMENT_ID)
             WHERE DEPARTMENT_ID = P_DEPT_ID;
             
        V_EMPS C_EMPS%ROWTYPE;
    BEGIN
        OPEN C_EMPS(:B_EMP);
        FETCH C_EMPS INTO V_EMPS;
            DBMS_OUTPUT.PUT_LINE('The employees in department of '|| V_EMPS.DEPARTMENT_NAME|| ' are :');
        CLOSE C_EMPS;
        
        OPEN C_EMPS(:B_EMP);
        LOOP
            FETCH C_EMPS INTO V_EMPS;
            EXIT WHEN C_EMPS%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE(V_EMPS.FIRST_NAME|| ' ' ||V_EMPS.LAST_NAME);
        END LOOP;
        CLOSE C_EMPS;
    END;
    /
    /********************* EXAMPLE 3 *********************/ --cursors with two different parameters
    DECLARE
        CURSOR C_EMPS (P_DEPT_ID NUMBER)
        IS
            SELECT FIRST_NAME,LAST_NAME,DEPARTMENT_NAME 
             FROM EMPLOYEES JOIN DEPARTMENTS USING (DEPARTMENT_ID)
            WHERE DEPARTMENT_ID = P_DEPT_ID;

        V_EMPS C_EMPS%ROWTYPE;
    BEGIN
        OPEN C_EMPS(:B_DEPT_ID);
        FETCH C_EMPS INTO V_EMPS;
            DBMS_OUTPUT.PUT_LINE('The employees in department of '|| V_EMPS.DEPARTMENT_NAME|| ' are :');
        CLOSE C_EMPS;
        
        OPEN C_EMPS(:B_DEPT_ID);
        LOOP
            FETCH C_EMPS INTO V_EMPS;
            EXIT WHEN C_EMPS%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE(V_EMPS.FIRST_NAME|| ' ' ||V_EMPS.LAST_NAME);
        END LOOP;
        CLOSE C_EMPS;
      
        OPEN C_EMPS(:B_DEPT_ID2);
        FETCH C_EMPS INTO V_EMPS;
            DBMS_OUTPUT.PUT_LINE('The employees in department of '|| V_EMPS.DEPARTMENT_NAME|| ' are :');
        CLOSE C_EMPS;
        
        OPEN C_EMPS(:B_DEPT_ID2);
        LOOP
            FETCH C_EMPS INTO V_EMPS;
            EXIT WHEN C_EMPS%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE(V_EMPS.FIRST_NAME|| ' ' ||V_EMPS.LAST_NAME);
        END LOOP;
        CLOSE C_EMPS;
    END;
    /
    /********************* EXAMPLE 4 *********************/ -- cursor with parameters - for in loops
    DECLARE
        CURSOR C_EMPS (P_DEPT_ID NUMBER)
        IS
            SELECT FIRST_NAME,LAST_NAME,DEPARTMENT_NAME 
              FROM EMPLOYEES JOIN DEPARTMENTS USING (DEPARTMENT_ID)
             WHERE DEPARTMENT_ID = P_DEPT_ID;
        
        V_EMPS C_EMPS%ROWTYPE;
    BEGIN
        OPEN C_EMPS(:B_DEPT_ID);
        FETCH C_EMPS INTO V_EMPS;
            DBMS_OUTPUT.PUT_LINE('The employees in department of '|| V_EMPS.DEPARTMENT_NAME|| ' are :');
        CLOSE C_EMPS;
        
        OPEN C_EMPS(:B_DEPT_ID);
        LOOP
            FETCH C_EMPS INTO V_EMPS;
            EXIT WHEN C_EMPS%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE(V_EMPS.FIRST_NAME|| ' ' ||V_EMPS.LAST_NAME);
        END LOOP;
        CLOSE C_EMPS;
      
        OPEN C_EMPS(:B_DEPT_ID2);
        FETCH C_EMPS INTO V_EMPS;
            DBMS_OUTPUT.PUT_LINE('The employees in department of '|| V_EMPS.DEPARTMENT_NAME|| ' are :');
        CLOSE C_EMPS;
        
        FOR I IN C_EMPS(:B_DEPT_ID2) LOOP
          DBMS_OUTPUT.PUT_LINE(I.FIRST_NAME|| ' ' ||I.LAST_NAME);
        END LOOP;
    END;
    /
    /********************* EXAMPLE 5 *********************/ --cursors with multiple parameters
    DECLARE
        CURSOR C_EMPS (P_DEPT_ID NUMBER , P_JOB_ID VARCHAR2)
        IS
            SELECT FIRST_NAME,LAST_NAME,JOB_ID,DEPARTMENT_NAME 
              FROM EMPLOYEES JOIN DEPARTMENTS USING (DEPARTMENT_ID)
             WHERE DEPARTMENT_ID = P_DEPT_ID
               AND JOB_ID = P_JOB_ID;
        
        V_EMPS C_EMPS%ROWTYPE;
    BEGIN
        FOR I IN C_EMPS(50,'ST_MAN') LOOP
          DBMS_OUTPUT.PUT_LINE(I.FIRST_NAME|| ' ' ||I.LAST_NAME|| ' - ' || I.JOB_ID);
        END LOOP;
        
        DBMS_OUTPUT.PUT_LINE(' - ');
        
        FOR I IN C_EMPS(80,'SA_MAN') LOOP
          DBMS_OUTPUT.PUT_LINE(I.FIRST_NAME|| ' ' ||I.LAST_NAME|| ' - ' || I.JOB_ID);
        END LOOP;
    END;
    /
    /********************* EXAMPLE 6 *********************/ -- An error example of using parameter name with the column name
    DECLARE
        CURSOR C_EMPS (P_DEPT_ID NUMBER , JOB_ID VARCHAR2)
        IS
            SELECT FIRST_NAME,LAST_NAME,JOB_ID,DEPARTMENT_NAME 
              FROM EMPLOYEES JOIN DEPARTMENTS USING (DEPARTMENT_ID)
             WHERE DEPARTMENT_ID = P_DEPT_ID
               AND JOB_ID = JOB_ID;
        
        V_EMPS C_EMPS%ROWTYPE;
    BEGIN
        FOR I IN C_EMPS(50,'ST_MAN') LOOP
          DBMS_OUTPUT.PUT_LINE(I.FIRST_NAME|| ' ' ||I.LAST_NAME|| ' - ' || I.JOB_ID);
        END LOOP;
        
        DBMS_OUTPUT.PUT_LINE(' - ');
        
        FOR I IN C_EMPS(80,'SA_MAN') LOOP
          DBMS_OUTPUT.PUT_LINE(I.FIRST_NAME|| ' ' ||I.LAST_NAME|| ' - ' || I.JOB_ID);
        END LOOP;
    END;
    /
    
    --CURSOR ATTRIBUTES
    DECLARE
        CURSOR C_EMPS IS SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID = 50;
        V_EMPS C_EMPS%ROWTYPE;
    BEGIN
        IF NOT C_EMPS%ISOPEN THEN
            OPEN C_EMPS;
            DBMS_OUTPUT.PUT_LINE('hello');
        END IF;
        
        DBMS_OUTPUT.PUT_LINE(C_EMPS%ROWCOUNT);
        FETCH C_EMPS INTO V_EMPS;
        DBMS_OUTPUT.PUT_LINE(C_EMPS%ROWCOUNT);
        DBMS_OUTPUT.PUT_LINE(C_EMPS%ROWCOUNT);
        FETCH C_EMPS INTO V_EMPS;
        DBMS_OUTPUT.PUT_LINE(C_EMPS%ROWCOUNT);
        CLOSE C_EMPS;
      
        OPEN C_EMPS;
        LOOP
            FETCH C_EMPS INTO V_EMPS;
            EXIT WHEN C_EMPS%NOTFOUND OR C_EMPS%ROWCOUNT>5;
            DBMS_OUTPUT.PUT_LINE(C_EMPS%ROWCOUNT|| ' ' ||V_EMPS.FIRST_NAME|| ' ' ||V_EMPS.LAST_NAME);
        END LOOP;
        CLOSE C_EMPS;
    END;
    /
    
    --FOR UPDATE CLAUSE
    --SE CREA CONEXION CON USER SYSTEM
    CREATE USER MY_USER IDENTIFIED BY 123;
    GRANT CREATE SESSION TO MY_USER;
    GRANT SELECT ANY TABLE TO MY_USER;
    GRANT UPDATE ON HR.EMPLOYEES_COPY TO MY_USER;
    GRANT UPDATE ON HR.DEPARTMENTS TO MY_USER;
    /
    /********************* EXAMPLE 1 *********************/
    UPDATE EMPLOYEES_COPY SET PHONE_NUMBER = '1' WHERE EMPLOYEE_ID = 100;
    
    DECLARE
        CURSOR C_EMPS 
        IS
            SELECT EMPLOYEE_ID,FIRST_NAME,LAST_NAME,DEPARTMENT_NAME
              FROM EMPLOYEES_COPY JOIN DEPARTMENTS USING (DEPARTMENT_ID)
             WHERE EMPLOYEE_ID IN (100,101,102)
               FOR UPDATE;
    BEGIN
      /* for r_emps in c_emps loop
        update employees_copy set phone_number = 3
         where employee_id = r_emps.employee_id; 
        end loop; */
        OPEN C_EMPS;
    END;
    /
    /********************* EXAMPLE 2 *********************/ -- example of wait with second
    DECLARE
        CURSOR C_EMPS 
        IS
            SELECT EMPLOYEE_ID,FIRST_NAME,LAST_NAME,DEPARTMENT_NAME
              FROM EMPLOYEES_COPY JOIN DEPARTMENTS USING (DEPARTMENT_ID)
             WHERE EMPLOYEE_ID IN (100,101,102)
               FOR UPDATE OF EMPLOYEES_COPY.PHONE_NUMBER, 
                             DEPARTMENTS.LOCATION_ID WAIT 5;
    BEGIN
      /* for r_emps in c_emps loop
        update employees_copy set phone_number = 3
         where employee_id = r_emps.employee_id; 
        end loop; */
        OPEN C_EMPS;
    END;
    /
    /********************* EXAMPLE 3 *********************/ --example of nowait
    DECLARE
        CURSOR C_EMPS
        IS
            SELECT EMPLOYEE_ID,FIRST_NAME,LAST_NAME,DEPARTMENT_NAME
              FROM EMPLOYEES_COPY JOIN DEPARTMENTS USING (DEPARTMENT_ID)
             WHERE EMPLOYEE_ID IN (100,101,102)
               FOR UPDATE OF EMPLOYEES_COPY.PHONE_NUMBER, 
                             DEPARTMENTS.LOCATION_ID NOWAIT;
    BEGIN
      /* for r_emps in c_emps loop
        update employees_copy set phone_number = 3
         where employee_id = r_emps.employee_id; 
        end loop; */
        OPEN C_EMPS;
    END;
    /
    
    --WHERE CURRENT OF CLAUSE
    /********************* EXAMPLE 1 *********************/
    DECLARE
        CURSOR C_EMPS
        IS
            SELECT *
              FROM EMPLOYEES 
             WHERE DEPARTMENT_ID = 30 FOR UPDATE;
    BEGIN
        FOR R_EMPS IN C_EMPS LOOP
            UPDATE EMPLOYEES SET SALARY = SALARY + 60
             WHERE CURRENT OF C_EMPS;
        END LOOP;  
    END;
    /
    /********************* EXAMPLE 2 *********************/ --Wrong example of using where current of clause
    DECLARE
        CURSOR C_EMPS
        IS 
            SELECT E.*
              FROM EMPLOYEES E, DEPARTMENTS D
             WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
               AND E.DEPARTMENT_ID = 30
               FOR UPDATE;
    BEGIN
        FOR R_EMPS IN C_EMPS LOOP
            UPDATE EMPLOYEES SET SALARY = SALARY + 60
             WHERE CURRENT OF C_EMPS;
        END LOOP;  
    END;
    /
    /********************* EXAMPLE 3 *********************/ --An example of using rowid like where current of clause
    DECLARE
        CURSOR C_EMPS
        IS
        SELECT E.ROWID,E.SALARY
          FROM EMPLOYEES E, DEPARTMENTS D
          WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
            AND E.DEPARTMENT_ID = 30
            FOR UPDATE;
    BEGIN
        FOR R_EMPS IN C_EMPS LOOP
            UPDATE EMPLOYEES SET SALARY = SALARY + 60
             WHERE ROWID = R_EMPS.ROWID;
        END LOOP;  
    END;
    /    
    
    --REF CURSOR - SYS_REFCURSOR  
    /********************* EXAMPLE 1 *********************/
    DECLARE
        TYPE T_EMPS IS REF CURSOR RETURN EMPLOYEES%ROWTYPE;
        RC_EMPS T_EMPS;
        R_EMPS  EMPLOYEES%ROWTYPE;
    BEGIN
        OPEN RC_EMPS FOR SELECT *
                           FROM EMPLOYEES;
    
        LOOP
            FETCH RC_EMPS INTO R_EMPS;
            EXIT WHEN RC_EMPS%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE(R_EMPS.FIRST_NAME|| ' ' || R_EMPS.LAST_NAME);
        END LOOP;
    
        CLOSE RC_EMPS;
    END;
    /
    /********************* EXAMPLE 2 *********************/ -- in two different queries
    DECLARE
        TYPE T_EMPS IS REF CURSOR RETURN EMPLOYEES%ROWTYPE;
        RC_EMPS T_EMPS;
        R_EMPS  EMPLOYEES%ROWTYPE;
    BEGIN
        OPEN RC_EMPS FOR SELECT *
                           FROM RETIRED_EMPLOYEES;
    
        LOOP
            FETCH RC_EMPS INTO R_EMPS;
            EXIT WHEN RC_EMPS%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE(R_EMPS.FIRST_NAME || ' ' || R_EMPS.LAST_NAME);
        END LOOP;
    
        CLOSE RC_EMPS;
        
        DBMS_OUTPUT.PUT_LINE('--------------');
        
        OPEN RC_EMPS FOR SELECT *
                           FROM EMPLOYEES;
                          WHERE JOB_ID = 'IT_PROG';
    
        LOOP
            FETCH RC_EMPS INTO R_EMPS;
            EXIT WHEN RC_EMPS%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE(R_EMPS.FIRST_NAME || ' ' || R_EMPS.LAST_NAME);
        END LOOP;
    
        CLOSE RC_EMPS;
    END;
    /
    /********************* EXAMPLE 3 *********************/ --Example of using with %type when declaring records first
    DECLARE
        R_EMPS  EMPLOYEES%ROWTYPE;
        TYPE T_EMPS IS REF CURSOR RETURN R_EMPS%TYPE;
        RC_EMPS T_EMPS;
         --type t_emps2 is ref cursor return rc_emps%rowtype;
    BEGIN
        OPEN RC_EMPS FOR SELECT *
                           FROM RETIRED_EMPLOYEES;
    
        LOOP
            FETCH RC_EMPS INTO R_EMPS;
            EXIT WHEN RC_EMPS%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE(R_EMPS.FIRST_NAME || ' ' || R_EMPS.LAST_NAME);
        END LOOP;
    
        CLOSE RC_EMPS;
        
        DBMS_OUTPUT.PUT_LINE('--------------');
        
        OPEN RC_EMPS FOR SELECT *
                           FROM EMPLOYEES
                          WHERE JOB_ID = 'IT_PROG';
    
        LOOP
            FETCH RC_EMPS INTO R_EMPS;
            EXIT WHEN RC_EMPS%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE(R_EMPS.FIRST_NAME || ' ' || R_EMPS.LAST_NAME);
        END LOOP;
    
        CLOSE RC_EMPS;
    END;
    /
    /********************* EXAMPLE 4 *********************/ --manually declared record type with cursors example
    DECLARE
        TYPE TY_EMPS IS RECORD (
                                E_ID            NUMBER,
                                FIRST_NAME      EMPLOYEES.FIRST_NAME%TYPE,
                                LAST_NAME       EMPLOYEES.LAST_NAME%TYPE,
                                DEPARTMENT_NAME DEPARTMENTS.DEPARTMENT_NAME%TYPE
                               );
        R_EMPS  TY_EMPS;
        TYPE T_EMPS IS REF CURSOR RETURN TY_EMPS;
        RC_EMPS T_EMPS;
    BEGIN
        OPEN RC_EMPS FOR SELECT EMPLOYEE_ID,
                                FIRST_NAME,
                                LAST_NAME,
                                DEPARTMENT_NAME
                           FROM EMPLOYEES
                           JOIN DEPARTMENTS USING ( DEPARTMENT_ID );
    
        LOOP
            FETCH RC_EMPS INTO R_EMPS;
            EXIT WHEN RC_EMPS%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE(R_EMPS.FIRST_NAME || ' ' || R_EMPS.LAST_NAME || ' is at the department of : ' || R_EMPS.DEPARTMENT_NAME);    
        END LOOP;
    
        CLOSE RC_EMPS;
    END;
    /
    /********************* EXAMPLE 5 *********************/ --first example of weak ref cursors
    DECLARE
        TYPE TY_EMPS IS RECORD (
                                E_ID            NUMBER,
                                FIRST_NAME      EMPLOYEES.FIRST_NAME%TYPE,
                                LAST_NAME       EMPLOYEES.LAST_NAME%TYPE,
                                DEPARTMENT_NAME DEPARTMENTS.DEPARTMENT_NAME%TYPE
                               );
        R_EMPS  TY_EMPS;
        TYPE T_EMPS IS REF CURSOR;
        RC_EMPS T_EMPS;
        Q       VARCHAR2(200);
    BEGIN
        Q := 'select employee_id,first_name,last_name,department_name 
                from employees 
                join departments using (department_id)';
                
        OPEN RC_EMPS FOR Q;
    
        LOOP
            FETCH RC_EMPS INTO R_EMPS;
            EXIT WHEN RC_EMPS%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE(R_EMPS.FIRST_NAME || ' ' || R_EMPS.LAST_NAME || ' is at the department of : ' || R_EMPS.DEPARTMENT_NAME);    
        END LOOP;
    
        CLOSE RC_EMPS;
    END;
    /
    /********************* EXAMPLE 6 *********************/ --bind variables with cursors example
    DECLARE
        TYPE TY_EMPS IS RECORD (
                                E_ID            NUMBER,
                                FIRST_NAME      EMPLOYEES.FIRST_NAME%TYPE,
                                LAST_NAME       EMPLOYEES.LAST_NAME%TYPE,
                                DEPARTMENT_NAME DEPARTMENTS.DEPARTMENT_NAME%TYPE
                               );
        R_EMPS  TY_EMPS;
        TYPE T_EMPS IS REF CURSOR;
        RC_EMPS T_EMPS;
        R_DEPTS DEPARTMENTS%ROWTYPE;
         --r t_emps%rowtype;
        Q       VARCHAR2(200);
    BEGIN
        Q := 'select employee_id,first_name,last_name,department_name 
                from employees
                join departments using (department_id)
               where department_id = :t';
               
        OPEN RC_EMPS FOR Q
            USING '50';
    
        LOOP
            FETCH RC_EMPS INTO R_EMPS;
            EXIT WHEN RC_EMPS%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE(R_EMPS.FIRST_NAME || ' ' || R_EMPS.LAST_NAME || ' is at the department of : ' || R_EMPS.DEPARTMENT_NAME);    
        END LOOP;
    
        CLOSE RC_EMPS;
        OPEN RC_EMPS FOR SELECT*
                           FROM DEPARTMENTS;
    
        LOOP
            FETCH RC_EMPS INTO R_DEPTS;
            EXIT WHEN RC_EMPS%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE(R_DEPTS.DEPARTMENT_ID || ' ' || R_DEPTS.DEPARTMENT_NAME);
        END LOOP;
    
        CLOSE RC_EMPS;
    END;
    /
    /********************* EXAMPLE 7 *********************/ --sys_refcursor example
    DECLARE
        TYPE TY_EMPS IS RECORD (
                                E_ID            NUMBER,
                                FIRST_NAME      EMPLOYEES.FIRST_NAME%TYPE,
                                LAST_NAME       EMPLOYEES.LAST_NAME%TYPE,
                                DEPARTMENT_NAME DEPARTMENTS.DEPARTMENT_NAME%TYPE
                               );
        R_EMPS  TY_EMPS;
        -- type t_emps is ref cursor;
        RC_EMPS SYS_REFCURSOR;
        R_DEPTS DEPARTMENTS%ROWTYPE;
         --r t_emps%rowtype;
        Q       VARCHAR2(200);
    BEGIN
        Q := 'select employee_id,first_name,last_name,department_name 
                from employees
                join departments using (department_id)
               where department_id = :t';
               
        OPEN RC_EMPS FOR Q USING '50';
    
        LOOP
            FETCH RC_EMPS INTO R_EMPS;
            EXIT WHEN RC_EMPS%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE(R_EMPS.FIRST_NAME || ' ' || R_EMPS.LAST_NAME || ' is at the department of : ' || R_EMPS.DEPARTMENT_NAME);    
        END LOOP;
    
        CLOSE RC_EMPS;
        OPEN RC_EMPS FOR SELECT *
                           FROM DEPARTMENTS;
    
        LOOP
            FETCH RC_EMPS INTO R_DEPTS;
            EXIT WHEN RC_EMPS%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE(R_DEPTS.DEPARTMENT_ID || ' ' || R_DEPTS.DEPARTMENT_NAME);
        END LOOP;
    
        CLOSE RC_EMPS;
    END;
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    