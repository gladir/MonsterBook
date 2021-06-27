CREATE TABLE Convers (
   VID      BYTE PRIMARY KEY,
   Title    VARCHAR,
   Question VARCHAR,
   Reponse1 VARCHAR,
   Reponse2 VARCHAR,
   Formula  VARCHAR
);

CREATE INDEX;

INSERT INTO Convers VALUES (0x0001,'Fahrenheit … Celcius',         'Entrez la temp‚rature en Fahrenheit:','La temp‚rature en Fahrenheit est ','La temp‚rature en Celcius est ','(X+40.0)*(5.0/9.0)-40.0');
INSERT INTO Convers VALUES (0x0002,'Celcius … Fahrenheit',         'Entrez la temp‚rature en Celcius:','La temp‚rature en Celcius est ','La temp‚rature en Fahrenheit est ',   '(X+40.0)*(9.0/5.0)-40.0');
INSERT INTO Convers VALUES (0x0003,'Kelvin … Celcius',             'Entrez la temp‚rature en Kelvin:','La temp‚rature en Kelvin est ','La temp‚rature en Celcius est ',        'X-273.16');
INSERT INTO Convers VALUES (0x0004,'Celcius … Kelvin',             'Entrez la temp‚rature en Celcius:','La temp‚rature en Celcius est ','La temp‚rature en Kelvin est ',       'X+273.16');
INSERT INTO Convers VALUES (0x0005,'Pouce … Pied',                 'Entrez la mesure en Pouce:','La mesure en Pouce est ','La mesure en Pied est ',                            '');
INSERT INTO Convers VALUES (0x0006,'Pied … Pouce',                 'Entrez la mesure en Pied:','La mesure en Pied est ','La mesure en Pouce est ',                             'X*12.0');
INSERT INTO Convers VALUES (0x0007,'Pouce … Verge',                'Entrez la mesure en Pouce:','La mesure en Pouce est ','La mesure en Verge est ',                           'X/36.0');
INSERT INTO Convers VALUES (0x0008,'Verge … Pouce',                'Entrez la mesure en Verge:','La mesure en Verge est ','La mesure en Pouce est ',                           'X*36.0');
INSERT INTO Convers VALUES (0x0009,'Pouce … Mile',                 'Entrez la mesure en Pouce:','La mesure en Pouce est ','La mesure en Mile est ',                            'X/63360.0');
INSERT INTO Convers VALUES (0x000A,'Mile … Pouce',                 'Entrez la mesure en Mile:','La mesure en Mile est ','La mesure en Pouce est ',                             'X*63360.0');
INSERT INTO Convers VALUES (0x000B,'Pouce … Mile nautique',        'Entrez la mesure en Pouce:','La mesure en Pouce est ','La mesure en Mile nautique',                        'X/72960.0');
INSERT INTO Convers VALUES (0x000C,'Mile nautique … Pouce',        'Entrez la mesure en Mile nautique:','La mesure en Mile nautique est ','La mesure en Pouce est ',           'X*72960.0');
INSERT INTO Convers VALUES (0x000D,'Pouce … MŠtre',                'Entrez la mesure en Pouce:','La mesure en Pouce est ','La mesure en MŠtre est ',                           'X*0.0254');
INSERT INTO Convers VALUES (0x000E,'MŠtre … Pouce',                'Entrez la mesure en MŠtre:','La mesure en MŠtre est ','La mesure en Pouce est ',                           'X/0.0254');
INSERT INTO Convers VALUES (0x000F,'Pouceý … Piedý',               'Entrez la mesure en Pouceý:','La mesure en Pouceý est ','La mesure en Piedý est ',                         'X/144.0');
INSERT INTO Convers VALUES (0x0010,'Piedý … Pouceý',               'Entrez la mesure en Piedý:','La mesure en Piedý est ','La mesure en Pouceý est ',                          'X*144.0');
INSERT INTO Convers VALUES (0x0011,'Pouceý … Vergeý',              'Entrez la mesure en Pouceý:','La mesure en Pouceý est ','La mesure en Vergeý est ',                        'X/1296.0');
INSERT INTO Convers VALUES (0x0012,'Vergeý … Pouceý',              'Entrez la mesure en Vergeý:','La mesure en Vergeý est ','La mesure en Pouceý est ',                        'X*1296.0');
INSERT INTO Convers VALUES (0x0013,'Pouceý … Mileý',               'Entrez la mesure en Pouceý:','La mesure en Pouceý est ','La mesure en Mileý est ',                         'X/4014489600.0');
INSERT INTO Convers VALUES (0x0014,'Mileý … Pouceý',               'Entrez la mesure en Mileý:','La mesure en Mileý est ','La mesure en Pouceý est ',                          'X*4014489600.0');
INSERT INTO Convers VALUES (0x0015,'Pouceý … Acre',                'Entrez la mesure en Pouceý:','La mesure en Pouceý est ','La mesure en Acre est ',                          'X/6272640.0');
INSERT INTO Convers VALUES (0x0016,'Acre … Pouceý',                'Entrez la mesure en Acre:','La mesure en Acre est ','La mesure en Pouceý est ',                            'X*6272640.0');
INSERT INTO Convers VALUES (0x0017,'Pouceý … MŠtreý',              'Entrez la mesure en Pouceý:','La mesure en Pouceý est ','La mesure en MŠtreý est ',                        'X/1550.016');
INSERT INTO Convers VALUES (0x0018,'MŠtreý … Pouceý',              'Entrez la mesure en MŠtreý:','La mesure en MŠtreý est ','La mesure en Pouceý est ',                        'X*1550.016');
INSERT INTO Convers VALUES (0x0019,'Pouce cube … Pied cube',       'Entrez la mesure en Pouce cube:','La mesure en Pouce cube est ','La mesure en Pied cube est ',             'X/1728.0');
INSERT INTO Convers VALUES (0x001A,'Pied cube … Pied cube',        'Entrez la mesure en Pied cube:','La mesure en Pied cube est ','La mesure en Pied cube est ',               'X*1728.0');
INSERT INTO Convers VALUES (0x001B,'Pouce cube … Verge cube',      'Entrez la mesure en Pouce cube:','La mesure en Pouce cube est ','La mesure en Verge cube est ',            'X/46656.0');
INSERT INTO Convers VALUES (0x001C,'Verge cube … Pouce cube',      'Entrez la mesure en Verge cube:','La mesure en Verge cube est ','La mesure en Pouce cube est ',            'X*46656.0');
INSERT INTO Convers VALUES (0x001D,'Pouce cube … MŠtre cube',      'Entrez la mesure Pouce cube:','La mesure en Pouce cube est ','La mesure en MŠtre cube est ',               'X/61022.592');
INSERT INTO Convers VALUES (0x001E,'MŠtre cube … Pouce cube',      'Entrez la mesure en MŠtre cube:','La mesure en MŠtre cube est ','La mesure en Pouce cube est ',            'X*61022.592');
INSERT INTO Convers VALUES (0x001F,'Oz liquide … Pinte',           'Entrez la mesure en Oz liquide:','La mesure en Oz liquide est ','La mesure en Pinte est ',                 'X/16.0');
INSERT INTO Convers VALUES (0x0020,'Pinte … Oz liquide',           'Entrez la mesure en Pinte:','La mesure en Pinte est ','La mesure en Oz liquide est ',                      'X*16.0');
INSERT INTO Convers VALUES (0x0021,'Oz liquide … Pinte',           'Entrez la mesure en Oz liquide:','La mesure en Oz liquide est ','La mesure en Pinte est ',                 'X/20.0');
INSERT INTO Convers VALUES (0x0022,'Pinte imp‚rial … oz liquide',  'Entrez la mesure en Pinte imp‚rial: ','La mesure en Pinte imp‚rial est ','La mesure en oz liquide est ',   'X*20.0');
INSERT INTO Convers VALUES (0x0023,'Oz liquide … Gallons',         'Entrez la mesure en Oz liquide:','La mesure en Oz liquide est ','La mesure en Gallons est ',               'X/128.0');
INSERT INTO Convers VALUES (0x0024,'Gallons … Oz liquide',         'Entrez la mesure en Gallons:','La mesure en Gallons est ','La mesure en Oz liquide est ',                  'X*128.0');
INSERT INTO Convers VALUES (0x0025,'Oz liquide … Gallons imp‚rial','Entrez la mesure en Oz liquide:','La mesure en Oz liquide est ','La mesure en Gallons imp‚rial est ',      'X/160.0');
INSERT INTO Convers VALUES (0x0026,'Gallons imp‚rial … Oz liquide','Entrez la mesure en Gallons imp‚rial:','La mesure en Gallons imp‚rial est ','La mesure en Oz liquide est ','X*160.0');
INSERT INTO Convers VALUES (0x0027,'Oz liquide … MŠtre cube',      'Entrez la mesure en Oz liquide:','La mesure en Oz liquide est ','La mesure en MŠtre cube est ',            'X/33820.0');
INSERT INTO Convers VALUES (0x0028,'MŠtre cube … Oz liquide',      'Entrez la mesure en MŠtre cube:','La mesure en MŠtre cube est ','La mesure en Oz liquide est ',            'X*33820.0');
INSERT INTO Convers VALUES (0x0029,'Once … Oz Lb',                 'Entrez la mesure en Once:','La mesure en Once est ','La mesure en Oz Lb est ',                             '');
INSERT INTO Convers VALUES (0x002A,'Oz Lb … Once',                 'Entrez la mesure en Oz Lb:','La mesure en Oz Lb est ','La mesure en Once est ',                            'X*16.0');
INSERT INTO Convers VALUES (0x002B,'Once … Tonne (courte)',        'Entrez la mesure en Once:','La mesure en Once est ','La mesure en Tonne (courte) est ',                    'X/32000.0');
INSERT INTO Convers VALUES (0x002C,'Tonne (courte) … Once',        'Entrez la mesure en Tonne (courte):','La mesure en Tonne (courte) est ','La mesure en Once est ',          'X*32000.0');
INSERT INTO Convers VALUES (0x002D,'Once … Tonne forte',           'Entrez la mesure en Once:','La mesure en Once est ','La mesure en Tonne forte est ',                       'X/35840.0');
INSERT INTO Convers VALUES (0x002E,'Tonne forte … Once',           'Entrez la mesure en Tonne forte:','La mesure en Tonne forte est ','La mesure en Once est ',                'X*35840.0');
INSERT INTO Convers VALUES (0x002F,'Once … Gramme',                'Entrez la mesure en Once:','La mesure en Once est ','La mesure en Gramme est ',                            'X*28.35');
INSERT INTO Convers VALUES (0x0030,'Gramme … Once',                'Entrez la mesure en Gramme:','La mesure en Gramme est ','La mesure en Once est ',                          'X/28.35');
INSERT INTO Convers VALUES (0x0031,'Sommation ASCII',              '','','',                                                                                                   '');
INSERT INTO Convers VALUES (0x0032,'Sommation Romaine',            '','','',                                                                                                   '');
