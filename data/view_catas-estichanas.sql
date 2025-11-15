-- Imprime el numero de elementos de cada tabla
-- y muestra las primeras 5 lineas

SELECT COUNT(*) FROM catadores;
.headers on
.mode column
SELECT * FROM catadores LIMIT 5;

SELECT COUNT(*) FROM catas;
.headers on
.mode column
SELECT * FROM catas LIMIT 5;

SELECT COUNT(*) FROM cervezas;
.headers on
.mode column
SELECT * FROM cervezas LIMIT 5;

SELECT COUNT(*) FROM notas;
.headers on
.mode column
SELECT * FROM notas LIMIT 5;
