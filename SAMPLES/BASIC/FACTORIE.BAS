' Programme propos‚e par Guy Bracquez (ENCB)
' Calcul de factorielle
' Ce programme utilise pour calculer les factorielles de nombres plus grands que 30,
' La propri‚t‚ des morphismes de la fonction logarithme, ensuite on passe … la fonction
' expontentielle.
Input "Quel est le nombre dont il faut calculer la factorielle";N!
A!=0
FOR I=1 TO N!
   A!=A!+LOG(I)
NEXT
A!=A!/LOG(10.0)
E!=INT(A!)
F!=A!-E!
L!=10.0^F!
PRINT N!;"! = ";L!;"* 10 ^";E!
K%=ReadKey