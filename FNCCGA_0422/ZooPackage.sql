CREATE OR REPLACE PACKAGE ZooPackage AS
    PROCEDURE NewPet(id IN NUMBER, nev IN VARCHAR2, fajta IN VARCHAR2, szul IN DATE, suly IN NUMBER, ertek IN NUMBER, gondozo IN VARCHAR2);
    PROCEDURE DelPet(id IN NUMBER);
    PROCEDURE ModPet(id IN NUMBER, gond IN VARCHAR2);
    PROCEDURE ListPet;
    FUNCTION PetNumber RETURN NUMBER;
END ZooPackage;

CREATE OR REPLACE PACKAGE BODY ZooPackage AS

    
    PROCEDURE NewPet(id IN NUMBER, nev IN VARCHAR2, fajta IN VARCHAR2, szul IN DATE, suly IN NUMBER, ertek IN NUMBER, gondozo IN VARCHAR2) IS
    BEGIN
        INSERT INTO Zoo (id, nev, fajta, szul, suly, ertek, gondozo)
    END NewPet;

    PROCEDURE DelPet(id IN NUMBER) IS
    BEGIN
        DELETE FROM Zoo WHERE ID = id;
        COMMIT;
    END DelPet;

    
    PROCEDURE ModPet(id IN NUMBER, gondozo IN VARCHAR2) IS
    BEGIN
        UPDATE Zoo SET GONDOZO = gondozo WHERE ID = id;
        COMMIT;
    END ModPet;

    
    PROCEDURE ListPet IS
    BEGIN
        FOR r IN (SELECT NEV, GONDOZO FROM Zoo) LOOP
            DBMS_OUTPUT.PUT_LINE('Név: ' || r.NEV || ' | Gondozó: ' || r.GONDOZO);
        END LOOP;
    END ListPet;

    
    FUNCTION PetNumber RETURN NUMBER IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_count FROM Zoo;
        RETURN v_count;
    END PetNumber;

END ZooPackage;