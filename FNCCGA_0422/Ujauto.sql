CREATE OR REPLACE PROCEDURE UjAuto(
    p_rsz IN Auto.rsz%TYPE,
    p_tipus IN Auto.tipus%TYPE,
    p_szin IN Auto.szin%TYPE,
    p_kor IN Auto.kor%TYPE,
    p_ar IN Auto.ar%TYPE
) AS
BEGIN
    INSERT INTO Auto (rsz, tipus, szin, kor, ar)
    VALUES (p_rsz, p_tipus, p_szin, p_kor, p_ar);
    COMMIT;
END;

CREATE OR REPLACE PROCEDURE AutoModosit(
    p_rsz IN Auto.rsz%TYPE,
    p_ujszin IN Auto.szin%TYPE
) AS
BEGIN
    UPDATE Auto SET szin = p_ujszin WHERE rsz = p_rsz;
    COMMIT;
END;

CREATE OR REPLACE PROCEDURE AutoTorol(p_rsz IN Auto.rsz%TYPE) AS
BEGIN
    DELETE FROM Auto WHERE rsz = p_rsz;
    COMMIT;
END;

CREATE OR REPLACE PACKAGE AutoCsomag AS
    PROCEDURE UjAuto(p_rsz VARCHAR2, p_tipus VARCHAR2, p_szin VARCHAR2, p_kor NUMBER, p_ar NUMBER);
    PROCEDURE AutoModosit(p_rsz VARCHAR2, p_ujszin VARCHAR2);
    PROCEDURE AutoTorol(p_rsz VARCHAR2);
END AutoCsomag;

CREATE OR REPLACE PACKAGE BODY AutoCsomag AS
    PROCEDURE UjAuto(p_rsz VARCHAR2, p_tipus VARCHAR2, p_szin VARCHAR2, p_kor NUMBER, p_ar NUMBER) IS
    BEGIN
        INSERT INTO Auto (rsz, tipus, szin, kor, ar) VALUES (p_rsz, p_tipus, p_szin, p_kor, p_ar);
    END UjAuto;

    PROCEDURE AutoModosit(p_rsz VARCHAR2, p_ujszin VARCHAR2) IS
    BEGIN
        UPDATE Auto SET szin = p_ujszin WHERE rsz = p_rsz;
    END AutoModosit;

    PROCEDURE AutoTorol(p_rsz VARCHAR2) IS
    BEGIN
        DELETE FROM Auto WHERE rsz = p_rsz;
    END AutoTorol;
END AutoCsomag;