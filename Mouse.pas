{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                   Malte Genesis/Module de Souris                    남�
 �      릁ition Chantal & Ad둳e pour Mode R괻l/IV - Version 1.0        남�
 �                     1995/02/02 � 1998/07/19                         남�
 �                                                                     남�
 �       Tous droits r굎erv굎 par les Chevaliers de Malte (C)          남�
 읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴侮�
  께께께께께께께께께께께께께께께께께께께께께께께께께께께께께께께께께께께께


 Description
 袴袴袴袴袴�

  Cette unit� est utilis� pour la gestion de la souris et de son pilote de
 souris accessible via l'interruption 33h. Elle apporte aussi des supports
 suppl굆entaire  comme le support  de pointeur graphique  en mode texte et
 un pointeur fournit pour des modes vid굊 non standard.
}

Unit Mouse;

{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}
                                 INTERFACE
{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}

{$I DEF.INC}
Uses Systex;

Const
 PtrMouse:Array[0..31]of Word=
    (($3FFF),  {0011111111111111}
     ($1FFF),  {0001111111111111}
     ($0FFF),  {0000111111111111}
     ($07FF),  {0000011111111111}
     ($03FF),  {0000001111111111}
     ($01FF),  {0000000111111111}
     ($00FF),  {0000000011111111}
     ($007F),  {0000000001111111}
     ($003F),  {0000000000111111}
     ($001F),  {0000000000011111}
     ($01FF),  {0000000111111111}
     ($10FF),  {0001000011111111}
     ($30FF),  {0011000011111111}
     ($F87F),  {1111100001111111}
     ($F87F),  {1111100001111111}
     ($FC7F),  {1111110001111111}

     ($0000),  {0000000000000000}
     ($4000),  {0100000000000000}
     ($6000),  {0110000000000000}
     ($7000),  {0111000000000000}
     ($7800),  {0111100000000000}
     ($7C00),  {0111110000000000}
     ($7E00),  {0111111000000000}
     ($7F00),  {0111111100000000}
     ($7F80),  {0111111110000000}
     ($7C00),  {0111110000000000}
     ($6C00),  {0110110000000000}
     ($4600),  {0100011000000000}
     ($0600),  {0000011000000000}
     ($0300),  {0000001100000000}
     ($0300),  {0000001100000000}
     ($0000)); {0000000000000000}

 LastMouseX:Byte=$FF;    { Volatile: Coordonn괻 texte de la derni둹e
                                     position du pointeur de la souris}
 LastMouseY:Byte=$FF;    { Volatile: Coordonn괻 texte de la derni둹e
                                     position du pointeur de la souris}
 LastMouseB:Byte=0;      { Volatile: 릘at des boutons souris }
 MouseTxtGrf:Boolean=False;{ Souris graphique en mode texte? }
 ColorMouse:Word=15;     { Couleur de la souris par d괽aut }
 BorderColorMouse:Word=0;{ Couleur de la bordure de la souris }
 LeftMouse:Boolean=False;{ Souris pour gauche? }

Var
 MouseMove:Boolean;   { D굋lacement du pointeur de souris a eu lieu
                        depuis la derni둹e demande de position de
                        souris.}

Procedure DelayMousePress(Milli:Word);
Procedure DisposeMousePtr;
Function  GetB(BMask:Word;Var Count,LastX,LastY:Word):Word;
Function  GetBRelease(BMask:Word;Var Count,LastX,LastY:Word):Word;
Function  GetMouseButton:Byte;Far;
Procedure GetMouseSwitch(Var X,Y,B:Word);
Function  GetMousePtrType:Byte;
Procedure HideMousePtr;
Function  InitMouse:Boolean;
Procedure InstallMouseSub(Flags:Word;Addr:Pointer);
Function  IsMouseMove:Boolean;
Function  IsShowMouse:Boolean;
Procedure LightPenOn;
Procedure LightPenOff;
Procedure MakeMousePtrObj(L,H:Byte;Obj:Pointer);
Procedure MakeMousePtrSprite(L,H:Byte;Obj:Pointer);
Procedure ReadMotion(Var hCount,vCount:Word);
Procedure ResetMouseMove;
Procedure SetGraphPointer(HotX,HotY:Word;Var Image);
Procedure SetMouse(Use:Boolean);
Procedure SetMouseMove(Value:Boolean);
Procedure SetMouseMoveArea(X1,Y1,X2,Y2:Word);
Procedure SetMouseMoveAreaX(X1,X2:Word);
Procedure SetMouseMoveAreaY(Y1,Y2:Word);
Procedure SetMousePos(X,Y:Word);
Procedure SetTextPointer(Select:Word;ScreenChar:Char;ScreenAttr:Byte;
                         PointerChar:Char;PointerAttr:Byte);
Procedure ShowMousePtr;
Procedure WaitMouseBut0;
Function  WaitMouseBut0OrOutZone(Const QX):Boolean;
Procedure WaitMouseMove;
Procedure __DoneMouse;
Function  __GetMouseButton:Byte;
Procedure __GetMouseTextSwitch(Var X,Y:Byte;Var B:Word);
Procedure __GetMouseTextSwitchZ(Var Z;Var B:Word);
Function  __GetMouseXPixels:Word;
Function  __GetMouseYPixels:Word;
Procedure __HideMousePtr;
Procedure __InitMouse;
Procedure __ShowMousePtr;

{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}
                              IMPLEMENTATION
{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}

Uses Adele,Video,Math,Memories,Systems;

Procedure DisableCOMint;Near;Forward;
Procedure ShowRet;Near;Assembler;ASM END;

