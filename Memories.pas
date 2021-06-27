Unit Memories;

{$I DEF.INC}

INTERFACE

Uses Systex;

Function  AddrExt2Conv(Addr:Pointer):LongInt;
Function  AddrRPtr2Ext(X:RPtr):Pointer;
Function  ALAdd(Var Q:ArrayList;Size:Word):Pointer;
Function  ALAddBlock(Var Q:ArrayList;Size:Word;Const Block):Boolean;
Function  ALAddLn(Var Q:ArrayList):Boolean;
Function  ALAddPChr(Var Q:ArrayList;PChr:PChr):Boolean;
Function  ALAddPChrByte(Var Q:ArrayList;PChr:PChr;Num:Byte):Boolean;
Function  ALAddPChrWord(Var Q:ArrayList;PChr:PChr;Num:Word):Boolean;
Function  ALAddSpcUStr(Var Q:ArrayList;S:Byte;Const Str:String):Boolean;
Function  ALAddStr(Var Q:ArrayList;Const Str:String):Boolean;
Function  ALAddStrByte(Var Q:ArrayList;Const Str:String;Num:Byte):Boolean;
Function  ALAddStrLong(Var Q:ArrayList;Const Str:String;Num:LongInt):Boolean;
Function  ALAddStrWord(Var Q:ArrayList;Const Str:String;Num:Word):Boolean;
Function  ALDelBuf(Var Q:ArrayList;P:RBP):Boolean;
Function  ALDelBufNSize(Var Q:ArrayList;P:RBP;Var Size:Word):Boolean;
Procedure ALDone(Var Q:ArrayList);
Function  ALGetBuf(Var Q:ArrayList;P:RBP;Var Size:Word):Pointer;
Function  ALGetCurrBuf(Var Q:ArrayList;Var Size:Word):Pointer;
Procedure ALInit(Var Q:ArrayList);
Function  ALIns(Var Q:ArrayList;P:RBP;Size:Word):Pointer;
Function  ALInsBlock(Var Q:ArrayList;P:RBP;Size:Word;Const Block):Boolean;
Function  ALInsStr(Var Q:ArrayList;P:RBP;Const Str:String):Boolean;
Function  ALInsStrWord(Var Q:ArrayList;P:RBP;Const Str:String;Num:Word):Boolean;
Function  ALIsEmpty(Var Q:ArrayList):Boolean;
Function  ALMax(Var Q:ArrayList):RBP;
Procedure ALNext(Var Q:ArrayList);
Procedure ALPopCurrPtr(Var Q:ArrayList;Addr:Pointer);
Procedure ALPrevious(Var Q:ArrayList);
Function  ALPushCurrPtr(Var Q:ArrayList):Pointer;
Function  ALSet(Var Q:ArrayList;P:RBP;Size:Word):Pointer;
Function  ALSetCurrBuf(Var Q:ArrayList;Size:Word):Pointer;
Procedure ALSetPtr(Var Q:ArrayList;P:RBP);
Function  ALXChgBuf(Var Q:ArrayList;A,B:RBP):Boolean;
{$IFNDEF NotReal}
 Function EmmNumPage:Integer;
{$ENDIF}
{$IFDEF Real}
 Procedure FreeAllHeap;
 Function  FreeHeap(SizeP:Word):Boolean;
 Procedure FreeMaxHeap;
 Procedure FreeMaxHeapBy(By:Word);
{$ENDIF}
Procedure FreeMemory(x0:Pointer;Size:Word);
{$IFDEF NotReal}
 Function MaxAvail:LongInt;
{$ENDIF}
Function  MemAlloc(Size:Word):Pointer;
{$IFDEF NotReal}
 Function MemAvail:LongInt;
{$ENDIF}
Function  MemNew(Size:Word):Pointer;
Function  NewBlock(Var Buf;Size:Word):Pointer;
Function  _ALGetBuf(Var Q:ArrayList;P:RBP):Pointer;
Function  _ALGetCurrBuf(Var Q:ArrayList):Pointer;
Function  _ALGetStr(Var Q:ArrayList;P:RBP):String;
Procedure _FreeMemory(Var x0:Pointer;Var Size:Word);

IMPLEMENTATION

Uses Adele,Systems;

Const
 MinRec={32}SizeOf(StrLongRec)+1;

{�����������������������������������������������������������������������
 �                         Fonction AddrExt2Conv                       �
 �����������������������������������������������������������������������


 Description
 �����������

  Cette fonction convertie une adresse du micro-processeur de 24 bits en
 adresse de mode r�el.
}

Function AddrExt2Conv{Addr:Pointer):LongInt};Begin
 AddrExt2Conv:=LongInt(PtrRec(Addr).Seg)shl 4+PtrRec(Addr).Ofs;
End;

{�������������������������������������������������������������������������
 �                          Fonction AddrRPtr2Ext                        �
 �������������������������������������������������������������������������


 Description
 �����������

  Cette fonction convertie une adresse du micro-processeur de mode r�el en
 adresse de 24 bits.
}

Function AddrRPtr2Ext{X:RPtr):Pointer};Begin
 {$IFDEF FLAT386}
 {$ELSE}
  AddrRPtr2Ext:=Ptr(X.LoSeg shl 12,X.Base)
 {$ENDIF}
End;

{�������������������������������������������������������������������������
 �                           Fonction EmmNumPage                         �
 �������������������������������������������������������������������������


 Description
 �����������

  Cette  fonction permet  de conna�tre  le nombre de plage  de m�moire EMS
 encore disponible pour l'application courante.


 Remarque
 ��������

  � Cette fonction � besoin  d'un pilote EMS ainsi  qu'une pr�d�tection de
    la pr�sence de ce pilote par le "StartUp"(l'unit� �Chantal� ou �Ad�le�
    si vous pr�f�rez).
}

{$IFNDEF NotReal}
 Function EmmNumPage{:Integer};Assembler;ASM
  XOR AX,AX
  CMP EmmExist,AL
  JE  @2
  MOV AH,042h
  INT 067h
  MOV EmmErr,AH
  CMP AH,0
  JE  @1
  XOR AX,AX
 @1:MOV AX,DX
 @2:
 END;
{$ENDIF}

{��������������������������������������������������������������������������
 �                           Proc�dure FreeAllHeap                        �
 ��������������������������������������������������������������������������


 Description
 �����������

  Cette proc�dure lib�re tout la m�moire utilis� par le programme et permet
 ainsi le chargement d'autre programme.
}

{$IFDEF Real}
 Procedure FreeAllHeap;Begin
  FreeHeap(PtrRec(HeapEnd).Seg-PtrRec(HeapOrg).Seg)
 End;
{$ENDIF}

{���������������������������������������������������������������������������
 �                             Fonction FreeHeap                           �
 ���������������������������������������������������������������������������


 Description
 �����������

  Cette fonction lib�re de la variable de param�trage  �SizeP� de la m�moire
 par multiple de 16 octets pour permettre �ventuellement � d'autre programme
 d'�tre charger dans cette m�me m�moire.
}

