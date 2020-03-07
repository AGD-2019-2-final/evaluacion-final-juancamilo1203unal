--
-- Pregunta
-- ===========================================================================
-- 
-- El archivo `truck_event_text_partition.csv` tiene la siguiente estructura:
-- 
--   driverId       INT
--   truckId        INT
--   eventTime      STRING
--   eventType      STRING
--   longitude      DOUBLE
--   latitude       DOUBLE
--   eventKey       STRING
--   correlationId  STRING
--   driverName     STRING
--   routeId        BIGINT
--   routeName      STRING
--   eventDate      STRING
-- 
-- Escriba un script en Pig que carge los datos y obtenga los primeros 10 
-- registros del archivo para las primeras tres columnas, y luego, ordenados 
-- por driverId, truckId, y eventTime. 
--
-- Escriba el resultado a la carpeta `output` del directorio actual.
-- 
fs -rm -f -r output;
-- 
--  >>> Escriba su respuesta a partir de este punto <<<
-- 

-- Gestion de archivos del sistema local al HDFS
fs -rm -f -r input
fs -mkdir input
fs -put truck_event_text_partition.csv input/truck_event_text_partition.csv

-- carga de datos
dataTable = LOAD 'input/truck_event_text_partition.csv' USING PigStorage(',')
    AS (driverId:INT,
        truckId:INT,
        eventTime:CHARARRAY,
        eventType:CHARARRAY,
        longitude:DOUBLE,
        latitude:DOUBLE,
        eventKey:CHARARRAY,
        correlationId:CHARARRAY,
        driverName:CHARARRAY,
        routeId:FLOAT,
        routeName:CHARARRAY,
        eventDate:CHARARRAY);
    
-- filtrar y ordenar
a = FOREACH dataTable GENERATE driverId,truckId,eventTime;
b = LIMIT a 10;
c = ORDER b BY $0, $1, $2;

-- escribe el archivo de salida
STORE c INTO 'output' USING PigStorage(',');

-- copia los archivos del HDFS al sistema local
fs -get output/ .