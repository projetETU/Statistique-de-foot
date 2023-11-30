CREATE TABLE competition(
    id_competition INT AUTO_INCREMENT PRIMARY KEY,
    competition VARCHAR(20)
);
INSERT INTO competition(competition) VALUES ("LIGUE 1");
INSERT INTO competition(competition) VALUES ("PREMIER LIGUE");
CREATE TABLE match(
    id_match INT AUTO_INCREMENT PRIMARY KEY,
    id_competition INT ,
    FOREIGN KEY (id_competition) REFERENCES competition(id_competition)
);
CREATE TABLE equipe(
    id_equipe INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR
);
CREATE TABLE lieu(
    id_lieu INT AUTO_INCREMENT PRIMARY KEY,
    lieu VARCHAR(20)
);
INSERT INTO lieu(lieu) VALUES ("DOMICILE");
INSERT INTO lieu(lieu) VALUES ("EXTERIEUR");

CREATE TABLE detailsMatch(
    id_details INT AUTO_INCREMENT PRIMARY KEY,
    id_match INT ,
    id_competition INT ,
    id_equipe INT,
    but INT ,
    cartonJ INT ,
    cartonR INT,
    possesion% float ,
    passeReussi% float,
    aerienGagner INT ,
    id_lieu INT ,
    note INT ,
    FOREIGN KEY (id_competition) REFERENCES competition(id_competition),
    FOREIGN KEY (id_equipe) REFERENCES equipe(id_equipe),
    FOREIGN KEY (id_lieu) REFERENCES lieu(id_lieu)
);