{$IFDEF Real}
 Function FreeHeap{SizeP:Word):Boolean};Assembler;ASM
  MOV AH,4Ah
  MOV BX,Word Ptr HeapEnd[2]
  SUB BX,PrefixSeg
  SUB BX,SizeP
  MOV ES,PrefixSeg
  MOV CX,ES
  ADD CX,BX
  PUSH CX
   INT 21h
  POP BX
  XOR AX,AX
  MOV Word Ptr HeapEnd[2],BX
  MOV Word Ptr HeapEnd,AX
  MOV AL,True
 END;
{$ENDIF}

{��������������������������������������������������������������������������
 �                          Proc�dure FreeMaxHeap                         �
 ��������������������������������������������������������������������������


 Description
 �����������

  Cette proc�dure lib�re le maximum de m�moire sans perte de donn�e dans le
 tas pour permettre  � d'autre application  d'�tre charg�e  dans la m�moire
 pr�sentement non utilis�.
}

{$IFDEF Real}
 Procedure FreeMaxHeap;
 Var
  Ex:Word;
 Begin
  Ex:=PtrRec(HeapEnd).Seg-PtrRec(HeapPtr).Seg;
  FreeHeap(Ex-1)
 End;
{$ENDIF}

{��������������������������������������������������������������������������
 �                         Proc�dure FreeMaxHeapBy                        �
 ��������������������������������������������������������������������������


 Description
 �����������

  Cette proc�dure lib�re le maximum de m�moire sans perte de donn�e dans le
 tas pour permettre  � d'autre application  d'�tre charg�e  dans la m�moire
 pr�sentement non utilis�.  A la diff�rence de son homologue �FreeMaxHeap�,
 elle permet  en plus  de sp�cifier une partie  de m�moire suppl�mentaire �
 garder  pour  l'application  actuel  pour des tra�tements  possiblement en
 arri�re plan...
}

{$IFDEF Real}
 Procedure FreeMaxHeapBy{By:Word};
 Var
  Ex:Word;
 Begin
  Ex:=PtrRec(HeapEnd).Seg-PtrRec(HeapPtr).Seg;
  If(Ex>By)Then Dec(Ex,By);
  FreeHeap(Ex)
 End;
{$ENDIF}


{������������������������������������������������������������������������
 �                           Proc�dure FreeMemory                       �
 ������������������������������������������������������������������������


 Description
 �����������

  Cette proc�dure lib�re la m�moire conventionnel  (en mode r�el) r�serv�
 pr�alablement par la fonction �MemAlloc� ou la proc�dure �GetMem�. Si la
 taille est 0 ou que le pointeur est �gale � �NIL�. L'op�ration n'est pas
 prit en compte car cela est impossible d'avoir un pointeur sur �NIL�.
}

Procedure FreeMemory{x0:Pointer;Size:Word};Begin
 If{$IFDEF AbsolutePack}(x0=@CRLFEnd)or{$ENDIF}
   (Size=0)or(x0=NIL)Then Exit;
 {$IFDEF Real}
  If Ofs(x0^)>$FThen Begin
   SysErr:=errHeapAlloc;
   Exit;
  End;
  If Seg(x0^)<Seg(HeapOrg^)Then Begin
   ASM
    MOV SysErr,errFlowFreeHeap
   END;
   Exit;
  End;
 {$ENDIF}
 System.FreeMem(x0,Size)
End;

{������������������������������������������������������������������������
 �                           Fonction MemAlloc                          �
 ������������������������������������������������������������������������


 Description
 �����������

  Cette fonction r�serve  une zone m�moire  de la taille sp�cifier par la
 variable de param�trage �Size� et retourne un pointeur. Dans le cas d'un
 �chec le pointeur retourn� est �NIL�.

 Function MemAlloc(Size:Word):Pointer;
 Var
  Ptr:Pointer;
 Begin
  MemAlloc:=NIL;
  If(Size=0)or(MaxAvail<Size)Then Exit;
  GetMem(Ptr,Size);
  MemAlloc:=Ptr;
 End;

}

Function MemAlloc{Size:Word):Pointer};
Label Xit;
Var
 Ptr:Pointer;
Begin
 ASM
  XOR AX,AX
  MOV Word Ptr @Result,AX
  MOV Word Ptr @Result[2],AX
  CMP Size,AX
  JE  Xit
 END;
 {$IFNDEF Win32}
  If(MaxAvail<Size)Then Exit;
 {$ENDIF}
 GetMem(Ptr,Size);
 MemAlloc:=Ptr;
Xit:
End;

{$IFDEF NotReal}
 Function MaxAvail:LongInt;Begin
  MaxAvail:=MemAvail;
 End;

 Function MemAvail:LongInt;Begin
  MemAvail:=$16000000;
 End;
{$ENDIF}


{������������������������������������������������������������������������
 �                           Fonction MemNew                            �
 ������������������������������������������������������������������������


 Description
 �����������

  Cette fonction r�serve  une zone m�moire  de la taille sp�cifier par la
 variable de param�trage �Size� et retourne un pointeur. Dans le cas d'un
 �chec le pointeur retourn� est �NIL�.  Si la fonction c'est correctement
 d�roul�,  la m�moire allou� est totalement initialis� � la valeur 0  (ou
 False si variable Boolean).
}

{Function MemNew(Size:Word):Pointer;
Var
 Ptr:Pointer;
Begin
 Ptr:=MemAlloc(Size);
 If(Ptr<>NIL)Then FillClr(Ptr^,Size);
 MemNew:=Ptr;
End;}

Function MemNew(Size:Word):Pointer;Assembler;ASM
 PUSH Size
 {$IFDEF FLAT386}
  CALL MemAlloc
 {$ELSE}
  PUSH CS
  CALL Near Ptr MemAlloc
 {$ENDIF}
 MOV CX,AX
 OR  CX,DX
 JCXZ @End
 PUSH AX
  PUSH DX
   PUSH DX
   PUSH AX
   PUSH Size
   CALL FillClr
  POP DX
 POP AX
@End:
END;

{������������������������������������������������������������������������
 �                            Fonction NewBlock                         �
 ������������������������������������������������������������������������


 Description
 �����������

  Cette fonction permet d'allou� un bloc de m�moire de la taille sp�cifi�
 par  la  variable  de param�trage  �Size�  en copiant  le  contenu  d'un
 enregistrement pointer par la variable de param�trage �Buf�.
}

