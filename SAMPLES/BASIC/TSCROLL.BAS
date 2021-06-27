REM D‚monstrateur de d‚filement d'‚cran sous le Basic PRO
REM Tous droits r‚serv‚s par les Chevaliers de Malte 1997
REM Programmeur: Sylvain Maltais
SCREEN0:WIDTH80:COLOR7,0
BytesPerLine(320)            'Instruction suppl‚mentaire pour faire ‚largir les bandes ‚cran en 320/2=160 caratŠres de large
FillBox(0,0)-(159,49),7,"-"  'Permet de cr‚er une boŒte avec un caractŠre sp‚cifique
Y=0:YDir=1
FOR J%=0TO 49:FOR I%=0TO 15:HPRINT(I%*10,J%),I%:NEXT I%:NEXT
WHILE INSTAT=0
 Y=Y+YDir
 IF Y<=0 OR Y>=NumYTexts*16THEN YDir=-YDir
 VScale Y
WEND
K%=ReadKey:X=0:XDir=1
WHILE INSTAT=0
 X=X+XDir
 IF X<=0OR X>=WIDTH*9THEN XDir=-XDir
 HScale X
WEND
K%=ReadKey
WHILE INSTAT=0
 X=X+XDir:Y=Y+YDir
 IF X<=0OR X>=WIDTH*9THEN XDir=-XDir
 IF Y<=0OR Y>=NumYTexts*16THEN YDir=-YDir
 VScale Y
 HScale X
WEND
K%=ReadKey
FillBox(0,0)-(159,49),&H70,"þ"
PAGE 1:FillBox(0,0)-(159,49),7,"-"
FOR J%=1TO 50:FOR I%=1TO 16:LOCATE J%,I%*10-9:PRINT I%;:NEXT:NEXT
X=0:XDir=1:Y=0:YDir=1:I=0:IDir=1
WHILE INSTAT=0
 X=X+XDir:Y=Y+YDir:I=I+IDir
 IF X<=0OR X>=WIDTH*9THEN XDir=-XDir
 IF Y<=0OR Y>=NumYTexts*16THEN YDir=-YDir
 IF I<=0OR I>=NumYTexts*16THEN IDir=-IDir
 SplitScreen I
 VScale Y
 HScale X
WEND
SCREEN0