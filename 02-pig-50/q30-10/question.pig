-- 
-- Pregunta
-- ===========================================================================
-- 
-- Para responder la pregunta use el archivo `data.csv`.
-- 
-- Escriba el codigo en Pig para manipulación de fechas que genere la siguiente
-- salida.
-- 
--    1971-07-08,08,8,jue,jueves
--    1974-05-23,23,23,jue,jueves
--    1973-04-22,22,22,dom,domingo
--    1975-01-29,29,29,mie,miercoles
--    1974-07-03,03,3,mie,miercoles
--    1974-10-18,18,18,vie,viernes
--    1970-10-05,05,5,lun,lunes
--    1969-02-24,24,24,lun,lunes
--    1974-10-17,17,17,jue,jueves
--    1975-02-28,28,28,vie,viernes
--    1969-12-07,07,7,dom,domingo
--    1973-12-24,24,24,lun,lunes
--    1970-08-27,27,27,jue,jueves
--    1972-12-12,12,12,mar,martes
--    1970-07-01,01,1,mie,miercoles
--    1974-02-11,11,11,lun,lunes
--    1973-04-01,01,1,dom,domingo
--    1973-04-29,29,29,dom,domingo
-- 
-- Escriba el resultado a la carpeta `output` del directorio actual.
-- 
fs -rm -f -r output;
--
u = LOAD 'data.csv' USING PigStorage(',') 
    AS (id:int, 
        firstname:CHARARRAY, 
        surname:CHARARRAY, 
        birthday:CHARARRAY, 
        color:CHARARRAY, 
        quantity:INT);
--
-- >>> Escriba su respuesta a partir de este punto <<<
--

/*
Se escribe un archivo con el contenido de las semanas
%%writefile diasSemana.txt
Mon	lun	lunes
Tue	mar	martes
Wed	mie	miercoles
Thu	jue	jueves
Fri	vie	viernes
Sat	sab	sabado
Sun	dom	domingo
*/

a = FOREACH u GENERATE id, birthday, REGEX_EXTRACT(birthday, '(.*)-(.*)-(.*)',3) AS dia;
b = FOREACH a GENERATE id, birthday, dia, dia as (numDia:INT), ToString(ToDate(birthday,'yyyy-MM-dd'), 'EEE' ) AS diaSem;

-- Gestion de archivos del sistema local al HDFS
fs -rm -f -r input
fs -mkdir input
fs -put diasSemana.txt input/diasSemana.txt

m = LOAD 'input/diasSemana.txt' USING PigStorage()
    AS (dsI:CHARARRAY,
        dsE:CHARARRAY,
        dsExt:CHARARRAY);

c = JOIN b BY diaSem, m BY dsI;
d = FOREACH c GENERATE id, birthday, dia, numDia, dsE, dsExt;

e = ORDER d BY id;
f = FOREACH e GENERATE birthday, dia, numDia, dsE, dsExt;


-- escribe el archivo de salida
STORE f INTO 'output' USING PigStorage(',');

-- copia los archivos del HDFS al sistema local
fs -get output/ .