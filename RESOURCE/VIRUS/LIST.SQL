CREATE TABLE ListeVirus (
   ID           WORD PRIMARY KEY,
   Annee        WORD, // Ann�e d�couvert
   Mois         BYTE, // Mois d�couvert
   NiveauDanger BYTE, // 4=Tres dangereux, 3=Dangereux, 2=Moyen, 1=Derangeant, 0=Inoffensif
   Nom          VARCHAR,
   Symotomes    VARCHAR
);

CREATE INDEX;

INSERT INTO ListeVirus VALUES (0x0001,1990,06,1,'1008','Augmente la taille de COMMAND.COM, des erreurs internes de pile, l''arr�t du syst�me lors du d�marrage');
INSERT INTO ListeVirus VALUES (0x0002,1990,07,3,'1226','Augmente la taille des fichiers COM, incapable de charger certains programmes, dimine la m�moire disponible, blocage du syst�me, caract�res �tranges sur �cran � la place de l''ex�cutable du programme, action non sollicit� des unit�s');
INSERT INTO ListeVirus VALUES (0x0003,1990,01,2,'1260','Augmente la taille des fichiers COM (1260 octets)');
INSERT INTO ListeVirus VALUES (0x0004,1990,06,2,'1381','Augmente la taille des fichiers EXE');
INSERT INTO ListeVirus VALUES (0x0005,1990,09,1,'1605','Augmente la taille des fichiers COM et EXE ainsi qu''une baisse des performances du syst�me');
INSERT INTO ListeVirus VALUES (0x0006,1990,04,1,'8 Tunes','Augmente la taille des fichiers COM et EXE et dimine la m�moire disponible ainsi que de la musique');
INSERT INTO ListeVirus VALUES (0x0007,1990,07,1,'382','Blocage du syst�me lors de l''ex�cution de programmes, caract�res �tranges sur �cran, lecteur tourne sans arr�t et red�marrage occasionnel');
INSERT INTO ListeVirus VALUES (0x0008,1990,05,4,'5120','Augmente la taille des fichiers COM et EXE, alt�re des fichiers et des secteurs de d�marrage ainsi qu''une activit� non sollicit� du disque');
INSERT INTO ListeVirus VALUES (0x0009,1989,00,2,'Aids','Plantages du syst�me lors de l''ex�cution de programmes.');
INSERT INTO ListeVirus VALUES (0x000A,1990,04,1,'Aids II','Apparition de fichiers COM ainsi que des messages et de la musique');
INSERT INTO ListeVirus VALUES (0x000B,1989,12,4,'Aids Info','Destruction imm�diate de la FAT');
INSERT INTO ListeVirus VALUES (0x000C,1990,07,1,'AirCop','Blocage du syst�me, affichage de messages, diminution de m�moire, modification du secteur de d�marrage');
INSERT INTO ListeVirus VALUES (0x000D,1990,10,4,'Alabama','Augmente la taille des fichiers EXE, affichage de messages, d�marrage de programmes autres que ceux demand�s');
INSERT INTO ListeVirus VALUES (0x000E,1990,06,1,'Ambulance','Augmente la taille des fichiers COM de 796 octets, affichage d''une ambulance ainsi que le bruit d''une sir�ne.');
INSERT INTO ListeVirus VALUES (0x000F,1990,03,2,'Amoeba','Augmente la taille des fichiers EXE et COM ainsi qu''une modification de leur date de cr�ation');
INSERT INTO ListeVirus VALUES (0x0010,1989,11,1,'Amstrad','Augmente la taille des fichiers COM de 847 octets, des erreurs de parit� m�moire ainsi que l''affichage de messages.');
INSERT INTO ListeVirus VALUES (0x0011,1990,07,4,'Anthrax','Augmente la taille de fichiers COM et EXE');
INSERT INTO ListeVirus VALUES (0x0012,1990,06,3,'Anti-Pascal','Augmente la taille des fichiers COM ainsi que la disparition des fichiers PAS et BAK');
INSERT INTO ListeVirus VALUES (0x0013,1990,06,2,'Armagedon','Augmente la taille de fichiers COM de 1079 caract�res ainsi qu''une activit� non sollicit� des ports s�rie');
INSERT INTO ListeVirus VALUES (0x0014,1989,09,1,'Ashar','Modifie le secteur de d�marrage et le nom du volume du disque');
INSERT INTO ListeVirus VALUES (0x0015,1990,09,2,'Black Monday','Augmente la taille des fichiers COM et EXE de 1055 octets');
INSERT INTO ListeVirus VALUES (0x0016,1990,08,2,'Blood','Augmente la taille des fichiers COM, red�marrage et blocage du syst�me, effets de cascade des caract�res');
INSERT INTO ListeVirus VALUES (0x0017,1986,00,1,'Brain','Modifie le nom de volume en (c) Brain');
INSERT INTO ListeVirus VALUES (0x0018,1990,00,2,'Burger','Blocages du syst�me lors d''ex�cution de programmes');
INSERT INTO ListeVirus VALUES (0x0019,1989,12,4,'Chaos','Modifie le secteur de d�marrage');
INSERT INTO ListeVirus VALUES (0x001A,1990,11,2,'Carioca','Augmente la taille des fichiers COM de 951 octets');
INSERT INTO ListeVirus VALUES (0x001B,1989,01,2,'Cascade','Augmente la taille des fichiers COM de 1701 octets, chute de caract�res � l''�cran et formtage du disque dur');
INSERT INTO ListeVirus VALUES (0x001C,1990,08,4,'Casper','Augmentation de la taille des fichiers COM de 1200 octets et secteur introuvable');
INSERT INTO ListeVirus VALUES (0x001D,1990,09,2,'Christmas in Japan','Augmente la taille de des fichers COM et affichage de messages de No�l');
INSERT INTO ListeVirus VALUES (0x001E,1989,09,4,'Dark Avenger','Augmente la taille de fichiers ex�cutable et destruction de donn�es');
INSERT INTO ListeVirus VALUES (0x001F,1989,04,4,'Datacrime','Augmente la taille des fichiers COM, blocage de l''ordinateur et destruction des donn�es du disque dur');
INSERT INTO ListeVirus VALUES (0x0020,1990,11,2,'Datalock','Augmente la taille des COMMAND.COM et des fichiers EXE, diminue la m�moire de 2048 octets et modifie la date et l''heure de cr�ation des fichiers');
INSERT INTO ListeVirus VALUES (0x0021,1988,09,4,'dBase','Augmente la taille des fichiers COM de 1864 octets, destruction de fichiers DBF et �crasement du r�pertoire principal et de la FAT');
INSERT INTO ListeVirus VALUES (0x0022,1989,12,2,'December 24th','Augmente la taille des fichiers EXE et diminution non justifi�e de l''espace disque disponible');
INSERT INTO ListeVirus VALUES (0x0023,1988,09,2,'Den Zuk','Destruction du contenu des disquettes 3� et 1,2 Mo, modifie le nom de volume du disque et affichage de messages');
INSERT INTO ListeVirus VALUES (0x0024,1989,12,4,'Devil''s Dance','Augmente la taille des fichiers COM de 951 octets, impossibilit� de d�marrer certains programmes, modification de l''affichage et pertes de donn�es');
INSERT INTO ListeVirus VALUES (0x0025,1990,05,2,'Diamond','Diminue la m�moire disponible et plantages du syst�me');
INSERT INTO ListeVirus VALUES (0x0026,1989,04,4,'Disk Killer','Affichage de messages suivi de destruction des donn�es du disque dur');
INSERT INTO ListeVirus VALUES (0x0027,1989,10,2,'Do-Nothing','Augmente la taille des fichiers COM de 608 octets');
INSERT INTO ListeVirus VALUES (0x0028,1990,10,1,'Dot Killer','Augmente la taille des fichiers COM de 944 octets et disparition des points (.) de l''�cran');
INSERT INTO ListeVirus VALUES (0x0029,1990,04,4,'Eddie II','Augmente la taille de fichiers COM et EXE, diminue la m�moire disponible et erreurs d''allocation de fichiers');
INSERT INTO ListeVirus VALUES (0x002A,1990,01,4,'EDV','Perte des fichiers situ�s sur les disquettes et le disque dur et blocages du syst�me');
INSERT INTO ListeVirus VALUES (0x002B,1990,11,4,'Father Christmas','Augmente la taille des fichiers COM de 1881 octets, unit� d''allocation perdus, m�lange des fichiers ainsi que l''affichage de divers messages ou graphiques');
INSERT INTO ListeVirus VALUES (0x002C,1990,07,2,'Fellowship','Augmente la taille des fichiers EXE et de temps en temps un blocage de programmes');
INSERT INTO ListeVirus VALUES (0x002D,0,   00,4,'FichV','Augmente la taille des fichiers de 903 octets, ralentissement des acc�s disque et diminution de la m�moire');
INSERT INTO ListeVirus VALUES (0x002E,1990,05,4,'Fish 6','Augmente la taille des fichiers EXE et COM de 3584 octets, modifie et ralentis l''affichage vid�o, m�lange de fichier');
INSERT INTO ListeVirus VALUES (0x002F,1990,07,1,'Flash','Augmente la taille des fichiers COM et EXE de 688 octets, clignotement de l''affichage et diminution de m�moire');
INSERT INTO ListeVirus VALUES (0x0030,1990,07,1,'Flip','Augmente la taille des fichiers COM et EXE de 2343 octets, diminue la m�moire, alt�re le secteur de d�marrage et la table de partition et des erreurs d''allocation de fichier');
INSERT INTO ListeVirus VALUES (0x0031,1990,06,1,'Form','Ralentit le temps de r�action du clavier');
INSERT INTO ListeVirus VALUES (0x0032,1990,05,2,'Fr�re Jacques','Augmente la taille de fichiers COM et EXE de 1808 octets, diminue la m�moire disponible, plantage syst�me, musique de Fr�re Jacques le Vendredi');
INSERT INTO ListeVirus VALUES (0x0033,1987,11,2,'Friday The 13th','Augmente la taille des fichiers COM de 408 � 544 octets, destruction de fichiers et activit� non sollicit� du lecteur A:');
INSERT INTO ListeVirus VALUES (0x0034,1990,01,4,'Frodo','Augmente la taille des fichiers COM, EXE et recouvrement de 4096 octets, blocage de programmes, pertes de fichiers, messages de programmes trop gros pour �tre charg�, m�lange les fichiers');
INSERT INTO ListeVirus VALUES (0x0035,1988,03,1,'Fu Manchu','Augmente la taille des fichiers COM et EXE de 2086 octets');
INSERT INTO ListeVirus VALUES (0x0036,1989,10,1,'Ghostballs','Augmente la taille des fichiers COM de 2351 octets ainsi qu''un effet de balle de ping-pong sur l''�cran');
INSERT INTO ListeVirus VALUES (0x0037,1990,03,1,'Groen Links','Augmente la taille des fichiers COM et EXE de 1893 octets, impossibilit� de d�marrer certains programmes et de la musique');
INSERT INTO ListeVirus VALUES (0x0038,1989,10,1,'Hallochen','Augmente la taille des fichiers COM et EXE ainsi qu''une disparition des caract�res tapp�s au clavier');
INSERT INTO ListeVirus VALUES (0x0039,1989,12,2,'Holland Girl','Augmente la taille des fichiers COM de 1332 octets et affichage de messages');
INSERT INTO ListeVirus VALUES (0x003A,1989,06,2,'Icelandic','Augmente la taille des fichiers EXE de 656 � 671 octets et diminue l''espace disque disponible');
INSERT INTO ListeVirus VALUES (0x003B,1990,09,2,'Invader','Augmente la taille des fichiers COM et EXE mais du COMMAND.COM, modifie le secteur de d�marrage et joue de la musique.');
INSERT INTO ListeVirus VALUES (0x003C,1990,03,2,'Itavir','Augmente la taille des fichiers EXE de 3880 octets, modifie le secteur de d�marrage et apparition d''un fichier ?OMMAND.COM');
INSERT INTO ListeVirus VALUES (0x003D,1987,10,2,'Jerusalem','Augmente la taille des fichiers COM et EXE d''environ 1808 octets, ralentissement du syst�me, efface des fichiers, impossible de charger des programmes');
INSERT INTO ListeVirus VALUES (0x003E,1988,01,2,'Jerusalem B','Augmente la taille des fichiers EXE, COM et SYS, ralentis le syst�me, destruction de fichier');
INSERT INTO ListeVirus VALUES (0x003F,1990,05,2,'JoJo','Augmente la taille des fichiers COM et arr�ts du syst�me');
INSERT INTO ListeVirus VALUES (0x0040,1989,12,3,'Joker','Augmente la taille des fichiers EXE et affichage de messages incoh�rents');
INSERT INTO ListeVirus VALUES (0x0041,1990,06,4,'Joshi','Blocages de l''ordinateur ainsi que l''apparition de messages');
INSERT INTO ListeVirus VALUES (0x0042,1990,04,1,'July 13th','Augmente la taille des fichiers EXE de 1201 octets et effets bizarres sur l''�cran');
INSERT INTO ListeVirus VALUES (0x0043,1990,04,4,'June 16th','Augmente la taille des fichiers COM, ralentis les acc�s disque et alt�re le r�pertoire principal ainsi que la FAT');
INSERT INTO ListeVirus VALUES (0x0044,1990,08,2,'Kamikazi','�crasement des programmes, des blocages de syst�me et des red�marrages � chaud');
INSERT INTO ListeVirus VALUES (0x0045,1990,04,4,'Kennedy','Augmente la taille des fichiers COM de 333 octets, affichage de messages � certaines dates, m�lange de fichiers, secteurs perdus, alt�re la FAT');
INSERT INTO ListeVirus VALUES (0x0046,1990,10,1,'Keypress','Augmente la taille des fichiers COM et EXE, diminue la m�moire disponible de 1232 octets, r�p�tition inattendue de touches tap�s au clavier');
INSERT INTO ListeVirus VALUES (0x0047,1990,03,3,'Korea','Infecte le secteur de d�marrage 5� 360Ko');
INSERT INTO ListeVirus VALUES (0x0048,1987,11,4,'Lehigh','Modifie le COMMAND.COM et la FAT des disquettes et du disque dur');
INSERT INTO ListeVirus VALUES (0x0049,1990,08,2,'Leprosy','Provoque l''affichage de messages inhabituels et comportement bizarre des programmes');
INSERT INTO ListeVirus VALUES (0x004A,1989,05,2,'Liberty','Augmente la taille des fichiers COM, EXE et OVL');
INSERT INTO ListeVirus VALUES (0x004B,1990,07,1,'Mardi Brothers','Modifie le nom de volume, secteur de d�marrage des disquettes ainsi qu''une diminution de m�moire');
INSERT INTO ListeVirus VALUES (0x004C,1990,06,1,'Microbes','Modifie le secteur de d�marrage des disquettes et du disque dur ainsi que des blocages syst�mes');
INSERT INTO ListeVirus VALUES (0x004D,1990,10,1,'Mirror','Augmente la taille de fichiers EXE, diminue la m�moire disponible et effet de miroir sur l''�cran en p�riode d''activation');
INSERT INTO ListeVirus VALUES (0x004E,1989,08,2,'Mix/1','Augmente la taille des fichiers EXE ainsi que des m�langes des caract�res envoy�s � l''imprimante et des balles rebondissantes � l''�cran');
INSERT INTO ListeVirus VALUES (0x004F,1990,11,2,'Monxla');
INSERT INTO ListeVirus VALUES (0x0050,1990,04,2,'Murphy');
INSERT INTO ListeVirus VALUES (0x0051,1990,12,3,'Music Bug','Diminue la m�moire, relentissement du syst�me et musique lors d''acc�s disque');
INSERT INTO ListeVirus VALUES (0x0052,1990,08,2,'Nomenklatura');
INSERT INTO ListeVirus VALUES (0x0053,1989,11,4,'Number of the Beast');
INSERT INTO ListeVirus VALUES (0x0054,1990,07,3,'Ontario');
INSERT INTO ListeVirus VALUES (0x0055,1989,10,2,'Oropax');
INSERT INTO ListeVirus VALUES (0x0056,1990,08,2,'Paris');
INSERT INTO ListeVirus VALUES (0x0057,1989,12,2,'Perfume');
INSERT INTO ListeVirus VALUES (0x0058,1990,07,4,'Phoenix');
INSERT INTO ListeVirus VALUES (0x0059,1988,03,1,'Ping-pong','Apparition d''une balle rebondissante sur l''�cran');
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
INSERT INTO ListeVirus VALUES (0x0068,1988,02,4,'Stoned','Affichage de messages, plantages du syst�me et pertes de donn�es');
INSERT INTO ListeVirus VALUES (0x0069,1989,11,4,'Sunday');
INSERT INTO ListeVirus VALUES (0x006A,1987,04,2,'Suriv 1.01');
INSERT INTO ListeVirus VALUES (0x006B,1990,00,1,'SVir');
INSERT INTO ListeVirus VALUES (0x006C,1989,08,1,'Swap','Affichage de graphiques, modification du secteur de d�marrage de disquettes et mauvaise unit� d''allocation');
INSERT INTO ListeVirus VALUES (0x006D,1988,11,3,'SysLock');
INSERT INTO ListeVirus VALUES (0x006E,1990,01,4,'Taiwan');
INSERT INTO ListeVirus VALUES (0x006F,1990,02,4,'Ten Bytes');
INSERT INTO ListeVirus VALUES (0x0070,1990,07,2,'Tiny');
INSERT INTO ListeVirus VALUES (0x0071,1988,10,2,'Traceback');
INSERT INTO ListeVirus VALUES (0x0072,1990,11,2,'Turbo 448');
INSERT INTO ListeVirus VALUES (0x0073,1989,06,2,'Typo','Caract�res envoy�s sur l''imprimante sont remplac�s');
INSERT INTO ListeVirus VALUES (0x0074,1990,10,4,'USSR');
INSERT INTO ListeVirus VALUES (0x0075,1990,08,4,'V-1','Augmente la taille des fichiers COM, modifie la table de partition et secteur de d�marrage ainsi qu''une activit� anormales des lecteurs de disquettes');
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
INSERT INTO ListeVirus VALUES (0x0087,1987,00,4,'Yale','Impossible de red�marrer le syst�me, disque reformat�');
INSERT INTO ListeVirus VALUES (0x0088,1989,09,2,'Yankee Doodle');
INSERT INTO ListeVirus VALUES (0x0089,1989,09,2,'Zero Bug');










