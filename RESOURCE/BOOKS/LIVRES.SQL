CREATE TABLE Livres (
   EditeurID    VARCHAR, // Num‚ro d'identification de l'‚diteur
   Annee        INTEGER, // Ann‚e de parution
   NombrePage   SMALLINT,// Nombre de page du livre
   Classe       BYTE,    // 16=Informatique
   Nom          VARCHAR, // Nom du livre
   NoEditeur    INTEGER, // Num‚ro de l'‚diteur
   NoAuteur     INTEGER, // Num‚ro de l'auteur
   Description1 VARCHAR, // Courte description du contenu du livre (premier paragraphe)
   Description2 VARCHAR, // Courte description du contenu du livre (deuxiŠme paragraphe)
   Liens        VARCHAR  // Lien vers un fichier
);

CREATE INDEX;

INSERT INTO Livres VALUES ('GM047',  -1,  -1, 16,
                           'Premiers pas en informatique',
                           100000000/*Marabout*/, 230000000/*Virga*/,
                           '',
                           '',
                           '');

INSERT INTO Livres VALUES ('MS107',  -1, -1, 16,
                           'Devenir champion de dBase III',
                           100000000/*Marabout*/, -1,
                           '',
                           '',
                           '');

INSERT INTO Livres VALUES ('MS111',1989, 576/* pages*/, 16,
                           'Devenir champion de programmation structur‚e et de GW-BASIC - Tome 1',
                           100000000/*Marabout*/, 100000000/*L‚opold Laurent*/,
                           'Le GW-Basic, quoique puissant, a ‚t‚ con‡u afin de mettre la programmation … la port‚e de tous. La m‚thode de programmation structur‚e pr‚conise une d‚marche logique et syst‚matique trŠs formative.',
                           'Cet ouvrage (dont voici le premier tome) est le fruit d''une longue exp‚rience p‚dagogique. Destin‚ aux non initi‚s, il offre la possibilit‚ de programmer correctement et sans peine. Une solution est propos‚e pour chaque exercice.',
                           '');

INSERT INTO Livres VALUES ('MS112',  -1, -1, 16,
                           'Devenir champion de MS-DOS',
                           100000000/*Marabout*/, -1,
                           '',
                           '',
                           '');

INSERT INTO Livres VALUES ('MS113',  -1, -1, 16,
                           'Devenir champion de Multiplan',
                           100000000/*Marabout*/, -1,
                           '',
                           '',
                           '');

INSERT INTO Livres VALUES ('MS114',  -1, -1, 16,
                           'Devenir champion de Turbo Pascal',
                           100000000/*Marabout*/, -1,
                           '',
                           '',
                           '');

INSERT INTO Livres VALUES ('MS115',  -1, -1, 16,
                           'Devenir champion de programmation structur‚e et de GW-BASIC - Tome 2',
                           100000000/*Marabout*/, 100000000/*L‚opold Laurent*/,
                           '',
                           '',
                           '');

INSERT INTO Livres VALUES ('MS116',  -1, -1, 16,
                           'Devenir champion des fonctions math‚matiques et financiŠres',
                           100000000/*Marabout*/, -1,
                           '',
                           '',
                           '');

INSERT INTO Livres VALUES ('MS120',  -1, -1, 16,
                           'Devenir Champion de Excel 3',
                           100000000/*Marabout*/, -1,
                           '',
                           '',
                           '');

INSERT INTO Livres VALUES ('MS634',  -1,  -1, 16,
                           'Programmer le Forth',
                           100000000/*Marabout*/, 220000000/*Robert Van Loo*/,
                           '',
                           '',
                           '');

INSERT INTO Livres VALUES ('MS669',  -1,  -1, 16,
                           'Le guide marabout du Macintosh',
                           100000000/*Marabout*/, 220000000/*Robert Van Loo*/,
                           '',
                           '',
                           '');

INSERT INTO Livres VALUES ('MS711',  -1,  -1, 16,
                           'Wordstar facile',
                           100000000/*Marabout*/, 230000000/*Virga*/,
                           '',
                           '',
                           '');

INSERT INTO Livres VALUES ('MS717',  -1,  -1, 16,
                           'MS Dos facile',
                           100000000/*Marabout*/, 230000000/*Virga*/,
                           '',
                           '',
                           '');

