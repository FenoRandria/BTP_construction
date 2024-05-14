create database btp_construction;

\c btp_construction;

-- create table users(
--     id serial primary key not null,
--     nom varchar(255) not null,
--     mail varchar(255) not null,
--     mdp varchar(255) not null,
--     corbeille int default 0,
--     createdAt TIMESTAMP DEFAULT NOW()
-- );

-- INSERT INTO users (nom, mail, mdp, corbeille, createdAt)
-- VALUES 
--     ('Admin', 'admin@gmail.com', 'admin', 0, NOW()),
--     ('Alice', 'alice@gmail.com', 'alice', 0, NOW()),
--     ('Bob', 'bob@gmail.com', 'bob', 0, NOW());

-- create table roles(
--     id serial primary key not null,
--     rolename varchar(255) not null,
--     corbeille int default 0,
--     createdAt TIMESTAMP DEFAULT NOW()
-- ) ;

-- INSERT INTO roles (rolename)
-- VALUES 
--     ('Admin'),
--     ('User') ;

-- create table userroles(
--     id serial primary key not null,
--     idUser INT REFERENCES users(id),
--     idRole INT REFERENCES roles(id),
--     createdAt TIMESTAMP DEFAULT NOW()
-- );

-- insert into userroles (idUser,idRole) VALUES
--     (1,1),
--     (2,2),
--     (3,2);


-- ------------------------------------------------------------------------------------------------------------------------------------------------------
create table users(
    id serial primary key not null,
    nom varchar(255),
    mail varchar(255),
    numero varchar(14),
    mdp varchar(255),
    corbeille int default 0,
    createdAt TIMESTAMP DEFAULT NOW()
);


-- ------------------------------------------------------------------------------------------------------------------------------------------------------

create table typeFinition(
    id serial primary key not null,
    typeFinition varchar(255) not null,
    pourcentage numeric(10,2) not null,
    createdAt TIMESTAMP DEFAULT NOW()
);

insert into typeFinition (typeFinition,pourcentage)values
('Standard',1),
('Premium',1.2),
('V.I.P',1.3),
('Gold',1.4);

-- ------------------------------------------------------------------------------------------------------------------------------------------------------

create table typeMaison(
    id serial primary key not null,
    nom varchar(255),
    descriptions text not null default 'aucune',
    photos varchar(255) not null,
    nbJourConstruction numeric(3,2),
    corbeille int default 0,
    createdAt TIMESTAMP DEFAULT NOW()
);

-- Insert 1: Modern house
INSERT INTO typeMaison (nom, descriptions, photos, nbJourConstruction) VALUES 
    ('Maison Moderne', '2 chambres, 2 salles de bain, une terrasse spacieuse', 'class1.jpeg', 6.5),
    ('Loft Spacieux', 'Grand espace ouvert, 1 chambre en mezzanine, emplacement parking', 'class2.jpeg', 4.0),
    ('Villa de Luxe', 'Piscine privée, 3 chambres avec salle de bain attenante, jardin paysagé', 'class3.jpeg', 8.0),
    ('Bungalow Confortable', '1 chambre, 1 salle de bain, salon avec cheminée', 'class1.jpeg', 3.5),
    ('Studio Lumineux', 'Pièce principale avec cuisine intégrée, salle de bain moderne', 'class4.jpeg', 1.0);


-- ------------------------------------------------------------------------------------------------------------------------------------------------------

create table detailDevisMaison(
    id serial primary key not null,
    descriptions text not null default 'aucune',
    prixUnitaire numeric(9,2) not null,
    quantite numeric(9,2) not null,
    unite varchar(10),
    idTypeMaison int REFERENCES typeMaison(id) not null,
    corbeille int default 0,
    createdAt TIMESTAMP DEFAULT NOW()
);

INSERT INTO detailDevisMaison (descriptions, quantite, prixUnitaire, unite, idTypeMaison)
VALUES 
    ('mur de soutènement et demi Clôture ht 1m', 25, 190000.00, 'm3', 1),
    ('maçonnerie de moellons, ep= 35cm', 150, 10100.50, 'm2', 1),
    ('béton armé dosé à 350kg/m3: semelles isolées', 15.5, 36000, 'm2', 1),
    ('béton armé dosé à 350kg/m3: amorces poteaux', 900, 63000, 'm3', 1),
    ('béton armé dosé à 350kg/m3: chaînage bas de 20x20', 720, 56000, 'm3', 1),
    ('Décapage des terrains meubles', 1.00, 189200.00, 'fft', 1),
    ('Dressage du plateforme', 160, 56000, 'm2', 1),
    ('Fouille d''ouvrage terrain ferme', 106, 37800.80, 'm2', 1),
    ('Remblai d''ouvrage', 24.44, 229514.29, 'm3', 1),
    ('Travaux d''implantation', 780.55, 585000.49, 'm3', 1),
    ('béton ordinaire dosé à 300kg/m3 pour forr', 14.40, 39075.62, 'm3', 1),
    ('chape de 2cm', 800.55, 555010.80, 'm3', 1),
    ('remblai technique', 30080.30, 780.55, 'm3', 1),
    ('herrissonage ep=10', 321000.85, 200.85, 'm3', 1);

