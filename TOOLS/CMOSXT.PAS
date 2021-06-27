{Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Ce petit utilitaire permet de connaŒtre le modŠle CMOS install‚ sur un
 XT s'il est existe.
}

{$I ..\Library\Memories\Cmos\CmosXT.Inc}

BEGIN
 WriteLn('D‚tecteur de CMOS XT  Tous droits r‚serv‚s par les Chevaliers de Malte  1995');
 WriteLn;
 WriteLn('Analyse en cours...');
 Case(CmosXT)of
  ctrlCmosUnknown:WriteLn('Contr“leur CMOS RTC de modŠle inconnu');
  ctrlCmosMM58167a:WriteLn('Contr“leur CMOS RTC MM58167 (2C0h … 2DFh)');
  ctrlCmosMM58167b:WriteLn('Contr“leur CMOS RTC MM58167 (2C0h … 2C7h)');
  ctrlCmosRTC58321:WriteLn('Contr“leur RTC-58321 (2C0h … 2C1h)');
  ctrlCmosMC146818:WriteLn('Contr“leur CMOS RTC MC146818 de Motorola');
  Else WriteLn('Pas de contr“leur CMOS RTC');
 End;
END.