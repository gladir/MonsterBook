{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                    Malte Genesis/Fin de l'‚diteur                       Û
 ³            dition Chantal pour Mode R‚el/IV - Version 1.1              Û
 ³                              1995/11/30                                 Û
 ³                                                                         Û
 ³          Tous droits r‚serv‚ par les Chevaliers de Malte (C)            Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Nom des programmeurs
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

  Sylvain Maltais ainsi que Dieu Tout-Puissant


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette unit‚ est utilis‚ pour mettre fin … l'‚dition du traŒtement de texte
 et ‚liminer ces donn‚es en m‚moire.


 Remarque
 ÍÍÍÍÍÍÍÍ

  ş Cette unit‚ s'adapte  en fonction du param‚trage  de m‚thode  de gestion
    multi - fenˆtre  ®H¯  selon  la  th‚orie  ‚crit  dans  le  livre  manuel
    technique Malte Genesis III par la directive de compilation ®H¯.
}

Unit EdtDone;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                  INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

{$I DEF.INC}

Function TEDone(Var Context):Word;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses
 Systex,Isatex,Memories,Systems,Dialex,Dials,
 Restex,ResServD,Editor,EdtSave,ToolView;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Fonction TEDone                            Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction ‚limine la fenˆtre de traŒtement  de texte actuellement en
 usage dans la variable de param‚trage ®Q¯. Si la fonction retourne kbAbort
 c'est  que l'utilisateur ne veut plus fermer la fenˆtre maintenant,  c'est
 probablement  qu'une erreur  utilisateur  c'est commis...  Si la  fonction
 retourne 0,  c'est que tous  c'est bien passer,  la fenˆtre est lib‚rer de
 toutes contraintes objet.  Dans  l'‚ventualit‚  o—  l'utilisateur  aurrait
 oublier  d'effectuer  une  sauvegarde,  il  demande  la  permission  de le
 sauvegarder et s'il lui accord et bien il le fait bien entendu.


 Remarques
 ÍÍÍÍÍÍÍÍÍ

  ş Si l'utilisateur demande de l'aide dans l'‚ventualit‚ o— l'utiliateur a
    failli oublier  de sauvegarder  sa liste,  il utilise  la  bibliothŠque
    d'‚dition, index 11, pour lui fournire de l'aide.

  ş AprŠs  son  op‚ration,  cette  fonction  appelle  la proc‚dure  virtuel
    ®PutMemory¯ pour r‚actualiser la m‚moire disponible, ainsi l'utiliateur
    c'est combien de m‚moire il lui restera aprŠs cette lib‚ration d'objet.
}

Function TEDone;
Label Restart;
Var
 Q:EditorApp Absolute Context;
 Path:String;
 K:Word;
 L:Window;
Begin
 TEDone:=0;
 If(Q.Modified)Then Begin{Modification effectuer depuis la derniŠre sauvegarde sur disque?}
  Path:=Q.EditName;
  If Path=''Then Path:='Pasnom';
Restart:
  WEPushEndBar(L);
  WEPutLastBar('^F1^ Aide ³ DerniŠre avertissement avant de perdre ce fichier!');
  K:=WarningMsgYesNo('Le fichier '+Path+' n''a pas ‚t‚ sauvegard‚! Dois-je le sauver ?');
  WEDone(L);
  Case(K)of
   kbF1:Begin{ L'utilisateur demande de l'aide? }
    QHlp4RLL('EDITOR.HLP',0,0);
    Goto Restart;{Il ne veut  surtout  pas quitter  cette ‚tape  aprŠs avoir
                  demand‚ de l'aide...}
   End;
   kbYes:TESave(Q);{L'utilisateur le supplie de sauvegarder...}
   kbAbort:Begin
    TEDone:=kbAbort; {Abandon utilisateur,il ne voulait }
    Exit;            {pas r‚ellement quitter...}
   End;
  End;
 End;
  { LibŠre la m‚moire du listing utiliser par la fenˆtre d'‚dition }
 ALDone(Q.List);
 ALDone(Q.Processus);
  { LibŠre la m‚moire utilis‚ par la syntaxe des langages de programmation }
 DBDispose(Q.DBInstr);
 DBDispose(Q.DBFunc);
 DBDispose(Q.DBMainWord);
  { Affiche la taille de m‚moire actuellement disponible }
 PutMemory;
  { CODE DE SCURIT: Ce code n'est pas indispensable, il n'existe quand
    pour pr‚venir un "crash" du systŠme advenant un ‚chec de chargement
    de fichier texte. }
 FillClr(Q,SizeOf(EditorApp));
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
END.