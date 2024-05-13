create database btp_construction;

\c btp_construction;

create table users(
    id serial primary key not null,
    nom varchar(255) not null,
    mail varchar(255) not null,
    mdp varchar(255) not null,
    corbeille int default 0,
    createdAt TIMESTAMP DEFAULT NOW()
);

INSERT INTO users (nom, mail, mdp, corbeille, createdAt)
VALUES 
    ('Admin', 'admin@gmail.com', 'admin', 0, NOW()),
    ('Alice', 'alice@gmail.com', 'alice', 0, NOW()),
    ('Bob', 'bob@gmail.com', 'bob', 0, NOW());

create table roles(
    id serial primary key not null,
    rolename varchar(255) not null,
    corbeille int default 0,
    createdAt TIMESTAMP DEFAULT NOW()
) ;

INSERT INTO roles (rolename)
VALUES 
    ('Admin'),
    ('User') ;

create table userroles(
    id serial primary key not null,
    idUser INT REFERENCES users(id),
    idRole INT REFERENCES roles(id),
    createdAt TIMESTAMP DEFAULT NOW()
);

insert into userroles (idUser,idRole) VALUES
    (1,1),
    (2,2),
    (3,2);




-- ---------------------J1  ----------------------------------
CREATE TABLE parking (
    id SERIAL PRIMARY KEY,
    lieu VARCHAR(50),
    nbPlace int,
    corbeille int default 0,
    createdAt TIMESTAMP DEFAULT NOW()
);

INSERT INTO parking (lieu, nbPlace) VALUES ('Tanjombato VB III 007', 15);
-- ---------------------- J1 ---------------------------------
CREATE TABLE place (
    id SERIAL PRIMARY KEY,
    numero VARCHAR(50),
    idParking int REFERENCES parking(id),
    corbeille int default 0,
    createdAt TIMESTAMP DEFAULT NOW()
);
INSERT INTO place (numero,idParking) VALUES 
('A101',1),
('B202',1),
('C303',1),
('D404',1),
('E505',1),
('F606',1),
('G707',1),
('H808',1),
('I909',1),
('J1010',1);

-- -------------------- J1 -----------------------------------
CREATE TABLE temps (
    id SERIAL PRIMARY KEY,
    dureeMinute int
);

INSERT INTO temps (dureeMinute)  VALUES 
(15),
(30),
(45),
(60),
(75),
(90),
(105),
(120),
(135),
(150);
-- ---------------------- J1 ---------------------------------
CREATE TABLE placementVoiture (
    id SERIAL PRIMARY KEY,
    idUser int REFERENCES users(id) not null,
    idPlace int REFERENCES place(id) not null,
    idTemp int REFERENCES temps(id) not null,
    immatriculation VARCHAR(10) not null,
    marque VARCHAR(50) not null,
    dateAjout timestamp not null default now(),
    corbeille int default 0,
    createdAt TIMESTAMP DEFAULT NOW()
);

-- ---------------------- J1 ---------------------------------
CREATE TABLE enlevementVoiture (
    id SERIAL PRIMARY KEY,
    idPlacement int REFERENCES placementVoiture(id),
    dateEnlevement TIMESTAMP NOT NULL DEFAULT NOW(),
    corbeille int default 0,
    createdAt TIMESTAMP DEFAULT NOW()
);



-- ------------------- J2 ------------------------------------
CREATE TABLE tarifPlace  (
    id SERIAL PRIMARY KEY,
    idTemp int REFERENCES temps(id),
    idPlace int REFERENCES place (id),
    prix NUMERIC(9,2)
);


create or replace view v_stationement as
select 
    pv.id as idStation,
    iduser,
    immatriculation,
    marque,
    dateajout,
    p.id as placeId,
    p.numero,
    t.id as idTemp,
    t.dureeminute,
    park.id as idParking,
    park.lieu
from 
    placementVoiture pv, 
    place p, 
    temps t, 
    parking park
where 
    pv.idPlace = p.id and 
    idTemp = t.id and
    pv.corbeille = 0;


create or replace view v_stationemntEnlevement as
select 
    *
from 
    enlevementVoiture as ev,
    v_stationemnt pv
where 
    ev.idPlacement = pv.idStation;

-- -------------------
update placementVoiture set corbeille = 1 where id = ?;


















-- -------------------------------------------------------
CREATE TABLE test (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(50),
    dtn DATE,
    salaire NUMERIC(10, 2),
    date_embauche DATE,
    heure_arrivee TIME,
    timestamp_creation TIMESTAMP,
    est_actif BOOLEAN,
    descriptions TEXT
);

