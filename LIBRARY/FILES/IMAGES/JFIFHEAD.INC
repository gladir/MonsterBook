{\Source\Chantal\Library\Files\Images\JFIFHead.Inc}

Type
 {Entˆte de fichier JFIF}
 HeaderJFIF=Record
  Sign:Array[0..3]of Char;{Signature "JFIF"}
  Ver,SubVer,DensityUnit:Byte;{Version, sous-version,Nombre de couleur dans l'image}
  NumXPixels,NumYPixels:Word;{Taille de l'image horizontal et vertical}
 End;