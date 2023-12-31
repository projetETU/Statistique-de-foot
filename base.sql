CREATE TABLE competition(
    id_competition INT AUTO_INCREMENT PRIMARY KEY,
    competition VARCHAR(20)
);
INSERT INTO competition(competition) VALUES ("LIGUE 1");
INSERT INTO competition(competition) VALUES ("PREMIER LIGUE");
CREATE TABLE matchfoot(
    id_matchfoot INT AUTO_INCREMENT PRIMARY KEY,
    id_competition INT ,
    FOREIGN KEY (id_competition) REFERENCES competition(id_competition)
);
INSERT INTO matchfoot(id_competition) VALUES (1);
INSERT INTO matchfoot(id_competition) VALUES (2);

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

CREATE TABLE detailsMatchfoot(
    id_details INT AUTO_INCREMENT PRIMARY KEY,
    id_matchfoot INT ,
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
        FOREIGN KEY (id_matchfoot) REFERENCES matchfoot(id_matchfoot),
    FOREIGN KEY (id_competition) REFERENCES competition(id_competition),
    FOREIGN KEY (id_equipe) REFERENCES equipe(id_equipe),
    FOREIGN KEY (id_lieu) REFERENCES lieu(id_lieu)
);
INSERT INTO detailsMatchfoot(id_matchfoot,id_competition,id_equipe,but,cartonJ,cartonR,possesion,passeReussi,aerienGagner,id_lieu,note) VALUES(1,2,1,2,4,1,54,43,12,1,6);
INSERT INTO detailsMatchfoot(id_matchfoot,id_competition,id_equipe,but,cartonJ,cartonR,possesion,passeReussi,aerienGagner,id_lieu,note) VALUES(2,2,2,5,3,0,46,61,12,2,5);
INSERT INTO detailsMatchfoot(id_matchfoot,id_competition,id_equipe,but,cartonJ,cartonR,possesion,passeReussi,aerienGagner,id_lieu,note) VALUES(1,1,3,2,1,1,54,43,12,1,6);
INSERT INTO detailsMatchfoot(id_matchfoot,id_competition,id_equipe,but,cartonJ,cartonR,possesion,passeReussi,aerienGagner,id_lieu,note) VALUES(1,1,4,1,2,0,46,61,12,2,5);

CREATE TABLE defense(
        id_defense INT AUTO_INCREMENT PRIMARY KEY,
        id_matchfoot INT ,
        id_equipe INT,
        id_competition INT ,
        tirspm INT ,
        tacle INT ,
        faute INT ,
        horsJeux INT ,
        note INT,
        id_lieu INT,
    FOREIGN KEY (id_matchfoot) REFERENCES matchfoot(id_matchfoot), 
    FOREIGN KEY (id_competition) REFERENCES competition(id_competition),
    FOREIGN KEY (id_equipe) REFERENCES equipe(id_equipe),
    FOREIGN KEY (id_lieu) REFERENCES lieu(id_lieu)
);
INSERT INTO defense(id_matchfoot,id_equipe,id_competition,tirspm,tacle,faute,horsJeux,note,id_lieu) VALUES (1,3,1,3,2,2,3,5,1);
INSERT INTO defense(id_matchfoot,id_equipe,id_competition,tirspm,tacle,faute,horsJeux,note,id_lieu) VALUES (1,4,1,4,5,2,3,5,1);

CREATE TABLE attaks(
        id_attaks INT AUTO_INCREMENT PRIMARY KEY,
        id_matchfoot INT ,
        id_equipe INT,
        id_competition INT ,
        tirspm INT ,
        tirsCApm INT ,
        driblepm INT ,
        fauteSubitpm INT ,
        note INT,
        id_lieu INT,
    FOREIGN KEY (id_matchfoot) REFERENCES matchfoot(id_matchfoot), 
    FOREIGN KEY (id_competition) REFERENCES competition(id_competition),
    FOREIGN KEY (id_equipe) REFERENCES equipe(id_equipe),
    FOREIGN KEY (id_lieu) REFERENCES lieu(id_lieu)
);
INSERT INTO attaks(id_matchfoot,id_equipe,id_competition,tirspm,tirsCApm,driblepm,fauteSubitpm,Note,id_lieu) VALUES (1,1,1,5,3,5,5,4,1);
INSERT INTO attaks(id_matchfoot,id_equipe,id_competition,tirspm,tirsCApm,driblepm,fauteSubitpm,Note,id_lieu) VALUES (1,2,1,6,2,5,6,4,2);
INSERT INTO attaks(id_matchfoot,id_equipe,id_competition,tirspm,tirsCApm,driblepm,fauteSubitpm,Note,id_lieu) VALUES (2,3,2,5,3,5,5,4,2);
INSERT INTO attaks(id_matchfoot,id_equipe,id_competition,tirspm,tirsCApm,driblepm,fauteSubitpm,Note,id_lieu) VALUES (2,4,2,6,2,5,6,4,1);

