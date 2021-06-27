@If Not Exist \Malte\Systems\StartUp.RLL Call RLL\MakeRLL.Bat
@If Exist \OutPut\MB.EXE Goto CpyMB
@REM Cr‚er d'abord les ressources .RC en Pascal
@CALL MakeRC.BAT
@REM Compiler le MonsterBook
@BPC \Source\Chantal\MB /B -$O+ -DMouse -DOverlay -DGraf -DShortBF -DDebug -DH -DLuxeExtra
:CpyMB
@CD\OUTPUT
@REM LZEXE MB.EXE
@CD\Source\Chantal
@REM Copy /B \OutPut\MB.EXE+\OutPut\MB.OVR \Malte\MB.EXE
@\OUTPUT\EXECVOLU.EXE \OUTPUT\MB.EXE MBRES.RC
@Copy \OUTPUT\MB.EXE \MALTE\MB.EXE