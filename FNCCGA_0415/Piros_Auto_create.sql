CREATE TABLE Piros_Auto (
    rsz varchar2(20),
    tipus varchar2(20),
    szin varchar2(20),
    kor number(3, 0),
    ar number(10, 0)
);

BEGIN
INSERT INTO Piros_Auto VALUES ('ABC500', 'Opel Corsa', 'piros', 8, 800000);
INSERT INTO Piros_Auto VALUES ('MCC325', 'Opel Insignia', 'fekete', 2, 6800000);
INSERT INTO Piros_Auto VALUES ('BBM104', 'Suzuki Swift', 'piros', 5, 1500000);
INSERT INTO Piros_Auto VALUES ('CHR411', 'Renault Twingo', 'piros', 12, 700000);
INSERT INTO Piros_Auto VALUES ('JRZ932', 'BMW M3', 'fekete', 5, 4500000);
INSERT INTO Piros_Auto VALUES ('JEG113', 'Opel Corsa', 'piros', 7, 900000);
INSERT INTO Piros_Auto VALUES ('DER842', 'Seat Ibiza', 'szürke', 14, 500000);
INSERT INTO Piros_Auto VALUES ('BAB422', 'Lada 1300S', 'fehér', 28, 220000);
INSERT INTO Piros_Auto VALUES ('UFF666', 'Audi TT', 'fekete', 4, 7500000);
COMMIT;
END;

CREATE TABLE MasikPiros_Auto (
    rsz varchar2(20),
    tipus varchar2(20),
    szin varchar2(20),
    kor number(3),
    ar number(10)
);

DECLARE
    CURSOR piros IS SELECT * FROM Piros_Auto WHERE szin = 'piros';
    x piros%ROWTYPE;
BEGIN
    OPEN piros;
    LOOP
        FETCH piros INTO x;
        EXIT WHEN piros%NOTFOUND;
        INSERT INTO MasikPiros_Auto VALUES (x.rsz, x.tipus, x.szin, x.kor, x.ar);
    END LOOP;
    CLOSE piros;
    COMMIT;
END;

BEGIN
    FOR x IN (SELECT * FROM Piros_Auto WHERE szin = 'piros') LOOP
        INSERT INTO MasikPiros_Auto VALUES (x.rsz, x.tipus, x.szin, x.kor, x.ar);
    END LOOP;
    COMMIT;
END;

