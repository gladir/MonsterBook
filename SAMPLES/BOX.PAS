{ Description
  ÕÕÕÕÕÕÕÕÕÕÕ

   Ce petit programme est un dÇmonstrateur visant Ö montrer les diffÇrentes
  forme de modäle de boåte disponible avec l'ensemble Malte Genesis.
}

Program Box;

Uses Adele,Systex,Systems,Video;

BEGIN
 InitSystems(suIsabel);
 SetVideoModeDeluxe(vmTxtDef);
 PutTxtCenter(0,__Justified__,'Modäle diffÇrents de boåte',Yellow);
 SetBorderAvenger;
 PutFillBorder(2,2,NmXTxts shr 1,NmYTxts shr 1,(Blue shl 4)+White);
 PutTxtXYUnKr((NmXTxts shr 2)-(Length('Avenger')shr 1),NmYTxts shr 2,'Avenger');
 SetBorderDouble;
 PutFillBorder((NmXTxts shr 1)+2,2,NmXTxts-2,NmYTxts shr 1,(LightBlue shl 4)+White);
 PutTxtXYUnKr((NmXTxts shr 1)+(NmXTxts shr 2)-(Length('Double')shr 1),NmYTxts shr 2,'Double');
 SetBorderSimple;
 PutFillBorder(2,(NmYTxts shr 1)+2,NmXTxts shr 1,NmYTxts-4,(Green shl 4)+White);
 PutTxtXYUnKr((NmXTxts shr 2)-(Length('Simple')shr 1),
              -1+(NmYTxts shr 1)+NmYTxts shr 2,'Simple');
 SetBorderSimpleLuxe;
 PutFillBorder((NmXTxts shr 1)+2,(NmYTxts shr 1)+2,NmXTxts-2,NmYTxts-4,(LightBlue shl 4)+White);
 PutTxtXYUnKr((NmXTxts shr 1)+(NmXTxts shr 2)-(Length('Simple Luxe')shr 1),
              -1+(NmYTxts shr 1)+NmYTxts shr 2,'Simple Luxe');
  { Terminaison habituel }
 PutTxtXY(2,MaxYTxts,'Presse une touche pour quitter...',LightRed);
 ReadKey;
 DoneLuxeVideo;
 DoneSystems;
END.