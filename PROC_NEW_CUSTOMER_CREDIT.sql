--------------------------------------------------------
--  File created - Monday-June-05-2017   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure PROC_NEW_CUSTOMER_CREDIT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "DEMO"."PROC_NEW_CUSTOMER_CREDIT" (CUSTOMER_ID       out    NUMBER,
                            FIRST_NAME      in     VARCHAR2,
                            CREDIT          in out NUMBER) IS
BEGIN
  SELECT SEQ_CUSTOMER_ID.nextval INTO CUSTOMER_ID
  FROM   dual;

  IF CREDIT is null THEN
    SELECT 100 INTO CREDIT
    FROM   dual;
  END IF;

  INSERT INTO CUSTOMER_CREDIT VALUES (CUSTOMER_ID,
       FIRST_NAME, CREDIT);
END PROC_NEW_CUSTOMER_CREDIT;

/
