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
    nom VARCHAR(20)
);
INSERT INTO equipe(nom) VALUES ("Bayern Munich");
INSERT INTO equipe(nom) VALUES ("Paris Saint-Germain");
INSERT INTO equipe(nom) VALUES ("Liverpool");
INSERT INTO equipe(nom) VALUES ("Inter");

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
    possesion float ,
    passeReussi float,
    aerienGagner INT ,
    id_lieu INT ,
    note INT ,
    FOREIGN KEY (id_competition) REFERENCES competition(id_competition),
    FOREIGN KEY (id_equipe) REFERENCES equipe(id_equipe),
    FOREIGN KEY (id_lieu) REFERENCES lieu(id_lieu)
);
INSERT INTO detailsMatch(id_match,id_competition,id_equipe,but,cartonJ,cartonR,possesion,passeReussi,aerienGagner,id_lieu,note) VALUES(1,1,1,2,4,1,54,43,12,1,6);
INSERT INTO detailsMatch(id_match,id_competition,id_equipe,but,cartonJ,cartonR,possesion,passeReussi,aerienGagner,id_lieu,note) VALUES(1,1,2,1,3,0,46,61,12,2,5);
INSERT INTO detailsMatch(id_match,id_competition,id_equipe,but,cartonJ,cartonR,possesion,passeReussi,aerienGagner,id_lieu,note) VALUES(1,1,3,2,4,1,54,43,12,1,6);
INSERT INTO detailsMatch(id_match,id_competition,id_equipe,but,cartonJ,cartonR,possesion,passeReussi,aerienGagner,id_lieu,note) VALUES(1,1,4,1,3,0,46,61,12,2,5);

CREATE OR REPLACE VIEW V_match AS
SELECT
  equipe.nom as Equipe,
  competition.competition as "Competitions",
  SUM(detailsMatch.but) as But,
  SUM(detailsMatch.cartonJ) as Jaune,
  SUM(detailsMatch.cartonR) as Rouge,
  AVG(detailsMatch.possesion) as "Possession",
  AVG(detailsMatch.passeReussi) as "PasseReussi",
  detailsMatch.aerienGagner as "AerienGagner",
  AVG(detailsMatch.note) as "Note"
FROM detailsMatch
JOIN competition ON detailsMatch.id_competition = competition.id_competition
JOIN equipe ON detailsMatch.id_equipe = equipe.id_equipe
JOIN lieu ON detailsMatch.id_lieu = lieu.id_lieu
GROUP BY equipe.nom,competition.competition
;
