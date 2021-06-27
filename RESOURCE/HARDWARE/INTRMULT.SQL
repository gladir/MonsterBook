CREATE TABLE InterruptionMultiplex (
   ID    BYTE,
   SubID BYTE,
   Mode  BYTE,
   Name  VARCHAR
);

CREATE INDEX;

INSERT INTO InterruptionMultiplex VALUES (0x12,0x00,0,'DOS');
INSERT INTO InterruptionMultiplex VALUES (0x08,0x00,0,'DRIVER.SYS');
INSERT INTO InterruptionMultiplex VALUES (0xB0,0x00,0,'DISPLAY.SYS');
INSERT INTO InterruptionMultiplex VALUES (0x1A,0x00,0,'ANSI.SYS');
//INSERT INTO InterruptionMultiplex VALUES (0xBC,0x00,0,'EGA.SYS');
INSERT INTO InterruptionMultiplex VALUES (0x01,0x00,0,'PRINT');
INSERT INTO InterruptionMultiplex VALUES (0x06,0x00,0,'ASSIGN');
INSERT INTO InterruptionMultiplex VALUES (0x10,0x00,0,'SHARE');
INSERT INTO InterruptionMultiplex VALUES (0x14,0x00,0,'NLSFUNC');
INSERT INTO InterruptionMultiplex VALUES (0xB0,0x00,0,'GRAFTABL (4.0-)');
INSERT INTO InterruptionMultiplex VALUES (0x23,0x00,1,'GRAFTABL (5.0+)');
INSERT INTO InterruptionMultiplex VALUES (0x87,0x00,0,'NETBIOS append');
INSERT INTO InterruptionMultiplex VALUES (0x88,0x00,0,'NETBIOS network');
INSERT INTO InterruptionMultiplex VALUES (0x19,0x00,0,'SHELLB');
INSERT INTO InterruptionMultiplex VALUES (0x1B,0x00,0,'XMA2EMS');
INSERT INTO InterruptionMultiplex VALUES (0xB7,0x00,0,'APPEND');
INSERT INTO InterruptionMultiplex VALUES (0x15,0x00,0,'GRAPHICS.COM');
INSERT INTO InterruptionMultiplex VALUES (0x05,0x00,0,'Crit.err.handlr');
INSERT INTO InterruptionMultiplex VALUES (0x15,0x10,2,'CD-ROM');
INSERT INTO InterruptionMultiplex VALUES (0x48,0x00,0,'DOSKEY');
INSERT INTO InterruptionMultiplex VALUES (0xB8,0x00,3,'R‚seau');
INSERT INTO InterruptionMultiplex VALUES (0xF1,0x00,4,'DOS Extender');

