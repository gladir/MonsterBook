

{

 *****************************************************************************
 ***                   MICRO APPLICATION PC INTERDIT                       ***
 ***                  ================================                     ***
 ***                                                                       ***
 ***                           Unit MOD_SB                                 ***
 ***                                                                       ***
 ***  Cette unit‚ est facilement int‚grable dans les programmes. Elle      ***
 ***  peut ˆtre mise en oeuvre par l'interm‚diaire de l'interruption du    ***
 ***  timer. Elle contient de plus une routine permettant d'ex‚cuter       ***
 ***  les fichiers VOC.                                                    ***
 ***  Pour une qualit‚ d'‚mission de 22KHz lors de la sortie d'un fichier  ***
 ***  MOD … 8 voix sur un 486 DX 33,  elle exige moins de 15% du temps de  ***
 ***  calcul.                                                              ***
 ***                                                                       ***
 *** Auteur          : Boris Bertelsons  (InspirE)                         ***
 *** Nom du fichier  : MOD_SB.PAS                                          ***
 *** Date            : 04.04.1994                                          ***
 *** Version         : 2.0                                                 ***
 *** Compilateur     : Turbo Pascal 6.0 et sup‚rieur                       ***
 *****************************************************************************

}

{$F+,G+}
unit modsb;

interface uses crt,dos,variab;

 var andycount : word;

procedure wr_dsp_sb16(v : byte);
{
Par l'interm‚diaire de cette proc‚dure, vous pouvez sortir un
octet sur le port de commandes de la carte Sound Blaster.
}

Function SbReadByte : Byte;
{
Cette fonction permet de lire un octet de donn‚es sur la 
carte Sound Blaster.
}

Function Reset_Sb16 : boolean;
{
Par l'interm‚diaire de cette fonction, vous pouvez r‚aliser 
un reset de la carte Sound Blaster. Quand le reset a ‚t‚ effectu‚, 
la carte renvoie la valeur TRUE, sinon la valeur FALSE. La
fonction permet d'obtenir l'adresse de base de la carte.
}

Function Detect_reg_Sb16 : boolean;
{
L'obtention de l'adresse de base dont il a ‚t‚ question ci-dessus
est men‚e … bien par cette fonction. Elle donne … la variable 
dsp_adr l'adresse de base de la carte Sound Blaster. Elle renvoie
TRUE quand une adresse de base a ‚t‚ trouv‚e, sinon FALSE.
}

Procedure Write_Mixer(Reg,Val : Byte);
{
Cette proc‚dure ‚crit la valeur transmise … "Val" dans le
registre de mixage "Reg". La proc‚dure ne fonctionne qu'…
partir de SB Pro.
}

Function Read_Mixer(Reg : Byte) : byte;
{
Au moyen de cette fonction, vous pouvez lire une valeur
dans le registre de mixage indiqu‚ dans "Reg".
}

Procedure Filtre_on;
{
Cette proc‚dure d‚sactive la mise en valeur des basses …
partir de la carte SB Pro.
}

Procedure Filtre_Mid;
{
Pour obtenir une sonorit‚ normale sur les cartes … partir
de SB Pro, vous pouvez utiliser cette proc‚dure.
}

Procedure Filtre_out;
{
En appelant cette proc‚dure, vous faites mieux entendre 
les sons aigus.
}

Procedure Set_Balance(Valeur : byte);
{
Au moyen de cette proc‚dure, vous pouvez r‚gler la balance
du son sur les cartes st‚r‚o. "Valeur" peut prendre des
valeurs comprises entre 0 (tout … gauche) et 15 (tout … droite). 
}

Procedure Set_Volume(Valeur : byte);
{
Vous r‚glez au moyen de cette proc‚dure le volume avec lequel
le fichier MOD sera ex‚cut‚. A partir de la carte SB Pro, le 
volume est r‚gl‚ mat‚riellement au moyen du mixer. Sur la 
carte SB habituelle, la r‚gulation se fait par des moyens
logiciels, … l'aide de la variable "outvolume"
}

Procedure Reset_Mixer;
{
Exactement comme pour le DSP, il faut restaurer les valeurs 
par d‚faut dans le mixer de la carte SB au moyen d'un reset.
Le registre 0 de reset du mixer doit recevoir pour cela la
valeur 0. La proc‚dure s'en charge … votre place.
}

Function Detect_Mixer_Sb16 : boolean;
{
Cette fonction sert … reconnaŒtre la puce mixer. Elle renvoie
la valeur TRUE quand une puce mixer a ‚t‚ trouv‚e et FALSE
dans le cas contraire. Elle est trŠs importante car elle
intervient pour distinguer les cartes SB. Lorsque la fonction
renvoie la valeur TRUE, cela veut dire que votre appareil est
‚quip‚ d'une carte SB Pro.
}

Procedure SbGetDSPVersion;
{
Pour distinguer entre SB Pro et SB16, vous avez besoin de
connaŒtre le num‚ro de version de la carte. S'il est inf‚rieur
… 4, vous avez une SB Pro. Sinon, c'est une SB 16.
}

Procedure Set_Timeconst_sb16(tc : byte);
{
Pour d‚finir la constante timer de la Sound Blaster, vous
avez besoin de cette fonction. La constante se calcule …
l'aide de la formule

tc:=256-(1.000.000/Fr‚quence du sample).

La constante que l'on obtient ainsi doit ˆtre transmise au
moyen de la commande $40. Vous transmettrez … la proc‚dure
la constante calcul‚e.
}

Procedure Exit_Sb16;
{
Pour mettre fin au programme, il faut faire appel … cette
proc‚dure. Elle ramŠne l'interruption cach‚e SB … sa valeur
pr‚c‚dente et elle restaure le masque initial de l'interruption.
}

Procedure dsp_block_sb16(gr,dgr : word; bk : pointer; b1,b2 : boolean);
{
Cette fonction est destin‚e … vous faciliter la tƒche quand
il s'agit de sortir un bloc via DMA. Elle sort un bloc de la
taille "gr" adress‚ par le pointeur "bk" via le DMA. Il se
peut que vous vouliez sortir un sample ou que vous ayez au
contraire besoin
}

procedure mod_SetSpeed(msp : word);
procedure mod_Samplefreq(Rate : integer);
Procedure Calculate_music;
procedure mod_SetLoop(msl : word);
procedure voc_pause;
function charge_fichiermod(modnom : string;ispeed,iloop : integer;freq : byte) : integer;
function init_The_Mod : boolean;
procedure voc_done;
procedure write_sbConfig;
procedure Init_Voc(filename : string);
Procedure periodic_off;
Procedure Fin_mod;
Procedure periodic_on;
procedure voc_continue;
function Init_Sb : boolean;

const bpm : byte = 125;

var SaveExitProc : Pointer;
 mycli : byte;
 music_played : boolean;

implementation

const
 Speed3 : word = 58;
 Loop3  : word = 42;

Var
 Tonhauteur_voix : array[1..8] of word;
 ton_haut : word;                       { Valeur qui se trouve dans  }
					{ dans le fichier MOD        }
 cible : pt;
 Modp  : pointer;                       { Pointeur sur Rm_Song        }
 note : array[1..8] of byte;
 altx,alty : integer;
 voix_actuelle : word;

 Mixed_data   : pointer;
 Mixed_data_st : pointer;

{$L modmix}
procedure Voix_vide; external;
procedure voix_normale; external;
procedure voix_normale_st; external;

var Portamento_Up_voix : array[1..8] of longint;
    Portamento_Do_voix : array[1..8] of longint;

var Mixingproc_voix     :  array[1..8] of pointer;
    voixvide            : pointer;

    effet_voix        : array[1..8] of byte;

    longueur_voix       : array[1..8] of longint;
    loop_longueur_voix  : array[1..8] of longint;
    Position_voix       : array[1..8] of longint;
    loop_start_voix     : array[1..8] of longint;
    Segment_voix        : array[1..8] of longint;
    Notvol_voix         : array[1..8] of longint;
    Incval_voix         : array[1..8] of longint;