Const
 ExternPtrMouse:^TByte=NIL;
 BufMouse:^TByte=NIL;
 BufMouseSize:Word=0;
 Button:Word=0;
 MousePtrSprite:Boolean=False;
 {$IFDEF FLAT386}
  ShowMethode:Pointer=@ShowRet;
  HideMethode:Pointer=@ShowRet;
 {$ELSE}
  ShowMethode:Word=Ofs(ShowRet);
  HideMethode:Word=Ofs(ShowRet);
 {$ENDIF}
 FirstTimeMouse:Boolean=True; { La routine d'initialisation n'a jamais 굏� lanc� }
 COMIncoming:Word=0;          { Port s굍ie: Num굍o d'octet re뇎 }
 ExtraByte:Byte=0;            { Octet d'extra (Logitech) }
 LGbstat:Byte=0;              { Etat de Logitech }
 X_LO:Byte=0;                 { Position Base Logitech }
 MSCButtState:Word=0;         { Etat des boutons en mode Mouse Systems}

Var
 MouseOldTextX,MouseOldTextY,MouseOldTextAttr:Byte;
 MouseOldX,MouseOldY:Integer;      { Ancienne position de la souris }
 ShowMouse:Boolean;                { Souris affich� }
 LenObj,LenPlane,HeightObj:Byte;
 BaseObj:Word;
 PushX1,PushY1,PushX2,PushY2:Word; { R괾ion sauvegarder en graphique }
 UserMove:Boolean;
 OldBackKbd:Procedure;             { Appel de l'ancienne routine d'arri둹e plan }
 OldIntIRQ:Pointer;                { Ancienne interruption IRQ }

Function MouseDriverFound:Byte;Assembler;ASM
 MOV AL,0
 MOV AH,Adele.Mouse
 CMP AH,AL
 JE  @NoDriver
 CMP AH,msPS2
 JE  @NoDriver
 MOV AL,1
 STC
 JMP @End
@NoDriver:
 CLC
@End:
END;

{ 旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
  �                       Proc괺ure AsmGetMouseSwitch                  �
  잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


  Portabilit�:  Local


  Description
  袴袴袴袴袴�

   Cette proc괺ure permet de conna똳re la position actuel du pointeur de
  souris ainsi que l'굏at de ces boutons.


  Remarque
  袴袴袴袴

   � Cette proc괺ure retourne ses valeurs directement dans les registres
     du microprocesseur.


  Param둻res de sortie
  袴袴袴袴袴袴袴袴袴袴

   BX             릘at des boutons
   CX             Coordonn괻s horizontal
   DX             Coordonn괻s vertical
}

Procedure AsmGetMouseSwitch;Near;Assembler;ASM
 MOV AL,Adele.Mouse
 CMP AL,msPS2
 JE  @DirectMethode
 CMP AL,msCOM
 JE  @DirectMethode
 CALL MouseDriverFound
 JNC  @NoDriver
 MOV AX,3
 INT 033h
 OR  BX,BX
 JZ  @End
 CMP LeftMouse,True
 JNE @End
 XOR BX,3 { Inverse les boutons }
 JMP @End
@DirectMethode:
 MOV BX,Button
 MOV CX,Word Ptr MouseOldX
 MOV DX,Word Ptr MouseOldY
 JMP @End
@NoDriver:
 XOR CX,CX
 XOR DX,DX
 XOR BX,BX
@End:
END;

Procedure InstallPS2(Routine:Pointer);Assembler;ASM
 {$IFNDEF FLAT386}
  MOV CX,2
@Try2:
  LES BX,Routine
  MOV AX,0C207h
  INT 15h
  JNC @PSokyet
  CMP AH,4
  JNE @noPSdet
  LOOP @Try2
  JMP @noPSdet
@PSokyet:
  MOV BH,3
  MOV AX,0C203h
  INT 15h
  JC  @NoPSdet        { Fixe la r굎olution Souris BH}
  MOV BH,1
  MOV AX,0C200h
  INT 15h
  JC  @NoPSdet        { Active la souris}
  XOR DL,DL
  XOR BH,BH
  MOV AX,0C206h
  INT 15h
@NoPSdet:
@End:
 {$ENDIF}
END;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                       Fonction GetMousePtrType                �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Description
 袴袴袴袴袴�

   Cette fonction permet de conna똳re le mod둳e de pointeur souris
  actuellement utilis� par cette unit�.
}

Function GetMousePtrType:Byte;Begin
 If(IsGrf)Then GetMousePtrType:=mpGrf Else
 If(MouseTxtGrf)and(FontFound)Then GetMousePtrType:=mpTxtGrf
                              Else GetMousePTrType:=mpTxtAttr;
End;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                          Proc괺ure WaitMouseMove                   �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Description
 袴袴袴袴袴�

   Cette proc괺ure permet d'attendre que l'utilisateur est rel긟her les
  boutons de la souris ou effectuer un mouvement du pointeur de souris.
}

Procedure WaitMouseMove;Begin
 ResetMouseMove;
 Repeat
  {$IFNDEF Win32}
   STI;
  {$ENDIF}
 Until(MouseMove)and(__GetMouseButton=0)
End;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                          Proc괺ure ResetMouseMove                     �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Description
 袴袴袴袴袴�

   Cette proc괺ure r굀nitialise  le drapeau de d굋lacement  de la souris en
  niveau interne des routines de cette unit굎 ayant lieu chaque fois qu'une
  action a lieu de la part de la souris.
}

Procedure ResetMouseMove;Assembler;ASM
 PUSHF
  CLI
  MOV MouseMove,False
  MOV UserMove,False
 POPF
End;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                            Proc괺ure DelayMousePress                    �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Description
 袴袴袴袴袴�

  Cette proc괺ure attend un certain d굃ai en milliseconde ou que les boutons
 de la souris soit rel긟her avant de redonner l'ex괹ution.
}

Procedure DelayMousePress(Milli:Word);
Var
 T,N:Word;
 TL:LongInt;
 Old,Curr:Byte;
Begin
 TL:=LongInt(DivLong(LongInt(Milli)*182,10000));
 T:=TL;N:=0;Old:=GetRawTimerB;
 Repeat
  _BackKbd;
  If __GetMouseButton=0Then Exit;
  Curr:=GetRawTimerB;
  If(Old<>Curr)Then Begin
   Old:=Curr;Inc(N);
   If(N>=T)Then Exit;
  End;
 Until False;
End;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                           Proc괺ure WaitMouseBut0                      �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Description
 袴袴袴袴袴�

  Cette proc괺ure attend que l'utilisateur est rel긟her tous les boutons de
 la souris avant de reprendre l'ex괹ution du programme.
}

Procedure WaitMouseBut0;Assembler;ASM
@0:
 STI
 {$IFDEF FLAT386}
  CALL __GetMouseButton
 {$ELSE}
  PUSH CS
  CALL Near Ptr __GetMouseButton
 {$ENDIF}
 OR  AL,AL
 JNZ @0
END;

Function WaitMouseBut0OrOutZone(Const QX):Boolean;
Label
 Xit;
Var
 M:TextCharRec;
 B:Word;
Begin
 WaitMouseBut0OrOutZone:=True;
 Repeat
  __GetMouseTextSwitchZ(M,B);
  {$IFDEF NoAsm}
   If Not((XM>=Q.X1)and(XM<=Q.X2)and(YM>=Q.Y1)and(YM<=Q.Y2))Then Exit;
  {$ELSE}
   ASM
    {$IFDEF FLAT386}
     LEA EDI,QX
     MOV CX,M
     MOV AX,Word Ptr [EDI].TextBoxRec.X1
     MOV BX,Word Ptr [EDI].TextBoxRec.X2
     CMP CL,AL
     JNAE Xit
     CMP CL,BL
     JNBE Xit
     CMP CH,AH
     JNAE Xit
     CMP CH,BH
     JNBE Xit
    {$ELSE}
     LES DI,QX
     MOV CX,M
     MOV AX,Word Ptr ES:[DI].TextBoxRec.X1
     MOV BX,Word Ptr ES:[DI].TextBoxRec.X2
     CMP CL,AL
     JNAE Xit
     CMP CL,BL
     JNBE Xit
     CMP CH,AH
     JNAE Xit
     CMP CH,BH
     JNBE Xit
    {$ENDIF}
   END;
  {$ENDIF}
 Until B=0;
 WaitMouseBut0OrOutZone:=False;
Xit:
End;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                          Proc괺ure SavePtr                            �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Description
 袴袴袴袴袴�

  Cette proc괺ure permet dans des 괹rans graphiques de sauvegarder l'image
 situ� sous le pointeur de souris.
}

Procedure SavePtr;Begin
 If(BufMouse<>NIL)Then Begin
  PushX1:=MouseOldX;
  PushY1:=MouseOldY;
  PushX2:=MouseOldX+LenObj-1;
  PushY2:=MouseOldY+HeightObj-1;
  If BitsPerPixel<8Then Begin
   PushX1:=PushX1 and$FFF8;
   PushX2:=PushX2 or 7;
  End;
  GetSmlImg(PushX1,PushY1,PushX2,PushY2,BufMouse^);
 End;
End;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                        Proc괺ure RestorePtr                         �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Description
 袴袴袴袴袴�

  Cette proc괺ure permet dans des 괹rans graphiques de restituer l'image
 situ� au pointeur de la souris.
}

Procedure RestorePtr;Near;Begin
 If(BufMouse<>NIL)Then PutSmlImg(PushX1,PushY1,PushX2,PushY2,BufMouse^);
End;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                          Proc괺ure MakeMousePtrObj                     �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Description
 袴袴袴袴袴�

  Cette proc괺ure permet de cr괻r l'affichage d'un pointeur graphique objet
 sp괹ifique de  style binaire.  Par d괽aut se doit donc 늯re le pointeur de
 fl둩he graphique...
}

