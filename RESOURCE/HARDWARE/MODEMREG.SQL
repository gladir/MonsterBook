CREATE TABLE ModemRegister (
   Code        BYTE PRIMARY KEY,
   Mode        BYTE,
   Description VARCHAR
);

CREATE INDEX;

INSERT INTO Modem VALUES (0,0,'Nombre de sonnerie avant de r‚pondre');
INSERT INTO Modem VALUES (1,0,'Compteur de sonnerie');
INSERT INTO Modem VALUES (2,5,'CaractŠre d''Echappement');
INSERT INTO Modem VALUES (3,5,'CaractŠre de Retour de chariot');
INSERT INTO Modem VALUES (4,5,'CaractŠre de Saut de ligne');
INSERT INTO Modem VALUES (5,5,'CaractŠre d''espace en arriŠre');
INSERT INTO Modem VALUES (6,1,'Pause entre les pulsations sonore');
INSERT INTO Modem VALUES (7,1,'Attente avant de r‚pondre');
INSERT INTO Modem VALUES (8,1,'Pause entre le point dans le num‚ro t‚l‚phone');
INSERT INTO Modem VALUES (9,1,'Temps pour raccrocher');
INSERT INTO Modem VALUES (10,2,'Temps pour un "HangUp"');
INSERT INTO Modem VALUES (11,3,'Vitesse du pulsation sonore');
INSERT INTO Modem VALUES (12,4,'Temps d''attente pour les Echappements');