Function NewBlock{Var Buf;Size:Wd):Pointer};
{$IFDEF FLAT386}
 Var
  Ptr:Pointer;
 Begin
  Ptr:=MemAlloc(Size);
  If(Ptr<>NIL)Then MoveLeft(Buf,Ptr^,Size);
  NewBlock:=Ptr;
 End;
{$ELSE}
 Assembler;ASM
  PUSH Size
  PUSH CS
  CALL Near Ptr MemAlloc
  MOV CX,DX
  OR  CX,AX
  JCXZ @End
  LES DI,Buf
  PUSH DX
   PUSH AX
    PUSH ES
    PUSH DI
    PUSH DX
    PUSH AX
    PUSH Size
    CALL MoveLeft
   POP AX
  POP DX
 @End:
 END;
{$ENDIF}

{������������������������������������������������������������������������
 �                           Proc�dure ALInit                           �
 ������������������������������������������������������������������������


 Description
 �����������

  Cette proc�dure initialise l'objet de recouvrement de tampon (Removable
 Buffer).  Elle n'alloue pas de m�moire  mais pr�pare plut�t l'arriver de
 prochaine donn�e.


 Param�tre
 ���������

  Q         Nom de l'objet de recouvrement de tampon (Array List)
}

Procedure ALInit(Var Q:ArrayList);Begin
 FillClr(Q,SizeOf(Q))
End;

{������������������������������������������������������������������������
 �                          Fonction ALIsEmpty                          �
 ������������������������������������������������������������������������


 Description
 �����������

  Cette fonction indique si l'objet de recouvrement de tampon ne contient
 pas de(s) enregistrement(s) (True) ou non (False). Donc, elle peut
 compris de la facon suivante: �ALIsEmpty:=Q.NB=0;�.


 Param�tre
 ���������

  Q         Nom de l'objet de recouvrement de tampon (Array List)
}

Function ALIsEmpty(Var Q:ArrayList):Boolean;Assembler;ASM
 {$IFDEF FLAT386}
  MOV DL,True
  MOV ECX,[EAX].ArrayList.Ls
  JECXZ @1
  MOV DL,False
@1:
  XCHG AX,DX
 {$ELSE}
  {LES DI,Q
  MOV AX,Word Ptr ES:[DI].ArrayList.Ls[2]
  OR  AX,Word Ptr ES:[DI].ArrayList.Ls
  JZ  @End
  MOV AL,True
  XOR AL,1}
  LES DI,Q
  XOR AX,AX
  SCASW
  JNZ @End
  MOV AL,True
@End:
 {$ENDIF}
END;

{�����������������������������������������������������������������
 �                        Fonction ALAdd                         �
 �����������������������������������������������������������������


 Description
 �����������

  Cette fonction additionne � l'objet de recouvrement de tampon un
 enregistrement � la fin de la liste actuel point� par la variable
 de param�trage �Q�.


 Param�tres
 ����������

  Q         Nom de l'objet de recouvrement de tampon (Array List)
  Size      Taille du nouvelle enregistrement � additionner
}

Function ALAdd(Var Q:ArrayList;Size:Word):Pointer;
Var
 W:RBufRec;
 WPtr:RBufPtr;
 Addr:Pointer;
Begin
 ALAdd:=NIL;
 FillClr(W,SizeOf(W));
 If Size>0Then Begin
  Addr:=MemAlloc(Size);
  If(Addr=NIL)Then Exit;
  W.Buf:=Addr;
  W.Size:=Size
 End;
 If(Q.Ls=NIL)Then Begin
  Q.Ls:=NewBlock(W,SizeOf(RBufRec));
  If(Q.Ls=NIL)Then Exit;
  Q.EndLsPtr:=Q.Ls
 End
  Else
 Begin
  WPtr:=Q.EndLsPtr;
  {$IFDEF NotReal}
   If(WPtr=NIL)Then Exit;
  {$ENDIF}
  W.Prev:=WPtr;
  WPtr^.Nxt:=NewBlock(W,SizeOf(RBufRec));
  Q.EndLsPtr:=WPtr^.Nxt;
 End;
 Inc(Q.Count);
 ALAdd:=Addr
End;

{������������������������������������������������������������������������
 �                           Fonction ALAddBlock                        �
 ������������������������������������������������������������������������


 Description
 �����������

  Cette fonction permet d'ajouer un bloc � la liste sym�trique de l'objet
 �ArrayList�.
}

Function ALAddBlock{Var Q:ArrayList;Size:Word;Const Block):Boolean};
{$IFDEF FLAT386}
 Var
  Ptr:Pointer;
 Begin
  ALAddBlock:=False;
  Ptr:=ALAdd(Q,Size);
  If(Ptr<>NIL)Then Begin
   MoveLeft(Block,Ptr^,Size);
   ALAddBlock:=True;
  End;
 End;
{$ELSE}
 Assembler;ASM
  LES DI,Q
  PUSH ES
  PUSH DI
  PUSH Size
  PUSH CS
  CALL Near Ptr ALAdd
  MOV CX,DX
  OR  CX,AX
  JCXZ @End
  LES DI,Block
  PUSH ES
  PUSH DI
  PUSH DX
  PUSH AX
  PUSH Size
  CALL MoveLeft
  MOV AL,True
 @End:
 END;
{$ENDIF}

Function ALInsBlock(Var Q:ArrayList;P:RBP;Size:Word;Const Block):Boolean;
{$IFDEF FLAT386}
 Var
  Ptr:Pointer;
 Begin
  ALInsBlock:=False;
  Ptr:=ALIns(Q,P,Size);
  If(Ptr<>NIL)Then Begin
   MoveLeft(Block,Ptr^,Size);
   ALInsBlock:=True;
  End;
 End;
{$ELSE}
 Assembler;ASM
  LES DI,Q
  PUSH ES
  PUSH DI
  PUSH P
  PUSH Size
  PUSH CS
  CALL Near Ptr ALIns
  MOV CX,DX
  OR  CX,AX
  JCXZ @End
  LES DI,Block
  PUSH ES
  PUSH DI
  PUSH DX
  PUSH AX
  PUSH Size
  CALL MoveLeft
  MOV AL,True
 @End:
 END;
{$ENDIF}

{������������������������������������������������������������������������
 �                            Fonction _ALSetPtr                        �
 ������������������������������������������������������������������������


 Description
 �����������

  Cette fonction permet de d�placer le pointeur de la liste sym�trique de
 l'objet �ArrayList� � un endroit pr�cis de celle-ci.


 Param�tres
 ����������

  Q         Nom de l'objet de recouvrement de tampon (Array List)
  P         Position devant �tre atteint dans la liste
}

Function _ALSetPtr(Var Q:ArrayList;P:RBP):Pointer;Near;
{$IFDEF FLAT386}
 Var
  WP:RBufPtr;
  I:RBP;
 Begin
  WP:=Q.Ls;
  For I:=1to(P)do Begin
   WP:=WP^.Nxt;
   If(WP=NIL)Then Begin
    _ALSetPtr:=NIL;
    Exit;
   End;
  End;
  _ALSetPtr:=WP
 End;
{$ELSE}
 Assembler;ASM
  XOR AX,AX
  XOR DX,DX
  MOV CX,P
  LES DI,Q
  LES DI,ES:[DI].ArrayList.Ls
  JCXZ @2
 @1:
  LES DI,ES:[DI].RBufRec.Nxt
  MOV SI,ES
  OR  SI,DI
  JZ  @End
  LOOP @1
 @2:
  MOV AX,DI
  MOV DX,ES
 @End:
 END;
{$ENDIF}

