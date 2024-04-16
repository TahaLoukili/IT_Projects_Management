

--creation des tables
CREATE TABLE Users (
    cin VARCHAR(10),
    username VARCHAR(50),
    password VARCHAR(50),
    role INT,
    PRIMARY KEY (cin)
);

CREATE TABLE Clients (
    id INT PRIMARY KEY,
    nom VARCHAR(50),
    tel VARCHAR(20)
);

CREATE TABLE Devs (
    id INT PRIMARY KEY,
    username VARCHAR(50)
);

CREATE TABLE Chefs (
    id INT PRIMARY KEY,
    username VARCHAR(50)
);

CREATE TABLE technologies (
    id INT PRIMARY KEY,
    nom VARCHAR(50)
);

CREATE TABLE methodologies (
    id INT PRIMARY KEY,
    nom VARCHAR(50)
);

CREATE TABLE devTech (
    id INT PRIMARY KEY,
    idDev INT,
    idTech INT,
    FOREIGN KEY (idDev) REFERENCES Devs(id),
    FOREIGN KEY (idTech) REFERENCES technologies(id)
);

CREATE TABLE projets (
    id INT PRIMARY KEY,
    nom VARCHAR(50) UNIQUE,
    description VARCHAR(255),
    idclient INT,
    dateDemarage DATE,
    dateLivraison DATE,
    dateReunion DATE,
    nbrJourDev INT,
    idChef INT,
    idMethodologie INT,
    FOREIGN KEY (idclient) REFERENCES Clients(id),
    FOREIGN KEY (idChef) REFERENCES Chefs(id),
    FOREIGN KEY (idMethodologie) REFERENCES methodologies(id)
);

CREATE TABLE projetTechs (
    id INT PRIMARY KEY,
    idProjet INT,
    idTech INT,
    FOREIGN KEY (idProjet) REFERENCES projets(id),
    FOREIGN KEY (idTech) REFERENCES technologies(id)
);

CREATE TABLE equipes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    idProjet INT,
    FOREIGN KEY (idProjet) REFERENCES projets(id)
);



CREATE TABLE membresEquipe (
    idEquipe INT,
    idDev INT,
    PRIMARY KEY (idEquipe, idDev),
    FOREIGN KEY (idEquipe) REFERENCES equipes(id),
    FOREIGN KEY (idDev) REFERENCES Devs(id)
);
DELIMITER //

CREATE TRIGGER delete_membresEquipe_before
BEFORE DELETE ON equipes
FOR EACH ROW
BEGIN
    DELETE FROM membresEquipe WHERE idEquipe = OLD.id;
END;
//

DELIMITER ;


CREATE TABLE services (
    id INT  PRIMARY KEY,
    description VARCHAR(255),
    duree INT
);

CREATE TABLE projetServices (
    id INT AUTO_INCREMENT PRIMARY KEY,
    idProjet INT,
    idService INT,
    FOREIGN KEY (idProjet) REFERENCES projets(id),
    FOREIGN KEY (idService) REFERENCES services(id)
);

CREATE TABLE taches (
    id INT AUTO_INCREMENT PRIMARY KEY,
    idDev INT,
    nom VARCHAR(50),
    idService INT,
    avancement INT,
    FOREIGN KEY (idDev) REFERENCES Devs(id),
    FOREIGN KEY (idService) REFERENCES services(id)
);

CREATE TABLE notificationChef (
    id INT AUTO_INCREMENT PRIMARY KEY,
    idChef INT,
    message TEXT,
    viewed TINYINT(1)
);

CREATE TABLE notificationDev (
    id INT AUTO_INCREMENT PRIMARY KEY,
    idDev INT,
    message TEXT,
    viewed TINYINT(1)
);




-- TRIGGERS
DROP TRIGGER IF EXISTS delete_project_trigger;

DELIMITER //
CREATE TRIGGER delete_project_trigger
BEFORE DELETE ON projets
FOR EACH ROW
BEGIN
    DECLARE proj_id INT;
    SET proj_id = OLD.id;

    -- Delete from projetTechs table
    DELETE FROM projetTechs WHERE idProjet = proj_id;

    -- Delete from equipes table
    DELETE FROM equipes WHERE idProjet = proj_id;

    -- Delete related taches using equipes as an intermediate table
    DELETE FROM taches WHERE idDev IN (SELECT id FROM Devs WHERE id IN (SELECT idDev FROM equipes WHERE idProjet = proj_id));
END;
//
DELIMITER ;


