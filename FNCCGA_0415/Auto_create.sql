CREATE TABLE Auto (
    rsz varchar2(6),
    tipus varchar2(30),
    szin varchar2(20),
    kor number(3),
    ar number(10)
);

BEGIN
    INSERT INTO Auto VALUES ('ABC500', 'Opel Corsa', 'piros', 8, 800000);
    INSERT INTO Auto VALUES ('MCC325', 'Opel Insignia', 'fekete', 2, 6800000);
    INSERT INTO Auto VALUES ('BBM104', 'Suzuki Swift', 'piros', 5, 1500000);
    INSERT INTO Auto VALUES ('CHR411', 'Renault Twingo', 'piros', 12, 700000);
    INSERT INTO Auto VALUES ('JRZ932', 'BMW M3', 'fekete', 5, 4500000);
    INSERT INTO Auto VALUES ('JEG113', 'Opel Corsa', 'piros', 7, 900000);
    INSERT INTO Auto VALUES ('DER842', 'Seat Ibiza', 'szürke', 14, 605000);
    INSERT INTO Auto VALUES ('BAB422', 'Lada 1300S', 'fehér', 28, 242000);
    INSERT INTO Auto VALUES ('UFF666', 'Audi TT', 'fekete', 4, 7500000);
COMMIT;
END;

CREATE OR REPLACE PROCEDURE aut_arnov1 IS
    CURSOR cur_a IS SELECT * FROM Auto WHERE szin = 'piros' FOR UPDATE;
    a cur_a%ROWTYPE;
BEGIN
    OPEN cur_a;
    LOOP
        FETCH cur_a INTO a;
        EXIT WHEN cur_a%NOTFOUND;
        UPDATE Auto SET ar = ar * 1.1 WHERE CURRENT OF cur_a;
    END LOOP;
    CLOSE cur_a;
    COMMIT;
END;

CREATE OR REPLACE FUNCTION aut_arnov3 RETURN NUMBER IS
    db NUMBER := 0;
BEGIN
    FOR cur_a IN (SELECT rsz FROM Auto WHERE szin = 'szürke' FOR UPDATE) LOOP
        UPDATE Auto SET ar = ar * 1.1 WHERE rsz = cur_a.rsz;
        db := db + 1;
    END LOOP;
    COMMIT;
    RETURN db;
END;

CREATE OR REPLACE PROCEDURE aut_arnov4(p_szin IN VARCHAR2) IS
    db NUMBER := 0;
BEGIN
    FOR cur_a IN (SELECT rsz FROM Auto WHERE szin = p_szin FOR UPDATE) LOOP
        UPDATE Auto SET ar = ar * 1.1 WHERE rsz = cur_a.rsz;
        db := db + 1;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Módosított autók száma: ' || db);
    COMMIT;
END;

Select * from Auto;