{���������������������������������������������������������������������������
 �                               Fonction ALIns                            �
 ���������������������������������������������������������������������������


 Description
 �����������

  Cette fonction permet d'ins�rer une ligne suppl�mentaire quelque part dans
 la liste sym�trique de l'objet �ArrayList�.


 Param�tres
 ����������

  Q         Nom de l'objet de recouvrement de tampon (Array List)
  P         Position dans la liste o� il faut mettre le nouvelle enregistrement
  Size      Taille du nouvelle enregistrement � ajouter dans la liste
}

Function ALIns(Var Q:ArrayList;P:RBP;Size:Word):Pointer;
Var
 WP,NewP:RBufPtr;
 Addr:Pointer;
Begin
 ALIns:=NIL;
 If(P>Q.Count)Then Exit;
 If(P=Q.Count)Then ALIns:=ALAdd(Q,Size)
  else
 Begin
  Addr:=NIL;
  If P=0Then Begin
   WP:=MemNew(SizeOf(Q.Ls^));
   If(WP=NIL)Then Exit;
   Q.Ls^.Prev:=WP;WP^.Nxt:=Q.Ls;
   If Size>0Then Begin
    Addr:=MemAlloc(Size);
    If(Addr=NIL)Then Exit;
    WP^.Buf:=Addr;WP^.Size:=Size
   End;
   Q.Ls:=WP
  End
   else
  Begin
   NewP:=MemNew(SizeOf(Q.Ls^));
   If(NewP=NIL)Then Exit;
   WP:=_ALSetPtr(Q,P);
   If(WP=NIL)Then Exit;
   NewP^.Nxt:=WP;
   NewP^.Prev:=WP^.Prev;
   If Size>0Then Begin
    Addr:=MemAlloc(Size);
    If(Addr=NIL)Then Exit;
    NewP^.Buf:=Addr;
    NewP^.Size:=Size
   End;
   WP^.Prev^.Nxt:=NewP;
   WP^.Prev:=NewP
  End;
  Inc(Q.Count);
  ALIns:=Addr
 End
End;

{��������������������������������������������������������������������������
 �                              Fonction ALAddPChr                        �
 ��������������������������������������������������������������������������


 Description
 �����������

  Cette fonction permet d'ajouter une ligne de format ASCIIZ � la fin de la
 liste sym�trique de l'objet �ArrayList�.


 Param�tres
 ����������

  Q         Nom de l'objet de recouvrement de tampon (Array List)
  PChr      Pointeur de la cha�ne de caract�res de format  �ASCIIZ�  devant
            �tre ajouter au recouvrement de tampon (Array List)
}

Function ALAddPChr(Var Q:ArrayList;PChr:PChr):Boolean;
Var
 PBuf:^TChar;
 L:Word;
Begin
 ALAddPChr:=False;
 L:=StrLen(PChr)+1;
 {$IFDEF AbsolutePack}
  If L=0Then Begin
   ALAdd(Q,0);
   Q.EndLsPtr^.Buf:=@CRLFEnd;
  End
   Else
 {$ENDIF}
 Begin
  PBuf:=ALAdd(Q,L);
  If(PBuf=NIL)Then Exit;
  If L=1Then PBuf^[0]:=#0
        Else MoveLeft(PChr^,PBuf^,L);
 End;
 ALAddPChr:=True
End;

{�������������������������������������������������������������������������
 �                         Fonction ALAddPChrByte                        �
 �������������������������������������������������������������������������


 Description
 �����������

  Cette fonction permet d'ajouter une ligne de format ASCIIZ avec un octet
 entier � la fin de la liste sym�trique de l'objet �ArrayList�.


 Param�tres
 ����������

  Q         Nom de l'objet de recouvrement de tampon (Array List)
  PChr      Pointeur de la cha�ne de caract�res de format  �ASCIIZ� devant
            �tre ajouter au recouvrement de tampon (Removable Buffer)
  Num       Nombre entier devant �tre ajouter � la  liste avant le contenu
            de l'enregistrement.
}

Function ALAddPChrByte(Var Q:ArrayList;PChr:PChr;Num:Byte):Boolean;
Var
 PCharByte:PPChrByte;
 Ptr:Pointer Absolute PCharByte;
Begin
 ALAddPChrByte:=False;
 Ptr:=ALAdd(Q,SizeOf(PCharByteRec));
 If(Ptr=NIL)Then Exit;
 PCharByte^.PChr:=PChr;
 PCharByte^.Nm:=Num;
 ALAddPChrByte:=True
End;

{�������������������������������������������������������������������������
 �                         Fonction ALAddStrByte                         �
 �������������������������������������������������������������������������


 Description
 �����������

  Cette fonction permet d'ajouter une ligne de format cha�ne de caract�res
 Pascal avec un octet entier  � la fin  de la  liste sym�trique de l'objet
 �ArrayList�.


 Param�tres
 ����������

  Q         Nom de l'objet de recouvrement de tampon (Array List)
  Str       Pointeur de la cha�ne de  caract�res de  format  Pascal devant
            �tre ajouter au recouvrement de tampon (Array List)
  Num       Nombre entier devant �tre ajouter � la  liste avant le contenu
            de l'enregistrement.
}

Function ALAddStrByte(Var Q:ArrayList;Const Str:String;Num:Byte):Boolean;
Var
 StrByte:PStrByte;
 Ptr:Pointer;
Begin
 ALAddStrByte:=False;
 Ptr:=ALAdd(Q,SizeOf(StrByteRec));
 If(Ptr=NIL)Then Exit;
 StrByte:=Ptr;
 StrByte^.PChr:=Str2PChr(Str);
 StrByte^.Len:=Length(Str);
 StrByte^.Nm:=Num;
 ALAddStrByte:=True
End;

{�������������������������������������������������������������������������
 �                         Fonction ALAddStrWord                         �
 �������������������������������������������������������������������������


 Description
 �����������

  Cette fonction permet d'ajouter une ligne de format cha�ne de caract�res
 Pascal avec un mot entier  � la fin  de la  liste  sym�trique de  l'objet
 �ArrayList�.


 Param�tres
 ����������

  Q         Nom de l'objet de recouvrement de tampon (Array List)
  Str       Pointeur de la cha�ne de  caract�res de  format  Pascal devant
            �tre ajouter au recouvrement de tampon (Array List)
  Num       Nombre entier devant �tre ajouter � la  liste avant le contenu
            de l'enregistrement.
}