INSERT INTO Livres VALUES ('MS737',  -1,  -1, 16,
                           'Framework I & II facile',
                           100000000/*Marabout*/, 150000000/*Philippe Mercier*/,
                           '',
                           '',
                           '');

INSERT INTO Livres VALUES ('MS742',  -1,  -1, 16,
                           'Indispensable pour IBM PC et compatible (L'')',
                           100000000/*Marabout*/, 230000000/*Virga*/,
                           '',
                           '',
                           '');

INSERT INTO Livres VALUES ('MS756',  -1,  -1, 16,
                           'Turbo Pascal facile',
                           100000000/*Marabout*/, 150000000/*Philippe Mercier*/,
                           '',
                           '',
                           '');

INSERT INTO Livres VALUES ('MS762',  -1,  -1, 16,
                           'Organisez votre disque dur',
                           100000000/*Marabout*/, 230000000/*Virga*/,
                           '',
                           '',
                           '');

INSERT INTO Livres VALUES ('MS766',  -1,  -1, 16,
                           'Indispensable pour Wordstar (L'')',
                           100000000/*Marabout*/, 230000000/*Virga*/,
                           '',
                           '',
                           '');

INSERT INTO Livres VALUES ('MS769',  -1,  -1, 16,
                           'Aide-m‚moire de GW-Basic',
                           100000000/*Marabout*/, 230000000/*Virga*/,
                           '',
                           '',
                           '');

INSERT INTO Livres VALUES ('MS771',  -1,  -1, 16,
                           'Aide-m‚moire de MS-Dos',
                           100000000/*Marabout*/, 230000000/*Virga*/,
                           '',
                           '',
                           '');

INSERT INTO Livres VALUES ('MS790',  -1,  -1, 16,
                           'Wordperfect facile',
                           100000000/*Marabout*/, 230000000/*Virga*/,
                           '',
                           '',
                           '');

INSERT INTO Livres VALUES ('MS813',  -1,  -1, 16,
                           'Indispensable pour la micro-‚dition (L'')',
                           100000000/*Marabout*/, 230000000/*Virga*/,
                           '',
                           '',
                           '');

INSERT INTO Livres VALUES ('MS821',  -1, -1, 16,
                           'Paradox facile',
                           100000000/*Marabout*/, -1,
                           '',
                           '',
                           '');


INSERT INTO Livres VALUES ('MS828',  -1, -1, 16,
                           'Indispensable pour les Tools de Clipper',
                           100000000/*Marabout*/, -1,
                           '',
                           '',
                           '');

INSERT INTO Livres VALUES ('MS838',  1989,  291/*pages*/, 16,
                           'Les Grandes RŠgles de la programmation en BASIC',
                           100000000/*Marabout*/, 220000000/*Robert Van Loo*/,
                           'La programmation, une affaire de professionnels? Non! Grƒce … ce livre, vous pourrez, vous aussi, en assimiler facilement les grandes rŠgles. þ L''initiation: toutes les instructions expliqu‚es en d‚tail par de nombreux exemples. ',
                           'þ La construction, pas … pas, de programmes pratiques: calcul, traitement de texte, gestion de base de donn‚es. þ Des exercices progressifs pour maŒtriser les grandes techniques de programmation.',
                           '');

INSERT INTO Livres VALUES ('MS839',  -1, -1, 16,
                           'Dictionnaire Bilingue d''informatique',
                           100000000/*Marabout*/, 230000000/*Virga*/,
                           '',
                           '',
                           '');

INSERT INTO Livres VALUES ('MS844',  -1,  -1, 16,
                           'Framework I et II facile',
                           100000000/*Marabout*/, 150000000/*Philippe Mercier*/,
                           '',
                           '',
                           '');

INSERT INTO Livres VALUES ('MS851',  -1,  -1, 16,
                           'Aide-m‚moire de Turbo-Pascal',
                           100000000/*Marabout*/, 230000000/*Virga*/,
                           '',
                           '',
                           '');

INSERT INTO Livres VALUES ('MS853',  -1,  -1, 16,
                           'Aide-m‚moire de dBase III',
                           100000000/*Marabout*/, 230000000/*Virga*/,
                           '',
                           '',
                           '');

