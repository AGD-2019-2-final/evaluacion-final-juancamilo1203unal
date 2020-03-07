-- Pregunta
-- ===========================================================================
-- 
-- Para el archivo `data.tsv` compute la cantidad de registros por letra de la 
-- columna 2 y clave de al columna 3; esto es, por ejemplo, la cantidad de 
-- registros en tienen la letra `b` en la columna 2 y la clave `jjj` en la 
-- columna 3 es:
-- 
--   ((b,jjj), 216)
-- 
-- Escriba el resultado a la carpeta `output` del directorio actual.
-- 
fs -rm -f -r output;
--
-- >>> Escriba su respuesta a partir de este punto <<<
--

-- Gestion de archivos del sistema local al HDFS
fs -rm -f -r input
fs -mkdir input
fs -put data.tsv input/data.tsv

-- carga de datos
lines = LOAD 'input/data.tsv' AS (clave:CHARARRAY, registro1:BAG{tup:(par:CHARARRAY)}, registro2:MAP[]);

-- genera una tabla llamada words con una palabra por registro
words = FOREACH lines GENERATE FLATTEN(registro1) AS (clv:CHARARRAY), FLATTEN(registro2) AS (val:CHARARRAY, reg:INT);

-- agrupa los registros que tienen la misma palabra
grouped = GROUP words BY (clv,val);

-- genera una variable que cuenta las ocurrencias por cada grupo
wordcount = FOREACH grouped GENERATE group, COUNT(words);

-- escribe el archivo de salida
STORE wordcount INTO 'output' USING PigStorage('\t');

-- copia los archivos del HDFS al sistema local
fs -get output/ .