Function ALAddStrWord(Var Q:ArrayList;Const Str:String;Num:Word):Boolean;
Var
 StrWord:PStrWord;
 Ptr:Pointer;
Begin
 ALAddStrWord:=False;
 Ptr:=ALAdd(Q,SizeOf(StrWordRec));
 If(Ptr=NIL)Then Exit;
 StrWord:=Ptr;
 StrWord^.PChr:=Str2PChr(Str);
 StrWord^.Len:=Length(Str);
 StrWord^.Nm:=Num;
 ALAddStrWord:=True
End;

Function ALAddStrLong(Var Q:ArrayList;Const Str:String;Num:LongInt):Boolean;
Var
 StrLong:PStrLong;
 Ptr:Pointer;
Begin
 ALAddStrLong:=False;
 Ptr:=ALAdd(Q,SizeOf(StrLongRec));
 If(Ptr=NIL)Then Exit;
 StrLong:=Ptr;
 StrLong^.PChr:=Str2PChr(Str);
 StrLong^.Len:=Length(Str);
 StrLong^.Nm:=Num;
 ALAddStrLong:=True
End;

{�������������������������������������������������������������������������
 �                           Fonction ALAddStr                           �
 �������������������������������������������������������������������������


 Description
 �����������

  Cette fonction permet d'ajouter une ligne de format cha�ne de caract�res
 Pascal � la fin de la liste sym�trique de l'objet �ArrayList�.


 Param�tres
 ����������

  Q         Nom de l'objet de recouvrement de tampon (Array List)
  Str       Pointeur de la cha�ne de  caract�res de  format  Pascal devant
            �tre ajouter au recouvrement de tampon (Array List)
}

Function ALAddStr(Var Q:ArrayList;Const Str:String):Boolean;
Var
 Ptr:Pointer;
 PC:PChr Absolute Ptr;
 Size:Word;
Begin
 If Length(Str)=0Then ALAddStr:=ALAddLn(Q)
  Else
 Begin
  ALAddStr:=False;
  Size:=Length(Str)+1;
  If(Size<MinRec)Then Size:=MinRec;
  Ptr:=ALAdd(Q,Size);
  If(Ptr=NIL)Then Exit;
  StrPCopy(PC,Str);
  ALAddStr:=True
 End;
End;

{�������������������������������������������������������������������������
 �                         Fonction ALAddSpcUStr                         �
 �������������������������������������������������������������������������


 Description
 �����������

  Cette fonction permet d'ajouter une ligne de format cha�ne de caract�res
 Pascal avec des espaces au d�but  de cette nouvelle  ligne � la fin de la
 liste sym�trique de l'objet �ArrayList�.


 Param�tres
 ����������

  Q         Nom de l'objet de recouvrement de tampon (Array List)
  S         Nombre d'espace  avant  la  cha�ne  de caract�res  devant �tre
            rajouter.
  Str       Pointeur de la cha�ne de  caract�res de  format  Pascal devant
            �tre ajouter au recouvrement de tampon (Array List)
}

Function ALAddSpcUStr(Var Q:ArrayList;S:Byte;Const Str:String):Boolean;Begin
 ALAddSpcUStr:=ALAddStr(Q,Spc(S)+Str)
End;

{��������������������������������������������������������������������
 �                         Fonction ALAddLn                         �
 ��������������������������������������������������������������������


 Description
 �����������

  Cette fonction permet d'ajouter une ligne vide � la fin de la liste
 sym�trique de l'objet �ArrayList�.


 Param�tre
 ���������

  Q         Nom de l'objet de recouvrement de tampon (Array List)
}

Function ALAddLn(Var Q:ArrayList):Boolean;Begin
 ALAddLn:=ALAddPChr(Q,NIL)
End;

{������������������������������������������������������������������������
 �                           Fonction ALInsStr                          �
 ������������������������������������������������������������������������


 Description
 �����������

  Cette fonction permet d'ajouter,  � une position pr�cise dans la liste,
 une ligne de format cha�ne de caract�res Pascal � la liste sym�trique de
 l'objet �ArrayList�.


 Param�tres
 ����������

  Q         Nom de l'objet de recouvrement de tampon (Array List)
  Str       Pointeur de la cha�ne de  caract�res de  format  Pascal devant
            �tre ajouter au recouvrement de tampon (Array List)
  P         Position dans la liste  � laquel  il faut ajouter la cha�ne de
            caract�res de format Pascal.
}

Function ALInsStr(Var Q:ArrayList;P:RBP;Const Str:String):Boolean;
Var
 Ptr:Pointer;
 PC:PChr;
 Size:Word;
Begin
 ALInsStr:=False;
 Size:=Length(Str)+1;
 If(Size<MinRec)Then Size:=MinRec;
 Ptr:=ALIns(Q,P,Size);
 If(Ptr=NIL)Then Exit;
 PC:=Ptr;
 StrPCopy(PC,Str);
 ALInsStr:=True
End;

{�����������������������������������������������������������������������
 �                         Fonction ALInsStrWord                       �
 �����������������������������������������������������������������������


 Description
 �����������

  Cette fonction permet d'ajouter, � une position pr�cise dans la liste,
 une ligne de format cha�ne  de caract�res Pascal avec un mot � la liste
 sym�trique de l'objet �ArrayList�.


 Param�tres
 ����������

  Q         Nom de l'objet de recouvrement de tampon (Array List)
  P         Position dans la liste  � laquel  il faut ajouter la cha�ne de
            caract�res de format Pascal et le mot.
  Str       Pointeur de la cha�ne de  caract�res de  format  Pascal devant
            �tre ajouter au recouvrement de tampon (Array List)
  Num       Nombre devant � ajouter  (avec la cha�nes de caract�res)  dans
            le recouvrement de tampon.
}

Function ALInsStrWord(Var Q:ArrayList;P:RBP;Const Str:String;Num:Word):Boolean;
Var
 StrWd:PStrWord;
 Ptr:Pointer;
Begin
 ALInsStrWord:=False;
 Ptr:=ALIns(Q,P,SizeOf(StrWordRec));
 If(Ptr=NIL)Then Exit;
 StrWd:=Ptr;
 StrWd^.PChr:=Str2PChr(Str);
 StrWd^.Len:=Length(Str);
 StrWd^.Nm:=Num;
 ALInsStrWord:=True
End;

{�����������������������������������������������������������������������
 �                         Fonction ALAddPChrWord                      �
 �����������������������������������������������������������������������


 Description
 �����������

  Cette fonction permet d'ajouter une ligne de format ASCIIZ avec un mot
 entier � la fin de la liste sym�trique de l'objet �ArrayList�.
}

Function ALAddPChrWord(Var Q:ArrayList;PChr:PChr;Num:Word):Boolean;
Var
 PChrWd:PPChrWord;
 Ptr:Pointer;
