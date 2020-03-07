-- 
-- Pregunta
-- ===========================================================================
-- 
-- Para responder la pregunta use el archivo `data.csv`.
-- 
-- Obtenga los apellidos que empiecen por las letras entre la 'd' y la 'k'. La 
-- salida esperada es la siguiente:
-- 
--   (Hamilton)
--   (Holcomb)
--   (Garrett)
--   (Fry)
--   (Kinney)
--   (Klein)
--   (Diaz)
--   (Guy)
--   (Estes)
--   (Jarvis)
--   (Knight)
-- 
-- Escriba el resultado a la carpeta `output` del directorio actual.
-- 
fs -rm -f -r output;
--
-- carga de datos
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
a = FOREACH u GENERATE surname, id;

b1 = FILTER a BY (surname matches '.*D.*');
b2 = FILTER a BY (surname matches '.*E.*');
b3 = FILTER a BY (surname matches '.*F.*');
b4 = FILTER a BY (surname matches '.*G.*');
b5 = FILTER a BY (surname matches '.*H.*');
b6 = FILTER a BY (surname matches '.*I.*');
b7 = FILTER a BY (surname matches '.*J.*');
b8 = FILTER a BY (surname matches '.*K.*');
c = UNION b1, b2, b3, b4, b5, b6, b7, b8;

d = ORDER c BY $1;
e = FOREACH d GENERATE $0;

-- escribe el archivo de salida
STORE e INTO 'output' USING PigStorage(',');

-- copia los archivos del HDFS al sistema local
fs -get output/ .