Procedure MakeMousePtrObj;Begin
 _FreeMemory(Pointer(BufMouse),BufMouseSize);
 LenObj:=L;
 LenPlane:=L shr 3;
 HeightObj:=H;BaseObj:=HeightObj*LenPlane;
 BufMouseSize:=GetSizeSmlImg(0,0,H-1,L-1);
 BufMouse:=MemAlloc(BufMouseSize);
 ExternPtrMouse:=Obj;
 MousePtrSprite:=False;
End;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                         Proc괺ure MakeMousePtrSprite                   �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Description
 袴袴袴袴袴�

  Cette proc괺ure permet de sp괹ifier un pointeur de style 췚prite� donc il
 ne s'agit plus ici d'une image binaire mais bien des dessins v굍itables!
}

Procedure MakeMousePtrSprite;Begin
 _FreeMemory(Pointer(BufMouse),BufMouseSize);
 LenObj:=L;LenPlane:=L;HeightObj:=H;
 BaseObj:=HeightObj*LenPlane;
 BufMouseSize:=GetSizeSmlImg(0,0,H-1,L-1);
 BufMouse:=MemAlloc(BufMouseSize);
 ExternPtrMouse:=Obj;
 MousePtrSprite:=True;
End;

Procedure PutPtr(X,Y:Integer);Near;
Var
 I,J,Ja:Word;
Begin
 If(ExternPtrMouse=NIL)Then For J:=0to 15do Begin
  CopT8Bin(X,Y+J,Not(Hi(PtrMouse[J])),BorderColorMouse);
  CopT8Bin(X+8,Y+J,Not(Lo(PtrMouse[J])),BorderColorMouse);
  CopT8Bin(X,Y+J,Hi(PtrMouse[16+J]),ColorMouse);
  CopT8Bin(X+8,Y+J,Lo(PtrMouse[16+J]),ColorMouse);
 End
  Else
 If(MousePtrSprite)Then PutSprite(X,Y,X+LenPlane-1,Y+HeightObj-1,ExternPtrMouse^)
  Else
 For I:=0to LenPlane-1do Begin
  Ja:=0;
  For J:=0to HeightObj-1do Begin
   CopT8Bin(X+(I shl 3),Y+J,Not(ExternPtrMouse^[Ja+I]),BorderColorMouse);
   CopT8Bin(X+(I shl 3),Y+J,ExternPtrMouse^[BaseObj+Ja+I],ColorMouse);
   Inc(Ja,LenPlane);
  End;
 End;
End;

Var C1,C2,C3,C4:Byte;

Procedure HideTxt;Near;Begin
 If(GetMousePtrType=mpTxtGrf)Then Begin
  SetChr(PushX1,PushY1,Chr(C1));
  SetChr(PushX1+1,PushY1,Chr(C2));
  SetChr(PushX1,PushY1+1,Chr(C3));
  SetChr(PushX1+1,PushY1+1,Chr(C4));
 End
  Else
 SetAttr(PushX1,PushY1,MouseOldTextAttr)
End;

Procedure SaveTxt;Near;Begin
 PushX1:=MouseOldTextX;PushY1:=MouseOldTextY;
 MouseOldTextAttr:=GetAttr(MouseOldTextX,MouseOldTextY);
 If(GetMousePtrType=mpTxtGrf)Then GetSmlImg(MouseOldTextX,MouseOldTextY,0,0,C1);
End;

Procedure ShowTxt;Near;
Var
 J,XP,YP,D:Byte;
Begin
 If(GetMousePtrType=mpTxtGrf)Then Begin
  XP:=MouseOldX and 7;
  YP:=MouseOldY mod GetHeightChr;
  PutSmlImg(XP,YP,MouseOldTextX,MouseOldTextY,C1);
 End
  Else
 SetAttr(MouseOldTextX,MouseOldTextY,Not(MouseOldTextAttr))
End;

Procedure MouEventHandler(EvFlags,ButState,X,Y:Integer);Near;Begin
 MouseMove:=True;
 UserMove:=True;
 If X<0Then X:=0;
 If Y<0Then Y:=0;
 MouseOldX:=X;                      { Ancienne position horizontal en pixel }
 MouseOldY:=Y;                      { Ancienne position vertical en pixel }
 If(EvFlags and meMsMove=meMsMove)Then Begin
  If(IsGrf)Then Begin
   MouseOldTextX:=X shr 3;            { Ancienne position horizontal en texte }
   MouseOldTextY:=Y div GetHeightChr; { Ancienne position vertical en texte }
  End
   Else
  Begin
   If(GetMousePtrType=mpTxtGrf)Then Begin
    MouseOldTextX:=X shr 3;
    MouseOldTextY:=Y div GetHeightChr;
   End
    Else
   Begin
    ASM
     {X:=X shr 3;}
     {Y:=Y shr 4;}
     MOV CL,3
     SHR X,CL
     INC CX
     SHR Y,CL
    END;
    MouseOldTextX:=X;
    MouseOldTextY:=Y;
   End;
  End;
 End;
 Button:=ButState;                   { Derni둹e 굏at des boutons de la souris }
 If(LeftMouse)and(Button>0)Then ASM
  XOR Button,3
 END;
End;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                         Proc괺ure AssHand                       �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Portabilit�:  Local


 Description
 袴袴袴袴袴�

  Le gestionnaire d'굒굈ements 굏ant d'abord appel� par le pilote de
 la souris et appelle alors � son tour la proc괺ure Pascal
 췔ouEventHandler�.


 Remarque
 袴袴袴袴

  � L'appel en langage Pascal est formellement interdit!


 Param둻res d'entr괻
 袴袴袴袴袴袴袴袴袴�

  AX          = Drapeaux d'굒굈ements du pilote de souris
  BX          = 릘at des boutons de la souris
}