Begin
 ALAddPChrWord:=False;
 Ptr:=ALAdd(Q,SizeOf(PCharWordRec));
 If(Ptr=NIL)Then Exit;
 PChrWd:=Ptr;
 PChrWd^.PChr:=PChr;
 PChrWd^.Nm:=Num;
 ALAddPChrWord:=True
End;

{�������������������������������������������������������������������������
 �                            Fonction ALGetBuf                          �
 �������������������������������������������������������������������������


 Description
 �����������

  Cette fonction permet de conna�tre le contenu d'une ligne � une position
 pr�cis dans une liste sym�trique de l'objet �ArrayList� et  retourne
 �galement la longueur de cette ligne.
}

Function ALGetBuf(Var Q:ArrayList;P:RBP;Var Size:Word):Pointer;
{$IFDEF FLAT386}
 Var
  WP:RBufPtr;
 Begin
  Size:=0;ALGetBuf:=NIL;
  If(P=rbMax)Then P:=Q.Count-1;
  If(P<0)or(P>=Q.Count)Then Exit;
  WP:=_ALSetPtr(Q,P);
  If(WP=NIL)Then Exit;
  ALGetBuf:=WP^.Buf;Size:=WP^.Size
 End;
{$ELSE}
 Assembler;ASM
  XOR AX,AX
  XOR DX,DX
  LES DI,Size
  STOSW
  LES DI,Q
  MOV SI,ES:[DI].ArrayList.Count
  MOV CX,P
  CMP CX,rbMax
  JNE @1
  MOV CX,SI
  DEC CX
 @1:
  CMP CX,SI
  JAE @End
  CMP CX,8000h
  JAE @End
  PUSH ES
  PUSH DI
  PUSH CX
  CALL _ALSetPtr
  MOV CX,AX
  OR  CX,DX
  JZ  @End
  XCHG AX,DI
  MOV ES,DX
  MOV AX,ES:[DI].RBufRec.Size
  LES BX,ES:[DI].RBufRec.Buf
  MOV DX,ES
  LES DI,Size
  STOSW
  XCHG AX,BX
 @End:
 END;
{$ENDIF}

{��������������������������������������������������������������������
 �                         Fonction _ALGetStr                       �
 ��������������������������������������������������������������������


 Description
 �����������

  Cette fonction permet de conna�tre le contenu d'une ligne de format
 cha�ne  de caract�res  Pascal �  une position pr�cis  dans une liste
 sym�trique de l'objet �ArrayList�.
}

Function _ALGetStr(Var Q:ArrayList;P:RBP):String;Begin
 _ALGetStr:=StrPas(_ALGetBuf(Q,P))
End;

{�������������������������������������������������������������������������
 �                           Proc�dure ALSetPtr                          �
 �������������������������������������������������������������������������


 Description
 �����������

  Cette proc�dure permet de fixer le pointeur de liste courant de la liste
 sym�trique de l'objet �ArrayList�.
}

Procedure ALSetPtr(Var Q:ArrayList;P:RBP);
{$IFDEF FLAT386}
 Begin
  Q.CurrPtr:=_ALSetPtr(Q,P);
 End;
{$ELSE}
 Assembler;ASM
  LES DI,Q
  PUSH ES
  PUSH DI
  PUSH P
  CALL _ALSetPtr
  LES DI,Q
  CLD
  ADD DI,Offset ArrayList.CurrPtr
  STOSW
  XCHG AX,DX
  STOSW
 END;
{$ENDIF}

{�������������������������������������������������������������������
 �                        Proc�dure ALPrevious                     �
 �������������������������������������������������������������������


 Description
 �����������

  Cette proc�dure permet de passer � la ligne pr�c�dente de la liste
 sym�trique de l'objet �AraryList�.
}

Procedure ALPrevious(Var Q:ArrayList);Assembler;ASM
 {$IFDEF FLAT386}
  XCHG ECX,EAX
  LEA EDX,[ECX].ArrayList.CurrPtr
  OR  EDX,EDX
  JZ  @End
  LEA EAX,[EDX].RBufRec.Prev
  MOV [ECX].ArrayList.CurrPtr,EAX
@End:
 {$ELSE}
  PUSH DS {Begin If(Q.CurrPtr<>NIL)Then Q.CurrPtr:=Q.CurrPtr^.Prev;End;}
   LES DI,Q
   LDS SI,ES:[DI].ArrayList.CurrPtr
   MOV CX,DS
   OR  CX,SI
   JCXZ @End
   CLD
   ADD SI,Offset RBufRec.Prev
   ADD DI,Offset ArrayList.CurrPtr
   MOVSW
   MOVSW
 @End:
  POP DS
 {$ENDIF}
END;

{�����������������������������������������������������������������
 �                       Proc�dure ALNext                        �
 �����������������������������������������������������������������


 Description
 �����������

  Cette proc�dure permet de passer � la ligne suivante de la liste
 sym�trique de l'objet �ArrayList�.
}

Procedure ALNext(Var Q:ArrayList);Assembler;ASM
 {$IFDEF FLAT386}
  XCHG EAX,ECX
  LEA EDX,[ECX].ArrayList.CurrPtr
  OR  EDX,EDX
  JZ  @End
  MOV EAX,[EDX].RBufRec.Nxt
  MOV [ECX].ArrayList.CurrPtr,EAX
@End:
 {$ELSE}
  PUSH DS {Begin If(Q.CurrPtr<>NIL)Then Q.CurrPtr:=Q.CurrPtr^.Nxt;End;}
   LES DI,Q
   LDS SI,ES:[DI].ArrayList.CurrPtr
   MOV CX,DS
   OR  CX,SI
   JCXZ @End
   CLD
   ADD SI,Offset RBufRec.Nxt
   ADD DI,Offset ArrayList.CurrPtr
   MOVSW
   MOVSW
 @End:
  POP DS
 {$ENDIF}
END;

{�������������������������������������������������������������������������
 �                            Fonction _ALGetBuf                         �
 �������������������������������������������������������������������������


 Description
 �����������

  Cette fonction permet de conna�tre le contenu d'une ligne � une position
 pr�cis dans une liste sym�trique de l'objet �ArrayList�.
}

Function _ALGetBuf(Var Q:ArrayList;P:RBP):Pointer;
{$IFDEF FLAT386}
 Var
  Size:Word;
 Begin
  _ALGetBuf:=ALGetBuf(Q,P,Size)
 End;
{$ELSE}
 Assembler;
 Var
  Size:Word;
 ASM
  LES DI,Q
  PUSH ES
  PUSH DI
  PUSH P
  PUSH SS
  MOV AX,Offset Size
  ADD AX,BP
  PUSH AX
  PUSH CS
  CALL Near Ptr ALGetBuf
 END;
{$ENDIF}

{��������������������������������������������������������������������������
 �                          Fonction _ALGetCurrBuf                        �
 ��������������������������������������������������������������������������


 Description
 �����������

  Cette proc�dure retourne l'enregistrement courante de la liste sym�trique
 de l'objet �ArrayList�
}

