CREATE TABLE ZOO(
    ID int PRIMARY KEY,
    Nev varchar2(30),
    Fajta varchar2(10),
    Szuletett date,
    Suly int,
    Ertek int,
    Gondozo varchar2(30)
);

desc zoo

begin 
    INSERT INTO ZOO VALUES (1, 'Nelly', 'Ellefánt', TO_DATE('10.03.2024', 'DD.MM.YYYY'), 3500, 3030303, 'Kiss János');
    INSERT INTO ZOO VALUES (2, 'Molly', 'cica', TO_DATE('10.03.2024', 'DD.MM.YYYY'), 5, 50000, 'Anna');
    INSERT INTO ZOO VALUES (3, 'Dávid', 'kutya', TO_DATE('10.03.2024', 'DD.MM.YYYY'), 20, 150000, 'Péter');
    INSERT INTO ZOO VALUES (4, 'Eszter', 'elefánt', TO_DATE('10.03.2024', 'DD.MM.YYYY'), 5000, 2000000, 'Katalin');
    INSERT INTO ZOO VALUES (5, 'Ferenc', 'farkas', TO_DATE('10.03.2024', 'DD.MM.YYYY'), 30, 80000, 'László');
END;

CREATE OR REPLACE PROCEDURE ErtekNovel (szazalek IN INT) AS
BEGIN
    UPDATE ZOO SET Ertek = Ertek + (Ertek * szazalek / 100);
END;