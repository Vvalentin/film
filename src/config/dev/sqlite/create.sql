-- Copyright (C) 2023 - present Juergen Zimmermann, Hochschule Karlsruhe
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <https://www.gnu.org/licenses/>.

-- https://docs.python.org/dev/library/sqlite3.html#sqlite3-cli
-- sqlite3 patient.sqlite

-- https://sqlite.org/lang_createtable.html
-- https://sqlite.org/stricttables.html ab 3.37.0
-- https://sqlite.org/syntax/column-constraint.html
-- https://sqlite.org/autoinc.html
-- https://sqlite.org/stricttables.html: INT, INTEGER, REAL, TEXT
-- https://sqlite.org/lang_createindex.html
-- https://stackoverflow.com/questions/37619526/how-can-i-change-the-default-sqlite-timezone

CREATE TABLE IF NOT EXISTS film (
    id             INTEGER PRIMARY KEY AUTOINCREMENT,
    version        INTEGER NOT NULL DEFAULT 0,
    regisseur           TEXT NOT NULL UNIQUE,
    bewertung         INTEGER NOT NULL CHECK (bewertung >= 0 AND bewertung <= 5),
    art            TEXT,
    preis          REAL,
    rabatt         REAL,
    lieferbar      INTEGER NOT NULL CHECK (lieferbar = 0 OR lieferbar = 1) DEFAULT 0,
    erscheinungsdatum          TEXT,
    homepage       TEXT,
    schlagwoerter  TEXT,
    erzeugt        TEXT NOT NULL,
    aktualisiert   TEXT NOT NULL
);
CREATE INDEX IF NOT EXISTS film_regisseur_idx ON film(regisseur);

CREATE TABLE IF NOT EXISTS titel (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    titel       TEXT NOT NULL,
    untertitel  TEXT,
    film_id     INTEGER NOT NULL UNIQUE REFERENCES film
);


CREATE TABLE IF NOT EXISTS abbildung (
    id              INTEGER PRIMARY KEY AUTOINCREMENT,
    beschriftung    TEXT NOT NULL,
    content_type    TEXT NOT NULL,
    film_id         INTEGER NOT NULL REFERENCES film
);
CREATE INDEX IF NOT EXISTS abbildung_film_id_idx ON abbildung(film_id);
