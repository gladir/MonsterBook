REM Exemple de programme de conversion de radian … cosinus
REM Inspir‚e du livre de Robert Van Loo: ®les grandes rŠgles de la programmation Basic¯
INPUT "Angle en Radiants";X!
R!=1
FOR N=8 TO 2 STEP -2
 D!=N*(N-1)
 R!=1-((X!*X!)/D!)*R!
NEXT
PRINT "Le cosinus vaut";R!
K%=ReadKey