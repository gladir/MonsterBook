CREATE TABLE Lexique (
   ID        WORD PRIMARY KEY,
   Mot       VARCHAR,
   Categorie VARCHAR,
   Descr     VARCHAR,
   Voir      VARCHAR
);

CREATE INDEX;

INSERT INTO Lexique VALUES (   1,'$$$','','Extension de nom de Fichier utilis‚e (g‚n‚ralement sous DOS) pour d‚signer certains fichiers Temporaires','');
INSERT INTO Lexique VALUES (   2,'*','','CaractŠre utilisable dans un Filtre de s‚lection de fichiers. Il remplace, sous Unix, tous les noms de Fichiers existants dans un R‚pertoire. quivalent sous DOS: ®*.*¯','Wildcard');
INSERT INTO Lexique VALUES (   3,'*.*','','Expression d‚signant tous les Fichiers existants dans un R‚pertoire. Filtre de s‚lection de fichiers d‚signant, sous DOS, tous les Fichiers existants dans un R‚pertoire. quivalent Unix: *','Wildcard');
INSERT INTO Lexique VALUES (   4,'*nix','UNIX','n. pl. Terme utilis‚ pour se r‚f‚rer aux innombrables versions d''Unix pass‚es, pr‚sentes, et … venir. L''int‚rˆt de la Wildcard est de ne pas avoir … citer la marque d‚pos‚e ®Unix¯, pendant longtemps propri‚t‚ d''AT&T','');
INSERT INTO Lexique VALUES (   5,'*grin*','Expression utilis‚e dans un message pour faire une grimace ou un sourire (suivant le contexte)','','');
INSERT INTO Lexique VALUES (   6,'*K ®* Killer¯','','Delphi est par exemple un VBK, pour ®Visual Basic Killer¯. A ne surtout pas confondre avec le ®K¯ de ®Kit¯, comme dans SDK, signifiant Software Development Kit. On peut d''ailleurs se demander si la confusion n''a pas ‚t‚ v‚ritablement recherch‚e','');
INSERT INTO Lexique VALUES (   7,'*wink*','','Expression utilis‚e dans un message pour faire un clin d''oeil','');
INSERT INTO Lexique VALUES (   8,'0','','Le z‚ro est souvent barr‚ en informatique pour ne pas le confondre avec les ®O¯. Mais dans ce cas l…, il ne faut pas le confondre avec l''ensemble vide, ni avec la lettre d''une de ces langues nordiques contennant 98% de consonnes. C''est pourquoi, sur certains systŠmes, le z‚ro est un ®O¯ avec un point au milieu, ou un 0 barr‚ … l''envers. Depuis les ann‚es 1990, grƒce … l''am‚lioration de la d‚finition des affichages, il est heureusement enfin possible d''avoir des caractŠres suffisamment pr‚cis pour qu''un 0 ne soit pas un O (mais cela n''empˆche pas toujours certaines ambigu‹t‚s)','');
INSERT INTO Lexique VALUES (   9,'0.6 microns','','C''est la taille minimale … la fin du XXe siŠcle d''un ‚l‚ment grav‚ sur un composant ‚lectronique. Il semblerait que chez NEC, on ait grav‚ du 0.07 microns','');
INSERT INTO Lexique VALUES (  10,'00000','','Abr‚viation de Z‚ro panne, z‚ro d‚faut, z‚ro d‚lai, z‚ro stock, z‚ro papier. Qu''est-ce qu''on doit se sentir g‚nial, dans ce cas-l…','');
INSERT INTO Lexique VALUES (  11,'030','HDW','Abr‚v‚viation courante de 68030. Prononc‚e ®Love thirty¯ par les anglo-saxons','');
INSERT INTO Lexique VALUES (  12,'1-2-3','','Tableur trŠs largement diffus‚ de la soci‚t‚ Lotus, dont la premiŠre version date de 1982','');
INSERT INTO Lexique VALUES (  13,'10Base2','CABLE','Type de Cƒble utilis‚ par Ethernet. C''est du Coaxial, et le cƒble doit se terminer aux 2 bouts par des bouchons (voir Bouchon de Terminaison), et passer en chemin par toutes les stations du r‚seau, sans faire plus de 200 mŠtres de long. Si le cƒble est coup‚, le r‚seau est globalement naze. Cela s''appelle une Topologie physique en bus. Le 10Base5, c''est la mˆme chose, mais avec des cƒbles ‚pais, sur une longueur maxi de 500 mŠtres. D‚bit: 10 Mbit/s (comme son nom l''indique). Appel‚ aussi Thin Ethernet','');
INSERT INTO Lexique VALUES (  14,'10Base5','CABLE','Voir 10Base2 (ici, le cƒble peut faire jusqu''… 500 mŠtres de long). D‚bit: 10 Mbit/s','');
INSERT INTO Lexique VALUES (  15,'10BaseF','CABLE','Ethernet avec un d‚bit de 10 Mbit/s sur de la Fibre Optique en bande de base (le d‚bit est limit‚ par la norme Ethernet, ceci rendant l''usage de la fibre optique dans ce contexte un peu idiot sauf cas particulier). Ses 3 variantes sont 10Base-FB, 10Base-FL, 10Base-FP','10Base2');
INSERT INTO Lexique VALUES (  16,'10Base-FB','CABLE','Ethernet synchrone¯, con‡u pour que les R‚p‚teurs communiquent plus efficacement, et permettant d''en mettre plus (normalement, on ne doit pas mettre plus de 4 r‚p‚teurs … la queue-leu-leu)','10BaseF');
INSERT INTO Lexique VALUES (  17,'10Base-FL','CABLE','Ethernet sur Fibre Optique fonctionnant … la maniŠre du 10BaseT, et rendant FOIRL obsolŠte','10BaseF');
INSERT INTO Lexique VALUES (  18,'10Base-FP','CABLE','Passive star fiber Ethernet: le Concentrateur est passif, il se contente d''envoyer les impulsions lumineuses entrantes aux fibres sortantes sans rien faire d''autre','10BaseF');
INSERT INTO Lexique VALUES (  19,'10BaseT','CABLE','Type de Cƒble utilis‚ principalement par la norme Ethernet. Mˆme chose que 10Base2, mais avec du cƒble en cuivre … paires torsad‚es, et une Topologie physique en ‚toile','');
INSERT INTO Lexique VALUES (  20,'10 NET Plus','IBM NTW','Le 10 Net+ est un logiciel de petite taille produit par DCA, supportant le Dos. Fonctionne sans qu''un serveur attitr‚ soit d‚clar‚. Il peut ˆtre install‚ suivant les topologies bus, ‚toiles, anneau et avec, comme support physique, les cƒbles coaxiaux, paires torsad‚es, fibres optiques dans le cadre des protocoles Ethernet 10 base T, Starlan, Token-Ring. 10 Net+ utilise la m‚thode d''accŠs CSMA/CA et propose une vitesse de 1 Mo/s en bande de base. Le prix assez d‚mocratique ne signifie pas pour autant qu''il n''y ait aucune protection; en effet, il offre les degr‚s de s‚curit‚ suivants: ş encryptage du mot de passe; ş code de localisation. De plus, il propose une messagerie ‚lectronique, un agenda, et des utilitaires appropri‚s, tels '+
                                                         'que le partage de fichiers, d''imprimante avec "spooling" (m‚morisation dans un/des tampon(s)). L''installation s''avŠre assez simple et seuls 64 Ko de RAM sont indispensables par machine pour le chargement de 10 Net+. Sa fiche technique: ş 255 Stations maximum, ş 600m Maximum pour une longueur de bus, ş 4 r‚p‚teur maximum, ş 32 Noeud maximum, ş peut partager jusqu''… 16 disques durs','');
INSERT INTO Lexique VALUES (  21,'100BaseT','CABLE','Ensemble de normes (100BaseTX, 100BaseTF et 100BaseT4), synnoyme de ®Fast Ethernet¯, permettant d''utiliser Ethernet avec un d‚bit de 100 Mbit/s','10BaseT');
INSERT INTO Lexique VALUES (  22,'1000','','La fr‚quence de fonctionnement maximale en MHz d''un Processeur Alpha','');
INSERT INTO Lexique VALUES (  23,'1024','','Le nombre exact d''Octets dans un Ko, c''est-…-dire 2 puissance 10','');
INSERT INTO Lexique VALUES (  24,'1028','IBM','Virus informatique ‚galement connu sous le nom de Dark Avenger','');
INSERT INTO Lexique VALUES (  25,'1048576','','Le nombre d''octets dans un Mo','');
INSERT INTO Lexique VALUES (  26,'1049','IBM','Virus informatique surnomm‚ USSR-1049','');
INSERT INTO Lexique VALUES (  27,'1063','IBM','Virus informatique surnomm‚ Mono','');
INSERT INTO Lexique VALUES (  28,'1067','IBM','Virus informatique surnomm‚ Headcrash','');
INSERT INTO Lexique VALUES (  29,'1073741824','','Le nombre d''octets dans un Go','');
INSERT INTO Lexique VALUES (  30,'1193','IBM','Virus informatique surnomm‚ Copyright','');
INSERT INTO Lexique VALUES (  31,'1099511627776','','Le nombre d''octets dans un To','');
INSERT INTO Lexique VALUES (  32,'16-32 bits','','Architecture de la majorit‚ des Micros de la fin des ann‚es 1980 et du d‚but des ann‚es 1990. C''est respectivement la largeur du Bus et la taille des Registres du Processeur, calculant donc sur 32 bits en interne','');
INSERT INTO Lexique VALUES (  33,'1701','','Erreur mat‚riel d– … un mauvais branchement des cƒbles de disque dur. G‚n‚ralement branchement … l''envers (dans le mauvais sense)','');
INSERT INTO Lexique VALUES (  34,'186','HDW','Abr‚viation de 80186','');
INSERT INTO Lexique VALUES (  35,'1876','IBM','Virus informatique ‚galement connu sous le nom de Dash-em','');
INSERT INTO Lexique VALUES (  36,'1ier','','Abr‚viation de Premier. Ce mot comme 1iŠre est couramment enploy‚ pour permettre une compression accrue du texte','');
INSERT INTO Lexique VALUES (  37,'1iŠre','','Abr‚viation de PremiŠre','1ier');
INSERT INTO Lexique VALUES (  38,'1NF','','Abr‚viation de First Normal Form. PremiŠre forme normale','');
INSERT INTO Lexique VALUES (  39,'1ST','','Abr‚viation de ®First¯. Document … consulter en 1ier, au mˆme titre qu''un README','');
INSERT INTO Lexique VALUES (  40,'2','','Le nombre maximal de valeurs possibles d''un Bit. Ceci expliquant que les valeurs caract‚ristiques des ordinateurs en soient des multiples','');
INSERT INTO Lexique VALUES (  41,'2','','Un ®2¯ plac‚ en position infixe dans le nom d''un Programme indique que ce programme permet de r‚aliser une conversion d''un format de donn‚es dans un autre (rappelant ainsi phon‚tiquement le ®to¯ anglais)','');
INSERT INTO Lexique VALUES (  42,'2 Humour:','','Le QI des bonshommes shoot‚s au caf‚ … la coca‹ne ayant imagin‚ le format Intel ainsi que son code Assembleur','');
INSERT INTO Lexique VALUES (  43,'21h','Coder','Il s''agit soit de l''Interruption DOS ou du Contr“leur d''interruption','');
INSERT INTO Lexique VALUES (  44,'24','','Le nombre de millions de connexions quotidiennes … Internet en 1995. C''est aussi le nombre de bits codant une image de qualit‚ photo (Photor‚aliste)','');
INSERT INTO Lexique VALUES (  45,'2468','IBM','Virus informatique surnomm‚ Tequila','');
INSERT INTO Lexique VALUES (  46,'25','','C''est le pourcentage des particuliers fran‡ais poss‚dant un ordinateur sans savoir quel Processeur il contient, quelle est la capacit‚ de son Disque Dur, ni de combien de M‚moire Vive il dispose en 1996','');
INSERT INTO Lexique VALUES (  47,'286','HDW','Synonyme de 80286','');
INSERT INTO Lexique VALUES (  48,'287','HDW','Synonyme de 80287','');
INSERT INTO Lexique VALUES (  49,'2B+D','COM','Type de raccordement … un RNIS: 2 canaux … 64 Kbits/s (B: donn‚es sur commutation de circuits) et 1 … 16 Kbits/s (D : signalisation sur commutation de paquets)','30B+D');
INSERT INTO Lexique VALUES (  50,'2D','CAO','Mod‚lisation ou repr‚sentation d''un objet sous forme bi-dimensionelle','');
INSERT INTO Lexique VALUES (  51,'2GL','Coder','Abr‚viation de Second Generation Language. Langage de deuxiŠme g‚n‚ration','3GL, 4GL, *L4G');
INSERT INTO Lexique VALUES (  52,'2K','','2000','An 2000');
INSERT INTO Lexique VALUES (  53,'2iŠme','','Abr‚viation de ®DeuxiŠme¯','');
INSERT INTO Lexique VALUES (  54,'3*','UNIX','®*¯ est un g‚n‚rique (joker) ‚quivalant … ®S¯, ®M¯, ®C¯, ®X¯, ®N¯, ®G¯, ou ®F¯. Ce sont les BibliothŠques standard d''Unix. Avant l''apparition des Spec1170, ‚videmment..','');
INSERT INTO Lexique VALUES (  55,'3.5','','Le nombre de pouces dans le diamŠtre d''une Disquette courante. Certaines font aussi 5,25 pouces de diamŠtre, celles de 8 pouces ont disparu. Ce format est devenu un standard, et il existe d‚sormais toutes sortes de p‚riph‚riques de cette taille, exemples, des disques durs','');
INSERT INTO Lexique VALUES (  56,'30B+D','COM','Type de raccordement … un RNIS: 30 canaux … 64 Kbits/s (B: donn‚es sur commutation de circuits) et 1 … 64 Kbits/s (D: signalisation sur commutation de paquets)','2B+D');
INSERT INTO Lexique VALUES (  57,'3270','HDW','Nom de toute une famille de produits extrˆmement r‚pandus d''IBM, et en particulier du Terminal et des Imprimantes allant avec','');
INSERT INTO Lexique VALUES (  58,'34010, 34020','IBM HDW','Micro-processeur graphique de Texas Instrument des cartes vid‚o TIGA. Il a pour fonction de d‚charger le CPU des routines encombrante que demande la gestion des systŠmes vid‚o','');
INSERT INTO Lexique VALUES (  59,'3615','','HISTOIRE: L''un des principaux num‚ros qu''on utilisait pour se connecter au Minitel. Il fallait ensuite indiquer le nom du service qu''on voulait appeler en particulier (du style 3615 FILTONFLOUZ)','');
INSERT INTO Lexique VALUES (  60,'386','HDW','Synonyme de 80386','');
INSERT INTO Lexique VALUES (  61,'386BSD','UNIX','Version d''Unix de Berkeley (bas‚e sur la version 4.4 de BSD), adapt‚e au PC','BSD, FreeBSD');
INSERT INTO Lexique VALUES (  62,'387','HDW','Synonyme de 80387','');
INSERT INTO Lexique VALUES (  63,'3COM','COM','Abr‚viation de Computer, Communications and Compatability. Soci‚t‚ oeuvrant dans le monde des r‚seaux. Quoiqu''elle ce soit d‚j… int‚ress‚ … monde des disquettes dans le pass‚e','');
INSERT INTO Lexique VALUES (  64,'3D','CAO','Mod‚lisation ou repr‚sentation d''un objet sous forme tri-dimensionnelle. ş Trois dimensions. L''espace physique commun, avant Einstein. Quand on parle de quelque chose en ®3D¯, c''est pour indiquer que l''image plane donnant une impression de relief, vue … l''‚cran, est une projection d''un monde tridimentionnel calcul‚... sauf quand il ne s''agit que d''une illusion d''optique, comme pour les contr“les en 3D des interfaces graphiques','');
INSERT INTO Lexique VALUES (  65,'3D Isom‚trique','','Type de projection 3D','');
INSERT INTO Lexique VALUES (  66,'3D Studio Max','IBM','Logiciel de synthŠse 3 dimensions d''Autodesk. Comprend la mod‚lisation, rendu et animation 3 dimensions, postproduction. Il tourne uniquement sous Windows NT et OS/2 Warp 4. Configuration monstre recommand‚: Pentium Pro 200 Mhz, 64 Mo, carte vid‚o 24 bits, CD-ROM,..','');
INSERT INTO Lexique VALUES (  67,'3D-DDI','','Abr‚viation de 3 Dimensions Device Driver Interface. Interface de Windows 95 devant permettre d''acc‚der facilement aux ressources 3D (objets, animations...) des Carte Graphique r‚centes','');
INSERT INTO Lexique VALUES (  68,'3DO','GAME','Abr‚viation de 3 Dimensional Optics. ModŠle de Console de Jeu. Principales caract‚ristiques: lecture de toutes sortes de CD (ROM, vid‚o, audio...), Processeur RISC 32 bits','Sega, Nintendo');
INSERT INTO Lexique VALUES (  69,'3DS','CAO','','3DStudio');
INSERT INTO Lexique VALUES (  70,'3DStudio','CAO','Logiciel de calcul d''images de synthŠse d''Autodesk, faisant r‚f‚rence dans le monde du PC. Curieusement, il est trŠs r‚pandu, malgr‚ son prix catalogue (26 000 FF dans sa version 3)... La version Max date de 1997','');
INSERT INTO Lexique VALUES (  71,'3GL','Coder','Abr‚viation Third Generation Language. Langage de troisiŠme g‚n‚ration','2GL, 4GL, *L4G');
INSERT INTO Lexique VALUES (  72,'3iŠme','','Abr‚viation de ®TroisiŠme¯','');
INSERT INTO Lexique VALUES (  73,'3RD','NTW','R‚seau Radio‚lectrique R‚serv‚ aux Donn‚es','');
INSERT INTO Lexique VALUES (  74,'401','INTERNET','Sur le WEB, petite cousine de l''Erreur 404. 401 vous indique qu''on ne vous a pas autoris‚ … lire la page Web vous int‚ressant. Vous vous ˆtes fait ad‚iser','');
INSERT INTO Lexique VALUES (  75,'404','INTERNET','Page souvent rencontr‚e sur le Web. Elle vous informe sous la forme d''une Erreur que le document que vous convoitez n''existe plus ou ne se trouve plus … l''URL examin‚e','');
INSERT INTO Lexique VALUES (  76,'4004','HDW','Le premier Microprocesseur de l''histoire, produit par Intel, con‡u en 1971 par M. Hoff. Il contenait 2300 transistors et ‚tait capable d''effectuer 60 000 op‚rations par seconde. C''‚tait les performances de l''ENIAC, mais ratatin‚es sur 10 mm carr‚s, au lieu de 30 mŠtres cubes...','');
INSERT INTO Lexique VALUES (  77,'4045 16/4 Token Ring XT/AT','HDW','Carte r‚seau pour XT et AT de ThomasúConrad','');
INSERT INTO Lexique VALUES (  78,'483','IBM','Virus informatique','');
INSERT INTO Lexique VALUES (  79,'486','HDW','Synonyme de 80486','');
INSERT INTO Lexique VALUES (  80,'4D','','Base de donn‚e de SGBDR tout d''abord exclusivement diffus‚ sur Mac, puis port‚ sur PC','');
INSERT INTO Lexique VALUES (  81,'4Dos','IBM','Logiciels rempla‡ant le COMMAND.COM. Il se distingue de celui-ci du fait qu''il occupe moins de m‚moire conventionnel que le "Command" original en plus d''avoir de nombreuses commandes suppl‚mentaires','');
INSERT INTO Lexique VALUES (  82,'4GL','Coder','Abr‚viation Fourth Generation Language','*L4G, 2GL, 3GL');
INSERT INTO Lexique VALUES (  83,'4iŠme','','Abr‚viation de ®QuatriŠme¯','');
INSERT INTO Lexique VALUES (  84,'50','','L''acc‚l‚ration en G (9.81 m/s/s) subie par une Disquette lors du d‚marrage du moteur du lecteur. On comprend pourquoi il vaut mieux acheter des disquettes de grand marque bien test‚es et un peu plus chŠres: le moindre d‚faut peut faire vibrer la disquette, et si le lecteur n''est pas trŠs bon, la petite galette de plastique peut ˆtre endommag‚e (voire imploser, c''est ce qui arriva sur de nombreux Atari ST)','');
INSERT INTO Lexique VALUES (  85,'516','IBM','Virus informatique ‚galement connu sous le nom de Leap Frog','');
INSERT INTO Lexique VALUES (  86,'5250','HDW','Nom des terminaux d''IBM pour ses mini-ordinateurs AS/400','');
INSERT INTO Lexique VALUES (  87,'56K Line','COM','Ligne de communication num‚rique capable de transporter des donn‚es avec un d‚bit de 56 Kbps','');
INSERT INTO Lexique VALUES (  88,'5iŠme','','Abr‚viation de ®CinquiŠme¯','');
INSERT INTO Lexique VALUES (  89,'600','IBM','Virus informatique ‚galement connu sous le nom de Veronezh','');
INSERT INTO Lexique VALUES (  90,'6151-11 16 Port Smart Hub','HDW','Carte r‚seau de ThomasúConrad','');
INSERT INTO Lexique VALUES (  91,'6242 Arcnet 8-Bit','HDW','Carte r‚seau de ThomasúConrad','');
INSERT INTO Lexique VALUES (  92,'6245 Arcnet 16-Bit','HDW','Carte r‚seau de ThomasúConrad','');
INSERT INTO Lexique VALUES (  93,'6245 Twisted Pair Plus Ethernet','HDW','Carte r‚seau de ThomasúConrad','');
INSERT INTO Lexique VALUES (  94,'6246 PS/2 Board Arcnet','HDW','Carte r‚seau de ThomasúConrad','');
INSERT INTO Lexique VALUES (  95,'650','IBM HDW','L''IBM 650 fut consid‚r‚ en son temps (vers 1960) comme le ®modŠle T¯ de l''informatique. Il eut un succŠs sans pr‚c‚dent … l''‚poque, car il s''‚tait vendu … 1500 exemplaires..','');
INSERT INTO Lexique VALUES (  96,'6502','HDW','Microprocesseur 8 bits de Mostek. Ce microprocesseur fut utilis‚ par exemple pour les Apple ][ et Commodore 64','');
INSERT INTO Lexique VALUES (  97,'6566','CK64 HDW','Connu ‚galement sous le nom de VIC, abr‚viation de Video Interface Controller, un contr“leur graphique et d''animation','');
INSERT INTO Lexique VALUES (  98,'669','SON','Fichier contenant un Module sonore au format du Soundtracker appel‚ ®669¯','');
INSERT INTO Lexique VALUES (  99,'680x0','HDW','La Famille des Processeurs 68000 de Motorola','');
INSERT INTO Lexique VALUES ( 100,'6800','HDW','Synonyme de MC6800. Ce microprocesseur de Motorola dispose de 2 registres accumulateurs 8-bits, bits conditionnel, un registre index 16-bits, un registre pointeur de pile, et un registre compteur de programme','');
INSERT INTO Lexique VALUES ( 101,'68000','HDW','Microprocesseur 32 bits avec un bus de 16 bits de Motorola. Il ‚quipait entre autre les ordinateur Atari et les Macintosh','');
INSERT INTO Lexique VALUES ( 102,'6801','HDW','Synonyme de MC6801. C''est un peu un membre interm‚diaire de la famille Mororola 6800, situ‚ entre le 6800 et le 6809. Le MC6801 a les mˆmes registres et instructions que le MC6800, par-contre il possŠde beaucoup plus d''instructions','');
INSERT INTO Lexique VALUES ( 103,'68020, 68030','HDW','Microprocesseur 32 bits de Motorola','');
INSERT INTO Lexique VALUES ( 104,'68040','HDW','Processeur 32 bits de chez Motorola. Tout pareil que le 68030, mais avec un coprocesseur arithm‚tique, une ex‚cution en pipeline des instructions et plusieurs bus internes','');
INSERT INTO Lexique VALUES ( 105,'68060','HDW','Processeur de chez Motorola, … la courte vie, il s''est retrouv‚ complŠtement d‚pass‚ d''une part par les processeur PowerPC, et d''autre part par les machins d''Intel','');
INSERT INTO Lexique VALUES ( 106,'6805','HDW','Synonyme de MC6805. Le MC6805 est destin‚ aux applications … micro-contr“le; il a le mˆme type d''instruction que le 6800 mais avec seulement un accumulateur, toutefois il a des instructions ‚tendus de manipulation de bit','');
INSERT INTO Lexique VALUES ( 107,'6809','HDW','Synonyme de MC6809. Successeur du 6800 de Motorola; il ‚tend l''architecture original du MC6800 en incluant plus de registres, d''instruction, et de mode d''adressages','');
INSERT INTO Lexique VALUES ( 108,'6845','IBM HDW','Contr“leur vid‚o de Motorola pour les cartes MDA, HGC & CGA. Concernant les cartes vid‚o post‚rieurs (EGA, MCGA, VGA,...), un contr“leur ayant le mˆme comportement, sans avoir le mˆme nom ou la mˆme marque, est employ‚ pour le contr“le du moniteur','');
INSERT INTO Lexique VALUES ( 109,'68B09E','HDW','Microprocesseur 8 bits utilis‚ pour les Coco 3. Il supporte un adressage m‚moire de 512 Ko mais pas d''adressage sp‚cifique pour les ports d''entr‚e/sortie, il doit donc utiliser la m‚moire pour faire des accŠs … des entr‚es/sorties','');
INSERT INTO Lexique VALUES ( 110,'68HC11','HDW','Synonyme de MC68HC11. Le plus r‚cent de la premiŠre g‚n‚ration des micro-ordinateurs, ce processeur apparaŒt avec un superset de registres … la 6800 et des instructions d''ajustement en plus de 8 Ko de m‚moire ROM, 256 octets de RAM et un circuit de p‚riph‚rique','');
INSERT INTO Lexique VALUES ( 111,'699','IBM','Virus informatique','');
INSERT INTO Lexique VALUES ( 112,'6D','','Animation','6DOF');
INSERT INTO Lexique VALUES ( 113,'6DOF','','Abr‚viation de Six Degrees Of Freedom. Quand on a 6 degr‚s de libert‚, c''est qu''on peut zoomer, faire un panoramique, pivoter sur soi-mˆme, tanguer, rouler, et faire un mouvement de lacet','');
INSERT INTO Lexique VALUES ( 114,'6E','HDW','Abr‚viation de Ergonomie, mission, nergie, cologie, Efficacit‚, conomie. Ce sont les points principaux des sp‚cifications TCO-92 concernant les Moniteurs informatiques','');
INSERT INTO Lexique VALUES ( 115,'6iŠme','','Abr‚viation de ®SixiŠme¯','');
INSERT INTO Lexique VALUES ( 116,'6x86','HDW','Processeur compatible avec le Pentium mis au point par Cyrix','');
INSERT INTO Lexique VALUES ( 117,'74LS612','IBM HDW','Contr“leur des registres de page du DMA des AT','');
INSERT INTO Lexique VALUES ( 118,'789','IBM','Virus informatique surnomm‚ Filehider','');
INSERT INTO Lexique VALUES ( 119,'7iŠme','','Abr‚viation de ®SeptiŠme¯','');
INSERT INTO Lexique VALUES ( 120,'8 bits','','Architecture de la majorit‚ des Micros du d‚but des ann‚es 1980. C''est la largeur du Bus et la taille des Registres du Processeur','');
INSERT INTO Lexique VALUES ( 121,'8-tunes','IBM','Virus informatique','');
INSERT INTO Lexique VALUES ( 122,'80/20','HDW','Un processeur passe 80% de son temps … ex‚cuter des programmes ‚crits avec 20% de son jeu d''instructions. C''est cette constatation ayant donn‚ naissance au RISC','');
INSERT INTO Lexique VALUES ( 123,'800','','La temp‚rature en degr‚s Celsius de l''encre … la sortie des buses d''une Imprimante … Jet d''Encre','');
INSERT INTO Lexique VALUES ( 124,'8003E & 8003EB','IBM HDW','Carte r‚seau, avec tampon de 8 Ko de Western Digital Corporation','');
INSERT INTO Lexique VALUES ( 125,'8013E','IBM HDW','Carte r‚seau, avec tampon de 16 Ko de Western Digital Corporation','');
INSERT INTO Lexique VALUES ( 126,'80186','HDW','Micro-processeur d''Intel sortie en 1981, utilis‚ sur certains IBM. Son bus d''adressage est de 20 bits (1 Mo), son bus de donn‚e est sur 16 bits. Il supporte le mode r‚el. Il a malgr‚ tout ‚t‚ am‚lior‚ avec des instructions suppl‚mentaire','');
INSERT INTO Lexique VALUES ( 127,'80188','HDW','Micro-processeur d''Intel sortie en 1983, utilis‚ sur certains IBM. Identique au 80186 mais son bus de donn‚e est de 8 bits au lieu de 16 bits','');
INSERT INTO Lexique VALUES ( 128,'802.3','COM','Norme de l''IEEE d‚finissant la Connectique des r‚seaux Ethernet','802.x');
INSERT INTO Lexique VALUES ( 129,'802.5','COM','Norme de l''IEEE d‚finissant la Connectique des r‚seaux Token Ring','802.x');
INSERT INTO Lexique VALUES ( 130,'802.6','NTW','Protocol r‚seau concernant les sp‚cifications pour les M.A.N. (Metropolitan Area Network)','');
INSERT INTO Lexique VALUES ( 131,'802.11','COM','Norme de l''IEEE d‚finissant les r‚seaux sans fils dans la bande de fr‚quence 2.400-2.480 Ghz. Les d‚bits vont de 1 … 4 Mbit/s','802.x');
INSERT INTO Lexique VALUES ( 132,'802.x','COM','Ensemble de normes de l''IEEE d‚finissant les r‚seaux locaux (LAN), en partic. 802.3 d‚finit la Connectique des r‚seaux Ethernet, et 802.5 d‚finit les r‚seaux Token Ring','802.11');
INSERT INTO Lexique VALUES ( 133,'802.x','NTW','Ensemble de normes IEEE de d‚finition de protocoles de r‚seaux Locaux','');
INSERT INTO Lexique VALUES ( 134,'80286','HDW','Micro-processeur d''Intel sortie en 1982, utilis‚ sur les AT et les XT286. Son bus d''adressage est sur 24 bits (16 Mo), son bus de donn‚e est de 16 bits. Il supporte aussi bien le mode r‚el que le mode prot‚g‚. Son cadencement fut 6, 8, 12 et 16 Mhz','');
INSERT INTO Lexique VALUES ( 135,'80386DX','HDW','Micro-processeur d''Intel sortie en 1985, utilis‚ sur les 386, PS/1 et PS/2. Son bus d''adressage est de 32 bits (4 096 Mo), son bus de donn‚es sur 32 bits. Il supporte le mode r‚el, le mode prot‚g‚, et le mode virtuel 8086','');
INSERT INTO Lexique VALUES ( 136,'80386SX','HDW','Micro-processeur d''Intel compatible aux 80386DX. Bus d''adressage de 24 bits, bus de donn‚es sur 16 bits','');
INSERT INTO Lexique VALUES ( 137,'8039','HDW','Microprocesseur utilis‚ pour les modems 2400 bauds','');
INSERT INTO Lexique VALUES ( 138,'8042','IBM HDW','Contr“leur Motorola destin‚ … la manipulation des clavier des AT et PS/2','');
INSERT INTO Lexique VALUES ( 139,'8048','IBM HDW','Contr“leur Motorola destin‚ … la manipulation des claviers PC et XT','');
INSERT INTO Lexique VALUES ( 140,'80486DX','HDW','Micro-processeur d''Intel. Bus d''adressage sur 32 bits (4 096 Mo), bus de donn‚e 32 bits. Supporte le mode R‚el, prot‚g‚, Virtuel 8086. PossŠde ‚galement un coprocesseur int‚gr‚ et une m‚moire cache','');
INSERT INTO Lexique VALUES ( 141,'80486SLC','HDW','Micro-processeur apparue au environ de 1993 sur le march‚, utilis‚ par les 486, certains PS/1 et PS/2. quivalent au 80486DX mais fabriqu‚ par IBM. Il est surnomm‚ le "Blue Lighting"','');
INSERT INTO Lexique VALUES ( 142,'80486SX','HDW','Micro-processeur d''Intel. Identique au 80486DX, mais contrairement … celui-ci, il ne dispose pas de coprocesseur','');
INSERT INTO Lexique VALUES ( 143,'80586','HDW','Micro-processeur d''Intel ‚galement appell‚ Pentium. Son bus d''adressage est sur 32 bits (4 096 Mo), son bus de donn‚es est de 32 bits. Il supporte aussi bien le mode r‚el, prot‚g‚, que le mode virtuel 8086. Le coprocesseur est int‚gr‚. Les premiers processeur de cette race ont failli causer la faitte d''Intel puisque ceux-ci surchauffait incroyablement … un point tel qu''aprŠs une heure d''utilisation il rendait l''ƒme! Il avait ‚galement de nombreux problŠme arithm‚tique, la division par 2, ne donne pas n‚cessairement la bonne r‚ponse...','');
INSERT INTO Lexique VALUES ( 144,'8080','HDW','Micro-processeur d''Intel sortie en 1974, utilis‚ pour les CP/M 80. Son bus d''adressage est sur 16 bits (64 Ko), mais son bus de donn‚e est de 8 bits','');
INSERT INTO Lexique VALUES ( 145,'8085','HDW','Micro-processeur d''Intel sortie en 1976 ayant sensiblement les mˆmes caract‚ristiques de fonctionnement externe que le 8080','');
INSERT INTO Lexique VALUES ( 146,'8086','HDW','Micro-processeur d''Intel sortie en 1978, utilis‚ pour les PC et XT d''IBM. Son bus d''adressage est sur 20 bits (1 Mo), mais son bus de donn‚e est de 16 bits. Il supporte al‚grement le mode r‚el','');
INSERT INTO Lexique VALUES ( 147,'8087','HDW','Coprocesseur arithm‚tique associ‚ au 8086, au 8088, au 80186 et au 80188','');
INSERT INTO Lexique VALUES ( 148,'8088','HDW','Micro-processeur d''Intel sortie en 1979, identique au 8086, mais son bus de donn‚e est 8 bits','');
INSERT INTO Lexique VALUES ( 149,'80C286','HDW','Essentiellement identique au 80286 mais plus ‚conomique en ‚nergie','');
INSERT INTO Lexique VALUES ( 150,'80x86','HDW','La Famille des processeurs Intel, du 8086 au 80486','8088, 80186, 80286, 80386');
INSERT INTO Lexique VALUES ( 151,'8237A','IBM HDW','Contr“leur DMA des PC, XT, AT & PS/2','');
INSERT INTO Lexique VALUES ( 152,'8237A-5','IBM HDW','Contr“leur DMA 2 des AT & PS/2','');
INSERT INTO Lexique VALUES ( 153,'8253','IBM HDW','Horloge programmable des PC/XT','');
INSERT INTO Lexique VALUES ( 154,'8254','IBM HDW','Horloge programmable des AT','');
INSERT INTO Lexique VALUES ( 155,'8255A','IBM HDW','Contr“leur clavier des PC/XT','');
INSERT INTO Lexique VALUES ( 156,'8259 esclave','IBM HDW','IRQ2 des AT & PS/2','');
INSERT INTO Lexique VALUES ( 157,'8259A','IBM HDW','Contr“leur d''interruption 1 des PC, XT, AT & PS/2','');
INSERT INTO Lexique VALUES ( 158,'8503','IBM HDW','Moniteur VGA','');
INSERT INTO Lexique VALUES ( 159,'8507','IBM HDW','Moniteur VGA','');
INSERT INTO Lexique VALUES ( 160,'8512','IBM HDW','Moniteur VGA','');
INSERT INTO Lexique VALUES ( 161,'8513','IBM HDW','Moniteur VGA','');
INSERT INTO Lexique VALUES ( 162,'8514','IBM HDW','Moniteur VGA','');
INSERT INTO Lexique VALUES ( 163,'8514/A','IBM HDW','IBM 8514/AI, carte graphique introduite par IBM en 1987, (pour les IBM et compatibles) dont la d‚finition graphique est de 1024x768 avec une gamme de 256 couleurs. Cette carte possŠde son propre processeur central. Synonyme presque parfait.. XGA','');
INSERT INTO Lexique VALUES ( 164,'8515','IBM HDW','Moniteur VGA','');
INSERT INTO Lexique VALUES ( 165,'8547','','Chiffre utilis‚ pour d‚signer Matte','');
INSERT INTO Lexique VALUES ( 166,'8604','IBM HDW','Moniteur VGA','');
INSERT INTO Lexique VALUES ( 167,'88000','HDW','Processeurs RISC de Motorola (avant la naissance des PowerPC)','');
INSERT INTO Lexique VALUES ( 168,'8N1','COM','8, bits de donn‚es, pas de Parit‚ (No parity), un Bit de Stop: une configuration standard de transfert de donn‚es par Port S‚rie','');
INSERT INTO Lexique VALUES ( 169,'905','IBM','Virus informatique surnomm‚ Backfont','');
INSERT INTO Lexique VALUES ( 170,'948','IBM','Virus informatique surnomm‚ Screenplus1','');
INSERT INTO Lexique VALUES ( 171,'<g>','','Le ®g¯ signifie ®grin¯, c''est-…-dire ®sourire¯, ®rictus¯, ®grimace¯ (cela d‚pend fortement du contexte, mais en g‚n‚ral c''est un sourire complice et moqueur','');
INSERT INTO Lexique VALUES ( 172,'@','','Prononc‚ ®At¯ en anglais, c''est l''Arobase, essentiellement utilis‚ pour s‚parer le nom de la BAL de celui du serveur dans une Adresse lectronique','');
INSERT INTO Lexique VALUES ( 173,'A','Algol68','Sp‚cificateur de caractŠre','');
INSERT INTO Lexique VALUES ( 174,'A','DOS','Quand cette lettre est suivie de ®:¯, c''est l''identifiant habituel du Lecteur de Disquettes, en particulier sous DOS. Exemple: ®Copie tout sur le lecteur A!¯','');
INSERT INTO Lexique VALUES ( 175,'A0','PRN','Feuille de papier d''environ un mŠtre carr‚ (840x1188 mm). On la coupe en 2 pour obtenir du A1, puis encore en 2 pour du A2... jusqu''… A13 (9x13 mm). Le A0 contient donc 16 pages A4','');
INSERT INTO Lexique VALUES ( 176,'A20','IBM','Abr‚viation de ®Address line 20¯ (Adresse de ligne 20). Les processeur 80286 et post‚rieur peuvent adresser d''une certaine fa‡on dans le mode r‚el au-del… de la marque d''un Mo, cela pouvant causer une incompatibilit‚e avec certains vieux programmes lequel pr‚voit tel adresses en dessous de l''espace adressable. Cette zone … une taille de 64 Ko','High Memory Area, Real Mode');
INSERT INTO Lexique VALUES ( 177,'A4','PRN','Format du papier … lettres fran‡ais courant: 21 x 29, 7 cm','A0');
INSERT INTO Lexique VALUES ( 178,'AA','COM','Abr‚viation de ®Automatic Answer¯. Signal indiquant qu''un Modem est prˆt … r‚pondre … l''arriv‚e d''un appel','OH');
INSERT INTO Lexique VALUES ( 179,'AAAA','','Abr‚viation de ®American Association Against Acronyms¯. Association am‚ricaine contre les acronymes','');
INSERT INTO Lexique VALUES ( 180,'AAAI','','Abr‚viation de ®American Association for Artificial Intelligence¯. Association Am‚ricaine en faveur de l''®Intelligence Artificielle¯','');
INSERT INTO Lexique VALUES ( 181,'AAL','','Abr‚viation de ®ATM Adaptation Layer¯','ATM');
INSERT INTO Lexique VALUES ( 182,'AARNET','COM','Abr‚viation de ®Australian Academic Research NETwork¯. R‚seau de la recherche et de l''enseignement en Australie. Cousin de l''®EARN¯ ou de ®Renater¯','');
INSERT INTO Lexique VALUES ( 183,'AAT','','Abr‚viation de ®Average Access Time¯. Temps d''accŠs moyen. Temps mis en moyenne pour acc‚der … une information sur un Disques, il est utilis‚ pour en caract‚riser la vitesse','');
INSERT INTO Lexique VALUES ( 184,'AAUI','APPLE','Connecteur sp‚cifique … Apple pour l''®Ethernet¯','');
INSERT INTO Lexique VALUES ( 185,'AAV','COM','Abr‚viation de ®Appel Aux Votes¯ ou ®Appel A Voter¯.','CFV');
INSERT INTO Lexique VALUES ( 186,'ABA','','Abr‚viation de ®American Bar Association¯, institut am‚ricain de statistiques','');
INSERT INTO Lexique VALUES ( 187,'Abandon','Coder','n. m. Arrˆt de l''ex‚cution d''un Programme ou d''une ®Proc‚dure¯, soit par choix de la part de l''utilisateur, soit par Plantage du programme','');
INSERT INTO Lexique VALUES ( 188,'Abandonner','Coder','Arrˆter une ®Proc‚dure¯ ou un ®Processus¯.','Abandon');
INSERT INTO Lexique VALUES ( 189,'A Basse Radiations','','Les tubes cathodiques des Moniteurs produisent un champ ‚lectrostatique et magn‚tique qui, selon le psychisme de l''Utilisateur, peut influer sur sa sant‚','');
INSERT INTO Lexique VALUES ( 190,'abcd:efgh','','Ces 8 lettres sont des chiffres hexad‚cimaux, les 4 premiers repr‚sentent un num‚ro de ®Segment¯, les 4 autres un ®Offset¯, le tout est une adresse de la m‚moire d''un PC. D– … la ®Compatibilit‚ Descendante¯. Ceci est issu des Bus de 16 bits, ne pouvant pas Adresser plus de 64 Ko d''un coup. Il fallait donc une astuce pour adresser un espace plus vaste, d''o— le d‚coupage en segments','Hexad‚cimal');
INSERT INTO Lexique VALUES ( 191,'Abend','','Abr‚viation de ®ABnormal END¯. Fin anormale d''un programme, suite … un bug, une fausse manipulation, une action malintentionn‚e...','Plantage');
INSERT INTO Lexique VALUES ( 192,'ABI','UNIX','Abr‚viation de ®Administration Binary Interface¯','');
INSERT INTO Lexique VALUES ( 193,'Ability scores','GAME','Mot d''origine anglaise utilis‚ dans ®Advanced Dungeons & Dragons¯. Ce sont les nombres d‚crivant les attributs d''un caractŠre. Ils sont divis‚s en 6 niveaux d''habilet‚: Force (Strength), Intelligence, Sagesse (®Wisdom¯), Dext‚rit‚ (®Dexterity¯), Constitution et Carisme (®Charisma¯)','');
INSERT INTO Lexique VALUES ( 194,'ABIOS','IBM','Abr‚viation d''®Advanced Basic Input Output System¯, c''est un BIOS ‚volu‚. Les modŠles IBM XT/286 et PS/2 avec un processeur 80286 ou post‚rieur contient 2 Bios s‚par‚. Le ABIOS est un Bios en mode prot‚g‚e lequel est utilis‚ par OS/2. Pour les machines sans ABIOS, tel l''IBM AT, OS/2 charge l''‚quivalent de l''®ABIOS¯ sur disque','CBIOS');
INSERT INTO Lexique VALUES ( 195,'Abonner','COM','S''inscrire … une ®Liste de Diffusion¯ pour en recevoir les messages, ou bien marquer d''une fa‡on ou d''une autre un Newsgroup pour que son Newsreader en r‚cupŠre syst‚matiquement le contenu','');
INSERT INTO Lexique VALUES ( 196,'Abort','','','Abandonner');
INSERT INTO Lexique VALUES ( 197,'About','','Le nom de l''entr‚e de menu permettant en g‚n‚ral d''obtenir quelques informations suppl‚mentaires sur le logiciel consid‚r‚. Traduit en g‚n‚ral par ®A propos de¯','');
INSERT INTO Lexique VALUES ( 198,'ABR','COM','Abr‚viation de ®Available Bit Rate¯','ATM, Bit Rate');
INSERT INTO Lexique VALUES ( 199,'ABS','Coder','Fonction retournant la valeur absolue d''une expression. C''est en quelque sorte un standard pour les programmeurs, il existe depuis le langage de programmation: ®Fortran¯, ®Basic¯, ®Pascal¯ et ®C¯. C''est fonction fait dans la plupart des cas, fixer le bit de signe … 0 et donc prend trŠs peut de temps au niveau micro-processeur. Par exemple, une variable de type ®Integer¯ de format ®Intel¯ pour micro-ordinateur, ayant une taille de 16 bits, soit limit‚ de 0 … 15, se vera fixer son bit 15 … la valeur 0','');
INSERT INTO Lexique VALUES ( 200,'ABS','CAO','Abr‚viation de ®Agfa''s Balanced Screening Technique¯. Technique de tramage num‚rique propos‚e par Agfa.','');
INSERT INTO Lexique VALUES ( 201,'Abscons OS2 Warp Merlin NT killer?','','C''‚tait le titre d''un article dans une revue au d‚but de 1997. On imagine la perplexit‚ du commun des mortels devant de telles sentences...','');
INSERT INTO Lexique VALUES ( 202,'Absorbeur','','n. m. Dispositif logiciel permettant de r‚cup‚rer toutes les Sorties d''un logiciel et de les faire disparaŒtre sans qu''elles soient trait‚es. Sous Unix: /dev/null','Slashdev Slashnul');
INSERT INTO Lexique VALUES ( 203,'Abstract','JAVA','Il s''agit de la reformulation compress‚e du contenu d''un fichier ou d''un document. Si ce terme est appliqu‚ … une classe Java, il s''agit d''une classe d‚finissant un comportement en ex‚cution.','');
INSERT INTO Lexique VALUES ( 204,'Abstrait','Coder','Type de donn‚es d‚fini par les op‚rations valides qu''on peut effectuer sur ce type, le nom des variables et leurs valeurs possibles','Type');
INSERT INTO Lexique VALUES ( 205,'Abstrait','','En reconnaissance de caractŠres, symbole n''ayant pas de signification et qu''on doit d‚finir avant de pouvoir le reconnaŒtre','OCR');
INSERT INTO Lexique VALUES ( 206,'ACB','COM','Abr‚viation de ®Automatic Call-Back¯','Call-Back');
INSERT INTO Lexique VALUES ( 207,'Acc‚l‚rateur','','n. m. Dispositif permettant de faire ce que son nom indique: acc‚l‚rer. G‚n‚ralement, les Acc‚l‚rateurs rendent l''affichage plus rapide (Acc‚l‚rateur Graphique), ou permettent de t‚l‚charger s‚lectivement des donn‚es, permettant par exemple de passer plus rapidement d''une page Web … l''autre en ne r‚cup‚rant que la substantifique mo‰lle de chacune.','');
INSERT INTO Lexique VALUES ( 208,'Acc‚l‚rateur 3D','','La plupart des acc‚l‚rateurs intŠgrent des primitives 2D (lignes, cercles, triangles, points, ...). Un acc‚l‚rateur 3D est plus sophistiqu‚ car il intŠgre des op‚rations 3D (Z buffer, ombrage de Gouraud, ...) utilis‚es en CAO et en imagerie de synthŠse. Attention, un acc‚l‚rateur 3D doit, de pr‚f‚rence, ˆtre compatible avec au moins l''une des normes suivantes: OpenGL, 3DR, Hoops ou Phigs','');
INSERT INTO Lexique VALUES ( 209,'Acc‚l‚rateur graphique','','Circuit sp‚cialis‚ dans l''affichage et dans lequel sont cƒbl‚es un certain nombre de primitives graphiques (trac‚ de lignes, remplissage, d‚placement de blocs m‚moire,...)','');
INSERT INTO Lexique VALUES ( 210,'Acc‚l‚ration','CAO','Caract‚ristique des traceurs … plumes. Elle indique le temps que met la tˆte … atteindre sa vitesse maximale. Elle varie de 2 … 6 G suivant le modŠle','');
INSERT INTO Lexique VALUES ( 211,'AccŠs','NTW','Synonyme d''®Access¯. Le fait d''obtenir des informations, ou la voie permettant de disposer de ressources ou d''informations. AccŠs Al‚atoire, AccŠs Direct, AccŠs Distant (AccŠs … Distance), AccŠs Multiligne, AccŠs Multiple, AccŠs S‚quentiel','');
INSERT INTO Lexique VALUES ( 212,'AccŠs Al‚atoire','','Quasi-synonyme d''AccŠs Direct','');
INSERT INTO Lexique VALUES ( 213,'AccŠs direct','','Les donn‚es sont localis‚es au moyen d''une adresse. Sous OS2 cette technique permettant de stocker, d''extraire ou de supprimer des enregistrements d''un fichier, de maniŠre non s‚quentielle','');
INSERT INTO Lexique VALUES ( 214,'AccŠs Distant','COM','On dit aussi ®AccŠs … Distance¯. Quand on obtient des donn‚es ‚tant physiquement ‚loign‚es, via un Cƒble ou un R‚seau','');
INSERT INTO Lexique VALUES ( 215,'AccŠs Multiligne','COM','Quand on dispose de plusieurs canaux de communication','');
INSERT INTO Lexique VALUES ( 216,'AccŠs Multiple','','Technique permettant … plusieurs utilisateurs de tirer partie en mˆme temps de ressources partag‚es','AMRF, AMRT');
INSERT INTO Lexique VALUES ( 217,'AccŠs s‚quentiel','','Les donn‚es sont lues ou ‚crites les uns … la suite de l''autre. Pour retrouver une donn‚e, il faut lire toutes celles si trouvant','');
INSERT INTO Lexique VALUES ( 218,'AccŠs s‚quentiel','HDW','Bande magn‚tique','');
INSERT INTO Lexique VALUES ( 219,'AccŠs s‚quentiel','DOS','Fichier de style ASCII','');
INSERT INTO Lexique VALUES ( 220,'AccŠs S‚quentiel Index‚','','Quand on doit parcourir, lors d''une recherche, tout ou partie des informations d''un fichier pour obtenir ce que l''on souhaite. Pour aller plus vite, on peut Indexer le fichier et cela donne un ®AccŠs S‚quentiel Index‚¯, qui fut pendant longtemps la forme la plus achev‚e de gestion de base de donn‚es. Contraire: AccŠs Direct','');
INSERT INTO Lexique VALUES ( 221,'Access','NTW','Le fait de lire ou d''‚crire sur un disque dur, de pouvoir imprimer son texte sur une imprimante. D''une maniŠre g‚n‚rale, on parle d''accŠs lorsqu''il s''agit de p‚riph‚riques.','');
INSERT INTO Lexique VALUES ( 222,'Access','','Base de donn‚e SGBDR de Microsoft, fourni avec Office dans sa version Pro, bas‚ sur le moteur ®Jet¯ et stockant toutes les donn‚es dans un seul fichier','');
INSERT INTO Lexique VALUES ( 223,'Access method','NTW','Ce terme est utilis‚ pour d‚crire le type de communication entre un terminal et un serveur par exemple','');
INSERT INTO Lexique VALUES ( 224,'Accessoire','','n. m. Petit bidule dont on a absolument besoin mais manquant toujours le dimanche, quand tous les magasins sont ferm‚s','');
INSERT INTO Lexique VALUES ( 225,'Accessoire','','n. m. Petit programme utilitaire ou simple gadget que l''on trouve dans une Interface Graphique, comme la montre, les yeux (Voir xeyes), le D‚mineur, l''agenda..','Accessoire (de) Bureau');
INSERT INTO Lexique VALUES ( 226,'Accessoire (de) Bureau','','Plus particuliŠrement, sur un Mac ou un Atari ST, les Accessoires de Bureau sont constamment accessibles (via le Menu Pomme sur un Mac)','Accessoire');
INSERT INTO Lexique VALUES ( 227,'Accessoires','Coco3 CK64 HDW','Extension tel l''imprimante, magn‚tocassette, cartouche, manette de jeu,..','');
INSERT INTO Lexique VALUES ( 228,'Accord‚on','PRN','Mode de stockage d''un papier Listing de 2 kilomŠtres de long. On aurait pu les mettre en rouleaux, mais avoir un cube de papier, c''est nettement plus pratique. De plus, les feuilles sont toutes … plat, donc sans courbure','');
INSERT INTO Lexique VALUES ( 229,'Accrochage','CAO','Aide de dessin permettant d''entrer des points s''accrochant au point le plus prŠs d''une grille imaginaire','');
INSERT INTO Lexique VALUES ( 230,'Accueil','','La premiŠre chose avec laquelle on entre en contact, quand d‚bute une Session de travail. C''est l''‚cran d''accueil d''un Serveur ou d''un Logiciel','Station d''Accueil');
INSERT INTO Lexique VALUES ( 231,'Accumulateur','','','Registre');
INSERT INTO Lexique VALUES ( 232,'Accupage','','Technologie permettant le r‚glage automatique du contraste et de la luminosit‚ des Scanners de Hewlett-Packard','');
INSERT INTO Lexique VALUES ( 233,'ACD','COM','Abr‚viation de Automatic Call Distributor ou Automatic Call Distribution. Distributeur Automatique d''Appels. SystŠme (ou technique) permettant de distribuer automatiquement les appels entrants ou sortants sur un ensemble de lignes, par exemple pour les dispatcher sur les employ‚s d''une Hotline','');
INSERT INTO Lexique VALUES ( 234,'ACE','UNIX','Abr‚viation de Advanced Computing Environment. Bidule ‚tant destin‚ … normaliser Unix','');
INSERT INTO Lexique VALUES ( 235,'ACF','COM','Abr‚viation de Access Control Field. Logiciel de contr“le des communications IBM dans une architecture SNA. ş Abr‚viation de Advanced Communication Function','SNA');
INSERT INTO Lexique VALUES ( 236,'Acheminement','NTW','Synonyme de Routage. D‚termination des chemins de donn‚es … travers les noeuds d''un r‚seau','');
INSERT INTO Lexique VALUES ( 237,'Achromatopsie','CAO','Anomalie visuelle se caract‚risant par une c‚cit‚ totale aux couleurs','');
INSERT INTO Lexique VALUES ( 238,'ACIA','HDW','Abr‚viation de Asynchronous Communications Interface Adapter. Circuit Int‚gr‚ gestionnaire de port S‚rie, en vue de communications Asynchrones','UART');
INSERT INTO Lexique VALUES ( 239,'ACID','','Abr‚viation de Atomicit‚, Coh‚rence, Isolation, Durabilit‚. Ensemble des caract‚ristiques d''une Transaction','');
INSERT INTO Lexique VALUES ( 240,'ACK','COM','Abr‚viation de ACKnowledged ou ACKnowledgement. Code indiquant un accus‚ de r‚ception dans une Transmission, il n''y a pas eu d''erreur et l''‚quipement (par exemple un Modem) exp‚diteur peut alors envoyer le paquet de donn‚es suivant. Le contraire est NAK','Signalisation');
INSERT INTO Lexique VALUES ( 241,'Acknowledgement','COM','','ACK');
INSERT INTO Lexique VALUES ( 242,'ACL','','Abr‚viation de Access Control List. Liste des personnes ayant le droit d''acc‚der … une Ressource (un fichier, un R‚seau ...), et parfois … quelles conditions','');
INSERT INTO Lexique VALUES ( 243,'ACLU','','Abr‚viation de American Civil Liberties Union. Organisation am‚ricaine de d‚fense des libert‚s individuelles, dont l''activit‚ s''‚tend naturellement … la d‚fense des libert‚s des Internautes (lutte contre le CDA par exemple)','');
INSERT INTO Lexique VALUES ( 244,'ACM','','Abr‚viation de l''®Association for Computing Machinery¯. Association am‚ricaine (mais internationale officiellement) pour l''informatique, cr‚‚e en 1947, publiant notamment ses ®Communications¯, afin de promouvoir la recherche et les normes dans le domaine. Le SIGGRAPH en est issu','SIG');
INSERT INTO Lexique VALUES ( 245,'ACM','','Abr‚viation de Advanced Computer Modeling','');
INSERT INTO Lexique VALUES ( 246,'ACME HUMOUR:','','Abr‚viation de A Company that Makes Everything. Une entreprise faisant tout et n''importe quoi, … commencer par les farces et attrappes invraisemblables des toons. On trouve ce terme un peu partout dans la culture am‚ricaine','');
INSERT INTO Lexique VALUES ( 247,'ACME WINDOWS','','Abr‚viation de Application Creation Made Easy. Dans le fichier WIN.INI, il est possible de d‚couvrir la ligne ®[MS Setup (ACME) Table Files]¯','');
INSERT INTO Lexique VALUES ( 248,'ACNOR','','Abr‚viation Association Canadienne de NORmalisation. Son nom en anglais semble ˆtre le CSA (Canadian Standardization Association)','');
INSERT INTO Lexique VALUES ( 249,'ACPC','APPLE','Abr‚viation de Apple Communication Protocol Card','');
INSERT INTO Lexique VALUES ( 250,'ACPI','HDW','Abr‚viation de Advanced Configuration and Power Interface. Gestion de l''‚conomie d''‚nergie conforme au systŠme d''exploitation. Elle devrait ˆtre int‚gr‚e sur les futur PC de bureau aussi bien que sur les portables. Cette norme permet de mettre en Veille un Micro-Ordinateur, lui permettant de se r‚veiller en 10 … 15 secondes, et donc d''ˆtre utilis‚ en tant que R‚veil-Matin, programmateur de magn‚toscope, r‚pondeur t‚l‚phonique..','APM');
INSERT INTO Lexique VALUES ( 251,'Acquisition','','n. f. Synonyme de Num‚risation, ce terme est en effet employ‚ en g‚n‚ral pour la num‚risation d''un signal analogique provenant d''un capteur (par exemple du son, de l''image...)','');
INSERT INTO Lexique VALUES ( 252,'Acquisition','','n. f. D''une maniŠre g‚n‚rale, collecte et saisie de donn‚es en vue de leur traitement informatis‚','');
INSERT INTO Lexique VALUES ( 253,'Acquittement','COM','n. m. Accus‚ de r‚ception d''un message. Synonyme de ACK (Acknowledgement). Antonyme: NAK','');
INSERT INTO Lexique VALUES ( 254,'Acrobat','','Utilitaire d''Adobe convertissant tout document au format PDF (Portable Document Format), rendant sa consultation possible … l''aide d''un Player sur n''importe quel ‚cran, et ce, ind‚pendamment du logiciel cr‚ateur','');
INSERT INTO Lexique VALUES ( 255,'Acrobat Distiller','','Logiciel commercial permettant de produire des documents PDF','Acrobat');
INSERT INTO Lexique VALUES ( 256,'ACS','CAO','Abr‚viation de "Adobe''s Accurate Screens". Technique de tramage num‚rique propos‚e par Adobe','');
INSERT INTO Lexique VALUES ( 257,'ACSE','NTW','Abr‚viation de Association Control Service Element','');
INSERT INTO Lexique VALUES ( 258,'Actif','','l‚ment d''une Interface Graphique, ou programme dans un environnement Multitƒche, qui re‡oit les entr‚es de l''utilisateur, ‚tant op‚rationnel au moment o— on agit','');
INSERT INTO Lexique VALUES ( 259,'action par d‚faut','OS2','Op‚ration ex‚cut‚e lorsque l''utilisateur appuie sur la touche ®ENTER¯, utilise le bouton de s‚lection de la souris en cliquant 2 fois sur un objet ou effectue une manipulation directe. L''action par d‚faut est l''action la plus fr‚quemment utilis‚e dans une situation donn‚e','');
INSERT INTO Lexique VALUES ( 260,'Activation','','n. f. Action de donner le Focus … un ‚l‚ment quelconque d''une Interface Graphique (souvent c''est … un Widget, et en g‚n‚ral, c''est par une action de l''utilisateur). Par la suite, c''est cet ‚l‚ment qui recevra en priorit‚ les entr‚es de l''utilisateur. ş D''une maniŠre g‚n‚rale, lancement de l''ex‚cution d''un programme','');
INSERT INTO Lexique VALUES ( 261,'Active desktop','','Ce tableau de bord de l''‚cran Windows est reli‚ … Internet et peut rapatrier des informations de maniŠre r‚guliŠre ou se connecter au site Web de Microsoft afin de mettre … jour les pilotes de l''ordinateur','');
INSERT INTO Lexique VALUES ( 262,'Active input area','MAC','Entr‚e inline. R‚gion de la fenˆtre de l''application dans lequel l''utilisateur entre le texte pour la conversion par un service composant du texte. L''application et le service composant du texte partage la responsabilit‚ pour la r‚gion d''entr‚e active.','');
INSERT INTO Lexique VALUES ( 263,'Active Movie','','Norme propri‚taire de Microsoft trŠs puissante bas‚e sur DirectX, et f‚d‚rant les diff‚rents Formats et types d''Animations et de vid‚o num‚rique (AVI, MPEG, QuickTime)','');
INSERT INTO Lexique VALUES ( 264,'Activer','','ş Mettre en fonction. ş tat d''une unit‚ de traitement permettant l''ex‚cution de certains types d''interruptions. ş Initialiser une op‚ration sur un circuit ou une unit‚. ş Rendre un Programme, une Proc‚dure ou une option op‚rationnel(le). ş Transformer un programme en Processus. Contraire: D‚sactiver','');
INSERT INTO Lexique VALUES ( 265,'ActiveX','INTERNET','Bidule cr‚‚ par Microsoft et permettant d''utiliser (ou de cr‚er) tout un tas d''extensions Multim‚dia sur un site Web. ActiveX est surtout connu pour les problŠmes de s‚curit‚ qu''il a pu engendrer. Un composant ActiveX ne peut s''ex‚cuter que sur une plate-forme Windows. L''enjeu est si important que Microsoft a accept‚ de confier son sort … un organisme ind‚pendant','');
INSERT INTO Lexique VALUES ( 266,'Actualisation','JAVA','M‚canisme de mise … jour ou de suppression de ligne … la position actuelle du curseur SQL','');
INSERT INTO Lexique VALUES ( 267,'ACU','COM','Abr‚viation de Automatic Call Unit','');
INSERT INTO Lexique VALUES ( 268,'AD','','Abr‚viation de Access Denied. Courant sur les R‚seaux, quand on cherche … acc‚der ind–ment … des donn‚es, ou qu''on se balade au petit bonheur. On dit parfois qu''on a ‚t‚ ®Ad‚is‚¯','');
INSERT INTO Lexique VALUES ( 269,'AD','','Abr‚viation Administrative Domain','');
INSERT INTO Lexique VALUES ( 270,'A/D','CAO','Abr‚viation de "Analog to Display". C''est le proc‚d‚ permettant de transformer un signal analogique sous forme digital ou num‚rique','');
INSERT INTO Lexique VALUES ( 271,'Ada','','Pr‚nom de la Comtesse Lovelace, Augusta Ad‚la‹de, la fille de Lord Byron, math‚maticienne consid‚r‚e comme la premiŠre informaticienne, elle a invent‚ le branchement conditionnel','Babbage Charles');
INSERT INTO Lexique VALUES ( 272,'Ada','Coder','Langage de programmation ‚volu‚ de type modulaire. C''est un langage de programmation … contrainte forte, notamment dans le typage, et enserrant le Programmeur dans un corset qu''il trouve souvent insupportable. Mise au point par J. FD. Ichbiah et son ‚quipe en 1979 suite … un appel d''offre du DoD. Ce fut un bide commercial, essentiellement parce que le cahier des charges tentait une quadrature du cercle: r‚aliser un mˆme langage pour faire de la gestion et de l''informatique embarqu‚e temps r‚el. ş ®Les Hackers trouvent la gestion des Exceptions et les Communication Inter-Processus de Ada particuliŠrement hilarantes.¯','');
INSERT INTO Lexique VALUES ( 273,'Adam','HDW','Ordinateur familiale de la fin des ann‚es 1970 ayant une 20aine de Ko de m‚moire et en plus ayant le Basic, Tableur et traitement de texte inclue en ROM. Il n''obtenu pas un grand succŠs du fait, entre autre, qu''il avait des bugs trŠs inqui‚t‚ dans sa ROM. Par exemple, il perdait des parties de texte dans le traŒtement de texte lorsqu''on d‚pla‡ait des morceaux tous simplement. AprŠs que c''est nombreux problŠme est ‚t‚ connu par le publique en g‚n‚ral, elle perdit sa clientŠle potentiel. Depuis ce temps, la compagnie n''a plus jamais fait surface dans les ordinateurs familiale: on ne sait trop si elle a fait faillite, a ‚t‚ racheter ou un autre sc‚nario du mˆme genre classique','');
INSERT INTO Lexique VALUES ( 274,'Adaptateur','','n. m. Dispositif permettant de connecter un systŠme alors qu''il n''avait pas ‚t‚ pr‚vu … l''origine pour le faire. Exemple: Adaptateur r‚seau, Adaptateur SCSI, Adaptateur Vid‚o. ®Adapter¯ en anglais','');
INSERT INTO Lexique VALUES ( 275,'Adaptateur Vid‚o','','Carte d''Extension permettant de transformer les signaux ‚lectroniques en signaux analogiques compr‚hensibles par le Moniteur. On dit maintenant une Carte Vid‚o, car elles sont devenues de vrais petits ordinateurs...','Contr“leur Vid‚o');
INSERT INTO Lexique VALUES ( 276,'Adapteur monochrome','IBM HDW','L''adapteur monochrome (tous types confondus) possŠde 2 connecteurs: un connecteur pour imprimante parallŠle (25 ®trous¯) et un connecteur par moniteur monochrome TTL … 9 ®trous¯ (®9-pin D-connector¯). Les signaux sur le connecteur monochrome sont les suivants:'+#13+
                                  'ÚÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿'+#13+
                                  '³ Broche ³ Description                 ³'+#13+
                                  'ÆÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍµ'+#13+
                                  '³  1     ³ Terre                       ³'+#13+
                                  '³  2     ³ Terre                       ³'+#13+
                                  '³  6     ³ Intensit‚                   ³'+#13+
                                  '³  7     ³ Vid‚o                       ³'+#13+
                                  '³  8     ³ Synchronisation horizontale ³'+#13+
                                  '³  9     ³ Synchronisation verticale   ³'+#13+
                                  'ÀÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ'+#13+
                                  'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿'+#13+
                                  '³        ____________________________________________        ³'+#13+
                                  '³        \                                          /        ³'+#13+
                                  '³ ÛÛÛÛÛ   \      5      4      3       2      1    /  ÛÛÛÛÛ  ³'+#13+
                                  '³ÛÛÛÛÛÛÛ   \    ù      ù      ù       ù      ù    /  ÛÛÛÛÛÛÛ ³'+#13+
                                  '³ ÛÛÛÛÛ     \                                    /    ÛÛÛÛÛ  ³'+#13+
                                  '³            \      9      8       7      6     /            ³'+#13+
                                  '³             \    ù      ù       ù      ù     /             ³'+#13+
                                  '³              \______________________________/              ³'+#13+
                                  'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ'+#13+
                                  'Il ne faut pas confondre ce connecteur avec les connecteurs semblables utilis‚s pour la sortie ®RGB¯ et pour la sortie s‚rielle.','');
INSERT INTO Lexique VALUES ( 277,'Adapteur (de) sexe','IBM HDW','Il arrive quelquefois que la sortie s‚rielle ou parallŠle d''un ordinateur et la p‚riph‚rique qu''on souhaŒte y connecter disposent du mˆme type de fiche, (mƒle-mƒle ou femelle-femelle). Pour remedier … ce problŠme, on utilisera ®sex changer¯ (module de changement de sexe)','');
INSERT INTO Lexique VALUES ( 278,'Adapteur vid‚o','IBM HDW','C''est la carte de circuit alimentant le moniteur. Elle peut ˆtre soit destin‚e … l''affichage graphique, soit texte, et combiner. Le tableau suivant donne les caract‚ristiques des principales adapteur pour PC d''IBM:'+#13+
                                                             'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿'+#13+
                                                             '³ Nom de carte ³ Nombre couleur ³ R‚solution ³ R‚solution ³ Autres modes support‚es ³'+#13+
                                                             '³              ³                ³ Horizontal ³ vertical   ³                         ³'+#13+
                                                             'ÆÍÍÍÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍµ'+#13+
                                                             '³  CGA         ³ 2, 4           ³ 640        ³ 200        ³ 320x200, 4 couleurs     ³'+#13+
                                                             '³  EGA         ³ 16/64          ³ 640        ³ 350        ³ CGA d''IBM               ³'+#13+
                                                             '³  PGC (PGA)   ³ 256/256K       ³ 640        ³ 480        ³ CGA                     ³'+#13+
                                                             '³  VGA         ³ 16/256K        ³ 640        ³ 480        ³ CGA, EGA, MCGA          ³'+#13+
                                                             '³  MCGA        ³ 256/256K       ³ 320        ³ 200        ³ 640x480, 2 couleurs     ³'+#13+
                                                             '³  HGC         ³  ÄÄÄÄÄÄÄÄ      ³ 720        ³ 348        ³  ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ ³'+#13+
                                                             'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ'+#13+
                                                             'D''autres cartes existent bien s–r, mais sont moins connues (et moins bien support‚es par les logiciels). Remarquer les cartes multistandard (ATI EGA Wonder) ‚mulant les modes CGA, EGA et Hercule.','');
INSERT INTO Lexique VALUES ( 279,'ADB','APPLE','Abr‚viation de Apple Desktop Bus. Interface g‚rant les principaux P‚riph‚riques d''entr‚e (clavier, souris, manette de jeux...) sur un Mac, pouvant supporter jusqu''… 16 p‚riph‚riques en mˆme temps.','');
INSERT INTO Lexique VALUES ( 280,'ADC','HDW','Abr‚viation de Analog to Digital Converter. Convertisseur Analogique-Digital.','DAC, CAN');
INSERT INTO Lexique VALUES ( 281,'ADD','Coder','Nom du Mn‚monique en Assembleur correspondant … l''instruction r‚alisant une addition','');
INSERT INTO Lexique VALUES ( 282,'Add-In','','Sorte de Patch servant … am‚liorer le fonctionnement d''un systŠme en rempla‡ant certaines de ses fonctions par d''autres (normalement plus ‚volu‚es). Comparer … Add-On. Peut ˆtre traduit pas Colmatage en fran‡ais, ou bien par ®Logiciel Compagnon¯ (mais dans ce cas, vous avez l''assurance que votre interlocuteur ne vous comprendra pas)','');
INSERT INTO Lexique VALUES ( 283,'Additionneur','HDW','n. m. Circuit ‚lectronique capable d''effectuer une addition, que cela soit entre 2 nombres binaires ou entre des signaux analogiques','');
INSERT INTO Lexique VALUES ( 284,'Add-On','','Sorte de Patch, servant … am‚liorer le fonctionnement d''un systŠme, en lui ajoutant une ou des fonctions. Comparer … Add-In. Colmatage en fran‡ais','');
INSERT INTO Lexique VALUES ( 285,'Addr','Coder','Abr‚viation de Address','');
INSERT INTO Lexique VALUES ( 286,'Address','Coder','Mot d''origine anglaise signifiant Adresse','');
INSERT INTO Lexique VALUES ( 287,'Address Mask','INTERNET','','Masque d''Adresse');
INSERT INTO Lexique VALUES ( 288,'Address Spoofing','','L''Address Spoofing, ou IP Spoofing, consiste … se faire passer pour quelqu''un d''autre, en utilisant son adresse sur le r‚seau. On peut ainsi faire croire que la connexion ou le message re‡u provient d''un compte d''utilisateur autoris‚','Spoofing');
INSERT INTO Lexique VALUES ( 289,'Ad‚iser','','Interdire l''accŠs sur un R‚seau … un intrus, en lui envoyant en pleine poire le message ®AD¯ pour ®Access Denied¯ (accŠs refus‚). G‚n‚ralement utilis‚ … la voix passive.','');
INSERT INTO Lexique VALUES ( 290,'AdŠle','COM','n. f. N‚ologisme pour Adresse lectronique','');
INSERT INTO Lexique VALUES ( 291,'Adi','Adi','est une s‚rie de logiciels ducatifs pour le collŠge. C''est un ET nomm‚ Adi pr‚sentant les le‡ons pour le primaire et le collŠge. Adibou est la version pour les ®pr‚scolaires¯ (5-6 ans). C''est un grand succŠs commercial, l''une des seules r‚ussites du domaine en fait, car c''est assez marrant','');
INSERT INTO Lexique VALUES ( 292,'ADI','CAO','Abr‚viation d''"Autocad Device Interface". Standard graphique constituant l''‚quivalent du VDI pour le cas particulier d''Autocad','');
INSERT INTO Lexique VALUES ( 293,'Adibou','','Adibou est destin‚ aux 5-6 ans','Adi');
INSERT INTO Lexique VALUES ( 294,'ADM','Unix','Ce terme d‚signe l''administration systŠme','');
INSERT INTO Lexique VALUES ( 295,'Admin','','n. m. Abr‚viation de Administrateur, la personne gŠrant le systŠme d''un ordinateur ou un systŠme informatique. On rencontre aussi Sysadmin, ®site admin¯, si la personne se charge d''un Site sur un R‚seau, et Newsadmin. Comparer … Sysop','');
INSERT INTO Lexique VALUES ( 296,'Admin','UNIX','Nom de la commande permettant de cr‚er puis de g‚rer un fichier SCCS','');
INSERT INTO Lexique VALUES ( 297,'Administrateur','','n. m. Gestionnaire, par d‚faut et sans autre pr‚cision, de sa propre machine.','Administrateur SystŠme, Administrateur NT');
INSERT INTO Lexique VALUES ( 298,'Administrateur NT','','Administrateur d''un r‚seau de Windows NT/2000/XP','');
INSERT INTO Lexique VALUES ( 299,'Administrateur r‚seau','','Personne responsable de l''installation, de la gestion et du contr“le d''un r‚seau. L''administrateur r‚seau autorise les utilisateurs … acc‚der aux ressources partag‚es et d‚finit pour chacun un niveau d''accŠs','');
INSERT INTO Lexique VALUES ( 300,'Administrateur (du) systŠme','Unix','La personne s''occupant du fonctionnement de l''ordinateur et ex‚cutant des tƒches comme donner des comptes aux nouveaux utilisateurs et sauvegarder le systŠme','');
INSERT INTO Lexique VALUES ( 301,'Administration','','n. f. Le fait d''Administrer un systŠme.','Administrateur');
INSERT INTO Lexique VALUES ( 302,'Administrer','','Synonyme de ®G‚rer¯','Administrateur');
INSERT INTO Lexique VALUES ( 303,'ADN','NTW','Abr‚viation de Advanced Digital Network','');
INSERT INTO Lexique VALUES ( 304,'Adobe','CAO','Soci‚t‚ cr‚atrice du langage PostScript. Elle est ‚galement ‚ditrice des logiciels Illustrator et Photoshop, lesquels ont r‚volutionn‚ la m‚thode de travail des graphistes','');
INSERT INTO Lexique VALUES ( 305,'ADP','','Abr‚viation de Automatic Data Processing. Traitement automatique de donn‚es','');
INSERT INTO Lexique VALUES ( 306,'ADPCM','','Abr‚viation de Adaptative Delta (ou Digital) Pulse Code Modulation. Famille de formats compact‚s de stockage d''‚chantillons sonores dans lequel on n''enregistre que les variations entre les valeurs et non pas les valeurs elle-mˆmes. Exemple: 127-145-138 sera stock‚ 127-18-(-7). TrŠs efficace … de hauts niveaux d''‚chantillonnage, quand les diff‚rences entre 2 valeurs cons‚cutives sont faibles. C''est le format utilis‚ par les CD par exemple. En fran‡ais: MICDA','');
INSERT INTO Lexique VALUES ( 307,'Adressage','','n. m. Le m‚canisme de calcul des Adresses','');
INSERT INTO Lexique VALUES ( 308,'Adressage Absolu','','L''Adresse est l''adresse r‚elle en m‚moire','');
INSERT INTO Lexique VALUES ( 309,'Adressage Direct','','L''Adresse est donn‚e directement, sans calcul interm‚diaire ni Pointeur','');
INSERT INTO Lexique VALUES ( 310,'Adressage Index‚','','Synonyme d''Adressage Relatif','');
INSERT INTO Lexique VALUES ( 311,'Adressage Relatif','','L''Adresse est donn‚es par rapport … un autre point de la M‚moire. Synonyme d''Adressage Index‚','');
INSERT INTO Lexique VALUES ( 312,'Adresse','Coder','Sur les processeurs de la famille Intel 80xx, une adresse est toujours constitu‚e … partir de l''un des 4 registres (6 … partir des 80386) de segment (… l''exception de l''instruction CALL de langage assembleur) et d''un autre registre ou bien d''une constante. Le contenu du registre de segment est appel‚ adresse segment, le contenu de l''autre registre ou bien de la constante ‚tant appel‚ adresse d''offset. Ces 2 adresses sont des adresses logiques devant ˆtre combin‚es de la fa‡on suivante pour former une adresse physique (c''est-…-dire un num‚ro de cellule de m‚moire): le registre de segment est multipli‚ par 16 et l''adresse d''offset est addionn‚e … ce produit ((Segmentú16)+Offset=Adresse physique)','');
INSERT INTO Lexique VALUES ( 313,'Adresse','NTW','C''est un nombre hexad‚cimal identifiant un ordinateur de fa‡on biunivoque sur un r‚seau','');
INSERT INTO Lexique VALUES ( 314,'Adresse','TABLEUR','Emplacement d''une cellule dans une feuille de calcul, d‚fini par une lettre de colonne et un num‚ro de ligne (A1, par exemple)','');
INSERT INTO Lexique VALUES ( 315,'Adresse','INTERNET','Dans un nom de style monnom@mail.dotcom.fr, l''adresse est le nom de l''utilisateur + @ + la machine recevant et stockant (ou transfŠrant) le courrier de l''utilisateur','');
INSERT INTO Lexique VALUES ( 316,'Adresse absolue','TABLEUR','Adresse r‚f‚ren‡ant toujours la mˆme cellule dans une formule, mˆme lorsque cette derniŠre est d‚plac‚e. QUATTRO_PRO La touche F4 confŠre aux adresses un caractŠre absolu en y introduisant le signe de dollar ($) (ex: $A$1)','');
INSERT INTO Lexique VALUES ( 317,'Adresse dynamique','INTERNET','L''adresse que le fournisseur d''accŠs attribue … votre ordinateur lorsque vous vous connectez … l''Internet. Elle est temporaire et sera reprise par un autre utilisateur apr‚s votre d‚connexion. D''o£ la difficult‚ particuliŠre d''appeler un poste pr‚cis en t‚l‚phonie','');
INSERT INTO Lexique VALUES ( 318,'Adresse (d'')E/S','','Adresse du Tampon des E/S','');
INSERT INTO Lexique VALUES ( 319,'Adresse lectronique','','Adresse … laquelle on peut envoyer du Courrier lectronique. En g‚n‚ral, elle est r‚dig‚e de la fa‡on suivante: dieu@paradis.la-haut¯ (ici, la personne … recevant du courrier est Dieu, et il habite … paradis.la-haut). [Image] AdŠle est un n‚ologisme synonyme d''Adresse lectronique, encore peu utilis‚','');
INSERT INTO Lexique VALUES ( 320,'Adresse Internet','','Cette adresse identifie une machine connect‚e … Internet. Elle se compose de 4 octets (32 bits) ‚crits sous forme d‚cimale. Une adresse Internet s''‚crit de la maniŠre suivante: ®192.168.1.100¯. On l''appelle aussi adresse IP','');
INSERT INTO Lexique VALUES ( 321,'Adresse IP','NTW','Sert … identifier de fa‡on unique un noeud sur un r‚seau. Elle se compose du num‚ro de r‚seau et du num‚ro d''h“te. Elle est repr‚sent‚e sous forme de 4 octets en notation d‚cimale, par exemple ®138.12.25.3¯','');
INSERT INTO Lexique VALUES ( 322,'Adresse logique','INTERNET','L''adresse logique n''est pas num‚rique mais alphab‚tique, ce qui la rend plus facile d''utilisation. Elle est construite … l''inverse d''une adresse IP, allant du domaine local au domaine national. Sa syntaxe est la suivante: ®www.zdnet.com¯','');
INSERT INTO Lexique VALUES ( 323,'Adresse relative','INTERNET','Dans une formule, adresse se modifiant, lorsque la formule est d‚plac‚e, pour toujours r‚f‚rencer les positions relatives de la cellule de d‚part','');
INSERT INTO Lexique VALUES ( 324,'Adresser','','D‚terminer ou donner une Adresse … une information ou … un ensemble d''information','');
INSERT INTO Lexique VALUES ( 325,'ADSL','','Abr‚viation de Asymmetrical Digital Subscriber Line. Voir xDSL. Dans cette variante, on re‡oit beaucoup plus d''infos qu''on ne peut en envoyer, id‚al pour consommer du Net … la maison','');
INSERT INTO Lexique VALUES ( 326,'Advance Width','MAC','Mot d‚signant la pleine largeur du glyph original, situ‚ de l''autre c“t‚ de la glyph courante, incluant n''importe quel espace blanc de l''un ou l''autre des c“t‚s','');
INSERT INTO Lexique VALUES ( 327,'Advent','GAME','Le jeu d''aventure de base, sous forme textuelle piment‚e de beaucoup d''humour, impl‚ment‚ par Will Crowther sur un PDP-10. Ce logiciel s''appelle maintenant ®Adventure¯, mais sur le PDP-10, les noms de fichiers ne pouvaient compter que 6 caractŠres','');
INSERT INTO Lexique VALUES ( 328,'Adventurer','','Mot d''origine anglaise utilis‚ dans Advanced Dungeons & Dragons. Terme utilis‚ pour une des caract‚ristiques du caractŠre d''un joueur sp‚cifique dans la partie','');
INSERT INTO Lexique VALUES ( 329,'A‚rographe','CAO','Outil de dessin permettant d''obtenir un fin jet de peinture ou d''encre et de cr‚er des d‚grad‚s de couleurs ainsi que des nuages de points','');
INSERT INTO Lexique VALUES ( 330,'AEC','CAO','Abr‚viation de "Architecture Engineering and Constructor". C''est le domaine d''application de la CAO','');
INSERT INTO Lexique VALUES ( 331,'AES','','Abr‚viation de Application Environment Services. Services d''environnement d''application. Ensemble de fonctions pr‚sentes dans le GEM des Atari, pour fournir tout ce qu''il faut pour qu''un programme utilise l''interface graphique','');
INSERT INTO Lexique VALUES ( 332,'AFA','INTERNET','Abr‚viation d''Association des Fournisseurs d''AccŠs (fran‡ais)','');
INSERT INTO Lexique VALUES ( 333,'AFAI','','Abr‚viation d''Association Fran‡aise d''Audit et de conseil Informatique','');
INSERT INTO Lexique VALUES ( 334,'AFAIK','','Abr‚viation d''As Far As I Know. ®A ma connaissance¯, ®Autant que je sache¯','');
INSERT INTO Lexique VALUES ( 335,'AFAQ','','Abr‚viation d''Association Fran‡aise de l''Assurance Qualit‚. Si vous voulez une certification ISO 9000, c''est l''un des organismes auxquels il faut s''adresser en France','');
INSERT INTO Lexique VALUES ( 336,'AFAS','','Abr‚viation d''Association Fran‡aise des Auteurs de Shareware. Association (type loi de 1901) compos‚e exclusivement d''auteurs de Sharewares francophones, oeuvrant pour la promotion de ce mode de distribution de logiciel','');
INSERT INTO Lexique VALUES ( 337,'AFB','','Abr‚viation d''Association Fran‡aise de Banque','');
INSERT INTO Lexique VALUES ( 338,'AFCE','','Abr‚viation d''Association Fran‡aise du Commerce lectronique','');
INSERT INTO Lexique VALUES ( 339,'AFCET','','Abr‚viation d''Association Fran‡aise pour la Cybern‚tique conomique et Technique, renomm‚ en Association Fran‡aise des Sciences et Technologies de l''Information et des SystŠmes. Association cr‚‚e en 1968 et dont l''objectif est d''aider aux d‚veloppements de ces nouvelles techniques','');
INSERT INTO Lexique VALUES ( 340,'AFE','APPLE','Abr‚viation d''Apple File Exchange. Programme (fourni par la firme … la pomme) permettant l''‚change de fichiers entre les ordinateurs Apple et le reste du monde informatique','');
INSERT INTO Lexique VALUES ( 341,'AFEL','','Abr‚viation "Association Fran‡aise des Editeurs de Logiciels"','');
INSERT INTO Lexique VALUES ( 342,'Affectation','','ş Action de r‚acheminer un nom de p‚riph‚rique local vers une ressource partag‚e d''un serveur. ş Option de menu consistant … attribuer un identificateur d''unit‚ … un r‚pertoire du r‚seau ou un identificateur de port … une imprimante r‚seau. S''oppose … d‚saffectation','');
INSERT INTO Lexique VALUES ( 343,'Affecter','','Donner une nouvelle valeur … la m‚moire se trouvant … une certaine Adresse (pouvant ˆtre repr‚sent‚e par une variable). En g‚n‚ral: attribuer des Ressources','');
INSERT INTO Lexique VALUES ( 344,'Affichage','','Op‚ration consistant … faire apparaŒtre un graphique ou des caractŠres sur un ‚cran','');
INSERT INTO Lexique VALUES ( 345,'Affichage double','','Affichage sur deux ‚crans en mˆme temps','');
INSERT INTO Lexique VALUES ( 346,'Afficher','','Rendre visible pour l''utilisateur une information, en g‚n‚ral par l''interm‚diaire d''un cran','');
INSERT INTO Lexique VALUES ( 347,'Afficheur','','Dispositif assurant l''affichage de quelques symboles (lettres ou chiffres), … l''aide de LEDs ou de Cristaux Liquides','');
INSERT INTO Lexique VALUES ( 348,'AFIN','','Abr‚viation d''Association Fran‡aise des INformaticiens','');
INSERT INTO Lexique VALUES ( 349,'AFIPS','','Abr‚viation d''American Federation of Information Processing Societies','');
INSERT INTO Lexique VALUES ( 350,'AFISI','','Abr‚viation d''Association Fran‡aise d''Ing‚nierie des SystŠmes d''Information','');
INSERT INTO Lexique VALUES ( 351,'AFJ','','Abr‚viation d''April''s Fool Joke. En fran‡ais: Poisson d''Avril. Tradition sur le Net. Le premier avril, il ne vaut mieux pas croire ce qu''on y trouve (les autres jours non plus, d''ailleurs). Certains blagues ont fait le tour du monde, et sont rest‚es longuement dans les m‚moires, comme le coup du kremvax, o— en pleine guerre froide, les Am‚ricains auraient vendu aux Russes un VAX pour l''installer au Kremlin','');
INSERT INTO Lexique VALUES ( 352,'AFK','','Abr‚viation d''Away From Keyboard. Loin du clavier. Pour pr‚venir les gens avec lesquels vous discutez que vous avez eu un besoin pressant','BBL');
INSERT INTO Lexique VALUES ( 353,'AFNIC','','Abr‚viation d''Association Fran‡aise pour le Nommage Internet en Coop‚ration. Autre nom du NIC France. L''adresse Internet est http://www.nic.fr','');
INSERT INTO Lexique VALUES ( 354,'AFNOR','','Abr‚viation d''Association Fran‡aise de NORmalisation. Repr‚sentant fran‡ais … l''ISO','');
INSERT INTO Lexique VALUES ( 355,'AFP','','Abr‚viation d''Advanced Function Presentation. Architecture mise au point par IBM','');
INSERT INTO Lexique VALUES ( 356,'AFP','APPLE','Abr‚viation d''AppleTalk File Protocol. Protocole Apple d''accŠs aux bases de donn‚es distantes','');
INSERT INTO Lexique VALUES ( 357,'AFPI','','C''est l''Association Fran‡aise des Professionnels de l''Internet. Regroupant entre autre: World Net, France Teaser et France T‚l‚com Interactive','');
INSERT INTO Lexique VALUES ( 358,'AFT','CAO','Abr‚viation "AM Fine Tuning". Technique de tramage num‚rique propos‚ par la soci‚t‚ AM','');
INSERT INTO Lexique VALUES ( 359,'AFTEL','','Abr‚viation d''Association Fran‡aise de la TL‚matique multim‚dia','');
INSERT INTO Lexique VALUES ( 360,'AfterStep Window manager','','qu''on trouve sous Linux, bas‚ sur l''interface NextStep. Un concurrent: WindowMaker (09-08-1998)','');
INSERT INTO Lexique VALUES ( 361,'AFUI','','Abr‚viation d''Association Fran‡aise des Utilisateurs de l''Internet','');
INSERT INTO Lexique VALUES ( 362,'AFUL','UNIX','Abr‚viation d''Association Fran‡aise des Utilisateurs de Linux. On pr‚cise parfois ®et du Logiciel Libre¯','Linux, Logiciel Libre');
INSERT INTO Lexique VALUES ( 363,'Agenda ‚lectronique','','(ou organiseur) Ordinateur de la taille d''une calculatrice et poss‚dant g‚n‚ralement les programmes de base d''un ordinateur tels qu''un agenda, une calculatrice et/ou un tableur, un ‚diteur voire un traitement de texte, et un langage simple de cr‚ation de programmes. Diff‚rents logiciels peuvent ˆtre ins‚r‚s par ajout d''une cartouche, enfichable sur le c“t‚ de l''appareil et permettant d''utiliser diff‚rents programmes ‚volu‚s. Les supports de stockage sont les m‚moires interne et externe (cartouche). Utilis‚s quand il est impossible de saisir les donn‚es au moyen d''un clavier ou quand les conditions de travail ne permettent pas de se servir d''un PC normal ou d''un portable (ordinateur), les agendas sont si '+
                                                          'petits que l''on peut les tenir dans une seule main, tandis qu''on introduit les donn‚es de l''autre. Parfois aussi, ils sont munis d''un ‚cran tactile … cristaux liquides (voir LCD) avec des menus. Le principal march‚ de ces ordinateurs est l''industrie, o— il faut effectuer des contr“les r‚guliers','');
INSERT INTO Lexique VALUES ( 364,'Agent','','Ils sont ‚lectroniques ou intelligents. Voir Agent lectronique et Agent Intelligent. Remarque importante: pour l''instant, ces machins n''existent pas, et sont les proies de tout un tas de chercheurs qui ont chacun leur propre d‚finition id‚aliste de tout le bazar...','');
INSERT INTO Lexique VALUES ( 365,'Agent lectronique','','Programme se d‚pla‡ant dans un R‚seau et r‚alisant des tƒches simples: recherche d''informations, r‚servations de places sur avion...','Agent');
INSERT INTO Lexique VALUES ( 366,'Agent Intelligent','','Programme utilisant l''Intelligence Artificielle pour exploiter un r‚seau en fonction des besoins de son MaŒtre (i.e. l''Utilisateur). On rˆve de pouvoir lancer un agent sur un r‚seau puis d''‚teindre sa machine et de revenir une fois qu''il aura fait tout le boulot. Mais cela reste bel et bien un rˆve','Agent');
INSERT INTO Lexique VALUES ( 367,'Agent SystŠme','Windows95','Programme permettant de lancer des processus … heures fixes, … la maniŠre de AT ou Cron','');
INSERT INTO Lexique VALUES ( 368,'AGI','','Abr‚viation d''Active Group Integrity','');
INSERT INTO Lexique VALUES ( 369,'Agiplan','IBM','Virus informatique ‚galement connu sous le nom de ®Month 4-6¯','');
INSERT INTO Lexique VALUES ( 370,'AGIS','','L''un des principaux nids … Spammeurs en 1997, les h‚bergeant avec un cynisme infect','IEMMC, Spamford');
INSERT INTO Lexique VALUES ( 371,'AGL','Coder','Abr‚viation d''Atelier de G‚nie Logiciel. Ensemble de programmes permettant la conception de programmes, d''applications ou de systŠmes parfois trŠs complexes','G‚nie Logiciel');
INSERT INTO Lexique VALUES ( 372,'AGLOO','Coder','Abr‚viation d''Atelier de G‚nie Logiciel Orient‚ Objet','Eiffel, G‚nie Logiciel');
INSERT INTO Lexique VALUES ( 373,'AGP','','Abr‚viation d''Accelerated Graphic Port. Bus local permettant un d‚bit de 500 Mo/s avec un Pentium Pro (ou un de ses successeurs) vers une Carte Graphique, destin‚ principalement a am‚liorer les performances des applications graphiques en 3D','');
INSERT INTO Lexique VALUES ( 374,'Agrandissement','OS2','Option disponible … partir de l''option Fenˆtre d''un menu contextuel. Elle permet de redimensionner une fenˆtre de sorte qu''elle soit … sa taille maximale','');
INSERT INTO Lexique VALUES ( 375,'AGUA','','Abr‚viation d''Association des Grands Utilisateurs Apple','Apple');
INSERT INTO Lexique VALUES ( 376,'AI','','Abr‚viation d''Artificial Intelligence','Intelligence Artificielle');
INSERT INTO Lexique VALUES ( 377,'Aide','OS2','Option d''un menu contextuel permettant d''obtenir des informations d''aide sur un objet (par exemple, l''aide g‚n‚rale pr‚sentant l''objet). Vous pouvez ‚galement mettre l''option en ‚vidence et cliquer sur le bouton F1 pour obtenir ces informations. Lorsque vous s‚lectez la flŠche situ‚e … droite de l''option Aide, le menu en cascade s''affichant propose des options d''aide suppl‚mentaires. L''option Aide peut ‚galement figurer sur la barre de menus de certains programmes','');
INSERT INTO Lexique VALUES ( 378,'Aide contextuelle','','Fonction d''aide s‚lective d''un logiciel +d''application. Elle permet d''obtenir des informations relatives … une action que l''utilisateur souhaite ex‚cuter. Dans un traitement de texte sous Windows, par exemple, lorsque l''utilisateur appuie sur la touche "F1" alors qu''il se trouve dans la fenˆtre d''impression, il obtient directement le fichier d''aide relatif … l''impression. L''aide contextuelle est l''une des caract‚ristiques de la nouvelle g‚n‚ration des logiciels d''application fonctionnant … partir d''une interface utilisateur graphique telle qu''OS/2 ou Windows','');
INSERT INTO Lexique VALUES ( 379,'Aide en Ligne','','','Aide');
INSERT INTO Lexique VALUES ( 380,'Aide sur les touches','OS2','Option du menu en cascade Aide permettant d''obtenir des informations sur les fonctions des touches d‚finies pour un objet ou un programme. Cette option figure ‚galement dans les programmes dont la barre de menus comporte l''option Aide','');
INSERT INTO Lexique VALUES ( 381,'AIF','SON','Abr‚viation d''Audio Interchange File format. Fichier contenant du son ‚chantillonn‚e dans un format cousin d''IFF d''abord sur l''Amiga, puis chez Apple, compress‚ ou non (variantes AIFC, AIFF)','WAV');
INSERT INTO Lexique VALUES ( 382,'AIFC','SON','Abr‚viation d''Audio Interchange File format Compressed','AIF');
INSERT INTO Lexique VALUES ( 383,'AIFF','SON','Abr‚viation d''Audio Interchange File Format. Format de fichiers audio utilis‚ dans le monde Macintosh et unix (par SGI notamment). Dans le monde Unix, le format le plus r‚pandu est ®.au¯ ayant ‚t‚ d‚velopp‚ par Sun puis repris par Next','AIF');
INSERT INTO Lexique VALUES ( 384,'Aiguillage','Coder','Dans un Programme, structure de contr“le de flux permettant d''ex‚cuter une suite d''Instructions parmi plusieurs en fonction d''une condition. Synonyme: Alternative','Boucle, It‚ratif');
INSERT INTO Lexique VALUES ( 385,'Aiguille','PRN','Technique d''Impression, dans laquelle des ®aiguilles¯ (bouts de m‚tal trŠs pointus) vont frapper le papier … travers un ruban encreur','Imprimante, Matriciel');
INSERT INTO Lexique VALUES ( 386,'AIM','','Abr‚viation d''Apple - IBM - Motorola. L''union sacr‚e, pour lutter contre le couple infernal Microsoft + Intel (Voir Wintel). Le rˆve d''AIM est un ordinateur fonctionnant grƒce … un PowerPC, avec son propre systŠme d''exploitation. L''alliance prit la d‚rive en 1997','');
INSERT INTO Lexique VALUES ( 387,'Air Brush','CAO','Synonyme d''Ar‚ographe','');
INSERT INTO Lexique VALUES ( 388,'AISI','','Abr‚viation d''As I See It. ®Tel que je le vois¯','');
INSERT INTO Lexique VALUES ( 389,'AIT','','Abr‚viation d''Advanced Intelligent Tape','');
INSERT INTO Lexique VALUES ( 390,'AIUI','','Abr‚viation d''As I Understand It. ®Tel que je le comprends¯','');
INSERT INTO Lexique VALUES ( 391,'AIX','IBM','Version de Unix. Malgr‚ sa conformit‚ … Posix, de nombreux utilitaire change de nom','');
INSERT INTO Lexique VALUES ( 392,'Ajouter une Patte','','Ajouter une Carte dans un Ordinateur. Cela n''a strictement rien … voir avec les Pattes des Puces','');
INSERT INTO Lexique VALUES ( 393,'AL','Coder','Abr‚viation d''Assembly Language. Langage d''assemblage, c''est-…-dire Assembleur','');
INSERT INTO Lexique VALUES ( 394,'Alabama','IBM Virus','Signature du virus Alabama: ®06h F9h 00h 01h 3Ch D3h 75h 06h F9h 00h 00h BBh 40h 00h 8Eh DBh 33h¯. Le virus ALABAMA est signal‚ pour la premiŠre fois au mois d''octobre 1989 … l''universit‚ h‚bra‹que de J‚rusalem. Le virus ALABAMA est un virus pour des programmes, il contamine uniquement les fichiers de type EXE en y ajoutant 1 560 octets. Le virus est r‚sidant en m‚moire vive dŠs lorsqu''un programme contamin‚ est ex‚cut‚. Il ne diminue pas le volume de m‚moire vive disponible. Le processus de contamination est relativement complexe. Le virus recherche s''il '+
                                                       'existe un fichier de type EXE non contamin‚ dans le r‚pertoire courant. Si oui il le contamine, sinon il contamine le programme en cours d''ex‚cution. Le d‚clenchement contamine le programme en cours d''ex‚cution. Le d‚clenchement des actions de dommages est bas‚ sur une dur‚e. AprŠs une heure de pr‚sence en m‚moire vive le virus ALABAMA affiche le message suivant:'+
                                                       'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿'+
                                                       '³ SOFTWARE COPIES PROHIBITED BY INTERNATIONAL LAW 000 ³'+
                                                       '³   BOX 1055 Tuscambia ALABAM USA                     ³'+
                                                       'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ'+
                                                       'Lorsque le virus est actif le vendredi, il procŠde parfois … une permutation (swapping) entre le programme en cours d''ex‚cution et le programme candidat … la contamination. Ce ph‚nomŠne conduit … une lente perte des programmes. Le virus ALABAMA d‚route l''interruption 09h relative au clavier ainsi que les commandes IN et OUT relatives aux ports d''entr‚e/sortie. Lorsque le virus d‚tecte la combinaison de touches CTRL+ALT+DEL; il simule un red‚marrage … chaud tout en restant en m‚moire vive.');
INSERT INTO Lexique VALUES ( 395,'Alarme','','Signal visuel ou sonore indiquant qu''une erreur s''est produite, que le systŠme est devenu Instable, qu''il est d‚j… trop tard pour sauver le monde. Le terme d''alarme est aussi utilis‚ dans les agendas ‚lectroniques. Dans ce sens, tout r‚veil-matin est une alarme.','');
INSERT INTO Lexique VALUES ( 396,'A la Vol‚e','','Synonyme de Temps R‚el, mais sans les exigences en b‚ton arm‚ du v‚ritable temps r‚el. Dans des traitements de donn‚es … la vol‚e, on ne verra pas forc‚ment d''inconv‚nient … perdre des donn‚es en cours de route, on cherche seulement … faire du mieux qu''on peut en un temps trŠs restreint. C''est d''ailleurs pourquoi les systŠmes de compression de disque (e.g. Drivespace) ont autant de problŠmes. On The Fly en anglais','');
INSERT INTO Lexique VALUES ( 397,'A-Law','SON','Format de Compression des donn‚es Audio, en 8 kHz, optimis‚ pour le traitement de la voix, et qu''on retrouve un peu partout, du t‚l‚phone … l''Internet, et dans le format AU','');
INSERT INTO Lexique VALUES ( 398,'Album','APPLE','Synonyme de Presse-Papier chez Apple','');
INSERT INTO Lexique VALUES ( 399,'Alerte','','Message destin‚ … l''utilisateur lui indiquant que quelque chose ne se passe pas tout … fait comme pr‚vu: plus de papier dans l''imprimante, un virus efface le disque dur... Le message est pr‚sent‚ dans une ®BoŒte d''alerte¯','');
INSERT INTO Lexique VALUES ( 400,'Alerteurs d''‚v‚nements','InterBase','Message pass‚ de la base de donn‚es … l''application, signalant l''occurence d''un ‚v‚nement dans la base de donn‚es. Un ‚v‚nement est une modification, ou un ensemble de modifications, apport‚ … la base de donn‚es, ‚tant important pour l''application. Un alerteur d''‚v‚nements peut ˆtre envoy‚ directement d''une application ou depuis un d‚clencheur. Si un d‚clencheur est utilis‚, vous pouvez d‚finir l''‚v‚nements comme la notification d''une insertion, mise … jour ou suppression dans une table particuliŠre. Utilisez le langage des d‚clencheurs pour d‚finir les conditions sp‚cifiques de l''‚v‚nement','');
INSERT INTO Lexique VALUES ( 401,'AlgŠbre Bool‚enne','MATH','','Boole George, Bool‚en');
INSERT INTO Lexique VALUES ( 402,'Algo','Coder','Abr‚viation usuelle de Algorithme','');
INSERT INTO Lexique VALUES ( 403,'Algol','','n.m. Abr‚viation d''ALGOrithme Language. Langage utilis‚ pour la programmation des problŠmes scientifiques ou techniques dans les ordinateurs','');
INSERT INTO Lexique VALUES ( 404,'Algorithme','Coder','Mot d‚riv‚ de Al-Khwarismi, nom du math‚maticien qui, au IXe siŠcle, inventa les chiffres arabes. Sch‚ma de r‚solution d''un problŠme par d‚composition en s‚rie d''action ‚l‚mentaire. D‚signe la description des actes … effectuer … un r‚sultat. Ou si vous pr‚f‚rez: Un jeu de rŠgles ou de proc‚dures bien d‚fini qu''il faut suivre pour obtenir la solution d''un problŠme dans un nombre fini d''‚tapes. Un algorithme peut comprendre des proc‚dures et instructions alg‚briques, arithm‚tiques, et logiques, et autres. Un algorithme peut ˆtre simple ou compliqu‚. '+
                                                      'Cependant un algorithme doit obtenir une solution en un nombre fini d''‚tapes. Les algorithmes sont fondamentaux dans la recherche d''une solution par voie d''ordinateur, parce que l''on doit donner … un ordinateur une s‚rie d''instructions claires pour conduire … une solution dans un temps raisonnable','');
INSERT INTO Lexique VALUES ( 405,'Algorithmie','Coder','Synonyme de Algorithmique, science de l''Algorithme','');
INSERT INTO Lexique VALUES ( 406,'Algorithmique','Coder','Science de l''Algorithme','');
INSERT INTO Lexique VALUES ( 407,'Alias','Coder Delphi','Nom sp‚cifiant l''emplacement des tables d''une base de donn‚e','');
INSERT INTO Lexique VALUES ( 408,'Alias','','Objet pointant vers un autre, pour avoir accŠs … ce dernier depuis un endroit d‚plac‚','');
INSERT INTO Lexique VALUES ( 409,'Alias','','Abr‚viation d''une commande, qui sera substitu‚e par la commande complŠte lors de l''‚valuation. Utilis‚ dans ce dernier sens particuliŠrement dans le Bourne-Shell et le Korn-Shell sous Unix','');
INSERT INTO Lexique VALUES ( 410,'Alias de commande','Unix','Un autre nom pour commande. Quand vous tapez le nom d''alias, la commande lui est substitu‚e. Les synonymes sont utiles pour rappeler des commandes avec d''autres noms que les leurs dans le systŠme Unix; par exemple, les utilisateurs de Dos peuvent penser … dir plut“t qu''… ls quand ils veulent lister un r‚pertoire. Les synonymes sont aussi utiles pour cr‚er des commandes ex‚cutant plusieurs commandes … la fois','');
INSERT INTO Lexique VALUES ( 411,'Aliasing','CAO','Effet visuel ind‚sirable obtenu lors de l''affichage d''images courbes ou de diagonales ainsi que lors du passage d''une couleur ou d''une texture … une autre','');
INSERT INTO Lexique VALUES ( 412,'Alice','MATH','','Alice et Bob');
INSERT INTO Lexique VALUES ( 413,'Alice et Bob','MATH','Ce sont les noms des 2 individus suspects n''arrˆtant pas de s''‚changer des messages secrets, dans la majeure partie des documents parlant de Cryptographie et ayant besoin d''un exemple. En fait, c''est plus clair que de parler d''une partie A envoyant un message … une partie B... Dans le monde anglo-saxon, on trouve aussi Eve (the eavesdropper), Paul (the prover) et Vic (the verifier)','');
INSERT INTO Lexique VALUES ( 414,'A-Life','','Abr‚viation d''Artificial Life, soit Vie Artificielle en anglais','');
INSERT INTO Lexique VALUES ( 415,'Alignement','','Mot d''origine anglaise utilis‚ dans Advanced Dungeons & Dragons. C''est tout simplement la phylosophie d''un caractŠre','');
INSERT INTO Lexique VALUES ( 416,'Alignement','','Le d‚placement horizontal des lignes du texte s''applique avec respectivement le c“t‚ gauche et droit de la r‚gion texte. L''alignement peut ˆtre gauche, droite, centr‚ ou justifi‚ (soit aussi bien gauche que droite). Ceci ne doit pas ˆtre confondu avec line direction','');
INSERT INTO Lexique VALUES ( 417,'Alignement','TABLEUR','Position d''une libell‚ ou d''une valeur dans une cellule: par d‚faut, alignement … gauche pour les libell‚s, alignement … droite pour les valeurs','');
INSERT INTO Lexique VALUES ( 418,'Alignement','HDW','Action consistant … s''assurer qu''une donn‚e se situe … une adresse paire (les processeurs Intel vont plus vite dans ce cas, les :680x0 plantent si ce n''est pas le cas). C''est souvent une Directive de Compilation (qui s''appelle alors ®align¯)','');
INSERT INTO Lexique VALUES ( 419,'Alim','HDW','','Abr‚viation courante d''Alimentation dans son premier sens (‚lectrique)');
INSERT INTO Lexique VALUES ( 420,'Alimentation','HDW','C''est la puissance de l''alimentation ‚lectronique disponible sur l''ordinateur. Un systŠme peu performant n''a guŠre besoin d''une alimentation importante; par contre, s''il est plus ou moins complet, il aura besoin d''une alimentation puissante afin de r‚pondre aux exigeances des divers composants','');
INSERT INTO Lexique VALUES ( 421,'Alimentation','PRN','M‚canisme permettant d''envoyer du papier dans une imprimante','Alimentation Feuille … Feuille, Alimentation par Picots, Alimentation par Friction, EntraŒnement');
INSERT INTO Lexique VALUES ( 422,'Alimentation feuille … feuille','PRN','Synonyme de Sheet feeder','');
INSERT INTO Lexique VALUES ( 423,'Alimentation par Picots','PRN','Un picot est un petit bitonio qui vient se loger dans des perforations sur les bords du papier, et qui permet un bon EntraŒnement du papier dans une Imprimante','Alimentation');
INSERT INTO Lexique VALUES ( 424,'Alimentation par Friction','PRN','Mode de gavage d''une imprimante dans lequel le papier est pinc‚ feuille par feuille entre des rouleaux tournant et l''entraŒnent','Alimentation');
INSERT INTO Lexique VALUES ( 425,'Aline','NTW','R‚seau num‚rique … int‚gration de services belge (voir RNIS), ‚quivalent l…-bas de Num‚ris chez nous','');
INSERT INTO Lexique VALUES ( 426,'Al-Khwarizmi','','Pr‚nomm‚ ®Mohammed Ibn Musa Abu Djefar¯, ce fut un math‚maticien arabe','Algorithme');
INSERT INTO Lexique VALUES ( 427,'Allen Paul','','Ing‚nieur cofondateur de Microsoft avec Bill Gates','');
INSERT INTO Lexique VALUES ( 428,'Allocation','Coder','Attribution d''un certain espace m‚moire … une variable, le plus souvent de type tableau ou pointeur','');
INSERT INTO Lexique VALUES ( 429,'Allumage','','Ce qui se produit aprŠs que vous ayez appuy‚ sur le gros bouton de mise en marche votre ordinateur (… condition que votre machine ne soit pas d‚j… en fonctionnement','Boot');
INSERT INTO Lexique VALUES ( 430,'Aloha','','SystŠme mis au point … l''universit‚ d''Hawa‹, pour les accŠs al‚atoires aux canaux satellites. Le problŠme des hawa‹ens ‚tait de relier toutes leurs Œles','');
INSERT INTO Lexique VALUES ( 431,'Alouette-Placard','','Surnom de Hewlett-Packard (HP), le Constructeur. Ce terme est plus rigolo que p‚joratif','');
INSERT INTO Lexique VALUES ( 432,'Alpha','HDW','Nom d''une ligne de Processeurs plus que puissants mis au point par Digital, bas‚ sur une architecture RISC','');
INSERT INTO Lexique VALUES ( 434,'Alpha','','Degr‚ de finition d''un logiciel: on parle de l''‚tat alpha. Cela signifie que le logiciel est en phase de teste interne; il n''est pas encore officiellement diffus‚','');
INSERT INTO Lexique VALUES ( 435,'Alpha AXP','HDW','Puce de Digital tournant … prŠs de 1 600 Mhz (1,6 Ghz) sortie en 1992. Lors de sa conception, elle est la plus rapide au monde. Principalement fignol‚e pour Windows NT, elle sert surtout sous Unix et VMS - le systŠme d''exploitation propre … Digial et aux machines VAX -. On en retrouve bien s–r ailleurs, notamment dans les super-ordianteurs Crays','');
INSERT INTO Lexique VALUES ( 436,'Alphabet','','L''ensemble des lettres, ou caractŠre, utilis‚ … l''‚criture d''un langage. L''alphabet utilise le script Romain constitu‚ de 26 caractŠres: A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y et Z','');
INSERT INTO Lexique VALUES ( 437,'Alphanum‚rique','','D‚signation d''une variable de type chaŒne de caractŠre','');
INSERT INTO Lexique VALUES ( 438,'Alpha Release','','Quasi-synonyme d''Alpha Version. La Release insistant sur le fait de distribuer le programme, la Version sur le programme lui-mˆme','');
INSERT INTO Lexique VALUES ( 439,'Alpha Version','','Pr‚version d''un logiciel, bourr‚e de Bugs et incomplŠte. Elle est distribu‚e soit pour faire baver les futurs utilisateurs, soit pour tester ce qui a ‚t‚ d‚j… fait. Vient ensuite la Bˆta Version. On dit aussi Alpha Release','');
INSERT INTO Lexique VALUES ( 440,'Alt','','Abr‚viation usuelle de la touche Alternate sur un compatible PC (quand il n''y a pas assez de place sur le cabochon). L''‚quivalent sur un Mac est la clover key. Avec Emacs, on utilise aussi l''abr‚viation ®A-¯','');
INSERT INTO Lexique VALUES ( 441,'Alt','','Abr‚viation d''Alternatif, Ludique et Terroriste. L''une des hi‚rarchies les plus controvers‚es de Usenet (chez certains Providers US, il faut signer un papier comme quoi on a plus de 18 ans pour y acc‚der). Les rŠgles de cr‚ation des nouveaux Groupes dans cette hi‚rarchie sont en effet trŠs libres, de sorte qu''on y trouve vraiment de tout...','');
INSERT INTO Lexique VALUES ( 442,'Alta‹r IV','HDW','Premier micro-ordinateur de l''histoire de l''humanit‚. Vendu en kit, dans les ann‚es 1970, par la soci‚t‚ MITS, il n''a jamais r‚ellement fonctionn‚, mais la volont‚ ‚tait l…, et l''engouement avec... Il disposait d''un Intel 8080 (8 bits) et de 256 octets de m‚moire. Bill Gates a fait ses premiŠres armes avec.','');
INSERT INTO Lexique VALUES ( 443,'Alta Vista','INTERNET','Moteur d''indexation automatique de l''Internet con‡u par une ‚quipe de Digital (dont le fran‡ais Monnier) sur le campus de Stanford, indexant des dizaines de millions de pages du Web et permettant d''y effectuer une recherche en quelques secondes. Le robot d''indexation s''appelle Scooter','Indexation, Internet, Web Crawler, Yahoo');
INSERT INTO Lexique VALUES ( 444,'Alt‚r‚','','Se dit d''un secteur d''un Disque quand on ne peut plus y lire ou y enregistrer de donn‚es, ou d''un fichier qu''on ne peut plus lire, parce que les donn‚es qu''il contenait, ou qui le concernaient, ont ‚t‚ d‚truites (au moins en partie). Par exemple … cause d''un Head-Crash. On peut trouver Alt‚r‚ comme synonyme de ®Modifi‚¯, sans connotation qualitative, suite … de mauvaises traductions de ®Altered¯','');
INSERT INTO Lexique VALUES ( 445,'Alternat','COM','Communication Simplex, s''effectuant chacun ‚mettant … son tour, comme avec des talkies-walkies.','');
INSERT INTO Lexique VALUES ( 446,'Alternate','','Touche de Commutation classique du clavier, sur un PC. Abr‚g‚ souvent en Alt','');
INSERT INTO Lexique VALUES ( 447,'Alternative','','Instruction effectuant un test et permettant un choix entre diverses parties du Programme. On sort ainsi de l''ex‚cution purement s‚quentielle des instructions. Synonyme: Aiguillage. Classiquement, c''est un ®If-Then-Else-Endif¯','');
INSERT INTO Lexique VALUES ( 448,'AltGr','','Abr‚viation de Alternate GR. Nom de la touche du clavier ‚tendu des PC simulant l''appui simultan‚ de Control et de Alt','');
INSERT INTO Lexique VALUES ( 449,'Alto','','Puissant ordinateur des ann‚es 1970 d‚velopp‚ par Xerox. Pionnier de l''utilisation des souris pour un ordinateur personnel','');
INSERT INTO Lexique VALUES ( 450,'alt.sex','INTERNET','Nom d''une hi‚rarchie de Newsgroups de Usenet. Officiellement, vous n''avouerez jamais que vous passez votre temps … la lire. Pourtant, les statistiques montrent qu''elle est trŠs fr‚quent‚e... C''est aussi dans cette hi‚rarchie que se trouvent les forums les plus controvers‚s (pornographie sexshoot, bestialit‚, p‚dophilie...)','');
INSERT INTO Lexique VALUES ( 451,'ALU','HDW','Abr‚viation Arithmetical and Logical Unit. Unit‚ Arithm‚tique et Logique, i.e. partie d''un Processeur faisant les calculs','UAL');
INSERT INTO Lexique VALUES ( 452,'AM','COM','Abr‚viation d''Amplitude Modulation','MA');
INSERT INTO Lexique VALUES ( 453,'AMA','','Abr‚viation d''A Mon Avis. Terme utilis‚ pour limiter la port‚e de ses propos et ‚viter les Flames et autres Guerre de Religion. Synonyme un peu plus courant AMHA. En anglais, IMO (Voir plut“t IMHO)','');
INSERT INTO Lexique VALUES ( 454,'Ambre','','Caract‚rise un affichage Monochrome dont le fond est noir et les impressions d''un orange tirant sur le maronnasse. De moins en moins utilis‚, autrefois trŠs r‚pandu dans les terminaux du genre ®s‚curit‚ sociale¯','');
INSERT INTO Lexique VALUES ( 455,'AMD','IBM','La compagnie am‚ricaine AMD (abr‚viation de "Advanced Micro Devices") fut la premiŠre … briser le monopole de son ancien partenaire Intel, en produisant ses propres processeurs 286 et 386 pour PC. AprŠs de longues p‚rip‚ties concernant le microcode, elle produit aussi, depuis 1993, des processeurs 486. AMD r‚ussit ‚galement trŠs bien dans le domaine des m‚moires flash et des processeurs RISC utilis‚s essentiellement pour l''impression laser. AMD est ‚galement … l''origine d''une recherche constante de l''augmentation de la fr‚quence d''horloge des processeurs. Le K6-2, la derniŠre production de l''entreprise, rivalise avec les derniers n‚s des processeurs Intel','');
INSERT INTO Lexique VALUES ( 456,'AMDEC','','Abr‚viation d''Analyse des Modes de D‚faillance, de leurs Effets et de leur Criticit‚','');
INSERT INTO Lexique VALUES ( 457,'Ame','HDW COM','Coeur en plastique d''un Cƒble Coaxial','');
INSERT INTO Lexique VALUES ( 458,'Amener','OS2','Action de relƒcher le bouton de s‚lection d''une p‚riph‚rique de pointage pour positionner un objet aprŠs l''avoir fait glisser','faire glisser');
INSERT INTO Lexique VALUES ( 459,'America Online','','','AOL');
INSERT INTO Lexique VALUES ( 460,'American National Standards Institue','','galement connue sous le nom d''ArcNet','');
INSERT INTO Lexique VALUES ( 461,'American Standard Code for Information Interchange','','galement connue sous le nom de ASCII','');
INSERT INTO Lexique VALUES ( 462,'AMHA','','Abr‚viation d''A Mon Humble Avis. Terme utilis‚ pour limiter la port‚e de ses propos et ‚viter les Flames et autres Guerre de Religion. Synonyme un peu moins courant AMA. En anglais, IMHO','');
INSERT INTO Lexique VALUES ( 463,'AMI','','Abr‚viation d''American Megatrends Inc. L''un des principaux fabricants mondiaux de BIOS, sans lequel jamais un PC ne pourrait fonctionner','');
INSERT INTO Lexique VALUES ( 464,'Amical','','Traduction de ®User-Friendly¯. On dit plus souvent Convivial ou Ergonomique. Un systŠme amical est normalement facile … maŒtriser et simple … utiliser. Jusqu''… ce qu''il plante, ‚videmment','');
INSERT INTO Lexique VALUES ( 465,'Amiga','HDW','Ordinateur Commodore Amiga. Machine disposant de son propre processeur pour le systŠme vid‚o. Puissance remarquable pour son ‚poque, exemple: Enregistrement en temps r‚el de la t‚l‚vision. H‚las, il n''a put faire sa marque … cause du systŠme d''exploitation "buguer" … mort. Histoire: Amiga Computer Inc. (ex Hi-Toro Inc.) est … l''origine une id‚e de 3 personnages de Floride ayant l''intention d''investir 7 millions de dollars dans un projet quelconque. Ils pensŠrent tout d''abord se lancer dans le commerce mais esp‚raient '+
                                               'quelque chose de plus exitant et passionnant. Ils d‚cidŠrent donc de fonder une compagnie d''informatique. Ils furent rejoints par RJ Mical, Carl Sassenrath mais surtout par Jay Miner, ‚tant alors chez Atari, et Dave Morse, un responsable des ventes chez Tonka Toys. La premiŠre id‚e ‚tait de cr‚er la plus fantastique console de jeux possible. Et rien d''autre. Cependant, Jay et les techniciens avaient d''autres id‚es. Heureusement, ils les gardŠrent pr‚cieusement au secret, laissant ainsi croire aux dirigeants qu''ils cr‚aient seulement une '+
                                               'console. videmment le march‚ pour ce type de machines ‚tait trŠs attirant en 1982. Il trouvŠrent le nom dans un dictionnaire de synonymes. Ils voulaient v‚hiculer le sentiment d''amiti‚, et Amiga ‚tait le premier nom sur la liste. Cela leur permettait mˆme d''ˆtre devant Apple dans les listes alphab‚tiques. Cependant, avant qu''ils puissent sortir une machine, ils voulaient ‚tablir leur pr‚sence sur le march‚, de fa‡on … faire connaŒtre leur nom et … monter quelques circuits de distribution. C''est ce qu''ils firent en distribuant des '+
                                               'p‚riph‚riques et des logiciels dont ils achetŠrent les droits … d''autres entreprises. L''essentiel de leur distribution fut le Joyboard, une sorte de manette de jeu que l''on pose … terre est sur laquelle on gesticule pour activer les switches … la base. Il proposŠrent un jeu de ski et plusieurs jeux de sports. Mais un jeu que le personnel d''Amiga Inc. appr‚ciait particuliŠrement ‚tait le jeu de la M‚ditation Zen, o— il fallait s''asseoir sur le Joyboard et essayer de rester parfaitement immobile. Et en fait, c''est d''ici que le terme '+
                                               'Guru Meditation tire son origine. En 1983, l''objectif de prix pour l''Amiga ‚tait de 400$. Parfait pour une console de jeux. Mais ce prix grimpa rapidement … 600 $. Devant les difficult‚s que rencontrait alors le march‚ de la console de jeux, les cr‚ateurs de l''Amiga d‚cidŠrent qu''il leur faudrait avoir quelque chose de mieux que juste une autre console pour survivre. C''est … ce moment que les id‚es que les techniciens avaient mises de c“t‚ commencŠrent … payer. Ces id‚es comprenaient un clavier, des connecteurs, des contr“leurs de '+
                                               'disques, un lecteur de disquettes. RJ Mical se charge alors de la programmation de Intuition, Jay Miner d‚veloppe le principe de l''affichage HAM et d‚veloppe le Blitter sur une id‚e Ron Nicholson. Il ‚tait alors pr‚vu d''introduire secrŠtement l''Amiga au CES d''hiver en janvier 1984. La partie logicielle fut r‚alis‚e 10 jours avant le CES, et fonctionnait parfaitement en simulation. Malheureusement, quand le mat‚riel fut mis en marche quelques jours plus tard, lui, ne marchait pas aussi bien qu''en simulation. Ce mat‚riel, bien s–r, '+
                                               'n''‚tait pas en silicium. Les custom chips ‚taient en fait des cartes ‚lectroniques, plac‚es verticalement autour d''un noyau central, et reli‚es entre elles par les c“t‚, comme un Cray. Chaque custom chip ‚tait une petite tour, une masse de cƒbles. AprŠs un travail acharn‚ jusqu''aux derniŠres minutes avant l''ouverture du CES, l''Amiga fonctionnait, toujours sous la forme de plusieurs cartes ‚lectroniques. Il purent ainsi offrir des d‚monstrations priv‚es dans une piŠce r‚serv‚e. AprŠs cette premiŠre nuit de succŠs au CES, tous les '+
                                               'responsables du marketing ‚taient pour le moins optimistes, car l''Amiga fit l''effet d''une bombe, malgr‚ le fait qu''ils essayŠrent de le garder secret. Y compris au CES, tout le monde travaillait sur la machine pour cr‚er des d‚mos, corriger quelques bugs. C''est … ce moment que fut cr‚‚e la c‚lŠbre d‚mo Boing. AprŠs le CES, Amiga Inc. ‚tait lourdement endett‚. Tout cela avait co–t‚ plus que les 7 millions de dollars pr‚vus, et encore plus de temps et d''argent ‚taient n‚cessaires pour le lancer sur le march‚. Malheureusement, les '+
                                               'investisseurs refusaient de s''engager d''avantage. De nouveaux fonds ‚taient donc n‚cessaires rapidement. Les responsables des finances r‚ussirent … faire durer les choses jusqu''au CES de juin. A ce moment l…, l''Amiga ‚tait fonctionnel et en silicium. Pendant ce show, les personnes assistant aux d‚monstrations cherchaient dans toute la piŠce la vraie machine qui affichait ces images. Maintenant l''argent commen‡ait … rentrer et un int‚rˆt grandissant ce faisait sentir dans les m‚dias. Et comme dans toutes le petites entreprises, dŠs que '+
                                               'l''argent rentre, il est d‚pens‚. Plusieurs personnes furent embauch‚es. Des ing‚nieurs mat‚riel pour optimiser et r‚duire les co–ts de l''architecture. Des ing‚nieurs en logiciels pour terminer le systŠme d''exploitation. Mˆme le soudain afflux d''argent ‚tait tout juste suffisant pour maintenir la compagnie … flots. En fait, pour r‚aliser le projet de l''id‚e … la distribution, 50 millions de dollard auraient ‚t‚ n‚cessaires. videmment Amiga Inc. n''avait aucune possibilit‚ de trouver une telle somme, et la fin se faisait sentir. Tout le monde '+
                                               'pers‚vŠrait, acceptant de travailler sans r‚mun‚ration, hypoth‚quant leurs biens. Cela ne suffisait pas. Ils contactŠrent Sony, Apple, Philips, HP, Silicon Graphics. Finalement, ils contactŠrent Jack Tramiel, chez Atari. Celui-ci leur offrit 1 million de dollars et un mois de n‚gociation. L''argent fut d‚pens‚ en une journ‚e. Bien s–r Tramiel ‚tait conscient que Amiga Inc. n''‚tait pas vraiment en position de discuter puisque … moins d''ˆtre rachet‚e, elle est … la rue. Il leur offrit 98 cents par action. C''est alors que, 3 jours avant '+
                                               'l''expiration de la p‚riode de n‚gociation, Commodore appela. 2 jours plus tard, il rachŠte Amiga Inc, Los-Gatos, Californie pour 4,25$ par action et 1 million de dollar pour rembourser Atari. Commodore avait enfin trouv‚ le moyen de prendre le virage du 16/32 bits aprŠs le succŠs mondial des Vic20 et C64. Comme par hasard, quelques mois plus tard, Atari sortait sa premiŠre machine … base de 68000 avec souris, ic“nes et fenˆtres, le 520 ST... Commodore leur donna 27 millions pour le d‚veloppement. Tous les ing‚nieurs eurent ainsi la '+
                                               'possibilit‚ de travailler sur des stations Sun et du mat‚riel de pointe. Mais Commodore fit aussi de nombreuses choses pour l''Amiga, de la r‚duction des co–ts, jusqu''… l''aspect machine professionnelle. On est loin de la console de jeux du d‚but. Cependant, Commodore ‚tait press‚ de commercialiser la machine, et refusŠrent aux d‚veloppeurs les 18 mois suppl‚mentaires qu''ils demandaient pour finioler le systŠme. Ainsi, si en 1985 l''Amiga 1000 fut distribu‚ avec un Kickstart sur disquette, c''est tout simplement parce que la version '+
                                               '1.0 ‚tait largement incomplŠte et bugu‚e, et que les mise … jours devaient pouvoir se faire facilement. "Amiga World" voit le jour la mˆme ann‚e. En 1986 l''Amiga 1000 est lanc‚ en Angleterre, le SideCar est cr‚‚ et Mehdi Ali entre chez Commodore. En 1987 l''Amiga 2000 est mis au point peut avant l''Amiga 500. le KickStart 1.2 est disponible. La soci‚t‚ Scala est fond‚e en NorvŠge. En 1990 l''Amiga 3000, le premier systŠme entiŠrement 32 bits, est pr‚sent‚. La mˆme ann‚e l''Amiga 500+ est lanc‚ en Europe. En 1991 le CDTV est lanc‚ mais ce r‚vŠle '+
                                               'rapidement un ‚chec commercial. L''ann‚e 1992 voit naŒtre l''Amiga 600, le chipset AGA, l''Amiga 4040, l''Amiga 1200 et le systŠme 3.0. En 1993, sort la derniŠre machine de Commodore: la CD-32. A la fin de cette ann‚e, les comptes de Commodore pr‚sentent un d‚ficit de 107 millions de dollars. En Avril 1994, Commodore est officiellement en liquidation judiciaire. Le 20 juin 1994, Jay Miner nous quitte. De nombreuses soci‚t‚s semblent alors int‚ress‚es par le rachat de Commodore et de la technologie de l''Amiga mais les annonces de '+
                                               'rachats se multiplient sans que rien n''en ressorte r‚ellement. AprŠs cette longue p‚riode de brouillard, la soci‚t‚ allemande ESCOM finit par racheter Commodore, et donc l''Amiga, en 1995 (pour la somme de 10 millions de Dollars). Escom promet un avenir radieux … l''Amiga et envisage de lui faire franchir le pas vers la technologie RISC. Mais ESCOM, en 1996, est confront‚ … de grosses difficult‚s financiŠres l''obligeant … cŠder Amiga Technologies … la soci‚t‚ am‚ricaine Gateway 2000','');
INSERT INTO Lexique VALUES ( 466,'AMON MIB','','Abr‚viation d''ATM Monitoring MIB. MIB (base de donn‚es d''informations de gestion) con‡ue pour tourner sous ATM, bas‚e sur RMON','');
INSERT INTO Lexique VALUES ( 467,'Amor‡age','','Red‚marrage, synonyme de Boot','');
INSERT INTO Lexique VALUES ( 468,'Amorce','','','Boot');
INSERT INTO Lexique VALUES ( 469,'Amorce','HDW','Extr‚mit‚ d''une Bande magn‚tique, par laquelle celle-ci est attach‚e … sa bobine','');
INSERT INTO Lexique VALUES ( 470,'Amorcer','','Version fran‡aise de Booter','');
INSERT INTO Lexique VALUES ( 471,'Ampersand','','Nom anglais du caractŠre ®&¯ (®et commercial¯ en fran‡ais)','');
INSERT INTO Lexique VALUES ( 472,'Amplificateur','HDW','Dispositif ‚lectronique fournissant en sortie un signal de puissance multiple de celle du signal d''entr‚e','');
INSERT INTO Lexique VALUES ( 473,'Amplifier','HDW','Version anglaise de Amplificateur','');
INSERT INTO Lexique VALUES ( 474,'AMPS','','Abr‚viation d''Advanced Mobile Phone System. T‚l‚phone cellulaire analogique utilis‚ dans les Am‚riques … partir de 1976. Remplac‚ par TDMA, puis GSM','');
INSERT INTO Lexique VALUES ( 475,'AMRF','COM','Abr‚viation d''AccŠs Multiple … R‚partition en Fr‚quence. M‚thode d''accŠs aux satellites, en train de disparaŒtre car elle est complexe et gaspille de la Bande Passante. On utilise de plus en plus l''AMRT … la place. FDMA en anglais','');
INSERT INTO Lexique VALUES ( 476,'AMRT','COM','Abr‚viation d''AccŠs Multiple … R‚partition dans le Temps. M‚thode d''accŠs aux satellites, o— les utilisateurs ‚mettent sur le mˆme Canal chacun … son tour, les uns aprŠs les autres. Voir aussi AMRF. TDMA en anglais','');
INSERT INTO Lexique VALUES ( 477,'AMS','HDW','Abr‚viation d''Autocommutateur Multi-Services','Autocommutateur');
INSERT INTO Lexique VALUES ( 478,'Amstrad','HDW','Abr‚viation d''Alan Michael Sugar Trading. Firme ayant fabriqu‚ des ordinateurs au milieu des ann‚es 1980 et ayant ‚t‚ beaucoup d‚cri‚e. Mais les CPC 464 (avec lecteur de cassettes int‚gr‚), 664 et 6128 (utilisant les fameuses Disquettes 3 pouces incompatibles avec le reste du march‚) ont eu ‚norm‚ment de succŠs, non sans raisons. Il s''agissait de machines 8 Bits utilisant CP/M comme SE','');
INSERT INTO Lexique VALUES ( 479,'ANAC','COM','Abr‚viation d''Automatic Number Announcement Circuit. Num‚ro de t‚l‚phone vous disant qui vous ˆtes: vous l''appelez et il vous r‚pond en vous donnant votre propre num‚ro. Utile pour les techniciens devant s''y retrouver parmi des kilos de fils. Utile aussi pour les Pirates et les espions','');
INSERT INTO Lexique VALUES ( 480,'Anaglyphe','','Nom technique donn‚ aux images en relief … base de plusieurs images superpos‚es (en g‚n‚ral une bleue et une rouge: on a besoin de lunettes … verres color‚s pour voir le relief)','Autost‚r‚ogramme');
INSERT INTO Lexique VALUES ( 481,'Analog transmission','NTW','Communication employant un signal continu modifi‚ en amplitude','');
INSERT INTO Lexique VALUES ( 482,'Analogique','','Un signal est dit analogique lorsqu''il est repr‚sent‚ par une grandeur physique variant de fa‡on continue: rotation, tension, courant,... On oppose couramment analogique … num‚rique','');
INSERT INTO Lexique VALUES ( 483,'Analogique','HDW','Mat‚riel informatique d‚signant l''‚cran vid‚o analogue. Moniteur utilis‚ pour les cartes VGA et Super VGA','');
INSERT INTO Lexique VALUES ( 484,'Analogique','CAO','Par opposition … num‚rique, se dit de tout ph‚nomŠne o— la repr‚sentation des donn‚es se fait sous forme de grandeur physique continue','');
INSERT INTO Lexique VALUES ( 485,'Analyse','','Proc‚d‚ utilis‚ pour connaŒtre les sp‚cifications mat‚riel ou logiciel','');
INSERT INTO Lexique VALUES ( 486,'Analyse graphique','TABLEUR','Variation des donn‚es et repr‚sentation graphique de ces donn‚es','');
INSERT INTO Lexique VALUES ( 487,'Analyse Post-Mortem','','Analyse d''un Programme aprŠs qu''il se soit plant‚ d''une maniŠre ou d''une autre. Ce qu''on analyse est en fait un extrait de la m‚moire centrale de l''ordinateur, r‚cup‚r‚ lors du Crash, ainsi que l''‚tat des Registres du processeur','');
INSERT INTO Lexique VALUES ( 488,'Analyse (de) scŠne','CAO','Application en traitement d''images faisant appel aux techniques d''intelligence artificielle et dont l''objectif est de reconstituer une scŠne … partir d''objets connus par le systŠme de reconnaissance','');
INSERT INTO Lexique VALUES ( 489,'Analyse (de) sensibilit‚','TABLEUR','','variation');
INSERT INTO Lexique VALUES ( 490,'Analyste','','Personne analysant les besoins de l''entreprise et ‚tablissant les caract‚ristiques de programmes, logiciel, systŠme d''exploitation, pilote,... Il supervice ‚galement le travail des programmeurs','');
INSERT INTO Lexique VALUES ( 491,'Analyste-Programmeur','','Analyste programmant. C''est le m‚tier de base de l''informatique, un peu comme l''®OS¯ dans l''industrie','');
INSERT INTO Lexique VALUES ( 492,'Anarkia','IBM','Virus informatique','');
INSERT INTO Lexique VALUES ( 493,'Anatomie de base','IBM','L''organisation g‚n‚rale d''un systŠme informatique PC est sembable … un systŠme … 3 couches concentriques. ş La premiŠre couche est compos‚e du coeur de l''ordinateur: c''est le microprocesseur (CPU), eu ‚gard … son anatomie externe, la puce. ş Autour de cette puce s''organise la seconde couche concentrique compos‚e d''un vaste r‚seau ou l''information est stock‚e, transport‚e,...: Ce sont, en quelque sorte les organes nobles de l''ordinateur (un peu comme le cerveau ou les poumons). Ces organes portent le nom de m‚moire, unit‚ de calcul, contr“leur,... Ces 2 premiŠres constituent l''ordinateur proprement dit. '+
                                                          'ş La 3iŠme couche centrique, couche beaucoup plus importante, est constitu‚e de tous les organes ‚tant en ‚troite connexion avec les 2 couches pr‚c‚dentes. Ils sont en quelque sorte, le prolongement ou, en d''autres mots, les organes des sens (yeux, oreilles) et les organes d''action (membres), ce sont les p‚riph‚riques','');
INSERT INTO Lexique VALUES ( 494,'Anchor','INTERNET','Ancre en fran‡ais','');
INSERT INTO Lexique VALUES ( 495,'Ancien Testament','Coder','La premiŠre ‚dition du livre de Kernighan et Ritchie d‚crivant le langage C, intitul‚ ®The C programming language¯','');
INSERT INTO Lexique VALUES ( 496,'Ancre','INTERNET','l‚ment du langage HTML servant … d‚finir un lien Hypertexte, par exemple: <A HREF="document_vis‚"<Blablabla>/A>. L''Ancre permet g‚n‚ralement de d‚finir un lien, la Balise a un sens beaucoup plus large','Balise');
INSERT INTO Lexique VALUES ( 497,'Ancrer','TABLEUR','Action consistant … fixer la s‚lection de la premiŠre cellule d''un bloc pr‚ablement … l''extension de ce dernier. L''ancrage d''une cellule s''obtient en amenant le pointeur sur la cellule, puis en appuyant sur la touche de s‚lection Alt+F7','cellule d''ancrage');
INSERT INTO Lexique VALUES ( 498,'And','MATH','','VF, Et');
INSERT INTO Lexique VALUES ( 499,'Andro‹de','','Robot ayant la morphologie et les capacit‚s d''un ˆtre humain (en fait, bien souvent, l''andro‹de est un surhomme)','');
INSERT INTO Lexique VALUES ( 500,'ANDSI','','Abr‚viation d''Association Nationale des Directeurs de SystŠmes d''Information','');
INSERT INTO Lexique VALUES ( 501,'Angle de trame','CAO','Orientation d''une trame de demi-teintes, exprim‚e en degr‚s','');
INSERT INTO Lexique VALUES ( 502,'ANI','','Abr‚viation d''Automatic Number Identification. Identification automatique de l''appelant (au t‚l‚phone), pour savoir qui c''est qui appelle Th‚rŠse et qui la retourne contre le mur','');
INSERT INTO Lexique VALUES ( 503,'ANI','','Fichier contenant la description d''une animation, en particulier d''un Curseur anim‚','');
INSERT INTO Lexique VALUES ( 504,'Anim','','Abr‚viation d''Animation, image graphiques fantomatiques','');
INSERT INTO Lexique VALUES ( 505,'Animation','','Proc‚d‚ permettant la repr‚sentation du mouvement en synthŠse d''images. L''animation peut se faire en temps r‚el ou en temps diff‚r‚. ş D‚placement d''un ou plusieurs objets graphiques sur l''‚cran avec ou non d‚formation de celui-ci. Une animation se programme image par image selon le principe du dessin anim‚','');
INSERT INTO Lexique VALUES ( 506,'Animatique','','Ensemble des techniques ‚lectroniques et informatiques appliqu‚es … l''Animation','');
INSERT INTO Lexique VALUES ( 507,'Anime','INTERNET','Animation japonaise, trŠs en vogue sur le Net. A ne pas confondre avec les Mangas (oui, bien que ce soit exactement la mˆme chose, les mangas, c''est sur papier uniquement)','');
INSERT INTO Lexique VALUES ( 508,'ANN','NTW','Abr‚viation d''Artificial Neural Network. R‚seau de neurones artificiels','Neuronal, R‚seau Neuromim‚tique, NN');
INSERT INTO Lexique VALUES ( 509,'Anneau','NTW','Type de Topologie de r‚seau. En g‚n‚ral, des Jetons y circulent (anneau … jetons)','');
INSERT INTO Lexique VALUES ( 510,'Annotation','JAVA','Une annotation est un processus d''int‚gration de commentaires, d''instructions ou d''autres informations dans un document, sans que le document en lui-mˆme ne soit modifi‚. En principe, les annotations sont r‚alis‚es par des programmes sp‚ciaux','');
INSERT INTO Lexique VALUES ( 511,'Annuaire','INTERNET','Service de R‚seau, en tous points comparable … l''annuaire t‚l‚phonique que tout le monde connaŒt, mais o— les abonn‚s sont parfois des gens, parfois des machines, parfois mˆme des r‚seaux. L''annuaire peut ˆtre centralis‚ ou distribu‚, dans ce cas la gestion des morceaux de l''annuaire est effectu‚e localement. Voir Whois, X500. En particulier, un annuaire sur l''Internet recense les sites et les classe par thŠmes','');
INSERT INTO Lexique VALUES ( 512,'Annulation','OS2','Plaquette permettant de sortir de la fenˆtre active et de revenir … la fenˆtre pr‚c‚dente sans valider les modifications effectu‚es','');
INSERT INTO Lexique VALUES ( 513,'Annuler','','ş Effacer des donn‚es, les mettre … z‚ro. ş Interrompre une action parce que l''on se rend compte qu''on est en train de faire une bˆtise','');
INSERT INTO Lexique VALUES ( 514,'Ano','INTERNET','Abr‚viation d''Anonymous','FTP Ano');
INSERT INTO Lexique VALUES ( 515,'Anonyme','INTERNET','','Anonymous');
INSERT INTO Lexique VALUES ( 516,'Anonyme','INTERNET','L''une des qualit‚s et l''un des d‚fauts des r‚seaux... Surtout que la plupart du temps, vous n''y ˆtes absolument pas du tout anonyme (pour transmettre un message, il faut qu''on ait votre adresse)','Remailer Anonyme');
INSERT INTO Lexique VALUES ( 517,'Anonyme','Coder','Une Variable est anonyme quand elle est cr‚‚e dynamiquement, lors de l''ex‚cution d''un programme (comme on ne peut pas pr‚voir si on en aura besoin, on ne peut pas la d‚clarer et lui donner un nom lors de la r‚daction du programme)','');
INSERT INTO Lexique VALUES ( 518,'Anonymous','INTERNET','C''est en fait le nom d''utilisateur de quelqu''un se connectant sur un serveur FTP alors qu''il n''a pas de compte personnel sur la machine, par l''interm‚diaire de l''Internet. En pratique, on parle de ®ftp anonymous¯. Et comme mot de passe on doit utiliser son adresse de courriel, selon la Netiquette (pour permettre aux administrateurs de site de faire des statistiques sur les visiteurs qui viennent. Ils peuvent par la suite mettre en place des Miroirs judicieusement dispos‚s … la surface de la planŠte.)','');
INSERT INTO Lexique VALUES ( 519,'Anonymous FTP','INTERNET','Il existe une multitude de serveurs sur le Net qui vous autorisent … vous connecter et … t‚l‚charger toute sorte de fichiers … partir de leur machine. Ils sont plus connus sous le nom de sites FTP anonymes. Indiquer anonymous pour le login et votre adresse e-mail en guise de password (mot de passe) suffit pour y acc‚der','');
INSERT INTO Lexique VALUES ( 520,'ANP','','Abr‚viation d''Assistant Num‚rique Personnel. Synonyme de PDA. Usage trŠs rare (Cela veut aussi dire chez les militaires: ®Appareil Normal de Protection¯, i.e. ®Masque … Gaz¯)','');
INSERT INTO Lexique VALUES ( 521,'ANSI','','Abr‚viation de "American National Standards Institute". Organisme am‚ricaine de normalisation. Il est le principal comit‚ de standardisation aux tats-Unis. ş Il peut ‚galement s''agir du terminal ANSI','');
INSERT INTO Lexique VALUES ( 522,'ANSI C','','Un terme pour d‚signer le standard ANSI du langage de programmation C. Ce standard a ‚t‚ publi‚ en F‚vrier 1990, sous le nom de Standard X3.159-1989','');
INSERT INTO Lexique VALUES ( 523,'Ant‚m‚moire','','M‚moire tampon contenant des instructions et des donn‚es fr‚quemment utilis‚es afin de r‚duire les temps d''accŠs au disque','');
INSERT INTO Lexique VALUES ( 524,'Anti-aliasing','CAO','Technique de filtrage des contours utilis‚e pour r‚duire les effets visuels d''escalier (lignes courbes ou diagonales) ou ind‚sirables (moir‚, d‚bordement des couleurs ou textures) lors de l''affichage d''images de synthŠse','');
INSERT INTO Lexique VALUES ( 525,'Antialiaser','','Francisation d''un terme Brit. Ex‚cuter un Anti-Aliasing sur une image ou une partie de cette image. Il vaut mieux utiliser le terme ®anticr‚neler¯, mˆme s''il n''existe pas','');
INSERT INTO Lexique VALUES ( 526,'Anticr‚nelage','','Version fran‡aise de Anti-Aliasing. On rencontre bien plus souvent la version anglaise. Technique d''‚limination du cr‚nelage consistant … lisser les lignes et les contours d''une image','');
INSERT INTO Lexique VALUES ( 527,'ANTIOPE','','Abr‚viation d''Acquisition Num‚rique et T‚l‚visualisation d''Images Organis‚es en Pages d''criture. Service Vid‚otex de France T‚l‚com et TDF permettant de consulter diverses informations sur un t‚l‚viseur muni d''un d‚codeur. Cela date de 1976','');
INSERT INTO Lexique VALUES ( 528,'Antislash','','A ne pas confondre avec l''®antischlass¯ ‚tant un remŠde de grand-mŠre pour ‚viter les gueules de bois. Nom usuel du caractŠre ®\¯ (92 en ASCII). Utilis‚ comme s‚parateur dans le Chemin d''AccŠs, sous DOS, ce qui pose pas mal de problŠme avec Unix dont le s‚parateur courant est le slash: ®/¯ (exactement l''inverse). D''autant plus que, toujours sous Unix, on utilise l''antislash pour masquer d''autres caractŠres sp‚ciaux afin de les utiliser ®normalement¯','');
INSERT INTO Lexique VALUES ( 529,'Anti-Virus','','Programme de d‚tection de virus. Il permet g‚n‚ralement d''‚galement de les d‚truires','');
INSERT INTO Lexique VALUES ( 530,'AOEC','MAC','Abr‚viation de Apple Open Colaboriation Environment','');
INSERT INTO Lexique VALUES ( 531,'AOHell','','Surnom du service en ligne devenu fournisseur d''accŠs … Internet AOL','');
INSERT INTO Lexique VALUES ( 532,'AOL','NTW','Abr‚viation du r‚seau ®American OnLine¯ cr‚‚ en 1985. En 1996, il comptait 5 millions d''abonn‚s dans le monde et 10 000 en France','');
INSERT INTO Lexique VALUES ( 533,'AOPC','','Abr‚viation d''Annual Obfuscated Perl Contest. Concours de programmation en Perl dans lequel le but du jeu est de produire le programme le plus horrible possible. TrŠs bon exemple de ce qu''il ne faut pas faire si vous ˆtes pay‚ pour programmer. TrŠs bon exemple de ce qu''il faut faire si vous d‚sirez briller dans la soci‚t‚ des Nerds','');
INSERT INTO Lexique VALUES ( 534,'Aoutelouquerie','INTERNET','Quand vous utilisez le Logiciel Outlook de Microsoft, il est fort probable que vous vous ridiculisiez en postant n''importe quoi dans les News... (par exemple de l''UTF-7 uuencod‚ dans du MIME)','');
INSERT INTO Lexique VALUES ( 535,'Apache','INTERNET','Serveur HTTP non seulement libre, mais aussi parmi les meilleurs et les plus r‚pandus','');
INSERT INTO Lexique VALUES ( 536,'Apartment Multi-Threading','','ModŠle Multithread utilis‚ par COM de Microsoft','');
INSERT INTO Lexique VALUES ( 537,'APDU','','Abr‚viation d''Application Protocol Data Unit','');
INSERT INTO Lexique VALUES ( 538,'Aper‡u','PRN','Un Aper‡u, ou un ®Aper‡u avant impression¯, permet de visualiser sur cran comment les informations vont ˆtre effectivement imprim‚es','WYSIWYG');
INSERT INTO Lexique VALUES ( 539,'API','Coder','Abr‚viation "Application Program[ming] Interface" (Interface d''Application Programmable). Proc‚d‚ utilis‚ en mode prot‚g‚ d‚finissant les pointeurs d''appelles par lesquel un programme peut faire une interaction avec les services requis du systŠme d''exploitation ou de l''environnement sous lequel il fonctionne. Cette m‚thode est utilis‚ parceque les entr‚es/sorties des pointeurs d''appelles sont un programme utilis‚ par l''API pour contr“ler des appelles identiques dans l''‚ventualit‚ o— l''organisation interne de l''API du programme aurait ‚t‚ modifi‚. JAVA Toutes les classes et les interfaces impl‚mentant une fonctionnalit‚ pr‚cise, par exemple l''API JDBC','');
INSERT INTO Lexique VALUES ( 540,'API','','Abr‚viation d''Automate Programmable Industriel. On les confond trŠs souvent avec les Robots','');
INSERT INTO Lexique VALUES ( 541,'API','','Interface pour langages de programmation, mat‚rialis‚es par des primitives, permettant … une application d''acc‚der … des programmes systŠme pour, par exemple, communiquer ou extraire des donn‚es. Ainsi un jeu d‚velopp‚ avec l''API de Direct 3D fonctionnera avec les cartes 3D supportant cette interface, sans adaptation. Anglais: Application Programming Interface','');
INSERT INTO Lexique VALUES ( 542,'APL','','Abreviation "A Programming Language". Langage interactif math‚matique manipulant des matrices','');
INSERT INTO Lexique VALUES ( 543,'Aplat','CAO','Surface imprim‚e en noir ou en une seule couleur et pr‚sentant une valeur maximale (100%)','');
INSERT INTO Lexique VALUES ( 544,'APM','IBM HDW','Abr‚viation d''Advanced Power Management. Gestionnaire d''am‚lioration de courant. Cette sp‚cification permet … des ordinateurs personnel d''utiliser moins de courant lorsque l''ordinateur n''effectue plus d''op‚ration v‚ritable aprŠs un certain laps de temps','');
INSERT INTO Lexique VALUES ( 545,'APP','','Abr‚viation d''Agence pour la Protection des Programmes','');
INSERT INTO Lexique VALUES ( 546,'App','','Abr‚viation usuelle de Application','');
INSERT INTO Lexique VALUES ( 547,'Appareils d''entr‚es de coordonn‚es','IBM HDW','Souris: Bus vs SERIEL, Microsoft, Mouse System; Tablette: Summa,...; Manette de jeu: Koala Pad, light Pen, Track ball, Touch Screen','');
INSERT INTO Lexique VALUES ( 548,'Appariement de Forme','Coder','Synonyme de Filtrage, ou encore de Pattern Matching en anglais','');
INSERT INTO Lexique VALUES ( 549,'APPC','','Abr‚viation d''Advanced Program to Program Communication. Protocole cr‚‚ par IBM pour permettre … des programmes de communiquer directement, sans l''interm‚diaire de couches plus basses du systŠme','SNA');
INSERT INTO Lexique VALUES ( 550,'Appel','Coder','Expression indiquant un branchement de l''ex‚cution du programme vers un sous-programme. Le mots anglais CALL est ‚galement utilis‚ pour d‚finir ce processus','');
INSERT INTO Lexique VALUES ( 551,'Appelation','GAME','Mot utilis‚ dans Advanced Dungeons & Dragons. C''est une incantation magique pouvant alt‚rer la r‚alit‚ de la nature. Les utilisateurs de magie, Clerics, les paladins de haut-niveau et les rangers peuvent jeter un sort aprŠs avoir m‚moris‚ le thŠme. Si l''appellation est jeter, il est partie de l''utilisateur et il est n‚cessaire de la rem‚moriser','');
INSERT INTO Lexique VALUES ( 552,'Appels (de) fonction','Coder','Un appel de fonction active une fonction sp‚cifi‚e par un identificateur de fonction, un descripteur de m‚thode, un descripteur de m‚thode qualifi‚e, ou une r‚f‚rence de variable de type sous-ensemble. si la d‚claration de la fonction comporte une liste de paramŠtres formels, l''appel de la fonction doit comporter une liste de paramŠtres effectifs. Chaque paramŠtre effectif vient prendre la place d''un paramŠtre formel','');
INSERT INTO Lexique VALUES ( 553,'Appel SystŠme','','Ex‚cution d''une routine du systŠme d''exploitation, routine aussi appel‚e instruction ‚tendue, car elles se trouvent souvent au niveau des instructions assembleur','');
INSERT INTO Lexique VALUES ( 554,'Append','','Ajouter des donn‚es … un Fichier d‚j… existant, en g‚n‚ral … la fin de ce fichier','');
INSERT INTO Lexique VALUES ( 555,'Apple','','Compagnie d''ordinateur. Fondateur des Apples I, Apples ][ et Apples Macintosh','');
INSERT INTO Lexique VALUES ( 556,'Apple Event','MAC','D‚signe un haut niveau d''‚v‚nement utilis‚ pour la communication et le partage des donn‚es parmi les applications','');
INSERT INTO Lexique VALUES ( 557,'Apple Event Handler','MAC','Fonction d‚finie par l''application extractant partiellement les donn‚es d''un Apple Event, accomplissant l''action requis par l''Apple Event, et retourne le r‚sultat','');
INSERT INTO Lexique VALUES ( 558,'Apple II','HDW','L''une des premiŠres machines produite par la marque … la pomme, sortie en 1983, con‡u par Jobs Steve et Wozniac Stephen, et trŠs utilis‚ au milieu des ann‚es 1980 dans l''‚ducation. L''Apple I a exist‚, mais il n''a ‚t‚ construit qu''… 200 exemplaires environ','Apple, Micro');
INSERT INTO Lexique VALUES ( 559,'Apple IIe','Apple','Un ordinateur dans la famille des Apple II','');
INSERT INTO Lexique VALUES ( 560,'Apple IIe Extended 80-column Text Card','Apple','Une carte de p‚riph‚rique qu''on insŠre dans la slot auxiliaire de l''Apple IIe et convertissant l''affichage de 40 … 80 colonnes. Il augmente ‚galement la capacit‚ de m‚moire de l''Apple IIe de 64 Ko','');
INSERT INTO Lexique VALUES ( 561,'Apple III','HDW','Grand frŠre de l''Apple II sorti … peu prŠs en mˆme temps que lui et tourn‚ vers le march‚ professionnel. 128 Ko de RAM, disquettes de 140 Ko, Processeur 6502, Disque Dur de 5 Mo en option','');
INSERT INTO Lexique VALUES ( 562,'Applemania','APPLE','Affection touchant les adeptes d''Apple','Applemaniaque, Windowsmania');
INSERT INTO Lexique VALUES ( 563,'Applemaniaque','APPLE','Utilisateur d''une machine Apple. Il n''y connaŒt rien, ne sait pas comment ‡a marche, et trouve ‡a tellement g‚nial que le reste du monde informatique est m‚prisable','Dossien, Unixien');
INSERT INTO Lexique VALUES ( 564,'AppleScript','APPLE','Langage d''automatisation des tƒches pour l''interface graphique des Macs. Voir SystŠme 7.5. Exactement ce qui manque toujours … Windows','');
INSERT INTO Lexique VALUES ( 565,'AppleShare','APPLE','Solution d''Apple pour les r‚seaux locaux, utilisant le Protocole AppleTalk','');
INSERT INTO Lexique VALUES ( 566,'AppleSoft','APPLE','C''est une version ‚tendu du langage de programmation Basic utilis‚ par les micro-ordinateurs Apple II et ‚tant capable de proc‚d‚ avec des nombres … virgule flottante. C''est un interpr‚teur pour ex‚cuter les programmes AppleSoft ‚tant construit dans le "firmware" de l''Apple IIe et Apple II Plus','');
INSERT INTO Lexique VALUES ( 567,'Applet','INTERNET','Abr‚viation d''APPLication widgET. Applette et Appliquette sont les versions fran‡aises du terme originel anglais Applet. Petit Programme, souvent accompagn‚ de donn‚es bien plus volumineuses que lui, et con‡u pour ˆtre t‚l‚charg‚ via un r‚seau … chaque fois qu''on veut l''utiliser, en particulier par un Navigateur, qui se chargera de l''ex‚cuter. Comparer … Appli, Application. JAVA L''oppos‚ de l''applet Java est l''application Java, directement charg‚e depuis le disque dur. C''est ‚galement le cas pour d''autres programmes ‚crits en d''autres langages de programmation','');
INSERT INTO Lexique VALUES ( 568,'AppleTalk','NTW','Protocole de communication employ‚ par Apple','');
INSERT INTO Lexique VALUES ( 569,'Applet Java','IBM NTW Windows','Un applet Java est con‡u pour ˆtre int‚gr‚ a une page HTML. Comme tout programme Java, il est compil‚ non pas en langage machine, mais en "byte-code", un code ex‚cutable par les machines virtuel Java. Celle-ci est comparable … un run-time et tourne aussi bien sous Windows que sur MacOS et Unix. L''exploitation de l''applet se limite pour l''instant … la navigation sur Internet alors qu''on peut d‚velopper n''importe quel programme en Java-mˆme des ActiveX comme l''autorise Jakarta','');
INSERT INTO Lexique VALUES ( 570,'Applette','INTERNET','Francisation al‚atoire de Applet. On dit aussi Appliquette','');
INSERT INTO Lexique VALUES ( 571,'Appli','','Abr‚viation courante d''Application. Ce terme est souvent utilis‚ assez affectueusement. Il n''est pas facile de tester ses petites applis sous Windows','');
INSERT INTO Lexique VALUES ( 572,'Applicatif','','Relatif au Logiciel, aux Applications. Exemple: Maintenance applicative. ş Un logiciel, une Application','');
INSERT INTO Lexique VALUES ( 573,'Application','','Programme ex‚cut‚ sous la tutel de l''environnement OS/2. ş Programme quelconque ex‚cut‚ sous le systŠme Unix. ş Programme ex‚cut‚ sous la tutel de l''environnement Windows','');
INSERT INTO Lexique VALUES ( 574,'Application Client/Serveur','','Application fonctionnant … partir d''une logique de pr‚sentation et d''application sur le poste de l''utilisateur (frond end), et communiquant via le r‚seau avec un back end, … charge pour ce dernier de mettre … disposition les composants centraux de logique et les donn‚es','');
INSERT INTO Lexique VALUES ( 576,'Application font','','Mot d''origine anglaise, d‚signant la police par d‚faut utilis‚ par l''application. La police d''application est d‚finie par chaque scripte du systŠme','');
INSERT INTO Lexique VALUES ( 577,'Application layer','NTW','La septiŠme couche du modŠle OSI','');
INSERT INTO Lexique VALUES ( 578,'Application multiliaison','','Une application client/serveur miltiliaison est une application de bases de donn‚es partitionn‚e en unit‚ logiques dont les diff‚rentes unit‚s fonctionnent g‚n‚ralement en coordination les unes avec les autres sur des machines s‚par‚es, partageant des donn‚es et communiquent par un r‚seau local voire mˆme par Internet. Dans son modŠle le plus simple, quelquefois appel‚ "modŠle … triple liaison", une application est partitionn‚e en 3: ®ş une application client fournissant une interface sur la machine de l''utilisateur; ş un serveur d''applications proposant des services de manipulation '+
                                                               'de donn‚es communs … un nombre quelconque d''applications client grƒce … des ensembles de donn‚es distribu‚s, et r‚sidant … un emplacement r‚seau central accessible … ses clients; un serveur de base de donn‚es distant supportant le systŠme de gestion de base de donn‚es relationnelle (SGBDR).¯ Dans ce modŠle … triple liaison, le serveur d''applications gŠre les ‚changes de donn‚es entre les clients et le serveur de base de donn‚es distant; il est donc parfois d‚nomm‚ "courtier ou broker de donn‚es"','');
INSERT INTO Lexique VALUES ( 579,'Application program','','Programme ayant une autre fonction que celle d''outil. S''oppose g‚n‚ralement au systŠme d''exploitation. Propose g‚n‚ralement une tƒche, un traitement de texte, une base de donn‚e, graphiques, t‚l‚communication,...','');
INSERT INTO Lexique VALUES ( 580,'Application type','','Mot d''origine anglaise d‚finissant le type de donn‚e stock‚ ‚tant utilis‚ par les applications','');
INSERT INTO Lexique VALUES ( 581,'Appliquette','INTERNET','Version fran‡aise d''Applet, pr‚f‚rable selon certains … Applette','');
INSERT INTO Lexique VALUES ( 582,'APPN','','Abr‚viation d''Advanced Peer to Peer Networking','SNA');
INSERT INTO Lexique VALUES ( 584,'Approximation','CAO','Technique math‚matique utilis‚e dans le cadre de la d‚finition de courbes ou de surfaces. Celles-ci ne passant pas par les points de contr“le utilis‚s pour leur d‚finition','');
INSERT INTO Lexique VALUES ( 585,'APQ','','Abr‚viation de l''Association des Programmeurs du Qu‚bec','');
INSERT INTO Lexique VALUES ( 586,'APS','','Abr‚viation d''Advanced Photo System. Pellicule photographique comprenant une piste magn‚tique permettant d''enregistrer diverses informations au sujet de chaque photo','');
INSERT INTO Lexique VALUES ( 587,'APSI','IBM','Abr‚viation de ®Advanced Programming SCSI Interface¯. C''est une interface de programmation permettant aux gestionnaires et utilitaires d''utiliser le mˆme adapteur SCSI. Ceci permet … des p‚riph‚riques SCSI vari‚s (disque, unit‚ de bande, CD-ROM, WORM,...) d''utiliser le mˆme adapteur, limitant ainsi le co–t du systŠme et le nombre d''emplacement de carte occup‚s. D‚velopp‚ par Adaptec, la norme APSI a ‚t‚ adopt‚e par de nombreuses soci‚t‚s de logiciel et mat‚riel','');
INSERT INTO Lexique VALUES ( 588,'APSI pour Windows','IBM','C''est une nouvelle interface d‚velopp‚e par Adaptec. Jusqu''… pr‚sent les application Windows d‚sirant communiquer avec la norme APSI devaient lui affecter tous ses tampons en m‚moire DOS. Cela imposait ‚galement au processeur de passer en mode prot‚g‚ en mode V86/r‚el. Pour ‚l‚miner ces limitations, Adaptec a d‚fini l''interface "APSI pour Windows". Cette interface permet aux applications, telles que Central Point Backup Version 8, d''affecter ses tampons de donn‚es l… o— elle peut et d''appeler APSI directement en mode prot‚g‚','');
INSERT INTO Lexique VALUES ( 589,'APT','Coder','Abr‚viation de Automatically Programmed Tools. Langage de programmation de machines-outils … commande num‚rique','');
INSERT INTO Lexique VALUES ( 590,'Aptiva','IBM HDW','Ordinateur IBM Aptiva successeur des PS/1','');
INSERT INTO Lexique VALUES ( 591,'AQ','','Abr‚viation d''Assurance Qualit‚ (ou Quality Assurance - QA - en anglais)','');
INSERT INTO Lexique VALUES ( 592,'ARA','APPLE NTW','Abr‚viation d''Appletalk Remote Access. AccŠs … distance … l''aide d''AppleTalk pour ordinateur Apple','');
INSERT INTO Lexique VALUES ( 593,'Arabic Calendar','MAC','D‚finie un calendrier lunaire utilis‚ par beaucoup de pays Arabes. Deux calendrier Arabes sont support‚ par le scripte du systŠme Arabe: Le calendrier astronomique lunaire, bas‚ sur les phases de la lune est actuellement observ‚ … chaque endroit … travers le monde; et le calendrier lunaire civil, une version historique du calendrier astronomique. Dans ces versions, les positions du temps de chaque mois varie d''une ann‚e … l''autre','');
INSERT INTO Lexique VALUES ( 594,'Arabic Numerals','MAC','D‚finie dans le gestionnaire systŠme des scripts, les nombres d''origine provennant du systŠme Arabe et n''utilisant pas les nombres romain. Comparable au Western numerals','');
INSERT INTO Lexique VALUES ( 595,'Araign‚e astral','GAME','Nom utilis‚ dans "Advanced Dungeons & Dragons". Ce sont des araign‚es g‚antes v‚n‚neuse poss‚dant l''habilet‚ de devenir intengible. Elles sont tengibles lorsqu''elles attaquent, et intengibles aprŠs','');
INSERT INTO Lexique VALUES ( 596,'Araign‚e g‚antes','GAME','Nom utilis‚ dans "Advanced Dungeons & Dragons". Sont les cousins g‚ant des petits pr‚dateur. Ils attaquent avec des morsures v‚n‚neuse','');
INSERT INTO Lexique VALUES ( 597,'ARAP','APPLE','Abr‚viation d''Appletalk Remote Access Protocol','ARA');
INSERT INTO Lexique VALUES ( 598,'Arborescence','JAVA','Il s''agit d''une structure hi‚archique d''organisation des donn‚es et des documents, par exemple l''arborescence du systŠme de fichiers ou la hi‚archie des objets','Arbre');
INSERT INTO Lexique VALUES ( 599,'Arborescence de r‚pertoire','','Repr‚sentation de tous les r‚pertoires et sous-r‚pertoires de l''unit‚ en cours','');
INSERT INTO Lexique VALUES ( 600,'Arbre','','Repr‚sentation d''un ensemble d''objets sous forme hi‚rarchique. Un arbre informatique a une Racine, des branches repr‚sentant la hi‚rarchie, et des feuilles ‚tant les objets. Voir aussi Arbre B, et, dans un sens tout diff‚rent, Arbre de No‰l. Arborescence est surtout utilis‚ pour qualifier l''organisation des Fichiers sur un Disque','');
INSERT INTO Lexique VALUES ( 601,'Arbre B','','','B-Tree');
INSERT INTO Lexique VALUES ( 602,'Arbre (de) construction','CAO','Synonyme de CSG','');
INSERT INTO Lexique VALUES ( 603,'Arbre (de) d‚cision','JAVA','quivalent de l''expression anglaise ®purse tree¯. Un arbre de d‚cision contient la repr‚sentation graphique de d‚finition ou de liaison entre des mots cl‚s, ou des ‚l‚ments lexicaux dans un flot d''entr‚e de donn‚es','');
INSERT INTO Lexique VALUES ( 604,'Arbre (de) No‰l','INTERNET','Caract‚rise les pages Web criardes et toutes remplies de machins blinkant (du nom du Tag) et clignotent dans tous les sens','');
INSERT INTO Lexique VALUES ( 605,'ARC','','Fichier contenant une Archive compact‚e. Courant sous DOS, en train de disparaŒtre. Par exemple le Norton Commander 3.0 utilisait ce genre de fichier compact‚ pour son installation','');
INSERT INTO Lexique VALUES ( 606,'ARC','','Abr‚viation d''Advanced RISC Computing','RISC');
INSERT INTO Lexique VALUES ( 607,'Arcade','GAME','l‚ment d''architecture, sous lequel on peut trouver des ® Jeux d''Arcade ¯... ş Caract‚rise un type de jeux vid‚os que l''on trouve dans les bars et les salles de jeux, dans lesquels l''action est primordiale, et ‚tant trŠs souvent adapt‚s aux micros-ordinateurs','Arkano‹d');
INSERT INTO Lexique VALUES ( 608,'archie','INTERNET','Utilitaire de recherche automatique de fichiers d''aprŠs leurs noms, … l''aide de bases de donn‚es recensant les fichiers disponibles','Gopher');
INSERT INTO Lexique VALUES ( 609,'Archimedes','HDW','Micro-ordinateur con‡u et fabriqu‚ par Acorn et utilis‚ essentiellement par des D‚momakers. Il a eu un succŠs tout … fait confidentiel … travers le monde...','');
INSERT INTO Lexique VALUES ( 610,'Architecture','','Structure de la partie mat‚rielle d''un ordinateur','SIGGRAPH');
INSERT INTO Lexique VALUES ( 611,'Archivage','','Le fait de mettre des fichiers dans une Archive','');
INSERT INTO Lexique VALUES ( 612,'Archive','','ş Indicateur utilis‚ par OS/2 pour d‚terminer quels sont les fichiers ou les r‚pertoires cr‚‚s ou modifi‚s derniŠrement. Les fichiers associ‚s … cet indicateur sont pris en compte lorsqu''ils sont sauvegard‚s ou restaur‚s sur disque. ş Copie d''un fichier ou d''une base de donn‚es sauvegard‚e en vue d''une consultation ult‚rieure ou d''une r‚cup‚ration des donn‚es d''origine au cas o— celles-ci seraient alt‚r‚es ou perdures','');
INSERT INTO Lexique VALUES ( 613,'Archive','','Fichier contenant plusieurs autres fichiers sous forme compact‚e ou non, facilitant ainsi l''administration d''un systŠme, et d‚sengorgeant les r‚seaux, car il ne reste plus qu''un seul fichier … manipuler. Lorsqu''on dispose d''une archive d''un logiciel, on est … peu prŠs s–r d''avoir tous les fichiers n‚cessaires … son bon fonctionnement','ARJ, Compacter, SFX, tar, Zip, ZOO');
INSERT INTO Lexique VALUES ( 614,'Archive','NTW','Site particulier, sur un R‚seau, utilis‚ essentiellement pour stocker des donn‚es, comme dans des archives classiques. Comparer … Miroir','');
INSERT INTO Lexique VALUES ( 615,'Archiver','','Placer des fichiers dans une Archive, en g‚n‚ral en leur faisant subir une Compression','');
INSERT INTO Lexique VALUES ( 616,'Archiveur','','Programme sp‚cialis‚, Utilitaire, r‚alisant des Archives, avec ou sans Compression','');
INSERT INTO Lexique VALUES ( 617,'Arcnet','NTW','R‚seau local d‚velopp‚ par DataPoint et repris et adapt‚ par d''autre fabricants','');
INSERT INTO Lexique VALUES ( 618,'Ardoise lectronique','HDW','Ordinateur Portable tout petit et extra-plat, sans Clavier, ‚quip‚ d''un cran Tactile. Synonyme de Notepad','');
INSERT INTO Lexique VALUES ( 619,'ArŠte','CAO','Ligne d''intersection de 2 plans ou de 2 surfaces se coupant. l‚ment de d‚finition des volumes (sommets, arˆtes, facettes) en mod‚lisation 3D','');
INSERT INTO Lexique VALUES ( 620,'Arg','','Abr‚viation usuelle de Argument, tellement utilis‚e (comme Var), que c''est l''‚quivalent informatique de ®cin‚ma¯ pour ®cin‚matographe¯, ou ®auto¯ pour ®automobile¯','');
INSERT INTO Lexique VALUES ( 621,'Argentique','','Caract‚rise la photographie traditionnelle, dans laquelle les intensit‚s lumineuses sont fix‚es par des sels d''argent. videmment, c''est un ph‚nomŠne Analogique, oppos‚ au Num‚rique','');
INSERT INTO Lexique VALUES ( 622,'Argument','','Synonyme de ParamŠtre. Souvent abr‚g‚ en Arg. On parle des arguments d''un Programme ou d''une Proc‚dure quand on passe les paramŠtres … la main, comme dans une Ligne de Commande ou dans du code source. Le Param‚trage est, lui, un peu plus sophistiqu‚','');
INSERT INTO Lexique VALUES ( 623,'Argument','][','Valeur dans lequel une fonction opŠre','');
INSERT INTO Lexique VALUES ( 624,'Argument','Unix','Mots tap‚ sur la ligne de commande suivant la commande elle-mˆme. Une commande peut avoir plus d''un argument. Les arguments peuvent ˆtre soit des drapeaux ou options indiquant … une commande comment travailler, soit des noms de fichiers indiquant … une commande sur quoi elle doit travailler','');
INSERT INTO Lexique VALUES ( 625,'Argument','TABLEUR','Variable utilis‚e pour apporter un suppl‚ment d''information dans les fonctions @ et les macrocommandes. Sous Quattro Pro, par exemple, dans la fonction @SOMME(A4..A10), les coordonn‚es du bloc sont l''argument permettant … Quattro d''identifier les valeurs … additionner','');
INSERT INTO Lexique VALUES ( 626,'Argument','JAVA','Un argument est un ‚l‚ment de remplacement repr‚sentant une valeur d''entr‚e d''une fonction, d''une m‚thode ou d''un constructeur','');
INSERT INTO Lexique VALUES ( 627,'Arena Header','DOS','Autre d‚signation des "Memory Control Blocks" (MCBs)','');
INSERT INTO Lexique VALUES ( 628,'ARIB','','Abr‚viation d''Association of Radio Industries and Businesses','');
INSERT INTO Lexique VALUES ( 629,'ARJ','','Format d''archive compact‚e; nom du programme permettant d''administrer les archives dans ce format. Passer un ensemble de fichiers … la moulinette de ce programme se dit ARJiser se pronon‡ant [A-R-gi-se]. Son principal int‚rˆt est de ne n‚cessiter qu''un seul et mˆme programme pour compacter aussi bien que pour d‚compacter tout en archivant, et de disposer d''une montagne de Switchs pour faire tout ce qu''on veut. Principal concurrent du format ZIP','Archive');
INSERT INTO Lexique VALUES ( 630,'ARJiser','','Compresser des donn‚es … l''aide de l''utilitaire ARJ','');
INSERT INTO Lexique VALUES ( 631,'Arkano‹d','GAME','C''est un casse-brique','Breakout');
INSERT INTO Lexique VALUES ( 632,'Armagedon','IBM','Virus informatique','');
INSERT INTO Lexique VALUES ( 633,'Arm‚','','Se dit des Virus ayant ‚t‚ dot‚s de structures empˆchant leur D‚sassemblage, et donc leur analyse. En fait, le d‚sassemblage devient tout simplement extraordinairement compliqu‚...','R‚trotechnique');
INSERT INTO Lexique VALUES ( 634,'ARMM','NTW','Abr‚viation d''Automated Retroactive Minimal Moderation. Robot con‡u pour supprimer les articles post‚s sur Usenet depuis des sites anonymes. Tout se serait bien pass‚ si le robot n''avait pas commenc‚ … traiter ses propres messages de contr“le... Chaque nouveau message en engendrant d''autres r‚cursivement... Bel exemple de la loi de Murphy','');
INSERT INTO Lexique VALUES ( 635,'Armor Class','','Mot d''origine anglaise utilis‚ dans Advanced Dungeons & Dragons synonyme d''Armor Class','');
INSERT INTO Lexique VALUES ( 636,'Arobas','','Symbolise le caractŠre @ surnomm‚ A commercial','');
INSERT INTO Lexique VALUES ( 637,'ARP','','Abr‚viation d''Address Resolution Protocol. Ce protocole permet de traduire des adresses IP 32 bits en adresses Ethernet de 48 bits. D‚fini par la RFC 826','R‚solution d''Adresse');
INSERT INTO Lexique VALUES ( 638,'ARPA','','Abr‚viation d''Advanced Research Projects Agency. Organisme am‚ricain remplac‚ par le DARPA, ayant soutenu ‚norm‚ment de projets informatiques historiques','Arpanet, DoD');
INSERT INTO Lexique VALUES ( 639,'ARPA-Net','NTW','Abr‚viation d''Advanced Research Projects Agency NETwork. R‚seau des ann‚es 1960 pŠre de l''Internet. La raison d''ˆtre de ce r‚seau ‚tait de construire quelque chose r‚sistant au attaque nucl‚aire sovi‚tique','');
INSERT INTO Lexique VALUES ( 640,'ARQ','','Abr‚viation d''Automatic Repeat reQuest. Demande de r‚p‚tition automatique. ApparaŒt lors d''une communication par Modem, quand celui-ci se rend compte de lui-mˆme que certaines donn‚es ont ‚t‚ alt‚r‚es pendant le transfert','');
INSERT INTO Lexique VALUES ( 641,'Array','Coder','C''est une collection de variables se r‚f‚ren‡ant par le mˆme nom et se distinguant par un num‚ro de sous-scriptes (subscripts)','');
INSERT INTO Lexique VALUES ( 642,'Array','HDW IBM','Zone des barrettes de m‚moire dans laquelle les bits d''informations (0 et 1) sont enregistr‚s. Un array est organis‚ en colonnes (column) et en lignes (rows), l''intersection d''une colonne et d''une ligne formant une cellule (cell)','');
INSERT INTO Lexique VALUES ( 643,'Arrˆter','OS2','Mettre fin aux op‚rations en cours sur le systŠme … l''aide de l''option Arrˆt pour ‚viter de perdre des donn‚es ou les informations de configuration lorsque le systŠme est mis hors tension','');
INSERT INTO Lexique VALUES ( 644,'Arrˆt/Fermeture','OS2','ş Option du menu systŠme de certains programmes et de la Liste de fenˆtres. galement option en cascade de l''option Fenˆtre d''un menu contextuel. Cette option permet de mettre fin aux programmes et objets mis en ‚vidence et de fermer les fenˆtres leur ‚tant associ‚es. Cette option constitue l''action par d‚faut lorsque vous s‚lectez l''ic“ne de barre de titre','');
INSERT INTO Lexique VALUES ( 645,'ArriŠre-plan','','En multiprogrammation, environnement dans lequel s''ex‚cutent les programmes de basse priorit‚ lorsque les ressources systŠme ne sont pas utilis‚es par des programmes de priorit‚ ‚lev‚e. Une session en arriŠre-plan est interrompue dŠs qu''une intervention de l''utilisateur est n‚cessaire. Le traitement des autres programmes se poursuit dans les sessions au premier plan','');
INSERT INTO Lexique VALUES ( 646,'ArriŠre-plan','','SystŠme non disponible directement, pour des raisons de S‚curit‚','Serveur de Base de Donn‚es');
INSERT INTO Lexique VALUES ( 647,'ARS','','Abr‚viation d''Automatic Route Selection','');
INSERT INTO Lexique VALUES ( 648,'ART','','Nom de format de fichier utilis‚ divers endroit contenant une image (plus ou moins) artistique','');
INSERT INTO Lexique VALUES ( 649,'ART','','Abr‚viation d''Autorit‚ de R‚gulation des T‚l‚coms','');
INSERT INTO Lexique VALUES ( 650,'ART','COM','Abr‚viation d''Automatic Receiver Transmitter','');
INSERT INTO Lexique VALUES ( 651,'Art ASCII','','Dessins compos‚s uniquement avec des caractŠres ASCII juxtapos‚s. Il existe ‚galement un forum de discussion sur Usenet pour discuter de cette forme d''art (et s''‚changer des oeuvres par la mˆme occasion)','');
INSERT INTO Lexique VALUES ( 652,'Article','NTW','Message cousin du Courrier lectronique, post‚ sur Usenet, dans un Newsgroup, c''est-…-dire publiquement. Tout comme un CE, un article est compos‚ d''un En-Tˆte (Header) n‚cessaire … sa manipulation par les logiciels de gestion des news, et d''un corps (Body) qui contiendra votre prose. Synonyme de News','');
INSERT INTO Lexique VALUES ( 653,'Artificial Intelligence','','','Intelligence Artificielle');
INSERT INTO Lexique VALUES ( 654,'AS/400','HDW','Ordinateur bas‚ sur le systŠme d''exploitation OS/400, le tout fabriqu‚ par IBM. C''est un Mini. L''AS/400 permet … IBM de r‚aliser ¬ de son chiffre d''affaires','');
INSERT INTO Lexique VALUES ( 655,'ASAP','','Abr‚viation d''As soon As possible. ®DŠs que possible¯','');
INSERT INTO Lexique VALUES ( 656,'Ascendant','','Une compatibilit‚ est dite ®Ascendante¯ lorsque les nouveaux systŠmes comprennent les anciens, mais pas l''inverse. Word 6 comprend les documents Word 2, mais Word 2 bloque sur les fichiers Word 6. Son contraire est descendant','Compatibilit‚');
INSERT INTO Lexique VALUES ( 657,'Ascenseur','Windows','Widget que l''on trouve sur le bord d''une Fenˆtre pour indiquer o— l''on se trouve dans le document, lorsque celui-ci est plus grand que la fenˆtre. Synonyme de Barre de D‚filement, Slider. Un petit cousin existe: Translateur, quand le d‚placement est horizontal. GlissiŠre est un synonyme de Ascenseur, la GlissiŠre est toutefois syst‚matiquement horizontale','');
INSERT INTO Lexique VALUES ( 658,'Ascent Line','','Un ligne horizontal imaginaire coincidant avec le sommet de la hauteur des caractŠres de la police. Voir ‚galement base line, descent line, x-height','');
INSERT INTO Lexique VALUES ( 659,'ASCII','','Le ®American Standard Code for Information Interchange¯ d‚finit les symboles (chiffres, lettres ou autres) affect‚s … chacune des valeurs de 0 … 127. Ce standard est officiellement appel‚ ANSI X3.4. L''IBM PC utilise un standard ‚tendu d‚finissant un jeu de caractŠres pour les codes de 128 … 255. Le terme fichier ASCII, est un fichier sans aucun formatage sp‚cial, et pouvant ˆtre visualis‚ par une simple commande "TYPE" du prompt DOS ou … l''aide de "cat", "more" et "vi" de Unix. HISTOIRE: L''ASCII a ‚t‚ cr‚‚ par BEMMER en 1965; il a ‚t‚ produit par le groupe de travail X3.4 de l''ANSI, certifi‚ en 1977 et adopt‚ par l''ISO en 1968 sous le num‚ro 646','');
INSERT INTO Lexique VALUES ( 660,'ASCIIb‚tique','','L''ordre ASCIIb‚tique est l''ordre obtenu en classant des ChaŒnes selon la table ASCII. On n''obtient pas vraiment un ordre alphab‚tique (les minuscules sont toutes aprŠs les majuscules, les accents viennent ensuite: [A-Z][a-z][…‚...]) mais c''est nettement plus facile','');
INSERT INTO Lexique VALUES ( 661,'ASCIIZ','','Une chaŒne de caractŠre ASCII avec une terminaison NUL. Par exemple, la chaŒne de caractŠre ASCIIZ "ABC" est constitu‚ de 4 octets 41h, 42h, 43h, et 00h. Sauf sp‚cifi‚, la longueur maximal n''a pas besoin d''ˆtre d‚finie','');
INSERT INTO Lexique VALUES ( 662,'ASE','NTW','Abr‚viation d''Application Service Element','');
INSERT INTO Lexique VALUES ( 663,'ASI','','Abr‚viation d''Actuator Sensor Interface. Bus destin‚ … la communication avec des capteurs ou des actionneurs, sur des robots, par exemple','');
INSERT INTO Lexique VALUES ( 664,'ASIC','HDW','Abr‚viation d''Application Specific Integrated Circuit. Circuit Int‚gr‚ sp‚cialis‚. En g‚n‚ral, ils sont produits en petites quantit‚s, car c''est du sur-mesures','FPGA');
INSERT INTO Lexique VALUES ( 665,'ASM','Coder','Abr‚viation usuelle de Assembleur. ş Fichier contenant du texte dont la signification est un Source en assembleur','');
INSERT INTO Lexique VALUES ( 666,'ASMP','','Abr‚viation d''ASymmetric MultiProcessing. Multitraitement asym‚trique. SystŠme multiprocesseurs dans lequel un processeur maŒtre commande … des esclaves partageant une mˆme m‚moire. Oppos‚ … MPP et … SMP. ASMP est plus facile … mettre en oeuvre que SMP, mais moins efficace','');
INSERT INTO Lexique VALUES ( 667,'ASN','Coder','Abr‚viation d''Abstract Syntax Notation. Langage formel permettant de d‚finir le contenu des PDU utilis‚s par SNMP','');
INSERT INTO Lexique VALUES ( 668,'ASP','','Abr‚viation d''®Association of Shareware Professionals¯. Associations des professionnels du shareware','');
INSERT INTO Lexique VALUES ( 669,'ASP','NTW','Abr‚viation d''Active Server Page. Cette technologie originaire de Microsoft permet de g‚n‚rer des pages HTML dynamiquement. On peut ainsi, par exemple, placer les textes des pages HTML dans une Base de Donn‚es, afin de ne plus avoir … faire de MAJ que dans la BD','');
INSERT INTO Lexique VALUES ( 670,'ASPI','','Abr‚viation d''Advanced SCSI Programming Interface. SystŠme d‚velopp‚ par Adaptec et soutenu par la majorit‚ des constructeurs, ce systŠme simplifie la gestion g‚n‚rique et les commandes de fonctionnement ind‚pendantes du mat‚riel connect‚','SCSI');
INSERT INTO Lexique VALUES ( 671,'Aspirateur','INTERNET','Un ®Aspirateur de Site¯ va aller r‚cup‚rer toutes les donn‚es contenues par un site Web et vous les sauvegarder sur votre disque dur. De la sorte, vous pouvez le consulter autant que vous le voulez sans ˆtre connect‚','');
INSERT INTO Lexique VALUES ( 672,'ASR','COM','Abr‚viation d''®Automatic Send Receive','');
INSERT INTO Lexique VALUES ( 673,'ASR','SON','Abr‚viation d''®Automatic Speech Recognition. Reconnaissance automatique de la parole','');
INSERT INTO Lexique VALUES ( 674,'Assemblage','Coder','Le fait d''Assembler, ou d''Assembler (i.e. assembler du code ou des machines)','');
INSERT INTO Lexique VALUES ( 675,'Assemblage','NTW','Dans un r‚seau … Commutation de paquets, le fait de r‚unir des caractŠres pour leur faire former un paquet ‚tant transmis. Contraires: D‚sassemblage, Segmentation','');
INSERT INTO Lexique VALUES ( 676,'Assembler','Coder','Mot d''origine anglaise, synonyme d''Assembleur. Action de compiler un programme … l''aide d''un Assembleur','');
INSERT INTO Lexique VALUES ( 677,'Assembler','HDW','Brancher ensemble les diff‚rents morceaux d''un ordinateur. Ce que fait un Assembleur','');
INSERT INTO Lexique VALUES ( 678,'Assembleur','Coder','Langage permettant la programmation de micro-processeur de la fa‡on la plus proche des op‚rations physiques qu''il sait r‚aliser. Les langages de haut niveau comme C/C++, Pascal, traduisent les instructions en assembleur. ş Nom d''une classe de langages de programmation de Bas Niveau, trŠs rapide, mais peu puissant. On le r‚serve aujourd''hui … l''‚criture de petits programmes et de Routines dont la rapidit‚ d''ex‚cution est cruciale. On devrait en th‚orie l''appeler langage d''assemblage. Exemple de bout de code (note: les Mn‚moniques sont ceux de l''assembleur 680x0):'+
                                                      'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿'+
                                                      '³ glok:                                                 ³'+
                                                      '³      move.w  #02, -(sp) ; on met un truc sur la pile  ³'+
                                                      '³      trap    #14        ; appel systŠme               ³'+
                                                      '³      addq.l  #6, sp     ; nettoyage de la pile        ³'+
                                                      '³      tst.w   d0         ; une erreur s''est produite ? ³'+
                                                      '³      bmi.s   glok       ; si oui, retour en glok      ³'+
                                                      'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ','Mn‚monique');
INSERT INTO Lexique VALUES ( 679,'Assembleur','HDW','Constructeur d''Ordinateurs, se contentant de brancher ensemble des morceaux tout faits. Synonyme d''Assemblier','');
INSERT INTO Lexique VALUES ( 680,'Assemblier','HDW','Constructeur d''Ordinateur branchant ensemble des morceaux d''ordinateur pr‚fabriqu‚s. Synonyme Assembleur','');
INSERT INTO Lexique VALUES ( 681,'Assembly Language','Coder','Mot d''origine anglaise, synonyme de Langage Assembleur','');
INSERT INTO Lexique VALUES ( 682,'Assigner (ou Allouer des pistes)','','Ce terme signifie que les pistes d‚fectueuses sur un disque dur sont signal‚es ou cit‚es au contr“leur','');
INSERT INTO Lexique VALUES ( 683,'Assistance','CAO','Capacit‚ d''un systŠme … amplifier l''aptitude du concepteur … extraire de l''analyse des donn‚es lui ‚tant soumises, une id‚e ‚tant la r‚ponse au problŠme pos‚ et ensuite … concr‚tiser cette id‚e sous la forme d''un objet','');
INSERT INTO Lexique VALUES ( 684,'Assistance','','Personne ou service dans une entreprise ayant pour fonction de vous aider quand vous avez un problŠme','');
INSERT INTO Lexique VALUES ( 685,'Assistant','HDW','Petit ordinateur sans clavier','PDA');
INSERT INTO Lexique VALUES ( 686,'Assistant','','Si c''est un logiciel, il s''agit d''un Programme d''aide … l''utilisation d''une Application plus grosse (Usine … Gaz...) ş Surcouche permettant d''‚tendre les fonctionnalit‚s d''un autre Programme','');
INSERT INTO Lexique VALUES ( 687,'Assistant','Coder','quivalent du mot anglais Wizard. Il s''agit d''une interface r‚unissant, … partir d''un ensemble de questions, des informations pour le compte de l''utilisateur','');
INSERT INTO Lexique VALUES ( 688,'Assistant Num‚rique','','','Assistant');
INSERT INTO Lexique VALUES ( 689,'Associated font','MAC','Une police Romain dont les glyphs sont automatiquement substitu‚ par les glyphs d''une police non-Romaine, pour des caractŠre de format Romain. Par exemple, le scripte Arabe utilise une association de polices … l''‚cran avec tous les caractŠres Romain, mˆme … l''int‚rieur des scriptes d''un texte Arabe','');
INSERT INTO Lexique VALUES ( 690,'Ast‚risque','','CaractŠre g‚n‚rique (Joker) rempla‡ant un ou plusieurs caractŠre(s) quelconque(s). br*er peut signifier br–ler, bramer, brouter, brfvfhvdkjhfver...','Wildcard');
INSERT INTO Lexique VALUES ( 691,'AST VGA Plus','IBM HDW','Carte Super VGA d''AST supportant des modes vid‚o graphiques allant de 800x600 en 16 couleurs … 640x480 en 256 couleurs','');
INSERT INTO Lexique VALUES ( 692,'ASVD','','Abr‚viation d''Analogic Simultaneous Voice and Data. Transfert simultan‚ de la voix et des donn‚es, de maniŠre analogique','DSVD');
INSERT INTO Lexique VALUES ( 693,'Async','','Abr‚viation de Asynchrone','');
INSERT INTO Lexique VALUES ( 694,'Asynchrone','','Mot d''origine anglaise synonyme d''Asychronous. Mode de communication dans lequel 2 ordinateurs s''‚changent des informations sans ˆtre synchronis‚s: les infos sont transmises et trait‚es … intervalles variables selon les ressources disponibles, en utilisant des r‚f‚rences temporelles diff‚rentes. Les signaux ont des phases et des fr‚quences diff‚rentes','Isochrone, Pl‚siochrone, Synchrone');
INSERT INTO Lexique VALUES ( 695,'Asynchrone','IBM HDW','Mode de travail avec lequel un module ou une unit‚ r‚agit en permanence … toutes les requˆtes, ind‚pendamment de la fr‚quence. ş Mode de fonctionnement de Processus (prendre le sens pr‚c‚dent en rempla‡ant ordinateur par Processus et communication par Communication Inter-Processus)','');
INSERT INTO Lexique VALUES ( 696,'Asynchronous','','M‚thode de transmission dans lequelle les intervalles de temps entre les caractŠres ne doivent pas ˆtre ‚gaux. Des bits suppl‚mentaire sont ajout‚s pour les rendres ‚gaux','');
INSERT INTO Lexique VALUES ( 697,'AST','HDW','Compagnie d''informatique anciennement Tandy','');
INSERT INTO Lexique VALUES ( 698,'AT','HDW COM','ApparaŒt au d‚but de certaines commandes modem compatible au standard Hayes','');
INSERT INTO Lexique VALUES ( 699,'AT','IBM','Cette abr‚viation de "Advanced Technolgy" d‚signe les modŠles de PC dot‚ d''un processeur 80286 ou plus puissant','');
INSERT INTO Lexique VALUES ( 700,'AT','Unix','Commande permettant de lancer une op‚ration … une heure donn‚e','');
INSERT INTO Lexique VALUES ( 701,'ATA','HDW','Abr‚viation d''Advanced Technology Attachment. Technologie de transfert de donn‚es entre le Disque Dur et la M‚moire. La premiŠre version, ATA, est le synonyme officiel selon l''ANSI de IDE et permet un d‚bit de 8,3 Mo par seconde, la seconde, ATA-2 aussi appel‚e EIDE, est form‚e de 2 parties, l''une logicielle dans le BIOS et l''autre mat‚rielle (elle atteint 16,6 Mo par seconde)','Fast ATA');
INSERT INTO Lexique VALUES ( 702,'ATA-2','HDW','Extension de la norme ATA','');
INSERT INTO Lexique VALUES ( 703,'Atanasoff John Vincent','','(1904-1995) Physicien am‚ricain v‚ritable inventeur du premier Ordinateur ‚lectronique en 1938. Mais sa machine n''‚tait pas programmable, contrairement … celle d''Eckert et Mauchly, ayant ‚t‚ cr‚dit‚s de l''invention jusqu''en 1973, touchant toutes les redevances jusqu''… cette date','');
INSERT INTO Lexique VALUES ( 704,'ATAPI','','Abr‚viation d''Advanced Technology Attachment Peripheral (ou Packet) Interface. Norme d''interface de connexion pour les Disque Durs (ou tout autre support de stockage de masse) sur un Bus AT, utilis‚ par la suite pour connecter les CD-ROM','ATA');
INSERT INTO Lexique VALUES ( 705,'Atari','GAME','Console de jeu des ann‚es 1970. C''est la premiŠre v‚ritable console de jeu commerciale. Le premier jeu fut Space Invader. Les jeux les plus c‚l‚bres sont Pac-Man, Missile Command, Astero‹d, Breakout, Maze Craze, Yars''Revenge, Dodge''DM, Bowling, Combat, Backgammon, Video Chess, Othello, 3-D TIC-TAC-TOE, Video Pinball. HISTOIRE: Firme am‚ricaine ayant d‚but‚ dans le domaine des machines de jeux pour les salles de jeux et les bars, puis ayant longuement rivalis‚ avec Commodore pour la supr‚matie sur le march‚ des ordinateurs de jeu, avec son 800 XL (oppos‚ alors au C64), puis sa s‚rie des ST (oppos‚s … l''Amiga). Toutefois, ils ont '+
                                                'd‚laiss‚ les ordinateurs au profit des consoles de jeux. En 1992, les pertes financiŠres de la soci‚t‚ sont ‚normes et le chiffre d''affaires au niveau mondial est tomb‚ au vingtiŠme de celui de 1982; dans ces conditions, la fin commerciale ne semble pas loin... En 1993, il abandonne donc son activit‚ dans les PC pour une machine sp‚cifique, son modŠle Falcon 030 paru fin 1992, et les consoles de jeux','Breakout, Pong');
INSERT INTO Lexique VALUES ( 706,'Atari','HDW','Ordinateur personnel du d‚but des ann‚es 1980. Principal rivaux des Commodores Amiga. A cette ‚poque cette machine ‚tant grandement reconnu par les compositeurs de musique sur ordinateur','');
INSERT INTO Lexique VALUES ( 707,'Atari ST','HDW','Ordinateur 16/32 bits datant de 1985, ayant eu un potentiel beaucoup plus ‚lev‚ en r‚volution 10 ans plus t“t que Windows 95 mais sans toutefois avoir b‚n‚fici‚ de la mˆme visibilit‚ que le produit de Microsoft','');
INSERT INTO Lexique VALUES ( 708,'ATI','','Compagnie Ontarienne de mat‚riel informatique, sp‚cialis‚ plus particuliŠrement dans les cartes de son et vid‚o','');
INSERT INTO Lexique VALUES ( 709,'ATI 8514 ULTRA','HDW','Carte vid‚o d''ATI de puissance de la carte IBM 8514/A. Cette carte permet l''affichage simultan‚ de 256 couleurs diff‚rents sur un palette de 16 millions','');
INSERT INTO Lexique VALUES ( 710,'ATI BASIC 16 VGA','HDW','Carte vid‚o d''ATI ‚quivalente … VGA. Carte permettant l''affichage de mode graphique allant de 320x200 en 256 couleurs, … 640x480 en 16 couleurs','');
INSERT INTO Lexique VALUES ( 711,'ATI EISA GRAPHICS ULTRA Pro','HDW','Carte vid‚o d''ATI de puissance Super VGA','');
INSERT INTO Lexique VALUES ( 712,'ATI GRAPHICS ULTRA','HDW','Carte vid‚o d''ATI de puissance Super VGA','');
INSERT INTO Lexique VALUES ( 713,'ATI GRAPHICS ULTRA PRO','HDW','Carte vid‚o d''ATI de puissance Super VGA','');
INSERT INTO Lexique VALUES ( 714,'ATI GRAPHICS VANTAGE','HDW','Carte vid‚o d''ATI de puissance Super VGA','');
INSERT INTO Lexique VALUES ( 715,'ATI INTEGRA','HDW','Carte vid‚o d''ATI de puissance Super VGA','');
INSERT INTO Lexique VALUES ( 716,'ATI MCA GRAPHICS ULTRA Pro','HDW','Carte vid‚o d''ATI de puissance Super VGA','');
INSERT INTO Lexique VALUES ( 717,'ATI VGA Wonder','HDW IBM','Carte Super VGA de la compagnie Ontarienne ATI supportant les modes vid‚o graphiques: 1024x768 en 16 couleurs, 640x480 ou 800x600 en 256 couleurs','');
INSERT INTO Lexique VALUES ( 718,'ATI VGA Wonder Turbo','HDW','Carte vid‚o d''ATI de puissance Super VGA. Carte ‚quivalente … la ATI VGA Wonder … la diff‚rence de celle-ci que la Turbo est plus rapide','');
INSERT INTO Lexique VALUES ( 719,'ATI VGA Wonder XL24','HDW','Carte vid‚o d''ATI de puissance Super VGA','');
INSERT INTO Lexique VALUES ( 720,'ATLAS','HDW','Machine anglaise du d‚but des ann‚es 1960, la premiŠre … disposer d''un m‚canisme de M‚moire Virtuelle','');
INSERT INTO Lexique VALUES ( 721,'ATLAS','NTW','Aussi appel‚ ®Atlas 400¯. SystŠme de Messagerie bas‚ sur la norme X400 et utilis‚ sur Transpac','');
INSERT INTO Lexique VALUES ( 722,'ATM','CAO','Abr‚viation de Adobe Type Manager. Il s''agit d''un programme d''Adobe permettant l''affichage … l''‚cran des caractŠres tels qu''ils seraient produits par une imprimante laser','');
INSERT INTO Lexique VALUES ( 723,'ATM','COM','Abr‚viation d''Asynchronous Transfer Mode. TTA en fran‡ais (technologie temporelle asynchrone). Technologie de r‚seau … haut d‚bit (centaines de Mbit/s, jusqu''… 2,5 Gbit/s) trŠs s‚rieusement normalis‚e et pr‚sent‚e comme une solution d''avenir. Les donn‚es sont transmises sous forme de paquets de taille fixe (53 octets de long), appel‚s Cellule. Originellement con‡u pour la voix et les WANs, l''ATM est en train de passer aux LANs. Cette technologie semble prendre l''ascendant en ce moment sur ses concurrentes. Le principal problŠme ‚tant la rapidit‚ de commutation, devant ˆtre ‚lev‚e vue la taille des cellules. Cette technologie est originaire de la France','Frame Relay');
INSERT INTO Lexique VALUES ( 724,'ATM','','Abr‚viation d''Automatic Teller Machine. Machine de guichet automatique, r‚pondeuse, comme un terminal bancaire','DAB');
INSERT INTO Lexique VALUES ( 725,'ATM Forum','NTW','Organisation dans laquelle sont repr‚sent‚es plusieurs centaines de soci‚t‚s impliqu‚es dans la mise au point et/ou dans la mise en oeuvre de r‚seaux ATM','');
INSERT INTO Lexique VALUES ( 726,'ATN','Coder','Fonction retournant l''arc-tangente d''une expression','');
INSERT INTO Lexique VALUES ( 727,'Atome','LISP','Mot traditionnel du langage de programmation. Exemple d''atome: ®DECEMBRE JOUEUR10 *CLEF 25 FILS-DE¯','');
INSERT INTO Lexique VALUES ( 728,'Atomicit‚','','Caract‚ristique de certains op‚rations complexes, en particulier les Transactions, qui ne seront r‚ellement effectu‚es que si toutes ses composantes peuvent ˆtre r‚alis‚es. Sinon, rien ne sera fait','Atomique');
INSERT INTO Lexique VALUES ( 729,'Atomique','','Se dit d''op‚rations que l''on peut consid‚rer comme indivisibles. Par exemple, une instruction assembleur du processeur l''est. Le fait de tester une variable *et* d''effectuer un branchement ne l''est pas forc‚ment (c''est d''ailleurs ce qui pose pas mal de problŠmes dans la communication inter-processus). Ce terme n''a absolument aucun rapport avec l''‚nergie nucl‚aire et les armes l''utilisant','Atomicit‚, Transaction');
INSERT INTO Lexique VALUES ( 730,'ATSC','','Abr‚viation d''Australian Telecommunication Standardization Committee','');
INSERT INTO Lexique VALUES ( 731,'At Sign','','Version anglais d''Arobase','');
INSERT INTO Lexique VALUES ( 732,'AT&T','HDW','Premier op‚rateur t‚l‚phonique am‚ricain','');
INSERT INTO Lexique VALUES ( 733,'AT&T DEB','HDW IBM','Carte vid‚o d''AT&T supportant le mode vid‚o sp‚cial 640x400 en 16 couleurs','');
INSERT INTO Lexique VALUES ( 734,'Attachement','NTW','Proc‚dure par laquelle on joint un ou plusieurs fichier … un courrier ‚lectronique. Les fichiers attach‚s seront transcrits dans un format leur permettant de passer par le Courrier lectronique (n''acceptant normalement que le texte simple). C''est un anglicisme, ®attachment¯ en anglais','');
INSERT INTO Lexique VALUES ( 735,'Attaque','SON','R‚gime de mont‚e d''un son au volume de crˆte','');
INSERT INTO Lexique VALUES ( 736,'Attaquer','','Synonyme de Interroger ou Consulter, quand on parle d''une base de donn‚es','');
INSERT INTO Lexique VALUES ( 737,'Attaquer','','','Piratage');
INSERT INTO Lexique VALUES ( 738,'Attente Active','','Un processus attend un ‚v‚nement, en surveillant son apparition … l''aide d''une Boucle Infinie (dont on sort tout de mˆme quand l''‚v‚nement se produit). C''est trŠs pratique dans un systŠme monotƒche, cela bloque tout l''ordinateur dans du Multitƒche mal implant‚','Coop‚ratif, Pr‚emptif');
INSERT INTO Lexique VALUES ( 739,'Att‚nuation','NTW','Perte, diminution du signal','');
INSERT INTO Lexique VALUES ( 740,'Attr','','Abr‚viation de Attribut','');
INSERT INTO Lexique VALUES ( 741,'Attribut','Coder','Une constante entiŠre d‚crivant une donn‚e attribu‚e … une entr‚e de dictonnaire. JAVA Dans le cadre de l''orientation objet, on appelle attribut des propri‚t‚s d''objets. Dans Java, le mot attribut d‚signe le composant nomm‚ d''un objet. Il d‚signe le type de valeur ou la d‚finition d''‚l‚ments, de conditions ou de valeurs pr‚d‚finies','');
INSERT INTO Lexique VALUES ( 742,'Attribut','','Pour le vid‚o, l''attribut est un octet suivant chaque caractŠre, pour l''affichage de texte sur l''‚cran, et en d‚finissant la couleur ou, plus g‚n‚ralement, l''apparence','');
INSERT INTO Lexique VALUES ( 743,'Attribut','','Caract‚ristique ou propri‚t‚ d''un fichier, d''un r‚pertoire ou d''un objet telle que la taille, la date et de la derniŠre modification ou un indicateur d''‚tat','ParamŠtre');
INSERT INTO Lexique VALUES ( 744,'Attribut (de) dessin','Windows','Objet de dessin situ‚ dans un DC et pouvant modifier l''apparence des affichages produits par diff‚rents routines de dessin de GDI. Parmi les attributs usuels, citons les plumes, les pinceaux, les polices,...','');
INSERT INTO Lexique VALUES ( 745,'Attribut (de) Fichier','','Information concernant un fichier indiquant au systŠme le type d''informations contenues dans ce fichier (systŠme, archive, etc..) ainsi que la fa‡on dont on doit g‚r‚ le fichier (cach‚ … l''utilisateur, accŠs en lecture seulement...). Ces informations ne font pas partie du fichier','RWX, XAR');
INSERT INTO Lexique VALUES ( 746,'Attribut suppl‚mentaire','','Informations suppl‚mentaire que le systŠme ou un programme associe … un fichier. Les attributs suppl‚mentaires peuvent avoir diff‚rents formats (texte, bitmap, donn‚es binaires,...)','');
INSERT INTO Lexique VALUES ( 747,'AU','SON','Format de fichier son compact‚, souvent avec l''Algorithme æ-Law. R‚pandu dans le monde Unix','');
INSERT INTO Lexique VALUES ( 748,'Audio','SON','Ensemble des techniques de manipulation des donn‚es sonores, de sa Num‚risation (chantillonnage) … sa restitution. Souvent associ‚ … la Vid‚o, cela donne de l''AV','');
INSERT INTO Lexique VALUES ( 749,'Audit','TABLEUR','Examen m‚thodique d''une feuille de calcul en vue de rechercher les erreurs et d''y rem‚dier. On peut ainsi mettre en ‚vidence les cellules d‚pendantes, les r‚f‚rences circulaires, et autres informations sur les cellules dans des formules','');
INSERT INTO Lexique VALUES ( 750,'Audioconf‚rence','NTW','Conf‚rence … distance, via le t‚l‚phone ou un r‚seau informatique, les interlocuteurs s''entendant mais ne se voyant pas','Vid‚oconf‚rence');
INSERT INTO Lexique VALUES ( 751,'Audiotex','NTW','SystŠme permettant une discussion avec un ordinateur sous un principe interactif','');
INSERT INTO Lexique VALUES ( 752,'Audit','NTW','Suivi de l''activit‚ des utilisateurs en enregistrant divers types d''‚v‚nements dans le journal S‚curit‚ d''un serveur ou d''une station de travail','');
INSERT INTO Lexique VALUES ( 753,'AUI','INTERNET','Abr‚viation d''Association des Utilisateurs de l''Internet','');
INSERT INTO Lexique VALUES ( 754,'AUI','','Abr‚viation d''Attachment Unit Interface. Interface d''unit‚ de raccordement, connecteur … un r‚seau Ethernet n‚cessitant une carte Ethernet en paire torsad‚e','');
INSERT INTO Lexique VALUES ( 755,'AUP','NTW','Abr‚viation d''Acceptable Use Policy. RŠgles d‚finissant ce que l''on a le droit de faire sur un r‚seau particulier. A l''origine, c''‚tait les rŠgles de la NSF pour l''utilisation de l''Internet depuis 1969 jusqu''en 1993, date de sa lib‚ralisation','');
INSERT INTO Lexique VALUES ( 756,'Auteur','','Se dit d''un logiciel permettant de cr‚er des applications (en clair de programmer), en g‚n‚ral sans avoir … ‚crire une ligne de Code. TrŠs utilis‚ par les BPDF pour s''imaginer qu''ils ont un gramme de cr‚ativit‚. Selon l''opinion public: ®Cela donne des programmes lourds mettant 5 minutes … se charger sur un Pentium Pro avec un disque dur SCSI-2. Quelques semaines plus tard, avec le mˆme logiciel, le mˆme BPDF est PDG de sa soci‚t‚ de multim‚dia interactif.¯','');
INSERT INTO Lexique VALUES ( 757,'Authentification','','Op‚ration par laquelle le destinataire et/ou l''‚metteur d''un message s''assure(nt) de l''identit‚ de son interlocuteur. C''est utilis‚ entre les utilisateurs des systŠmes aussi bien qu''entre des Processus. En anglais, on trouve aussi Authentication. JAVA L''identification d''un utilisateur avant l''accŠs aux ressources d''un poste local ou d''un poste r‚seau est appel‚e authentification. Cet accŠs peut concerner la lecture, la modification ou la suppression d''un enregistrement. En g‚n‚ral, l''authentification intervient par la saisie du nom d''utilisateur et d''un mot de passe','');
INSERT INTO Lexique VALUES ( 758,'Authentification','NTW','Validation de l''identit‚ d''un utilisateur. Par exemple, lorsqu''un utilisateur ouvre une session sur un ordinateur ex‚cutant WINDOWS NT Workstation, il est authentifi‚ par son ordinateur','');
INSERT INTO Lexique VALUES ( 759,'Authentifier','NTW','S''assurer de l''identit‚ de l''‚metteur d''un Message, et de l''‚galit‚ entre le message re‡u et le message envoy‚','');
INSERT INTO Lexique VALUES ( 760,'Autocode','Coder','Sorte de langage Assembleur rudimentaire, la diff‚rence entre celui-ci et l''autocode ‚tant que ce dernier ne dispose mˆme pas des quelques instructions ®complexes¯ de l''autre, comme les Macros. A l''origine, ce fut un langage ou plut“t systŠme de programmation cr‚‚ par Alick E. Glennie en 1952 pendant ses loisirs … l''Universit‚ de Manchester. Selon The Language List - Version 1.8, septembre 1992 de Bill Kinnersley: ®peut-ˆtre le premier compilateur rudimentaire; il traduisait les instructions symboliques en langage machine pour l''ordinateur Mark I de Manchester, R-U. L''autocodage devint un terme g‚n‚rique pour d‚signer la programmation en langage assembleur symbolique et des versions d''Autocode ont ‚t‚ d‚velopp‚es pour de nombreuses machines: ATLAS, Titan, Mercury et Pegasus de Ferranti, et les IBM 702 et 705¯','');
INSERT INTO Lexique VALUES ( 761,'Autocom','HDW','Abr‚viation courante de Autocommutateur, PBX en anglais, moins ‚volu‚ qu''un AMS','');
INSERT INTO Lexique VALUES ( 762,'Autocomment‚','Coder','Se dit d''un Code ‚tant tellement lisible qu''il n''aurait pas besoin de Commentaires. Synonyme d''Autodocumentaire','Autodocument‚');
INSERT INTO Lexique VALUES ( 763,'Autocommutateur','HDW','Parfois abr‚g‚ en Autocom. Central t‚l‚phonique ‚lectronique. Synonyme PAX, PABX, PBX. quipement organisant les communications et le raccordement au RTC. L''autocom est capable de g‚rer non seulement des conversations t‚l‚phoniques (… 2 ou plus), mais aussi des donn‚es informatiques en tous genres et pourrait bien devenir un maillon essentiel du systŠme informatique des entreprises. L''Autocom de base, PBX en anglais, n''est normalement pas aussi ‚volu‚ que l''AMS, il faut faire la nuance quand on veut ˆtre pr‚cis','');
INSERT INTO Lexique VALUES ( 764,'Autocopiant','PRN','Papier NCR, s''imprimant tout seul quand on appuie dessus. On ne peut l''utiliser qu''avec les imprimantes Matricielles','');
INSERT INTO Lexique VALUES ( 765,'AutoDesk','CAO','Compagnie surtout r‚pendue dans les applications de Dessin sp‚cialis‚, tel AutoCad, AutoDesk Animator,...','');
INSERT INTO Lexique VALUES ( 766,'Autodiagnostic','','Technique mis en oeuvre par une machine et permettant de lui demander (… distance ou non) comment elle va. La r‚ponse est en g‚n‚ral du genre: ®Je ne marche pas parce que l''erreur XB4552F-00C s''est produite, ou bien parce qu''il n''y a pas de disque dans le lecteur ou il n''est pas format‚, ou bien l''ordinateur n''est pas correctement branch‚¯, ce qui nous ‚claire forc‚ment','');
INSERT INTO Lexique VALUES ( 767,'Autodial','COM','Num‚rotation automatique. C''est quand le modem fait ses signales sonores afin de communiquer...','Autodialer');
INSERT INTO Lexique VALUES ( 768,'Autodialer','HDW','Composeur en fran‡ais','');
INSERT INTO Lexique VALUES ( 769,'Autodocumentaire','Coder','Synonyme de Autocomment‚ ou de Autodocument‚, selon la nuance','');
INSERT INTO Lexique VALUES ( 770,'Autodocument‚','Coder','La CMTI l''a d‚fini comme qualifiant une r‚alisation informatique dont la Documentation, int‚gr‚e au programme, peut ˆtre consult‚e directement sur l''‚cran. Ceci devient la rŠgle des logiciels s‚rieux commercialis‚s dans les ann‚es 1990. Variante: code source contenant des Commentaires, chose bien plus rare qu''il ne faudrait!','Autocomment‚');
INSERT INTO Lexique VALUES ( 771,'Autoexec','','Nom courant donn‚ aux programmes ou aux macros ex‚cut‚s … chaque fois qu''un systŠme ou qu''un logiciel est lanc‚, en particulier le fichier AUTOEXEC.BAT pour le DOS, sur les PC','');
INSERT INTO Lexique VALUES ( 772,'AutoExec.Bat','IBM DOS','Imm‚diatement aprŠs le premier chargement du COMMAND.COM, celui-ci recherche un fichier batch intitul‚ AUTOEXEC.BAT dans le r‚pertoire racine du p‚riph‚rique … partir duquel il a ‚t‚ lanc‚. Si ce fichier n''est pas trouv‚, ce n''est pas grave (il passe … l''‚tape suivante), mais s''il est trouv‚ il est automatiquement interpr‚t‚ par le "command"','');
INSERT INTO Lexique VALUES ( 773,'Automagically','','Mot d''origine anglaise ayant pour ‚quivalent fran‡ais Automagiquement','');
INSERT INTO Lexique VALUES ( 774,'Automagiquement','','Ce terme est un ®A peu prŠs¯, d‚signant un comportement ‚trange de la part d''un programme: il marche et fait ce qu''on attendait de lui','');
INSERT INTO Lexique VALUES ( 775,'Automate','MATH','Dispositif assurant un enchaŒnement automatique et continu d''op‚rations arithm‚tiques et logiques. Les automates cellulaires, dont les cellules sont les cases d''un tableau, permettent de simuler de nombreux ph‚nomŠnes naturels','');
INSERT INTO Lexique VALUES ( 776,'Automate','','Machine, m‚canisme automatique, Robot industriel, distributeur automatique. Certains font une diff‚rence fondamentale entre le robot et l''automate: le premier saurait s''adapter … son environnement, l''autre bourrant dans le tas comme un blaireau','');
INSERT INTO Lexique VALUES ( 777,'Automaticien','','Personne sp‚cialis‚e dans le domaine des Automates et de l''automatisme en g‚n‚ral','');
INSERT INTO Lexique VALUES ( 778,'Automatisme','','SystŠme con‡u pour fonctionner sans intervention humaine... c''est-…-dire avec tout plein de Maintenanciens','');
INSERT INTO Lexique VALUES ( 779,'Automodifiant','Coder','On trouve aussi Automodifi‚ (Automodifiant est plus correct). Se dit d''un code capable de se reprogrammer, de se modifier, au cours de son ex‚cution. A manier avec pr‚cautions depuis l''apparition des Caches. Il faut en effet toujours s''assurer que le contenu de la m‚moire centrale est le mˆme que celui du (des) cache(s), or, si un Programme se triture tout seul, il se peut que seule la partie de code situ‚e dans le cache soit modifi‚, et pas le reste..','');
INSERT INTO Lexique VALUES ( 780,'Automodifi‚','','Synonyme de Automodifiant','');
INSERT INTO Lexique VALUES ( 781,'Automontage','UNIX','Ce n''est que quand on accŠde … un fichier situ‚ sur un disque distant que le montage est effectu‚, et non pas lors de l''initialisation du systŠme','Montage');
INSERT INTO Lexique VALUES ( 782,'Autonome','','Se dit d''un mat‚riel lorsqu''il fonctionne ind‚pendamment de tout autre. Notes: 1.Le terme anglais offline peut ‚galement ˆtre traduit par d‚connect‚ ou indisponible.  2.Cette fiche annule et remplace celle figurant dans l''arrˆt‚ de l''informatique du 22 d‚cembre 1981 (J.O. du 17/01/82). Anglais: off-line, offline','');
INSERT INTO Lexique VALUES ( 783,'Autoplay','','Quand on met un CD-ROM dans le lecteur, le Programme principal qu''il contient se lance automatiquement. D''aprŠs certains, en particulier sous Windows 95, c''est une grande nouveaut‚ (C''est quoi alors un Virus-boot?)','');
INSERT INTO Lexique VALUES ( 784,'Auto-Programmeur','','Faisant ces propres programme lui-mˆme','');
INSERT INTO Lexique VALUES ( 785,'Autopsie','Coder','Analyse et recherche des raisons d''un Crash ou d''un Plantage, en partant de l''‚tat du systŠme juste aprŠs l''‚v‚nement. Synonyme d''Analyse Post-Mortem','');
INSERT INTO Lexique VALUES ( 786,'Auto-R‚pondeur','NTW','Logiciel se chargeant de r‚pondre automatiquement … un Courrier lectronique','Mailbot');
INSERT INTO Lexique VALUES ( 787,'Autorisation','OS2','ş Droit accord‚ … un utilisateur ou … un groupe d''utilisateurs de communiquer avec un ordinateur, un r‚seau ou une base de donn‚es. ş Ensemble de privilŠges d‚finissant les droits d''accŠs … des objets. Pour obtenir le droit d''accŠs … un objet de type r‚seau, vous devez entrer un identification d''utilisation (ID utilisateur) et un mot de passe valides','');
INSERT INTO Lexique VALUES ( 788,'Autorisations','','Attributs de fichier indiquant ayant accŠs … un fichier ou … un r‚pertoire. Surtout utilis‚ sous Unix. L''utilisateur propri‚taire d''un fichier peut d‚cider que personne d''autre que lui ne le lira, en annulant toutes les autorisations','Attribut (de) Fichier');
INSERT INTO Lexique VALUES ( 789,'Autoroute','NTW','','Autoroute de l''Information');
INSERT INTO Lexique VALUES ( 790,'Autoroute de l''Information','NTW','L''id‚e est de connecter tout le monde avec un r‚seau num‚rique … haut d‚bit, pour faire du Multim‚dia Interactif. Tout ce que ces autoroutes ont en commun avec les vraies, c''est les p‚ages, mais on n''en parle jamais... En anglais Information Superhighway. On rencontre aussi Infobahn et Inforoute','');
INSERT INTO Lexique VALUES ( 791,'Autost‚r‚ogramme','','Image en relief visible sans aucun accessoire. Le truc pour voir une telle image est d''ˆtre capable de suffisamment de concentration pour regarder une image en louchant et en focalisant sa vue 30 cm derriŠre la page. Le truc est connu des interprŠtes d''images depuis la fin des ann‚es 1980','');
INSERT INTO Lexique VALUES ( 792,'Autosync','','','Autosynchronisation');
INSERT INTO Lexique VALUES ( 793,'Autosynchronisation','','Capacit‚ d''un cran … se r‚gler automatiquement sur la fr‚quence que lui envoie la Carte Vid‚o (donc … changer de R‚solution)','');
INSERT INTO Lexique VALUES ( 794,'Auto-Test','PRN','Dispositif par lequel l''imprimante peut, sans ˆtre raccord‚e … un ordinateur, vous montrer les param‚trages de base et produire une impression test','');
INSERT INTO Lexique VALUES ( 795,'Auto-Test','HDW','Test automatique d''un systŠme, effectu‚ par le systŠme lui-mˆme. Tout PC fait … son d‚marrage un Auto-Test, s''appellant d''ailleurs le POST, ‚mettant des Bips en fonction de son ‚tat. La plupart des P‚riph‚riques se font aussi des autotests','');
INSERT INTO Lexique VALUES ( 796,'A/UX','','Abr‚viation d''Apple/Unix. Version d''Apple d''Unix destin‚e au Mac, bas‚ sur le System V de AT&T et saupoudr‚ de BSD, avec du NFS. Adapt‚ par Apple, cette version de Unix permet d''utiliser l''Interface Graphique des Macs','');
INSERT INTO Lexique VALUES ( 797,'AUX','IBM DOS','C''est sous ce nom qu''est d‚sign‚e l''interface s‚rielle','');
INSERT INTO Lexique VALUES ( 798,'Auxiliary Script','MAC','Scripte du systŠme autre que le scripte du systŠme utilis‚ par l''Application. Un scripte auxiliaire peut ˆtre utilis‚ dans les documents, mais il n''affecte pas la conduite par d‚faut du systŠme logiciel','');
INSERT INTO Lexique VALUES ( 799,'Auxiliary Slot','][','Mot d''origine anglaise, synonyme de Slot auxiliaire','');
INSERT INTO Lexique VALUES ( 800,'AV','','Abr‚viation d''Audio - Vid‚o. Caract‚rise les ‚quipements capables de g‚rer … la fois le son et l''image (anim‚e de pr‚f‚rence). Plus particuliŠrement utilis‚ par Apple (orthographi‚ ainsi: ®A/V¯) pour d‚signer ses machines dot‚es de capacit‚s particuliŠres dans ce domaine','');
INSERT INTO Lexique VALUES ( 801,'Avant-Plan','','Dans l''expression ®tƒche d''avant-plan¯, caract‚rise une Tƒche ex‚cut‚e proritairement par rapport … celles d''ArriŠre-Plan. C''est cette tƒche re‡evant les entr‚es de l''utilisateur. On dit souvent Foreground, ou Premier Plan','Tƒche de Fond');
INSERT INTO Lexique VALUES ( 802,'Avatar','NTW','Le personnage semi-imaginaire vous repr‚sentant sous forme graphique quand vous vous promenez dans une Convivialit‚, ou dans une R‚alit‚ Virtuelle. tymologiquement parlant, ®avatar¯ est la descente de Vishnou sur terre','');
INSERT INTO Lexique VALUES ( 803,'Avertissement','','Version fran‡aise de Warning. Il s''agit d''une condition d''exception n''interrompant pas pour autant l''ex‚cution du programme. Sous JAVA, JDBC offre une m‚thode getWarnings pour intercepter ces avertissements','');
INSERT INTO Lexique VALUES ( 804,'Aveugle','NTW','Se dit d''un systŠme lorsqu''il est incapable de voir quelque chose. Sur un r‚seau, par exemple, une Sonde sera incapable de d‚terminer le destinateur d''un message si celui-ci est pass‚ par un Routeur. Quand le destinateur a envoy‚ son message, il lui a donn‚ l''adresse du routeur, ayant renvoy‚ le message, le dotant par la mˆme occasion de sa propre adresse et effa‡ant la pr‚c‚dente','');
INSERT INTO Lexique VALUES ( 805,'Aveugle','','Une ‚criture se fait ®en aveugle¯ sur un disque quand on n''effectue aucune v‚rification','');
INSERT INTO Lexique VALUES ( 806,'AVI','','Abr‚viation d''Audio Video Interleave. Format de fichier d''animations mis au point par Microsoft, fonctionnant sur n''importe quelle machine, et ne n‚cessite pas de carte d''extension particuliŠre. Dans ce format, la compression est toujours effectu‚e image par image. C''est l''‚quivalent de QuickTime d''Apple','FLC, FLI, MPEG');
INSERT INTO Lexique VALUES ( 807,'AviaNet','NTW','R‚seau de messages et de fichiers bien structur‚ et portant sur l''aviation en g‚n‚ral, d''amateur de ®Flight Simulator¯, ATP ou ceux de guerre tels ®Falcon 3.0¯','');
INSERT INTO Lexique VALUES ( 808,'Avis','','Ensemble de normes de l''UIT','CCITT');
INSERT INTO Lexique VALUES ( 809,'AVR','SON','Abr‚viation d''Audio Visual Research. Fichier contenant un ‚chantillon, utilis‚ essentiellement dans le monde Mac','');
INSERT INTO Lexique VALUES ( 810,'awk','UNIX','Abr‚viation d''Aho - Weinberger - Kernighan. Langage de manipulation de donn‚es textuelles mis au point par Alfred Aho, Peter Weinberger et Brian Kernighan, ayant une syntaxe proche du C. Perl est son cousin','');
INSERT INTO Lexique VALUES ( 811,'AWT','','Abr‚viation d''Abstract-Window-Toolkit','');
INSERT INTO Lexique VALUES ( 812,'AXP','HDW','Alpha','');
INSERT INTO Lexique VALUES ( 813,'AYFK','','Abr‚viation d''Ask Your Fucking Question. ®Pose ta putain de question¯','');
INSERT INTO Lexique VALUES ( 814,'AYT','','Abr‚viation d''Are You There? ®Etes-vous l…?¯','');
INSERT INTO Lexique VALUES ( 815,'AZERTY','','Clavier fran‡ais standard, AZERTY ‚tant les premiŠres touches de la deuxiŠme ligne du clavier en partant du haut','QWERTY');
INSERT INTO Lexique VALUES ( 816,'AZT','Coder','Abr‚viation Ascii Zero Terminal, soit en fran‡ais ChaŒnes … z‚ro terminal. Les chaŒnes avec terminaison par 0 sont largement utilis‚es par les langages de programmation C et C++ et par Windows','');
INSERT INTO Lexique VALUES ( 817,'B','Coder','M‚thode de Sp‚cification formelle et de d‚veloppement, con‡ue par Jean-Raymond Abrial, permettant la production de code … partir de machines abstraites. Du mˆme auteur, la m‚thode Z ne fait que de la sp‚cification','');
INSERT INTO Lexique VALUES ( 818,'B','Coder','Ancˆtre du langage C','');
INSERT INTO Lexique VALUES ( 819,'B','HDW','Lettre traditionnellement r‚serv‚e au deuxiŠme lecteur de Disquettes, sur les Micros','');
INSERT INTO Lexique VALUES ( 820,'B1M92','IBM','Virus informatique surnomm‚ ®Year 92¯','');
INSERT INTO Lexique VALUES ( 821,'B4','','Abr‚viation de Before. ®Avant¯','');
INSERT INTO Lexique VALUES ( 822,'BA','CK64','Abr‚viation d‚signant la broche #12 d''accŠs d''extension de cartouche du Commodore 64Ko','');
INSERT INTO Lexique VALUES ( 823,'Babasse','HDW','Machine. En g‚n‚ral, c''est un Ordinateur personnel (mais on dit aussi B‚cane pour lui), ou une Imprimante (dans ce cas, elle est lourdingue, encombrante et/ou bruyante)','Bouzine');
INSERT INTO Lexique VALUES ( 824,'Babbage Charles','','(1792-1871). Math‚maticien ayant tent‚ de mettre au point une machine de calcul m‚canique dans les ann‚es 1850. Sa ®Machine Analytique¯ (aussi appel‚e Machine de Babbage) n''a jamais fonctionn‚ de son vivant (elle ‚tait m‚canique ce qui entraŒnait trop de frottements), mais fut un gouffre financier quand mˆme. Sa programmeuse fut Augusta Ad‚la‹de Byron, comtesse de Lovelace. Cette machine ne fonctionna qu''… la fin du XXe siŠcle, et encore, elle comportait tellement de piŠces m‚caniques qu''il fallut utiliser toutes les finesses de l''usinage moderne pour limiter les frottements. Du temps de son inventeur, les engrenages n''auraient jamais voulu tourner... Cette machine ‚tait programmable, mais ce n''‚tait pas un ordinateur, ‚tant pilot‚e par l''homme pour des raisons philosophiques; elle utilisait des cartes pefor‚es, comportait Imprimante et lecteur de cartes','Ada');
INSERT INTO Lexique VALUES ( 825,'Babillard','NTW','Petit service T‚l‚matique, accessible par Modem, souvent administr‚ par des particuliers, sans grands moyens (un Micro-Ordinateur seulement), et permettant le T‚l‚chargement de fichiers ainsi que l''‚change de Courrier lectronique. En anglais: BBS. Auparavant, des entreprises avaient des Babillards. D‚sormais, elles ont des serveurs un peu plus puissants, en particulier des sites Web. En fait, les BBS ont eu leurs heures de gloire dans les ann‚es 1980. Ils n''existent maintenant que sous la forme de repaires sulfureux de Hackers mal‚fiques','');
INSERT INTO Lexique VALUES ( 826,'Baby Bell','','Surnom des entreprises r‚sultant du d‚coupage de Bell par les organismes antitrust am‚ricains. Il y en a sept, ce qui explique le surnom leur ayant ‚t‚ donn‚, pour les d‚signer en mˆme temps qu''ATT: ®Blanche neige et les sept nains¯. Le nom officiel est RBOC, pour Regional Bell Operating Company ou Regional Holding Company','');
INSERT INTO Lexique VALUES ( 827,'Babylon','Coder','Environnement de d‚veloppement de systŠmes experts','SystŠme Expert');
INSERT INTO Lexique VALUES ( 828,'BAC','','Abr‚viation de BACkup. Fichier contenant une copie de Sauvegarde. On utilise toutefois beaucoup plus souvent BAK','');
INSERT INTO Lexique VALUES ( 829,'Backbone','HDW','Dorsale. Utilis‚ pour les r‚seaux, c''est l''ensemble des artŠres principales du r‚seau interconnectant l''ensemble des ‚l‚ments du r‚seau. Lebackbone est constitu‚ de quelques liens longue distance … trŠs haut d‚bit','NSF et Backbone Cabal');
INSERT INTO Lexique VALUES ( 830,'Backbone Cabal','INTERNET','Litt‚ralement, ®la cabale de l''‚pine dorsale¯. Conseil de surveillance informel compos‚ des administrateurs des sites v‚hiculant le trafic Usenet, aux origines de celui-ci. Disparue depuis','');
INSERT INTO Lexique VALUES ( 831,'Backdoor','','Porte d''entr‚e cach‚e dans un systŠme, souvent, c''est une porte de service officielle, servant lors du D‚buggage du programme, et ayant ‚t‚ plus ou moins oubli‚e. videmment, en g‚n‚ral, tout le monde ne l''oublie pas...','');
INSERT INTO Lexique VALUES ( 832,'Back-End','','En fran‡ais: ArriŠre-Plan, par opposition au ®Front-End¯ (‚tant traduit par Avant-Plan)','');
INSERT INTO Lexique VALUES ( 833,'Back-End','JAVA','Il s''agit d''un service de mis … disposition sur un serveur de r‚seau par une interface r‚seau. La contrepartie du back end est le front end (ou application frontale). Le front end exploite cette interface r‚seau pour acc‚der aux services du back end','');
INSERT INTO Lexique VALUES ( 834,'Background Color','Coder','Mots d''origine anglaise d‚signant Background Colour','');
INSERT INTO Lexique VALUES ( 835,'Background Colour','CAO','Mots d''origine anglaise d‚signant la couleur d''arriŠre-plan. Couleur situ‚e sur les parties de l''‚cran ne contenant pas de texte ou de graphiques','');
INSERT INTO Lexique VALUES ( 836,'Background Colour','IBM Coder','Mots d''origine anglaise utilis‚ dans les langages ‚volu‚ comme le Pascal pour indiquer la couleur d''arriŠre plan d''un caractŠre en ‚cran de texte','');
INSERT INTO Lexique VALUES ( 837,'Background Task','','Mots d''origine anglaise d‚signant un travail effectu‚ en second plan par un ordinateur par rapport … une tƒche prioritaire. La tƒche de fond est ex‚cut‚e dans les intervalles "creux" laiss‚s par la tƒche principale','');
INSERT INTO Lexique VALUES ( 838,'Backslash','','Version alternative de Antislash','');
INSERT INTO Lexique VALUES ( 839,'Backspace','','Touche du clavier servant … effacer le caractŠre ou la s‚lection se trouvant … gauche du curseur (sauf avec Digital o— ‡a fait n''importe quoi en alternance avec Suppr)','');
INSERT INTO Lexique VALUES ( 840,'Backtime','IBM','Virus informatique affectant le temps','');
INSERT INTO Lexique VALUES ( 841,'Backup','','Mots d''origine anglaise. Double d''un programme ou de donn‚es. Principalement, on parlera de backup dans les cas de copies de s‚curit‚, qu''il s''agisse de programmes ou de donn‚es','');
INSERT INTO Lexique VALUES ( 842,'Bact‚riorhodopsine','','Mol‚cule ayant 2 ‚tats stables et passant de l''un … l''autre sous l''effet de la lumiŠre, et permettant donc de stocker de l''information binaire. Sera bient“t utilis‚e pour fabriquer des circuits int‚gr‚s bio‚lectronique, des m‚moires dans un premier temps','');
INSERT INTO Lexique VALUES ( 843,'BAD','','Abr‚viation de Broken As Design','');
INSERT INTO Lexique VALUES ( 844,'Badaud','NTW','Version fran‡ais de Lurker. Quelqu''un lisant les news d''un Forum Usenet sans jamais rien poster. Au f‚minin : ®Badaude¯. Synonyme possibles: ®Consommateur passif¯, ®Lecteur silencieux¯','');
INSERT INTO Lexique VALUES ( 845,'Baguette Magique','','Outil utilis‚ en retouche d''image et permettant de r‚aliser une S‚lection dans l''image selon une tol‚rance de couleur. Cousin: Lasso','');
INSERT INTO Lexique VALUES ( 846,'Baguette Magique','CAO','Objet permettant de choisir une distance dans l''espace de couleur et un point de l''image, puis de choisir tous les points adjacents se trouvant dans cet intervalle de couleur; elle sert aux retouches de couleur','');
INSERT INTO Lexique VALUES ( 847,'Baie','','Synonyme de Rack','');
INSERT INTO Lexique VALUES ( 848,'BAK','','Abr‚viation de BAcKup. Fichier, g‚n‚r‚ automatiquement en g‚n‚ral, contenant une ancienne version d''un document','Backup');
INSERT INTO Lexique VALUES ( 849,'BAKup','','Mots d''origine anglaise d‚signant une op‚ration de duplication d''un fichier pour disposer d''une copie de sauvegarde','');
INSERT INTO Lexique VALUES ( 850,'BAL','NTW','BoŒte … Lettres. Espace, sur un Disque Dur, d‚di‚ … un utilisateur, o— sont stock‚s les Messages ‚lectroniques lui parvennant (dans une File d''Attente), en attendant qu''il les lise. Voir aussi Courrier lectronique, Email, Messagerie. Variantes : BL, MBX (anglais). La forme correcte est d''aprŠs le Robert ®BoŒte aux lettres¯. Pour ˆtre correct, on devrait toujours ‚crire ®BAL¯, avec l''accent sur le ®A¯','');
INSERT INTO Lexique VALUES ( 851,'Balayage','','Le fait de parcourir s‚quentiellement un ensemble de donn‚es pour y trouver une Information. Voir Scanner et sa famille','');
INSERT INTO Lexique VALUES ( 852,'Balayage','HDW','Le fait pour le faisceau d''‚lectrons d''un Moniteur de parcourir l''‚cran','');
INSERT INTO Lexique VALUES ( 853,'Balayage entrelac‚','CAO','Ce terme d‚signe le mode d''affichage peu performant consistu‚ en 2 passages. Au premier passage, ce sont les lignes paires ‚tant affich‚es; tandis qu''au second passage ce sont les lignes impaires','');
INSERT INTO Lexique VALUES ( 854,'Balayage (de) trame','IBM','Terme caract‚risant un ‚cran graphique, dans lequel le faisceau d''‚lectron balaie syst‚matiquement toute la surface sensible. L''‚cran est ainsi d‚coup‚ en ligne et chaque ligne en points','');
INSERT INTO Lexique VALUES ( 855,'Balayage vecteur','IBM','Terme caract‚risant un ‚cran graphique, dans lequel le faisceau d''‚lectrons balaie uniquement les traits visibles … l''‚cran','');
INSERT INTO Lexique VALUES ( 856,'Balayer','','Ex‚cuter un Balayage','Scanner');
INSERT INTO Lexique VALUES ( 857,'Balisage','','Le fait de coller tout un tas de Balises dans un document','');
INSERT INTO Lexique VALUES ( 858,'Balise','INTERNET','CaractŠre particulier, ou s‚rie de caractŠres, utilis‚ pour la mise en forme d''un document (souvent du texte), et ‚tant invisible pour l''utilisateur final. Un exemple typique est l''insertion des liens d''un document Hypertexte','Ancre, tiquette, Marque, Tag');
INSERT INTO Lexique VALUES ( 859,'Banane','','Logiciel-Banane','');
INSERT INTO Lexique VALUES ( 860,'Bancale','','Cabale','');
INSERT INTO Lexique VALUES ( 861,'Bancatique','','Ensemble des techniques de l''‚lectronique et de l''informatique appliqu‚es au secteur bancaire','');
INSERT INTO Lexique VALUES ( 862,'Banc d''Essai','','Simulation de l''environnement de fonctionnement d''un systŠme … des fins de test (i.e. on essaye pour voir si ‡a fonctionne correctement). On le confond souvent avec le Benchmark, qui, lui, est en fait un test de performance','Jeu d''Essai');
INSERT INTO Lexique VALUES ( 863,'Bande','HDW','Abr‚viation usuelle de ®Bande Magn‚tique¯. Support de stockage de donn‚es … long terme de trŠs grande capacit‚. Utilis‚ pour faire des Sauvegardes. Le p‚riph‚rique associ‚ est le Streamer, appel‚ Tape Drive en anglais. Le principal inconv‚nient, c''est le Temps d''AccŠs, pouvant ˆtre trŠs long (1 minute, au lieu de quelques dizaines ou centaines de millisecondes par ailleurs), les autres inconv‚nients, plus mineurs, mais p‚nibles quand mˆme, sont les problŠmes d''enroulement, la d‚magn‚tisation au fil du temps, l''allongement, la rupture','Bande Optique');
INSERT INTO Lexique VALUES ( 864,'Bande','','Bande Passante','');
INSERT INTO Lexique VALUES ( 865,'Bande Carbon‚e','PRN','Sorte de Ruban Encreur, mais ne pouvant ˆtre utilis‚e qu''une fois et relativement dispendieux','');
INSERT INTO Lexique VALUES ( 866,'Bande Optique','HDW','Bande sur laquelle on lit et on ‚crit … l''aide de diodes lasers','');
INSERT INTO Lexique VALUES ( 867,'Bande passante','','Terme caract‚risant un signal. Dans le cas d''un ‚cran, elle exprime le nombre maximum de positions balay‚es par la faisceau d''‚lectrons en 1/25e de seconde. L''unit‚ est le Hertz ou le M‚gahertz (MHz)','');
INSERT INTO Lexique VALUES ( 868,'Bande passante','NTW','La Largeur de Bande est l''intervalle de fr‚quences (® la bande ¯) transmises sans distorsions notables sur un support de transmission. Pour les r‚seaux, et ensuite par extension pour tous les m‚dias, cela repr‚sente la quantit‚ de donn‚es transmises, c''est-…-dire le D‚bit, aussi appel‚ alors Bande Passante','');
INSERT INTO Lexique VALUES ( 869,'Bande passante','NTW','Expression synonyme de Bandwith','');
INSERT INTO Lexique VALUES ( 870,'Banding','CAO','Mots d''origine anglaise repr‚sentant un effet de bandes. Il s''agit d''un effet non d‚sir‚ visible dans le d‚grad‚ de couleurs provoqu‚ par une d‚finition insuffisante du p‚riph‚rique de sortie','');
INSERT INTO Lexique VALUES ( 871,'Bandwith','NTW','Mots d''origine anglaise d‚signant une gamme de fr‚quences pouvant passer sur un canal','');
INSERT INTO Lexique VALUES ( 872,'Bang','','Nom (ou surnom) anglo-saxon du caractŠre ®!¯. C''est-…-dire un Point d''Exclamation','');
INSERT INTO Lexique VALUES ( 873,'Bang Path','INTERNET','Description du routage d''un message, sous la forme d''une liste de noms de sites s‚par‚s par des points d''exclamation (Bang en argot am‚ricain). C''est un routine source','');
INSERT INTO Lexique VALUES ( 874,'Bank','','','Banque');
INSERT INTO Lexique VALUES ( 875,'Banner','','','BanniŠre');
INSERT INTO Lexique VALUES ( 876,'BanniŠre','UNIX','Un texte ‚crit en grand sur un terminal … l''aide de la commande du mˆme nom. HUMOUR: Utilis‚ par les ‚tudiants de deuxiŠme ann‚e en france pour faire peur aux ®petits¯ d‚butant et sont terroris‚s de voir apparaŒtre en grand sur leur ‚cran des textes comme ®Je te vois !¯, messages qu''ils croient souvent venir de leur Dieu','');
INSERT INTO Lexique VALUES ( 877,'BanniŠre','PRN','Un texte ‚crit en grand sur la premiŠre page d''une impression, et s‚parant les impressions sur les listings, sur les imprimantes de groupe. Utilis‚ sur les vieux systŠmes o— l''on a toujours des Listings','');
INSERT INTO Lexique VALUES ( 878,'BanniŠre','','Le premier ‚cran d''un logiciel, indiquant son nom, avec g‚n‚ralement un dessin, les noms des auteurs, tous les droits d''auteurs, le rappel de la l‚gislation sur le piratage... Par exemple pour Word 6, c''est un stylo avec du papier','');
INSERT INTO Lexique VALUES ( 879,'Bannir','','®To ban¯ en anglais. Chasser d‚finitivement quelqu''un d''un canal IRC quand on en est l''OP','');
INSERT INTO Lexique VALUES ( 880,'Banque','','Segment d''une m‚moire. La granularit‚ d''une m‚moire est la distance minimale en octets entre deux banques successives. L''‚quivalent anglais est Bank','Banque de Donn‚es');
INSERT INTO Lexique VALUES ( 881,'Banque de donn‚es','','Ensemble de fichiers informatis‚s regroupant des donn‚es dans un domaine particulier, exemple: banques de donn‚es sur le vin, sur l''‚conomie mondiale,... L''‚quivalent anglais est DataBank','');
INSERT INTO Lexique VALUES ( 882,'Bar','','','Foobar');
INSERT INTO Lexique VALUES ( 883,'Barre','','l‚ment graphique horizontal permettant l''affichage de plus d''information que la d‚finition vid‚o le permet','');
INSERT INTO Lexique VALUES ( 884,'Barre (de) d‚filement','','Barre situ‚e … droite ou en bas d''une fenˆtre; appel‚e aussi ®ascenseur¯; elle permet de faire d‚filer horizontalement et verticalement le document … l''int‚rieur de la fenˆtre. ş Sous QUATTRO PRO, affich‚es en surbrillance le long des bords inf‚rieur et droit de chaque fenˆtre, elles permettent de faire d‚filer la feuille de calcul avec la souris. Pour cela, il suffit de cliquer la boŒte de d‚filement de l''une des deux barres, de la d‚placer jusqu''… faire apparaŒtre la zone souhait‚e, puis de relƒcher','');
INSERT INTO Lexique VALUES ( 885,'Barre (d'')tat','','Ligne inf‚rieure d''une Fenˆtre, incorpor‚e au cadre de cette fenˆtre, et affichant des informations sur l''‚tat g‚n‚ral du programme (ce qu''il fait, ce qu''il attend, ce qu''il veut...)','');
INSERT INTO Lexique VALUES ( 886,'Barre (d'')Ic“nes','','Widget contenant des Ic“nes affich‚es conjointement. Synonyme de Barre d''Outils','Barre, Palette, Palette Flottante');
INSERT INTO Lexique VALUES ( 887,'Barre (d'')Ic“nes','QUATTRO_PRO','Colonne de boutons, situ‚e le long de la bordure droite des fenˆtres feuille de calcul ou Gestionnaire de fichiers, ou en haut (mode WYSIWYG), permettant d''activer certaines fonctions par exemple cliquage','');
INSERT INTO Lexique VALUES ( 888,'Barre (de) menus','','Barre situ‚ sous la barre de titre d''une fenˆtre ou d''un ‚cran: elle donne accŠs aux commandes des diff‚rents menus','');
INSERT INTO Lexique VALUES ( 889,'Barre Oblique Inverse','','Version fran‡aise officielle de Antislash ou Backslash. C''est le caractŠre "\"','');
INSERT INTO Lexique VALUES ( 890,'Barre d''Outils','','Widget r‚unissant toute une s‚rie d''Ic“nes repr‚sentant des outils. Synonyme de Barre d''Ic“nes','Barre, Palette, Palette Flottante');
INSERT INTO Lexique VALUES ( 891,'Barre (de) pression','PRN','D‚signe un dispositif servant … presser le papier contre le rouleau de l''imprimante; la barre porte 2 ou 3 petits cylindre. On peut g‚n‚ralement la basculer vers l''avant pour ins‚rer ou sortir le papier','');
INSERT INTO Lexique VALUES ( 892,'Barre (des) tƒches','Windows95','Barre graphique situ‚e en bas du bureau; la barre des tƒches affiche l''heure et la liste des applications en cours d''ex‚cution; le bouton D‚marrer est situ‚ dans cette barre','');
INSERT INTO Lexique VALUES ( 893,'Barre (de) titre','','Barre situ‚ en haut d''une fenˆtre indiquant le nom de celle-ci','');
INSERT INTO Lexique VALUES ( 894,'Barrel Shifter','HDW','Cƒblage interne … un Microprocesseur lui permettant de r‚aliser plusieurs Shifts (Shift) en un seul cycle machine (jusqu''… 8 d''un coup sur certains processeurs Motorola). Extrˆmement rapidement, donc','');
INSERT INTO Lexique VALUES ( 895,'Barrette','HDW','Petite Carte d''extension supportant des Puces de M‚moire Vive','SIMM, SIPP');
INSERT INTO Lexique VALUES ( 896,'BAS','Coder','Fichier contenant un Source en BASIC. Bien que cela soit souvent le cas, les sources en BASIC ne sont pas forc‚ment cod‚s en ASCII comme par exemple sous BASICA et GWBASIC','');
INSERT INTO Lexique VALUES ( 897,'Bascule','Coder','Synonyme de type … bascule, valeur de type bool‚anne','');
INSERT INTO Lexique VALUES ( 898,'Bascule','HDW','Type de circuit logique passant par 2 ‚tats et pouvant stocker de l''information. Utilis‚ dans les SRAM (aussi appel‚ M‚moire Statique). En anglais: Flip-Flop','');
INSERT INTO Lexique VALUES ( 899,'Basculement','','Synonyme de Migration','');
INSERT INTO Lexique VALUES ( 900,'Basculer','OS2','Passer d''un mode … un autre. Par exemple, l''utilisateur d''un ordinateur personnel connect‚ … un r‚seau peut basculer du mode entr‚e de donn‚es au mode commande, ou du mode de fonctionnement ind‚pendant au mode ‚mulation de terminal. Par exemple, lorsque vous appuyez sur la touche ®NumLock¯ (VerNum), celle-ci passe du mode EF au mode HF, et inversement','');
INSERT INTO Lexique VALUES ( 901,'Base','MATH','Nombre de chiffres utilis‚s dans un systŠme de num‚ration. Exemple: La base hexad‚cimale comporte 16 chiffres','Binaire, Hexad‚cimal, Octal');
INSERT INTO Lexique VALUES ( 902,'Base','Coder','Index du plus petit ‚l‚ment d''un Tableau (en g‚n‚ral 0 ou 1)','');
INSERT INTO Lexique VALUES ( 903,'Base','','Expression populaire ®J''entre les donn‚es dans la Base¯ signifie ajouter des informations dans une Base de Donn‚es','');
INSERT INTO Lexique VALUES ( 904,'Base (de) donn‚es','','Ensemble de donn‚es organis‚ en lignes, appel‚es enregistrements, elles-mˆmes divis‚es en colonnes appel‚es champs','Gestionnaire de base de donn‚es, S.G.B.D.');
INSERT INTO Lexique VALUES ( 905,'Base (de) donn‚es','OS2','Ensemble de donn‚es structur‚ mis … la disposition d''un grand nombre d''utilisateurs pour leur permettre d''y rechercher des informations et d''y ajouter les leurs','');
INSERT INTO Lexique VALUES ( 906,'Base (de) donn‚es des classes','Windows','Collection de classes de fenˆtres ayant ‚t‚ enregistr‚es dans la systŠme au moyen de la fonction ®RegisterClass¯','');
INSERT INTO Lexique VALUES ( 907,'Base (de) donn‚es des modules','Windows','Image r‚sidente en m‚moire de l''en-tˆte du fichier d''un programme d''application ou d''une bibliothŠque de liaison dynamique. Le chargeur de Windows s''en sert pour charger les programmes et les ressources … partir du disque lorsque c''est n‚cessaire','');
INSERT INTO Lexique VALUES ( 908,'Basehand','NTW','Terme d''origine anglaise s''opposant … broadband. La baseband est une connexion ‚lectronique de r‚seau limitant le cƒble … un canal','');
INSERT INTO Lexique VALUES ( 909,'bash','','Abr‚viation de Bourne Again SHell. Shell d‚velopp‚ par la FSF, disposant de tous les gadgets d''un shell complet. Utilis‚ g‚n‚ralement par d‚faut sous Linux','');
INSERT INTO Lexique VALUES ( 910,'Basic','','Abr‚viation de "Beginner''s All-Propose Symbolic Instruction Code" (Langage symbolique universel pour d‚butants). Langage de programmation trŠs r‚pandu invent‚ aux tats-Unis, il a ‚t‚ con‡u au d‚but des ann‚es 1960 pour rendre plus accessibles les ordinateurs, sans sacrifier la puissance de calcul. ş Sous l''Apple ][, 2 versions sont disponibles pour ces ordinateurs: Applesoft (construit dans le "frimware" d''Apple ][ et l''Apple ][ Plus) et le Basic int‚gr‚ (fournit dans la disquette SYSTEM MASTER','');
INSERT INTO Lexique VALUES ( 911,'BASICA','IBM','Abr‚viation de Basic Advanced. Version du langage Basic trŠs rapide d‚velopp‚ par IBM pour ses PC. Ce n''est pas un compilateur mais plut“t qu''un Interpr‚teur','');
INSERT INTO Lexique VALUES ( 912,'Basic en ROM','IBM HDW Coder','Sp‚cification mat‚riel des premiers modŠles PC comportant en ROM, … partir de l''adresse F000h:6000h un petit interpr‚teur Basic ne permettant cependant pas d''acc‚der aux m‚moire de masse externes telles que la disquette ou le disque dur. Sur ces systŠmes, ce Basic est appel‚ chaque fois que le BIOS ‚choue dans sa tentative de charger un systŠme d''exploitation','');
INSERT INTO Lexique VALUES ( 913,'Basilisk','GAME','Nom d''origine anglaise utilis‚ dans "Advanced Dungeons & Dragons". C''est un monstre reptilien dont le regard peut changer toute chair en os','');
INSERT INTO Lexique VALUES ( 914,'Bas Niveau','Coder','A un niveau proche du SystŠme. Qui est peu d‚velopp‚: langage de bas niveau (LLL)','');
INSERT INTO Lexique VALUES ( 915,'BAT','IBM DOS','Fichier contenant un programme de Traitement par Lots','Batch');
INSERT INTO Lexique VALUES ( 916,'BAT','IBM DOS','Abr‚viation de Block Address Translation','');
INSERT INTO Lexique VALUES ( 917,'Batch','IBM DOS','Mots d''origine anglaise d‚signant un type de commande ex‚cut‚ par le prompt du DOS','');
INSERT INTO Lexique VALUES ( 918,'Batch file','IBM DOS','Terme d''origine anglaise ‚tant utilis‚ pour d‚signer un fichier comprennant des instructions de commande de type Batch','');
INSERT INTO Lexique VALUES ( 919,'Batch mode','NTW','Terme d''origine anglaise d‚signant l''ex‚cution d''un programme sans l''intervention de l''utilisateur','');
INSERT INTO Lexique VALUES ( 920,'Batterie','HDW','Accessoire indispensable au fonctionnement d''un ordinateur Portable, tellement indispensable d''ailleurs que c''est l''un des principaux points faibles des portables','');
INSERT INTO Lexique VALUES ( 921,'Batterie','','D''une maniŠre g‚n‚rale, une batterie est une collection d''‚l‚ments de mˆme type. Une ®batterie de cuisine¯ est une s‚rie de casseroles, une batterie de disques durs... idem, une batterie de portable est une s‚rie d''accumulateurs','');
INSERT INTO Lexique VALUES ( 922,'Batterie','','Instrument de musique, reconnu comme beaucoup d''autres par la norme MIDI','');
INSERT INTO Lexique VALUES ( 923,'Baud','COM','Baud, l''unit‚, du nom de Baudot, l''inventeur (1845-1903). Le baud est l''unit‚ de mesure de la vitesse de transmission des donn‚es de modulation, souvent confondu avec le bit par seconde. En g‚n‚ral, 1 baud = 1 bps, mais cela d‚pend de la Valence du signal (i. e. le nombre de valeurs diff‚rentes qu''il peut prendre). Dans les modems actuels, 1 baud vaut plusieurs bps','BPS, Modem');
INSERT INTO Lexique VALUES ( 924,'Baudot','','Nom de l''inventeur en ayant prˆt‚ une partie de son nom au Baud Function','');
INSERT INTO Lexique VALUES ( 925,'Baud rate','COM','Mots d''origine anglaise d‚signant la vitesse de transmission s''exprimant le plus souvent en baud, ou bps (pour "baud per second")','');
INSERT INTO Lexique VALUES ( 926,'Bavardage','INTERNET','Version fran‡aise rare de Chat','');
INSERT INTO Lexique VALUES ( 927,'Baver','','Se dit de couleurs, quand elles ne sont pas … leur place. C''est soit un problŠme mat‚riel d''affichage, soit une interface bƒcl‚e, soit un vilain bug','');
INSERT INTO Lexique VALUES ( 928,'BBIAF','','Abr‚viation de Be Back In A Few minutes. ®Je reviens dans un instant¯ (ou dans quelques minutes, ou jamais)','');
INSERT INTO Lexique VALUES ( 929,'BBL','','Abr‚viation de Be Back Later. ®Je reviens plus tard¯. Cousin de AFK, dans une discussion en direct, mais quand on s''‚loigne pour plus longtemps','');
INSERT INTO Lexique VALUES ( 930,'BBN','','Abr‚viation de Bye Bye Now. ®Maintenant, au revoir¯. Quand il faut vraiment se quitter … la fin d''une discussion en direct','');
INSERT INTO Lexique VALUES ( 931,'BBS','COM','Abr‚vation anglaise de "Bulletin Board System". Banque de fichier ou messagerie utilise pour l''‚change d''information de toute sorte','');
INSERT INTO Lexique VALUES ( 932,'BBS-Addy','COM','Petit programme de publicit‚ dans une boŒte aux lettres de messagerie ‚lectronique, 64Ko au maximum','');
INSERT INTO Lexique VALUES ( 933,'BCD','Coder','Abr‚viation d''origine anglaise "Binary Codes Decimal" (d‚cimal cod‚ en binaire). Ensemble d''octets dont chacun est cod‚ sur 2 chiffres d‚cimaux, les quatre bits de plus fort poids codant le chiffre de plus faible poids','');
INSERT INTO Lexique VALUES ( 934,'BCE','Coder','Abr‚viation de Boucle pour le code source de nombreux programme d''exemple','');
INSERT INTO Lexique VALUES ( 935,'BCNU','','Abr‚viation de Be Seeing You. Utilis‚ pour se donner un rendez-vous: ®je te verrai plus tard¯ = ®BCNU L8TR¯','');
INSERT INTO Lexique VALUES ( 936,'BCRCI','','Abr‚viation de Brigade Centrale de la R‚pression de la Criminalit‚ Informatique. Service d‚pendant de la police judiciaire (PJ), cousin du SEFTI, mais s''occupant d''affaires g‚n‚ralement provinciales (le SEFTI ‚tant parisine)','CNIL, DISSI, DST, SCSSI');
INSERT INTO Lexique VALUES ( 937,'BD','','Abr‚viation de Base de Donn‚es','');
INSERT INTO Lexique VALUES ( 938,'BDD','','Abr‚viation de Base De Donn‚es','');
INSERT INTO Lexique VALUES ( 939,'Bean','Coder','Voir Javabean','');
INSERT INTO Lexique VALUES ( 940,'Beat Them Up','GAME','Jeu de baston, dans lequel le seul objectif est de casser la gueule de l''adversaire. Exemple type: Street Fighter','Shoot Them Up');
INSERT INTO Lexique VALUES ( 941,'Beat''em Up','GAME','','Beat Them Up');
INSERT INTO Lexique VALUES ( 942,'Beautifier','','Programme am‚liorant la forme de votre Code source en y apportant quelques formatages standardis‚s (les indentations deviennent r‚guliŠres, par exemple)','');
INSERT INTO Lexique VALUES ( 943,'B‚cane','HDW','Ordinateur. Plus particuliŠrement, micro-ordinateur personnel. Exemple: J''ai une super b‚cane qui p‚dale bien','');
INSERT INTO Lexique VALUES ( 944,'BEDO','IBM HDW','Abr‚viation de Burst EDO RAM. EDO RAM acceptent les accŠs Burst','');
INSERT INTO Lexique VALUES ( 945,'Beep','SON','Le petit bruit que le haut-parleur int‚gr‚ … un ordinateur peut g‚n‚rer pour vous indiquer si tout va bien ou si tout va mal en fonction des circonstances. Pendant longtemps, une succession de beeps fut consid‚r‚ comme de la ®musique¯ sur un PC. Synonyme de Bilip, Blip','');
INSERT INTO Lexique VALUES ( 946,'Beep','HDW','Petit appareil qu''on porte … la ceinture ou dans sa poche et permettant de vous faire savoir qu''on cherche … vous joindre','');
INSERT INTO Lexique VALUES ( 947,'Belgadoc','','Serveur de banque de donn‚e Belge','');
INSERT INTO Lexique VALUES ( 948,'Bell','','Graham Bell fut l''inventeur du t‚l‚phone. D''aprŠs la l‚gende, il s''est renvers‚ un truc sur les genoux, et a appel‚ son assistant au secours par t‚l‚phone sans mˆme se rendre compte de ce qu''il faisait (®Watson, come here, I need you!¯). Cela fut le premier coup de fil du monde. Puis Bell cr‚a sa compagnie de PTT, … laquelle il donna son nom','Bellcore');
INSERT INTO Lexique VALUES ( 949,'Bellcore','','Abr‚viation de BELL COmmunications Research. C''est un labo de recherche commun aux diff‚rentes Baby Bells','Bell');
INSERT INTO Lexique VALUES ( 950,'Bench','','Abr‚viation de Benchmark','');
INSERT INTO Lexique VALUES ( 951,'Benchmark','','Abr‚viation de Benchmark. Banc d''essai, permettant de mesurer les performances d''un systŠme pour le comparer … d''autres. En g‚n‚ral, les benchs (ou benchmark) ne veulent pas dire grand chose, car dŠs qu''ils deviennent des r‚f‚rences, les constructeurs ou les ‚diteurs s''empressent de cr‚er des systŠmes optimis‚s sp‚cialement pour eux..','MIPS');
INSERT INTO Lexique VALUES ( 952,'Benchmarking','','Mesure des performances d''un systŠme informatique afin de le comparer … d''autres systŠmes, … l''aide d''un Bench. Cette technique est utilis‚e pour am‚liorer les systŠmes d''informations','');
INSERT INTO Lexique VALUES ( 953,'Ben-day','CAO','Mots d''origine anglaise. Proc‚d‚ de mise en couleur devant son nom … son inventeur, Benjamin Day, un savant am‚ricain du d‚but du siŠcle. Cette technique consiste … reconstituer "manuellement", c''est-…-dire par superposition, des couleurs … partir de 2 ou 3 des couleurs primaires de la quadrichromie','');
INSERT INTO Lexique VALUES ( 954,'BER','COM','Abr‚viation de Bit Error Rate. Taux de Bits erron‚s, c''est-…-dire ayant ‚t‚ mal transmis','');
INSERT INTO Lexique VALUES ( 955,'Berthiaume, Paul','','N‚ … Montr‚al (Qu‚bec), en 1939, fils d''Antoine Berthiaume et Marguerite Leblanc. Etudes: CollŠge Notre-Dame, Montr‚al; CollŠge de Saint-Laurent, bachelier Šs arts (b.a.) de l''Universit‚ de Montr‚al; Universit‚ McGill, math‚matique avanc‚es. CarriŠre: Conseiller technique, au service d''IBM, Montr‚al 1962-1965; repr‚sentant de cette ®Berthiaume, St-Pierre, Th‚riault & Associ‚ Inc.¯, Montr‚al depuis 1966. Association: Directeur national de l''Association canadienne de l''informatique, (1967-1968)','');
INSERT INTO Lexique VALUES ( 956,'Berthiaume, St-Pierre, Th‚riault & Associ‚s Inc.','','Entreprise sp‚cialis‚ dans les conseils en informatique fond‚ en juillet 1966','');
INSERT INTO Lexique VALUES ( 957,'Bˆta','','Degr‚ de finition d''un logiciel. Le stade bˆta signifie que le logiciel est encore en phase de d‚veloppement, mais qu''il est confi‚ … des fins de test … un groupe d''utilisateurs','');
INSERT INTO Lexique VALUES ( 958,'Bˆta Release','','','Bˆta Version');
INSERT INTO Lexique VALUES ( 959,'Bˆta Version','','Pr‚version d''un logiciel, distribu‚e … des fins de test, comprenant toutes ses fonctions (Contrairement … l''Alpha Version), mais aussi de nombreux Bugs, … tel point que les bˆtas sont souvent inutilisables s‚rieusement. Parfois, Bˆta est ‚crit ®beta¯ ou ®b‚ta¯','');
INSERT INTO Lexique VALUES ( 960,'Bˆta Testeur','','Client r‚el testant un nouveau produit en situation - th‚oriquement - r‚elle ; en ‚change du service rendu en faisant les essais, il a droit habituellement … un support technique qualifi‚ et attentif. Le Bˆta n''a strictement aucun rapport avec l''adjectif Bˆtat','Tester');
INSERT INTO Lexique VALUES ( 961,'Betweening -','','Synonyme rare de Tween','');
INSERT INTO Lexique VALUES ( 962,'Beziers','CAO','M‚thode de repr‚sentation de surfaces gauches par approximation … l''aide de "carreaux" (ou portions ‚l‚mentaires de surface) d‚finis par les ‚quations des 4 courbes frontiŠres. Cr‚‚e par Pierre B‚zier, ing‚nieur chez Renault, pour la mod‚lisation des carrosseries de voitures','');
INSERT INTO Lexique VALUES ( 963,'BFD','','Abr‚viation de Big Fucking Deal','');
INSERT INTO Lexique VALUES ( 964,'BFG','','Abr‚viation de Big Fat Grin','');
INSERT INTO Lexique VALUES ( 965,'BFN','','Abr‚viation de Bye For Now. ®A+¯, ®C''est tout pour le moment¯','');
INSERT INTO Lexique VALUES ( 966,'BFT','COM','Abr‚viation de Binary File Transfer. Transfert de Fichiers en mode binaire: c''est le transfert ‚tant binaire, on ne s''occupe pas du fichier. Il faut y prendre garde: certains transferts se font en mode caractŠre, et ces caractŠres sont souvent en ASCII 7 bits','');
INSERT INTO Lexique VALUES ( 967,'BGCOLOR','','Abr‚viation de Background Color. Balise permettant de d‚finir une couleur de fond pour tout ou partie d''une page Web','');
INSERT INTO Lexique VALUES ( 968,'BGE','Coder','Abr‚viation de Branch if Greater or Equal de l''Assembleur. Nom du Mn‚monique en Assembleur ordonnant un Branchement si un paramŠtre est sup‚rieur ou ‚gal … une certaine valeur. Synonyme de BHI','BHIS');
INSERT INTO Lexique VALUES ( 969,'BGI','IBM Coder','Abr‚viation de Borland Graphic Interface. Interface permettant de r‚aliser des sorties graphiques (par opposition au mode texte) avec les langages sous DOS de chez Borland','');
INSERT INTO Lexique VALUES ( 970,'BHI','Coder','Abr‚viation de Branch if Higher de l''Assembleur. Nom du Mn‚monique en Assembleur ordonnant un Branchement si un paramŠtre est sup‚rieur … une certaine valeur. Synonyme de BGE','BHIS');
INSERT INTO Lexique VALUES ( 971,'BHIS','Coder','Abr‚viation de Branch if Higher or Same de l''Assembleur. Nom du Mn‚monique en Assembleur ordonnant un Branchement si un paramŠtre est sup‚rieur ou ‚gal … une certaine valeur','BHI');
INSERT INTO Lexique VALUES ( 972,'Bible','','Un bouquin de r‚f‚rence sur un sujet (un logiciel, un SE, une machine), extrˆmement d‚taill‚, et faisant r‚f‚rence dans ce sujet. Exemple: La bible du PC, 5Šme ‚dition','Ancien Testament, Nouveau Testament');
INSERT INTO Lexique VALUES ( 973,'Biblioth‚caire','','Classe de logiciels dont la mission est de g‚rer des BibliothŠques','Robot Biblioth‚caire');
INSERT INTO Lexique VALUES ( 974,'BibliothŠque','','Ensemble de Fonction et/ou de Proc‚dures, ayant de pr‚f‚rence un point commun. Les fichiers contenant les bibliothŠques ont souvent l''extension LIB, de l''anglais Library','');
INSERT INTO Lexique VALUES ( 975,'BibliothŠque (d'')importation','Windows','Fournit … l''‚diteur de liens des informations sur les points d''entr‚e export‚s d''une bibliothŠque de liaison dynamique. La bibliothŠque d''importation permet de cr‚er un enregistrement de translation d''adresse dans un fichier .EXE grƒce auquel le m‚canisme des liaisons dynamique de Windows pourra op‚rer les ajustements n‚cessaires lors de l''ex‚cution du programme','');
INSERT INTO Lexique VALUES ( 976,'BibliothŠque (de) liaisons dynamiques','Windows','Fichier contenant du code ou des donn‚es et pouvant ˆtre partag‚ par diff‚rents programme d''application lors de leur ex‚cution. Windows lui mˆme en contient plusieurs: ®KERNEL.EXE¯, ®USER.EXE¯ et ®GDI.EXE¯. Les polices de caractŠres sont un exemple de bibliothŠque de liaison dynamique ne contenant pas de code','');
INSERT INTO Lexique VALUES ( 977,'BibliothŠque (de) macros','TABLEUR','Feuille de calcul destin‚e … stocker des macros. Sous Quattro Pro, lorsque vous lancez une macro ne faisant pas partie de la feuille de calcul active, Quattro la recherche automatiquement dans la (ou les) bibliothŠque(s) de macros ouverte(s) et l''ex‚cute','');
INSERT INTO Lexique VALUES ( 978,'BibliothŠque standard','JAVA','Les bibliothŠques standard regroupent les fonctions les plus courantes, et mettent ces fonctions … disposition sous une forme homogŠne','');
INSERT INTO Lexique VALUES ( 979,'BiCaPiTaLiSaTiOn','','Le fait d''‚crire le nom d''une marque commerciale en utilisant diff‚rentes casses, sans raison apparente, comme dans NeXT, PostScript, ou TeX (dans ce dernier cas, le ®e¯ est mˆme en indice)','');
INSERT INTO Lexique VALUES ( 980,'Bichromie','CAO','Reproduction d''une image imprim‚e en 2 couleurs','');
INSERT INTO Lexique VALUES ( 981,'Bidirectionnel','','S''‚crit aussi ®Bi-Directionnel¯. Se dit d''un canal de communication permettant d''‚changer des informations simultan‚ment dans les 2 sens. Synonyme de Duplex. Contraire: Simplex, Unidirectionnel','');
INSERT INTO Lexique VALUES ( 982,'Bidirectionnel','PRN','Se dit des Imprimantes ‚tant capables d''imprimer de gauche … droite aussi bien que de droite … gauche. C''est le cas des imprimantes Matricielles ou … impact. Contraire: Unidirectionnel','');
INSERT INTO Lexique VALUES ( 983,'Bidouillage','Coder','Le fait de Bidouiller, une Bidouille','');
INSERT INTO Lexique VALUES ( 984,'Bidouille','Coder','®La bidouille¯. Programmation pas du tout Robuste, crado, pas document‚e, mais fonctionnant, parfois','');
INSERT INTO Lexique VALUES ( 985,'Bidouille ®Une bidouille¯','','Petit bout de Programme, petite r‚alisation technique, permettant d''obtenir des r‚sultats avec peu de moyens. Synonyme de Kluge. Exemple: remplacer un jumper par un morceau d''aluminium. Dans ce cas, le terme n''est pas p‚joratif','');
INSERT INTO Lexique VALUES ( 986,'Bidouiller','Coder','Programmer en utilisant des Bidouilles','Bitouille');
INSERT INTO Lexique VALUES ( 987,'Bidouilleur','Coder','Programmeur employant des m‚thodes de travail peu orthodoxes, incompr‚hensibles par quelqu''un d''autre que lui, puisqu''il ne documente jamais son code. Naturellement, celui-ci devient rapidement un r‚bus pour lui aussi. S''il peut r‚soudre de petits problŠmes, il ne peut pas travailler en groupe. Quand quelqu''un traite un individu de bidouilleur, c''est p‚joratif. Quand on se traite soi-mˆme de bidouilleur, cela ne l''est plus du tout...','');
INSERT INTO Lexique VALUES ( 988,'Bi-Endian','','Caract‚ristique des machines sachant stocker les Donn‚es aussi bien en Big Endian qu''en Little Endian','');
INSERT INTO Lexique VALUES ( 989,'Big 8','NTW','Les 8 principales hi‚rarchies mondiales de Newsgroups: Alt, Soc, Rec, Sci, Comp, talk, humanities et misc','');
INSERT INTO Lexique VALUES ( 990,'Big Blue','','Abr‚viation de Big Blue est le surnom d''IBM, par r‚f‚rence d''une part … Big Brother, ‚tant le personnage inqui‚tant d''Orwell dans ®1984¯, et d''autre part … la taille et la couleur du logo de l''entreprise','Bill Brother');
INSERT INTO Lexique VALUES ( 991,'Big Brother','','Personnage d''Orwell dans 1984: il s''agit du dictateur omnipr‚sent et omnipotent. L''affreux a inspir‚ quelques surnoms peu flatteurs, comme Big Blue ou Bill Brother','');
INSERT INTO Lexique VALUES ( 992,'Big Endian','','Description d''une fa‡on (parmi d''autres) dont on stocke les nombres dans plusieurs Octets: l''octet de poids fort est stock‚ avant l''octet de poids faible. Utilis‚ sur la famille des 680x0 de Motorola, c''est la fa‡on habituelle de voir un nombre. Oppos‚ … Little Endian. En fran‡ais: Gros-Boutiste. La r‚f‚rence aux Voyages de Gulliver, d‚couvrant un monde o— deux peuples s''affrontent … mort pour savoir par quel bout on doit ouvrir un oeuf dur, est tout … fait voulue','');
INSERT INTO Lexique VALUES ( 993,'Bignum','','Contraction de ®BIG NUMber¯. Grand nombre, c''est-…-dire contenant pas mal de chiffres. Habituellement, les ordinateurs sont capables de traiter des nombres grands, mais relativement petits du point de vue du nombre de leurs chiffres, traditionnellement, les valeurs maximals sont 2 … la 31 (2 147 483 648) ou 2 … la 15 (32 768). Il est donc n‚cessaire d''‚crire des programmes ou des bibliothŠques de fonctions particuliŠres pour obtenir une pr‚cision aussi grande que n‚cessaire','');
INSERT INTO Lexique VALUES ( 994,'Bigot','','Personne pour laquelle un sujet donn‚ ne procŠde que de dogmes. Un bigot est prompt … provoquer une Guerre de Religion','');
INSERT INTO Lexique VALUES ( 995,'Bilip','SON','Variante de Beep … consonnance un peu plus francophone','');
INSERT INTO Lexique VALUES ( 996,'Bill Brother','','Bill Brother est le surnom de Gates Bill, bas‚ sur la r‚f‚rence litt‚raire de Big Brother, … comparer avec Big Blue pour IBM. Mais ici, ce n''est pas tant la taille du monstre ‚tant important, mais l''omnipr‚sence et l''omnipotence (apparentes) de Microsoft','');
INSERT INTO Lexique VALUES ( 997,'Bill Gates','','Une des 2 personnes ayant fond‚ Microsoft. Actuel pr‚sent de cette mˆme Multi-National. Il est l''homme le plus riches des tats-Unis. De nombreuses personnes le considŠrent comme le diable et d''autre comme un ®Dieu¯, lequel est-il?','');
INSERT INTO Lexique VALUES ( 998,'Billou','','Surnom du PDG de Microsoft, Bill Gates. Cela semble affectueux, comme pour un animal familier, et c''est vrai qu''il est constamment pr‚sent chez vous dans votre micro si vous avez un PC! Parfois orthographi‚ ®Bilou¯','');
INSERT INTO Lexique VALUES ( 999,'Bin','','Abr‚viation de ®binary¯. Le nom du r‚pertoire contenant des fichiers ex‚cutables, c''est-…-dire exprim‚s en code binaire uniquement compr‚hensible par la machine et non pas en code Source','');
INSERT INTO Lexique VALUES (1000,'Bin','UNIX','Fichier contenant du code Ex‚cutable','');
INSERT INTO Lexique VALUES (1001,'BINAC','','Abr‚viation de BINary Automatic Computer. HISTOIRE: L''un des 1iers ordinateurs, mis au point par W. Eckert et J. Mauchly dans les ann‚es 1960','ENIAC');
INSERT INTO Lexique VALUES (1002,'Binaire','Coder','SystŠme … base num‚rique binaire, synonyme de systŠme binaire. Dans la pratique, un fichier est dit binaire s''il ne peut ˆtre interpr‚t‚ que par des applications bien pr‚cises','');
INSERT INTO Lexique VALUES (1003,'Binariser','','Transformer un ensemble de donn‚es num‚riques relativement complexes en informations Binaires. Par exemple, le fait de binariser une image en 256 couleurs la transformera en noir et blanc. Comparer … Num‚riser','');
INSERT INTO Lexique VALUES (1004,'Binary','Coder','Mot d''origine anglaise, synonyme de Binaire','');
INSERT INTO Lexique VALUES (1005,'Binary file','','Mot d''origine anglaise, synonyme de Fichier Binaire','');
INSERT INTO Lexique VALUES (1006,'Bincancel','NTW','Annulation d''un message contenant un fichier binaire. Sur Usenet, il est en effet interdit de poster ce genre de messages dans les groupes n''ayant pas express‚ment ‚t‚ mis en place pour cela (comme la hi‚rarchie alt.binaries.*)','');
INSERT INTO Lexique VALUES (1007,'BIND','INTERNET','Abr‚viation de Berkeley Internet Name Domain. Impl‚mentation d''un Domain Name Server (voir DNS) r‚alis‚e par l''universit‚ de Berkeley','BSD');
INSERT INTO Lexique VALUES (1008,'Binder','','Synonyme de Linker. Un binder est un programme rassemblant des parties de programmes converties de fa‡on ind‚pendante, avec des bibliothŠques systŠme et des bibliothŠques utilisateurs, pour aboutir … un programme en ‚tat de fonctionner','');
INSERT INTO Lexique VALUES (1009,'','','','');




          Binette NTW Version francophone de Smiley propos‚e par l'OLF.

          Binhex APPLE Abr‚viation de Binary Hexadecimal. M‚thode de codage de donn‚es binaires pour les 
          transformer en ASCII, afin de pouvoir les faire passer, par exemple, dans du Courrier lectronique. On trouve 
          de plus en plus ce format sur les PC.

          Biobreak NTW Terme employ‚ par les Netsurfers pour indiquer qu'ils doivent satisfaire des besoins 
          naturels, et donc s'‚loigner de leur Clavier. Voir aussi AFK, BRB.

          Bioinformatique Discipline de la biologie sp‚cialis‚e dans le traitement en masse des donn‚es
          issues d'exp‚riences de biologie.

          Biom‚trie Mesure du corps humain. En g‚n‚ral … des fins d'authentification ou d'identification 
          (empreintes digitales, r‚tiniennes...). Il est possible de num‚riser des empreintes digitales, expression qui 
          embˆte tous ceux confondant volontairement les termes digital et num‚rique...

          BION Abr‚viation de Believe It Or Not. ®Croyez-le ou non¯.

          Bionique Discipline n‚e de la fusion entre la biologie et l'lectronique.

          BIOS Abr‚viation anglaise de Basic Input Output System. Zone de m‚moire mort d'un ordinateur. Regroupement
          de disposition et de fonctions de base pour la communication avec le systŠme. IBM Cette m‚moire s'‚tend des 
          cellules de F000:C000 ou F000:E000 … F000:FFFF. Codes de base pour faire fonctionner la machine l'hors du 
          d‚marrage de l'ordinateur.

          BIOS-DOS Dos Mots utiliser pour d‚signer la partie permettant de g‚rer les p‚riph‚riques. Le Bios-Dos 
          ne doit pas ˆtre confondu avec le BIOS en ROM proprement dit. Il contient les pilotes de p‚riph‚rique gŠrant 
          pour le Dos l'accŠs aux p‚riph‚riques tels que le clavier, l'‚cran, la disquette,...

          Bios RAM IBM Zone de m‚moire situ‚ entre les adresses 0040h:00h et 0040h:FFh inclusivement. Cette 
          r‚gion est destin‚ … garder les donn‚es variable du Bios.

          Biotronique Ensemble des technologies diverses (Informatique, lectronique, Robotique, 
          microtechniques) utilis‚es en conjonction pour r‚parer le corps humain.

          Bip SON Variante de Beep … orthographe un peu plus francophone.

          Biprocesseur HDW Se dit d'un Ordinateur utilisant 2 Processeurs centraux, la plupart des machines 
          n'en ayant qu'un (c'est donc sans compter les Coprocesseurs, souvent beaucoup moins puissants, et qui 
          s'occupent exclusivement de certaines fonctions).

          B-ISDN NTW Abr‚viation de Broadband ISDN. ISDN … large bande. Voir ISDN.

          Biseau Coder Le composant biseau (Bevel) vous permet d'ajouter des lignes ou des cadres biseaut‚s dans 
          les fiches de votre application.

          Bit Coder Abr‚viation d'origine anglaise Binairy digit. Valeur binaire ne pouvaut connaŒtre que 2 ‚tats: 0 
          (out) ou 1 (in). Le bit est la plus petite unit‚ d'information trait‚e par l'ordinateur. ş PRN Transmission … 
          l'imprimante de 'paquet' de 8 bits qu'on appelle un octet.

          Bit d'arrˆt COM En transmission arythmique, signal suivant un caractŠre et pr‚pare l'unit‚ 
          r‚ceptrice … recevoir le caractŠre suivant. Il est g‚n‚ralement sp‚cifi‚ comme la dur‚e d'un intervalle 
          d'unit‚.

          Bit (de) d‚marrage COM C'est le 1ier envoy‚ lorsque l'UART veut envoyer un octet de donn‚es. 
          Le bit de d‚marrage indique sans ambigu‹t‚ au r‚cepteur l'arriv‚e d'un ensemble de bits de donn‚es. C'es 
          normalement un espace ou un bit 0.

          Bit (de) d‚part COM Synonyme de Bit (de) d‚marrage.

          Bit (de) parit‚ COM Un bit de parit‚ est un bit suppl‚mentaire ‚tant ajout‚ … un octet de donn‚es
          transmis. G‚n‚ralement, le bit de priorit‚ vaut 0 ou 1 pour forcer l'octet de donn‚es … avoir un ensemble 
          impair ou pair de bits de donn‚es mis … 1, d'o— les termes ®parit‚ impaire¯ et ®parit‚ paire¯. Ce bit 
          suppl‚mentaire permet au r‚cepteur de d‚tecter une erreur sur un bit individuel.

          Bit (de) start COM Synonyme de Bit (de) d‚marrage.

          Bit (de) stop COM Ce bit est normalement envoy‚ par un UART pour terminer un octet de donn‚es. Ce 
          bit est g‚n‚ralement un bit de ®marque¯ ou un bit 1. Il est utilis‚ pour s‚parer des caractŠres cons‚cutifs et
          simplifier la resynchronisation.

          BitBlt Windows Abr‚viation de BIT-boudary BLock Transfert (transfert de bloc … frontiŠre quelconque). 
          Cette fonction de GDI copie des motifs rectangulaires de bits d'un endroit quelconque vers un autre. L'emploi 
          le plus courant de cette routine est le d‚placement de fenˆtres sur l'‚cran. Elle sert ‚galement … faire 
          apparaŒtre rapidement les menus. Les programmes d'application peuvent utiliser cette fonction pour d‚placer 
          des images sous forme de bitmaps vers une p‚riph‚rique de sortie comme l'‚cran ou une imprimante. Il est aussi
          possible de copier une image … partir d'un ‚cran vers une bitmap.

          BitFAT IBM DOS FAT particuliŠre utilis‚e sur les disques durs compress‚s en ligne, n‚cessaire pour 
          remplacer la FAT normale car les enregistrements sur le disque n'ont plus une longueur constante. La BitFAT, 
          sp‚cifique au CVF de MS-DOS 6, indique quels secteurs sont utilis‚s dans l'espace des fichiers comprim‚s.

          Bitmap Mots d'origine anglaise utiliser par Windows est un image graphique compos‚e par un certain 
          nombre de points par pouce. ş M‚moire de trame stockant chaque point de l'‚cran sous la forme d'un bit pour 
          les ‚crans monochromes ou de 2 … 8 bits pour les ‚crans couleur.

          Bitmap OS2 Repr‚sentation d'une image par un tableau de bits. Le logo OS/2 utilis‚ sur ce systŠme est un
          exemple de repr‚sentation en mode bitmap.

          Bitmap Windows Coder C'est une des 2 pseudo-p‚riph‚riques utilis‚s par GDI pour conserver des images 
          (l'autre est un m‚tafichier). Les bitmaps conservent les images rectangulaires en m‚moire. On cr‚e une bitmap 
          en appelant GDI pour allouer la m‚moire n‚cessaire. Une fois allou‚e, une bitmap procure une surface de dessin
          invisible sur laquelle un programme peut dessiner en appelant n'importe quelle routine de GDI. C'est ‚galement
          une ressource permettant … un programme de conserver une image graphique dans un fichier ex‚cutable. Le 3iŠme 
          type de bitmap est constitu‚ par les bitmaps ind‚pendantes des p‚riph‚riques (DIB) permettant de conserver des
          informations de couleur ind‚pendamment des caract‚ristiques d'une p‚riph‚rique.

          BITNET Abr‚viation de Because-It's-Time-NETwork. R‚seau cr‚‚ par Ira Fuchs en 1981, d‚di‚ … la 
          recherche, reliant 2 000 organismes dans 38 pays, financ‚ au d‚part par la NSF et IBM, pour relier les gros 
          centres de calcul de Big Blue. On y utilise principalement des listes de diffusion. L'‚quivalent europ‚en est
          EARN (European Academic Research Network).

          BITNIC Abr‚viation de BITNET Network Information Center. Voir BITNET.

          Bitouille Litt‚ralement "touiller des bits". Propos‚ par M. Dubesset. Bidouille logicielle.

          Bit Rate COM Quantit‚ moyenne de bits transitant sur un R‚seau. C'est une mesure de son d‚bit. Les 
          quatre variantes ABR (Available Bit Rate), UBR (Unspecified Bit Rate), CBR (Constant Bit Rate) et VBR 
          (Variable Bit Rate) sont utilis‚es sous ATM pour sp‚cifier l'utilisation que l'on fait du r‚seau.

          BitsPerPixel Coder Terme d'origine anglaise utilis‚ pour d‚signer le nombre de Bit requis pour 
          m‚moriser un pixel.

          Bits Par Secondes (bps) COM Une unit‚ de mesure, commun‚ment utilis‚e pour mesurer la 
          vitesse de signalisation. G‚n‚ralement, ce chiffre est utilis‚ pour indiquer les capacit‚s de d‚bit maximum 
          d'un m‚dium.

          Bit Tax Voir Taxe … l'Octet.

          Bit-Wise Comparaison de 2 valeurs Bit par bit.

          BIX Abr‚viation de Byte Information eXchange. Le r‚seau de service en ligne du magazine am‚ricain Byte. On 
          y trouve des smilies d'un type ‚trange, comme: (@_@) (repr‚sentant ici deux yeux et une bouche). Ces smilies 
          s'appellent des ®Bixies¯.

          BK! Abr‚viation de BacKup. Fichier, g‚n‚r‚ automatiquement en g‚n‚ral, contenant une ancienne version d'un 
          document. Voir Backup, BAK.

          Black Hole Voir Trou Noir.

          Black-Monday IBM Virus informatique.

          Blank Line Ligne blanche, une ligne vide, ne contenant rien, ou … la rigueur seulement des espaces.

          BL Abr‚viation de BoŒte … Lettres lectronique. Voir BAL.

          Bleu Se dit des produits d'IBM, d'aprŠs la couleur du logo de cette entreprise. Se dit aussi des produits 
          con‡us pour les systŠmes IBM par des soci‚t‚s tierces.

          Blindage Fil m‚tallique entourant un dispositif ‚lectronique pour ‚viter les parasites, et pour 
          pouvoir par exemple de ce fait ‚couter la radio tout en travaillant sur son ordinateur.

          Blinder quiper une Puce ou un Cƒble d'une gaine m‚tallique pour l'empˆcher de produire des parasites 
          ou d'ˆtre sensible … des parasites ‚lectromagn‚tiques.

          Blinker IBM Virus informatique.

          Blip SON Variante de Beep … consonnance un peu plus francophone.

          Blitter HDW Puce con‡ue pour acc‚l‚rer le traitement des images Bitmap, mais cette voie est d‚sormais 
          abandonn‚e. L'Amiga et l'Atari STE en avaient ‚t‚ pourvus.

          BLKEND IBM Coder Dans le cas d'un fichier objet, cette identificateur de code 7Ch d‚signe une fin de 
          bloc d'enregistrement.

          BLKIN Coco3 Coder Abr‚viation de "BlockInput". Demande au Coco 3 de lire un bloc … partir d'une cassette.

          BLKLEN Coco3 Coder Signifie "BlockLength", est situ‚ en 70h et contient le nombre d'octets de donn‚es 
          dans le bloc (0 … 255) dans le cas d'une machine … cassette.

          BLKOUT Coco3 Coder Signifie "BlockOutput" et que le Coco 3 ‚crit un bloc … partir d'une cassette.

          BLKREC IBM Coder Dans le cas d'un fichier objet, cette identificateur de code 7Ah d‚signe une d‚finition
          de bloc d'enregistrement.

          BLKTYP Coco3 Coder Signifie "BlockType", est situ‚ en 7Ch et contient le type de bloc dans le cas de 
          lecture d'information sur une machine … cassette.

          BLOB Abr‚viation de Binary Large Object. Peut contenir des donn‚es non format‚es telles que des graphiques
          ou du texte sans limite th‚orique. Un BLOB est une extension du modŠle relationnel standard ne fournissant 
          habituellement que les types de donn‚es de longueur fixe. Le type BLOB est analogue … un fichier ordinaire; 
          les donn‚es BLOB peuvent y ˆtre stock‚es dans n'importe quel format (par exemple, binaire ou ASCII). 
          Cependant, un BLOB n'est pas un fichier s‚par‚. Les donn‚es BLOB sont enregistr‚es dans la base comme toutes 
          les autres donn‚es. Comme elles contiennent en g‚n‚ral des donn‚es en quantit‚ ‚lev‚e et variable, les 
          colonnes BLOB sont enregistr‚es et extraites segment par segment.

          BLOB Objet tridimentionnel utilis‚ en imagerie de synthŠse et obtenu par la d‚formation mutuelle de sphŠre
          s'attirant ou se repoussant. En fait, c'est complŠtement impossible … d‚crire, et mˆme … imaginer quand on 
          cherche … en cr‚er un.

          Bloc Coder Un bloc est compos‚ de d‚clarations, ‚crites ou combin‚es dans un ordre quelconque, et 
          d'instructions. Chaque bloc est contenu dans une d‚claration de proc‚dure, de fonction, de programme, d'unit‚ 
          ou de bibliothŠque. Tous les identificateurs et ‚tiquettes (labels) d‚clar‚s dans la partie d‚claration d'un 
          bloc sont locaux … ce bloc. La syntaxe g‚n‚rale pour un bloc quelconque est la suivante:
          ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
          ³  bloc ÄÄÄÄÄÄ> ÛpartieÛd‚clarationsÛ ÄÄÄÄÄÄÄÄ> ÛpartieÛinstructionsÛ ÄÄÄÄÄÄÄÄÄ>                             ³
          ³  partie d‚clarations ÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄ>         ³
          ³                        ^ ÃÄ> partieÛd‚clarationÛdesÛ‚tiquettesÛ(labels) ÄÄÄÄÄÄÄÄÄÄÄ>^    ³                 ³
          ³                        ³ ÃÄ> partieÛd‚clarationÛdesÛconstantes  ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ>³    ³                 ³
          ³                        ³ ÃÄ> partieÛd‚clarationÛdesÛtypes ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ>³    ³                 ³
          ³                        ³ ÃÄ> partieÛd‚clarationÛdesÛvariables ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ>³    ³                 ³
          ³                        ³ ÃÄ> partieÛd‚clarationÛdesÛproc‚duresÛetÛfonctions ÄÄÄÄÄÄÄ>³    ³                 ³
          ³                        ³ ÃÄ> clauseÛexports ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ>³    ³                 ³
          ³                        ³ ÀÄ> partieÛchaŒneÛressource ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ    ³                 ³
          ³                        ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ                 ³
          ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

          Bloc SEX Sur un disque, ensemble de secteurs, aussi appel‚ Cluster.

          Bloc TABLEUR Groupe de cellules de forme rectangulaire, d‚limit‚ par les adresses de deux de ses angles 
          oppos‚s (g‚n‚ralement sup‚rieur gauche et inf‚rieur droit) - par exemple, A1..B4. La taille d'un bloc varie 
          d'uen seule cellule … une feuille de calcul entiŠre.

          Blocage CODER quivalent du mot anglais Deadlock. Un deadlock intervient si deux ou plusieurs 
          utilisateurs sont en attente les uns des autres pour la lib‚ration des verrous. Les DBMS avanc‚s ‚vitent ce 
          type de blocages, et interrompent automatiquement les transactions s'uils se produisent.

          Blocage de fichier NTW D‚signation d'un File lock.

          Bloc d'environnement IBM Dos Terme pour d‚signer l'attribution a chaque programme d'un bloc
          d'environnement dont l'adresse est inscrite dans le PSP du programme. Le bloc d'environnement se compose d'une
          s‚quence de chaŒnes ASCII contenant diff‚rentes informations telles que le chemin de recherche des fichiers 
          (PATH), par exemple.

          Block Mots d'origine anglaise d‚signant un ensemble de caractŠre transmis comme ‚tant un bloc ou un 
          ensemble.

          Blockbuster INTERNET Site Web connaissant un fort succŠs et collectionnant les millions de Hits. 
          Exemples: Alta Vista, Yahoo.

          Bloc nomm‚ TABLEUR N'importe quel bloc auquel a ‚t‚ affect‚ un nom. La liste des blocs nomm‚s peut 
          ˆtre consult‚e sous forme de simple liste ou de table (liste alphab‚tique des noms assortie des coordonn‚es de
          blocs).

          Bloc-notes OS2 Repr‚sentation graphique ressemblant … un carnet reli‚. Les pages du bloc-notes sont 
          s‚par‚es par des intercalaires munis d'onglets facilitant le passage d'une page … une autre. En s‚lectant un 
          onglet, vous ouvrez le bloc-notes … la page d‚crite par le libell‚ de l'onglet.

          Bloc r‚ponse TABLEUR Dans une base de donn‚es, Bloc destin‚ … recevoir la copie des enregistrements
          r‚pondant aux critŠres de recherche.

          Blocs d'entr‚e et de sortie TABLEUR Dans le cadre de la fragmentation des libell‚s, 
          bloc d'entr‚e d‚signe la colonne contenant le texte … fragmenter et la (ou les) ligne(s) de format, et bloc de
          sortie le bloc auquel sont destin‚es les donn‚es fragment‚es.

          Bloc source et destination TABLEUR Dans le cadre d'une copie, le bloc source est le 
          bloc … copier et le bloc destination celui ‚tant destin‚ … recevoir la copie.

          Bloquant UNIX Caract‚rise un Tube empˆchant la poursuite d'un des Processus auxquels il est associ‚. 
          Le tube permet alors la Synchronisation des processus.

          Bloqu‚ Se dit d'un processus attendant un ‚v‚nement ext‚rieur pour pouvoir continuer de fonctionner. Ses
          autres ‚tats possibles sont Prˆt et lu.

          BLOS Coder Abr‚viation de Branch if Lower Or Same.

          Blue Book Format de CD. D‚finit le CD-Extra. Un CD-Extra contient 2 sessions, l'une pour la piste 
          audio et l'autre pour la piste de donn‚es. Cette piste est invisible pour un lecteur Audio.

          Blue Box SystŠme ‚lectronique proche du Modem et permettant d'appeler plus ou moins erratiquement un 
          num‚ro de t‚l‚phone. Cela sert, soit … ennuyer les gens, soit … appeler exhaustivement des num‚ros afin de 
          tomber par hasard sur quelque chose d'int‚ressant, dans ce cas pour Pirater ou d‚couvrir des BBS non 
          officiels. Steve Jobs et Steve Wozniak (® Woz ¯) ont commenc‚ leur carriŠre en bricolant et en vendant de tels
          systŠmes, avant de poursuivre plus honnˆtement en concevant l'Apple II. La Blue Box fut ensuite remplac‚e par 
          la Beige Box. Il y a toutes sortes d'autres types de ® boxes ¯, selon leur usage: voir Colored Box.

          Blue Boxing Le fait d'utiliser une Blue Box.

          Bluelist INTERNET L'inverse d'un Blacklist, selon certains Spammeurs.

          Blue Ribbon INTERNET Voir Ruban Bleu.

          Blue Screen Ou BSOD. Quand le Windows de Microsoft plante, il propose un bel ‚cran tout bleu. Voir 
          GPF.

          BMP Abr‚viation anglaise de BitMaP. Format de fichier de dessin … la structure ‚l‚mentaire utilis‚ par 
          Windows ou OS/2. Permettant des images ayant jusqu'… 16 millions de couleurs.

          BNC Abr‚viation de Bayonet Neill-Concelman connector. Type de Connecteur, en ba‹onnette (rendant la 
          connexion solide, mais surtout peuvent ˆtre branch‚s et d‚branch‚s bien plus rapidement que les connecteurs 
          se vissant), pour cƒble coaxial thin Ethernet, fin, pour r‚seau ou pour branchement de moniteur vid‚o. Pour un
          moniteur, il en faut 5 pour les 3 couleurs plus la synchronisation horizontale et verticale ; il pr‚sente 
          l'avantage d'ˆtre isol‚ jusqu'… son extr‚mit‚ contrairement … un connecteur de type D-sub. Il peut ‚galement 
          servir … relier un ou deux moniteurs raccord‚s en chaŒne sur une seule unit‚ centrale, pour les entr‚es de 
          signaux vid‚o, un cƒble par signal : rouge, vert, bleu, synchronisation verticale et horizontale ; 
          malheureusement, le moniteur ne supporte alors plus les sp‚cifications Plug-and-Play.

          BNF Abr‚viation de Backus-Naur Form. M‚thode de description de la syntaxe d'un Langage formel, con‡ue 
          d'abord par J. W. Backus puis par P. Naur. Elle a ‚t‚ utilis‚e pour la 1iŠre fois pour sp‚cifier le langage 
          ALGOL. Exemple classique, ici issu du Jargon File 3.0.0:
          ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
          ³ <adresse>::=<nom> <rue> <ville> .                                                                          ³
          ³ <nom>::=<pr‚nom> <nom-de-famille> <EOL> | <statut-civil> <pr‚nom>                                          ³
          ³ <nom-de-famille> <EOL> .                                                                                   ³
          ³ <rue>::= [<apt>] [<bat>] <num‚ro> <nom-de-rue> <EOL> .                                                     ³
          ³ <ville>::= <code-postal> <nom-de-ville> <EOL> .                                                            ³
          ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
          Une adresse est donc compos‚e d'un nom, d'une rue et d'une ville. Un nom est compos‚ soit d'un pr‚nom et d'un 
          nom, soit d'un statut civil (Madame, Mademoiselle, Monsieur, etc.) d'un pr‚nom et d'un nom. Un nom est 
          toujours termin‚ par une fin de ligne. Une rue est compos‚e de 2 ‚l‚ments optionnels, un num‚ro d'appartement 
          et un identifiant de bƒtiment, puis doit contenir un num‚ro de rue, une virgule, un nom de rue et se termine 
          par une fin de ligne. Enfin, la ville est un code postal suivi du nom de la ville et d'une fin de ligne. La 
          BNF a ‚t‚ largement ‚tendue depuis ses d‚buts, reprise par exemple pour les Base de Donn‚es avec leurs 
          c‚lŠbres formes normales num‚rot‚es de 1 … 3, voire 5 pour les sp‚cialistes, et peut maintenant utiliser la 
          R‚cursion ainsi que divers symboles et Wildcards. On rencontre aussi la FBN et la FNB, ‚tant 2 VF.

          BNQ Abr‚viation de Bureau de Normalisation du Qu‚b‚c.

          Board Terme utilis‚ pour parler familiŠrement des BBS (Bulletin Board System). Voir Babillard. Utilis‚ 
          ‚galement pour Carte.

          Bob Voir Alice et Bob.

          BOC Abr‚viation de Bell Operating Company. Voir RBOC.

          Body Version anglaise de Corps. Ici, c'est le corps du message, se situant entre l'En-Tˆte et la 
          Signature.

          Bodyscanning Num‚risation du corps humain.

          BOF Abr‚viation de Begining Of File. D‚but de Fichier.

          BOF Abr‚viation de Birds Of a Feather... ® Qui se ressemble... ¯.

          BOF Un ® Birds Of a Feather ¯ (flocking together) est un groupe de discussion informel cr‚‚ pour r‚soudre 
          un petit problŠme ponctuel dans un groupe de travail.

          Bogue Version fran‡aise de Bug.

          BoŒte Rectangle utilis‚ pour afficher des informations. BoŒte Flexible: boŒte dimensionnable, dont on 
          peut modifier les dimensions. D'une maniŠre g‚n‚rale, une boŒte est un ‚l‚ment graphique plus ou moins 
          rectangulaire.

          BoŒte (d')Alerte BoŒte servant … pr‚venir l'Utilisateur qu'il est en train de faire une 
          connerie... Exemple: D‚clencher la IIIŠme guerre mondiale.

          BoŒte Blanche Un ®d‚bogage en BoŒte Blanche¯ est effectu‚ en connaissant parfaitement les 
          sp‚cifications internes du systŠme … d‚verminer, contrairement … la BoŒte Noire.

          BoŒte (de) dialogue Fenˆtre affich‚e automatiquement par un programme; elle peut afficher une
          information ou demander des donn‚es compl‚mentaires. Synonyme de Formulaire. QUATTRO_PRO Boite que Quattro Pro
          propose pour diverses op‚rations. C'est une alternative aux menus, notamment pour les graphiques et 
          l'impression.

          BoŒte (de) dialogue Windows Fenˆtre dans laquelle se trouvent d'autres fenˆtres appel‚es 
          contr“les de boŒtes de dialogues. Utilis‚e g‚n‚ralement pour obtenir davantage d'informations de l'utilisateur
          pour compl‚ter une commande.

          BoŒte (de) dialogue (contr“le de) Windows Fenˆtre r‚sidant dans une boŒte de 
          dialogue et destin‚e … accomplir certains services: boutons-poussoirs, boutons radio, boŒtes … liste, barres 
          de d‚filement, statiques.

          BoŒte (de) dialogue (coordonn‚es d'une) Windows Moyen ind‚pendant des 
          p‚riph‚riques de sp‚cifier l'agencement d'une boŒte de dialogue. Les unit‚s de boŒtes de dialogue sont 
          relatives aux dimensions de la police systŠme ou d'une autre police d‚finie pour ˆtre utilis‚e dans la boŒte 
          de dialogue.

          BoŒte (…) Lettres Voir BAL. Normalement, on devrait dire ® BoŒtes aux lettres ¯.

          BoŒte Noire Dispositif dont on connaŒt parfaitement la fonction et l'utilisation, mais dont le 
          fonctionnement interne n'est pas cens‚ concerner l'utilisateur. Un ®d‚bogage en boŒte noir¯ se fait sans que 
          l'on connaisse le fonctionnement interne du systŠme. Voir BoŒte Blanche.

          BoŒte (…) Outils Ensemble d'Outils, g‚n‚ralement con‡us pour fonctionner les uns avec les 
          autres, d'une fa‡on compl‚mentaire. En anglais : Toolbox. Une boŒte … outils peut ˆtre constitu‚e de petits 
          bidules bricol‚s par vous-mˆme depuis que vous avez d‚couvert la programmation, ou ˆtre une collection trŠs 
          structur‚e d'objets sp‚cifi‚s formellement par une multinationale...

          BoŒte (…) peindre Coder Le composant boŒte … peindre (PaintBox) permet … votre application de 
          dessiner sur la fiche dans une zone rectangulaire pr‚d‚finie. Par cons‚quent, il est impossible de dessiner en
          dehors des limites de la boŒte … peindre.

          BoŒte (…) Pizza Forme de certains BoŒtier d'ordinateur, ultra-plats, essentiellement ceux de 
          certains Macs. Voir Tour, Mini-Tour. ş Stations Sun, modŠles SparcStation.

          BoŒte (…) Riz HDW Clone d'un ordinateur, fabriqu‚ en Asie.

          BoŒtier central HDW C'est la partie … laquelle l'utilisateur n‚ophyte s'int‚resse le moins et 
          pourtant c'est l… que sont situ‚s les organes vitaux... Le boŒtier central comprend les ‚l‚ments suivants (la 
          liste n'est pas exhaustive mais comprend le ®minimum vital¯): la carte mŠre, le contr“leur des lecteurs de 
          disquettes, le(s) lecteur(s) de disquettes, l'alimentation.

          Bombe n.f. Affich‚es en nombre plus ou moins grand par les Atari ST et les Macintoshs lorsqu'ils 
          plantent. quivalent de la ®guru m‚ditation¯ de l'Amiga, ou du Panic d'Unix. Et de rien du tout sous DOS ou 
          Windows, ‚tant incapables de d‚tecter proprement leurs erreurs de fonctionnement!! Voir aussi Planter.

          Bombe Logique Petit bout de programme ins‚r‚ par un utilisateur dans un logiciel ou un systŠme 
          d'exploitation pour tout foutre en l'air si jamais il est licenci‚... La Bombe Logique est normalement con‡ue 
          pour se d‚clencher en fonction d'‚v‚nements bien pr‚cis, la Bombe Temporelle en ‚tant un cas particulier.

          Bombe Temporelle Voir Time Bomb.

          BonD COM Abr‚viation BandWidth On Demand. Bande passante attribu‚e … la demande, voir BWOD.

          Bookmark INTERNET D'une maniŠre g‚n‚rale, signe indiquant un passage digne d'int‚rˆt, sur lequel on 
          veut revenir par la suite. Cela peut ˆtre utilis‚ dans toutes sortes de documents, en particulier les sites 
          Web ou les fichiers d'aide en ligne. Dans ces derniers cas, le Signet a la forme d'un ensemble d'informations 
          indiquant o— se trouve le passage int‚ressant (URL), ainsi que son nom. En fran‡ais, on doit dire Marque-Page 
          pour traduire Bookmark, mais personne ne le fait, lui pr‚f‚rant le synonyme Signet.

          Bookware Logiciel livr‚ avec (ou mˆme dans) un livre. Bref, pour une fois, on a de la documentation. 
          Mais cette documentation n'est pas forc‚ment de qualit‚, pire encore, le bouquin ne correspond pas toujours au
          logiciel...

          BOOLEAN Coder Terme d'origine anglaise indiquant un type de variable de langage Pascal permettant 2 
          valeurs True ou False. Ce type prend un octet de m‚moire dans les compilateurs Turbo Pascal et Borland Pascal.

          Boole George (1815-1864) Math‚maticien Britannique du XIX	Š	m	e siŠcle, cr‚ateur au XIX	Š	m	e siŠcle de 
          la logique moderne portant son nom (logique Bool‚enne), aussi appel‚e ®AlgŠbre de Boole¯ ou AlgŠbre Bool‚enne.
          Voir Bool‚en.

          Bool‚en MATH adj. Relatif … la logique de Boole George.

          Bool‚en n. m. Type de donn‚e classique, ne pouvant prendre que 2 valeurs, 0 et 1, ou Vrai et Faux, par 
          exemple. Voir Boole George. Tout ceci n'a rien … voir avec la p‚tanque. Contraire: Flou, Fuzzy. Les anglais 
          ‚crivent toujours l'adjectif avec une majuscule (rien que pour pas faire comme nous, comme d'habitude).

          Bool‚enne Coder Terme indiquant une variable ne pouvant prendre que 2 valeurs: vrai (True) et faux 
          (False). En Pascal, un variable de type Boolean est stock‚e sur un octet.

          Boorne shell Unix Shell le plus fr‚quemment utilis‚, appel‚ comme son auteur, Steven R. Bourne. La 
          plupart des scripts fournis avec le systŠme Unix sont ‚crits dans le langage de programmation du Bourne Shell.
          Pour commencer un Bourne Shell … partir de la ligne de commande, taper sh et appuyez sur (Entr‚e).

          Booster vt. Acc‚l‚rer grandement la vitesse d'ex‚cution d'un Programme, d'une machine ou d'une 
          p‚riph‚rique.

          Booster n. m. Dispositif permettant d'acc‚l‚rer un systŠme, en particulier dans les plaquettes de pub 
          et les sites web de mauvais go–t.

          Boot Dos Terme d'origine anglaise utilis‚ pour d‚signer les op‚rations de chargement du Bios. Savoir 
          ‚l‚mentaire transmis … l'ordinateur … la mise sous tension de la machine. Le processus de boot comporte 
          ‚galement la recherche d'un systŠme d'exploitation sur une m‚moire de masse (disque), d'abord sur l'unit‚ 
          logique A, puis sur le disque dur si A n'est pas en service.

          Bootable adj. Caract‚rise un disque sur lequel on peut Booter.

          Boot CD Format de CD. On commence … voir apparaŒtre des CD bootables (par exemple Windows NT 4.0). Les 
          nouvelles versions de BIOS contiennent une option permettant le d‚marrage … partir d'un CD-ROM. En ins‚rant le
          CD, vous pouvez travailler comme s'il s'agissait d'une disquette de d‚marrage. Mais ce d‚veloppement n'en est 
          encore qu'… ses d‚buts.

          Boot Drive Mots d'origine anglaise d‚signant le disque sur lequel le systŠme d'exploitation … lancer 
          le systŠme d'exploitation. D‚signation de booter.

          Booter Mots d'origine anglaise d‚signant un lancement de systŠme d'exploitation. D‚signation de 
          l'op‚ration de d‚marrage de l'ordinateur, au cours de laquelle le Bios teste puis initialise tout d'abord les 
          diff‚rents ‚l‚ments du systŠme, aprŠs quoi le systŠme d'exploitation est charg‚ et lanc‚.

          Booter Unix Terme d'origine anglaise d‚signant l'action de se charger sur le serveur.

          BOOTP n. m. Abr‚viation de Bootstrap Protocol. Protocole permettant … un client d'interroger un Serveur 
          pour savoir quelle est son Adresse IP en fonction de son adresse mat‚rielle sur le r‚seau. Souvent utilis‚ 
          pour permettre … des stations Sans Disque de booter et d'ˆtre automatiquement configur‚es.

          Boot Sector Premier secteur d'un disque sur lequel se trouve le Bootstrap, petit programme 
          ex‚cutable permettant de lancer un programme plus gros (en g‚n‚ral le SE). On peut utiliser la VF Secteur de 
          D‚marrage sans risque d'ˆtre incompris.

          Bootstrap n. m. Terme quasi-syst‚matiquement abr‚g‚ en Boot. Il sera donc de bon ton d'aller voir par
          l… si la d‚finition y est.

          Border IBM Virus informatique.

          Borland  Compagnie de logiciel informatique pour IBM sp‚cialit‚ dans les compilateurs et les langages 
          de programmation. Les plus connus des compilateurs sont: Turbo Pascal, Borland Pascal, Delphi, Turbo C, Turbo 
          C++, Borland C++ et Turbo Basic. Partiellement renomm‚e ®Inprise¯ en 1998.

          Borne Interactive Dispositif permettant de fournir des informations au public, … une bande de 
          sauvages d‚g‚n‚r‚s qui feront tout pour tout bousiller en quelques heures. La borne ne pr‚sente donc qu'un 
          ‚cran tactile macul‚ de taches de gras, dans une boŒte en m‚tal blind‚e … l'int‚rieur de laquelle est cach‚ un
          ordinateur.

          BOS Abr‚viation de Basic Operating System.

          Boss Key GAME Touche ou Combinaison de Touches permettant de passer rapidement … une fausse Feuille de 
          Calcul ou … un faux Traitement de Texte, quand on est en train de jouer sur son lieu de travail, et permettant
          donc de ne pas se faire piquer … rien glander... Ouh, les vilains! Synonyme de Panic Key.

          Bot COM Abr‚viation de Batch Oriented Task. C'est aussi l'abr‚viation de Robot. Ce genre de bidule logiciel
          vous permet d'ex‚cuter des actions relativement complexes, en particulier effectuer des recherches dans des 
          Base de Donn‚es sur un r‚seau, ou bien de surveiller un canal de l'IRC.

          Bouchon de Terminaison COM Dispositif physique (une r‚sistance pour Ethernet par exemple) 
          permettant de terminer une liaison dans un r‚seau local.

          Boucle Coder Terme pour indiquer une op‚ration it‚rative poursuivit jusqu'… ce qu'une condition soit 
          satisfaite.

          Boucle For Coder Boucle d‚finie par l'instruction classique For, permettant d'ex‚cuter un bloc de 
          programme un nombre pr‚d‚termin‚ de fois. Ce nombre est d‚termin‚ lors de l'entr‚e dans la boucle, et 
          normalement, on ne doit pas le changer. videmment, les bidouilleurs adorent faire des trucs du genre:
          ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
          ³    For i=1 to 10                                                                                           ³
          ³         i <- i + 1                                                                                         ³
          ³         print i                                                                                            ³
          ³    Next i                                                                                                  ³
          ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
          Voir aussi Next.

          Boucle Infinie Coder On trouve aussi ®Boucle Sans Fin¯. Boucle ne se terminant jamais, du moins 
          tant qu'on ne coupe pas le courant, que la machine fonctionne encore et que la Terre tourne autour du Soleil. 
          Une blague courante … chaque nouvelle g‚n‚ration de Superordinateur est de dire que le tout nouveau modŠle 
          ex‚cutera une boucle infinie en moins de 3,5 secondes.

          Boucle Sans Fin Coder Synonyme de Boucle Infinie.

          Bouclier DOS n. m. Programme (r‚sident en m‚moire sous DOS) destin‚ … empˆcher les intrusions sur un 
          systŠme, en particulier celles des Virus.

          Bouffer D‚truire des donn‚es, en les faisant myst‚rieusement disparaŒtre. Voir Bousiller. Exemple: Word
          m'a encore bouff‚ 10 pages … l'impression!

          Bounce INTERNET ®Rebondir¯. Quand vous envoyez un message sur le r‚seau Internet, et que le destinataire
          est introuvable, il est probable que votre message rebondira, donc vous reviendra avec la mention ®User 
          unknown¯ (utilisateur inconnu), ou pire: ®Host unknown¯ (H“te inconnu).

          Bounding Box Objet tridimentionnel simple englobant un autre objet plus compliqu‚, afin d'acc‚l‚rer
          le calcul d'une Image de SynthŠse. En effet, si en Raytracing on ne rencontre pas la bounding box, il est 
          inutile de tester la pr‚sence de l'objet complexe. Synonyme: ®Bounding Shape¯. Aussi utilis‚ dans les fichiers
          EPS.

          Bourne-Shell UNIX Nom d'un Shell con‡u par Monsieur Bourne pour Unix, en particulier dans le SVr4.
          Voir aussi C-Shell, Korn-Shell.

          Bourrage PRN n. m. v‚nement se produisant quand on n'a pas ®D‚ram‚¯ un paquet de feuilles (qu'on ne 
          s'est pas assur‚ qu'elles ‚taient bien d‚tach‚es les unes des autres), et qu'on l'a donn‚ … manger … une 
          Imprimante. AprŠs, c'est tout en bordel … l'int‚rieur de la machine (et si la machine est grosse, il faut 
          faire venir un Maintenancien). Autres causes possibles de bourrage: papier humide, trop fin ou trop ‚pais.

          Bourrin Se dit d'un SystŠme particuliŠrement lent, lourd, et ne fesant pas dans la dentelle. Utilise 
          souvent la Force Brute et l'ignorance massive.

          Bousiller D‚truire des donn‚es, ou, plus souvent, un mat‚riel, en g‚n‚ral par inadvertance. Voir 
          Flinguer, Griller.

          Bouton n. m. Widget permettant d'activer une fonction d'un logiciel, ou de basculer d'un ‚tat … un autre
          (par exemple pour une option pouvant ˆtre vraie ou fausse). La diff‚rence entre un bouton et une Ic“ne est que
          le bouton porte du texte, tandis que l'ic“ne porte un dessin (Picto). Dans un ensemble de boutons ®radio¯, un 
          seul bouton peut-ˆtre s‚lectionn‚ … la fois.

          Bouton OS2 Dispositif d'une p‚riph‚rique de pointage (tel qu'une souris) permettant de lancer une 
          op‚ration ou zone d'un ‚cran d'ordinateur servant … lancer une action. Voir aussi bouton d'agrandissement, 
          bouton de masquage, plaquette, bouton de restauration et s‚lecteur rotatif.

          Bouton agrandissement Bouton situ‚ … l'extr‚mit‚ droite de la barre de titre d'une 
          fenˆtre.

          Bouton d‚marrer Situ‚ dans la barre des tƒches, il permet d'acc‚der aux diff‚rents programmes.

          Bouton fermer Bouton situ‚ dans la barre de titre d'une fenˆtre ou d'une boŒte de dialogue. Il 
          permet de fermer la fenˆtre ou la boŒte de dialogue.

          Bouton (de) masquage OS2 Bouton situ‚ dans la partie sup‚rieure droite de la barre de titre 
          d'une fenˆtre. S‚lectez ce bouton pour faire disparaŒtre de l'‚cran toutes les fenˆtres associ‚es … la fenˆtre
          affich‚e. Les titres de ces fenˆtres se trouvent dans la Liste de fenˆtres. S'oppose … bouton 
          d'agrandissement. Voir aussi bouton de restauration.

          Bouton r‚duction Bouton situ‚ … l'extr‚mit‚ droite de la barre de titre d'une fenˆtre; un clic 
          sur ce bouton affiche la fenˆtre en taille moyenne: la fenˆtre pourra alors ˆtre d‚plac‚e ou redimensionn‚e.

          Bouton (de la) rŠgle OS2 Bouton permettant de d‚placer l'index de la rŠgle dans la direction 
          indiqu‚e par la flŠche, l'incr‚ment ‚tant de un. Lorsque le bouton ne comporte pas de flŠche, il est 
          impossible de d‚placer l'index dans cette direction. Voir aussi rŠgle et index de la rŠgle.

          Bouton (de) restauration OS2 Bouton situ‚ dans le coin sup‚rieur droit de la barre de 
          titre d'une fenˆtre ayant ‚t‚ agrandie … sa taille maximale. Le boutaon de restauration permet de ramener la 
          fenˆtre … ses dimensions pr‚c‚dentes. Voir aussi bouton d'agrandissement et bouton de masquage.

          Bouton (de la) souris OS2 Dispositif de la souris sur lequel l'utilisateur appuie pour 
          s‚lecter des options ou ex‚cuter une op‚ration.

          Bouzine n. f. pop. Synonyme de ®Machine¯, avec une nuance affective malgr‚ une lourdeur certaine. Une 
          grosse Imprimante est une bouzine, un Calculateur des ann‚es 1950 aussi. Voir aussi Babasse.

          Boxel n. m. Synonyme rare de Voxel.

          Boxologie n. f. p‚j. tude des boŒtes. Les informaticiens sont friands des boŒtes, des carr‚s, des 
          ronds, avec des flŠches dans tous les sens, ce qui n'‚claire pas le sujet mais le rend au contraire un peu 
          plus confus, car chacun a sa propre fa‡on d'interpr‚ter ®le rond avec une flŠche vers le carr‚¯. Voir 
          Certangle.

          BP COM Abr‚viation de Bande Passante.

          BPB IBM Coder Abr‚viation du terme anglais Bios Parameter Block. Bloc de paramŠtre du Bios d‚finissant le 
          format et la structure d'une m‚moire de masse (disquette ou disque dur). ş Bloc inscrit dans le secteur boot 
          de toute m‚moire de masse mais il doit aussi ˆtre communiqu‚ au Dos par le routine d'initialisation d'un 
          pilote de p‚riph‚rique de bloc.

          BPDF Abr‚viation de Bon PŠre De Famille. L'acheteur moyen de Windows95, il est heureux, et n'y comprend en
          g‚n‚ral absolument rien. Mais comme il a un ordinateur sur son bureau et que son patron veut qu'il l'utilise, 
          il s'en est achet‚ un.

          bpi Abr‚viation de Bits Per Inch. Mesure de la densit‚ d'informations stock‚es sur un support, souvent un 
          Disque, bpp en fran‡ais.

          bpp Abr‚viation de Bit Par Pouce. Mesure de la densit‚ d'informations stock‚es sur un support, souvent un 
          Disque, bpi en anglais.

          BPM Abr‚viation de Battements par minute. Unit‚ de mesure de la rapidit‚ d'une musique. Le BPM en Techno va
          usuellement de 115 … 160 (Il peut monter jusqu'… 1000, mais il faut l'entendre pour le croire! Et ‡a fait du 
          bien quand ‡a s'arrˆte...).

          BPR Abr‚viation de Business Process Reegineering.

          bps COM Abr‚viation de Bit par seconde. Voir Baud, Modem, Wpm.

          BR COM Abr‚viation de Bit Rate. Voir ABR, CBR, UBR, VBR.

          BR Abr‚viation de Bus Request. Demande de Bus.

          BR WINDOWS95 Abr‚viation Base de Registre. Voir Registre, Registry.

          Branchement Coder n. m. Arrˆt de l'Ex‚cution lin‚aire et s‚quentielle d'un Programme, pour la 
          continuer en un autre endroit. Synonyme Saut.

          Branch prediction M‚thode de pr‚diction de calcul invent‚ par Digital en d‚but des ann‚es 
          1990. Cette technologie fut ‚galement enprunt‚ ill‚galement par la soci‚t‚ Intel pour sa s‚rie de micro- 
          processeur Pentium.

          Bras HDW n. m. Abr‚viation de courante de Bras d'AccŠs.

          Bras d'AccŠs HDW C'est le support des Tˆtes de lecture et d'‚criture dans les Disques. 
          G‚n‚ralement, le mˆme bras porte les 2 tˆtes; sinon, c'est une chose rare et curieuse...

          Brassage COM n. m. Interconnexion de lignes (on branche des cƒbles ensemble en quelque sorte).

          Brasser COM Interconnecter des lignes.

          Brasseur HDW COM n. m. Appareil r‚alisant l'Interconnexion des lignes t‚l‚phoniques.

          BRB Abr‚viation de Be Right Back. ® Je reviens *tout* de suite¯.

          Break Arrˆt du systŠme. Fin d'un Processus suite … une erreur, ou … une interruption de l'utilisateur 
          (l'important est que ce n'est pas la fin normale du processus et qu'en g‚n‚ral, on peut le relancer par la 
          suite).

          Breakout GAME L'un des 1iers grands succŠs de l'industrie du jeu sur ordinateur. C'est un Casse- 
          Briques. Fabriqu‚e par Atari. Exemple-type du ®frigidaire¯ informatique.

          Breakpoint Coder Mots d'origine anglaise d‚signant Point d'arrˆt pour un d‚bugage.

          B-Rep CAO Abr‚viation d'origine anglaise Boundary Representation. Technique de mod‚lisation volumique 
          permettant de repr‚senter un objet par un ensemble de surfaces d‚limitant celui-ci.

          Bretelle  COM n. f. Voie d'accŠs permettant de se connecter sur un r‚seau.

          BRI COM Abr‚viation de Basic Rate Interface. La version de base du RNIS, avec 2 canaux B (soit 128 Kbps). 
          Voir PRI.

          Brid‚ adj. Se dit d'une Version d'un Logiciel ne comportant pas toutes les fonctions du logiciel 
          original. En g‚n‚ral distribu‚e … des fins de test ou de D‚mo. Voir Crippleware.

          Bridge NTW Mots d'origine anglaise d‚signant une passerelle entre 2 r‚seaux utilisant le mˆme protocole 
          de communication.

          Bridge-Router  COM Version anglaise de Pont-Routeur.

          Brin COM Le Fil d'une discussion, voir Fil de Discussion. Synonyme Enfilade. En anglais Thread #2. Brin 
          n'est pas utilis‚ en France.

          BroadBand NTW Mots d'origine anglaise d‚signant un terme en opposition … basehand. ş Connexion de 
          r‚seau permettant le passage de plusieurs canaux d'informations. Le broadband est g‚n‚ralement compar‚ au 
          cƒble de t‚l‚vision permettant le passage de plusieurs canaux.

          Broadcast NTW Mots d'origine anglaise se r‚f‚rant … l'information. Qualifie la qualit‚ d'un 
          enregistrement sonore ou vid‚o. Si la qualit‚ broadcast est atteinte, on a quelque chose de professionnel que 
          l'on peut le diffuser … la radio ou … la t‚l‚vision.

          Brochage HDW n. m. Configuration des Pattes d'une puce ou d'une connexion (d'une prise avec des 
          bitonios et/ou des trous). Les brochages les plus affolants sont ceux des processeurs: entre 150 et 320 
          pattes!

          Broche HDW n. f. Patte d'une puce, ‚l‚ment d'un Brochage.

          Broken As Design Expression utilis‚e pour d‚signer les produits ne fonctionnant pas tout 
          simplement parce qu'ils ont semblent con‡us dans ce but... Exemple: Windows 95.

          Broker Voir la VF, Courtier. Voir aussi ORB.

          Brosse Voir pinceau.

          Brothers IBM Virus informatique.

          Bromure CAO Terme de m‚tier d‚signant une ‚preuve de contr“le tir‚e sur papier photographique (dit 
          papier au bromure).

          Brooks La loi de Brooks dit que: ®Le fait d'ajouter des gens … un projet logiciel en retard le retarde 
          encore davantage¯.

          Brouteur COM n. m. Rien … voir avec un animal broutant. Pont-Routeur, niveau 2 OSI pour le Pont et 3 
          pour le Routeur. Voir aussi Pont-Routeur. En anglais: Bridge-Router. Certains utilisent ce terme pour d‚signer
          un Browser.

          Browser COM Version anglaise courante pour Navigateur.

          Broyeur OS/2 Sorte de d‚chiqueteuse virtuelle, utilis‚e par OS/2 … la place de la Poubelle de Windows; 
          il est ‚vident (?) qu'IBM ne peut pas utiliser le mˆme vocabulaire que Microsoft.

          Bruit CAO Ph‚nomŠne parasitaire se superposant … un signal et modifie le r‚sultat de la transmission de 
          l'information. En traitement d'images, ces perturbations peuvent ˆtre att‚nu‚es par une ‚tape de restauration.

          Bruit COM n. m. Information sans int‚rˆt. Exemple: Le gouvernement a d‚cid‚ que.... Il faut bien 
          ‚videmment ‚viter de faire du Bruit, par exemple en ‚vitant de r‚pondre aux provocations. Voir Bruiter, 
          Rapport S/B.

          Bruiter COM Faire du Bruit (parler pour ne rien dire, ou pire, pour dire n'importe quoi).

          Br–lage n. m. M‚saventure arrivant … un cran de mauvaise qualit‚ quand vous le laissez allum‚ trop 
          longtemps avec une intensit‚ lumineuse trop forte. La couche phosphorescente se trouvant dans le tube est 
          ®br–l‚e¯. D'o— l'int‚rˆt des conomiseur d'cran (mˆme si maintenant au milieu des ann‚es 1990, les ‚crans 
          sont nettement plus performants qu'il y a quelques ann‚es). Ce terme est aussi utilis‚ pour le fait de Br–ler 
          une EPROM.

          Br–ler HDW Dans l'expression ®br–ler une ROM¯, ‚crire des donn‚es dans cette m‚moire (les donn‚es y 
          resteront et ne pourront pas ˆtre chang‚es). La ROM en question peut ˆtre une EPROM, une EEPROM, une PROM ou 
          un CD-ROM.

          Br–ler COM Dans l'expression ®br–ler une adresse¯, couper le lien entre l'adresse et un terminal.

          Br–leur HDW n. m. Appareil permettant de Br–ler une m‚moire.

          Brute Voir Force Brute.

          BSA Business Software Alliance. Organisme de lutte contre le piratage r‚unissant de nombreuses entreprises 
          du logiciel exc‚d‚es de ne pas ˆtre encore plus riches. ®Cette quˆte de l'interdit (le piratage) est ni plus 
          ni moins qu'un comportement d'obs‚d‚! (...) C'est un comportement de pervers.¯ Gilles August, avocat de BSA.

          BSA Bidouilleurs Sans Argent.

          BSC NTW Binary Synchronous Communication. En fran‡ais: Communication Synchrone Binaire. Proc‚dure de 
          contr“le de chaŒnon de donn‚es, de type caractŠre, synchrone … alternat, point … point et multipoint. 
          (Je ne sais plus o— j'ai repˆch‚ cette d‚finition).

          BSC IBM Protocole propre … IBM, datant d'avant SNA.

          BSD Abr‚viation de Berkeley System (ou Software) Distribution. L'universit‚ de Berkeley est connue dans le 
          monde Unix pour les nombreux logiciels qu'elle a d‚velopp‚ puis mis dans le domaine public. BSD d‚signe en 
          particulier une famille de versions d'Unix issue de l'universit‚ de Berkeley en Californie, con‡ue pour le VAX
          de DEC et le PDP-11, qui a ‚t‚ ensuite port‚e sur les PC sous le nom :386BSD, puis de FreeBSD. D'autres 
          Impl‚mentations existent, voir NetBSD, OpenBSD. Pendant longtemps, Berkeley et sa version de Unix furent … la 
          pointe du milieu, avec l'introduction de nombreuses nouvelles fonctionnalit‚s (vi, le C-Shell...) et beaucoup 
          de grands constructeurs ont bas‚ leur propre version sur celui-ci. Ou Berzerkeley Software Distribution. ®To 
          berzerk¯ (ou ®berserk¯) signifie ®devenir fou au combat¯ en anglais.

          BSI IBM Abr‚viation Boot Sector Infector. Virus infectant le secteur de Boot d'un disque. 

          BSI Abr‚viation de British Standard Institution. Organisme national de standardisation anglais. Cousin de 
          l'AFNOR et de l'ANSI. Membre de l'ISO.

          BSOD Windows Blue Screen Of Death. L'‚cran bleu de la mort, indiquant que votre Windows vient probablement
          de planter.

          B-spline CAO Mots d'origine anglaise d‚signant la m‚thode de repr‚sentation de surfaces gauches par 
          approximation et constituant une g‚n‚ralisation et une extension de la m‚thode Bezier. Elle se diff‚rencie de 
          cette derniŠre par le fait que lors d'une modification, la surface n'est perturb‚e qu'au voisinage du point 
          modifi‚.

          BT COM Abr‚viation de British Telecom. Op‚rateur de T‚l‚communications britannique.

          BTM IBM Dos Fichier Batch charg‚ en m‚moire utilis‚ par 4Dos et NDOS.

          B-Tree Coder Abr‚viation Balanced Tree. Arborescence permettant de stocker des Index. L'arbre est 
          ‚quilibr‚, c'est-…-dire qu'il comprend le mˆme nombre de niveaux dans chaque branche; une recherche dans ce 
          type d'arbre a donc toujours la mˆme dur‚e; il a ‚t‚ invent‚ par un certain Bayer.

          BTW COM Abr‚viation de By The Way. ®(Oh!) Par la mˆme occasion...¯. Voir OBTW.

          Bubble Jet PRN Nom donn‚ par Canon … la technologie du Jet d'Encre.

          Budgetx NTW Serveur de banque de donn‚e Belge.

          Buffer Mots d'origine anglaise d‚signant la m‚moire dans laquelle est stock‚e provisoirement 
          l'information. ş Synonyme de … Tampon.

          Bufferiser Doter un flux d'entr‚es-sorties d'un Buffer.

          Bug Mots d'origine anglaise d‚signant une punaise ou vermine, francis‚ en bogue. Fait allusion aux 
          insectes, dans les premiŠres g‚n‚rations d'ordinateurs, se logeant dans les circuits ‚lectroniques et y 
          provoquaient des courts-circuits. ş Terme d‚signant les erreurs de programmation provoquant des anomalies de 
          fonctionnement, ‚ventuellement l'arrˆt anormal de la machine.

          Bug (du) Pentium Humour: Un produit industriel ayant la complexit‚ d'un Processeur moderne 
          contient in‚vitable de petites erreurs de conception. Les premiŠres versions du pentium d'Intel contenaient un
          bug, dont le sympt“me ‚tait de se tromper dans certaines divisions au niveau de la 6 ou 7Šme d‚cimale. 
          videmment, ce type d'erreur est tout … fait n‚gligeable en pratique (sauf pour ceux effectuant des calculs 
          scientifiques), mais certains puristes s'en sont ‚mus, en particulier via l'Internet. L'erreur d'Intel fut de 
          tenter de minimiser l'affaire, ce qui mit en colŠre pas mal de monde, et tout naturellement d'innombrables 
          blagues sur l'incapacit‚ des Pentiums … diviser certains nombres ont suivi. Voir 586.

          Bugfix Une correction d'un Bug, d'une erreur, souvent sous la forme d'une Mise … Jour.

          Bugg‚ Se dit d'un programme contenant des Bugs, ne fonctionnant pas, plantant tout le temps, ‚tant donc 
          nul, et le terme est souvent p‚joratif. Humour: Synonyme ®PremiŠre version d'un logiciel Microsoft¯.

          Bull Constructeur d'ordinateurs fran‡ais, ayant r‚guliŠrement chang‚ de nom au fil du temps. En ce moment,
          c'est Bull tout court, du nom de son fondateur norv‚gien et non d'un quelconque bison am‚ricain. Ses machines 
          sont en g‚n‚ral de bonne qualit‚, mais le c“t‚ commercial n'a jamais suivi. Le groupe informatique est 
          d‚sormais trŠs li‚ au japonais NEC. Voir GCOS, Micral. Le logo de l'entreprise est un arbre, ce qui fait dire 
          … certains qu'il a probablement ‚t‚ choisi parce que les ordinateurs du constructeur se plantent 
          r‚guliŠrement... Cela semble aussi ˆtre un chˆne, peupl‚ de glands... Voir Planter.

          Bulle Coder Voir Tri Bulles.

          Bulle Voir Bulle d'Aide, Infobulles.

          Bulle d'Aide Widget apparaissant quand un autre widget obtient le Focus, et donnant un petit texte 
          d'explication. C'est trŠs utiles pour d‚terminer la raison d'ˆtre de telle ou telle ic“ne au pictogramme 
          herm‚tique. Sur le Mac, il s'agit carr‚ment de phylactŠres, comme dans les bandes dessin‚es (‚nervant, … 
          force). Synonyme Infobulle.

          Bump Mapping CAO Mots d'origine anglaise d‚signant une technique de placage de texture, utilis‚e en
          synthŠse d'image, permettant d'ajouter un relief … la texture.

          BUNCH Abr‚viation de Burroughs, Univac, NCR, Control Data, Honeywell. Les 5 grandes compagnies de 
          l'industrie informatique se partageant les miettes laiss‚es par IBM dans les ann‚es 1970. Bunch signifie ®la 
          bande¯, ®l'‚quipe¯ en anglais.

          Bundle Groupage de produits r‚alis‚ par le vendeur (ou l'‚diteur), … caractŠre g‚n‚ralement 
          promotionnel.

          Bureau C'est l'espace de travail, c'est-…-dire l'‚cran du micro-ordinateur sur lequel les programmes 
          sont affich‚s.

          Bureau OS2 Dossier de la taille de l'‚cran dans lequel sont stock‚s tous les objets permettant 
          d'effectuer des op‚rations sur le systŠme.

          Bureau Windows Fenˆtre recouvrant la totalit‚ de l'‚cran. Elle est situ‚e derriŠre les autres 
          fenˆtres du systŠme.

          Bureautique Informatique appliqu‚e au Bureau. ş Ensemble des techniques informatiques permettant de
          faire ex‚cuter par des machines tout ou une partie des tƒches manuelles de bureau.

          Burghofer IBM Virus informatique.

          Burst IBM HDW Regroupement de bits en une unit‚ sur laquelle l'accŠs est trŠs rapide. Le taux d'accŠs sur
          un Burst est en principe d‚finit dans le BIOS sous la forme d'une s‚rie de chiffres. Chaque chiffre repr‚sente
          le nombre de cycles n‚cessaires pour un accŠs Burst sur un bit. L'ensemble d‚termine le nombre de bits du 
          Burst. L'accŠs au 1ier bit est plus lent que les autres. Une valeur de 3-1-1-1 indique que le Burst se compose
          de 4 bits, que l'accŠs au 1ier n‚cessite 3 cycles de traitement et celui aux autres, un cycle seulement.

          Burst Mode COM M‚thode assurant une transmission continue des informations entre 2 ‚l‚ments d'un 
          ordinateur, et permettant (principalement) au processeur de recevoir les donn‚es sans Wait State. Utilis‚ en 
          particulier pour les p‚riph‚riques.

          Bus HDW Terme d'origine anglaise d‚signant l'ensemble des lignes transportant les signaux permettant au 
          microprocesseur de converser avec ses m‚moires internes et les p‚riph‚riques. Il existe divers types de bus 
          dont le bus de donn‚es, le bus de commandes, le bus des adresses, le bus d'entr‚/sortie.

          Bus NTW Terme d'origine anglaise se r‚f‚rant … la topologie de r‚seau.

          Bus (d')adresse Canal reliant l'unit‚ centrale … la m‚moire (RAM ou ROM). Lorsque l'unit‚ 
          centrale veux appeler une cellule de m‚moire, elle doit tout d'abord envoyer son adresse sur l'adresse pour 
          aiguiller le systŠme vers cette cellule de m‚moire.

          Bus AGP pour le 3D IBM HDW Les applications 3D se multiplient et se r‚pandent. Malheureusement, 
          le traitement des images 3D exige un ordinateur d'une grande puissance. Les PC "courants" ne sont pas assez 
          performants pour ces applications; le bus PCI notamment, dont le d‚bit th‚orique de 132 Mo par seconde, r‚duit
          en pratique de 40 Mo, est trop lent pour des images 3D anim‚es … haute r‚solution ou les animations 3D. Pour 
          trouver une solution, Intel et les principaux constructeurs de cartes graphiques ont d‚fini un nouveau bus 
          sp‚cifique aux cartes graphiques: AGP (Accelerated Graphics Port). Le bus AGP ne remplace pas le bus PCI, mais
          constitue un connecteur sp‚cifique pour la carte graphique utilis‚ en parallŠle avec le bus PCI. Il fonctionne
          … la fr‚quence du bus systŠme, c'est-…-dire … 66 MHz et est connect‚ au bus PCI. Ainsi, la bande passante est 
          ainsi environ 4 fois plus ‚lev‚e que celle du PCI (envrion 256 Mo par seconde), et peut mˆme ˆtre doubl‚e en 
          mode 2x. Un bus de ce type offre ainsi des r‚serves assez larges pour les applications 3D du futur. Un proc‚d‚
          ‚quivalent au Busmastering PCI permet l'‚change direct entre la carte et la m‚moire sans passer par le 
          processeur. AGP pr‚sente une autre particularit‚: les futurs cartes graphiques 3D seront moins co–teuses que 
          les cartes actuelles, en raison de l'‚conomie que permet de r‚aliser l'absence de m‚moire graphique 
          suppl‚mentaire pour les informations 3D ("Frame-buffer", "Z-buffer" et description des textures). Dans les 
          cartes 3D PCI, ces donn‚es doivent ˆtre enregistr‚es sur la carte elle-mˆme car les temps d'accŠs … la m‚moire
          vive du PC sont trop long pour ces donn‚es. La bande passante d'AGP est suffisamment large pour permettre 
          cette utilisation, au moins pour les modules de DRAM. Les cartes ne demanderont plus … ˆtre ‚quip‚es d'une 
          m‚moire 3D suppl‚mentaire. En outre, des textures plus nombreuses et plus fines pourront ˆtre enregistr‚es 
          dans la m‚moire vive au lieu de devoir se contenter des 2 … 4 Mo de m‚morie 3D des cartes graphiques. Le 
          couplage trŠs ‚troit entre AGP et PCI permettra ‚galement une bonne compatibilit‚ descendante trŠs importante 
          pour les transferts Busmaster entre les cartes PCI et la carte graphique AGP. Il faut ‚videmment que les 
          cartes vid‚o puissent ‚changer des donn‚es avec la carte graphique, … l'aide de DirectDraw. Vous vous demandez
          peut-ˆtre ce que ce bus apportera en pratique, et comment il sera g‚r‚ par les logiciels et le mat‚riel. Les 
          cartes graphiques poss‚dant une connexion AGP sont prˆtes chez la plupart des constructeurs, voire d‚j… sur le
          march‚. Le surco–t ne sera que d'environ 350 francs (70$), au d‚but. Le connecteur AGP est l‚gŠrement plus 
          petit qu'un connecteur PCI, en raison de sa structure plus compacte. La carte et le connecteur suppl‚mentaire 
          ne prendront docn que peu de place sur la carte mŠre. Le surcroŒt effectif de performance d‚pend beaucoup de 
          la carte mŠre (type de m‚moire, fr‚quence du bus systŠme,...) ainsi que de l'application, et en particulier de
          l'utilisation des fonctions 3D. Une carte AGP n'est qu'environ 10 … 15% plus rapide que son ‚quivalent PCI 
          pour les applications 2D normales. En outre, une carte mŠre avec un bus systŠme 66 MHz n'apporte pas beaucoup 
          plus de puissance. Il n'est donc pas trŠs rentable d'acheter ce type de carte mŠre et une nouvelle carte AGP. 
          Mais dŠs qu'il s'agit de 3D, AGP devient trŠs int‚ressant. Les performances maximales de ce bus ne seront 
          cependant r‚ellement atteintes qu'avec de nouvelles cartes mŠres, de nouveaux modules m‚moire, et de nouvelles
          applications. Le facteur d‚terminant dans tout cela sera une fr‚quence accrue du bus systŠme. La prise en 
          charge du standard AGP par le systŠme d'exploitation et par les constructeurs de cartes mŠres est 
          probl‚matique. Intel a ainsi tent‚ d'utiliser AGP pour promouvoir son processeur Pentium II (mais uniquement 
          avec le nouveau chipset 440LX) contre les tenants du socle ZIF 7 Pentium, et de mettre hors course la 
          concurrence d'AMD et autres. Ces concurrents fournissent dŠs la fin de 1997 leurs propres chipsets et cartes 
          mŠres compatibles AGP. La cons‚quence imm‚diate set que les prix ont baisser et que la technologie AGP est 
          disponible de maniŠre trŠs large.

          Bus (de) donn‚es Canal reliant l'unit‚ centrale … la m‚moire (RAM ou ROM). C'est … travers ce 
          canal que les donn‚es peuvent ˆtre transf‚r‚es de l'unit‚ centrale vers la m‚moire ou de la m‚moire vers 
          l'unit‚ centrale.

          Buse PRN n. f. Dispositif canalisant l'encre d'une Imprimante … Jet d'Encre, et crachant les petites 
          gouttelettes r‚alisant l'impression.

          Bus (de) Fond de Panier Bus situ‚ au fond d'un rack, sur lequel on branche tout le bazar 
          ‚tant devant (la Carte MŠre ‚tant positionn‚e verticalement). Et en plus, le bus principal est divis‚ en sous-
          bus, l'un pour les adresses, un autre pour les donn‚es et le dernier pour le contr“le de tout le bazar.

          Bus Local Bus utilis‚ pour les services n‚cessitant de gros tranferts, comme la vid‚o, pour lib‚rer le
          bus principal et acc‚l‚rer le fonctionnement de l'ordinateur.

          Butineur INTERNET Voir Navigateur.

          Bwana INTERNET Surnom du FAI Wanadoo.

          Bwanadoo INTERNET Surnom du FAI Wanadoo.

          BWL Abr‚viation de Bursting With Laughter. ®En train d'exploser de rire¯ (au cours d'une discussion en 
          direct).

          BWOD COM BandWidth On Demand. Bande passante attribu‚e … la demande, pour de courtes p‚riodes de temps, 
          afin de pouvoir faire face … des fluctuations de trafic … moindre co–t (on ne paye la bande passante que pour 
          la dur‚e pendant laquelle on l'a demand‚e).

          Byte Mots d'origine anglaise synonyme d'octet.

          Bytecode Coder Sorte de code Objet, interm‚diaire entre le Source et le binaire Ex‚cutable, utilis‚ en
          Java pour permettre un usage multi-plateforme de ce langage. Le code n'est donc pas directement compr‚hensible
          par le processeur, ceci pouvant provoquer certaines lenteurs. Le Bytecode est ex‚cut‚ dans une VM (Virtual 
          Machine).

          Byte-Code Coder Variante pour Bytecode.

          Bz2 Fichier contenant un document compress‚ en Bzip2.

          Bzip2 Logiciel de Compactage de donn‚es utilisant des statistiques pour obtenir un r‚sultat sans pertes 
          d'environ 20 … 30% meilleurs que le Zip. Extension de fichier associ‚e: Bz2.