CREATE OR REPLACE VIEW V_Matchfoot AS
SELECT
  equipe.nom as Equipe,
  competition.competition as "Competitions",
  SUM(detailsMatchfoot.but) as But,
  SUM(detailsMatchfoot.cartonJ) as Jaune,
  SUM(detailsMatchfoot.cartonR) as Rouge,
  AVG(detailsMatchfoot.possesion) as "Possession",
  AVG(detailsMatchfoot.passeReussi) as "PasseReussi",
  detailsMatchfoot.aerienGagner as "AerienGagner",
  AVG(detailsMatchfoot.note) as "Note"
FROM detailsMatchfoot
JOIN competition ON detailsMatchfoot.id_competition = competition.id_competition
JOIN equipe ON detailsMatchfoot.id_equipe = equipe.id_equipe
JOIN lieu ON detailsMatchfoot.id_lieu = lieu.id_lieu
GROUP BY equipe.nom,competition.competition
;
CREATE OR REPLACE VIEW V_MatchfootDomicile AS
SELECT
  equipe.nom as Equipe,
  competition.competition as "Competitions",
  SUM(detailsMatchfoot.but) as But,
  SUM(detailsMatchfoot.cartonJ) as Jaune,
  SUM(detailsMatchfoot.cartonR) as Rouge,
  AVG(detailsMatchfoot.possesion) as "Possession",
  AVG(detailsMatchfoot.passeReussi) as "PasseReussi",
  detailsMatchfoot.aerienGagner as "AerienGagner",
  ROUND(AVG(detailsMatchfoot.note), 2) as "Note"
FROM detailsMatchfoot
JOIN competition ON detailsMatchfoot.id_competition = competition.id_competition
JOIN equipe ON detailsMatchfoot.id_equipe = equipe.id_equipe
JOIN lieu ON detailsMatchfoot.id_lieu = lieu.id_lieu
WHERE detailsMatchfoot.id_lieu = 1
GROUP BY equipe.nom, competition.competition;

CREATE OR REPLACE VIEW V_Defense AS
SELECT
  equipe.nom as Equipe,
  competition.competition as "Competitions",
  ROUND(AVG(defense.tirspm), 1) as "TirsPm",
  ROUND(AVG(defense.tacle), 1) as "TaclePm",
  ROUND(AVG(defense.faute), 1) as "Faute",
  ROUND(AVG(defense.horsJeux), 1) as "HorsJeux",
  ROUND(AVG(defense.note), 2) as "Note"
FROM defense
JOIN matchfoot ON defense.id_matchfoot = matchfoot.id_matchfoot
JOIN equipe ON defense.id_equipe = equipe.id_equipe
JOIN competition ON defense.id_competition = competition.id_competition
JOIN lieu ON defense.id_lieu = lieu.id_lieu
GROUP BY equipe.nom, competition.competition;


CREATE OR REPLACE VIEW V_Attaks AS
SELECT
  equipe.nom as Equipe,
  competition.competition as "Competitions",
  ROUND(AVG(attaks.tirspm), 1) as "TirsPm",
  ROUND(AVG(attaks.tirsCApm), 1) as "TirsCAPm",
  ROUND(AVG(attaks.driblepm), 1) as "DriblePm",
  ROUND(AVG(attaks.fauteSubitpm), 1) as "FauteSubitPm",
  ROUND(AVG(attaks.note), 2) as "Note"
FROM attaks
JOIN matchfoot ON attaks.id_matchfoot = matchfoot.id_matchfoot
JOIN equipe ON attaks.id_equipe = equipe.id_equipe
JOIN competition ON attaks.id_competition = competition.id_competition
JOIN lieu ON attaks.id_lieu = lieu.id_lieu
GROUP BY equipe.nom, competition.competition;

