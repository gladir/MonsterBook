{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                                                                         �
 �                        Malte Genesis/C � LAM                            �
 �                                                                         �
 �            릁ition Chantal pour Mode R괻l/IV - Version 1.1              �
 �                              1999/06/13                                 �
 �                                                                         �
 �          Tous droits r굎erv굎 par les Chevaliers de Malte (C)           �
 �                                                                         �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Nom du programmeur
 袴袴袴袴袴袴袴袴袴

  Sylvain Maltais


 Description
 袴袴袴袴袴�

  Cette unit� contient les routines n괹essaires � la traduction du source de
 format C/C++  en un  fichier  de format  췓AM�  compatible  avec l'outil de
 d굒eloppement pour les programmeurs 췖verCode�.
}

Unit C2LAM;

{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}
                                  INTERFACE
{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}

Uses Systex;

Function CnCPP2Lam(Const Path:String;CPP:Bool):Int;

{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}
                                IMPLEMENTATION
{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}

Const
 csDefine={$IFDEF FRENCHCODE}'d괽inie'{$ELSE}'define'{$ENDIF};
 csDo={$IFDEF FRENCHCODE}'faire'{$ELSE}'do'{$ENDIF};
 csElse={$IFDEF FRENCHCODE}'sinon'{$ELSE}'else'{$ENDIF};
 csExtern={$IFDEF FRENCHCODE}'externe'{$ELSE}'extern'{$ENDIF};
 csFor={$IFDEF FRENCHCODE}'pour'{$ELSE}'for'{$ENDIF};
 csIf={$IFDEF FRENCHCODE}'si'{$ELSE}'if'{$ENDIF};
 csMain={$IFDEF FRENCHCODE}'principal'{$ELSE}'main'{$ENDIF};
 csReturn={$IFDEF FRENCHCODE}'retourne'{$ELSE}'return'{$ENDIF};
 csVoid={$IFDEF FRENCHCODE}'n괶nt'{$ELSE}'void'{$ENDIF};
 csWhile={$IFDEF FRENCHCODE}'tantque'{$ELSE}'while'{$ENDIF};

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                            Fonction CnCPP2Lam                        �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Description
 袴袴袴袴袴�

  Cette fonction permet de convertir un source 괹rit en langage C/C++ en
 format de fichier 췓AM�.
}

Function CnCPP2Lam;Begin

  { � compl굏er ... }

End;

{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}
END.