{���������������������������������������������������������������������������
 �                                                                         �
 �                        Malte Genesis/C � LAM                            �
 �                                                                         �
 �            �dition Chantal pour Mode R�el/IV - Version 1.1              �
 �                              1999/06/13                                 �
 �                                                                         �
 �          Tous droits r�serv�s par les Chevaliers de Malte (C)           �
 �                                                                         �
 ���������������������������������������������������������������������������


 Nom du programmeur
 ������������������

  Sylvain Maltais


 Description
 �����������

  Cette unit� contient les routines n�cessaires � la traduction du source de
 format C/C++  en un  fichier  de format  �LAM�  compatible  avec l'outil de
 d�veloppement pour les programmeurs �OverCode�.
}

Unit C2LAM;

{���������������������������������������������������������������������������}
                                  INTERFACE
{���������������������������������������������������������������������������}

Uses Systex;

Function CnCPP2Lam(Const Path:String;CPP:Bool):Int;

{���������������������������������������������������������������������������}
                                IMPLEMENTATION
{���������������������������������������������������������������������������}

Const
 csDefine={$IFDEF FRENCHCODE}'d�finie'{$ELSE}'define'{$ENDIF};
 csDo={$IFDEF FRENCHCODE}'faire'{$ELSE}'do'{$ENDIF};
 csElse={$IFDEF FRENCHCODE}'sinon'{$ELSE}'else'{$ENDIF};
 csExtern={$IFDEF FRENCHCODE}'externe'{$ELSE}'extern'{$ENDIF};
 csFor={$IFDEF FRENCHCODE}'pour'{$ELSE}'for'{$ENDIF};
 csIf={$IFDEF FRENCHCODE}'si'{$ELSE}'if'{$ENDIF};
 csMain={$IFDEF FRENCHCODE}'principal'{$ELSE}'main'{$ENDIF};
 csReturn={$IFDEF FRENCHCODE}'retourne'{$ELSE}'return'{$ENDIF};
 csVoid={$IFDEF FRENCHCODE}'n�ant'{$ELSE}'void'{$ENDIF};
 csWhile={$IFDEF FRENCHCODE}'tantque'{$ELSE}'while'{$ENDIF};

{������������������������������������������������������������������������
 �                            Fonction CnCPP2Lam                        �
 ������������������������������������������������������������������������


 Description
 �����������

  Cette fonction permet de convertir un source �crit en langage C/C++ en
 format de fichier �LAM�.
}

Function CnCPP2Lam;Begin

  { � compl�ter ... }

End;

{���������������������������������������������������������������������������}
END.