CREATE TABLE Instr (
   OpCode BYTE,
   Name   VARCHAR,
   Param  VARCHAR
);

CREATE INDEX;

INSERT INTO Instr VALUES (0xEF,'BANKFONT',          '');
INSERT INTO Instr VALUES (0x0B,'BARHORI',           '(B,B,B)');
INSERT INTO Instr VALUES (0x05,'BARUP',             '');
INSERT INTO Instr VALUES (0xEA,'BIN',               '');
INSERT INTO Instr VALUES (0xF1,'CAPTION',           '');
INSERT INTO Instr VALUES (0xF7,'CHECKBOX',          '');
INSERT INTO Instr VALUES (0xF7,'CLICKBOX',          '');
INSERT INTO Instr VALUES (0x03,'CLOSEICON',         '');
INSERT INTO Instr VALUES (0x31,'COLORCUBE',         '(B,B),B,B');
INSERT INTO Instr VALUES (0x8B,'COLORGRID',         '(B,B)');
INSERT INTO Instr VALUES (0x78,'COMBOBOX',          '(B,B,B)');
INSERT INTO Instr VALUES (0x50,'COPY',              'S,S');
INSERT INTO Instr VALUES (0xE1,'COPYRIGHT',         '');
INSERT INTO Instr VALUES (0x11,'ELSE',              '');
INSERT INTO Instr VALUES (0xF9,'END',               '');
INSERT INTO Instr VALUES (0xFC,'EXTERNAL',          '');
INSERT INTO Instr VALUES (0x8C,'FRAME',             '(B,B)-(B,B),S');
INSERT INTO Instr VALUES (0xFB,'GHOST',             '');
INSERT INTO Instr VALUES (0xED,'HEIGHT',            '');
INSERT INTO Instr VALUES (0x10,'IF',                '');
INSERT INTO Instr VALUES (0xC0,'IMAGE',             '(B,B),W,S');
INSERT INTO Instr VALUES (0xEC,'IMAGEBIN',          '');
INSERT INTO Instr VALUES (0xE2,'INDEXASCII',        '');
INSERT INTO Instr VALUES (0xE6,'INDEXDIALOG',       '');
INSERT INTO Instr VALUES (0xE4,'INDEXFILE',         '');
INSERT INTO Instr VALUES (0xE7,'INDEXMENUCONTEXT',  '');
INSERT INTO Instr VALUES (0xE8,'INDEXMSG',          '');
INSERT INTO Instr VALUES (0xE5,'INDEXREC',          '');
INSERT INTO Instr VALUES (0xE3,'INDEXSQL',          '');
INSERT INTO Instr VALUES (0xF0,'INPUT',             '');
INSERT INTO Instr VALUES (0x8E,'KEYHORI',           '(B,B),B,S');
INSERT INTO Instr VALUES (0x85,'KEYHORIDOWN',       'S');
INSERT INTO Instr VALUES (0x71,'LIST',              '(B,B)-(B,B),S');
INSERT INTO Instr VALUES (0x87,'LISTBOX',           '(B,B)-(B,B),');
INSERT INTO Instr VALUES (0x04,'LN',                '');
INSERT INTO Instr VALUES (0x0F,'LOCATE',            'B,B');
INSERT INTO Instr VALUES (0xEB,'MATRIX',            '');
INSERT INTO Instr VALUES (0xFE,'MESSAGE',           '');
INSERT INTO Instr VALUES (0x50,'MOVE',              'S,S');
INSERT INTO Instr VALUES (0xEE,'NAME',              '');
INSERT INTO Instr VALUES (0xE9,'NUMBERINDEX',       '');
INSERT INTO Instr VALUES (0xF8,'RADIOBUTTON',       '');
INSERT INTO Instr VALUES (0xB1,'SCREEN',            '(B,B)-(B,B)');
INSERT INTO Instr VALUES (0x88,'SCROLLBAR',         'W:W(B,B,B),B');
INSERT INTO Instr VALUES (0xB0,'SECTORIAL',         '(B,B)-(B,B),');
INSERT INTO Instr VALUES (0xFD,'SIMPLE',            '');
INSERT INTO Instr VALUES (0x01,'SIZE',              'B,B');
INSERT INTO Instr VALUES (0x0E,'SIZE_RELATIVE',     '');
INSERT INTO Instr VALUES (0x8A,'TABBEDNOTEBOOK',    'B,S');
INSERT INTO Instr VALUES (0xFA,'TEXT',              '');
INSERT INTO Instr VALUES (0x21,'TREE',              '(B,B)-(B,B)');
INSERT INTO Instr VALUES (0xF2,'WINDOWCOLORCLASSIC','');