INSERT INTO Livres VALUES ('MS868',  -1,  -1, 16,
                           'Indispensable pour Macintosh',
                           100000000/*Marabout*/, 220000000/*Robert Van Loo*/,
                           '',
                           '',
                           '');

INSERT INTO Livres VALUES ('MS874',  -1, -1, 16,
                           'Mac - Works facile sur Macintosh',
                           100000000/*Marabout*/, -1,
                           '',
                           '',
                           '');

INSERT INTO Livres VALUES ('MS880',  -1, -1, 16,
                           'Nouveau dictionnaire de la micro-informatique',
                           100000000/*Marabout*/, -1,
                           '',
                           '',
                           '');

INSERT INTO Livres VALUES ('MS890',  -1, -1, 16,
                           'Rapidfile facile',
                           100000000/*Marabout*/, -1,
                           '',
                           '',
                           '');

INSERT INTO Livres VALUES ('MS899',  -1,  -1, 16,
                           'Framework III facile',
                           100000000/*Marabout*/, 150000000/*Philippe Mercier*/,
                           '',
                           '',
                           '');

INSERT INTO Livres VALUES ('MS900',  -1, -1, 16,
                           'dBase IV facile',
                           100000000/*Marabout*/, -1,
                           '',
                           '',
                           '');

INSERT INTO Livres VALUES ('MS908',  -1, -1, 16,
                           'Works facile sur PC',
                           100000000/*Marabout*/, -1,
                           '',
                           '',
                           '');

INSERT INTO Livres VALUES ('MS935',  -1, -1, 16,
                           'De dBase IV … dBase IV',
                           100000000/*Marabout*/, -1,
                           '',
                           '',
                           '');

INSERT INTO Livres VALUES ('MS941',  -1,  -1, 16,
                           'Aide-m‚moire des Virus',
                           100000000/*Marabout*/, 150000000/*Philippe Mercier*/,
                           '',
                           '',
                           '');

INSERT INTO Livres VALUES ('MS946',  -1, -1, 16,
                           'Aide-m‚moire de dBase IV',
                           100000000/*Marabout*/, -1,
                           '',
                           '',
                           '');

INSERT INTO Livres VALUES ('MS956',  -1, -1, 16,
                           'Mac - FileMaker II facile',
                           100000000/*Marabout*/, -1,
                           '',
                           '',
                           '');

INSERT INTO Livres VALUES ('MS959',  -1, -1, 16,
                           'Works pour Windows',
                           100000000/*Marabout*/, -1,
                           '',
                           '',
                           '');

INSERT INTO Livres VALUES ('MS964',  -1, -1, 16,
                           'Dictionnaire de la CAO et du graphisme',
                           100000000/*Marabout*/, -1,
                           '',
                           '',
                           '');

INSERT INTO Livres VALUES ('MS966',  -1, -1, 16,
                           'Dictionnaire des sigles informatiques',
                           100000000/*Marabout*/, 230000000/*Virga*/,
                           '',
                           '',
                           '');

INSERT INTO Livres VALUES ('MS968',  -1, -1, 16,
                           'Dictionnaire des t‚l‚communications',
                           100000000/*Marabout*/, -1,
                           '',
                           '',
                           '');

INSERT INTO Livres VALUES ('MS971',  -1, -1, 16,
                           'FoxPro 2.0 facile',
                           100000000/*Marabout*/, -1,
                           '',
                           '',
                           '');

INSERT INTO Livres VALUES ('MS974',  -1, -1, 16,
                           'Dictionnaire du synth‚tiseur et de la musique informatique',
                           100000000/*Marabout*/, -1,
                           '',
                           '',
                           '');

INSERT INTO Livres VALUES ('MS978',  -1, -1, 16,
                           'Programmation structur‚e sous dBase IV',
                           100000000/*Marabout*/, -1,
                           '',
                           '',
                           '');

INSERT INTO Livres VALUES ('MS994',  -1, -1, 16,
                           'Aide-m‚moire de dBase IV - Version 1.5',
                           100000000/*Marabout*/, -1,
                           '',
                           '',
                           '');
