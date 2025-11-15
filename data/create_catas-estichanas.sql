PRAGMA foreign_keys = ON;

CREATE TABLE catadores (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	nombre TEXT NOT NULL CHECK (LENGTH(nombre) <= 100),
	password_hash TEXT NOT NULL CHECK (LENGTH(password_hash) <= 255)
);

CREATE TABLE catas (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	nombre TEXT NOT NULL CHECK (LENGTH(nombre) <= 300),
	lugar TEXT CHECK (LENGTH(lugar) <= 150),
	fecha TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP, -- TIENE QUE SER YYYY-MM-DD
	imagen TEXT
);

CREATE TABLE cervezas (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	nombre TEXT NOT NULL CHECK (LENGTH(nombre) <= 300),
	marca TEXT CHECK (LENGTH(marca) <= 300),
	estilo TEXT CHECK (LENGTH(estilo) <= 300),
	alcohol REAL CHECK (alcohol == NULL OR alcohol >= 0.0 AND alcohol <= 100.0),
	pais TEXT CHECK (LENGTH(pais) <= 100),
	ean INTEGER,
   	gtin INTEGER,
	imagen TEXT,
	no_cerveza INTEGER DEFAULT 0,
	necesita_revision INTEGER DEFAULT 0
);

CREATE TABLE notas (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	id_cata INTEGER,
	id_cerveza INTEGER,
	id_catador INTEGER,
	nota REAL CHECK (nota >= 0.0 AND nota <= 10.0),
	comentario TEXT CHECK (LENGTH(comentario) <= 1000),
	FOREIGN KEY (id_cata) REFERENCES catas(id),
	FOREIGN KEY (id_cerveza) REFERENCES cervezas(id),
	FOREIGN KEY (id_catador) REFERENCES catadores(id)
);


