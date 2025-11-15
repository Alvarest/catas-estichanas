from typing import Optional
from fastapi import FastAPI, Query
from fastapi.middleware.cors import CORSMiddleware
import sqlite3

app = FastAPI()

app.add_middleware(
        CORSMiddleware,
        allow_origins=["*"],
        allow_methods=["*"],
        allow_headers=["*"]
)

def get_db():
    conn = sqlite3.connect("../data/catas-estichanas.db")
    return conn

@app.get("/options")
def get_options():
    conn = get_db()
    rows = conn.execute(
            "SELECT id, nombre FROM catadores"
    ).fetchall()
    conn.close()

    return[
            {"id": row[0],
             "nombre": row[1]}
            for row in rows
    ]

@app.get("/crearTop")
def crearTop(catador: Optional[str] = Query(None)):
    conn = get_db()
    if catador == "todos":
        info_cervezas = conn.execute(
                "SELECT id, nombre, marca, estilo, alcohol, no_cerveza FROM cervezas").fetchall()
        rows = conn.execute(
                """
                SELECT id_cerveza, 
                COUNT(*) AS num_notas,
                AVG(nota) AS nota_media
                FROM notas
                GROUP BY id_cerveza
                ORDER BY nota_media DESC;
                """
        ).fetchall()
        conn.close()

    else:
        info_cervezas = conn.execute(
                "SELECT id, nombre, marca, estilo, alcohol, no_cerveza FROM cervezas").fetchall()
        rows = conn.execute(
                """
                SELECT id_cerveza, 
                COUNT(*) AS num_notas,
                AVG(nota) AS nota_media
                FROM notas
                WHERE id_catador = ?
                GROUP BY id_cerveza
                ORDER BY nota_media DESC;
                """
        , (catador,)).fetchall()
        conn.close()


    print("Catador: " + catador)
    print("------------- Cervezas -------------")
    for i, cerveza in enumerate(info_cervezas):
        print(str(i) + ", " + str(cerveza))

    print()
    print("------------ Medias --------------")
    for row in rows:
        print(row)
    
    return [
            {"puesto": i+1,
             "cerveza": info_cervezas[row[0]-1][1],
             "productor": info_cervezas[row[0]-1][2],
             "estilo": info_cervezas[row[0]-1][3],
             "alcohol": info_cervezas[row[0]-1][4],
             "num_notas": row[1],
             "nota_media": round(row[2], 2)}
            for i,row in enumerate(rows)
    ]

