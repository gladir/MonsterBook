REM Exemple d'utilisation du SGN
REM Inspir‚ du livre de L. Laurent: ®Devenir champion de programmation structur‚e et de GWBASIC¯
PRINT "    Tableau des temp‚ratures"
PRINT "journ‚e du:","signe","degr‚s"
FOR A=1 TO 6
   READ TEMP
   PRINT A,SGN(TEMP),ABS(TEMP)
NEXT
K%=ReadKey
DATA -4,5,0,-8,-2,12