var perfcount : word;

    var bsw : boolean;
      vocb1,
      vocb2,
      buffer1,
      buffer2 : pointer;
    shiftfacteur,
    shiftfacteur_stereo : word;

{

 **************************************************************************
 ***                                                                    ***
 ***                Routine du Timer - Handling                         ***
 ***                                                                    ***
 **************************************************************************

}
procedure RegleTimer(Proc:pointer;Freq:word);var icompteur:word;oldv:pointer;begin
 asm cli end;
 icompteur := 1193180 DIV Freq;
 Port[$43] := $36;
 Port[$40] := Lo(Icompteur);
 Port[$40] := Hi(Icompteur);
 Getintvec(8,OldV);
 setintvec(OldTimerInt,OldV);
 SetIntVec(8,Proc);
 old_tCompteur := 1;
 seccompteur  := 0;
 Oldintcompteur := 0;
 asm sti end;
end;

procedure RestaureTimer;var oldv:pointer;begin;
  asm cli end;
  port[$43] := $36;
  Port[$40] := 0;
  Port[$40] := 0;
  GetIntVec(OldTimerInt,OldV);
  SetIntVec(8,OldV);
  asm sti end;
end;

Procedure NouveauTimer;Interrupt;{Var dr:registers;}Begin
 {if not InRetrace then} calculate_Music;
 Inc(perfcount);Inc(Seccompteur);Inc(oldintcompteur);
 If oldintcompteur=58Then Begin;
  oldintcompteur:=0;
{  intr(Oldtimerint,dr);}
  ASM INT OldTimerInt;END;
 End;
 If(Seccompteur=timer_per_second)Then Begin;
  Seccompteur:=0;Inc(andycount);Inc(secpass);
  If secpass=60Then Begin;Inc(minpass);secpass:=0;End;
 End;
 {if not InRetrace then} calculate_Music;
 Port[$20] := $20;
End;

{
 **************************************************************************
 ***                                                                    ***
 ***            Routine de programmation des cartes Soundblasters       ***
 ***                                                                    ***
 **************************************************************************

}

procedure wr_dsp_sb16(v:byte);begin;
  while port[dsp_adr+$c] >= 128 do ;
  port[dsp_adr+$c] := v;
end;

FUNCTION SbReadByte : BYTE;
{
 La fonction attend, jusqu'… ce que la DSP puisse ˆtre lue et
 retourne alors la valeur lue.
}
begin;
  while port[dsp_adr+$a] = $AA do ;     { attend que DSP soit prˆte }
  SbReadByte := port[dsp_adr+$a];       { lit une valeur }
end;

procedure SBreset;VAR bt,ct,stat:BYTE;begin;
  PORT[dsp_adr+$6] := 1;
  FOR ct := 1 TO 100 DO;
  PORT[dsp_adr+$6]:=0;
  bt:=0;
  repeat
    ct := 0;
    Repeat stat:=port[dsp_adr+$E]Until(ct>8000)or(stat>=128);
    inc(bt);
  until (bt > 100) or (port[dsp_adr + $A] = $AA);
end;

