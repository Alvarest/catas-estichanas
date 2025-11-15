-- Importar los datos de los csv (csv con cabezeras)
.mode csv
.separator ,
.import --skip 1 ../csv/catadores.csv catadores 
.import --skip 1 ../csv/catas.csv catas
.import --skip 1 ../csv/cervezas.csv cervezas
.import --skip 1 ../csv/notas.csv notas