Function _ALGetCurrBuf(Var Q:ArrayList):Pointer;Assembler;ASM
 {$IFDEF FLAT386}
  XCHG EAX,EDX
  XOR EAX,EAX
  LEA EDX,[EDX].ArrayList.CurrPtr
  OR  EDX,EDX
  JZ  @End
  MOV EAX,[EDX].RBufRec.Buf
@End:
 {$ELSE}
  XOR AX,AX
  XOR DX,DX
  LES DI,Q
  LES DI,ES:[DI].ArrayList.CurrPtr
  MOV CX,ES
  OR  CX,DI
  JCXZ @End
  LES AX,ES:[DI].RBufRec.Buf
  MOV DX,ES
@End:
 {$ENDIF}
END;

{�������������������������������������������������������������������������
 �                         Proc�dure ALPushCurrPtr                       �
 �������������������������������������������������������������������������


 Description
 �����������

  Cette proc�dure permet de sauvegarder la position courante dans la liste
 sym�trique de l'objet �ArrayList�.
}

Function ALPushCurrPtr(Var Q:ArrayList):Pointer;Assembler;ASM
 {$IFDEF FLAT386}
  MOV EAX,[EAX].ArrayList.CurrPtr
 {$ELSE}
  LES DI,Q
  LES AX,ES:[DI].ArrayList.CurrPtr
  MOV DX,ES
 {$ENDIF}
END;

{�����������������������������������������������������������������������
 �                         Proc�dure ALPopCurrPtr                      �
 �����������������������������������������������������������������������


 Description
 �����������

  Cette proc�dure permet de restituer la position courante dans la liste
 sym�trique de l'objet �ArrayList�.
}

Procedure ALPopCurrPtr(Var Q:ArrayList;Addr:Pointer);Assembler;ASM
 {$IFDEF FLAT386}
  MOV [EAX].ArrayList.CurrPtr,EDX
 {$ELSE}
  LES AX,Addr
  MOV DX,ES
  LES DI,Q
  CLD
  ADD DI,Offset ArrayList.CurrPtr
  STOSW
  XCHG AX,DX
  STOSW
  {MOV ES:[DI].ArrayList.CurrPtr.Word,AX
  MOV ES:[DI].ArrayList.CurrPtr.Word[2],DX}
 {$ENDIF}
END;

{������������������������������������������������������������������������
 �                           Fonction ALGetCurrBuf                      �
 ������������������������������������������������������������������������


 Description
 �����������

  Cette fonction permet de conna�tre le contenu de la ligne � la position
 courante dans la liste sym�trique de l'objet �ArrayList�.
}

Function ALGetCurrBuf(Var Q:ArrayList;Var Size:Word):Pointer;Assembler;ASM
 {$IFDEF FLAT386}
  XCHG EAX,ECX
  XOR EAX,EAX
  LEA ECX,[ECX].ArrayList.CurrPtr
  OR  ECX,ECX
  JZ  @End
  MOV EAX,[ECX].RBufRec.Buf
  MOV CX,[ECX].RBufRec.Size
@End:
  MOV [EDX],CX
 {$ELSE}
  XOR AX,AX
  XOR DX,DX
  LES DI,Q
  LES DI,ES:[DI].ArrayList.CurrPtr
  MOV CX,ES
  OR  CX,DI
  JCXZ @End
  MOV CX,ES:[DI].RBufRec.Size
  LES AX,ES:[DI].RBufRec.Buf
  MOV DX,ES
 @End:
  LES DI,Size
  MOV ES:[DI],CX
 {$ENDIF}
END;

{��������������������������������������������������������������������������
 �                            Fonction ALSetCurrBuf                       �
 ��������������������������������������������������������������������������


 Description
 �����������

  Cette fonction permet de modifier de remplacer une ligne par une nouvelle
 � la position courante dans la liste sym�trique de l'objet �ArrayList�.
}

Function ALSetCurrBuf(Var Q:ArrayList;Size:Word):Pointer;Assembler;ASM
 {$IFDEF FLAT386}
  LEA EAX,DWord Ptr Q
  LEA EDI,[EAX].ArrayList.CurrPtr
  OR  EDI,EDI
  JCXZ @1
  MOV  EDX,EAX
  ADD  EDX,Offset RBufRec.Size
  ADD  EAX,Offset RBufRec.Buf
  CALL _FreeMemory
  MOV AX,Size
  OR  AX,AX
  JZ   @1
  CALL MemAlloc
  OR  EAX,EAX
  JZ  @End
  LEA EDX,DWord Ptr Q
  LEA EDX,[EDX].ArrayList.CurrPtr
  MOV CX,Size
  MOV [EDX].RBufRec.Size,CX
  MOV [EDX].RBufRec.Buf,EAX
  JMP @End
@1:
  XOR EAX,EAX
@End:
 {$ELSE}
  LES DI,Q
  LES DI,ES:[DI].ArrayList.CurrPtr
  MOV CX,ES
  OR  CX,DI
  JCXZ @1
  PUSH ES
  MOV  SI,DI
  ADD  SI,Offset RBufRec.Buf
  PUSH SI
  PUSH ES
  MOV  SI,DI
  ADD  SI,Offset RBufRec.Size
  PUSH SI
  PUSH CS
  CALL Near Ptr _FreeMemory
  MOV CX,Size
  JCXZ @1
  PUSH CX
  PUSH CS
  CALL Near Ptr MemAlloc
  MOV CX,AX
  OR  CX,DX
  JCXZ @End
  LES DI,Q
  LES DI,ES:[DI].ArrayList.CurrPtr
  MOV CX,Size
  MOV ES:[DI].RBufRec.Size,CX
  MOV Word Ptr ES:[DI].RBufRec.Buf,AX
  MOV Word Ptr ES:[DI].RBufRec.Buf[2],DX
  JMP @End
 @1:XOR AX,AX
   XOR DX,DX
 @End:
 {$ENDIF}
END;

{��������������������������������������������������������������������
 �                        Fonction ALDelBufNSize                    �
 ��������������������������������������������������������������������


 Description
 �����������

  Cette fonction permet d'effacer une ligne de la liste sym�trique de
 l'objet �ArrayList� et de conna�tre la longueur de la ligne effacer.
}

Function ALDelBufNSize(Var Q:ArrayList;P:RBP;Var Size:Word):Boolean;
Var
 WP:RBufPtr;