{Variable sur le Code Segment:}
Procedure Actif;Assembler;ASM
 DB 0; { Indique si un appel est actuellement en cours d'ex괹ution}
END;

Procedure AdresseData;Assembler;ASM
 DD MouseMove; {Indique l'adresse du Data Segment}
END;

Procedure AssHand;Far;Assembler;ASM
{ Sauvegarder tout d'abord tous les registres du processeur sur la pile}
  CMP Byte Ptr Actif,0  { Appel non encore termin� ? }
  JNE @Fin              { Non --> ne pas permettre l'appel }
  MOV Byte Ptr Actif,1  { Ne plus autoriser d'appels }
  PUSH AX
   PUSH BX
    PUSH CX
     PUSH DX
      PUSH DI
       PUSH SI
        PUSH BP
         PUSH ES
          PUSH DS
           { Placer sur la pile les arguments pour l'appel de la }
           { fonction Pascal. Appel: }
           {  MouEventHandler (EvFlags,ButStatus,x,y:Integer); }
           PUSH AX            {Placer les drapeaux d'굒굈ements sur la pile}
           PUSH BX            {Etat des boutons de la souris sur la pile}
           PUSH CX
           PUSH DX            {et placer sur la pile}
           MOV  DS,Word Ptr AdresseData[2]
           CALL MouEventHandler               {Appel de la proc괺ure Pascal}
           { Retirer de la pile les registres sauvegard굎 }
          POP DS
         POP ES
        POP BP
       POP SI
      POP DI
     POP DX
    POP CX
   POP BX
  POP AX
  MOV Byte Ptr Actif,0 { Appel � nouveau autoris� }
@Fin:
END;

Procedure XMov;Assembler;ASM
 DW 0
END;

Procedure YMov;Assembler;ASM
 DW 0
END;

Procedure ButtonFlags;Assembler;ASM
 DW 0
END;

Procedure PS2Hand;Far;Assembler;ASM
 {$IFNDEF FLAT386}
  CLD
  CMP Byte Ptr Actif,0  { Appel non encore termin� ? }
  JNE @Fin              { Non --> ne pas permettre l'appel }
  MOV Byte Ptr Actif,1  { Ne plus autoriser d'appels }
  PUSH BP
   MOV BP,SP
   PUSH AX
    PUSH BX
     PUSH CX
      PUSH DX
       PUSH DS
        PUSH ES
         PUSH DI
          PUSH SI
           PUSH CS
            PUSH CS
            POP DS
           POP ES
           MOV AX,[BP+0Ch]
           TEST AH,AH
           JNZ @InvPS2Data
           AND AL,3
           MOV Byte Ptr ButtonFlags,AL
           MOV AX,[BP+0Ch]
           MOV BX,[BP+0Ah]
           MOV CX,[BP+8]
           TEST AL,10h
           JZ  @PSxNeg
           MOV BH,0FFh
 @PSxNeg:  TEST CX,CX
           JZ  @NoYMov
           NEG CL
           TEST AL,20h
           JNZ @NoYMov
           MOV CH,0FFh
 @NoYMov:  ADD Word Ptr YMov,CX
           ADD Word Ptr XMov,BX
           MOV AX,meMsMove
           PUSH AX
           PUSH Word Ptr ButtonFlags
           PUSH Word Ptr XMov
           PUSH Word Ptr YMov
           MOV DS,Word Ptr AdresseData[2]
           CALL MouEventHandler
 @InvPS2Data:
          POP SI
         POP DI
        POP ES
       POP DS
      POP DX
     POP CX
    POP BX
   POP AX
  POP BP
  MOV Byte Ptr Actif,0 { Appel � nouveau autoris� }
@Fin:
 {$ENDIF}
END;

Procedure MovePointer;Near;Assembler;ASM
 MOV AX,meMsMove
 PUSH AX
 PUSH Word Ptr ButtonFlags
 PUSH Word Ptr XMov
 PUSH Word Ptr YMov
 CALL MouEventHandler
 MOV AX,1
 PUSH AX
 DEC AX
 PUSH AX
 MOV AL,'0'
 ADD AL,Byte Ptr ButtonFlags
 PUSH AX
 CALL SetChr
END;

Procedure MicrosoftProc;Near;Assembler;ASM
 CBW
 CMP COMIncoming,0
 JNZ @MSsecond
 CMP AL,40h
 JB  @NoSync1
 XOR CX,CX
 MOV Word Ptr XMov,CX
 MOV Word Ptr YMov,CX
 SHR AL,1                        { Bit 0 - X incr굆ente HI}
 RCR Byte Ptr XMov,1
 SHR AL,1                        { Bit 1 - X incr굆ente HI}
 RCR Byte Ptr XMov,1
 SHR AL,1                        { Bit 2 - Y increment HI}
 RCR Byte Ptr YMov,1
 SHR AL,1                        { Bit 3 - Y increment HI}
 RCR Byte Ptr YMov,1
 AND AL,3
 SAR AL,1                        { Bit 4 - Bouton droite?}
 JNC @MSrrel                     { Saute si non press� }
 OR  AL,2                        { Fixe le bit 1 si press� }
@MSrrel:
 MOV Byte Ptr ButtonFlags,AL
 MOV COMIncoming,1
 JMP @End
@MSsecond:
 CMP COMIncoming,1
 JNE @MSthird
 MOV COMIncoming,2
 AND AL,3Fh
 OR  Byte Ptr XMov,AL        { Fixe X incr굆ente LO}
 JMP @End
@MSthird:
 CMP COMIncoming,2           { Troisi둴e octet?}
 JNE @nosync1                { Saute si pas le cas}
 MOV COMIncoming,0
 AND AL,3Fh
 OR  AL,Byte Ptr YMov        { Fixe Y incr굆ente LO}
 CBW
 MOV CX,AX
 MOV AL,Byte Ptr XMov
 CBW
 MOV BX,AX
 JMP MovePointer
{ JMP @End}
@NoSync1:
 MOV COMincoming,0
@End:
 JMP MovePointer
END;

{Lecture de la Logitech }
Procedure LogiProc;Near;Assembler;ASM
 MOV CX,COMIncoming              { CL = Lequel des octets est-ce?}
 TEST AL,40h                     { Premier?}
 JZ  @3f47                       { Saute si non}
 TEST CX,CX                      { CX = 0?}
 JZ  @3f47                       { Saute si oui}
 CMP CX,3
 JZ  @3f35                       { Saute si CX = 3}
 XOR CX,CX
 MOV COMIncoming,CX
 JMP @3f54
@3f35:
 XOR CX,CX
 MOV COMIncoming,CX
 TEST ExtraByte,4                { Milieu enfonc�?}
 JZ  @3f54                       { Saute si oui}
 AND ExtraByte,0FBh
 JMP @3f54
@3f47:
 TEST AL,40h                     { Premier?}
 JNZ @3f54                       { Saute si oui}
 TEST CX,CX                      { Premier?}
 JNZ  @3f54                      { Saute si oui}
@endLGproc:
 RET
@3f54:
 TEST CX,CX                      { Premier?}
 JNZ @3f5e                       { Saute si non}
 MOV LGbstat,AL                  { Sauvegarde ici}
 JMP @3f67
@3f5e:
 CMP CX,1                        { Deuxi둴e?}
 JNZ @3f67                       { Saute sinon}
 MOV X_LO,AL                     { Sauvegarde ici}
@3f67:
 INC COMIncoming                 { Requ늯e du prochaine octet}
 CMP CX,2                        { Troisi둴e?}
 JB  @EndLGproc                  { Saute si inf굍ieur}
 JA  @LG4th                      { Saute si sup굍ieur}
 MOV BL,X_LO
 {$IFOPT G+}
  SHL BL,2
 {$ELSE}
  SHL BL,1
  SHL BL,1
 {$ENDIF}
 MOV BH,LGbstat
 {$IFOPT G+}
  SHR BX,2
 {$ELSE}
  SHR BX,1
  SHR BX,1
 {$ENDIF}
 MOV DL,BL                          { DL = Xmovement}
 MOV BL,AL
 {$IFOPT G+}
  SHL BL,2
 {$ELSE}
  SHL BL,1
  SHL BL,1
 {$ENDIF}
 {$IFOPT G+}
  SHR BX,2
 {$ELSE}
  SHR BX,1
  SHR BX,1
 {$ENDIF}
 MOV DH,BL                          { DH = Ymovement}
 ROR BX,1
 ROR BH,1
 SHL BL,1
 {$IFOPT G+}
  RCL BH,2
 {$ELSE}
  RCL BH,1
  RCL BH,1
 {$ENDIF}
 AND BH,3
 MOV BL,BH                          { BL = Etat gauche/droite}
 MOV BH,ExtraByte
 TEST BH,4
 JZ  @3FAA
 OR  BL,4
@3FAA:
 MOV ExtraByte,BL                   { BL = 릘at bouton}
 MOV AL,DL
 CBW
 MOV Word Ptr XMov,AX
 MOV AL,DH
 CBW
 MOV Word Ptr YMov,AX
 JMP @3FED
@LG4th:
 MOV COMIncoming,0                  { Requ늯e des prochains: 3, 4}
 MOV BL,ExtraByte
 AND BL,4
 MOV CL,3
 AND AL,20h
 SHR AL,CL
 XOR BL,AL
 JNZ @3FD9
 JMP @endLGproc
@3FD9:
 XOR BL,ExtraByte
 MOV ExtraByte,BL
 XOR BX,BX
 MOV Word Ptr YMov,BX
 MOV Word Ptr XMov,BX
@3FED:
 MOV AL,ExtraByte
{ CALL updatebuttstat}
 MOV Byte Ptr ButtonFlags,AL
 MOV CX,Word Ptr YMov
 MOV BX,Word Ptr XMov
 JMP MovePointer
END;

{Mouse Systems}

Procedure MSystemsProc;Assembler;ASM
 CBW
 {$IFDEF FLAT386}
  MOV SI,COMIncoming
  OR  SI,SI
  JZ  @MSM1
  CMP SI,1
  JE  @MSM24
  CMP SI,2
  JE  @MSM3
  CMP SI,3
  JE  @MSM24
  CMP SI,4
  JE  @MSM5
 {$ELSE}
  MOV SI,COMIncoming
  SHL SI,1
  JMP Word Ptr @MSMoffsets[SI]
@MSMoffsets:
  DW Offset @MSM1        { fonctions pour chaque 5 octets msm }
  DW Offset @MSM24
  DW Offset @MSM3
  DW Offset @MSM24
  DW Offset @MSM5
 {$ENDIF}
{컴컴컴� 1st MSM octet 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴}
@MSM1:
 PUSH AX
  AND AL,0F8h
  CMP AL,80h                        { V굍ification synchroniser }
  JNE @nosync2                      { Saute si non synchroniser}
 POP AX
 NOT AX
 AND AX,7
 MOV COMIncoming,1                  { Requ늯e du prochaine octet}
 MOV MSCButtState,AX                { Sauvegarde l'굏at des boutons}
 XOR AX,AX
 MOV Word Ptr XMov,AX
 MOV Word Ptr YMov,AX               { Efface le mouvement }
 RET
@NoSync2:
  XOR AX,AX
  MOV COMIncoming,AX                { Red굆arre la reception}
  MOV Word Ptr XMov,AX
  MOV Word Ptr YMov,AX              { clear movement regs}
 POP AX
 RET
{컴컴� 2i둴e et 4i둴e octets MSM 컴컴컴컴컴컴컴컴컴컴}
@MSM24:
 ADD Word Ptr XMov,AX
 INC COMIncoming
 RET
{컴컴� 3i둴e octet MSM 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴}
@MSM3:
 MOV Word Ptr YMov,AX
 INC COMIncoming
 RET
{컴컴� 5i둴e octet MSM 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴}
@MSM5:
 ADD Word Ptr YMov,AX
 MOV COMIncoming,0
{--- Information de nouveau processus}
 MOV AX,MSCbuttstate
 MOV CL,0Eh
 SHL AX,CL
 RCL AX,1
 MOV CL,3
 RCL AH,CL
 OR  AL,AH
{ CALL updatebuttstat}
 MOV Byte Ptr ButtonFlags,AL
 MOV BX,Word Ptr XMov
 MOV CX,Word Ptr YMov
 NEG CX
 JMP MovePointer
END;


Procedure ComHand;{$IFNDEF FLAT386}Interrupt;{$ENDIF}Assembler;ASM
 CLD
 CMP Byte Ptr Actif,0  { Appel non encore termin� ? }
 JNE @Fin              { Non --> ne pas permettre l'appel }
 MOV Byte Ptr Actif,1  { Ne plus autoriser d'appels }
 CLI
 PUSH AX
  PUSH BX
   PUSH CX
    PUSH DX
     PUSH DS
      PUSH ES
       PUSH DI
        PUSH SI
         PUSH BP
          MOV AL,20h
          OUT 20h,AL        { Port 20h, fin d'interruption }
          MOV DS,Word Ptr AdresseData[2]
          MOV DX,DefMousePort

(*          ADD DX,5
          IN  AL,DX                        {3FDh check for overrun}
          MOV AH,AL
          SUB DX,5
          IN  AL,DX                        {3F8h flush receive buffer}
          MOV CL,Byte Ptr COMincoming
          MOV CH,0
          TEST AH,2
          JZ  @NoOverRun                { jump if no overrun occured}
          MOV Byte Ptr COMincoming,CH                { zero counter}
          JMP @ExitIRQh
@NoOverRun:
          TEST AH,1
          JZ  @ExitIRQh                { jump if data not ready}*)

          ADD DX,5
          IN  AL,DX
          SUB DX,5
          TEST AL,2
          JZ  @NoOverRun
          IN  AL,DX
          MOV COMincoming,0
          JMP @ExitIRQh
@NoOverrun:
          TEST AL,1
          JNZ @DataReady
          IN  AL,DX
          JMP @ExitIRQh
@DataReady:
          IN  AL,DX

          CMP TypeMouse,1   { Souris Microsoft?}
          JE  @MSproc
          CMP TypeMouse,2
          JE  @ProcLogi     { Logitech?}
          CALL MSystemsProc { Autrement mode MSM}
          JMP @ExitIRQh
@MSproc:  CALL MicrosoftProc
          JMP @ExitIRQh
@ProcLogi:CALL LogiProc
@ExitIRQh:
(*          MOV AL,20h
          OUT 20h,AL        { Port 20h, fin d'interruption }*)
         POP BP
        POP SI
       POP DI
      POP ES
     POP DS
    POP DX
   POP CX
  POP BX
 POP AX
@Fin:
END;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                       Proc괺ure __DoneMouse                    �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Portabilit�:  Globale


 Description
 袴袴袴袴袴�

  Cette proc괺ure d굎active toutes les routines enclench� par cette
 unit� et r굀nitialise la souris � son 굏at initiale.
}

Procedure __DoneMouse;Begin
 __HideMousePtr;
 InitMouse;
 Case(Adele.Mouse)of
  msPS2:InstallPS2(NIL);
  msCOM:Begin
   DisableComInt;
   SetIntVec(IRQIntNumMouse,OldIntIRQ);
  End;
 End;
End;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                          Proc괺ure HideDef                       �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Portabilit�:  Local


 Description
 袴袴袴袴袴�

  Cette routine est utilis� par d괽aut pour effacer le pointeur de la
 souris � l'괹ran.
}

Procedure HideDef;Near;Assembler;ASM
 CALL MouseDriverFound
 JNC @End
 MOV AX,2
 INT 33h
@End:
END;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                          Proc괺ure __HideMousePtr                      �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Description
 袴袴袴袴袴�

   Cette proc괺ure efface la pr굎ence du pointeur de la souris � l'괹ran et
  d'interdire sa pr굎ence � l'괹ran.
}

Procedure __HideMousePtr;Assembler;ASM
 PUSHF
  CLI
  XOR AL,AL
  {$IFDEF Adele}
   CMP Adele.Mouse,AL
  {$ELSE}
   CMP Chantal.Mouse,AL
  {$ENDIF}
  JE  @1
  CMP ShowMouse,AL
  JE  @1
  MOV ShowMouse,AL  { ShowMouse:=No; }
  CALL HideMethode
@1:
 POPF
END;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                          Proc괺ure ShowGS                          �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Portabilit�:  Local


 Description
 袴袴袴袴袴�

  Cette routine est utilis� pour l'affichage du pointeur de souris pour
 la carte vid굊 d'ATI Super CGA: 췍raphic Solutions�.
}

Procedure ShowGS;Near;Begin
 SavePtr;
 PutPtr(MouseOldX,MouseOldY);
End;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                          Proc괺ure ShowDef                        �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Portabilit�:  Local


 Description
 袴袴袴袴袴�

  Cette routine est utilis� pour l'affichage du pointeur de souris par
 d괽aut lorsqu'aucun pointeur n'est applicable au mode vid굊 actuel.
}

Procedure ShowDef;Near;Assembler;ASM
 CALL MouseDriverFound
 JNC @End
 MOV AX,1
 INT 33h
@End:
END;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                            Proc괺ure ShowText                          �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Portabilit�:  Local


 Description
 袴袴袴袴袴�

  Cette routine est utilis� pour l'affichage du pointeur de souris dans les
 괹ran de texte seulement.
}

Procedure ShowText;Near;Begin
 SaveTxt;
 ShowTxt;
End;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                          Proc괺ure __ShowMousePtr                    �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Portabilit�: Globale


 Description
 袴袴袴袴袴�

  Cette proc괺ure permet d'autoriser l'affichage du pointeur de la souris
 � l'괹ran.
}

Procedure __ShowMousePtr;Assembler;ASM
 PUSHF
  CLI
  {$IFDEF Adele}
   CMP Adele.Mouse,0
  {$ELSE}
   CMP Chantal.Mouse,0
  {$ENDIF}
  JE  @1
  CMP ShowMouse,1
  JE  @1
  CALL ShowMethode
  MOV ShowMouse,True  { ShowMouse:=True; }
@1:
 POPF
END;

Function IsTrueMouseMove:Boolean;Near;Assembler;ASM
 PUSHF
  CLI
  MOV AL,MouseMove
 POPF
END;

{ Cette routine est appel� pour  l'application courante lorsqu'il a du temps
 disponible pour le faire, exemple: curseur, l'heure, pointeur de souris,...
 Toutefois dans le cas suivant il n'est question que du pointeur de souris.
}

Procedure BackRoutine;Far;Begin
 OldBackKbd;
 If(IsTrueMouseMove)Then Begin
  {$IFNDEF Win32}
   CLI;
  {$ENDIF}
  MouseMove:=False;
  {$IFNDEF Win32}
   STI;
  {$ENDIF}
  If(IsGrf)Then Begin
   If(ShowMouse)Then RestorePtr;
   SavePtr;
   If(ShowMouse)Then PutPtr(MouseOldX,MouseOldY);
  End
   Else
  Begin
   If(ShowMouse)Then HideTxt;
   SaveTxt;
   If(ShowMouse)Then ShowTxt;
  End;
 End;
End;

Procedure DisableCOMint;Assembler;ASM
 PUSHF
  CLI
  IN  AL,21h               { 21h Demande le masque PIC}
  OR  AL,PICstateMouse     { D굎active les interruptions s굍ie}
  OUT 21h,AL
  MOV DX,DefMousePort
  ADD DX,3
  MOV AL,0
  OUT DX,AL                { {3FBh Fixe DLAB ferm�}
  INC DX
  IN  AL,DX                { 3FCh Contr뱇e modem}
  AND AL,0F3h
  OUT DX,AL                { 3FCh OUT2 ferm�}
  SUB DX,3
  MOV AL,0
  OUT DX,AL                {3F9h Toutes les interruptions ferm�}
 POPF
END;

Procedure EnableCOMint;Near;Assembler;ASM
 MOV DX,DefMousePort
 ADD DX,3
 MOV AL,80h
 OUT DX,AL          { 3FBh fixe DLAB ouvert}
 SUB DX,3
 MOV AX,96
 OUT DX,AX          { 3F8h,3F9h 1200 baud}
 ADD DX,3
 MOV AL,ComLCR
 OUT DX,AL          {3FBh DLAB ferm�, pas de parit�, stop=1, longueur=7/8}
 INC DX
 MOV AL,0Bh
 OUT DX,AL          {3FCh DTR/RTS/OUT2 ouvert}
 SUB DX,3
 MOV AL,1
 OUT DX,AL          {3F9h Interruption DR activ�}
 DEC AX
 MOV Byte Ptr COMIncoming,AL
 IN  AL,21h         {21h Demande le masque PIC}
 MOV AH,PICstateMouse
 NOT AH
 AND AL,AH          { Active l'interruption s굍ie}
 OUT 21h,AL
END;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                             Proc괺ure __InitMouse                       �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Portabilit�: Globale


 Description
 袴袴袴袴袴�

  Cette proc괺ure permet d'initialiser la souris en fonction du nouveau mode
 vid굊 venant  d'늯re changer  et d'initialiser  en fonction du nouveau mode
 vid굊  totalement  inconnu  si aucun changement  de mode vid굊  n'a eu lieu
 depuis le syst둴e d'exploitation.
}

Procedure __InitMouse;
Var
 X,Y,B:Word;
 Ok:Boolean;
Begin
 If(Adele.Mouse=msCOM)Then Begin
  If(FirstTimeMouse)Then GetIntVec(IRQIntNumMouse,OldIntIRQ);
  SetIntVec(IRQIntNumMouse,@ComHand);
 End;
 LenObj:=16;HeightObj:=16;
 {$IFDEF FLAT386}
  ShowMethode:=@ShowRet;
  HideMethode:=@ShowRet;
 {$ELSE}
  ShowMethode:=Ofs(ShowRet);
  HideMethode:=Ofs(ShowRet);
 {$ENDIF}
 If {$IFDEF Adele}Adele{$ELSE}Chantal{$ENDIF}.Mouse<>0Then Begin
   {Routine par d괽aut d'affichage}
  {$IFDEF FLAT386}
   If(IsGrf)Then ShowMethode:=@ShowGS
            Else ShowMethode:=@ShowText;
  {$ELSE}
   If(IsGrf)Then ShowMethode:=Ofs(ShowGS)
            Else ShowMethode:=Ofs(ShowText);
  {$ENDIF}
   {Routine par d괽aut de restauration}
  {$IFDEF FLAT386}
   If(IsGrf)Then HideMethode:=@RestorePtr
            Else HideMethode:=@HideTxt;
  {$ELSE}
   If(IsGrf)Then HideMethode:=Ofs(RestorePtr)
            Else HideMethode:=Ofs(HideTxt);
  {$ENDIF}
  _FreeMemory(Pointer(BufMouse),BufMouseSize);
  InitMouse;
  ASM
   PUSHF
    CLI
    MOV ShowMouse,False
   POPF
  END;
  If(IsGrf)Then Begin
   SetMouseMoveArea(0,0,GetMaxXPixels,GetMaxYPixels);
   SetMousePos(NmXPixels shr 1,NmYPixels shr 1);
  End
   Else
  Begin
   X:=MaxXTxts shl 3;Y:=MaxYTxts shl 4;
   If(GetMousePtrType=mpTxtGrf)Then Begin
    X:=X shl 3;
    Y:=Y*GetHeightChr;
   End;
   SetMouseMoveArea(0,0,X,Y);
   SetMousePos(NmXTxts shr 1,NmYTxts shr 1);
  End;
  If(GetMousePtrType=mpTxtGrf){and(CurrVideoMode<=7)}Then ASM
   MOV AX,01Ah{  Ces instructions sont n괹essaires  dans le cas o� le pilote }
   MOV BX,128 { de la souris sait  qu'il s'agit d'un mode texte et en d괺uit }
   MOV CX,256 { qu'il doit forc굆ent 늯re n괹essaire d'avoir des coordonn괻s }
   MOV DX,2   { multiple de 8 ou de 16 et non de 1...}
   INT 033h
  END;
   {GetMouseSwitch(X,Y,B);}
  ASM
   CALL AsmGetMouseSwitch
   MOV B,BX
   MOV X,CX
   MOV Y,DX
  END;
  MouseOldX:=X;MouseOldY:=Y;
  MouseOldTextX:=X shr 3;
  MouseOldTextY:=Y div HeightChr;
  If(IsGraf)Then Begin
   BufMouseSize:=GetSizeSmlImg(0,0,15,31);
   BufMouse:=MemAlloc(BufMouseSize);
   If(BufMouse=NIL)Then Exit;
   SavePtr;
  End
   Else
  SaveTxt;
  Case(Adele.Mouse)of
   msPS2:InstallPS2(@PS2Hand);
   msCOM:Begin
    EnableCOMint;
   End;
   Else InstallMouseSub(meAll,@AssHand);
  End;
 End;
 If(FirstTimeMouse)Then Begin
  FirstTimeMouse:=False;
  OldBackKbd:=_BackKbd;
  _BackKbd:=BackRoutine;
 End;
End;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                           Fonction InitMouse                         �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Description
 袴袴袴袴袴�

  Cette fonction permet d'initialiser le pilote de souris c'est toutefois
 s'occuper  des routines  interne  � cette unit�,  il ne s'applique qu'au
 niveau du pilote logiciel du syst둴e d'exploitation.
}

Function InitMouse:Boolean;Assembler;ASM
 CALL MouseDriverFound
 JNC @End
 XOR AX,AX
 INT 33h
@End:
END;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                        Proc괺ure ShowMousePtr                     �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Description
 袴袴袴袴袴�

  Cette proc괺ure permet de r괶fficher le pointeur classique de souris
 fournit  avec le  pilote de  souris.  Il n'a  pas  d'influence sur le
 gestionnaire d'굒굈ement comme la proc괺ure �__ShowMousePtr�.
}

Procedure ShowMousePtr;Assembler;ASM
 CALL MouseDriverFound
 JNC @End
 MOV AX,1
 INT 33h
@End:
END;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                          Proc괺ure HideMousePtr                       �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Description
 袴袴袴袴袴�

  Cette proc괺ure permet d'effacer le pointeur classique de souris fournit
 avec le pilote  de souris.  Il n'a pas  d'influence  sur le  gestionnaire
 d'굒굈ement comme la proc괺ure �__HideMousePtr�.
}

Procedure HideMousePtr;Assembler;ASM
 CALL MouseDriverFound
 JNC @End
 MOV AX,2
 INT 33h
@End:
END;

{ 旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
  �                       Proc괺ure GetMouseSwitch                     �
  잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


  Description
  袴袴袴袴袴�

   Cette proc괺ure permet de conna똳re la position actuel du pointeur de
  souris ainsi que l'굏at de ces boutons.
}

Procedure GetMouseSwitch(Var X,Y,B:Word);Assembler;ASM
 {$IFDEF FLAT386}
 {$ELSE}
  CALL AsmGetMouseSwitch
  LES DI,X
  XCHG AX,CX
  STOSW
  LES DI,Y
  XCHG AX,DX
  STOSW
  LES DI,B
  XCHG AX,BX
  STOSW
 {$ENDIF} 
END;

{ 旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
  �                             Fonction GetB                               �
  잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Portabilit�: Globale


 Description
 袴袴袴袴袴�

  Cette fonction retourne l'굏at actuel des boutons de la souris et le nombre
 d'appui effectu괻  sur les boutons  ainsi que la position du pointeur souris
 o� cela c'est produit.
}

Function GetB(BMask:Word;Var Count,LastX,LastY:Word):Word;Assembler;ASM
 {$IFDEF FLAT386}
 {$ELSE}
  CALL MouseDriverFound
  JNC @End
  MOV AX,5
  MOV BX,BMask
  INT 33h
  LES DI,Count
  XCHG AX,BX
  STOSW
  LES DI,LastX
  XCHG AX,CX
  STOSW
  LES DI,LastY
  XCHG AX,DX
  STOSW
  XCHG AX,BX
@End:
 {$ENDIF}
END;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                             Fonction GetBRelease                         �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Portabilit�: Globale


 Description
 袴袴袴袴袴�

  Cette fonction retourne l'굏at actuel des boutons de la souris et le nombre
 de rel긟hement effectu괻  sur les boutons  ainsi que la position du pointeur
 souris o� cela c'est produit.
}

Function GetBRelease(BMask:Word;Var Count,LastX,LastY:Word):Word;Assembler;ASM
 {$IFDEF FLAT386}
 {$ELSE}
  CALL MouseDriverFound
  JNC @End
  MOV AX,6
  MOV BX,BMask
  INT 33h
  LES DI,Count
  XCHG AX,BX
  STOSW
  LES DI,LastX
  XCHG AX,CX
  STOSW
  LES DI,LastY
  XCHG AX,DX
  STOSW
  XCHG AX,BX
@End:
 {$ENDIF}
END;

{ 旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
  �                         Proc괺ure SetMouseMoveArea                   �
  잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


  Description
  袴袴袴袴袴�

   Cette proc괺ure permet de d괽init les limites horizontal et vertical du
  pointeur de la souris.
}

Procedure SetMouseMoveArea(X1,Y1,X2,Y2:Word);Assembler;ASM
 CALL MouseDriverFound
 JNC @End
 MOV AX,8
 MOV CX,Y1
 MOV DX,Y2
 INT 033h
 MOV AX,7
 MOV CX,X1
 MOV DX,X2
 INT 033h
@End:
END;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                       Proc괺ure SetMouseMoveAreaX                    �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Description
 袴袴袴袴袴�

  Cette proc괺ure  sert � fixer  l'intervale horizontal du d굋lacement du
 pointeur de la souris et naturellement des valeurs pouvant 늯re retourn�.
}

Procedure SetMouseMoveAreaX(X1,X2:Word);Assembler;ASM
 CALL MouseDriverFound
 JNC @End
 MOV AX,7
 MOV CX,X1
 MOV DX,X2
 INT 033h
@End:
END;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                     Proc괺ure SetMouseMoveAreaY                  �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Description
 袴袴袴袴袴�

  Cette proc괺ure sert � fixer l'intervale vertical du d굋lacement du
 pointeur  de la souris  et  naturellement  des valeurs  pouvant 늯re
 retourn�.
}

Procedure SetMouseMoveAreaY(Y1,Y2:Word);Assembler;ASM
 CALL MouseDriverFound
 JNC @End
 MOV AX,8
 MOV CX,Y1
 MOV DX,Y2
 INT 033h
@End:
END;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                         Proc괺ure SetGraphPointer                    �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Portabilit�: Globale


 Description
 袴袴袴袴袴�

  Cette proc괺ure permet de d괽init le style de pointeur graphique devant
 늯re utilis� par le pilote souris en mode graphique.
}

Procedure SetGraphPointer(HotX,HotY:Word;Var Image);Assembler;ASM
 {$IFDEF FLAT386}
 {$ELSE}
  CALL MouseDriverFound
  JNC @End
  MOV AX,9
  MOV BX,HotX
  MOV CX,HotY
  LES DX,Image
  INT 33h
@End:
 {$ENDIF}
END;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                      Proc괺ure SetTextPointer                    �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Portabilit�: Globale


 Description
 袴袴袴袴袴�

  Cette proc괺ure permet de d괽init le style de pointeur texte devant
 늯re utilis� par le pilote souris en mode texte.
}

Procedure SetTextPointer(Select:Word;ScreenChar:Char;ScreenAttr:Byte;
                         PointerChar:Char;PointerAttr:Byte);Assembler;ASM
 CALL MouseDriverFound
 JNC @End
 MOV AX,0Ah
 MOV BX,Select
 MOV CL,ScreenChar
 MOV CH,ScreenAttr
 MOV DL,PointerChar
 MOV DH,PointerAttr
 INT 33h
@End:
END;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                       Proc괺ure ReadMotion                     �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Portabilit�: Globale


 Description
 袴袴袴袴袴�

  Cette proc괺ure permet de conna똳re le compteur de d굋lacement du
 pointeur de souris depuis le dernier appel.
}

Procedure ReadMotion(Var hCount,vCount:Word);Assembler;ASM
 {$IFDEF FLAT386}
 {$ELSE}
  CALL MouseDriverFound
  JNC @End
  MOV AX,0Bh
  INT 33h
  LES DI,hCount
  XCHG AX,CX
  STOSW
  LES DI,vCount
  XCHG AX,DX
  STOSW
@End:
 {$ENDIF}
END;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                        Proc괺ure InstallMouseSub                    �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Description
 袴袴袴袴袴�

  Cette proc괺ure permet d'installer un gestionnaire d'굒굈ement lorsque
 la souris a un comportement quelconque.  Un drapeau permet de sp괹ifier
 le type de comportement � surveiller. Toutefois, plusieurs gestionnaire
 ne sont pas n괹essairement supporter par tous les pilotes de souris.
}

Procedure InstallMouseSub(Flags:Word;Addr:Pointer);Assembler;ASM
 {$IFDEF FLAT386}
 {$ELSE}
  CALL MouseDriverFound
  JNC @End
  MOV AX,0Ch
  MOV CX,Flags
  LES DX,Addr
  INT 033h
@End:
 {$ENDIF}
END;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                          Proc괺ure LightPenOn                       �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Portabilit�: Globale


 Description
 袴袴袴袴袴�

  Cette proc괺ure active l'굆ulation crayon lumineux par le pilote de la
 souris.
}

