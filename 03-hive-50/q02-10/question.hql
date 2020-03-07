-- 
-- Pregunta
-- ===========================================================================
--
-- Para resolver esta pregunta use el archivo `data.tsv`.
--
-- Construya una consulta que ordene la tabla por letra y valor (3ra columna).
--
-- Escriba el resultado a la carpeta `output` de directorio de trabajo.
--
-- >>> Escriba su respuesta a partir de este punto <<<
--
DROP TABLE IF EXISTS docs;
DROP TABLE IF EXISTS dataT; 

CREATE TABLE docs (line STRING);
LOAD DATA LOCAL INPATH "data.tsv" OVERWRITE INTO TABLE docs;

CREATE TABLE dataT (l_letter STRING, d_date STRING, v_value STRING);

INSERT OVERWRITE TABLE dataT 
SELECT 
    regexp_extract(line, '^(?:([^\t]*)\t?){1}', 1) AS l_letter, 
    regexp_extract(line, '^(?:([^\t]*)\t?){2}', 1) AS d_date, 
    regexp_extract(line, '^(?:([^\t]*)\t?){3}', 1) AS v_value
FROM
    docs;

INSERT OVERWRITE DIRECTORY '/tmp/output'
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
SELECT l_letter,d_date, CAST(v_value AS INT)
FROM
    dataT
ORDER BY
    l_letter,
    v_value,
    d_date;

!hadoop fs -copyToLocal /tmp/output output