Begin
 ALDelBufNSize:=False;Size:=0;
 If(Q.Count=0)or(P<0)or(P>=Q.Count)Then Exit;
 WP:=Q.Ls;
 If P=0Then Begin
  If(WP=NIL)Then Exit;
  Size:=WP^.Size;
  Memories.FreeMemory(WP^.Buf,WP^.Size);
  Memories.FreeMemory(WP,SizeOf(WP^));
  If Q.Count>1Then Begin
   If(Q.Ls^.Nxt=NIL)Then Exit;
   WP^.Nxt^.Prev:=NIL;
   Q.Ls:=Q.Ls^.Nxt;
   Q.CurrPtr:=NIL;
   Dec(Q.Count)
  End
   else
  ALInit(Q)
 End
  else
 Begin
  WP:=_ALSetPtr(Q,P);
  If(WP=NIL)Then Exit;
  If P=Q.Count-1Then Begin
   Q.EndLsPtr:=WP^.Prev;
   WP^.Prev^.Nxt:=NIL;
  End
   Else
  Begin
   WP^.Nxt^.Prev:=WP^.Prev;
   WP^.Prev^.Nxt:=WP^.Nxt;
  End;
  Size:=WP^.Size;
  Memories.FreeMemory(WP^.Buf,WP^.Size);
  Memories.FreeMemory(WP,SizeOf(Q.Ls^));
  Dec(Q.Count)
 End;
 ALDelBufNSize:=True
End;

{��������������������������������������������������������������������
 �                          Fonction ALDelBuf                       �
 ��������������������������������������������������������������������


 Description
 �����������

  Cette fonction permet d'effacer une ligne de la liste sym�trique de
 l'objet �ArrayList�.
}

Function ALDelBuf(Var Q:ArrayList;P:RBP):Boolean;
{$IFDEF FLAT386}
 Var
  Size:Word;
 Begin
  ALDelBuf:=ALDelBufNSize(Q,P,Size);
 End;
{$ELSE}
 Assembler;
 Var
  Size:Word;
 ASM
  LES DI,Q
  PUSH ES
  PUSH DI
  PUSH P
  LEA DI,Size
  PUSH SS
  PUSH DI
  PUSH CS
  CALL Near Ptr ALDelBufNSize
 END;
{$ENDIF}

{�����������������������������������������������������������������
 �                         Fonction ALSet                        �
 �����������������������������������������������������������������


 Description
 �����������

  Cette fonction permet de modifier le contenu d'une ligne par une
 nouvelle dans une liste sym�trique de l'objet �ArrayList�.
}

Function ALSet(Var Q:ArrayList;P:RBP;Size:Word):Pointer;
Var
 WP:RBufPtr;
 Addr:Pointer;
Begin
 ALSet:=NIL;
 If(P<0)or(P>Q.Count)Then Exit;
 If(P=Q.Count)Then ALSet:=ALAdd(Q,Size)
  Else
 Begin
  WP:=_ALSetPtr(Q,P);
  If(WP=NIL)Then Exit;
  _FreeMemory(WP^.Buf,WP^.Size);
  If Size<>0Then Begin
   Addr:=MemAlloc(Size);
   If(Addr=NIL)Then Exit;
   WP^.Buf:=Addr;
   WP^.Size:=Size;
   ALSet:=Addr
  End;
 End;
End;

{����������������������������������������������������������������������
 �                          Fonction ALXChgBuf                        �
 ����������������������������������������������������������������������


 Description
 �����������

  Cette fonction permet d'�changer deux �l�ments d'une liste sym�trique
 de l'objet �ArrayList�.
}

Function ALXChgBuf(Var Q:ArrayList;A,B:RBP):Boolean;
Var
 WP,WPtr:RBufPtr;
 BufA,BufB:Pointer;
 SizeA,SizeB:Word;
 W:RBufRec;
Begin
 ALXChgBuf:=False;
 If(A<0)or(A>=Q.Count)or(B<0)Then Exit;
 BufA:=ALGetBuf(Q,A,SizeA);
 BufB:=ALGetBuf(Q,B,SizeB);
 WP:=_ALSetPtr(Q,A);
 WP^.Buf:=BufB;
 WP^.Size:=SizeB;
 If(B=Q.Count)Then Begin { �change avec un bloc � rajouter � la fin de la liste?}
  W.Buf:=BufA;
  W.Size:=SizeA;
  W.Nxt:=NIL;
  WPtr:=Q.EndLsPtr;
  W.Prev:=WPtr;
  WPtr^.Nxt:=NewBlock(W,SizeOf(Q.Ls^));
  Q.EndLsPtr:=WPtr^.Nxt
 End
  Else
 Begin
  WP:=_ALSetPtr(Q,B);
  WP^.Buf:=BufA;
  WP^.Size:=SizeA;
 End;
 ALXChgBuf:=True
End;

{��������������������������������������������������������������������
 �                          Fonction ALMax                          �
 ��������������������������������������������������������������������


 Description
 �����������

  Cette fonction retourne l'�l�ment maximum de la liste sym�trique de
 l'objet �ArrayList�.
}

Function ALMax(Var Q:ArrayList):RBP;Assembler;ASM
 {$IFDEF FLAT386}
  MOV EAX,[EAX].ArrayList.Count
  DEC EAX
 {$ELSE}
  LES DI,Q
  {$IFDEF NotReal}
   LES AX,ES:[DI].ArrayList.Count
   MOV DX,ES
  {$ELSE}
   MOV AX,ES:[DI].ArrayList.Count
  {$ENDIF}
  DEC AX
 {$ENDIF}
END;

{����������������������������������������������������������������������
 �                           Proc�dure ALDone                         �
 ����������������������������������������������������������������������


 Description
 �����������

  Cette proc�dure permet de lib�rer les zones de m�moires r�serv�es par
 l'objet �ArrayList� de liste sym�trique.
}

Procedure ALDone(Var Q:ArrayList);
Var
 WP:RBufPtr;
 Ptr:PStrByte;
Begin
 WP:=Q.Ls;
 While(WP<>NIL)do Begin
  If(WP^.Size=SizeOf(StrByteRec))or(WP^.Size=SizeOf(StrWordRec))Then Begin
   Ptr:=WP^.Buf;
   StrDispose(Ptr^.PChr);
  End;
  Memories.FreeMemory(WP^.Buf,WP^.Size);
  Memories.FreeMemory(WP,SizeOf(RBufRec));
  WP:=WP^.Nxt;
  {$IFDEF Real}
   If PtrRec(WP).Ofs>$FThen Break;
  {$ENDIF}
 End;
 FillClr(Q,SizeOf(Q));
End;

{������������������������������������������������������������������������
 �                         Procedure _FreeMem                           �
 ������������������������������������������������������������������������


 Description
 �����������

  Cette proc�dure lib�re la m�moire (tout comme sa soeur FreeMem) mais en
 plus r�initialise les variables d'appel:  Le tampon pointe sur NIL et la
 variable de taille �Size�, vaut 0 apr�s appel de cette proc�dure.
}

Procedure _FreeMemory(Var x0:Pointer;Var Size:Word);Begin
 Memories.FreeMemory(x0,Size);
  { Met le pointeur � nulle ainsi que la taille � 0: }
 ASM
  XOR AX,AX
  LES DI,x0
  CLD
  STOSW
  STOSW
  LES DI,Size
  STOSW
 END;
End;

END.