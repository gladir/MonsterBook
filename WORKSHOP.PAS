Unit WorkShop;

INTERFACE

Uses Systex,Wintex;

Const
  { Ressource }
  NbrNiveauMax=6; { Nombre de niveaux maximum }

Type
 TypeRsrcEnteteNiveau=Record
  NbrEntree:Word; { Nombre d'entr‚e dans ce niveau }
 End;

  { Une entr‚e de ressource : r‚pertoire ou ressource (Taille = 12 octets) }
 TypeRsrcUneEntree=Record
  TypeRepert:Boolean;     { R‚pertoire : TRUE / FALSE -> Ressource        }
  NomExiste:Boolean;      { L'offset du nom pointe vers un nom ou alors   }
                          { c'est un type de ressource ?                  }
  LongNom:Word;           { Longueur du nom                               }
  OfstNom:LongInt;        { Offset du nom                                 }
  Ofst:LongInt;           { Si c'est un sous-r‚pertoire : offset de       }
                          { l'en-tˆte du prochain niveau                  }
                          { Si c'est une ressource : Offset de l'entˆte   }
 End;                     { de la ressource                               }

  { Un ressource (Taille = 8 octets) }
 TypeRsrcUneRsrc=Record
  OfstDonnee:LongInt;   { Offset des donn‚es (dans le fichier)          }
  TailleDonnee:LongInt; { Taille des donn‚es                            }
 End;

 WorkShopApp=Record
  W:Window;
  Format:(fNone,fPE,fWin16);
  Path:String;
  IndexRessource,IndexHeader,IndexName:RBuf;
  PosRes:Array[0..1023]of Word;
  Handle:Hdl;
  FilePos:LongInt;
  OfstRessource:LongInt;       { Offset des ressources (dans le fichier) }
  PEEnteteExeDos:PETypeHeaderExeDos;
  PEEntetePE:PETypeHeaderPE;
  PEEnteteOptionnelPE:PETypeHeaderOptionnelPE;
  PEEnteteSection:PETypeHeaderSection;
  IndexSection:Byte;           { Index de la section en cours }
  RvaSectionTmp:LongInt;       { RVA d'une section }
  Niveau:Word;                 { Niveau actuel dans les ressoures }
  EnteteNiveau:Array[0..NbrNiveauMax-1]of TypeRsrcEnteteNiveau;
  PEEnteteRessource:Array[0..NbrNiveauMax-1]of PETypeHeaderRessource;
  PERepertoireRes:PETypeDirRes;
  PosListeRes:Array[0..NbrNiveauMax-1]of Word;
  UneEntree:TypeRsrcUneEntree;
  OfstNiveau: Array[0..NbrNiveauMax-1]of LongInt;
  SauvePosFichNiv:Array[0..NbrNiveauMax-1]of LongInt;
  PEEnteteUneRes:PETypeHeaderUneRes;
  UneRessource:TypeRsrcUneRsrc; { Une ressource }
   { Liste de toutes les ressources }
(*  ListeRes:Record
    { Tampon des entr‚es et ressources }
   TailleTampon:LongInt;
   Handle:LongInt;
    { Tampon des noms }
   TailleTamponNom:LongInt;
   HandleNom:LongInt;
  End;*)
  Err:Word; { 0: Aucune erreur
              1: Le fichier est trop petit
              2: Le fichier n'est pas un ex‚cutable
              3: Le programme n'est pas un ex‚cutable Windows
              4: Le fichier est un ex‚cutable NE (16 bits) et non PE (32 bits)
              5: Le fichier est un ex‚cutable LE et non PE
              6: Signature inconnue
              7: Type de processeur incorrect ou inconnu
              8: Signature invalide
              9: Type de sous-systŠme recquis incorrect ou inconnu
              10: Section ressource introuvable!
              11: Offset invalide
            }
 End;

Function  WSInit(Var Context;X1,Y1,X2,Y2:Byte):Bool;
Procedure WSLoad(Var Context;X1,Y1,X2,Y2:Byte;Const Path:String);
Procedure WSRefresh(Var Context);
Function  WSRun(Var Context):Word;
Function  WSDone(Var Context):Word;

IMPLEMENTATION

Uses Adele,Systems,Video,Dials;

Procedure _GetRec(Var Q:WorkShopApp;Size:Word;Var Buffer);Begin
 Systems._GetAbsRec(Q.Handle,Q.FilePos,Size,Buffer);
 Inc(Q.FilePos,Long(Size));
End;

Procedure SetFilePos(Var Q:WorkShopApp;Pos:Long);Begin
 Systems.SetFilePos(Q.Handle,Pos);
 Q.FilePos:=Pos;
End;

Function PENomCpuRecquis(CPU:Word):String;Begin
 PENomCpuRecquis:='';
 Case(CPU)of
  $0000:PENomCpuRecquis:='inconnu';
  $014C:PENomCpuRecquis:='Intel 80386 ou sup‚rieur';
  $014D:PENomCpuRecquis:='Intel 80486 ou sup‚rieur';
  $014E:PENomCpuRecquis:='Intel Pentium ou sup‚rieur';
  $0160:PENomCpuRecquis:='R3000 (MIPS), big endian';
  $0162:PENomCpuRecquis:='R3000 (MIPS), little endian';
  $0166:PENomCpuRecquis:='R4000 (MIPS), little endian';
  $0168:PENomCpuRecquis:='R10000 (MIPS), little endian';
  $0184:PENomCpuRecquis:='DEC Alpha AXP';
  $01F0:PENomCpuRecquis:='IBM Power PC, little endian';
 End;
End;

Function PENomSousSystem(SousSystemRecquis:Word):String;Begin
 PENomSousSystem:='';
 Case(SousSystemRecquis)of
  1:PENomSousSystem:='Aucun';
  2:PENomSousSystem:='Sous-systŠme graphique';
  3:PENomSousSystem:='Console Windows';
  4:PENomSousSystem:='Console OS/2';
  5:PENomSousSystem:='Console POSIX';
 End;
End;

Function PENomRepertoire(IndexRep:Byte):String;
Var
 TmpTxt:String[3];
Begin
 Case(IndexRep)of
   1:PENomRepertoire:='Symboles export‚s';
   2:PENomRepertoire:='Symboles import‚s';
   3:PENomRepertoire:='Ressources';
   4:PENomRepertoire:='Exceptions';
   5:PENomRepertoire:='S‚curit‚';
   6:PENomRepertoire:='Table r‚allocation de base';
   7:PENomRepertoire:='D‚bogage';
   8:PENomRepertoire:='Droits d''auteur'; { Copyright }
   9:PENomRepertoire:='Valeur de la machine'; { MIPS GP }
  10:PENomRepertoire:='Table TLS';
  11:PENomRepertoire:='Configuration de chargement';
  12:PENomRepertoire:='''Bound'' import‚s';
  13:PENomRepertoire:='Adresses des imports';
  Else Begin
   System.Str(IndexRep,TmpTxt);
   PENomRepertoire:='inconnu (='+TmpTxt+')';
  End
 End;
End;

Function PENomCaracteristique(Caract:LongInt):String;Begin
 If Caract=0Then PENomCaracteristique:='(aucune)'Else
 If(Caract)and$F00FFFFF=$60000020Then PENomCaracteristique:='code'Else
 If(Caract)and$F00FFFFF=$40000040Then PENomCaracteristique:='donn‚es'Else
 If(Caract)and$F00FFFFF=$50000040Then PENomCaracteristique:='donn‚es partag‚es'Else
 If(Caract)and$F00FFFFF=$C0000040Then PENomCaracteristique:='variables'Else
 If(Caract)and$F00FFFFF=$C0000000Then PENomCaracteristique:='lecture + ‚criture'Else
 If(Caract)and$F00FFFFF=$E0000020Then PENomCaracteristique:='CODE (+ variables)'
                                 Else PENomCaracteristique:=HexLong2Str(Caract);
End;

Function PENomTypeRessource(IndexRes:LongInt):String;
Var
 TmpTxt:String[12];
Begin
 Case(IndexRes)of
  -1:PENomTypeRessource:='-und‚finie-';
  rtCursor:PENomTypeRessource:='Curseur';
  rtBitmap:PENomTypeRessource:='Bitmap';
  rtIcon:PENomTypeRessource:='Ic“ne';
  rtMenu:PENomTypeRessource:='Menu';
  rtDialog:PENomTypeRessource:='Dialogue';
  rtString:PENomTypeRessource:='ChaŒne de caractŠres';
  rtFontDir:PENomTypeRessource:='R‚pertoire de polices';
  rtFont:PENomTypeRessource:='Police';
  rtAccelerator:PENomTypeRessource:='Acc‚l‚rateurs';
   10:PENomTypeRessource:='Donn‚e non-format‚e';
   11:PENomTypeRessource:='Table des messages';
   12:PENomTypeRessource:='Groupe de curseurs';
   14:PENomTypeRessource:='Groupe d''ic“ne';
  rtVersion:PENomTypeRessource:='Informations de version';
  rtTaskBar:PENomTypeRessource:='Barre des tƒches';
  Else Begin
   System.Str(IndexRes,TmpTxt);
   PENomTypeRessource:='inconnu='+TmpTxt;
  End
 End;
End;

Function PELitTxtUnicode(Var Q:WorkShopApp;Var Txt:String;LitLongTxt:Boolean;
                         LongMax:Integer;Var VraiLongTxt:Word):Boolean;
Var
 i:Byte;
 TmpM:Word;
 SauvePosFich:LongInt;
Begin
  { Pour l'instant la chaŒne renvoy‚e n'est pas un nombre }
 PELitTxtUnicode:=True;
  { RŠgle la longueur maximum }
 If(LongMax<=0)or(255<LongMax)Then LongMax:=255;
 If(LitLongTxt)Then Begin
   { Lit la longueur du nom, puis la sauve }
  _GetRec(Q,2,TmpM);
  SauvePosFich:=Q.FilePos;
  VraiLongTxt:=TmpM;
  If(LongMax<TmpM)Then Txt[0]:=Chr(LongMax)
                  Else Txt[0]:=Chr(TmpM);
   { Lit le texte }
  i:=1;
  While i<=length(Txt)do Begin
   _GetRec(Q,2,TmpM);
   Txt[i]:=Chr(TmpM);
   Inc(i);
  End;
   { Va … la fin du texte (avec sa vrai longueur }
  SetFilePos(Q,SauvePosFich+VraiLongTxt shl 1);
 End
  else
 Begin
   { Lit le premier caractŠre }
  _GetRec(Q,2,TmpM);
   { Est-il ‚gal … FFFFh ? Si oui on a affaire … un nombre (sur 2 octets) }
  If(TmpM<>$FFFF)Then Begin
    { Lit le texte jusqu'au caractŠre #0 ou            }
    { jusqu'… ce que la longueur maximum soit atteinte }
   Txt[1]:=Chr(TmpM);
   i:=1;
   While(Txt[i]<>#0)and(i-1<LongMax)do Begin
    _GetRec(Q,2,TmpM);
    inc(i);
    txt[i]:=chr(TmpM);
   End;
   txt[0]:=chr(i-1);
   VraiLongTxt:=i-1;
    { Va jusqu'… la fin du texte }
   If(i-1=LongMax)and(Txt[i]<>#0)Then begin
    TmpM:=1;
    While(TmpM<>$0000)do begin
     _GetRec(Q,2,TmpM);
     Inc(VraiLongTxt);
    End;
   End;
  End
   Else
  Begin
    { Premier mot = FFFFh -> C'est un nombre (2 octets) }
   _GetRec(Q,2,TmpM);
   VraiLongTxt:=TmpM;
   System.Str(VraiLongTxt,txt);
   PELitTxtUnicode:=No;
  End;
 End;
End;

Function PELitNomRessource(Var Q:WorkShopApp;OfstDepuisRes:LongInt):String;
Var
 SauvePosFich:LongInt;
 TmpM:Word;
 Txt:String;
Begin
  { Se positionne … l'offset du nom }
 SauvePosFich:=Q.FilePos;
 SetFilePos(Q,OfstDepuisRes);
  { Lit le nom }
 PELitTxtUnicode(Q,Txt,TRUE,-1,TmpM);
  { Sauve le nom complet }
 PELitNomRessource:=Txt;
  { Revient … la position sauv‚e }
 SetFilePos(Q,SauvePosFich);
end;

Procedure PELitEnteteDos(Var Q:WorkShopApp);Begin
  { V‚rifie la taille du fichier }
 If FileSize(Q.Handle)<SizeOf(PETypeHeaderExeDos)Then Q.Err:=1;
  { Lit l'entˆte DOS }
 _GetRec(Q,SizeOf(PETypeHeaderExeDos),Q.PEEnteteExeDos);
  { Le fichier est un ex‚cutable ? }
 If Q.PEEnteteExeDos.Signature<>$5A4D{'MZ'}Then Q.Err:=2;
  { Le fichier est un ex‚cutable Windows ? }
 If Q.PEEnteteExeDos.OfstReallocation<>$0040Then Q.Err:=3;
 { Se positionne … l'entˆte PE }
 SetFilePos(Q,Q.PEEnteteExeDos.OfstEntetePE);
 Q.FilePos:=Q.PEEnteteExeDos.OfstEntetePE;
End;

Procedure PELitEntetePE(Var Q:WorkShopApp);Var Txt:String;Begin
 PELitEnteteDos(Q); { Lit l'en-tˆte DOS puis se positionne … l'entˆte PE }
  { Lit l'en-tˆte PE puis le v‚rifie }
 _GetRec(Q,SizeOf(PETypeHeaderPE),Q.PEEntetePE); { Lit l'en-tˆte }
  { Est-ce bien la signature PE ? }
 If(Q.PEEntetePE.Signature<>SignaturePE)Then Begin
  If(Q.PEEntetePE.Signature and $FFFF=SignatureNE)Then Q.Err:=4; { Signature NE ? }
  If(Q.PEEntetePE.Signature=SignatureLE)Then Q.Err:=5; { Signature LE ? }
  Q.Err:=6;                               { Autre : signature inconnue }
 End;
  { V‚rifie l'entˆte }
 Txt:=PENomCpuRecquis(Q.PEEntetePE.CPU);
 If Txt=''Then Q.Err:=7;
  { Lit l'en-tˆte PE optinnel puis le v‚rifie }
 _GetRec(Q,SizeOf(PETypeHeaderOptionnelPE),Q.PEEnteteOptionnelPE);
  { V‚rifie l'en-tˆte optionnel }
 If Q.PEEnteteOptionnelPE.Signature<>$010BThen Q.Err:=8;
 Txt:=PENomSousSystem(Q.PEEnteteOptionnelPE.SousSystemeRecquis);
 If Txt=''Then Q.Err:=9;
End;

Function ChercheOfstRessource(Var Q:WorkShopApp):LongInt;
Var
 SauvePosFich:LongInt;
 Txt:String;
Begin
 ChercheOfstRessource:=-1; { Pour l'instant l'offset est introuvable }
 If Q.PEEntetePE.NbrSection=0Then Exit; { Il y a-t-il au moins une section ? }
 SauvePosFich:=Q.FilePos; { Sauvegarde la position du fichier }
 { Initialise l'offset RVA des sections }
 Q.RvaSectionTmp:=Q.PEEnteteOptionnelPE.RvaCode;
 { Scanne toutes les sections … la recherche }
 { de celle nomm‚e 'CODE' ou '.code'         }
 Q.IndexSection:=1;Txt:='';
 While Q.IndexSection<Q.PEEntetePE.NbrSection+1do Begin
  _GetRec(Q,SizeOf(PETypeHeaderSection),Q.PEEnteteSection);
  MoveLeft(Q.PEEnteteSection.Nom,Txt[1],8); Txt[0]:=#8;
  Txt:=StrUp(Trim(Txt));
  If Pos('RSRC',txt)<>0Then Begin
   { Renvoie la position de la section }
   ChercheOfstRessource:=Q.PEEnteteSection.PosDonnee;
   { Revient … la position sauvegard‚e du fichier }
   SetFilePos(Q,SauvePosFich);
   Exit;
  End;
  Inc(Q.IndexSection);
  Inc(Q.RvaSectionTmp,Q.PEEnteteSection.TailleVirtuelle);
 End;
 { Revient … la position sauvegard‚e du fichier }
 SetFilePos(Q,SauvePosFich);
End;

Procedure CreeListeRessource(Var Q:WorkShopApp);
Const
  { Ressource }
  NbrNiveauMax = 6;                    { Nombre de niveaux maximum           }
  TailleUnBlocRes = 5 { Ko };          { Taille d'un bloc de ressource : le  }
                                       { tampon est allou‚ par bloc de 5 Ko  }
Label
  NouveauNiveau,DescendNiveau;
Var
 SauvePosFich:LongInt;
 ProchainOfstLibre:LongInt;
 OfstCourant:Array[0..NbrNiveauMax-1]of LongInt;
                                       { Offset courant d'un certain niveau  }
 IndexRes:Array[0..NbrNiveauMax-1]of Word;
 TmpL:LongInt;
 Txt:String;
Begin
{ With Q.ListeRes. do} Begin
  SauvePosFich:=Q.FilePos;
   { Initialise les donn‚es : Niveau=Root (0), Taille=0 }
  Q.Niveau:=0;
  OfstCourant[Q.Niveau]:=0;
  ProchainOfstLibre:=0;
   { Alloue les tampons }
{  TmpL:=TailleUnBlocRes;
  if MemXmsLibre<TmpL*2 then
    StopProgram ('l''allocation du tampon des ressources','M‚moire libre insuffisante');
  Handle := AlloueMemXms (TmpL);
  TestErreurXms ('l''allocation du tampon des ressources');
  HandleNom := AlloueMemXms (TmpL);
  TestErreurXms ('l''allocation du tampon des noms');
  with CopieXms do begin
   DstHdl := Handle;
   DstOfs := 0;
  end;
  with CopieXmsNom do begin
   DstHdl := HandleNom;
   SrcOfs := Ptr2Long( @txt[1] );
   DstOfs := 0;
  end;}
NouveauNiveau:
  { ============ NOUVEAU NIVEAU ============= }
  { Lit l'entˆte du niveau (nombre d'entr‚es) }
  IndexRes[Q.Niveau] := 0;
  _GetRec(Q,SizeOf(PETypeHeaderRessource),Q.PEEnteteRessource[Q.Niveau]);
   { Ecrit l'entˆte niveau }
  With Q.EnteteNiveau[Q.Niveau]do With Q.PEEnteteRessource[Q.Niveau]do
   NbrEntree:=NbrEntreeNommee+NbrEntreeIndexee;
   RBAddBlock(Q.IndexHeader,SizeOf(TypeRsrcEnteteNiveau),Q.EnteteNiveau[Q.Niveau]);
(*  with CopieXms do begin
    Taille := SizeOf(TypeRsrcEnteteNiveau);
    SrcOfs := Ptr2Long( @EnteteNiveau[Niveau] );
    DstOfs := ProchainOfstLibre;

    { Calcul l'offset des entr‚es du niveau }
    inc (ProchainOfstLibre, Taille);
    OfstCourant[Niveau] := ProchainOfstLibre;

    { Calcul le prochain offset libre }
    inc (ProchainOfstLibre, EnteteNiveau[Niveau].NbrEntree*SizeOf(TypeRsrcUneEntree));

    { Est-ce que le tampon est trop petit ? Si c'est le cas l'agrandi }
    VerifieTailleTampon (Handle, TailleTampon, ProchainOfstLibre);
  end;
  CopieMemXms (CopieXms); TestErreurXms ('l''‚criture de l''entˆte niveau');
*)
DescendNiveau:
   { Traite une entr‚e aprŠs l'autre. Si un sous-r‚pertoire est trouv‚ : }
   { rentre dedans ! }
  With Q.PEEnteteRessource[Q.Niveau]do While IndexRes[Q.Niveau]<NbrEntreeNommee+NbrEntreeIndexee do Begin
    { ============ NOUVELLE ENTREE ============= }
   Inc(IndexRes[Q.Niveau]);
   _GetRec(Q,SizeOf(PETypeDirRes),Q.PERepertoireRes);
   With Q.PERepertoireRes do Begin
     { Pour l'instant, on a un nom }
    Q.UneEntree.NomExiste:=Ya;
     { Cr‚e le nom }
    If Ofst shr 31<>0Then Begin
     If Nom shr 31=0Then Begin
      { Pas de nom, mais un index }
      Q.UneEntree.NomExiste:=No;
      Q.UneEntree.OfstNom:=Nom;
      { Lit le nom dans le fichier }
     End
      Else
     Txt:=PELitNomRessource(Q,Q.OfstRessource+Nom and $7FFFFFFF);
    End
     Else
    Begin
     Q.UneEntree.NomExiste:=No;
     Q.UneEntree.OfstNom:=-Nom;
    End;
     { Si le nom existe : l'‚crit dans le tampon }
    If(Q.UneEntree.NomExiste)Then Begin
     If 60<length(txt)Then Delete(txt,60,length(txt)-60);
     Q.UneEntree.LongNom:=Length(txt);
      { Ecrit le nom dans le tampon des noms }
     If length(txt)and 1=1Then Txt[0]:=Chr(Length(txt)+1);
     RBAddStr(Q.IndexName,Txt);
(*   With CopieXmsNom do Begin
      If length(txt)and 1=1Then Txt[0]:=Chr(Length(txt)+1);
      Taille:=length(txt);
     End;
     CopieMemXms(CopieXmsNom);
     TestErreurXms ('l''‚criture d''un nom de ressource');*)
    End;
     { Ecrit l'entr‚e }
    With Q.UneEntree do Begin
     { Est-ce un r‚pertoire ou une ressource ? }
     TypeRepert:=Q.PERepertoireRes.Ofst shr 31=1;
     Ofst:=ProchainOfstLibre;
     { Offset du nom }
    If(NomExiste)Then Begin
     RBAddStr(Q.IndexName,Txt);
     (*With CopieXmsNom do Begin
       OfstNom:=DstOfs;
       Inc(DstOfs,Taille);
        { Est-ce que le tampon des noms est trop petit ? }
        { Si c'est le cas : l'agrandi                    }
       VerifieTailleTampon(HandleNom,TailleTamponNom,DstOfs);
      End;*)
     End;
    End;
    RBAddBlock(Q.IndexRessource,SizeOf(TypeRsrcUneEntree),Q.UneEntree);
(*   With CopieXms do begin
     Taille:=SizeOf(TypeRsrcUneEntree);
     SrcOfs:=Ptr2Long(@UneEntree);
     DstOfs:=OfstCourant[Niveau];
      { Ajoute la taille de l'entr‚e … l'offset du niveau courant }
     Inc(OfstCourant[Niveau],Taille);
    End;
    CopieMemXms (CopieXms); TestErreurXms ('l''‚criture d''une entr‚e');*)
     { Est-ce un sous-r‚pertoire ? Si oui, monte d'un niveau }
    If Ofst shr 31=1Then Begin
      { Rentre dans un r‚pertoire }
     Q.SauvePosFichNiv[Q.Niveau]:=Q.FilePos;
     TmpL:=Q.OfstRessource+Ofst and $7FFFFFFF;
     If(FileSize(Q.Handle)<TmpL)Then Q.Err:=11
                                Else SetFilePos(Q,TmpL);
      { Change de niveau }
     Inc(Q.Niveau);
     Goto NouveauNiveau;
    End;
   End;
  End;
  { ============ FIN DU NIVEAU ============= }
  { Le niveau courant est trait‚ : redescent d'un niveau (si nous ne sommes }
  { pas dans le niveau ROOT)                                                }
  If Q.Niveau<>0Then With Q.PERepertoireRes do begin
   { Est-ce le bo–t (une ressource) }
   if Ofst shr 31=0 then begin
    { Lit une ressource }
    TmpL:=Q.OfstRessource+Ofst and $7FFFFFFF;
    If(FileSize(Q.Handle)<TmpL)Then Q.Err:=11
                               Else SetFilePos(Q,TmpL);
    _GetRec(Q,SizeOf(PETypeHeaderUneRes),Q.PEEnteteUneRes);
    { Ecrit l'entr‚e }
    Q.UneRessource.OfstDonnee:=Q.PEEnteteUneRes.Ofst;
    Q.UneRessource.TailleDonnee:=Q.PEEnteteUneRes.Taille;
    RBAddBlock(Q.IndexRessource,SizeOf(PETypeHeaderUneRes),Q.PEEnteteUneRes);
{    WriteLn(Q.UneRessource.OfstDonnee,' ',Q.UneRessource.TailleDonnee);}
(*    with CopieXms do begin
     Taille := SizeOf(PE_TypeEnteteUneRes);
     SrcOfs := Ptr2Long( @PE_EnteteUneRes );
     DstOfs := ProchainOfstLibre;
      { Ajoute la taille de l'entˆte ressource au prochain offset libre }
     inc (ProchainOfstLibre, Taille);
      { Est-ce que le tampon est trop petit ? Si c'est le cas l'agrandi }
     VerifieTailleTampon (Handle, TailleTampon, ProchainOfstLibre);
    end;
    CopieMemXms (CopieXms); TestErreurXms ('l''‚criture d''une ressource');*)
     { La ressource est d‚sormais lue }
    Ofst:=$FFFFFFFF;
   end;
   { Descend d'un niveau }
   dec (Q.Niveau);
   SetFilePos(Q,Q.SauvePosFichNiv[Q.Niveau]);
   goto DescendNiveau;
  End;
   { Revient … la position sauv‚e }
  SetFilePos(Q,SauvePosFich);
 End
End;

Procedure AfficheUnNiveauRes(Var Q:WorkShopApp);
Var
 OfstCourant:LongInt;
 IndexRes:Word;
 Txt:String;           { ChaŒne de caractŠre temporaire }
 CurrName:Word;
Begin
{ With Q.ListeRes do} Begin
 CurrName:=0;
  ClrScrBlack;
  { Lit l'offset du niveau }
  OfstCourant:=Q.OfstNiveau[Q.Niveau];
   { Affiche le d‚but du titre }
  SetKr(15+1*16);
  PutTyping('[ ');
  If Q.Niveau<>0Then Begin
    PutTyping('Niveau ');
    SetKr(14+1*16);
    PutTyping(WordToStr(Q.Niveau));
  End
   else
  PutTyping('ROOT');
   { Lit l'entˆte niveau }
  MoveLeft(_RBGetBuf(Q.IndexHeader,Q.Niveau)^,Q.EnteteNiveau[Q.Niveau],SizeOf(TypeRsrcEnteteNiveau));
{  With CopieXms do Begin
   Taille:=SizeOf(TypeRsrcEnteteNiveau);
   SrcOfs:=OfstCourant;
   DstOfs:=Ptr2Long(@EnteteNiveau[Niveau]);
   Inc(OfstCourant,Taille);
  End;
  CopieMemXms(CopieXms);
  TestErreurXms('lecture de l''entˆte d''un niveau');}
   { Affiche la fin du titre }
  PutTyping(' : ');
  SetKr(14+1*16);
  PutTyping(WordToStr(Q.EnteteNiveau[Q.Niveau].NbrEntree));
  PutTyping(' entr‚es ]');
  _Dn;
  VidBnkSwitch.XP:=0;
  SetKr(7+0*16);
   { Affiche le r‚pertoire : retour au niveau -1 }
  If Q.Niveau<>0Then begin
{   SetKr(CoulResRepos);}
   PutTyping('\..');
{   PutTyping(HexWord2Str(80-EcranX)+' ');}
  End;
   { Traite les entr‚es }
  With Q.EnteteNiveau[Q.Niveau]do Begin
   IndexRes:=0;
   While(IndexRes<NbrEntree{Q.IndexRessource.NB})do Begin
     { Lit une entr‚e }
    MoveLeft(_RBGetBuf(Q.IndexRessource,IndexRes)^,Q.UneEntree,SizeOf(TypeRsrcUneEntree));
{    With CopieXms do Begin
     Taille:=SizeOf(TypeRsrcUneEntree);
     SrcOfs:=OfstCourant;
     DstOfs:=Ptr2Long(@UneEntree);
     Inc(OfstCourant,Taille);
    End;
    CopieMemXms(CopieXms);
    TestErreurXms('lecture d''une entr‚e');}
    With Q.UneEntree do Begin
      { Lit le nom de l'entr‚e }
     If(NomExiste)Then Begin
      PutTyping(_RBGetStr(Q.IndexName,CurrName));
      Inc(CurrName);
{      With CopieXmsNom do Begin
       Taille:=LongNom;
       If Taille and 1=1Then Inc(Taille);
       SrcHdl:=HandleNom;
       SrcOfs:=OfstNom;
       Txt[0]:=Chr(LongNom);
      End;
      CopieMemXms(CopieXmsNom);
      TestErreurXms('lecture du nom');}
     End
      Else
     Begin
       { Cr‚e un nom }
      If OfstNom<0Then Begin
        { C'est une ressource }
       System.Str(-OfstNom,Txt);
       Txt:='Ressource (langage='+txt+')';
      End
       Else
      Begin
       If Q.Niveau<>0Then Begin
         { C'est un r‚pertoire index‚ }
        System.Str (OfstNom,txt);
        Txt:='ID='+txt;
         { C'est un r‚pertoire racine (nom=type de ressource) }
       End
        Else
       Begin
        Txt:=PENomTypeRessource(OfstNom);
       End;
      End;
     End;
      { Affiche une entr‚e }
{     If Q.Niveau<>0Then
      If IndexRes=Q.PosListeRes[Q.Niveau]-1Then SetKr(CoulResSelect)
                                           Else SetKr(CoulResRepos)
     Else
      If IndexRes=Q.PosListeRes[Niveau]Then CoulTxt:=CoulResSelect
                                       Else CoulTxt:=CoulResRepos;}
     If(TypeRepert)Then PutTyping('\');
     PutTyping(txt);
     _Dn;
     VidBnkSwitch.XP:=0;
{     If EcranX<>0Then EcriTh(80-EcranX,' ');}
     SetKr(7);
    End;
    Inc(IndexRes);
(*    If(22=IndexRes)Then Begin
     SetKr(12);
     PutTyping('............. (trop de ressources !!!)');
     NbrEntree:=22;
     If Q.Niveau=0Then Inc(NbrEntree);
     Exit;
    End;*)
   End;
  End;
 End
End;

Procedure AfficheRessources(Var Q:WorkShopApp);
Var
 K:Word;
Begin
{ With ListeRes do} Begin
   { Initialise les structures de copie XMS (passe en lecture) }
{  With CopieXms do Begin
   SrcHdl:=Handle;
   DstHdl:=0;
  End;
  With CopieXmsNom do Begin
   SrcHdl:=HandleNom;
   DstHdl:=0;
   DstOfs:=Ptr2Long(@Txt[1]);
  End;}
   { Affiche le niveau ROOT }
  Q.Niveau:=0;
  Q.OfstNiveau[0]:=0;
  Q.PosListeRes[0]:=0;
  AfficheUnNiveauRes(Q);
   { D‚sactive le curseur }
(*  CloseCur;
   { Navigation dans les ressources }
  Repeat
   K:=ReadKey;
   Case(K)of
    { D‚placement dans la liste (haut, bas, ...) }
    kbHome:DeplaceListeRes(-127);
    kbPgUp:DeplaceListeRes(-5);
    kbHome:DeplaceListeRes(-1);
    kbDn:  DeplaceListeRes(+1);
    kbPgDn:DeplaceListeRes(+5);
    kbEnd: DeplaceListeRes(+127);
    { Entr‚e : Entre dans un r‚pertoire ou lit une ressource }
    kbEnter:Begin
      { Lit l'entr‚e s‚lectionn‚e }
     If(Niveau=0)or((Niveau<>0)and(PosListeRes[Niveau]<>0))Then Begin
      With CopieXms do Begin
       Taille:=SizeOf(TypeRsrcUneEntree);
       If Niveau<>0Then SrcOfs:=OfstNiveau[Niveau]+SizeOf(TypeRsrcEnteteNiveau) +(PosListeRes[Niveau]-1)*SizeOf(UneEntree)
                   Else SrcOfs:=OfstNiveau[Niveau]+SizeOf(TypeRsrcEnteteNiveau) +PosListeRes[Niveau]*SizeOf(UneEntree);
       DstOfs:=Ptr2Long(@UneEntree);
      End;
      CopieMemXms(CopieXms);
      TestErreurXms('lecture de l''entr‚e sel‚ctionn‚e');
     End
      Else
     UneEntree.TypeRepert:=True;
      { L'entr‚e est une ressource ? }
     With UneEntree do Begin
      If(TypeRepert)Then Begin
       If(Niveau<>0)and(PosListeRes[Niveau]=0)Then ChangeNiveauRes(-1)
                                              Else ChangeNiveauRes(+1);
      End
       Else
      Begin
        { C'est une ressource }
       AfficheUneRessource;
       ChangeNiveauRes (-1);
      End;
     End;
    End
   End;
  Until K=kbEsc;(**)
 End
End;

Procedure AfficheToutesRessources(Var Q:WorkShopApp);
Var
 SauvePosFich:LongInt;
 TmpL:LongInt;
Begin
{ With Q.ListeRes do} Begin
   { Sauvegarde la position du fichier }
  SauvePosFich:=Q.FilePos;
   { Si le r‚pertoire n'existe pas, on se casse }
  TmpL:=ChercheOfstRessource(Q);
  If TmpL=-1Then Begin
   Q.Err:=10;
   Exit;
  End
   else
  Begin
   Q.OfstRessource:=TmpL; { Sauve la position des ressources }
   SetFilePos(Q,TmpL);    { S'y place }
  End;
   { Cr‚e la liste des ressources }
  CreeListeRessource(Q);
   { Affiche la liste du niveau ROOT }
  AfficheRessources(Q);
  { Revient … la position sauvegard‚e du fichier }
  SetFilePos(Q,SauvePosFich);
 End
End;

Function WSInit(Var Context;X1,Y1,X2,Y2:Byte):Bool;
Var
 Q:WorkShopApp Absolute Context;
Begin
 FillClr(Q,SizeOf(Q));
 Q.Handle:=errHdl;
 WEInit(Q.W,X1,Y1,X2,Y2);
 WSRefresh(Q);
End;

Procedure WSLoad(Var Context;X1,Y1,X2,Y2:Byte;Const Path:String);
Var
 Q:WorkShopApp Absolute Context;
Begin
 FillClr(Q,SizeOf(Q));
 Q.Handle:=errHdl;
 WEInit(Q.W,X1,Y1,X2,Y2);
 Q.Path:=Path;
 Q.Handle:=FileOpen(Q.Path,fmRead);
 PELitEntetePE(Q);
 AfficheToutesRessources(Q);
 WSRefresh(Q);
End;

Procedure WSRefresh(Var Context);
Var
 Q:WorkShopApp Absolute Context;
Begin
End;

Function WSRun(Var Context):Word;
Var
 Q:WorkShopApp Absolute Context;
Begin
 WSRun:=WEReadk(Q.W);
End;

Function WSDone(Var Context):Word;
Var
 Q:WorkShopApp Absolute Context;
Begin
 FileClose(Q.Handle);
End;

END.