Procedure LightPenOn;Assembler;ASM
 CALL MouseDriverFound
 JNC @End
 MOV AX,0Dh
 INT 33h
@End:
END;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                         Proc괺ure LightPenOff                       �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Portabilit�: Globale


 Description
 袴袴袴袴袴�

  Cette proc괺ure d굎active l'굆ulation crayon lumineux par le pilote de
 la souris.
}

Procedure LightPenOff;Assembler;ASM
 CALL MouseDriverFound
 JNC @End
 MOV AX,0Eh
 INT 33h
@End:
END;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                            Fonction GetMouseButton                     �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Description
 袴袴袴袴袴�

  Cette fonction permet de conna똳re l'굏at actuel des boutons de la souris
 en utilisant le pilote d'interruption 33h.

 Remarque
 袴袴袴袴

  � Voici cette fonction en Pascal traditionnel:
    旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
    � Function GetMouseButton:Byte;Var X,Y,B:Wd;Begin                     �
    �  GetMouseSwitch(X,Y,B);                                             �
    �  GetMouseButton:=B;                                                 �
    � End;                                                                �
    읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
}

Function GetMouseButton:Byte;Assembler;ASM
 CALL AsmGetMouseSwitch
 XCHG AX,BX
End;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                          Proc괺ure SetMouse                        �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Description
 袴袴袴袴袴�

  Cette proc괺ure permet de d굎activer la pr굎ence de la souris dans le
 syst둴e advenant une incompatibilit� du pilote.
}

