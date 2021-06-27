CREATE TABLE Shell (
   ID     BYTE,
   Mode   WORD,
   Name   VARCHAR
);

CREATE INDEX;

/* INSERT INTO Shell VALUES (0x65,0x1C00,'at'); */
/* INSERT INTO Shell VALUES (0x66,0x1C00,'awk'); */
INSERT INTO Shell VALUES (0x67,0x1C00,'banner');
INSERT INTO Shell VALUES (0x68,0x1C00,'basename');
/* INSERT INTO Shell VALUES (0x69,0x1C00,'batch'); */
/* INSERT INTO Shell VALUES (0x6A,0x1C00,'cat'); */
INSERT INTO Shell VALUES (0x6B,0x1C00,'cd');
/* INSERT INTO Shell VALUES (0x6C,0x1C00,'chgrp'); */
/* INSERT INTO Shell VALUES (0x6D,0x1C00,'chmod'); */
/* INSERT INTO Shell VALUES (0x6E,0x1C00,'chown'); */
INSERT INTO Shell VALUES (0x08,0x1C00,'clear');
/* INSERT INTO Shell VALUES (0x70,0x1C00,'cmp'); */
/* INSERT INTO Shell VALUES (0x71,0x1C00,'copy'); */
INSERT INTO Shell VALUES (0x0B,0x1C00,'cp');
/* INSERT INTO Shell VALUES (0x73,0x1C00,'cron'); */
/* INSERT INTO Shell VALUES (0x74,0x1C00,'crontab'); */
/* INSERT INTO Shell VALUES (0x75,0x1C00,'date'); */
/* INSERT INTO Shell VALUES (0x76,0x1C00,'df'); */
/* INSERT INTO Shell VALUES (0x77,0x1C00,'disable'); */
INSERT INTO Shell VALUES (0x78,0x1C00,'dirname');
/* INSERT INTO Shell VALUES (0x79,0x1C00,'diskcp'); */
/* INSERT INTO Shell VALUES (0x7A,0x1C00,'diskcmp'); */
/* INSERT INTO Shell VALUES (0x7B,0x1C00,'doscat'); */
/* INSERT INTO Shell VALUES (0x7C,0x1C00,'doscp'); */
/* INSERT INTO Shell VALUES (0x7D,0x1C00,'dosdir'); */
/* INSERT INTO Shell VALUES (0x7E,0x1C00,'dosformat'); */
/* INSERT INTO Shell VALUES (0x7F,0x1C00,'dosls'); */
/* INSERT INTO Shell VALUES (0x80,0x1C00,'dosmkdir'); */
/* INSERT INTO Shell VALUES (0x81,0x1C00,'dosrm'); */
/* INSERT INTO Shell VALUES (0x82,0x1C00,'dosrmdir'); */
/* INSERT INTO Shell VALUES (0x83,0x1C00,'dtype'); */
/* INSERT INTO Shell VALUES (0x84,0x1C00,'du'); */
INSERT INTO Shell VALUES (0x85,0x1C00,'echo');
/* INSERT INTO Shell VALUES (0x86,0x1C00,'ed'); */
/* INSERT INTO Shell VALUES (0x87,0x1C00,'egrep'); */
/* INSERT INTO Shell VALUES (0x88,0x1C00,'enable'); */
/* INSERT INTO Shell VALUES (0x89,0x1C00,'env'); */
INSERT INTO Shell VALUES (0x14,0x1C00,'exit');
/* INSERT INTO Shell VALUES (0x8B,0x1C00,'expr'); */
/* INSERT INTO Shell VALUES (0x8C,0x1C00,'fgrep'); */
/* INSERT INTO Shell VALUES (0x8D,0x1C00,'find'); */
/* INSERT INTO Shell VALUES (0x8E,0x1C00,'format'); */
/* INSERT INTO Shell VALUES (0x8F,0x1C00,'fsck'); */
/* INSERT INTO Shell VALUES (0x90,0x1C00,'grep'); */
/* INSERT INTO Shell VALUES (0x91,0x1C00,'haltsys'); */
/* INSERT INTO Shell VALUES (0x92,0x1C00,'head'); */
INSERT INTO Shell VALUES (0x93,0x1C00,'help');
/* INSERT INTO Shell VALUES (0x94,0x1C00,'kill'); */
/* INSERT INTO Shell VALUES (0x95,0x1C00,'ln'); */
INSERT INTO Shell VALUES (0x14,0x1C00,'logout');
/* INSERT INTO Shell VALUES (0x97,0x1C00,'lp'); */
/* INSERT INTO Shell VALUES (0x98,0x1C00,'lprint'); */
/* INSERT INTO Shell VALUES (0x99,0x1C00,'lpstat'); */
INSERT INTO Shell VALUES (0x9A,0x1C00,'ls');
/* INSERT INTO Shell VALUES (0x9B,0x1C00,'mail'); */
INSERT INTO Shell VALUES (0x93,0x1C00,'man');
/* INSERT INTO Shell VALUES (0x9D,0x1C00,'mesg'); */
/* INSERT INTO Shell VALUES (0x9E,0x1C00,'mkdir'); */
/* INSERT INTO Shell VALUES (0x9F,0x1C00,'mknod'); */
/* INSERT INTO Shell VALUES (0xA0,0x1C00,'mnt'); */
/* INSERT INTO Shell VALUES (0xA1,0x1C00,'mv'); */
/* INSERT INTO Shell VALUES (0xA2,0x1C00,'nice'); */
/* INSERT INTO Shell VALUES (0xA3,0x1C00,'nl'); */
/* INSERT INTO Shell VALUES (0xA4,0x1C00,'nohup'); */
/* INSERT INTO Shell VALUES (0xA5,0x1C00,'od'); */
/* INSERT INTO Shell VALUES (0xA6,0x1C00,'passwd'); */
/* INSERT INTO Shell VALUES (0xA7,0x1C00,'pr'); */
/* INSERT INTO Shell VALUES (0xA8,0x1C00,'ps'); */
INSERT INTO Shell VALUES (0xA9,0x1C00,'pwd');
/* INSERT INTO Shell VALUES (0xAA,0x1C00,'reboot'); */
/* INSERT INTO Shell VALUES (0xAB,0x1C00,'rm'); */
/* INSERT INTO Shell VALUES (0xAC,0x1C00,'rmdir'); */
/* INSERT INTO Shell VALUES (0xAD,0x1C00,'sed'); */
/* INSERT INTO Shell VALUES (0xAE,0x1C00,'shutdown'); */
/* INSERT INTO Shell VALUES (0xAF,0x1C00,'sleep'); */
/* INSERT INTO Shell VALUES (0xB0,0x1C00,'sort'); */
/* INSERT INTO Shell VALUES (0xB1,0x1C00,'split'); */
/* INSERT INTO Shell VALUES (0xB2,0x1C00,'stty'); */
/* INSERT INTO Shell VALUES (0xB3,0x1C00,'su'); */
/* INSERT INTO Shell VALUES (0xB4,0x1C00,'tar'); */
/* INSERT INTO Shell VALUES (0xB5,0x1C00,'tee'); */
/* INSERT INTO Shell VALUES (0xB6,0x1C00,'test'); */
/* INSERT INTO Shell VALUES (0xB7,0x1C00,'tr'); */
/* INSERT INTO Shell VALUES (0xB8,0x1C00,'translate'); */
/* INSERT INTO Shell VALUES (0xB9,0x1C00,'tset'); */
/* INSERT INTO Shell VALUES (0xBA,0x1C00,'tty'); */
/* INSERT INTO Shell VALUES (0xBB,0x1C00,'umask'); */
/* INSERT INTO Shell VALUES (0xBC,0x1C00,'umnt'); */
/* INSERT INTO Shell VALUES (0xBD,0x1C00,'uname'); */
/* INSERT INTO Shell VALUES (0xBE,0x1C00,'uniq'); */
/* INSERT INTO Shell VALUES (0xBF,0x1C00,'vmstat'); */
/* INSERT INTO Shell VALUES (0xC0,0x1C00,'w'); */
/* INSERT INTO Shell VALUES (0xC1,0x1C00,'wait'); */
/* INSERT INTO Shell VALUES (0xC2,0x1C00,'wc'); */
/* INSERT INTO Shell VALUES (0xC3,0x1C00,'who'); */
INSERT INTO Shell VALUES (0xC4,0x1C00,'whoami');
/* INSERT INTO Shell VALUES (0xC5,0x1C00,'write'); */
