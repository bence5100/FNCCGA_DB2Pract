CREATE TABLE Naplo5 (
    datum TIMESTAMP,
    esemeny VARCHAR(20),
    Adat VARCHAR(100)
);

DESCRIBE Naplo5;

CREATE TABLE Vasarlo (
    VID CHAR(3),
    NEV VARCHAR(30),
    CIM VARCHAR(30),
    FIZMOD NUMBER(3,0)
);

DESCRIBE Vasarlo;

BEGIN
    INSERT INTO Vasarlo VALUES ('V01', 'Kék Alma', 'Mc. Kék u.12', 2);
    INSERT INTO Vasarlo VALUES ('V02', 'Zöld Gabi', 'Mc. Hó u.72', 3);
    INSERT INTO Vasarlo VALUES ('V03', 'Feke F...', 'Mc. Kő u.25', 1);
    INSERT INTO Vasarlo VALUES ('V04', 'Korcs Éva', 'Eger. LAP...', 1);
    INSERT INTO Vasarlo VALUES ('V05', 'Kis Béla', 'Eger. Bé u.9', 2);
    INSERT INTO Vasarlo VALUES ('V06', 'Kis Jenő', 'Eger. Cé ...', 3);
    INSERT INTO Vasarlo VALUES ('V07', 'Kis Noé', 'Eger. Cé ...', 4);
    INSERT INTO Vasarlo VALUES ('V08', 'Kis Tas', 'Eger. Cé ...', 1);
    INSERT INTO Vasarlo VALUES ('V09', 'Hó Manó', 'Nyék. Tóu.74', 2);
    INSERT INTO Vasarlo VALUES ('V10', 'Ká Rozi', 'Nyél. Káu.5', 3);
    INSERT INTO Vasarlo VALUES ('V11', 'Víz Jenő', 'Mc. Útu.39', 3);

END;

SELECT * FROM Vasarlo;

CREATE OR REPLACE TRIGGER TB after insert on Vasarlo FOR each row
BEGIN
    insert into Naplo5 (esemeny, Adat, datum)
    values ('Beszúrás', :new.VID ||'_'|| :new.NEV ||'_'|| :new.CIM, sysdate);
END;

INSERT INTO VASARLO VALUES ('V12', 'Jó Géza', 'Eger. Vár u.9', 2);
INSERT INTO VASARLO VALUES ('V15', 'Bekre Pál', 'Mc. Uts u.87', 1);

SELECT * FROM NAPLO5;

DROP TRIGGER TB;
SELECT * FROM NAPLO5;
SELECT * FROM VASARLO;

CREATE OR REPLACE TRIGGER TM after update on Vasarlo FOR each row
DECLARE
    s VARCHAR(100);
BEGIN
    IF :old.VID != :new.VID THEN
        s := s || :old.VID ||'_'|| :new.VID ||',';
    END IF;
    IF :old.NEV != :new.NEV THEN
        s := s || :old.NEV ||'_'|| :new.NEV ||',';
    END IF;
    IF :old.CIM != :new.CIM THEN
        s := s || :old.CIM ||'_'|| :new.CIM ||',';
    END IF;
    IF :old.FIZMOD != :new.FIZMOD THEN
        s := s || :old.FIZMOD ||'_'|| :new.FIZMOD ||',';
    END IF;
        s := substr(s, 1, length(s)-1);
    insert into Naplo5 (esemeny, Adat, datum)
    values ('Módosítás', s, sysdate);
END;

SELECT * FROM NAPLO5;
SELECT * FROM VASARLO;

BEGIN
UPDATE Vasarlo SET VID='V11', NEV = 'Víz Jenő' WHERE VID = 'V12';
END;

SELECT * FROM NAPLO5;
SELECT * FROM VASARLO;  

DROP TRIGGER TM;

CREATE OR REPLACE TRIGGER TT after delete on Vasarlo FOR each row
BEGIN
    insert into Naplo5 (esemeny, Adat, datum)
    values ('Törlés', :old.VID ||'_'|| user, sysdate);
END;

DELETE FROM Vasarlo WHERE VID IN ('V15', 'V11');
SELECT * FROM NAPLO5;
SELECT * FROM VASARLO;
