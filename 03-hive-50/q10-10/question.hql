-- 
-- Pregunta
-- ===========================================================================
--
-- Escriba una consulta que calcule la cantidad de registros por clave de la 
-- columna 3. En otras palabras, cuántos registros hay que tengan la clave 
-- `aaa`?
--
-- Escriba el resultado a la carpeta `output` de directorio de trabajo.
--
DROP TABLE IF EXISTS t0;
CREATE TABLE t0 (
    c1 STRING,
    c2 ARRAY<CHAR(1)>, 
    c3 MAP<STRING, INT>
    )
    ROW FORMAT DELIMITED 
        FIELDS TERMINATED BY '\t'
        COLLECTION ITEMS TERMINATED BY ','
        MAP KEYS TERMINATED BY '#'
        LINES TERMINATED BY '\n';
LOAD DATA LOCAL INPATH 'data.tsv' INTO TABLE t0;
--
-- >>> Escriba su respuesta a partir de este punto <<<
--

DROP TABLE IF EXISTS dataTable; 
CREATE TABLE dataTable (key STRING, val INT);
INSERT OVERWRITE TABLE dataTable 
SELECT explode(c3) FROM t0;

DROP TABLE IF EXISTS word_counts;
CREATE TABLE word_counts
AS
    SELECT word,count(1) AS count
    FROM
        (SELECT key AS word FROM dataTable) w
GROUP BY
    word
ORDER BY
    word;
    
    
INSERT OVERWRITE DIRECTORY '/tmp/output'
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','

SELECT * FROM word_counts;

!hadoop fs -copyToLocal /tmp/output output