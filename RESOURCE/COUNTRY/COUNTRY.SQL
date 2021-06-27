CREATE TABLE Country (
   ID                  WORD,
   CodePays            WORD,
   CodePage            WORD,
   Abrev               VARCHAR,
   Pays                VARCHAR,
   Icone               BLOB,
   CodeFormatDate      BYTE,
   NombreChiffreGroupe BYTE,
   Config1             BYTE,
   TimeType            BYTE,
   Config2             BYTE,
   Config3             BYTE,
   Config4             BYTE,
   Config5             BYTE,
   Config6             BYTE,
   AmString            VARCHAR,
   PmString            VARCHAR,
   Currency            VARCHAR,
   ThSep               CHAR,
   DecSep              CHAR,
   DateSep             CHAR,
   TimeSep             CHAR,
   ParaSep             CHAR,
   FormatDateShort     VARCHAR,
   FormatDateLong      VARCHAR
);

CREATE INDEX;

INSERT INTO Country VALUES (  100,    27,  437,'ENU','Afrique du Sud',               '\SOURCE\CHANTAL\RESOURCE\COUNTRY\AFRICSUD.ICO',0,0,2,1,0,1,2,0, 0,      '',  '',  '$',   ',', '.','/',':',',','M/d/yy',      'dddd, MMMM dd, yyyy');
INSERT INTO Country VALUES (  200,   213,  437,'ENU','AlgÇrie',                      '\SOURCE\CHANTAL\RESOURCE\COUNTRY\ALGERIE.ICO', 0,0,2,1,0,1,2,0, 0,      '',  '',  '$',   ',', '.','/',':',',','M/d/yy',      'dddd, MMMM dd, yyyy');
INSERT INTO Country VALUES (  300,    49,  850,'DEU','Allemagne',                    '\SOURCE\CHANTAL\RESOURCE\COUNTRY\ALLEMAGN.ICO',1,3,2,1,1,0,2,8, 1,      '',  '',  'DM',  '.', ',','.',':',';','dd.MM.yyyy',  'dddd, d. MMMM yyyy');
INSERT INTO Country VALUES (  310,    61,  437,'ENU','Anglais International',        '',                                             0,0,2,1,0,1,2,0, 0,      '',  '',  '$',   ',', '.','/',':',',','M/d/yy',      'dddd, MMMM dd, yyyy');
INSERT INTO Country VALUES (  400,    44,  437,'ENG','Angleterre',                   '\SOURCE\CHANTAL\RESOURCE\COUNTRY\ANGLETER.ICO',1,0,2,1,1,0,2,1, 1,      '',  '',  '£',   ',', '.','/',':',',','dd/MM/yy',    'dd MMMM yyyy');
INSERT INTO Country VALUES (  500,     3,  437,'ENU','AmÇrique Latine',              '',                                             0,0,2,1,0,1,2,0, 0,      '',  '',  '$',   ',', '.','/',':',',','M/d/yy',      'dddd, MMMM dd, yyyy');
INSERT INTO Country VALUES (  600,   966,  437,'ENU','Arabie Seoudite',              '',                                             0,0,2,1,0,1,2,0, 0,      '',  '',  '$',   ',', '.','/',':',',','M/d/yy',      'dddd, MMMM dd, yyyy');
INSERT INTO Country VALUES (  700,    54,  437,'ENU','Argentine',                    '\SOURCE\CHANTAL\RESOURCE\COUNTRY\ARGENTIN.ICO',0,0,2,1,0,1,2,0, 0,      '',  '',  '$',   ',', '.','/',':',',','M/d/yy',      'dddd, MMMM dd, yyyy');
INSERT INTO Country VALUES (  800,    99,  437,'ENU','Asie anglophone',              '',                                             0,0,2,1,0,1,2,0, 0,      '',  '',  '$',   ',', '.','/',':',',','M/d/yy',      'dddd, MMMM dd, yyyy');
INSERT INTO Country VALUES (  900,    61,  437,'ENG','Australie',                    '\SOURCE\CHANTAL\RESOURCE\COUNTRY\AUSTRALI.ICO',1,0,2,0,0,0,2,0, 0,      'AM','PM','$',   ',', '.','/',':',',','d/MM/yy',     'dddd, d MMMM yyyy');
INSERT INTO Country VALUES ( 1000,    43,  437,'DEU','Autriche',                     '\SOURCE\CHANTAL\RESOURCE\COUNTRY\AUTRICHE.ICO',2,2,2,1,1,0,2,9, 1,      '',  '',  'S',   '.', ',','-',':',';','yyyy-MM-dddd','dddd, dd. MMMM yyyy');
INSERT INTO Country VALUES ( 1100,   880,  437,'ENU','Bangladesh',                   '\SOURCE\CHANTAL\RESOURCE\COUNTRY\BANGLADE.ICO',0,0,2,1,0,1,2,0, 0,      '',  '',  '$',   ',', '.','/',':',',','M/d/yy',      'dddd, MMMM dd, yyyy');
INSERT INTO Country VALUES ( 1200,    32,  850,'FRA','Belgique (Franáais)',          '\SOURCE\CHANTAL\RESOURCE\COUNTRY\BELGIQUE.ICO',1,3,2,1,0,0,2,8, 0,      '',  '',  'FB',  '.', ',','/',':',';','d/MM/yy',     'dddd d MMMM yyyy');
INSERT INTO Country VALUES ( 1300,    32,  850,'NLD','Belgique (Hollandais)',        '\SOURCE\CHANTAL\RESOURCE\COUNTRY\BELGIQUE.ICO',1,3,2,1,1,0,2,8, 0,      '',  '',  'BF',  '.', ',','/',':',';','d/MM/yy',     'dddd d MMMM yyyy');
INSERT INTO Country VALUES ( 1400,    55,  850,'PTG','BrÇsil',                       '\SOURCE\CHANTAL\RESOURCE\COUNTRY\BRESIL.ICO',  1,2,2,1,1,0,2,0, 0,      '',  '',  'Cr$', '.', ',','/',':',';','d/MM/yy',     'dddd, d'' de ''MMMM'' de ''yyyy');
INSERT INTO Country VALUES ( 1500,    11,  437,'ENG','Canada anglophone',            '\SOURCE\CHANTAL\RESOURCE\COUNTRY\CANADA.ICO',  1,0,2,1,1,0,2,1, 1,      '',  '',  '$',   ',', '.','/',':',',','dd/MM/yy',    'MMMM d, yyyy');
INSERT INTO Country VALUES ( 1600,     2,  863,'FRC','Canada francophone',           '\SOURCE\CHANTAL\RESOURCE\COUNTRY\CANADA.ICO',  2,3,2,1,1,0,2,8, 1,      '',  '',  '$',   ' ', ',','-',':',';','yy-MM-dd',    'd MMMM, yyyy');
INSERT INTO Country VALUES ( 1700,    56,  437,'ENU','Chili',                        '\SOURCE\CHANTAL\RESOURCE\COUNTRY\CHILI.ICO',   0,0,2,1,0,1,2,0, 0,      '',  '',  '$',   ',', '.','/',':',',','M/d/yy',      'dddd, MMMM dd, yyyy');
INSERT INTO Country VALUES ( 1800,    86,  936,'ENU','Chine',                        '\SOURCE\CHANTAL\RESOURCE\COUNTRY\CHINE.ICO',   2,0,2,1,0,1,2,0, 0,      '',  '',  '\',   ',', '.','-',':',',','yy-MM-dd',    'd MMMM, yyyy');
INSERT INTO Country VALUES ( 1900,   357,  437,'ENU','Chypre',                       '',                                             0,0,2,1,0,1,2,0, 0,      '',  '',  '$',   ',', '.','/',':',',','M/d/yy',      'dddd, MMMM dd, yyyy');
INSERT INTO Country VALUES ( 2000,    57,  437,'ENU','Colombie',                     '\SOURCE\CHANTAL\RESOURCE\COUNTRY\COLOMBIE.ICO',0,0,2,1,0,1,2,0, 0,      '',  '',  '$',   ',', '.','/',':',',','M/d/yy',      'dddd, MMMM dd, yyyy');
INSERT INTO Country VALUES ( 2100,    82,  934,'KOR','CorÇe',                        '',                                             2,0,2,1,0,0,2,1, 0,      '',  '',  'W',   ',', '.','.',':',',','yyyy.MM.d',   'yyyy.MM.dd');
INSERT INTO Country VALUES ( 2200,   506,  437,'ENU','Costa Rica',                   '',                                             0,0,2,1,0,1,2,0, 0,      '',  '',  '$',   ',', '.','/',':',',','M/d/yy',      'dddd, MMMM dd, yyyy');
INSERT INTO Country VALUES ( 2300,    45,  865,'DAN','Danemark',                     '\SOURCE\CHANTAL\RESOURCE\COUNTRY\DANEMARK.ICO',1,2,2,1,1,0,2,2, 1,      '',  '',  'kr',  '.', ',','-','.',';','dd-MM-yy',    'd. MMMM yyyy');
INSERT INTO Country VALUES ( 2400,    20,  437,'ENU','êgypte',                       '\SOURCE\CHANTAL\RESOURCE\COUNTRY\EGYPTE.ICO',  0,0,2,1,0,1,2,0, 0,      '',  '',  '$',   ',', '.','/',':',',','M/d/yy',      'dddd, MMMM dd, yyyy');
INSERT INTO Country VALUES ( 2500,   971,  437,'ENU','êmirats Arabes Unis',          '',                                             0,0,2,1,0,1,2,0, 0,      '',  '',  '$',   ',', '.','/',':',',','M/d/yy',      'dddd, MMMM dd, yyyy');
INSERT INTO Country VALUES ( 2600,    34,  850,'ESP','Espagne',                      '\SOURCE\CHANTAL\RESOURCE\COUNTRY\ESPAGNE.ICO', 1,3,2,1,0,0,0,8, 0,      '',  '',  'Pts', '.', ',','/',':',';','d/MM/yy',     'dddd d'' de ''MMMM'' de ''yyyy');
INSERT INTO Country VALUES ( 2700,     1,  437,'ENU','êtats-Unis',                   '\SOURCE\CHANTAL\RESOURCE\COUNTRY\USA.ICO',     0,0,2,0,1,1,2,0, 0,      'AM','PM','$',   ',', '.','/',':',',','M/d/yy',      'dddd, MMMM dd, yyyy');
INSERT INTO Country VALUES ( 2800,   358,  437,'FIN','Finlande',                     '',                                             1,3,2,1,1,0,2,8, 0,      '',  '',  'mk',  ' ', ',','.','.',';','d.M.yyyy',    'd. MMMMta yyyy');
INSERT INTO Country VALUES ( 2900,    33,  850,'FRA','France',                       '\SOURCE\CHANTAL\RESOURCE\COUNTRY\FRANCE.ICO',  1,3,2,1,1,0,2,8, 1,      '',  '',  'F',   ' ', ',','/',':',';','dd/MM/yyyy',  'dddd d MMMM yyyy');
INSERT INTO Country VALUES ( 3000,    30,  437,'ENU','Gräce',                        '\SOURCE\CHANTAL\RESOURCE\COUNTRY\GRECE.ICO',   0,0,2,1,0,1,2,0, 0,      '',  '',  '$',   ',', '.','/',':',',','M/d/yy',      'dddd, MMMM dd, yyyy');
INSERT INTO Country VALUES ( 3100,   502,  437,'ENU','Guatemala',                    '',                                             0,0,2,1,0,1,2,0, 0,      '',  '',  '$',   ',', '.','/',':',',','M/d/yy',      'dddd, MMMM dd, yyyy');
INSERT INTO Country VALUES ( 3200,   509,  437,'ENU','Haãti',                        '',                                             0,0,2,1,0,1,2,0, 0,      '',  '',  '$',   ',', '.','/',':',',','M/d/yy',      'dddd, MMMM dd, yyyy');
INSERT INTO Country VALUES ( 3300,   852,  437,'ENU','Hong Kong',                    '',                                             0,0,2,1,0,1,2,0, 0,      '',  '',  '$',   ',', '.','/',':',',','M/d/yy',      'dddd, MMMM dd, yyyy');
INSERT INTO Country VALUES ( 3400,    36,  852,'ENU','Hongrie',                      '\SOURCE\CHANTAL\RESOURCE\COUNTRY\HONGRIE.ICO', 2,0,2,1,0,1,2,0, 0,      '',  '',  'Ft',  ' ', ',','-',':',',','M/d/yy',      'dddd, MMMM dd, yyyy');
INSERT INTO Country VALUES ( 3500,    22,  437,'ENU','Ile de Malte',                 '\SOURCE\CHANTAL\RESOURCE\COUNTRY\ILEMALTE.ICO',0,0,2,1,0,1,2,0, 0,      '',  '',  '$',   ',', '.','/',':',',','M/d/yy',      'dddd, MMMM dd, yyyy');
INSERT INTO Country VALUES ( 3600,    91,  437,'ENU','Inde',                         '',                                             0,0,2,1,0,1,2,0, 0,      '',  '',  '$',   ',', '.','/',':',',','M/d/yy',      'dddd, MMMM dd, yyyy');
INSERT INTO Country VALUES ( 3700,    62,  437,'ENU','IndonÇsie',                    '\SOURCE\CHANTAL\RESOURCE\COUNTRY\INDONESI.ICO',0,0,2,1,0,1,2,0, 0,      '',  '',  '$',   ',', '.','/',':',',','M/d/yy',      'dddd, MMMM dd, yyyy');
INSERT INTO Country VALUES ( 3800,    98,  437,'ENU','Iran',                         '',                                             0,0,2,1,0,1,2,0, 0,      '',  '',  '$',   ',', '.','/',':',',','M/d/yy',      'dddd, MMMM dd, yyyy');
INSERT INTO Country VALUES ( 3900,   353,  437,'ENG','Irlande',                      '',                                             1,0,2,1,1,0,2,1, 1,      '',  '',  '£',   ',', '.','/',':',',','dd/MM/yy',    'dd MMMM yyyy');
INSERT INTO Country VALUES ( 4000,   354,  850,'ISL','Islande',                      '',                                             2,3,2,1,0,0,2,8, 0,      '',  '',  'kr',  '.', ',','.',':',';','dd.MM.yyyy',  'd. MMMM, yyyy');
INSERT INTO Country VALUES ( 4100,   972,  862,'ENU','Israâl',                       '',                                             0,0,2,1,0,1,2,0, 0,      '',  '',  '$',   ',', '.','/',':',',','M/d/yy',      'dddd, MMMM dd, yyyy');
INSERT INTO Country VALUES ( 4200,    39,  850,'ITA','Italie',                       '\SOURCE\CHANTAL\RESOURCE\COUNTRY\ITALIE.ICO',  1,2,2,1,1,0,0,9, 0,      '',  'L', '.',   '.', ',','/','.',';','dd/MM/yy',    'dddd dd MMMM yyyy');
INSERT INTO Country VALUES ( 4300,    81,  932,'ENU','Japon',                        '\SOURCE\CHANTAL\RESOURCE\COUNTRY\JAPON.ICO',   0,0,2,1,0,1,2,0, 0,      '',  '',  '$',   ',', '.','/',':',',','M/d/yy',      'dddd, MMMM dd, yyyy');
INSERT INTO Country VALUES ( 4400,    60,  437,'ENU','Malaysie',                     '',                                             0,0,2,1,0,1,2,0, 0,      '',  '',  '$',   ',', '.','/',':',',','M/d/yy',      'dddd, MMMM dd, yyyy');
INSERT INTO Country VALUES ( 4500,   212,  437,'ENU','Maroc',                        '',                                             0,0,2,1,0,1,2,0, 0,      '',  '',  '$',   ',', '.','/',':',',','M/d/yy',      'dddd, MMMM dd, yyyy');
INSERT INTO Country VALUES ( 4600,    52,  850,'ESP','Mexique',                      '\SOURCE\CHANTAL\RESOURCE\COUNTRY\MEXIQUE.ICO', 1,0,2,0,0,0,2,0, 0,      'AM','PM','$',   ',', '.','/',':',',','d/MM/yy',     'dddd d'' de ''MMMM'' de ''yyyy');
INSERT INTO Country VALUES ( 4700,    64,  437,'ENG','Nouvelle ZÇlande',             '\SOURCE\CHANTAL\RESOURCE\COUNTRY\NEWZELAN.ICO',1,0,2,0,1,0,2,0, 1,      'AM','PM','$',   ',', '.','/',':',',','d/MM/yy',     'dddd, d MMMM yyyy');
INSERT INTO Country VALUES ( 4800,    47,  865,'NOR','Norväge',                      '\SOURCE\CHANTAL\RESOURCE\COUNTRY\NORVEGE.ICO', 1,2,2,1,1,0,2,2, 1,      '',  '',  'kr',  '.', ',','.',':',';','dd.MM.yy',    'dd. MMMM yyyy');
INSERT INTO Country VALUES ( 4900,    92,  437,'ENU','Pakistan',                     '',                                             0,0,2,1,0,1,2,0, 0,      '',  '',  '$',   ',', '.','/',':',',','M/d/yy',      'dddd, MMMM dd, yyyy');
INSERT INTO Country VALUES ( 5000,   507,  437,'ENU','Panama',                       '',                                             0,0,2,1,0,1,2,0, 0,      '',  '',  '$',   ',', '.','/',':',',','M/d/yy',      'dddd, MMMM dd, yyyy');
INSERT INTO Country VALUES ( 5100,   785,  864,'ENU','Pays arabes',                  '',                                             0,0,2,1,0,1,2,0, 0,      '',  '',  '$',   ',', '.','/',':',',','M/d/yy',      'dddd, MMMM dd, yyyy');
INSERT INTO Country VALUES ( 5200,    31,  850,'NLD','Pays-Bas',                     '\SOURCE\CHANTAL\RESOURCE\COUNTRY\PAYSBAS.ICO', 1,2,2,1,1,0,2,10,0,      '',  '',  'F',   '.', ',','-',':',';','d-MM-yy',     'dddd d MMMM yyyy');
INSERT INTO Country VALUES ( 5300,    51,  437,'ENU','PÇrou',                        '\SOURCE\CHANTAL\RESOURCE\COUNTRY\PEROU.ICO',   0,0,2,1,0,1,2,0, 0,      '',  '',  '$',   ',', '.','/',':',',','M/d/yy',      'dddd, MMMM dd, yyyy');
INSERT INTO Country VALUES ( 5400,    63,  437,'ENU','Philippines',                  '\SOURCE\CHANTAL\RESOURCE\COUNTRY\PHILIPPI.ICO',0,0,2,1,0,1,2,0, 0,      '',  '',  '$',   ',', '.','/',':',',','M/d/yy',      'dddd, MMMM dd, yyyy');
INSERT INTO Country VALUES ( 5500,    48,  852,'ENU','Pologne',                      '\SOURCE\CHANTAL\RESOURCE\COUNTRY\POLOGNE.ICO', 2,0,2,1,0,1,2,0, 0,      '',  '',  'Zl',  ',', '.','/',':',',','M/d/yy',      'dddd, MMMM dd, yyyy');
INSERT INTO Country VALUES ( 5600,   351,  860,'PTG','Portugal',                     '',                                             1,3,2,1,1,0,2,8, 0,      '',  '',  'Esc.','.', ',','-',':',';','dd-MM-yyyy',  'dddd, d'' de ''MMMM'' de ''yyyy''');
INSERT INTO Country VALUES ( 5700,     2,  863,'FRC','QuÇbec',                       '\SOURCE\CHANTAL\RESOURCE\COUNTRY\QUEBEC.ICO',  2,3,2,1,1,0,2,8, 1,      '',  '',  '$',   ' ', ',','-',':',';','yy-MM-dd',    'd MMMM, yyyy');
INSERT INTO Country VALUES ( 5800,    88,  437,'ENU','RÇpublique Populaire de Chine','',                                             0,0,2,1,0,1,2,0, 0,      '',  '',  '$',   ',', '.','/',':',',','M/d/yy',      'dddd, MMMM dd, yyyy');
INSERT INTO Country VALUES ( 5900,    40,  852,'ENU','Roumanie',                     '\SOURCE\CHANTAL\RESOURCE\COUNTRY\ROUMANIE.ICO',0,0,2,1,0,1,2,0, 0,      '',  '',  '$',   ',', '.','/',':',',','M/d/yy',      'dddd, MMMM dd, yyyy');
INSERT INTO Country VALUES ( 6000,    44,  437,'ENG','Royaume-Uni',                  '\SOURCE\CHANTAL\RESOURCE\COUNTRY\ANGLETER.ICO',1,0,2,1,1,0,2,1, 1,      '',  '',  '£',   ',', '.','/',':',',','dd/MM/yy',    'dd MMMM yyyy');
INSERT INTO Country VALUES ( 6050,     2,  863,'FRC','Saguenay/Lac-St-Jean',         '\SOURCE\CHANTAL\RESOURCE\COUNTRY\BLEUET.ICO',  2,3,2,1,1,0,2,8, 1,      '',  '',  '$',   ' ', ',','-',':',';','yy-MM-dd',    'd MMMM, yyyy');
INSERT INTO Country VALUES ( 6100,   503,  437,'ENU','Salvador',                     '\SOURCE\CHANTAL\RESOURCE\COUNTRY\AFRICSUD.ICO',0,0,2,1,0,1,2,0, 0,      '',  '',  '$',   ',', '.','/',':',',','M/d/yy',      'dddd, MMMM dd, yyyy');
INSERT INTO Country VALUES ( 6200,    65,  437,'ENU','Singapour',                    '',                                             0,0,2,1,0,1,2,0, 0,      '',  '',  '$',   ',', '.','/',':',',','M/d/yy',      'dddd, MMMM dd, yyyy');
INSERT INTO Country VALUES ( 6300,    94,  437,'ENU','Sri Lanka',                    '',                                             0,0,2,1,0,1,2,0, 0,      '',  '',  '$',   ',', '.','/',':',',','M/d/yy',      'dddd, MMMM dd, yyyy');
INSERT INTO Country VALUES ( 6400,    46,  850,'SVE','Suäde',                        '\SOURCE\CHANTAL\RESOURCE\COUNTRY\SUEDE.ICO',   2,3,2,1,1,0,2,8, 1,      '',  '',  'kr',  ' ', ',','-','.',';','yyyy-MM-dd',  ''' den ''d MMMM yyyy');
INSERT INTO Country VALUES ( 6500,    41,  850,'FRA','Suisse (Franáais)',            '\SOURCE\CHANTAL\RESOURCE\COUNTRY\SUISSE.ICO',  1,2,2,1,1,0,2,2, 1,      '',  '',  'Fr.', '''','.','.',',',';','d.MM.yy',     'dddd, dd. MMMM yyyy');
INSERT INTO Country VALUES ( 6600,    41,  850,'DEU','Suisse (Allemand)',            '\SOURCE\CHANTAL\RESOURCE\COUNTRY\SUISSE.ICO',  1,2,2,1,1,0,2,2, 1,      '',  '',  'Fr.', '''','.','.',',',';','d.MM.yy',     'dddd, dd. MMMM yyyy');
INSERT INTO Country VALUES ( 6700,    41,  850,'ITA','Suisse (Italien)',             '\SOURCE\CHANTAL\RESOURCE\COUNTRY\SUISSE.ICO',  1,2,2,1,1,0,2,2, 1,      '',  '',  'Fr.', '''','.','.',',',';','d.MM.yy',     'dddd, dd. MMMM yyyy');
INSERT INTO Country VALUES ( 6800,   886,  938,'ENG','Taãwan',                       '',                                             2,0,2,1,0,1,2,1, 0,      '',  '',  'NT$', ',', '.','/',':',',','yy/MM/dd',    'dd'' of ''MMMM,yyyy');
INSERT INTO Country VALUES ( 6900,    42,  852,'ENU','TchÇcoslovaquie',              '\SOURCE\CHANTAL\RESOURCE\COUNTRY\TCHECOSL.ICO',2,0,2,1,0,1,2,0, 0,      '',  '',  'Kcs', ',', '.','/',':',',','M/d/yy',      'dddd, MMMM dd, yyyy');
INSERT INTO Country VALUES ( 7000,    66,  437,'ENU','Thaãlande',                    '\SOURCE\CHANTAL\RESOURCE\COUNTRY\THIALAND.ICO',0,0,2,1,0,1,2,0, 0,      '',  '',  '$',   ',', '.','/',':',',','M/d/yy',      'dddd, MMMM dd, yyyy');
INSERT INTO Country VALUES ( 7100,   216,  437,'ENU','TunÇsie',                      '',                                             0,0,2,1,0,1,2,0, 0,      '',  '',  '$',   ',', '.','/',':',',','M/d/yy',      'dddd, MMMM dd, yyyy');
INSERT INTO Country VALUES ( 7200,    90,  857,'ENU','Turquie',                      '',                                             1,0,2,1,0,1,2,0, 0,      '',  '',  'TL',  ',', '.','/',':',',','M/d/yy',      'dddd, MMMM dd, yyyy');
INSERT INTO Country VALUES ( 7300,     7,  437,'ENU','U.R.S.S.',                     '\SOURCE\CHANTAL\RESOURCE\COUNTRY\URSS.ICO',    0,0,2,1,0,1,2,0, 0,      '',  '',  '$',   ',', '.','/',':',',','M/d/yy',      'dddd, MMMM dd, yyyy');
INSERT INTO Country VALUES ( 7400,    58,  437,'ENU','VÇnÇsuela',                    '\SOURCE\CHANTAL\RESOURCE\COUNTRY\VENEZULA.ICO',0,0,2,1,0,1,2,0, 0,      '',  '',  '$',   ',', '.','/',':',',','M/d/yy',      'dddd, MMMM dd, yyyy');
INSERT INTO Country VALUES ( 7500,    38,  852,'ENU','Yougoslavie',                  '\SOURCE\CHANTAL\RESOURCE\COUNTRY\YOUGOSLA.ICO',2,0,2,1,0,1,2,0, 0,      '',  '',  'Din', ',', '.','/',':',',','M/d/yy',      'dddd, MMMM dd, yyyy');
INSERT INTO Country VALUES ( 7600,     1,  437,'ENU','Autres pays',                  '',                                             0,0,2,1,0,1,2,0, 0,      '',  '',  '$',   ',', '.','/',':',',','M/d/yy',      'dddd, MMMM dd, yyyy');