CREATE OR REPLACE VIEW V_MatchfootExterieur AS
SELECT
  equipe.nom as Equipe,
  competition.competition as "Competitions",
  SUM(detailsMatchfoot.but) as But,
  SUM(detailsMatchfoot.cartonJ) as Jaune,
  SUM(detailsMatchfoot.cartonR) as Rouge,
  AVG(detailsMatchfoot.possesion) as "Possession",
  AVG(detailsMatchfoot.passeReussi) as "PasseReussi",
  detailsMatchfoot.aerienGagner as "AerienGagner",
  ROUND(AVG(detailsMatchfoot.note), 2) as "Note"
FROM detailsMatchfoot
JOIN competition ON detailsMatchfoot.id_competition = competition.id_competition
JOIN equipe ON detailsMatchfoot.id_equipe = equipe.id_equipe
JOIN lieu ON detailsMatchfoot.id_lieu = lieu.id_lieu
WHERE detailsMatchfoot.id_lieu = 2
GROUP BY equipe.nom, competition.competition;



CREATE OR REPLACE VIEW V_AttaksD AS
SELECT
  equipe.nom as Equipe,
  competition.competition as "Competitions",
  ROUND(AVG(attaks.tirspm), 1) as "TirsPm",
  ROUND(AVG(attaks.tirsCApm), 1) as "TirsCAPm",
  ROUND(AVG(attaks.driblepm), 1) as "DriblePm",
  ROUND(AVG(attaks.fauteSubitpm), 1) as "FauteSubitPm",
  ROUND(AVG(attaks.note), 2) as "Note"
FROM attaks
JOIN matchfoot ON attaks.id_matchfoot = matchfoot.id_matchfoot
JOIN equipe ON attaks.id_equipe = equipe.id_equipe
JOIN competition ON attaks.id_competition = competition.id_competition
JOIN lieu ON attaks.id_lieu = lieu.id_lieu
WHERE attaks.id_lieu = 1 
GROUP BY equipe.nom, competition.competition;
CREATE OR REPLACE VIEW V_AttakseE AS
SELECT
  equipe.nom as Equipe,
  competition.competition as "Competitions",
  ROUND(AVG(attaks.tirspm), 1) as "TirsPm",
  ROUND(AVG(attaks.tirsCApm), 1) as "TirsCAPm",
  ROUND(AVG(attaks.driblepm), 1) as "DriblePm",
  ROUND(AVG(attaks.fauteSubitpm), 1) as "FauteSubitPm",
  ROUND(AVG(attaks.note), 2) as "Note"
FROM attaks
JOIN matchfoot ON attaks.id_matchfoot = matchfoot.id_matchfoot
JOIN equipe ON attaks.id_equipe = equipe.id_equipe
JOIN competition ON attaks.id_competition = competition.id_competition
JOIN lieu ON attaks.id_lieu = lieu.id_lieu
WHERE attaks.id_lieu = 12
GROUP BY equipe.nom, competition.competition;

CREATE OR REPLACE VIEW V_DefenseD AS
SELECT
  equipe.nom as Equipe,
  competition.competition as "Competitions",
  ROUND(AVG(defense.tirspm), 1) as "TirsPm",
  ROUND(AVG(defense.tacle), 1) as "TaclePm",
  ROUND(AVG(defense.faute), 1) as "Faute",
  ROUND(AVG(defense.horsJeux), 1) as "HorsJeux",
  ROUND(AVG(defense.note), 2) as "Note"
FROM defense
JOIN matchfoot ON defense.id_matchfoot = matchfoot.id_matchfoot
JOIN equipe ON defense.id_equipe = equipe.id_equipe
JOIN competition ON defense.id_competition = competition.id_competition
JOIN lieu ON defense.id_lieu = lieu.id_lieu
WHERE defense.id_lieu = 1
GROUP BY equipe.nom, competition.competition;
CREATE OR REPLACE VIEW V_DefenseE AS
SELECT
  equipe.nom as Equipe,
  competition.competition as "Competitions",
  ROUND(AVG(defense.tirspm), 1) as "TirsPm",
  ROUND(AVG(defense.tacle), 1) as "TaclePm",
  ROUND(AVG(defense.faute), 1) as "Faute",
  ROUND(AVG(defense.horsJeux), 1) as "HorsJeux",
  ROUND(AVG(defense.note), 2) as "Note"
FROM defense
JOIN matchfoot ON defense.id_matchfoot = matchfoot.id_matchfoot
JOIN equipe ON defense.id_equipe = equipe.id_equipe
JOIN competition ON defense.id_competition = competition.id_competition
JOIN lieu ON defense.id_lieu = lieu.id_lieu
WHERE defense.id_lieu = 2
GROUP BY equipe.nom, competition.competition;
