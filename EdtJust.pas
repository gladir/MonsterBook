Unit EdtJust;

{���������������������������������������������������������������������������}
                                  INTERFACE
{���������������������������������������������������������������������������}

Uses Systex,Isatex;

Procedure TECenterHomeParagraph(Var Q:EditorApp);
Procedure TECenterTxt(Var Q:EditorApp);
Procedure TECenter(Var Q:EditorApp;X:CenterType);

{���������������������������������������������������������������������������}
                                IMPLEMENTATION
{���������������������������������������������������������������������������}

Uses Memories,Systems,Editor;

{$I \Source\Chantal\Library\System\Malte\ExecFile\GetGatLe.Inc}
{$I \Source\Chantal\TEPopCur.Inc}
{$I \Source\Chantal\TESETPTR.INC}

{��������������������������������������������������������������������������
 �                       Proc�dure TECenterHomeParagraph                  �
 ��������������������������������������������������������������������������


 Description
 �����������

  Cette proc�dure position le pointeur texte correctement en fonction d'une
 nouvelle ligne commen�ant � �tre �crite  � la suite d'un d�bordement de la
 marge de droite.
}

Procedure TECenterHomeParagraph;
Var
 PC:PChr;
 I,NL:Word;
Begin
 If(Q.ReadOnly)Then Exit;
 If Q.P>0Then Begin
  If Q.SheetFormat.X2>=65520Then Exit;
  PC:=TEPopCurr(Q);NL:=0;
  If Not IsPChrEmpty(PC)Then Begin
   If PC^[0]=' 'Then Begin
    NL:=0;
    While PC^[NL]=' 'do Inc(NL);
   End;
  End;
  ALPrevious(Q.List);
  PC:=_ALGetCurrBuf(Q.List);
  ALNext(Q.List);
  If Not(IsPChrEmpty(PC))Then Begin
   If PC^[0]=' 'Then Begin
    I:=0;
    While PC^[I]=' 'do Inc(I);
    If PC^[I]in['�','�','�']Then Begin
     Inc(I);
     If PC^[I]=' 'Then Inc(I)
    End
     else
    If I=Q.SheetFormat.X1+1Then Dec(I);
    PC:=_ALGetBuf(Q.List,Q.P);
    If(I>NL)Then TEInsSpcHome(Q,StrLen(PC),I-NL,PC);
   End;
  End;
 End;
End;

{������������������������������������������������������������������������
 �                         Proc�dure TECenterTxt                        �
 ������������������������������������������������������������������������


 Description
 �����������

  Cette proc�dure fixe une ligne au milieu des marges respectives d�finit
 par les variables �XW1� et �XW2�.


 Remarque
 ��������

  � Lorsque cette marge n'est pas d�finit (qu'il est �gale � FFF0h, il ne
    centre pas la ligne.
}

Procedure TECenterTxt;
Var
 PC:PChr;
 L,L2:Word;
Begin
 If(Q.ReadOnly)Then Exit;
 If Q.SheetFormat.X2<65520Then Begin
  PC:=TEPopCurr(Q);
  While PC^[0]=' 'do StrDel(PC,0,1);
  If(Q.Mode=vtGat)Then Begin
   L:=GetGatLen(PC);
   If L>0Then Begin
    If(Q.SheetFormat.X2-Q.SheetFormat.X1<L)Then Exit;
    L2:=StrLen(PC);
   End;
  End
   Else
  Begin
   L:=StrLen(PC);
   L2:=L;
  End;
  If L>0Then TEInsSpcHome(Q,L2,Q.SheetFormat.X1+((Q.SheetFormat.X2-Q.SheetFormat.X1+1-L)shr 1),PC);
 End;
 TEkDn(Q);
End;

{������������������������������������������������������������������������
 �                         Proc�dure TECenter                           �
 ������������������������������������������������������������������������


 Description
 �����������

  Cette proc�dure fixe  une ligne  centr�e en fonction  de la demande par
 param�tre (gauche, centr�e, droite)  dans les marges respectives d�finit
 par les variables �XW1� et �XW2�.


 Remarque
 ��������

  � Lorsque cette marge n'est pas d�finit (qu'il est �gale � FFF0h, il ne
    centre pas la ligne.
}

Procedure TECenter(Var Q:EditorApp;X:CenterType);
Var
 PC:PChr;
 L,L2:Word;
 OldY:Byte;
Begin
 If(Q.ReadOnly)Then Exit;
 If Q.SheetFormat.X2<65520Then Begin
  OldY:=Q.W.Y;
  PC:=TEPopCurr(Q);
  While PC^[0]=' 'do StrDel(PC,0,1);
  If(Q.Mode=vtGat)Then Begin
   L:=GetGatLen(PC);
   If L>0Then Begin
    If(Q.SheetFormat.X2-Q.SheetFormat.X1<L)Then Exit;
    L2:=StrLen(PC);
   End;
  End
   Else
  Begin
   L:=StrLen(PC);
   L2:=L;
  End;
  Case(X)of
     __Left__:If L>0Then TEInsSpcHome(Q,L2,Q.SheetFormat.X1,PC);
__Justified__:If L>0Then TEInsSpcHome(Q,L2,Q.SheetFormat.X1+((Q.SheetFormat.X2-Q.SheetFormat.X1+1-L)shr 1),PC);
    __Right__:If(L>0)and(L<Q.SheetFormat.X2)Then TEInsSpcHome(Q,L2,Q.SheetFormat.X2-L,PC);
  End;
  TESetPtr(Q);
  Q.W.Y:=OldY;
 End;
End;

{���������������������������������������������������������������������������}
END.