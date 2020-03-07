-- Pregunta
-- ===========================================================================
-- 
-- Para responder la pregunta use el archivo `data.csv`.
-- 
-- Genere una relación con el apellido y su longitud. Ordene por longitud y 
-- por apellido. Obtenga la siguiente salida.
-- 
--   Hamilton,8
--   Garrett,7
--   Holcomb,7
--   Coffey,6
--   Conway,6
-- 
-- Escriba el resultado a la carpeta `output` del directorio actual.
-- 
fs -rm -f -r output;
--
fs -put data.csv data.csv
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

-- Carga el archivo desde el disco duro
--
    
a = FOREACH u GENERATE surname, SIZE(surname);
b = ORDER a BY $1 DESC, $0 ASC;
c = LIMIT b 5;

-- escribe el archivo de salida
STORE c INTO 'output' USING PigStorage(',');

-- copia los archivos del HDFS al sistema local
fs -get output/ .