--autoIncrement
--project table
SET FOREIGN_KEY_CHECKS = 0;
ALTER TABLE projets MODIFY id INT AUTO_INCREMENT;
SET FOREIGN_KEY_CHECKS = 1;

--chefs table
SET FOREIGN_KEY_CHECKS = 0;
ALTER TABLE methodologies MODIFY id INT AUTO_INCREMENT;
SET FOREIGN_KEY_CHECKS = 1;

--technologies table
SET FOREIGN_KEY_CHECKS = 0;
ALTER TABLE technologies MODIFY id INT AUTO_INCREMENT;
SET FOREIGN_KEY_CHECKS = 1;


--projetTech table
ALTER TABLE projetTechs
MODIFY COLUMN id INT AUTO_INCREMENT;

--equipe table
ALTER TABLE equipes
MODIFY COLUMN id INT AUTO_INCREMENT;

--services table
SET FOREIGN_KEY_CHECKS = 0;
ALTER TABLE services MODIFY id INT AUTO_INCREMENT;
SET FOREIGN_KEY_CHECKS = 1;

--taches table
SET FOREIGN_KEY_CHECKS = 0;
ALTER TABLE taches MODIFY id INT AUTO_INCREMENT;
SET FOREIGN_KEY_CHECKS = 1;

--insertion
INSERT INTO technologies(id,nom)
VALUES
    (1,".NET"),
    (2,"JEE"),
    (3,"php"),
    (4,"Reac");

INSERT INTO methodologies(id,nom)
VALUES
    (1,"Agile"),
    (2,"XP");

INSERT INTO Users (cin, username, password, role)
VALUES 
    ('AB1234', 'Directeur', 'password1', 1),
    ('CD4567', 'Chef', 'password2', 2),
    ('EF8910', 'Dev', 'password3', 3),
    ('AB1239', 'yousef','yousef',3),
    ('AB1230', 'oussama','oussama',3),
    ('AB1232', 'mohamed','mohamed',3),
    ('AB1236', 'anouar','anouar',3),
    ('AB1288','taha','taha',2),
    ('AB1277','marwane','marwane',2);
INSERT INTO Devs (id, username)
VALUES
    (1, 'yousef'),
    (2, 'oussama'),
    (3, 'mohamed'),
    (4, 'anouar');

INSERT INTO Chefs (id, username)
VALUES 
    (1, 'Chef'),
     (2, 'taha'),
      (3, 'marwane');


INSERT INTO Clients (id, nom, tel)
VALUES 
    (1, 'FST', '0655443322'),
    (2, 'CITYBUS', '0611223355');
    
-- Inserting data into the DevTech table
INSERT INTO devTech (id, idDev, idTech)
VALUES 
    (1, 1, 2), 
    (2, 1, 4),
    (3, 1, 3),
    (4, 2, 4),
    (5, 2, 1),
    (6, 3, 2),
    (7, 4, 4),
    (8, 4, 3),
    (9, 4, 1); 

-- Inserting data into the projets table
INSERT INTO projets (
    id, nom, description, idclient, dateDemarage, dateLivraison, dateReunion, nbrJourDev, idChef, idMethodologie
)
VALUES 
    (1, 'Project Alpha', 'Description for Project Alpha', 1, '2023-01-01', '2023-06-30', '2023-07-01', 100, 1, 1),
    (2, 'Project Beta', 'Description for Project Beta', 2, '2023-03-15', '2023-09-30', '2023-10-01', 150, 1, 2);


-- Inserting data into the projetTechs table
INSERT INTO projetTechs (id, idProjet, idTech)
VALUES 
    (1, 1, 1), 
    (2, 1, 4), 
    (3, 2, 2), 
    (4, 2, 3); 

-- Inserting data into the equipes table
INSERT INTO equipes (id, idProjet)
VALUES 
    (1, 1), 
    (2, 2); 

-- Inserting data into the services table
INSERT INTO services (id, description, duree)
VALUES 
    (1, 'Service for Project Alpha', 50),
    (2, 'Service for Project Beta', 75);



-- Inserting data into the taches table
INSERT INTO taches (id, idDev, idService, avancement)
VALUES 
    (1, 1, 1, 25), 
    (2, 1, 2, 50); 


    UPDATE projets SET nom = 'Project1 ', description = 'description1',  idChef = 2, idMethodologie = 2, WHERE id = 1;


    INSERT INTO projets (nom, description, dateDemarage, dateLivraison, idChef) VALUES ('project insert1', 'desc','2023-01-01', '2023-06-30' , 1);