-- ----------------------------------------------------
INSERT INTO test (nom, dtn, salaire, date_embauche, heure_arrivee, timestamp_creation, est_actif, descriptions) 
VALUES 
('John Doe', '1990-05-15', 50000.00, '2020-01-10', '08:00:00', '2022-03-20 10:30:00', true, 'Description de John Doe'),
('Jane Smith', '1985-08-20', 60000.50, '2019-12-01', '09:15:00', '2022-04-05 09:00:00', true, 'Description de Jane Smith'),
('Alice Johnson', '1992-11-12', 45000.75, '2021-02-28', '08:30:00', '2022-05-10 11:45:00', false, 'Description de Alice Johnson'),
('Bob Williams', '1988-03-25', 70000.25, '2020-03-15', '07:45:00', '2022-06-15 08:45:00', true, 'Description de Bob Williams'),
('Emily Brown', '1995-07-30', 55000.00, '2021-04-05', '09:00:00', '2022-07-20 09:30:00', true, 'Description de Emily Brown'),
('Michael Davis', '1993-09-18', 48000.25, '2020-05-20', '08:15:00', '2022-08-01 10:00:00', true, 'Description de Michael Davis'),
('Sarah Martinez', '1991-12-05', 62000.00, '2021-01-02', '08:45:00', '2022-09-10 09:15:00', false, 'Description de Sarah Martinez'),
('Daniel Rodriguez', '1987-06-22', 53000.50, '2020-06-10', '09:30:00', '2022-10-05 11:00:00', true, 'Description de Daniel Rodriguez'),
('Olivia Wilson', '1994-02-14', 68000.75, '2021-03-01', '08:00:00', '2022-11-15 08:30:00', true, 'Description de Olivia Wilson'),
('James Taylor', '1989-10-08', 47000.00, '2020-04-15', '08:45:00', '2022-12-20 10:45:00', false, 'Description de James Taylor'),
('Emma Anderson', '1990-04-01', 59000.25, '2021-02-15', '09:00:00', '2023-01-10 09:00:00', true, 'Description de Emma Anderson'),
('William Garcia', '1986-08-12', 51000.00, '2020-07-05', '08:15:00', '2023-02-05 09:30:00', true, 'Description de William Garcia'),
('Ava Hernandez', '1993-05-28', 65000.50, '2021-05-10', '08:30:00', '2023-03-20 11:15:00', true, 'Description de Ava Hernandez'),
('Liam Lopez', '1988-11-15', 49000.75, '2020-08-20', '09:00:00', '2023-04-15 08:15:00', true, 'Description de Liam Lopez'),
('Isabella Martinez', '1995-01-10', 63000.00, '2021-06-01', '09:15:00', '2023-05-01 09:45:00', false, 'Description de Isabella Martinez'),
('Noah Clark', '1992-07-02', 54000.25, '2020-09-25', '08:45:00', '2023-06-10 10:30:00', true, 'Description de Noah Clark'),
('Sophia Lee', '1989-03-18', 67000.00, '2020-10-10', '08:00:00', '2023-07-05 11:00:00', true, 'Description de Sophia Lee'),
('Mason King', '1994-09-05', 48000.50, '2021-07-05', '08:15:00', '2023-08-20 08:45:00', false, 'Description de Mason King'),
('Charlotte Scott', '1987-01-30', 60000.75, '2020-11-20', '08:30:00', '2023-09-15 09:30:00', true, 'Description de Charlotte Scott'),
('Ethan Green', '1991-06-18', 52000.00, '2020-12-15', '08:45:00', '2023-10-10 10:15:00', true, 'Description de Ethan Green'),
('Amelia Hall', '1996-04-22', 64000.25, '2021-08-10', '09:00:00', '2023-11-01 11:45:00', true, 'Description de Amelia Hall'),
('Benjamin Adams', '1986-10-25', 50000.00, '2021-01-05', '09:15:00', '2023-12-05 08:30:00', false, 'Description de Benjamin Adams'),
('Harper Baker', '1990-02-08', 66000.50, '2021-09-20', '09:30:00', '2024-01-10 09:00:00', true, 'Description de Harper Baker'),
('Alexander Young', '1988-08-02', 47000.75, '2021-02-10', '08:00:00', '2024-02-15 10:30:00', true, 'Description de Alexander Young');




