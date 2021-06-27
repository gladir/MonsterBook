{\Source\Chantal\Library\Compiler\Pascal\QPUHeader.Inc}

{Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fichier contient les structures de base pour permettre une
 compilation ou d‚compilation d'un unit‚ QuickPascal.
}

Const
 QPUSignMicrosoft='MSQP';    { Signature normal, celle de Microsoft}

Type
 QPUHeader=Record
  Sign:Array[0..3]of Char;   { Signature de l'unit‚ Microsoft QuickPascal: ®MSQP¯}
  Data1:Array[4..9]of Byte;  { R‚serv‚s pour un usage inconnue ??????}
  NmUses:Word;               { Nombre d'Unit‚ r‚f‚renc‚ par cette unit‚: ®Uses ...,...¯}
  Data2:Array[12..23]of Byte;{ R‚serv‚s pour un usage inconnue ??????}
  SizeIncludeFiles:Word;     { Taille des fichiers inclue lors de la compilation}
  Data3:Array[26..34]of Byte;{ R‚serv‚s pour un usage inconnue ??????}
  UnitName:String[8];        { Nom de l'unit‚: ®Unit ...¯}
 End;

 QPUUses=Record
  Data:Array[0..2]of Byte;   { Donn‚e inconnue? }
  Name:String[8];            { Nom de l'unit‚ de l'ensemble ®Uses ...¯}
 End;