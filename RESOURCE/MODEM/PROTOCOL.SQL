CREATE TABLE Protocol (
   ID         BYTE PRIMARY KEY,
   SingleFile BOOLEAN,
   TN         CHAR(2),
   SectorSize SMALLINT,
   Header     BOOLEAN,
   XonXoff    BOOLEAN,
   Nom        VARCHAR
);

CREATE INDEX;

INSERT INTO Protocol VALUES ( 1,True, 'AS', 128,False,False,'ASCII');
INSERT INTO Protocol VALUES ( 0,True, 'EX', 128,False,False,'Aucun');
INSERT INTO Protocol VALUES ( 4,False,'KE', 128,False,False,'Kermit');
INSERT INTO Protocol VALUES ( 7,False,'M7', 128,False,False,'Modem 7 CRC');
INSERT INTO Protocol VALUES ( 6,False,'MK', 128,False,False,'Modem 7 Checksum');
INSERT INTO Protocol VALUES ( 5,False,'TE', 128,False,False,'Telink');
INSERT INTO Protocol VALUES (13,True, 'U1', 128,False,False,'Externe 1');
INSERT INTO Protocol VALUES (14,True, 'U2', 128,False,False,'Externe 2');
INSERT INTO Protocol VALUES (15,True, 'U3', 128,False,False,'Externe 3');
INSERT INTO Protocol VALUES (16,True, 'U4', 128,False,False,'Externe 4');
INSERT INTO Protocol VALUES ( 8,True, 'X1',  -1,True, True, 'XModem 1K');
INSERT INTO Protocol VALUES ( 3,True, 'XC', 128,False,False,'XModem CRC');
INSERT INTO Protocol VALUES ( 9,True, 'XG',  -1,True, True, 'XModem 1K G');
INSERT INTO Protocol VALUES ( 2,True, 'XK', 128,False,False,'XModem Checksum');
INSERT INTO Protocol VALUES (10,False,'YB',  -1,True, True, 'YModem Batch');
INSERT INTO Protocol VALUES (11,False,'YG',  -1,True, True, 'YModem G');
INSERT INTO Protocol VALUES (12,True, 'ZM', 128,False,False,'ZModem');

