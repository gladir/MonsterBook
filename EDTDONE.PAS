{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                    Malte Genesis/Fin de l'괺iteur                       �
 �            릁ition Chantal pour Mode R괻l/IV - Version 1.1              �
 �                              1995/11/30                                 �
 �                                                                         �
 �          Tous droits r굎erv� par les Chevaliers de Malte (C)            �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Nom des programmeurs
 袴袴袴袴袴袴袴袴袴袴

  Sylvain Maltais ainsi que Dieu Tout-Puissant


 Description
 袴袴袴袴袴�

  Cette unit� est utilis� pour mettre fin � l'괺ition du tra똳ement de texte
 et 굃iminer ces donn괻s en m굆oire.


 Remarque
 袴袴袴袴

  � Cette unit� s'adapte  en fonction du param굏rage  de m굏hode  de gestion
    multi - fen늯re  췎�  selon  la  th굊rie  괹rit  dans  le  livre  manuel
    technique Malte Genesis III par la directive de compilation 췎�.
}

Unit EdtDone;

{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}
                                  INTERFACE
{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}

{$I DEF.INC}

Function TEDone(Var Context):Word;

{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}
                                IMPLEMENTATION
{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}

Uses
 Systex,Isatex,Memories,Systems,Dialex,Dials,
 Restex,ResServD,Editor,EdtSave,ToolView;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                             Fonction TEDone                            �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Description
 袴袴袴袴袴�

  Cette fonction 굃imine la fen늯re de tra똳ement  de texte actuellement en
 usage dans la variable de param굏rage 췘�. Si la fonction retourne kbAbort
 c'est  que l'utilisateur ne veut plus fermer la fen늯re maintenant,  c'est
 probablement  qu'une erreur  utilisateur  c'est commis...  Si la  fonction
 retourne 0,  c'est que tous  c'est bien passer,  la fen늯re est lib굍er de
 toutes contraintes objet.  Dans  l'굒entualit�  o�  l'utilisateur  aurrait
 oublier  d'effectuer  une  sauvegarde,  il  demande  la  permission  de le
 sauvegarder et s'il lui accord et bien il le fait bien entendu.


 Remarques
 袴袴袴袴�

  � Si l'utilisateur demande de l'aide dans l'굒entualit� o� l'utiliateur a
    failli oublier  de sauvegarder  sa liste,  il utilise  la  biblioth둸ue
    d'괺ition, index 11, pour lui fournire de l'aide.

  � Apr둺  son  op굍ation,  cette  fonction  appelle  la proc괺ure  virtuel
    췗utMemory� pour r괶ctualiser la m굆oire disponible, ainsi l'utiliateur
    c'est combien de m굆oire il lui restera apr둺 cette lib굍ation d'objet.
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
 If(Q.Modified)Then Begin{Modification effectuer depuis la derni둹e sauvegarde sur disque?}
  Path:=Q.EditName;
  If Path=''Then Path:='Pasnom';
Restart:
  WEPushEndBar(L);
  WEPutLastBar('^F1^ Aide � Derni둹e avertissement avant de perdre ce fichier!');
  K:=WarningMsgYesNo('Le fichier '+Path+' n''a pas 굏� sauvegard�! Dois-je le sauver ?');
  WEDone(L);
  Case(K)of
   kbF1:Begin{ L'utilisateur demande de l'aide? }
    QHlp4RLL('EDITOR.HLP',0,0);
    Goto Restart;{Il ne veut  surtout  pas quitter  cette 굏ape  apr둺 avoir
                  demand� de l'aide...}
   End;
   kbYes:TESave(Q);{L'utilisateur le supplie de sauvegarder...}
   kbAbort:Begin
    TEDone:=kbAbort; {Abandon utilisateur,il ne voulait }
    Exit;            {pas r괻llement quitter...}
   End;
  End;
 End;
  { Lib둹e la m굆oire du listing utiliser par la fen늯re d'괺ition }
 ALDone(Q.List);
 ALDone(Q.Processus);
  { Lib둹e la m굆oire utilis� par la syntaxe des langages de programmation }
 DBDispose(Q.DBInstr);
 DBDispose(Q.DBFunc);
 DBDispose(Q.DBMainWord);
  { Affiche la taille de m굆oire actuellement disponible }
 PutMemory;
  { CODE DE S륝URIT�: Ce code n'est pas indispensable, il n'existe quand
    pour pr굒enir un "crash" du syst둴e advenant un 괹hec de chargement
    de fichier texte. }
 FillClr(Q,SizeOf(EditorApp));
End;

{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}
END.