FUNCTION Reset_SB16 : BOOLEAN;
{
 La fonction effectue un reset du DSP. Si le reset r‚ussit,
 elle retourne TRUE, sinon FALSE
}
CONST  ready = $AA;
VAR ct, stat : BYTE;
BEGIN
  PORT[dsp_adr+$6] := 1;                { dsp_adr+$6 = fonction de reset }
  FOR ct := 1 TO 100 DO;
  PORT[dsp_adr+$6] := 0;
  stat := 0;
  ct   := 0;                            { Comparaison  ct < 100, car }
  WHILE (stat <> ready)                 { l'initialisation dure    }
  AND   (ct < 100)      DO BEGIN        { environ 100ms             }
    stat := PORT[dsp_adr+$E];
    stat := PORT[dsp_adr+$a];
    INC(ct);
  END;
  Reset_SB16 := (stat = ready);
END;

Function Detect_reg_SB16:BOOLEAN;
{
 La fonction retourne TRUE, quand une carte Soundblaster a pu  ˆtre
 initialis‚e, sinon FALSE. La variable dsp_adr re‡oit
 l'adresse de base de la SB.
}
Var Port,Lst:Word;Begin
 Detect_Reg_SB16:=SbRegDetected;
 If(SbRegDetected)Then EXIT;            { Exit, lorsque l'initialisation est faite }
 Port:=Startport;                     { Adresse SB possibles }
 Lst:=Endport;                       { entre $210 et $280 !      }
 While(Not SbRegDetected)and(Port<=Lst)do Begin
  dsp_adr := Port;
  SbRegDetected := Reset_SB16;
  If Not(SbRegDetected)Then Inc(Port,$10);
 End;
 Detect_reg_SB16:=SbRegDetected;
END;

Procedure Write_Mixer(Reg,Val:Byte);Assembler;ASM
 {Port[dsp_adr+$4]:=Reg;Port[dsp_adr+$5]:=Val;}
 MOV AL,Reg
 MOV AH,Val
 MOV DX,dsp_adr+4
 OUT DX,AX
END;

FUNCTION Read_Mixer(Reg:Byte):Byte;begin;
 Port[dsp_adr+$4]:=Reg;Read_Mixer:=Port[dsp_adr+$5];
end;

procedure Filtre_on;
{
Cette proc‚dure d‚sactive la mise en valeur des basses …
partir de la carte SB Pro.
}
var Aide : byte;
begin;
 if sb16detected then begin;
   write_Mixer(68,64);
   write_Mixer(69,64);
   write_Mixer(70,255);
   write_Mixer(71,255);
 end else begin;
   Aide := read_Mixer($0c);
   Aide := Aide or 8;
   Write_Mixer($0c,Aide);
   Aide := read_Mixer($0e);
   Aide := Aide AND 2;
   write_Mixer($0e,Aide);
 end;
end;

procedure Filtre_MID;
{
Pour obtenir une sonorit‚ normale sur les cartes … partir
de SB Pro, vous pouvez utiliser cette proc‚dure.
}
var Aide : byte;
begin;
 if sb16detected then begin;
   write_Mixer(68,160);
   write_Mixer(69,160);
   write_Mixer(70,192);
   write_Mixer(71,192);
 end else begin;
   Aide := read_Mixer($0e);
   Aide := Aide OR 32;
   write_Mixer($0e,Aide);
 end;
end;

procedure Filtre_out;
{
En appelant cette proc‚dure, vous faites mieux entendre
les sons aigus.
}

var Aide : byte;
begin;
 if sb16detected then begin;
   write_Mixer(68,192);
   write_Mixer(69,192);
   write_Mixer(70,160);
   write_Mixer(71,160);
 end else begin;
   Aide := read_Mixer($0c);
   Aide := Aide OR 247;
   Write_Mixer($0c,Aide);
   Aide := read_Mixer($0e);
   Aide := Aide AND 2;
   write_Mixer($0e,Aide);
 end;
end;

procedure Set_Balance(Valeur:byte);Var left,right:byte;begin;
 if Sb16Detected then begin;
   left  := 12;
   right := 12;
   if Valeur < 12 then right := Valeur;
   if Valeur > 12 then left  := 24-Valeur;
   write_Mixer(50,(left  shl 4));
   write_Mixer(51,(right shl 4));
 end else begin;
  Valeur := Valeur SHR 1;
  case Valeur of
   0..6 : write_Mixer(02,(7 shl 5)+(Valeur shl 1));
     07 : write_Mixer(02,(7 shl 5)+(7 shl 1));
 08..13 : write_Mixer(02,((13-Valeur) shl 5)+(7 shl 1));
  end;
 end;
end;

procedure Set_Volume(Valeur:byte);begin
  if sb16detected then begin;
    write_Mixer(48,(Valeur shl 3));
    write_Mixer(49,(Valeur shl 3));
  end else begin;
    if MixerDetected then begin;
      Valeur := Valeur Shr 2;
      write_Mixer($22,(Valeur shl 5) + (Valeur shl 1));
    end else begin;
      outvolume := Valeur shl 1;
    end;
  end;
end;

procedure reset_Mixer;assembler;asm
  mov dx,dsp_adr+$4
  mov al,0
  out dx,al
  mov cx,50
@loop:
  loop @loop
  inc dx
  out dx,al
end;

FUNCTION Detect_Mixer_sb16:Boolean;Var SaveReg,NewReg:Word;Begin
  Detect_Mixer_sb16 := MixerDetected;
  IF (NOT SbRegDetected)
  OR MixerDetected THEN EXIT;
  Reset_Mixer;
  SaveReg := Read_Mixer($22);
  Write_Mixer($22, 243);
  NewReg  := Read_Mixer($22);
  IF NewReg = 243 THEN begin;MixerDetected:=TRUE;STEREO:=True;end;
  Write_Mixer($22, SaveReg);
  Detect_Mixer_sb16 := MixerDetected;
END;

PROCEDURE SbGetDSPVersion;
{
 Fournit le num‚ro de version de la DSP et le d‚pose dans les variables
 globales SBVERSMAJ et SBVERSMIN, ainsi que SBVERSSTR.
}
Var i,t:WORD;s:STRING[2];
Begin
  Wr_dsp_sb16($E1);                  { $E1 = interroge le num‚ro de version }
  SbVersMaj := SbReadByte;
  SbVersMin := SbReadByte;
  str(SbVersMaj, SbVersStr);
  SbVersStr := SbVersStr + '.';
  str(SbVersMin, s);
  if SbVersMin > 9 then
    SbVersStr := SbVersStr +       s
  else
    SbVersStr := SbVersStr + '0' + s;
END;


function wrt_dsp_adr_sb16:string;begin;
  case dsp_adr of
    $210 : wrt_dsp_adr_sb16 := '210';
    $220 : wrt_dsp_adr_sb16 := '220';
    $230 : wrt_dsp_adr_sb16 := '230';
    $240 : wrt_dsp_adr_sb16 := '240';
    $250 : wrt_dsp_adr_sb16 := '250';
    $260 : wrt_dsp_adr_sb16 := '260';
    $270 : wrt_dsp_adr_sb16 := '270';
    $270 : wrt_dsp_adr_sb16 := '280';
   END;
end;

function wrt_dsp_irq:string;begin;
  case dsp_irq of
     $2 : wrt_dsp_irq := '2 h';
     $3 : wrt_dsp_irq := '3 h';
     $5 : wrt_dsp_irq := '5 h';
     $7 : wrt_dsp_irq := '7 h';
    $10 : wrt_dsp_irq := '10 h';
   END;
end;

procedure Set_Timeconst_sb16(tc:byte);begin;
  wr_dsp_sb16($40);
  wr_dsp_sb16(tc);
end;

procedure test_transmission;begin;
   fillchar(buffer1^,3000,127);
   Taillebloc := 2000;
   dern_sortie := true;
   Sampling_Rate := 211;
   dsp_block_sb16(Taillebloc,Taillebloc,buffer1,true,false);
   delay(100);
end;

procedure write_sbConfig;begin;
  clrscr;
  if(SbRegDetected)then begin;
    writeln('Carte son … l''adresse ',wrt_dsp_adr_sb16,'h avec une IRQ ',wrt_dsp_irq);
  end else begin;
    writeln('Aucune carte son compatible Sound Blaster trouv‚ !');
  end;
  if MixerDetected then begin;
    writeln('Mixer - Chip trouv‚');
    if SbVersMaj < 4 then
      writeln('La carte d‚tect‚e est une Sound Blaster Pro ou compatible')
    else
      writeln('La carte d‚t‚ct‚e est',
      ' une Sound Blaster 16 ASP ou compatible');
  end else begin;
    writeln('La carte d‚tect‚e est une Sound Blaster ou compatible');
  end;
  writeln('Num‚ro de version : ',SbVersStr);
end;

procedure Exit_Sb16;begin;
  setintvec($8+dsp_irq,oldint);
  port[$21] := Port[$21] or irqmsq;
  port[dsp_adr+$c] := $d3;
  Port[$20] := $20;
  wr_dsp_sb16($D0);
end;

procedure Jouer_Sb16(Segm,Offs,dgr,dsize:word);var li:word;begin;
  port[$0A] := dma_ch+4;
  Port[$0c] := 0;
  Port[$0B] := $48+dma_ch;
  Port[dma_adr[dma_ch]] := Lo(offs);
  Port[dma_adr[dma_ch]] := Hi(offs);
  Port[dma_wc[dma_ch]] := Lo(dgr-1);
  Port[dma_wc[dma_ch]] := Hi(dgr-1);
  Port[dma_page[dma_ch]] := Segm;
  if sb16_outputlong <> dsize then begin;
    wr_dsp_sb16($C6);
    if(stereo)then wr_dsp_sb16($20)else wr_dsp_sb16($00);
    wr_dsp_sb16(Lo(dsize-1));
    wr_dsp_sb16(Hi(dsize-1));
    sb16_outputlong := dsize;
  end else begin;
    wr_dsp_sb16($45);
  end;
  Port[$0A] := dma_ch;
end;

procedure Jouer_Sb(Segm,Offs,dgr,dsize : word);
{
 Cette proc‚dure ex‚cute le bloc adress‚ par Segm:Offs
 de taille dsize. Il faut noter que le contr“leur DMA ne peut PAS
 travailler en acc‚dant aux pages...
}
var li:word;begin;
  port[$0A] := dma_ch+4;                { Bloque le canal DMA }
  Port[$0c] := 0;                       { Adresse du tampon (blk)  }
  Port[$0B] := $48+dma_ch;              { Pour la sortie du son }
  Port[dma_adr[dma_ch]] := Lo(offs);    { au DMA-Controller }
  Port[dma_adr[dma_ch]] := Hi(offs);
  Port[dma_wc[dma_ch]] := Lo(dgr-1);  { Taille du bloc }
  Port[dma_wc[dma_ch]] := Hi(dgr-1);  { au DMA-Controller }
  Port[dma_page[dma_ch]] := Segm;
  Wr_dsp_sb16($14);
  Wr_dsp_sb16(Lo(dsize-1));                  { Taille du bloc }
  Wr_dsp_sb16(Hi(dsize-1));                  { … la DSP }
  Port[$0A] := dma_ch;                  { LibŠre le canal DMA }
end;

procedure Jouer_SbPro(Segm,Offs,dgr,dsize:word);var li:word;begin;
  port[$0A] := dma_ch+4;
  Port[$0c] := 0;
  Port[$0B] := $48+dma_ch;
  Port[dma_adr[dma_ch]] := Lo(offs);
  Port[dma_adr[dma_ch]] := Hi(offs);
  Port[dma_wc[dma_ch]] := Lo(dgr-1);
  Port[dma_wc[dma_ch]] := Hi(dgr-1);
  Port[dma_page[dma_ch]] := Segm;
  wr_dsp_sb16($48);
  wr_dsp_sb16(Lo(dsize-1));
  wr_dsp_sb16(Hi(dsize-1));
  wr_dsp_sb16($91);
  Port[$0A] := dma_ch;
end;

procedure dsp_block_sb16(gr,dgr:word;bk:pointer;b1,b2:boolean);
var l:longint;pn,offs:word;hbyte:byte;a:word;OldV,NewV,Aide:byte;
stereoreg:byte;sr:word;samps:byte;begin;
  PLAYING_MOD:=b1;PLAYING_VOC:=b2;dsp_rdy_sb16:=false;
  l:=16*longint(pt(bk).sgm)+pt(bk).ofs;pn:=pt(l).sgm;offs:=pt(l).ofs;
  if(PLAYING_MOD)then begin;
    set_timeconst_sb16(Sampling_Rate);
    if sb16Detected then begin;
     if(stereo)then Jouer_Sb16(pn,offs,dgr shl 1,gr shl 1)else Jouer_Sb16(pn,offs,dgr,gr);
    end else begin;
      if stereo then begin;
	SR:=Word(-1000000 div(Sampling_Rate-256));
	ASM SHL SR,1;END;
	Samps:=256-(1000000 div SR);
	set_timeconst_sb16(Samps);
	Jouer_SbPro(pn,offs,dgr shl 1,gr shl 1);
      end else
	Jouer_Sb(pn,offs,dgr,gr);
    end;
  end;
  if(PLAYING_VOC)then begin;
    sb16_outputlong:=0;
    set_timeconst_sb16(vblock.SR);
    if(sb16Detected)then begin;
     if(stereo)then Jouer_Sb16(pn,offs,dgr,gr)else Jouer_Sb16(pn,offs,dgr,gr);
    end else begin;
     if(stereo)then Jouer_SbPro(pn,offs,dgr,gr)else Jouer_Sb(pn,offs,dgr,gr);
    end;
  end;
end;

{
***********************************************************************
***                                                                 ***
***                   Routines pour fichiers MOD                    ***
***                                                                 ***
***********************************************************************
}

{Description
 ÍÍÍÍÍÍÍÍÍÍÍ
  La proc‚dure fournit … partir de la hauteur de son transmise (telle qu'elle
 figure dans le fichier MOD) la valeur entiŠre et les d‚cimales n‚cessaires
 pour la manipulation de la fr‚quence.
}

procedure get_pctunel(hauteur:word;Var vk:longint);var nct:byte;trouve:boolean;begin;
 nct:=1;trouve:=false;
 while(nct<=70)and not(trouve)do Begin { jusqu'… aboutissement ou une valeur dans le tableau }
  if hauteur>Modoctave[nct]then trouve:=true;
  inc(nct);
 end;
 if(trouve)then vk:=Incfacts[nct-tpw+12]
 else vk:=0; { Va chercher des valeurs dans le tableau. }
end;

function Notes_Nr(hauteur:word):integer;var nct:byte;trouve:boolean;begin;
 nct:=1;trouve:=false;
 while(nct<=70)and not(trouve)do   { Jusqu'… aboutissement }
 begin;                            { ou derniŠre valeur dans le tableau }
  if hauteur>Modoctave[nct]then trouve:=true;
  inc(nct);
 end;
 if(trouve)then Notes_nr:=nct-1 else Notes_nr:=-1;
end;

function Volume_notes(Stm:byte):byte;begin;Volume_notes:=Rm_Song[mli,Stm,4];End;

var mixed_posi,calc_size:word;

procedure intra_boucle_4;
{
 On r‚alise ici le mixage des donn‚es. Le tampon
 est rempli avec les donn‚es calcul‚es. C'est la
 version MONO de la routine.
}
begin;
 calc_size:=taillebloc;
 if(bsw)then cible:=pt(buffer1)else cible:=pt(buffer2);

asm  {  fillchar(mixed_data^,8000,128);}
  LES DI,Mixed_data
  CLD
  MOV CX,8000 shr 1
  MOV AX,$8080
  REP STOSW

    mov cx,1
@voix_loop:
    mov mixed_posi,0
    mov voix_actuelle,cx
    mov si,cx
    dec si
    shl si,2
    call dword ptr Mixingproc_voix[si]

    inc cx
    cmp cx,voix
    jbe @voix_loop

    mov mixed_posi,0
    mov cx,calc_size
@Mixed_2_blk:
    les di,mixed_data
    add di,mixed_posi
    mov ax,es:[di]
    push cx
    mov cx,shiftfacteur
    shr ax,cl
    pop cx
    add mixed_posi,2

    mov bx,cible.sgm   { Ecrit les octets dans la cible }
    mov es,bx
    mov bx,cible.ofs
    mul outvolume
    shr ax,6
    mov es:[bx],al
    inc cible.ofs

    loop @mixed_2_blk
end;
end;

procedure intra_boucle_4_stereo;
{
 On r‚alise ici le mixage des donn‚es. Le tampon
 est rempli par les donn‚es calcul‚es. C'est la
 version st‚r‚o de la routine.
}
begin;
  calc_size := taillebloc;
  if bsw then
    cible := pt(buffer1)
  else
    cible := pt(buffer2);
 ASM {fillchar(mixed_data^,8000,128);}
  LES DI,Mixed_data
  CLD
  MOV CX,8000 shr 1
  MOV AX,$8080
  REP STOSW
   {fillchar(mixed_data_st^,8000,128);}
  LES DI,Mixed_data_st
  CLD
  MOV CX,8000 shr 1
  MOV AX,$8080
  REP STOSW
    mov cx,1
@voix_loop:
    mov mixed_posi,0
    mov voix_actuelle,cx
    mov si,cx
    dec si
    shl si,2
    call dword ptr Mixingproc_voix[si]

    inc cx
    cmp cx,voix
    jbe @voix_loop

    mov mixed_posi,0
    mov cx,calc_size
@Mixed_2_blk:
    les di,mixed_data
    add di,mixed_posi
    mov ax,es:[di]
    push cx
    mov cx,shiftfacteur_stereo
    shr ax,cl
    pop cx

    mov bx,cible.sgm     { Ecrit les octets dans la cible }
    mov es,bx
    mov bx,cible.ofs
    mul outvolume
    shr ax,6
    mov es:[bx],al
    inc cible.ofs

    les di,mixed_data_st
    add di,mixed_posi
    mov ax,es:[di]
    push cx
    mov cx,shiftfacteur_stereo
    shr ax,cl
    pop cx
    add mixed_posi,2

    mov bx,cible.sgm       { Ecrit l'octet dans la cible}
    mov es,bx
    mov bx,cible.ofs
    mul outvolume
    shr ax,6
    mov es:[bx],al
    inc cible.ofs

    loop @mixed_2_blk
end;
end;

procedure mixe_start_4;var dummy:byte;li:integer;begin
 for li:=1to(Voix)do begin;
   if note[li] <> 0 then begin;
     tonhauteur_Voix[li]:=((Rm_Song[mli,li,1]and$F)shl 8)+Rm_Song[mli,li,2];
     get_pctunel(tonhauteur_Voix[li],Incval_Voix[li]);
   end;
   ASM
    MOV SI,li
    DEC SI
    MOV BL,DS:[Offset In_st+SI]
    XOR BH,BH
    DEC BX
    MOV AX,DS:[Offset loop_s+BX] {ls[li] := loop_s[In_st[li]]}
    MOV DS:[Offset ls+SI],AX
    MOV AX,Ds:[Offset loop_l+BX] {ll[li] := loop_l[In_st[li]]}
    MOV DS:[Offset ll+SI],AX
   END;
   if ll[li] > 30 then inl[li] := ll[li]+ls[li];
   Loop_Longueur_Voix[li] := ll[li];
   Loop_Start_Voix[li]  := ls[li];
   case effet_Voix[li] of
     1 :inc(Incval_Voix[li],Portamento_up_Voix[li]);
     2 :inc(Incval_Voix[li],Portamento_do_Voix[li]);
   end;
 end;
end;

procedure effect_handling(li:integer);var startinc,endinc:longint;
idx,Portamento_Speed,Startnote,endnote:word;begin;
 if Rm_Song[mli,li,3] and $0F <= 15 then begin;
   Eff[li] := 0;
   case (Rm_Song[mli,li,3] and $0F) of
(*       0: Begin
             idx:=Rm_Song[mli,li,4];
	     effet_Voix[li] := 1;
	     Portamento_Speed := idx;
	     Startnote := Notes_nr(tonhauteur_Voix[li]);
	     Endnote   := Startnote{+Portamento_Speed};
	     get_pctunel(Modoctave[Startnote],Startinc);
	     get_pctunel(Modoctave[Endnote],Endinc);
{	     Portamento_up_Voix[li] := LongInt((Endinc-Startinc)div playspeed);}
{             inl[li]    := 0;
	     Notvol_Voix[li]   := 0;
	     inp[li]    := 0;
	     NotVol[li]    := 0;}
       End;*)
      01 : begin;
	     effet_Voix[li] := 1;
	     Portamento_Speed := Rm_Song[mli,li,4];
	     Startnote := Notes_nr(tonhauteur_Voix[li]);
	     Endnote   := Startnote+Portamento_Speed;
	     get_pctunel(Modoctave[Startnote],Startinc);
	     get_pctunel(Modoctave[Endnote],Endinc);
	     Portamento_up_Voix[li] := LongInt((Endinc - Startinc)div playspeed);
	   end;
      02 : begin;
	     effet_Voix[li] := 2;
	     Portamento_Speed := Rm_Song[mli,li,4];
	     Startnote := Notes_nr(tonhauteur_Voix[li]);
	     Endnote   := Startnote-Portamento_Speed;
	     get_pctunel(Modoctave[Startnote],Startinc);
	     get_pctunel(Modoctave[Endnote],Endinc);
	     Portamento_do_Voix[li] := LongInt((Endinc - Startinc)div playspeed);
	   end;
       8:;
       9 : begin;  { Sample offset }
	     Position_Voix[li] := longint(Rm_Song[mli,li,4]) shl 24;
	   end;
      13 : mli := 64;
      11 : begin;
            mli := 64;
	    mlj := Rm_Song[mli,li,4];
           end;
      12 : begin;
	     Notvol_Voix[li]  := Volume_notes(li);
	   end;
      14 : begin;
	     case (Rm_Song[mli,li,4] shr 4) of
		12 : begin;
		       inl[li]    := 0;
		       Notvol_Voix[li]   := 0;
		       inp[li]    := 0;
		       NotVol[li]    := 0;
		     end;
{                Else WriteLn('M=',(Rm_Song[mli,li,4] shr 4));}
	     end;
	   end;
      15 : begin;
	     idx := Rm_Song[mli,li,4];
	     if idx <= $f then Playspeed    := idx
	      else
             begin
	      bpm := idx;
	      mod_SetLoop(Sampling_Frequence div(BPM shl 2));
             End;
	     Speed := Playspeed*105 div 10;
	     taillebloc := Speed * Sound_Boucle;
	     if taillebloc < 40 then taillebloc := 40;
	     if taillebloc > 4000 then taillebloc := 4000;
           end;
{      Else WriteLn('F=',(Rm_Song[mli,li,3] and $0F));}
    end;
  end;
end;

Procedure MoveRmSong(Var Buffer);Near;Assembler;ASM
 CLD
 MOV CX,2048/4
 PUSH DS
  PUSH DS
  POP ES
  MOV DI,Offset Rm_Song
  LDS SI,Buffer
  DB 0F3h,66h,0A5h { REP MOVSD }
 POP DS
END;

procedure nmw_all_4;const stereoprocs:array[1..8]of pointer=
  (@Voix_normale,@Voix_normale,@Voix_normale_st,@Voix_normale_st,
   @Voix_normale,@Voix_normale,@Voix_normale_st,@Voix_normale_st);
var idx:byte;li:integer;begin;
   inc(mli);
   if mli > 64 then mli := 1;
   if mli = 1 then begin;
     inc(mlj);
     if mlj > Chansonlongueur then begin;
       if mloop then begin;
	 mlj := 1;
         MoveRmSong(rm[Chanson[1]]^);
       end else begin;
	 asm
	   call [periodic_arret]
	 end;
	 music_off:=true;Mod_Fin:=true;
       end;
     end else MoveRmSong(rm[Chanson[mlj]]^);
   end;
  for li := 1 to Voix do begin;
    effet_Voix[li] := 0;
    note[li] := (Rm_Song[mli,li,1]and $F0)+(Rm_Song[mli,li,3]shr 4);
    if note[li] <> 0 then begin;
      if stereo then begin;
	Mixingproc_voix[li] := stereoprocs[li];
      end else begin;
	Mixingproc_voix[li] := @Voix_normale;
      end;
      Frappe_notes[li] := 500;
      In_St[li]  := note[li];
      inst[li]  := Ptr(pt(Samp[In_St[li]]).sgm,pt(Samp[In_St[li]]).ofs);
      Longueur_Voix[li]      := sam_l[In_St[li]];
      Position_Voix[li]    := 0;
      Notvol_Voix[li]      := vol_inst[in_St[li]];
      Segment_Voix[li]     := seg(inst[li]^);
    end;
    effect_handling(li);
  end;
end;

procedure initialiser_mixage;begin;
  asm
    call [mixer_proc]
  end;
end;

Function ConvertString(Source:Pointer;Size:Byte):String;Var WorkStr:String;Begin
 Move(Source^,WorkStr[1],Size);
 WorkStr[0] := CHR(Size);
 ConvertString := WorkStr;
End;

function init_Song:boolean;
const idt1 : string = 'FLT4';
      idt2 : string = 'M.K.';
      idt3 : string = '8CHN';
var rmod : file;
    sgr : word;                         { taille d'un sample }
    inststart : longint; { Position o— d‚marrent les donn‚es sample dans le fichier }
    t_fichier : longint;                    { La taille du fichier MOD }
    Mkg : array[1..4] of char;          { pour reconnaŒtre le type de mode m }
    helpsp : ^byte;
    strptr : pointer;
    idtch : array[1..4] of char;
    idtstr : string;
    instance : byte;
    idx : integer;
begin;
 In_St[1] := 0;
 In_St[2] := 0;
 In_St[3] := 0;
 In_St[4] := 0;
 In_St[5] := 0;
 In_St[6] := 0;
 In_St[7] := 0;
 In_St[8] := 0;
 for mlj:=0to 128do Chanson[mlj]:=0;
 {$I-}
 assign(rmod,Mod_Nom);
 reset(rmod,1);
 {$I+}
 if IOresult<>0then begin;init_song:=false;exit;end;
 if taillefimod <> 0 then t_fichier := taillefimod else
 t_fichier := filesize(rmod);
 inststart := t_fichier;
 seek(rmod,1080);
 blockread(rmod,idtch,4);
 idtstr := idtch;
 if(idtstr<>idt1)and(idtstr<>idt2)and(idtstr<>idt3)then instance:=15 else instance:=31;
 if instance = 31 then begin;  { 31 voix obtenus par leurs num‚ros d'identit‚}
 for mlj := 1 to 31 do begin;
  idx := mlj;
  seek(rmod,msp+42+(idx-1)*30);
  blockread(rmod,sgr,2);
  sgr := swap(sgr) * 2;
  if sgr <> 0 then inststart := inststart - sgr;
  Sam_l[idx] := sgr;
  seek(rmod,msp+45+(idx-1)*30);
  blockread(rmod,vol_inst[idx],1);
  blockread(rmod,loop_s[idx],2);
  blockread(rmod,loop_l[idx],2);
  loop_s[idx] := swap(loop_s[idx])*2;
  loop_l[idx] := swap(loop_l[idx])*2;
 end;
 seek(rmod,msp+1080);
 blockread(rmod,Mkg,4);
 if pos('8CHN',Mkg) <> 0 then begin;
  Taille_patt:=2048;Voix:=8;shiftfacteur:=3;shiftfacteur_stereo:=3;
 end else begin;
 { Fichier MOD - 4 voix }
   Taille_patt:=1024;Voix:=4;shiftfacteur:=2;shiftfacteur_stereo:=2;
 end;
 Mixer_Proc:=@mixe_start_4;nmw_Proc:=@nmw_all_4;
 if(stereo)then proc_intra:=@intra_boucle_4_stereo
           else proc_intra:=@intra_boucle_4;
 seek(rmod,msp+inststart);
 for mlj := 1 to 31 do begin;
  idx := mlj;
  getmem(Samp[idx],Sam_l[idx]);
  blockread(rmod,Samp[idx]^,sam_l[idx]);
 end;
 t_fichier:=inststart-1083;nb_patt:=t_fichier div Taille_patt;
 for mlj:=0to nb_patt-1do begin;
   getmem(rm[mlj],2048);
   fillchar(rm[mlj]^,2048,0);
   seek(rmod,msp+1084+mlj*Taille_patt);
   helpsp := ptr(seg(rm[mlj]^),ofs(rm[mlj]^));
   for mli := 0 to 63 do begin;
     helpsp := ptr(seg(rm[mlj]^),ofs(rm[mlj]^)+mli*32);
	 blockread(rmod,helpsp^,Taille_patt div 64);
   end;
 end;
 seek(rmod,msp+952);
 blockread(rmod,Chanson,128);
 getmem(strptr,25);
 for i := 0 to 30 do begin;
   seek(rmod,msp+20+i*30);
   blockread(rmod,strptr^,22);
   noms_inst[i+1] := convertstring(strptr,22);
 end;
 seek(rmod,msp);
 blockread(rmod,strptr^,20);
 Nom_chanson := convertstring(strptr,20);
 freemem(strptr,25);
 seek(rmod,msp+950); { … partir de 470}
 blockread(rmod,Chansonlongueur,1);
 end else begin;
 for mlj := 1 to 15 do begin;
  seek(rmod,msp+42+(mlj-1)*30);
  blockread(rmod,sgr,2);
  sgr := swap(sgr) * 2;
  if sgr <> 0 then inststart := inststart - sgr;
  Sam_l[mlj] := sgr;
  seek(rmod,msp+45+(mlj-1)*30);
  blockread(rmod,vol_inst[mlj],1);
  blockread(rmod,loop_s[mlj],2);
  blockread(rmod,loop_l[mlj],2);
  loop_s[mlj] := swap(loop_s[mlj])*2;
  loop_l[mlj] := swap(loop_l[mlj])*2;
 end;
 for mlj := 16 to 31 do begin;
  Sam_l[mlj]:=0;loop_s[mlj]:=0;loop_l[mlj]:=0;
 end;
 if pos('8CHN',Mkg) <> 0 then begin;
  Taille_patt:=2048;Voix:=8;shiftfacteur:=3;shiftfacteur_stereo:=3;
 end else begin;
 { Fichier MOD … quatre voix }
   Taille_patt:=1024;Voix:=4;shiftfacteur:=2;shiftfacteur_stereo:=2;
 end;
 Mixer_Proc:=@mixe_start_4;nmw_Proc:=@nmw_all_4;
 if(stereo)then proc_intra:=@intra_boucle_4_stereo
           else proc_intra:=@intra_boucle_4;

 seek(rmod,msp+inststart);
 for mlj := 1 to 15 do begin;
   getmem(Samp[mlj],Sam_l[mlj]);
   blockread(rmod,Samp[mlj]^,sam_l[mlj]);
 end;
 t_fichier:=inststart-603;nb_patt:=t_fichier div Taille_patt;
 for mlj := 0 to nb_patt-1 do begin;
   getmem(rm[mlj],2048);
   fillchar(rm[mlj]^,2048,0);
   seek(rmod,msp+1084+mlj*Taille_patt);
   helpsp := ptr(seg(rm[mlj]^),ofs(rm[mlj]^));
   for mli := 0 to 63 do begin;
     helpsp := ptr(seg(rm[mlj]^),ofs(rm[mlj]^)+mli*32);
	 blockread(rmod,helpsp^,Taille_patt div 64);
   end;
 end;
 seek(rmod,msp+472);
 blockread(rmod,Chanson,128);
 getmem(strptr,25);
 for i := 0 to 14 do begin;
  seek(rmod,msp+20+i*30);
  blockread(rmod,strptr^,22);
  noms_inst[i+1] := convertstring(strptr,22);
 end;
 for i := 15 to 30 do noms_inst[i+1] := '';
 seek(rmod,msp);
 blockread(rmod,strptr^,20);
 Nom_chanson := convertstring(strptr,20);
 freemem(strptr,25);
 seek(rmod,msp+470);
 blockread(rmod,Chansonlongueur,1);
 end;
 mlj := 0; mli := 0;
 close(rmod);
 init_song := true;
end;


procedure exit_song;begin;
 Port[dsp_adr+$C]:=$D3;
 halt(0);
end;

procedure Free_Soundmem;begin;
 If(music_played)Then For mlj:=0to Nb_patt-1do FreeMem(rm[mlj],2048);
end;

procedure init_sbperiod(p:pointer);begin;periodic_arret:=p;end;
procedure mod_SetLoopflag(loopen:boolean);begin;mloop:=loopen;end;
procedure mod_SetMultiply(msm:word);begin;modmultiply:=msm;end;
procedure mod_SetLoop(msl:word);begin;Sound_Boucle:=msl;loop3:=msl;end;
procedure mod_SetSpeed(msp:word);begin;speed:=msp;Speed3:=msp;end;
procedure mod_autodetect(what:boolean);begin;mautodet:=what;end;
procedure mod_transpose(transposerwert:integer);begin;tpw:=transposerwert;end;

procedure init_data;
Var i,j : integer;
begin;
 m_played := false;
 In_St[1] := 0;
 In_St[2] := 0;
 In_St[3] := 0;
 In_St[4] := 0;
 In_St[5] := 0;
 In_St[6] := 0;
 In_St[7] := 0;
 In_St[8] := 0;
 Note1 := 0;
 Note2 := 0;
 Note3 := 0;
 Note4 := 0;
 Note5 := 0;
 Note6 := 0;
 Note7 := 0;
 Note8 := 0;
 Frappe_Notes[1] := 0;
 Frappe_Notes [2] := 0;
 Frappe_Notes [3] := 0;
 Frappe_Notes [4] := 0;
 Frappe_Notes [5] := 0;
 Frappe_Notes [6] := 0;
 Frappe_Notes [7] := 0;
 Frappe_Notes [8] := 0;
 fillchar(inl,sizeof(inl),0);
 notvol1 := 0; notvol2 := 0; notvol3 := 0; notvol4 := 0;
 notvol5 := 0; notvol6 := 0; notvol7 := 0; notvol8 := 0;
 fillchar(Rm_Song,2048,0);
end;

procedure mod_Samplefreq(Rate : integer);begin;
 case Rate of
     08 : begin;
	    Sampling_Rate := 131;
	    set_timeconst_sb16(131);
	    mod_transpose(1);
	    mod_SetLoop(15);
	    TailleBloc := Speed * Sound_Boucle;
	    Sampling_Frequence := 8000;
	  end;
     10 : begin;
	    Sampling_Rate := 156;
	    set_timeconst_sb16(156);
	    mod_transpose(5);
	    mod_SetLoop(19);
	    TailleBloc := Speed * Sound_Boucle;
	    Sampling_Frequence := 10000;
	  end;
     13 : begin;
	    Sampling_Rate := 181;
	    set_timeconst_sb16(181);
	    mod_transpose(10);
	    mod_SetLoop(25);
	    TailleBloc := Speed * Sound_Boucle;
	    Sampling_Frequence := 13333;
	  end;
     16 : begin;
	    Sampling_Rate := 196;
	    set_timeconst_sb16(196);
	    mod_transpose(14);
	    mod_SetLoop(32);
	    Taillebloc := Speed * Sound_Boucle;
	    Sampling_Frequence := 16666;
	  end;
     22 : begin;
	    Sampling_Rate := 211;
	    set_timeconst_sb16(211);
	    mod_transpose(19);
	    mod_SetLoop(44);
	    Taillebloc := Speed * Sound_Boucle;
	    Sampling_Frequence := 22222;
	  end;
   end;
end;

procedure Sound_handler;var li:integer;begin;
 if mycli<>0then exit;
 mycli:=1;
 if (Loop_pos > Speed) then begin;
   if phase_2 then begin;
     Perfcount:=0;
     asm
       call [nmw_proc]
     end;
     Initialiser_mixage;
     Loop_pos:=0;phase_2:=false;phase_1:=true;
     if outfading then if outvolume >= 2 then dec(outvolume,2);
     for li:=1to 8do if Frappe_notes[li]>50then dec(Frappe_notes[li],50);
   end;
 end else begin;
     asm call [proc_intra] end;
   Loop_pos := Speed+2;
 end;
 mycli := 0;
end;

procedure calculate_music; assembler;asm
 cmp mycli,0
 jne  @fin_stop
 cmp  music_off,0
 jne   @fin_stop
 pusha
 call Sound_handler
 popa
 @fin_stop:
end;

procedure mod_waitretrace(num:byte);var dl:integer;begin;
 in_retrace := true;
 for dl := 1 to num do calculate_music;
asm
  push dx
@l1:
  mov dx,3dah
  in al,dx
  and al,8h
  jnz @l1
@l2:
  mov dx,3dah
  in al,dx
  and al,8h
  jz @l2
  pop dx
End;
 in_retrace := false;
end;

function charge_fichiermod(modnom : string;ispeed,iloop : integer;freq : byte) : integer;
var df:file;sterreg:byte;t_f:longint;begin;
 PLAYING_MOD:=true;PLAYING_VOC:=false;outfading:=false;outvolume:=63;Mod_Nom:=modnom;
 {$I-}
 assign(df,Mod_nom);
 reset(df,1);
 {$I+}
 if IOResult <> 0 then begin;
   {$I-}
   close(df);
   charge_fichiermod := -1;                 { Fichier non trouv‚ !     }
   exit;
 end;
 {$I-}
 t_f := filesize(df);
 close(df);
 music_played:=true;music_off:=false;Mod_fin:=false;
 if ispeed <> AUTO then Speed3 := ispeed;
 if iloop <> AUTO then Loop3  := iloop;
 if force_mono then stereo := false;
 if force_sb then begin;
   if Sb16Detected then stereo := false;
   Sb16Detected := false;
 end;
 if SBProdetected then begin;
   if stereo then begin;
     sterreg := Read_Mixer($0e);
     write_Mixer($0e,sterreg OR 2);
   end else begin;
     sterreg := Read_Mixer($0e);
     write_Mixer($0e,sterreg AND $FD);
   end;
 end;
 init_data;
 if init_song then begin;
   phase_1 := false;
   phase_2 := true;
   mycli := 0;
   mod_Samplefreq(freq);
   Playspeed    := 6;
   Speed := Playspeed*105 div 10;
   bpm := 125;
   mod_SetLoop(Sampling_Frequence div (BPM shl 2));
   taillebloc := Speed * Sound_Boucle;
   if taillebloc < 100 then taillebloc := 100;
   if taillebloc > 4000 then taillebloc := 4000;

   asm call [nmw_proc] end;
   set_timeconst_sb16(Sampling_Rate);
   Initialiser_mixage;
   Secpass := 0;
   Minpass := 0;
   wr_dsp_sb16($D1);
   if sb16detected or sbprodetected then begin;
	   Filtre_Mid;
     Set_Balance(Balance);
     Set_Volume(Mastervolume);
   end;
   Charge_fichiermod := 0;
 end else begin;
   Charge_fichiermod := -3;  { Erreur au chargement de la chanson }
 end;
end;

procedure fin_mod;var mlj:integer;begin;
 Free_Soundmem;
 for mlj := 1 to 31 do begin;
   freemem(Samp[mlj],Sam_l[mlj]);
 end;
 mod_terminated := true;
end;

Procedure periodic_on;Begin
 Outvolume:=64;
 dern_sortie := false;
 for Loop_pos := 1 to Speed do begin;
   asm call [proc_intra] end;
 end;
 dsp_block_sb16(taillebloc,taillebloc,buffer1,true,false);
 bsw := not bsw;
 Loop_pos := 0;
 asm
   call [nmw_proc]
 end;
 Initialiser_mixage;

 init_sbperiod(@periodic_off);
 music_played := true;
 RegleTimer(@NouveauTimer,timer_per_second);
End;

Procedure periodic_off;Begin
  dern_sortie := true;
  RestaureTimer;
End;

procedure Fade_Musix_out;
begin;
  outfading := true;
end;

procedure MODExitProc;
var mlj : byte;
 begin
 ExitProc := SaveExitProc;
{ if music_played then periodisch_off;}
 if not mod_terminated and music_played then fin_mod;
 Exit_Sb16;
end;



{

 **************************************************************************
 ***                                                                    ***
 ***                 Routine pour sortir du fichier VOV                 ***
 ***                                                                    ***
 **************************************************************************

}

var pause_voc : boolean;


procedure Init_Voc(filename : string);
const VOCidt : string = 'Creative Voice File'+#$1A;
var ch : char;
    idtstr : string;
    ct : byte;
    h : byte;
    error : integer;
    srlo,srhi : byte;
    SR : word;
    Samplingr : word;
    stereoreg : byte;
begin;
  PLAYING_MOD := false;
  PLAYING_VOC := true;
  VOC_READY   := false;
  vocsstereo := stereo;
  stereo := false;

  assign(vocf,filename);
  reset(vocf,1);
  if filesize(vocf) < 5000 then begin;
    VOC_READY   := true;
    exit;
  end;
  blockread(vocf,voch,$19);
  idtstr := voch.Ident;
  if idtstr <> VOCidt then begin;
    VOC_READY   := true;
    exit;
  end;

  Blockread(vocf,inread,20);
  vblock.Ident_code := inread[2];

  if vblock.Ident_code = 1 then begin;
    vblock.SR := inread[6];
  end;

  if vblock.Ident_code = 8 then begin;
    SR := inread[6]+(inread[7]*256);
    Samplingr := 256000000 div (65536 - SR);
    if inread[9] = 1 then begin; {stereo}
      if sb16detected then samplingr := samplingr shr 1;
      stereo := true;
    end;
    vblock.SR := 256 - longint(1000000 DIV samplingr);
  end;

  if vblock.Ident_code = 9 then begin;
    Samplingr := inread[6]+(inread[7]*256);
    if inread[11] = 2 then begin; {stereo}
      stereo := true;
      if sbprodetected then samplingr := samplingr * 2;
      vblock.SR := 256 - longint(1000000 DIV (samplingr));
    end else begin;
      vblock.SR := 256 - longint(1000000 DIV samplingr);
    end;
  end;


  if vblock.SR < 130 then vblock.SR := 166;

  set_timeconst_sb16(vblock.SR);

  t_bloc := filesize(vocf) - 31;
  if t_bloc > 2500 then t_bloc := 2500;
  blockread(vocf,buffer1^,t_bloc);

  ch := #0;
  t_f := filesize(vocf) - 32;
  t_f := t_f - t_bloc;
  Bloc_actif := 1;

  if t_f > 1 then begin;
    blockread(vocf,buffer2^,t_bloc);
    t_f := t_f - t_bloc;
  end;

  wr_dsp_sb16($D1);
  lastone := false;

 if not sb16Detected then begin;
   if Stereo then begin;
     stereoreg := Read_Mixer($0E);
     stereoreg := stereoreg OR 2;
     Write_Mixer($0E,stereoreg);
   end else begin;
     stereoreg := Read_Mixer($0E);
     stereoreg := stereoreg AND $FD;
     Write_Mixer($0E,stereoreg);
   end;
 end;
 pause_voc:=false;
 dsp_block_sb16(t_bloc,t_bloc,vocb1,false,true);
end;

procedure voc_done;
var h : byte;
begin;
 lastone := true;
{ repeat until dsp_rdy_sb16;}
 close(vocf);
 Reset_Sb16;
 stereo := vocsstereo;
end;


procedure voc_pause;
begin;
  pause_voc := true;
end;

procedure voc_continue;
begin;
  pause_voc := false;
  if bloc_actif = 1 then begin
    dsp_block_sb16(T_bloc,T_bloc,vocb2,false,true);
    bloc_actif := 2;
  end else begin;
    dsp_block_sb16(T_bloc,T_bloc,vocb1,false,true);
    bloc_actif := 1;
  end;
end;


procedure dsp_int_sb16; interrupt;
{
 On passe … cette proc‚dure avec l'interruption g‚n‚r‚e … la fin
 d'un transfert de bloc. Si le flag dern_sortie n'a pas ‚t‚ pos‚,
 une nouvelle sortie d‚marre.
}
var h : byte;
begin;
  if interrupt_check then begin;
    IRQDetected := true;
  end else begin;
    if Playing_Mod then begin;
      h := port[dsp_adr+$E];
      dsp_rdy_sb16 := true;

      if not dern_sortie then begin;
       if bsw then
	dsp_Block_sb16(taillebloc,Taillebloc,Buffer1,true,false)
       else
	dsp_Block_sb16(taillebloc,Taillebloc,Buffer2,true,false);
	bsw := not bsw;
	phase_1 := false;
	phase_2 := true;
      end;
    end;

    IF PLAYING_VOC then begin;
      h := port[dsp_adr+$E];
      if (T_f > T_bloc) and not lastone then begin
	lastone := false;
	if bloc_actif = 1 then begin
	  if not pause_voc then
	    dsp_block_sb16(T_bloc,T_bloc,vocb2,false,true);
	  blockread(vocf,vocb1^,T_bloc);
	  T_f := T_f - T_bloc;
	  bloc_actif := 2;
	end else begin;
	  if not pause_voc then
	    dsp_block_sb16(T_bloc,T_bloc,vocb1,false,true);
	  blockread(vocf,vocb2^,T_bloc);
	  T_f := T_f - T_bloc;
	  bloc_actif := 1;
	end;
      end else begin;
	if not lastone then begin;
	  if bloc_actif = 1 then begin
	    if not pause_voc then
	      dsp_block_sb16(T_bloc,T_bloc,vocb2,false,true);
	    lastone := true;
	  end else begin;
	    if not pause_voc then
	      dsp_block_sb16(T_bloc,T_bloc,vocb1,false,true);
	    lastone := true;
	  end;
	end else begin;
	  dsp_rdy_sb16 := true;
	  wr_dsp_sb16($D0);
	  VOC_READY := true;
	end;
      end;
    end;
  end;
  Port[$20] := $20;
end;


procedure detect_sbIRQ;
{
 Cette routine reconnaŒt l'interruption de la carte Sound Blaster. Pour cela
 on teste toutes les interruptions possibles. On envoie des blocs courts
 via DMA. Si la sortie se conclut par le saut … l'interruption indiqu‚e,
 celle-ci a ‚t‚ trouv‚e.
}
const irqs_possibles : array[1..5] of byte = ($2,$3,$5,$7,$10);
var i : integer;
    h : byte;
begin;
 getintvec($8+dsp_irq,intback);         { Sauvegarde les valeurs ! }
 port21 := port[$21];
 fillchar(buffer1^,1200,128);
 set_Timeconst_sb16(211);
 Wr_dsp_sb16($D3);                           { Eteint le haut-parleur }
 i := 1;
 interrupt_check := true;
 while (i <= 5) and (not IRQDetected) do
   begin;
     dsp_irq := irqs_possibles[i];      { IRQ … tester }
     getintvec($8+dsp_irq,oldint);      { Interruption d‚tourn‚e }
     setintvec($8+dsp_irq,@Dsp_Int_sb16);
     irqmsq := 1 shl dsp_irq;
     port[$21] := port[$21] and not irqmsq;
     Sampling_Rate := 211;
     taillebloc := 1200;              { Sortie pour test }
     dsp_Block_sb16(taillebloc,Taillebloc,buffer1,true,false);
     delay(150);
     setintvec($8+dsp_irq,oldint);      { R‚tablit l'interrupt }
     port[$21] := Port[$21] or irqmsq;
     h := port[dsp_adr+$E];
     Port[$20] := $20;
     inc(i);
   end;
 interrupt_check := false;
 Wr_dsp_sb16($D1);                           { R‚tablit le haut-parleur }
 setintvec($8+dsp_irq,intback);         { R‚tablit les valeurs !!!      }
 port[$21] := port21;
 dsp_rdy_sb16 := true;
end;


function Init_Sb : boolean;
begin;
  if not detect_Reg_sb16 then begin;
    Init_Sb := false;
    exit;
  end;
{ Soundblaster trouv‚      }
 if not force_irq then detect_sbIRQ;    { IRQ auto-detection         }
   test_Transmission;
 if not force_irq then detect_sbIRQ;
 if Detect_Mixer_sb16 then begin;
   SbProDetected := TRUE;
 end;
 SbGetDspVersion;
 if SbVersMaj >= 4 then begin;                { SB 16 ASP d‚tect‚e         }
   Sb16Detected := true;
   SBProDetected := false;
 end;
 wr_dsp_sb16($D1);
 getintvec($8+dsp_irq,oldint);
 setintvec($8+dsp_irq,@dsp_int_sb16);
 irqmsq := 1 shl dsp_irq;
 port[$21] := port[$21] and not irqmsq;
end;

function init_The_Mod : boolean;
begin;
 mod_autodetect(on);
 mod_SetSpeed(66);
 mod_SetMultiply(11);
 mod_Setloopflag(ON);

 if not init_sb then
   init_the_mod := false
 else begin;
   init_the_mod := true;
   mod_Samplefreq(Samfreq);
 end;
end;


begin;
 SaveExitProc := ExitProc;
 ExitProc := @MODExitProc;
 dsp_rdy_sb16 := true;
 mod_terminated := false;
 music_played := false;
 mloop := true;
 mli := 0;
 mlj := 0;
 tpw := 5;
 In_St[1] := 0;
 In_St[2] := 0;
 In_St[3] := 0;
 In_St[4] := 0;
 In_St[5] := 0;
 In_St[6] := 0;
 In_St[7] := 0;
 In_St[8] := 0;
 loop_pos := 0;
 mautodet := true;
 modmultiply  := 20;
 Sound_boucle := 10;
 Frappe_notes[1] := 0;
 Frappe_notes[2] := 0;
 Frappe_notes[3] := 0;
 Frappe_notes[4] := 0;
 Frappe_notes[5] := 0;
 Frappe_notes[6] := 0;
 Frappe_notes[7] := 0;
 Frappe_notes[8] := 0;
 Voixvide := @Voix_vide;
 Mixingproc_voix[1] := Voixvide;
 Mixingproc_voix[2] := Voixvide;
 Mixingproc_voix[3] := Voixvide;
 Mixingproc_voix[4] := Voixvide;
 Mixingproc_voix[5] := Voixvide;
 Mixingproc_voix[6] := Voixvide;
 Mixingproc_voix[7] := Voixvide;
 Mixingproc_voix[8] := Voixvide;
 getmem(mixed_data,8000);
 getmem(mixed_data_st,8000);
 getmem(buffer1,8000);
 getmem(buffer2,8000);
 getmem(vocb1,8000);
 getmem(vocb2,8000);
 bsw := true;
end.

