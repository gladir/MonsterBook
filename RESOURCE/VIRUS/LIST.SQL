CREATE TABLE ListeVirus (
   ID           WORD PRIMARY KEY,
   Annee        WORD, // AnnÇe dÇcouvert
   Mois         BYTE, // Mois dÇcouvert
   NiveauDanger BYTE, // 4=Tres dangereux, 3=Dangereux, 2=Moyen, 1=Derangeant, 0=Inoffensif
   Nom          VARCHAR,
   Symotomes    VARCHAR
);

CREATE INDEX;

INSERT INTO ListeVirus VALUES (0x0001,1990,06,1,'1008','Augmente la taille de COMMAND.COM, des erreurs internes de pile, l''arràt du systäme lors du dÇmarrage');
INSERT INTO ListeVirus VALUES (0x0002,1990,07,3,'1226','Augmente la taille des fichiers COM, incapable de charger certains programmes, dimine la mÇmoire disponible, blocage du systäme, caractäres Çtranges sur Çcran Ö la place de l''exÇcutable du programme, action non sollicitÇ des unitÇs');
INSERT INTO ListeVirus VALUES (0x0003,1990,01,2,'1260','Augmente la taille des fichiers COM (1260 octets)');
INSERT INTO ListeVirus VALUES (0x0004,1990,06,2,'1381','Augmente la taille des fichiers EXE');
INSERT INTO ListeVirus VALUES (0x0005,1990,09,1,'1605','Augmente la taille des fichiers COM et EXE ainsi qu''une baisse des performances du systäme');
INSERT INTO ListeVirus VALUES (0x0006,1990,04,1,'8 Tunes','Augmente la taille des fichiers COM et EXE et dimine la mÇmoire disponible ainsi que de la musique');
INSERT INTO ListeVirus VALUES (0x0007,1990,07,1,'382','Blocage du systäme lors de l''exÇcution de programmes, caractäres Çtranges sur Çcran, lecteur tourne sans arràt et redÇmarrage occasionnel');
INSERT INTO ListeVirus VALUES (0x0008,1990,05,4,'5120','Augmente la taille des fichiers COM et EXE, altäre des fichiers et des secteurs de dÇmarrage ainsi qu''une activitÇ non sollicitÇ du disque');
INSERT INTO ListeVirus VALUES (0x0009,1989,00,2,'Aids','Plantages du systäme lors de l''exÇcution de programmes.');
INSERT INTO ListeVirus VALUES (0x000A,1990,04,1,'Aids II','Apparition de fichiers COM ainsi que des messages et de la musique');
INSERT INTO ListeVirus VALUES (0x000B,1989,12,4,'Aids Info','Destruction immÇdiate de la FAT');
INSERT INTO ListeVirus VALUES (0x000C,1990,07,1,'AirCop','Blocage du systäme, affichage de messages, diminution de mÇmoire, modification du secteur de dÇmarrage');
INSERT INTO ListeVirus VALUES (0x000D,1990,10,4,'Alabama','Augmente la taille des fichiers EXE, affichage de messages, dÇmarrage de programmes autres que ceux demandÇs');
INSERT INTO ListeVirus VALUES (0x000E,1990,06,1,'Ambulance','Augmente la taille des fichiers COM de 796 octets, affichage d''une ambulance ainsi que le bruit d''une siräne.');
INSERT INTO ListeVirus VALUES (0x000F,1990,03,2,'Amoeba','Augmente la taille des fichiers EXE et COM ainsi qu''une modification de leur date de crÇation');
INSERT INTO ListeVirus VALUES (0x0010,1989,11,1,'Amstrad','Augmente la taille des fichiers COM de 847 octets, des erreurs de paritÇ mÇmoire ainsi que l''affichage de messages.');
INSERT INTO ListeVirus VALUES (0x0011,1990,07,4,'Anthrax','Augmente la taille de fichiers COM et EXE');
INSERT INTO ListeVirus VALUES (0x0012,1990,06,3,'Anti-Pascal','Augmente la taille des fichiers COM ainsi que la disparition des fichiers PAS et BAK');
INSERT INTO ListeVirus VALUES (0x0013,1990,06,2,'Armagedon','Augmente la taille de fichiers COM de 1079 caractäres ainsi qu''une activitÇ non sollicitÇ des ports sÇrie');
INSERT INTO ListeVirus VALUES (0x0014,1989,09,1,'Ashar','Modifie le secteur de dÇmarrage et le nom du volume du disque');
INSERT INTO ListeVirus VALUES (0x0015,1990,09,2,'Black Monday','Augmente la taille des fichiers COM et EXE de 1055 octets');
INSERT INTO ListeVirus VALUES (0x0016,1990,08,2,'Blood','Augmente la taille des fichiers COM, redÇmarrage et blocage du systäme, effets de cascade des caractäres');
INSERT INTO ListeVirus VALUES (0x0017,1986,00,1,'Brain','Modifie le nom de volume en (c) Brain');
INSERT INTO ListeVirus VALUES (0x0018,1990,00,2,'Burger','Blocages du systäme lors d''exÇcution de programmes');
INSERT INTO ListeVirus VALUES (0x0019,1989,12,4,'Chaos','Modifie le secteur de dÇmarrage');
INSERT INTO ListeVirus VALUES (0x001A,1990,11,2,'Carioca','Augmente la taille des fichiers COM de 951 octets');
INSERT INTO ListeVirus VALUES (0x001B,1989,01,2,'Cascade','Augmente la taille des fichiers COM de 1701 octets, chute de caractäres Ö l''Çcran et formtage du disque dur');
INSERT INTO ListeVirus VALUES (0x001C,1990,08,4,'Casper','Augmentation de la taille des fichiers COM de 1200 octets et secteur introuvable');
INSERT INTO ListeVirus VALUES (0x001D,1990,09,2,'Christmas in Japan','Augmente la taille de des fichers COM et affichage de messages de Noâl');
INSERT INTO ListeVirus VALUES (0x001E,1989,09,4,'Dark Avenger','Augmente la taille de fichiers exÇcutable et destruction de donnÇes');
INSERT INTO ListeVirus VALUES (0x001F,1989,04,4,'Datacrime','Augmente la taille des fichiers COM, blocage de l''ordinateur et destruction des donnÇes du disque dur');
INSERT INTO ListeVirus VALUES (0x0020,1990,11,2,'Datalock','Augmente la taille des COMMAND.COM et des fichiers EXE, diminue la mÇmoire de 2048 octets et modifie la date et l''heure de crÇation des fichiers');
INSERT INTO ListeVirus VALUES (0x0021,1988,09,4,'dBase','Augmente la taille des fichiers COM de 1864 octets, destruction de fichiers DBF et Çcrasement du rÇpertoire principal et de la FAT');
INSERT INTO ListeVirus VALUES (0x0022,1989,12,2,'December 24th','Augmente la taille des fichiers EXE et diminution non justifiÇe de l''espace disque disponible');
INSERT INTO ListeVirus VALUES (0x0023,1988,09,2,'Den Zuk','Destruction du contenu des disquettes 3´ et 1,2 Mo, modifie le nom de volume du disque et affichage de messages');
INSERT INTO ListeVirus VALUES (0x0024,1989,12,4,'Devil''s Dance','Augmente la taille des fichiers COM de 951 octets, impossibilitÇ de dÇmarrer certains programmes, modification de l''affichage et pertes de donnÇes');
INSERT INTO ListeVirus VALUES (0x0025,1990,05,2,'Diamond','Diminue la mÇmoire disponible et plantages du systäme');
INSERT INTO ListeVirus VALUES (0x0026,1989,04,4,'Disk Killer','Affichage de messages suivi de destruction des donnÇes du disque dur');
INSERT INTO ListeVirus VALUES (0x0027,1989,10,2,'Do-Nothing','Augmente la taille des fichiers COM de 608 octets');
INSERT INTO ListeVirus VALUES (0x0028,1990,10,1,'Dot Killer','Augmente la taille des fichiers COM de 944 octets et disparition des points (.) de l''Çcran');
INSERT INTO ListeVirus VALUES (0x0029,1990,04,4,'Eddie II','Augmente la taille de fichiers COM et EXE, diminue la mÇmoire disponible et erreurs d''allocation de fichiers');
INSERT INTO ListeVirus VALUES (0x002A,1990,01,4,'EDV','Perte des fichiers situÇs sur les disquettes et le disque dur et blocages du systäme');
INSERT INTO ListeVirus VALUES (0x002B,1990,11,4,'Father Christmas','Augmente la taille des fichiers COM de 1881 octets, unitÇ d''allocation perdus, mÇlange des fichiers ainsi que l''affichage de divers messages ou graphiques');
INSERT INTO ListeVirus VALUES (0x002C,1990,07,2,'Fellowship','Augmente la taille des fichiers EXE et de temps en temps un blocage de programmes');
INSERT INTO ListeVirus VALUES (0x002D,0,   00,4,'FichV','Augmente la taille des fichiers de 903 octets, ralentissement des accäs disque et diminution de la mÇmoire');
INSERT INTO ListeVirus VALUES (0x002E,1990,05,4,'Fish 6','Augmente la taille des fichiers EXE et COM de 3584 octets, modifie et ralentis l''affichage vidÇo, mÇlange de fichier');
INSERT INTO ListeVirus VALUES (0x002F,1990,07,1,'Flash','Augmente la taille des fichiers COM et EXE de 688 octets, clignotement de l''affichage et diminution de mÇmoire');
INSERT INTO ListeVirus VALUES (0x0030,1990,07,1,'Flip','Augmente la taille des fichiers COM et EXE de 2343 octets, diminue la mÇmoire, altäre le secteur de dÇmarrage et la table de partition et des erreurs d''allocation de fichier');
INSERT INTO ListeVirus VALUES (0x0031,1990,06,1,'Form','Ralentit le temps de rÇaction du clavier');
INSERT INTO ListeVirus VALUES (0x0032,1990,05,2,'Fräre Jacques','Augmente la taille de fichiers COM et EXE de 1808 octets, diminue la mÇmoire disponible, plantage systäme, musique de Fräre Jacques le Vendredi');
INSERT INTO ListeVirus VALUES (0x0033,1987,11,2,'Friday The 13th','Augmente la taille des fichiers COM de 408 Ö 544 octets, destruction de fichiers et activitÇ non sollicitÇ du lecteur A:');
INSERT INTO ListeVirus VALUES (0x0034,1990,01,4,'Frodo','Augmente la taille des fichiers COM, EXE et recouvrement de 4096 octets, blocage de programmes, pertes de fichiers, messages de programmes trop gros pour àtre chargÇ, mÇlange les fichiers');
INSERT INTO ListeVirus VALUES (0x0035,1988,03,1,'Fu Manchu','Augmente la taille des fichiers COM et EXE de 2086 octets');
INSERT INTO ListeVirus VALUES (0x0036,1989,10,1,'Ghostballs','Augmente la taille des fichiers COM de 2351 octets ainsi qu''un effet de balle de ping-pong sur l''Çcran');
INSERT INTO ListeVirus VALUES (0x0037,1990,03,1,'Groen Links','Augmente la taille des fichiers COM et EXE de 1893 octets, impossibilitÇ de dÇmarrer certains programmes et de la musique');
INSERT INTO ListeVirus VALUES (0x0038,1989,10,1,'Hallochen','Augmente la taille des fichiers COM et EXE ainsi qu''une disparition des caractäres tappÇs au clavier');
INSERT INTO ListeVirus VALUES (0x0039,1989,12,2,'Holland Girl','Augmente la taille des fichiers COM de 1332 octets et affichage de messages');
INSERT INTO ListeVirus VALUES (0x003A,1989,06,2,'Icelandic','Augmente la taille des fichiers EXE de 656 Ö 671 octets et diminue l''espace disque disponible');
INSERT INTO ListeVirus VALUES (0x003B,1990,09,2,'Invader','Augmente la taille des fichiers COM et EXE mais du COMMAND.COM, modifie le secteur de dÇmarrage et joue de la musique.');
INSERT INTO ListeVirus VALUES (0x003C,1990,03,2,'Itavir','Augmente la taille des fichiers EXE de 3880 octets, modifie le secteur de dÇmarrage et apparition d''un fichier ?OMMAND.COM');
INSERT INTO ListeVirus VALUES (0x003D,1987,10,2,'Jerusalem','Augmente la taille des fichiers COM et EXE d''environ 1808 octets, ralentissement du systäme, efface des fichiers, impossible de charger des programmes');
INSERT INTO ListeVirus VALUES (0x003E,1988,01,2,'Jerusalem B','Augmente la taille des fichiers EXE, COM et SYS, ralentis le systäme, destruction de fichier');
INSERT INTO ListeVirus VALUES (0x003F,1990,05,2,'JoJo','Augmente la taille des fichiers COM et arràts du systäme');
INSERT INTO ListeVirus VALUES (0x0040,1989,12,3,'Joker','Augmente la taille des fichiers EXE et affichage de messages incohÇrents');
INSERT INTO ListeVirus VALUES (0x0041,1990,06,4,'Joshi','Blocages de l''ordinateur ainsi que l''apparition de messages');
INSERT INTO ListeVirus VALUES (0x0042,1990,04,1,'July 13th','Augmente la taille des fichiers EXE de 1201 octets et effets bizarres sur l''Çcran');
INSERT INTO ListeVirus VALUES (0x0043,1990,04,4,'June 16th','Augmente la taille des fichiers COM, ralentis les accäs disque et altäre le rÇpertoire principal ainsi que la FAT');
INSERT INTO ListeVirus VALUES (0x0044,1990,08,2,'Kamikazi','êcrasement des programmes, des blocages de systäme et des redÇmarrages Ö chaud');
INSERT INTO ListeVirus VALUES (0x0045,1990,04,4,'Kennedy','Augmente la taille des fichiers COM de 333 octets, affichage de messages Ö certaines dates, mÇlange de fichiers, secteurs perdus, altäre la FAT');
INSERT INTO ListeVirus VALUES (0x0046,1990,10,1,'Keypress','Augmente la taille des fichiers COM et EXE, diminue la mÇmoire disponible de 1232 octets, rÇpÇtition inattendue de touches tapÇs au clavier');
INSERT INTO ListeVirus VALUES (0x0047,1990,03,3,'Korea','Infecte le secteur de dÇmarrage 5¨ 360Ko');
INSERT INTO ListeVirus VALUES (0x0048,1987,11,4,'Lehigh','Modifie le COMMAND.COM et la FAT des disquettes et du disque dur');
INSERT INTO ListeVirus VALUES (0x0049,1990,08,2,'Leprosy','Provoque l''affichage de messages inhabituels et comportement bizarre des programmes');
INSERT INTO ListeVirus VALUES (0x004A,1989,05,2,'Liberty','Augmente la taille des fichiers COM, EXE et OVL');
INSERT INTO ListeVirus VALUES (0x004B,1990,07,1,'Mardi Brothers','Modifie le nom de volume, secteur de dÇmarrage des disquettes ainsi qu''une diminution de mÇmoire');
INSERT INTO ListeVirus VALUES (0x004C,1990,06,1,'Microbes','Modifie le secteur de dÇmarrage des disquettes et du disque dur ainsi que des blocages systämes');
INSERT INTO ListeVirus VALUES (0x004D,1990,10,1,'Mirror','Augmente la taille de fichiers EXE, diminue la mÇmoire disponible et effet de miroir sur l''Çcran en pÇriode d''activation');
INSERT INTO ListeVirus VALUES (0x004E,1989,08,2,'Mix/1','Augmente la taille des fichiers EXE ainsi que des mÇlanges des caractäres envoyÇs Ö l''imprimante et des balles rebondissantes Ö l''Çcran');
INSERT INTO ListeVirus VALUES (0x004F,1990,11,2,'Monxla');
INSERT INTO ListeVirus VALUES (0x0050,1990,04,2,'Murphy');
INSERT INTO ListeVirus VALUES (0x0051,1990,12,3,'Music Bug','Diminue la mÇmoire, relentissement du systäme et musique lors d''accäs disque');
INSERT INTO ListeVirus VALUES (0x0052,1990,08,2,'Nomenklatura');
INSERT INTO ListeVirus VALUES (0x0053,1989,11,4,'Number of the Beast');
INSERT INTO ListeVirus VALUES (0x0054,1990,07,3,'Ontario');
INSERT INTO ListeVirus VALUES (0x0055,1989,10,2,'Oropax');
INSERT INTO ListeVirus VALUES (0x0056,1990,08,2,'Paris');
INSERT INTO ListeVirus VALUES (0x0057,1989,12,2,'Perfume');
INSERT INTO ListeVirus VALUES (0x0058,1990,07,4,'Phoenix');
INSERT INTO ListeVirus VALUES (0x0059,1988,03,1,'Ping-pong','Apparition d''une balle rebondissante sur l''Çcran');
INSERT INTO ListeVirus VALUES (0x005A,1990,07,2,'Plastique');
INSERT INTO ListeVirus VALUES (0x005B,1990,10,2,'Plastique Anticad');
INSERT INTO ListeVirus VALUES (0x005C,1990,11,1,'Polimer');
INSERT INTO ListeVirus VALUES (0x005D,1990,10,1,'Polish');
INSERT INTO ListeVirus VALUES (0x005E,1989,03,3,'Print Screen','Ralentissement du disque dur et anomalies dans la liste des fichiers');
INSERT INTO ListeVirus VALUES (0x005F,1990,08,4,'Pround');
INSERT INTO ListeVirus VALUES (0x0060,1990,12,3,'Prudents');
INSERT INTO ListeVirus VALUES (0x0061,1990,03,2,'PSQR');
INSERT INTO ListeVirus VALUES (0x0062,1989,10,0,'Saddam');
INSERT INTO ListeVirus VALUES (0x0063,1990,03,4,'Saturday The 14TH');
INSERT INTO ListeVirus VALUES (0x0064,1990,05,2,'Shake');
INSERT INTO ListeVirus VALUES (0x0065,1990,05,1,'Slow');
INSERT INTO ListeVirus VALUES (0x0066,1990,03,1,'Solano');
INSERT INTO ListeVirus VALUES (0x0067,1990,11,1,'Spyer');
INSERT INTO ListeVirus VALUES (0x0068,1988,02,4,'Stoned','Affichage de messages, plantages du systäme et pertes de donnÇes');
INSERT INTO ListeVirus VALUES (0x0069,1989,11,4,'Sunday');
INSERT INTO ListeVirus VALUES (0x006A,1987,04,2,'Suriv 1.01');
INSERT INTO ListeVirus VALUES (0x006B,1990,00,1,'SVir');
INSERT INTO ListeVirus VALUES (0x006C,1989,08,1,'Swap','Affichage de graphiques, modification du secteur de dÇmarrage de disquettes et mauvaise unitÇ d''allocation');
INSERT INTO ListeVirus VALUES (0x006D,1988,11,3,'SysLock');
INSERT INTO ListeVirus VALUES (0x006E,1990,01,4,'Taiwan');
INSERT INTO ListeVirus VALUES (0x006F,1990,02,4,'Ten Bytes');
INSERT INTO ListeVirus VALUES (0x0070,1990,07,2,'Tiny');
INSERT INTO ListeVirus VALUES (0x0071,1988,10,2,'Traceback');
INSERT INTO ListeVirus VALUES (0x0072,1990,11,2,'Turbo 448');
INSERT INTO ListeVirus VALUES (0x0073,1989,06,2,'Typo','Caractäres envoyÇs sur l''imprimante sont remplacÇs');
INSERT INTO ListeVirus VALUES (0x0074,1990,10,4,'USSR');
INSERT INTO ListeVirus VALUES (0x0075,1990,08,4,'V-1','Augmente la taille des fichiers COM, modifie la table de partition et secteur de dÇmarrage ainsi qu''une activitÇ anormales des lecteurs de disquettes');
INSERT INTO ListeVirus VALUES (0x0076,1990,07,4,'V2100');
INSERT INTO ListeVirus VALUES (0x0077,1990,05,4,'V800');
INSERT INTO ListeVirus VALUES (0x0078,1989,11,2,'Vacsina');
INSERT INTO ListeVirus VALUES (0x0079,1989,12,3,'VComm');
INSERT INTO ListeVirus VALUES (0x007A,1990,09,1,'VFSI');
INSERT INTO ListeVirus VALUES (0x007B,1989,07,0,'VHP');
INSERT INTO ListeVirus VALUES (0x007C,1990,05,4,'Victor');
INSERT INTO ListeVirus VALUES (0x007D,1988,04,2,'Vienna');
INSERT INTO ListeVirus VALUES (0x007E,1988,04,3,'Violator');
INSERT INTO ListeVirus VALUES (0x007F,1988,04,1,'VirDem');
INSERT INTO ListeVirus VALUES (0x0080,1990,05,1,'VP');
INSERT INTO ListeVirus VALUES (0x0081,1989,12,2,'W13');
INSERT INTO ListeVirus VALUES (0x0082,1990,08,2,'Westwood');
INSERT INTO ListeVirus VALUES (0x0083,1990,08,4,'Whale');
INSERT INTO ListeVirus VALUES (0x0084,1990,08,3,'Wisconsin');
INSERT INTO ListeVirus VALUES (0x0085,1990,07,2,'Wolfman');
INSERT INTO ListeVirus VALUES (0x0086,1990,03,2,'XA1');
INSERT INTO ListeVirus VALUES (0x0087,1987,00,4,'Yale','Impossible de redÇmarrer le systäme, disque reformatÇ');
INSERT INTO ListeVirus VALUES (0x0088,1989,09,2,'Yankee Doodle');
INSERT INTO ListeVirus VALUES (0x0089,1989,09,2,'Zero Bug');










