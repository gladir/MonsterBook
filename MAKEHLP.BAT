@REM ������������������������������������������������������������������
@IF NOT EXIST \OUTPUT\GAT2HLP.EXE BPC GAT2HLP /B -DMouse -DOverlay -DGraf -DShortBF -DH
@REM �����������������������������������������
@REM MonsterBook - Vous n'avez pas sauvegarder
@REM �����������������������������������������
@\OUTPUT\GAT2HLP \MALTE\TEXT\PROJETMA.LTE\MONSTERB.OOK\NOTSAVE.GAT
@COPY \MALTE\TEXT\PROJETMA.LTE\MONSTERB.OOK\NOTSAVE.HLP \MALTE\HLP\NOTSAVE.HLP
@DEL \MALTE\TEXT\PROJETMA.LTE\MONSTERB.OOK\NOTSAVE.HLP
@REM ������������������������������
@REM MonsterBook - Aide sur HexView
@REM ������������������������������
@\OUTPUT\GAT2HLP \MALTE\TEXT\PROJETMA.LTE\MONSTERB.OOK\HEXVIEW.GAT
@COPY \MALTE\TEXT\PROJETMA.LTE\MONSTERB.OOK\HEXVIEW.HLP \MALTE\HLP\HEXVIEW.HLP
@DEL \MALTE\TEXT\PROJETMA.LTE\MONSTERB.OOK\HEXVIEW.HLP
@REM ���������������������������������������������������
@REM MonsterBook - Aide sur la Calculatrice programmable
@REM ���������������������������������������������������
@\OUTPUT\GAT2HLP \MALTE\TEXT\PROJETMA.LTE\MONSTERB.OOK\CALPROG.GAT
@COPY \MALTE\TEXT\PROJETMA.LTE\MONSTERB.OOK\CALPROG.HLP \MALTE\HLP\CALPROG.HLP
@DEL \MALTE\TEXT\PROJETMA.LTE\MONSTERB.OOK\CALPROG.HLP
@REM ���������������������������������������������
@REM MonsterBook - Aide sur l'information des Pays
@REM ���������������������������������������������
@\OUTPUT\GAT2HLP \MALTE\TEXT\PROJETMA.LTE\MONSTERB.OOK\INFPAYS.GAT
@COPY \MALTE\TEXT\PROJETMA.LTE\MONSTERB.OOK\INFPAYS.HLP \MALTE\HLP\INFPAYS.HLP
@DEL \MALTE\TEXT\PROJETMA.LTE\MONSTERB.OOK\INFPAYS.HLP
@REM ������������������������������������������
@REM MonsterBook - Aide sur l'information Vid�o
@REM ������������������������������������������
@\OUTPUT\GAT2HLP \MALTE\TEXT\PROJETMA.LTE\MONSTERB.OOK\INFVID.GAT
@COPY \MALTE\TEXT\PROJETMA.LTE\MONSTERB.OOK\INFVID.HLP \MALTE\HLP\INFVID.HLP
@DEL \MALTE\TEXT\PROJETMA.LTE\MONSTERB.OOK\INFVID.HLP
@REM ���������������������������������������������
@REM MonsterBook - Aide des combinaisons de Touche
@REM ���������������������������������������������
@\OUTPUT\GAT2HLP \MALTE\TEXT\PROJETMA.LTE\MONSTERB.OOK\KEY.GAT
@COPY \MALTE\TEXT\PROJETMA.LTE\MONSTERB.OOK\KEY.HLP \MALTE\HLP\KEY.HLP
@DEL \MALTE\TEXT\PROJETMA.LTE\MONSTERB.OOK\KEY.HLP
@REM ������������������������������������������������������������������
@IF NOT EXIST \OUTPUT\MKBESCH.EXE BPC MKBESCH /B -DMouse -DOverlay -DGraf -DShortBF -DH
@REM ����������������������������������������������
@REM MonsterBook - Cr�ation du Bescherelle de Verbe
@REM ����������������������������������������������
@\OUTPUT\MKBESCH
