--------------------------------------------------------
--  File created - Monday-June-05-2017   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Trigger TRG_CUSTOMER_CREDIT
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "DEMO"."TRG_CUSTOMER_CREDIT" 
BEFORE INSERT or UPDATE on CUSTOMER_CREDIT
REFERENCING new as newROW old as oldROW
FOR EACH ROW
DECLARE
  ex_credit_limit EXCEPTION;
BEGIN
  IF (INSERTING) THEN
    SELECT SEQ_CUSTOMER_ID.nextval INTO :newROW.CUSTOMER_ID
    FROM   DUAL;

    IF ((:newROW.CREDIT is NULL) or (:newROW.CREDIT < 0)) THEN
      SELECT 100 INTO :newROW.CREDIT
      FROM   DUAL;
    END IF;

  ELSIF (UPDATING) THEN
    IF (:oldROW.CUSTOMER_ID <> :newROW.CUSTOMER_ID) THEN
      raise_application_error (-20998, 'Cannot change the CUSTOMER_ID!');
    END IF;

    IF (:newROW.CREDIT < 0) THEN
      raise_application_error (-20999, 'The credit ' || :newROW.CREDIT || ' is below zero!');
    END IF;
  END IF;
  EXCEPTION
    WHEN ex_credit_limit THEN
      DBMS_OUTPUT.PUT_LINE('Fehler!!!');
      DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/
ALTER TRIGGER "DEMO"."TRG_CUSTOMER_CREDIT" ENABLE;
