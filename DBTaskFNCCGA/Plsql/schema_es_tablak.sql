-- Szekvenciák az azonosítókhoz
CREATE SEQUENCE auto_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE naplo_seq START WITH 1 INCREMENT BY 1;

-- Fő tábla
CREATE TABLE autok (
    auto_id NUMBER PRIMARY KEY,
    rendszam VARCHAR2(10) UNIQUE,
    marka VARCHAR2(50),
    gyartasi_ev NUMBER,
    regisztracio_datum DATE
);

-- Kapcsolt tábla
CREATE TABLE javitasok (
    javitas_id NUMBER PRIMARY KEY,
    auto_id NUMBER REFERENCES autok(auto_id),
    leiras VARCHAR2(200),
    koltseg NUMBER,
    javitas_datum DATE
);

-- Naplózó tábla
CREATE TABLE szerviz_naplo (
    naplo_id NUMBER PRIMARY KEY,
    muvelet VARCHAR2(50),
    datum DATE,
    felhasznalo VARCHAR2(50)
);