Procedure SetMouse;Begin
 If Not(Use)Then {$IFDEF Adele}Adele{$ELSE}Chantal{$ENDIF}.Mouse:=0;
End;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                       Proc괺ure SetMousePos                        �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Description
 袴袴袴袴袴�

  Cette proc괺ure fixe la nouvelle position du pointeur de souris. Sans
 oublier  d'affecter  toutes  les donn괻s  correspondent  pour en tenir
 compte.
}

Procedure SetMousePos;
Var
 Show:Boolean;
Begin
 ASM
  PUSHF
   CLI
   MOV CX,X
   MOV Word Ptr XMov,CX
   MOV DX,Y
   MOV Word Ptr YMov,DX
  POPF
  CMP Adele.Mouse,msPS2
  JE  @NoInt
  MOV AX,4
  INT 033h
@NoInt:
  PUSHF
   CLI
   MOV AL,ShowMouse
   MOV Show,AL
  POPF
 END;
 If(Show)Then __HideMousePtr;
 ASM
  PUSHF
   CLI
   MOV AX,X
   MOV Word Ptr MouseOldX,AX
   MOV AX,Y
   MOV Word Ptr MouseOldY,AX
  POPF
 END;
 If(Show)Then __ShowMousePtr;
End;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                        Fonction __GetMouseButton                    �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Portabilit�: Globale
 Multi-t긟he: Support�


 Description
 袴袴袴袴袴�

  Cette fonction demande l'굏at des boutons de la souris sans passer par
 l'interruption 33h si possible.


 Remarque
 袴袴袴袴

  � Voici le contenu de cette fonction en Pascal traditionnel:
    旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
    � Begin                                                            �
    �  CLI;                                                            �
    �  _GetMouseButton:=Button;                                        �
    �  STI;                                                            �
    � End;                                                             �
    읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
}