INSERT INTO detailDevisMaison (descriptions, quantite, prixUnitaire, unite, idTypeMaison)
VALUES 
    ('mur de soutènement et demi Clôture ht 1m', 30, 180000.00, 'm3', 2),
    ('maçonnerie de moellons, ep= 35cm', 160, 10500.00, 'm2', 2),
    ('béton armé dosé à 350kg/m3: semelles isolées', 13, 35000.00, 'm2', 2),
    ('béton armé dosé à 350kg/m3: amorces poteaux', 850, 62000.00, 'm3', 2),
    ('béton armé dosé à 350kg/m3: chaînage bas de 20x20', 690, 54000.00, 'm3', 2),
    ('Décapage des terrains meubles', 1.00, 180000.00, 'fft', 2),
    ('Dressage du plateforme', 150, 54000.00, 'm2', 2),
    ('Fouille d''ouvrage terrain ferme', 100, 36000.00, 'm2', 2),
    ('Remblai d''ouvrage', 24.44, 229514.29, 'm3', 2),
    ('Travaux d''implantation', 750.00, 580000.49, 'm3', 2),
    ('béton ordinaire dosé à 300kg/m3 pour forr', 12.00, 38075.62, 'm3', 2),
    ('chape de 2cm', 750.00, 550010.80, 'm3', 2),
    ('remblai technique', 32080.30, 800.55, 'm3', 2),
    ('herrissonage ep=10', 321000.85, 200.85, 'm3', 2);




insert into devis (iduser,descriptions,idtypefinition,idtypemaison,datedebut,datefin,montant,pourcentagefinition) values 
(
    id,
    ?,
    ?,
    ?,
    'datedebut',
    SELECT '2024-05-13'::DATE + (SELECT nbjourconstruction * INTERVAL '1 day' FROM typemaison where id = ?),
    select sum(quantite*prixunitaire) as montant from detaildevismaison where idtypemaison = ?,
    select pourcentage from typeFinition where id =?
);


insert into devis  (idUser,) values (select sum(quantite*prixunitaire) as montant from detaildevismaison where idtypemaison = 1 group by idtypemaison)

-- ------------------------------------------------------------------------------------------------------------------------------------------------------

create table Devis(
    id serial primary key not null,
    idUser int REFERENCES users (id) not null,
    descriptions text not null default 'aucune',
    idTypeFinition int REFERENCES typeFinition(id) not null,
    idTypeMaison int REFERENCES typeMaison(id) not null,
    dateDebut DATE DEFAULT NOW() not null,
    dateFin DATE,
    montant numeric(10,2),
    pourcentageFinition  numeric(10,2) not null, 
    etatDevis int default 0,
    corbeille int default 0,
    createdAt TIMESTAMP DEFAULT NOW()
);


create table paiement(
    id serial primary key not null,
    idDevis int REFERENCES Devis(id) not null,
    montant numeric(20,2) not null,
    datePaiement TIMESTAMP not null
);

INSERT INTO payment (idDevis, montant, datePayment) VALUES
(1, 500.00, '2024-05-14 08:30:00');
(2, 750.75, '2024-05-11 10:00:00');


insert into users (numero) values ('0345137423') returning *




-- view pdf :

CREATE OR REPLACE VIEW v_detaildevismaison AS (
    SELECT 
        detaildevismaison.id AS idDetail,
        devis.iduser,
        devis.id AS idDevis,
        devis.montant, 
        devis.idtypemaison,
        detaildevismaison.descriptions,                                      
        detaildevismaison.prixunitaire,
        detaildevismaison.quantite, 
        detaildevismaison.unite,
        detaildevismaison.quantite * detaildevismaison.prixunitaire AS sousmontant 
    FROM devis
    JOIN typemaison ON devis.idtypemaison = typemaison.id
    JOIN detaildevismaison ON typemaison.id = detaildevismaison.idtypemaison
);


Create or replace view v_DevisMois as 
    SELECT 
        EXTRACT(YEAR FROM dateDebut) AS year,
        EXTRACT(MONTH FROM dateDebut) AS month,
        TO_CHAR(dateDebut, 'Month') AS month_name,
        SUM(montant) AS montantTotal
    FROM 
        devis
    GROUP BY 
        EXTRACT(YEAR FROM dateDebut), EXTRACT(MONTH FROM dateDebut), TO_CHAR(dateDebut, 'Month')
    ORDER BY 
        year, month;

------------------------------------------------------------------------------------------

Create or replace view v_DevisAnnee as 
SELECT 
    EXTRACT(YEAR FROM dateDebut) AS year,
    SUM(montant) AS montantTotal
FROM 
    devis
GROUP BY 
    EXTRACT(YEAR FROM dateDebut)
ORDER BY year;




-- --------------------------------------------------------------------------------------
-- JOUR 2 EVALUATION ---------------------------------------------------------------------------
CREATE TABLE Import_maison_travaux (
    travaux_type_maison VARCHAR(30) NOT NULL,
    travaux_maison_descrit VARCHAR(200) NOT NULL,
    travaux_maison_surf numeric(20,2) default 0 NOT NULL,
    travaux_code int default 0 NOT NULL,
    travaux_type text not null default 'aucune',
    travaux_unite VARCHAR(30) NOT NULL,
    travaux_maison_pu numeric(20,2) default 0 NOT NULL,
    travaux_maison_quantite numeric(20,2) default 0 NOT NULL,
    travaux_duree numeric(20,2) default 0 NOT NULL
);

create table Import_devis (
    devis_client_num VARCHAR(50) NOT NULL,
    devis_refs  VARCHAR(50) NOT NULL,
    devis_type_maison VARCHAR(30) NOT NULL,
    devis_type_finition VARCHAR(30) NOT NULL,
    devis_taux_finition numeric(20,2),
    devis_date DATE default now() not null,
    devis_dateDebut DATE default now() not null,
    devis_lieu VARCHAR(50) NOT NULL
);

create table Import_paiement (
    devis_refs  VARCHAR(50) NOT NULL,
    paiement_refs VARCHAR(50) NOT NULL,
    paiement_date DATE default now() not null,
    paiement_montant numeric(20,2) not null
);