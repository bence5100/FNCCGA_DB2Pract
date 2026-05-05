
-- 1. TRIGGEREK TÖRLÉSE 
DROP TRIGGER auto_pk_trg;
DROP TRIGGER javitas_ctrl_trg;
DROP TRIGGER javitas_naplo_trg;



-- 2. PL/SQL CSOMAG TÖRLÉSE
DROP PACKAGE autok_pkg;



-- 3. TÁBLÁK TÖRLÉSE 
-- A CASCADE CONSTRAINTS biztosítja, hogy a külső kulcsok (Foreign Keys) se okozzanak akadályt
DROP TABLE javitasok;
DROP TABLE autok ;
DROP TABLE szerviz_naplo ;



-- 4. SZEKVENCIÁK (Sorszámosztók) TÖRLÉSE
DROP SEQUENCE auto_seq;
DROP SEQUENCE naplo_seq;