Function __GetMouseButton:Byte;Assembler;ASM
 PUSHF
  CLI
  MOV AL,Byte Ptr Button
 POPF
END;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                     Proc괺ure __GetMouseTextSwitch               �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Portabilit�: Globale
 Multi-t긟he: Support�


 Description
 袴袴袴袴袴�

  Cette fonction retourne les coordonn괻s actuel en texte du pointeur
 de la souris ainsi que l'굏at des boutons de la souris.


 Remarque
 袴袴袴袴

  � Voici le contenu de cette fonction en Pascal traditionnel:
    旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
    � X:=MouseOldTextX;Y:=MouseOldTextY;B:=Button;                  �
    � LastMouseX:=X;LastMouseY:=Y;LastMouseB:=B;                    �
    읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
}

Procedure __GetMouseTextSwitch;Assembler;ASM
 {$IFDEF FLAT386}
 {$ELSE}
  CLD
  PUSHF
   CLI
   MOV AL,MouseOldTextY
   LES DI,Y
   STOSB
   MOV CH,AL
   MOV AL,MouseOldTextX
   LES DI,X
   STOSB
   MOV CL,AL
   MOV AX,Button
   LES DI,B
   STOSW
   OR  AL,AL
   JZ  @NoUpdate
   MOV LastMouseB,AL
 @NoUpdate:
  POPF
  MOV Word Ptr LastMouseX,CX
 {$ENDIF}
