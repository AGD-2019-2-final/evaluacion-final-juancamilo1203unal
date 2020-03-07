-- 
-- Pregunta
-- ===========================================================================
-- 
-- Para el archivo `data.tsv` compute Calcule la cantidad de registros en que 
-- aparece cada letra minúscula en la columna 2.
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
words = FOREACH lines GENERATE FLATTEN(registro1) AS word;

-- agrupa los registros que tienen la misma palabra
grouped = GROUP words BY word;

-- genera una variable que cuenta las ocurrencias por cada grupo
wordcount = FOREACH grouped GENERATE group, COUNT(words);

-- escribe el archivo de salida
STORE wordcount INTO 'output';

-- copia los archivos del HDFS al sistema local
fs -get output/ .
