-- 
-- Pregunta
-- ===========================================================================
--
-- Realice una consulta que compute la cantidad de veces que aparece cada valor 
-- de la columna `t0.c5`  por año.
--
-- Escriba el resultado a la carpeta `output` de directorio de trabajo.
--
DROP TABLE IF EXISTS tbl0;
CREATE TABLE tbl0 (
    c1 INT,
    c2 STRING,
    c3 INT,
    c4 DATE,
    c5 ARRAY<CHAR(1)>, 
    c6 MAP<STRING, INT>
)
ROW FORMAT DELIMITED 
FIELDS TERMINATED BY ','
COLLECTION ITEMS TERMINATED BY ':'
MAP KEYS TERMINATED BY '#'
LINES TERMINATED BY '\n';
LOAD DATA LOCAL INPATH 'tbl0.csv' INTO TABLE tbl0;
--
DROP TABLE IF EXISTS tbl1;
CREATE TABLE tbl1 (
    c1 INT,
    c2 INT,
    c3 STRING,
    c4 MAP<STRING, INT>
)
ROW FORMAT DELIMITED 
FIELDS TERMINATED BY ','
COLLECTION ITEMS TERMINATED BY ':'
MAP KEYS TERMINATED BY '#'
LINES TERMINATED BY '\n';
LOAD DATA LOCAL INPATH 'tbl1.csv' INTO TABLE tbl1;
--
-- >>> Escriba su respuesta a partir de este punto <<<
--
DROP TABLE IF EXISTS dateT; 
CREATE TABLE dateT (d_date STRING, l_letter ARRAY<CHAR(1)>);
INSERT OVERWRITE TABLE dateT 
SELECT 
    SUBSTR(c4, 1, 4) AS d_date,
    c5 AS l_letter
FROM
    tbl0;
    
DROP TABLE IF EXISTS wordCount; 
CREATE TABLE wordCount (year STRING, clave STRING);
INSERT OVERWRITE TABLE wordCount 
SELECT
    d_date,
    let
FROM
    dateT
LATERAL VIEW
    explode(l_letter) dateT AS let;  
    

DROP TABLE IF EXISTS word_counts_2;
CREATE TABLE word_counts_2
AS
    SELECT year, clave, count(1) AS count
    FROM
        wordCount
GROUP BY
    year, clave;  

INSERT OVERWRITE DIRECTORY '/tmp/output'
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','

SELECT * FROM word_counts_2;

!hadoop fs -copyToLocal /tmp/output output