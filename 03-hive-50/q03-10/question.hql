-- 
-- Pregunta
-- ===========================================================================
--
-- Para resolver esta pregunta use el archivo `data.tsv`.
--
-- Escriba una consulta que devuelva los cinco valores diferentes más pequeños 
-- de la tercera columna.
--
-- Escriba el resultado a la carpeta `output` de directorio de trabajo.
--
-- >>> Escriba su respuesta a partir de este punto <<<
--
DROP TABLE IF EXISTS docs;
DROP TABLE IF EXISTS dataTable;
DROP TABLE IF EXISTS testTable; 

CREATE TABLE docs (line STRING);
LOAD DATA LOCAL INPATH "data.tsv" OVERWRITE INTO TABLE docs;

CREATE TABLE dataTable (l_letter STRING, d_date STRING, v_value STRING);

INSERT OVERWRITE TABLE dataTable 
SELECT 
    regexp_extract(line, '^(?:([^\t]*)\t?){1}', 1) AS l_letter, 
    regexp_extract(line, '^(?:([^\t]*)\t?){2}', 1) AS d_date, 
    regexp_extract(line, '^(?:([^\t]*)\t?){3}', 1) AS v_value
FROM
    docs;
    


CREATE TABLE testTable (num INT);

INSERT OVERWRITE TABLE testTable 
SELECT 
    CAST(v_value AS INT) AS num
FROM
    dataTable;

INSERT OVERWRITE DIRECTORY '/tmp/output'
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','

SELECT num FROM testTable GROUP BY num ORDER BY num LIMIT 5;

!hadoop fs -copyToLocal /tmp/output output