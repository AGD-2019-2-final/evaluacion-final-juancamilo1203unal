-- 
-- Pregunta
-- ===========================================================================
-- 
-- Para responder la pregunta use el archivo `data.csv`.
-- 
-- Cuente la cantidad de personas nacidas por año.
-- 
-- Escriba el resultado a la carpeta `output` del directorio actual.
-- 
fs -rm -f -r output;
--
-- fs -put data.csv data.csv
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
a = FOREACH u GENERATE REGEX_EXTRACT(birthday, '(.*)-(.*)-(.*)',1) AS year;
-- agrupa los registros que tienen la misma palabra
grouped = GROUP a BY year;

-- genera una variable que cuenta las ocurrencias por cada grupo
wordcount = FOREACH grouped GENERATE group, COUNT(a);


-- escribe el archivo de salida
STORE wordcount INTO 'output' USING PigStorage(',');

-- copia los archivos del HDFS al sistema local
fs -get output/ .