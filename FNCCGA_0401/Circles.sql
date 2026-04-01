CREATE Table Circles (
    Radius number(4) Primary Key,
    Circumference number,
    Area number
);

desc Circles

Select 1 Radius, 2*1*3.141592654 Circumference from dual;

CREATE or REPLACE FUNCTION PI RETURN number AS
BEGIN
    RETURN 3.141592654;
END;

SELECT 1 Radius, 2*1*PI() Circumference from dual;

DECLARE
    Radius number := 1;
    Circumference number;
BEGIN
    Circumference := 2*Radius*PI();
    dbms_output.put_line('Radius: ' || Radius || ' Circumference: ' || Circumference);
END;

DECLARE
    Circumference number;
    x number := 1;
    y number := 5;
BEGIN
    FOR i IN x..y LOOP
        Circumference := 2*i*PI();
        dbms_output.put_line('Radius: ' || i || ' Circumference: ' || Circumference);
    END LOOP;
END;

CREATE OR REPLACE PROCEDURE Circler(x IN number, y IN number) IS
    Circumference number;
BEGIN
    FOR i IN x..y LOOP
        Circumference := 2*i*PI();
        dbms_output.put_line('Radius: ' || i || ' Circumference: ' || Circumference);
    END LOOP;
END;

begin
    Circler(1, 5);
end;


CREATE OR REPLACE PROCEDURE Circler(x IN number, y IN number) IS
    Circumference number;
    Area number;
BEGIN
    FOR i IN x..y LOOP
        Circumference := 2*i*PI();
        Area := POWER(i, 2)*PI();
        INSERT INTO Circles VALUES (i, Circumference, Area);
    END LOOP;
    dbms_output.put_line('A Circles tábla bekerúltek az adatok');
END;

begin
    Circler(1, 5);
end;

SELECT * FROM Circles;