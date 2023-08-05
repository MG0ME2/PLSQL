--USING SQL IN PL/SQL
SET SERVEROUTPUT ON;
    /************************ Example 1 *************************/
    DECLARE
        v_name   VARCHAR2(50);
        v_salary employees.salary%type;
    BEGIN
        SELECT first_name ||' '|| last_name
              ,salary
          INTO v_name, v_salary  
          FROM employees 
         WHERE employee_id = 130;
        dbms_output.put_line('The salary of '|| v_name || ' is : '|| v_salary);
    END;
    /
    /************************ Example 2 *************************/
    DECLARE
        v_name   VARCHAR2(50);
        sysdates employees.hire_date%type;
    BEGIN
        SELECT first_name ||' '|| last_name
              ,sysdates
          INTO v_name, sysdates 
          FROM employees 
         WHERE employee_id = 130;
        dbms_output.put_line('The salary of '|| v_name || ' is : '|| sysdates);
    END;
    /
    /************************ Example 3 *************************/
    DECLARE
        v_name      VARCHAR2(50);
        v_sysdate   employees.hire_date%type;
        employee_id employees.employee_id%type := 130;
    BEGIN 
        SELECT first_name ||' '|| last_name
              ,sysdate
          INTO v_name, v_sysdate 
          FROM employees 
         WHERE employee_id = employee_id;
        dbms_output.put_line('The salary of '|| v_name || ' is : '|| v_sysdate );
    END;
    /
    /************************ Example 4 *************************/
    DECLARE
        v_name        VARCHAR2(50);
        v_salary      employees.salary%type;
        v_employee_id employees.employee_id%type := 130;
    BEGIN 
        SELECT first_name ||' '|| last_name
              ,salary
          INTO v_name, v_salary 
          FROM employees 
         WHERE employee_id = v_employee_id;
        dbms_output.put_line('The salary of '|| v_name || ' is : '|| v_salary );
    END;
    /

--DML OPERATIONS IN PL/SQL
    CREATE TABLE employees_copy AS SELECT * FROM employees; --se hace una copia de la tabla original para no alterar los datos en el ejemplo
    
    SELECT * FROM employees_copy;
    
    /************************ Example 1 *************************/
    BEGIN
        FOR i IN 207..216 LOOP
            INSERT INTO employees_copy 
                (employee_id, first_name, last_name, email, hire_date, job_id, salary)
            VALUES
                (i, 'employee#'||i,'temp_emp','abc@xmail.com',sysdate,'IT_PROG',1000);
        END LOOP;
    END; 
    /
    /************************ Example 2 *************************/
    DECLARE
      v_salary_increase NUMBER      := 400;
    BEGIN
        FOR i IN 207..216 LOOP    
            UPDATE employees_copy 
               SET salary = salary + v_salary_increase
             WHERE employee_id = i;
        END LOOP;
    END; 
    /
    /************************ Example 3 *************************/
    BEGIN
        FOR i IN 207..216 LOOP
            DELETE FROM employees_copy
             WHERE employee_id = i;
        END LOOP;
    END; 
    /
    DROP TABLE employees_copy;

--USING SEQUENCES IN PL/SQL
    CREATE TABLE employees_copy AS SELECT * FROM employees; --se hace una copia de la tabla original para no alterar los datos en el ejemplo
    
    SELECT * FROM employees_copy;
    
    /******************** Creating a Sequence *******************/
       CREATE SEQUENCE employee_id_seq 
        START WITH 207
    INCREMENT BY 1;
    
    /************************ Example 1 *************************/
    BEGIN
        FOR i IN 1..10 LOOP
            INSERT INTO employees_copy 
                (employee_id,first_name,last_name,email,hire_date,job_id,salary)
            VALUES 
                (employee_id_seq.nextval,'employee#'||employee_id_seq.nextval,'temp_emp','abc@xmail.com',sysdate,'IT_PROG',1000);
        END LOOP;
    END;
    /
    /************************ Example 2 *************************/
    DECLARE
        v_seq_num NUMBER;
    BEGIN
        SELECT employee_id_seq.nextval 
          INTO v_seq_num 
          FROM dual;
        dbms_output.put_line(v_seq_num);
    END;
    /
    /************************ Example 3 *************************/
    DECLARE
        v_seq_num NUMBER;
    BEGIN
        SELECT employee_id_seq.nextval 
          INTO v_seq_num 
          FROM employees_copy 
         WHERE rownum = 1;
        dbms_output.put_line(v_seq_num);
    END;
    /
    /************************ Example 4 *************************/
    DECLARE
        v_seq_num NUMBER;
    BEGIN
        v_seq_num := employee_id_seq.nextval; 
        dbms_output.put_line(v_seq_num);
    END;
    /
    /************************ Example 5 *************************/
    BEGIN
        dbms_output.put_line(employee_id_seq.nextval);
    END;
    /
    /************************ Example 6 *************************/
    BEGIN
        dbms_output.put_line(employee_id_seq.currval);
    END;
    