END;

Procedure __GetMouseTextSwitchZ;
Var
 Q:TextCharRec Absolute Z;
Begin
 __GetMouseTextSwitch(Q.X,Q.Y,B);
End;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                      Fonction __GetMouseXPixels                 �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Portabilit�: Globale
 Multi-t긟he: Support�


 Description
 袴袴袴袴袴�

  Cette fonction retourne la derni둹e coordonn괻 horizontal en pixel
 m굆oris� de la position du pointeur de la souris.
}

Function __GetMouseXPixels;Assembler;ASM
 {$IFDEF FLAT386}
 {$ELSE}
  PUSHF
   CLI
   MOV AX,MouseOldX
  POPF
 {$ENDIF}
END;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                           Fonction __GetMouseYPixels                   �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Portabilit�: Globale
 Multi-t긟he: Support�


 Description
 袴袴袴袴袴�

  Cette fonction retourne la derni둹e coordonn괻 vertical en pixel m굆oris�
 de la position du pointeur de la souris.
}

Function __GetMouseYPixels;Assembler;ASM
 {$IFDEF FLAT386}
 {$ELSE}
  PUSHF
   CLI
   MOV AX,MouseOldY
  POPF
 {$ENDIF}
END;

Function IsShowMouse:Boolean;Assembler;ASM
 PUSHF
  CLI
  MOV AL,ShowMouse
 POPF
END;

Function IsMouseMove:Boolean;Assembler;ASM
 PUSHF
  CLI
  MOV AL,UserMove
  MOV UserMove,0
 POPF
END;

Procedure SetMouseMove(Value:Boolean);Assembler;ASM
 PUSHF
  CLI
  MOV AL,Value
  MOV UserMove,AL
 POPF
END;

Procedure DisposeMousePtr;Begin
 ExternPtrMouse:=NIL;
End;

{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}
END.