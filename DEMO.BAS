REM D‚monstrateur du Basic PRO
REM Tous droits r‚serv‚s par les Chevaliers de Malte 1997
REM Programmeur: Sylvain Maltais
SCREEN14:BytesPerLine640':PAGE 1:'MLOAD"MEDIEVAL.FNT"
COLOR 9,0:HPRINT(10,0),"þþþþ Basic PRO þþþþ",SHADOW
COLOR 12,0:HPRINT(5,2),"D‚monstrateur d'effet sp‚ciaux",SHADOW
COLOR 14,0:HPRINT(5,5),"Programmeur:",SHADOW:HPRINT(5,6),"Sylvain Maltais",SHADOW
COLOR 15:HPRINT(5,10),"VIVE PASCAL! FUCK C/C++!!!!",SHADOW
Y=0:P%=128:WHILE Y<=200
 Y=Y+2:IF(INSTAT)THEN 10
 VScale Y:Palette 9,0,0,P%:P%=128+((P%+3)AND &H7F):WaitRetrace
WEND
10' FOR I%=0TO38:WAITRETRACE:NEXT:X=0:XDir=1:WHILE X<=640
' X=X+8:IF(INSTAT)THEN 20
' Palette 9,0,0,P%:P%=128+((P%+3)AND&H7F):HScale X:WaitRetrace
'WEND
'20 'K%=ReadKey
'SCREEN0:WIDTH 80:END