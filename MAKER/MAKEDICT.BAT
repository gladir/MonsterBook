@ECHO OFF
REM ⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ‹
REM ≥                                                            €
REM ≥                 CrÇateur de dictionnaire                   €
REM ≥                                                            €
REM ≥ Programmeur: Sylvain Maltais                               €
REM ≥ Date:        1998-11-20                                    €
REM ≥ Ensemble:    Malte Genesis IV: Chantal                     €
REM ≥              Malte Genesis V: Adäle                        €
REM ≥ SociÇtÇ:     Les Chevaliers de Malte                       €
REM ≥                                                            €
REM ≥                                                            €
REM ≥ Description                                                €
REM ≥ ÕÕÕÕÕÕÕÕÕÕÕ                                                €
REM ≥                                                            €
REM ≥  Ce fichier "Batch" permet la crÇation de dictionnaire     €
REM ≥ utilisable par les traåtements de texte disponible avec    €
REM ≥ l'ensemble Malte Genesis IV et V: Chantal et Adäle.        €
REM ≥                                                            €
REM ≥                                                            €
REM ≥ Paramätre                                                  €
REM ≥ ÕÕÕÕÕÕÕÕÕ                                                  €
REM ≥                                                            €
REM ≥  Aucun                                                     €
REM ≥                                                            €
REM ≥                                                            €
REM ≥ Fichier requis                                             €
REM ≥ ÕÕÕÕÕÕÕÕÕÕÕÕÕÕ                                             €
REM ≥                                                            €
REM ≥  LST2DTA.EXE dans le rÇpertoire Æ\OUTPUTØ                  €
REM ≥                                                            €
REM ¿‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€

ECHO CrÇateur de dictionnaire pour l'Ensemble Malte Genesis IV et V
ECHO Tous droits rÇservÇs par les Chevaliers de Malte 1998

:A
IF EXIST \MALTE\SPELL\A.DTA GOTO B
\OUTPUT\LST2DTA \ATLAS\LISTES\A.LST \MALTE\SPELL\A.DTA
:B
IF EXIST \MALTE\SPELL\B.DTA GOTO C1
\OUTPUT\LST2DTA \ATLAS\LISTES\B.LST \MALTE\SPELL\B.DTA
:C1
IF EXIST \MALTE\SPELL\C1.DTA GOTO C2
\OUTPUT\LST2DTA \ATLAS\LISTES\C1.LST \MALTE\SPELL\C1.DTA
:C2
IF EXIST \MALTE\SPELL\C2.DTA GOTO CNOM
\OUTPUT\LST2DTA \ATLAS\LISTES\C2.LST \MALTE\SPELL\C2.DTA
:CNOM
IF EXIST \MALTE\SPELL\CNOM.DTA GOTO D
\OUTPUT\LST2DTA \ATLAS\LISTES\CNOM.LST \MALTE\SPELL\CNOM.DTA
:D
IF EXIST \MALTE\SPELL\D.DTA GOTO E
\OUTPUT\LST2DTA \ATLAS\LISTES\D.LST \MALTE\SPELL\D.DTA
:E
IF EXIST \MALTE\SPELL\E.DTA GOTO F
\OUTPUT\LST2DTA \ATLAS\LISTES\E.LST \MALTE\SPELL\E.DTA
:F
IF EXIST \MALTE\SPELL\F.DTA GOTO G
\OUTPUT\LST2DTA \ATLAS\LISTES\F.LST \MALTE\SPELL\F.DTA
:G
IF EXIST \MALTE\SPELL\G.DTA GOTO H
\OUTPUT\LST2DTA \ATLAS\LISTES\G.LST \MALTE\SPELL\G.DTA
:H
IF EXIST \MALTE\SPELL\H.DTA GOTO I
\OUTPUT\LST2DTA \ATLAS\LISTES\H.LST \MALTE\SPELL\H.DTA
:I
IF EXIST \MALTE\SPELL\I.DTA GOTO J
\OUTPUT\LST2DTA \ATLAS\LISTES\I.LST \MALTE\SPELL\I.DTA
:J
IF EXIST \MALTE\SPELL\J.DTA GOTO K
\OUTPUT\LST2DTA \ATLAS\LISTES\J.LST \MALTE\SPELL\J.DTA
:K
IF EXIST \MALTE\SPELL\K.DTA GOTO L
\OUTPUT\LST2DTA \ATLAS\LISTES\K.LST \MALTE\SPELL\K.DTA
:L
IF EXIST \MALTE\SPELL\L.DTA GOTO M
\OUTPUT\LST2DTA \ATLAS\LISTES\L.LST \MALTE\SPELL\L.DTA
:M
IF EXIST \MALTE\SPELL\M.DTA GOTO N
\OUTPUT\LST2DTA \ATLAS\LISTES\M.LST \MALTE\SPELL\M.DTA
:N
IF EXIST \MALTE\SPELL\N.DTA GOTO O
\OUTPUT\LST2DTA \ATLAS\LISTES\N.LST \MALTE\SPELL\N.DTA
:O
IF EXIST \MALTE\SPELL\O.DTA GOTO P
\OUTPUT\LST2DTA \ATLAS\LISTES\O.LST \MALTE\SPELL\O.DTA
:P
IF EXIST \MALTE\SPELL\P.DTA GOTO Q
\OUTPUT\LST2DTA \ATLAS\LISTES\P.LST \MALTE\SPELL\P.DTA
:Q
IF EXIST \MALTE\SPELL\Q.DTA GOTO R
\OUTPUT\LST2DTA \ATLAS\LISTES\Q.LST \MALTE\SPELL\Q.DTA
:R
IF EXIST \MALTE\SPELL\R.DTA GOTO S
\OUTPUT\LST2DTA \ATLAS\LISTES\R.LST \MALTE\SPELL\R.DTA
:S
IF EXIST \MALTE\SPELL\S.DTA GOTO T
\OUTPUT\LST2DTA \ATLAS\LISTES\S.LST \MALTE\SPELL\S.DTA
:T
IF EXIST \MALTE\SPELL\T.DTA GOTO U
\OUTPUT\LST2DTA \ATLAS\LISTES\T.LST \MALTE\SPELL\T.DTA
:U
IF EXIST \MALTE\SPELL\U.DTA GOTO V
\OUTPUT\LST2DTA \ATLAS\LISTES\U.LST \MALTE\SPELL\U.DTA
:V
IF EXIST \MALTE\SPELL\V.DTA GOTO W
\OUTPUT\LST2DTA \ATLAS\LISTES\V.LST \MALTE\SPELL\V.DTA
:W
IF EXIST \MALTE\SPELL\W.DTA GOTO X
\OUTPUT\LST2DTA \ATLAS\LISTES\W.LST \MALTE\SPELL\W.DTA
:X
IF EXIST \MALTE\SPELL\X.DTA GOTO Y
\OUTPUT\LST2DTA \ATLAS\LISTES\X.LST \MALTE\SPELL\X.DTA
:Y
IF EXIST \MALTE\SPELL\Y.DTA GOTO Z
\OUTPUT\LST2DTA \ATLAS\LISTES\Y.LST \MALTE\SPELL\Y.DTA
:Z
IF EXIST \MALTE\SPELL\Z.DTA GOTO Fin
\OUTPUT\LST2DTA \ATLAS\LISTES\Z.LST \MALTE\SPELL\Z.DTA
:Fin