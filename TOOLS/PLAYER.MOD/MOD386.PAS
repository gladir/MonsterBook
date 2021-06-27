{
 ****************************************************************************
 *** Ce programme illustre la mise en oeuvre de l'unit‚ MOD_SB. Il permet ***
 *** d'ex‚cuter des fichiers MOD et VOC. Le lancement de ce programme     ***
 *** sans paramŠtre, abouti … un menu de s‚lection qui permet de choisir  ***
 *** un fichier son parmi ceux du r‚pertoire courant. Le paramŠtre -r     ***
 *** active le mode Repeat. Appuyer alors sur ESC si vous  d‚sirez        ***
 *** sortir du programme.                                                 ***
 ****************************************************************************
}



uses {ModInit,}{Chantal,}Adele,Systex,Systems,Mouse,Video,Dials,{Overlay,}
     DialPlus,crt,dos,modsb,variab;

{{{$O ModSB}

{ $define polling}
{
 Normalement, la valeur est renvoy‚e par Timer-Interrupt. Mais s'il vous
 faut synchroniser avec le Retrace horizontal, vous devez utiliser la
 m‚thode Polling, qui calcule le son d'une fa‡on non-p‚riodique, quand
 elle a le temps. C'est une m‚thode, plus lente, qui produit une moins
 bonne qualit‚. Elle peut conduire … des problŠmes avec des MOD …
 8 voix. Son utilisation est cons‚ill‚e, si on ne peut pas faire
 autrement.
}

type
  t = record                      { Pour une impression directe sur l'‚cran }
       c : char;
       a : byte;
     end;

const Nummods : byte = 0;
      repeatmode : boolean = false;

var gi : integer;
    my_modname : string;
    stapo,stinc : integer;
    ch,dch : char;
    next_song : integer;
    effects : array[1..4] of effect_type;
    Modd : array[1..10] of string;

Procedure PutVolume;Begin
 SetKr($9);
 _PutTxtXY(46,1,'Volume: ');
 SetKr($B);
 _PutTxt(Str2(Mastervolume,2));
 SetKr($9);
End;

Procedure PutBalance;Begin
 SetKr($9);
 _PutTxtXY(57,1,'Balance ');
 SetKr($E);
 _PutTxtXY(65,1,'þþþþþþþþþþþþþ');
 SetKr(4);
 _PutTxtXY(77-(Balance shr 1),1,'þ');
 SetKr($9);
End;

procedure Scala_boxes;Var I:Byte;begin;
  textcolor(1);
  textbackground(black);
  clrscr;
  textcolor(lightblue);
  SetKr($9);
  for I:=1to 10do begin;
   _PutTxtXY(1,I+3,Str2(I,2)+'. '+noms_inst[I]);
   _PutTxtXY(27,I+3,Str2(I+10,2)+'. '+noms_inst[I+10]);
   _PutTxtXY(53,I+3,Str2(I+20,2)+'. '+noms_inst[I+20]);
  end;
  SetBorderDouble;
  PutFillBorder(1,15,78,16+Voix,$F0);
  SetBorderSimpleLuxe;
  SetChr(26,15,'Ë');
  BarChrVer(26,16,15+Voix,'º');
  SetChr(26,16+Voix,'Ê');
  PutVolume;
  PutBalance;
  _PutTxtXY(35,1,'Filtre');
  SetKr($B);
  _PutTxt(' OFF');
end;

procedure Scala;var li,lj:integer;screen:array[1..50,1..80]of t absolute $B800:0;begin;
  SetKr($9);
  _PutTxtXY(1,2,'Nom de la chanson: ');
  SetKr($B);
  _PutTxt(Nom_chanson);
  SetKr($9);
  _PutTxtXY(35,2,'Fr‚quence: ');
  SetKr($B);
  _PutTxt(Str2(Sampling_Frequence,5));
  SetKr(9);
  _PutTxt(' KHz   Dur‚e: ');
  SetKr($B);
  _PutTxt(Str2(minpass,2)+':'+Str0(secpass,2));
  SetKr(9);
  _PutTxtXY(1,3,'Pattern No.:');
  SetKr($B);
  _PutTxt(Str2(Chanson[mlj],3));
  SetKr(9);
  _PutTxt('    Pattern:');
  SetKr($B);
  _PutTxt(Str2(mlj,3)+'/'+Str0(ChansonLongueur,3));
  SetKr(9);
  _PutTxt('    Ligne:');
  SetKr($B);
  _PutTxt(Str2(mli,3));
  SetKr(9);
  _PutTxt('    Vitesse: ');
  SetKr($B);
  _PutTxt(Str2(Playspeed,3)+'/128');
  SetKr(9);
  _PutTxtXY(1,1,'Memoire de libre: ');
  SetKr($B);
  _PutTxt(Str2(Maxavail,6)+' octets');
{  textcolor(black);
  textbackground(7);}
  SetKr($F0);
  For li:=1to(Voix)do If In_St[li]<>0Then _PutTxtXY(3,15+li,Noms_Inst[In_St[li]]);
  for lj := 1 to Voix do begin;
    for li := 1 to 16 do begin;
      if (Frappe_Notes[lj] div 10) > li then
        begin;
          screen[16 +lj,29+li].c := 'þ';
          screen[16 +lj,29+li].a := 114+$80;
        end else begin;
          screen[16 +lj,29+li].c := 'þ';
          screen[16 +lj,29+li].a := $F7;
        end;
    end;
    for li := 16  to 32 do begin;
      if (Frappe_Notes[lj] div 10) > li then
        begin;
          screen[16 +lj,29+li].c := 'þ';
          screen[16 +lj,29+li].a := 126+$80;
        end else begin;
          screen[16 +lj,29+li].c := 'þ';
          screen[16 +lj,29+li].a := $F7;
        end;
    end;
    for li := 33 to 48 do begin;
      if (Frappe_Notes[lj] div 10) > li then
        begin;
          screen[16 +lj,29+li].c := 'þ';
          screen[16 +lj,29+li].a := $F4;
        end else begin;
          screen[16 +lj,29+li].c := 'þ';
          screen[16 +lj,29+li].a := $F7;
        end;
    end;
  end;
end;

var retraceincs:word;systemspeed,modspeed:longint;

procedure test_waitretrace;begin;
retraceincs := 0;
  asm
    MOV   DX,03dAh
@WD_R:
    inc word ptr retraceincs
    IN    AL,DX
    TEST  AL,8d
    JZ    @WD_R
@WD_D:
    inc word ptr retraceincs
    IN    AL,DX
    TEST  AL,8d
    JNZ   @WD_D
  end;
end;

procedure test_systemspeed;var li:integer;begin;
  writeln;
  writeln('Test de rapidit‚ du systŠme, patientez SVP ...');
  writeln;
  test_waitretrace;
  systemspeed := 0;
  for li := 1 to 70 do begin;
    test_waitretrace;
    systemspeed := systemspeed+retraceincs;
  end;
end;

procedure test_modspeed;var li:integer;begin;
  writeln;
  writeln('Test de MOD-Speed, patientez SVP ...');
  writeln;
  test_waitretrace;
  modspeed := 0;
  for li := 1 to 210 do begin;
    test_waitretrace;
    modspeed := modspeed+retraceincs;
  end;
  modspeed := modspeed div 3;
end;

procedure Play_the_Mod(s:string);var h:byte;error,li:integer;begin;
 Reset_Sb16;
 mod_SetSpeed(66);
 mod_Samplefreq(Samfreq);
 dsp_rdy_sb16 := true;
 error := charge_fichiermod(s,AUTO,AUTO,Samfreq);
 if error <> 0 then begin;
   clrscr;
   writeln('Erreur pendant le chargement du fichier MOD ! ');
   if error = -1 then writeln('Fichier introuvable !');
   if error = -2 then writeln('M‚moire insuffisante !');
   halt(0);
 end;
 {$ifdef polling}
 start_polling;
 {$else}
 periodic_on;   { Active l'ex‚cution p‚riodique }
 {$endif}
 Scala_boxes;
 ch := #255;
 Repeat
  Repeat
   Calculate_music;
   Scala;
  Until KeyPress;
  Case Systems.ReadKey of
   kbEsc:Break;
   kbF3:Begin
    if Mastervolume>0then dec(Mastervolume);
    Set_Volume(Mastervolume);
    PutVolume;
   end;
   kbF4:Begin
    if Mastervolume < 31 then inc(Mastervolume);
    Set_Volume(Mastervolume);
    PutVolume;
   End;
   kbF5:Begin
    if Balance > 0 then dec(Balance);
    Set_Balance(Balance);
    PutBalance;
   End;
   kbF6:Begin
    if Balance < 24 then inc(Balance);
    Set_Balance(Balance);
    PutBalance;
   End;
  End;
 Until No;
 outfading := true;
{ while outvolume > 1 do Scala; {D‚grader de musique...}
 {$ifndef polling}
 periodic_off;
 {$endif}
 fin_mod;
 Reset_Sb16;
end;

procedure Write_Helptext;begin;
  textcolor(lightgray);
  textbackground(black);
  clrscr;
  writeln(' MOD386  Version 2.0, (c) 1994 MICRO APPLICATION',
	      ' Programmeur : Boris Bertelsons (InspirE)');
  writeln;
  writeln(' Utilisation : Mod386 <Nom de fichier[.MOD]> [options]');
  writeln;
  writeln(' Options possibles :');
  writeln(' -H        : cette ‚cran');
  writeln(' -In       : utilise l''interruption n');
  writeln(' -Dn       : utilise le canal DMA n');
  writeln(' -Pxxx     : Utilise l''adresse xxx');
  writeln(' -Snn      : Choix du taux d''‚chantillonnage en KHz possible : ',
	        '8,10,13,16,22');
  writeln(' -r        : s‚lectionne le mode "Repeat"');
  writeln(' -sb       : sans d‚tection d''une SB16');
  writeln(' <nom>     : zus„tzliche .MOD-Datei, spielt in zuf„lliger',
	        ' Reihenfolge');
  writeln;
  writeln;
  writeln('             - Appuyez sur une touche pour continuer -');
  writeln;
  repeat until keypressed; readkey;
  clrscr;
  writeln(' MOD386  Version 2.0, (c) 1994 MICRO APPLICATION',
	      '  Programmeur : Boris Bertelsons (InspirE)');
  writeln;
  writeln('Fonction des touches durant l''ex‚cution du programme ');
  writeln;
  writeln('  F : Filtre X-Bass On/Off');
  writeln(' F3 : Baisse le volume        F4 : Augmente le volume');
  writeln(' F5 : Balance vers la gauche  F6 : Balance vers la droite');
  writeln('  1 : Retour d''un Pattern      3 : Avance d''un pattern');
  writeln('  4 : Retour d''une ligne       6 : Avance d''une ligne');
  writeln('  n : Fichier suivant      esc,X : Quitter');
  writeln('  p : Performance du systŠme');
  writeln;
  SimpleCur;
  halt(0);
end;

procedure interprete_commandline;
var cs,hs:string;li,code:integer;sampelfr:word;Datnm:boolean;Begin;
 for li:=1to 10do begin;
  cs:=paramstr(li);Datnm:=true;
   { Utilisation de l'aide ? }
  if(pos('-h',cs)<>0)or(pos('/h',cs)<>0)or
    (pos('-H',cs)<>0)or(pos('/H',cs)<>0)or
    (pos('-?',cs)<>0)or(pos('/?',cs)<>0)then begin;
   write_Helptext;
   Datnm:=false;
  end;
    { mode repeat ? }
  if(pos('-r',cs)<>0)or(pos('/r',cs)<>0)or
    (pos('-R',cs)<>0)or(pos('/R',cs)<>0)then begin;
   Repeatmode:=true;Datnm:=false;
  end;
   { Force NO Sb16 ? }
  if(pos('-sb',cs) <> 0) or (pos('/sb',cs) <> 0) or
    (pos('-SB',cs) <> 0) or (pos('/SB',cs) <> 0) then begin;
   force_SB:=true;Datnm:=false;
  end;
  if(pos('-i',cs)<>0)or(pos('/i',cs)<>0)or
    (pos('-I',cs)<>0)or(pos('/I',cs)<>0)then begin;
   force_irq:=true;hs:=copy(cs,3,length(cs)-2);
   val(hs,dsp_irq,code);
   Datnm := false;
  end;
   { Force DMA ? }
  if (pos('-d',cs) <> 0) or (pos('/d',cs) <> 0) or
     (pos('-D',cs) <> 0) or (pos('/D',cs) <> 0) then begin;
   force_dma:=true;hs:=copy(cs,3,length(cs)-2);
   val(hs,dma_ch,code);
   Datnm := false;
  end;
  { Force Base ? }
    if (pos('-p',cs) <> 0) or (pos('/p',cs) <> 0) or
       (pos('-P',cs) <> 0) or (pos('/P',cs) <> 0) then begin;
       hs := copy(cs,3,length(cs)-2);
       if hs = '200' then dsp_adr := $200;
       if hs = '210' then dsp_adr := $210;
       if hs = '220' then dsp_adr := $220;
       if hs = '230' then dsp_adr := $230;
       if hs = '240' then dsp_adr := $240;
       if hs = '250' then dsp_adr := $250;
       if hs = '260' then dsp_adr := $260;
       if hs = '270' then dsp_adr := $270;
       if hs = '280' then dsp_adr := $280;
       Startport := dsp_adr;
       Endport   := dsp_adr;
      Datnm := false;
    end;
    { Indiquer Sampelrate ? }
    if (pos('-s',cs) <> 0) or (pos('/s',cs) <> 0) or
       (pos('-S',cs) <> 0) or (pos('/S',cs) <> 0) then begin;
      hs := copy(cs,3,length(cs)-2);
      val(hs,Sampelfr,code);
      if Sampelfr >= 8000 then Sampelfr := Sampelfr DIV 1000;
      if Sampelfr >= 8 then Samfreq := 8;
      if Sampelfr >= 10 then Samfreq := 10;
      if Sampelfr >= 13 then Samfreq := 13;
      if Sampelfr >= 16 then Samfreq := 16;
      if Sampelfr >= 22 then Samfreq := 22;
      Datnm := false;
    end;
    if Datnm then begin;
      if cs <> '' then begin;
        Inc(Nummods);
        Modd[Nummods] := cs;
      end;
    end;
  end;
end;

procedure write_vocmessage;begin;
  clrscr;
  _PutTxtXY(10,08,'Attention !  Le Voc entrera dans une boucle sans fin !!!');
  _PutTxtXY(10,10,'Commencer  par  Q  ');
  _PutTxtXY(10,11,'Pause     avec  P  ');
  _PutTxtXY(10,12,'Continuer avec  C  ');
  _PutTxtXY(10,13,'Reprendre avec  N  ');
  _PutTxtXY(10,21,'                         E N J O Y');
end;

procedure play_sound(datname:string);var li:integer;ch:char;begin;
 for li:=1to length(datname)do datname[li]:=upcase(Datname[li]);
  if pos('.MOD',datname)<>0then begin;
    Play_The_Mod(datname);
    exit;
  end;
  if pos('.VOC',datname) <> 0 then begin;
  repeat
    Reset_Sb16;
    write_vocmessage;
    Init_Voc(datname);
    ch := #0;
    repeat
      if keypressed then ch := readkey;
      if ch = 'p' then begin;
        voc_pause;
        repeat
          ch := readkey;
        until ch = 'c';
        voc_continue;
      end;
    until VOC_READY or (ch = 'n') or (upcase(ch) = 'Q');
    VOC_DONE;
  until upcase(ch) = 'Q';
  end;
end;

begin;
 InitSystems(suIsabel);
 InitVideoDeluxe;
 __InitMouse;
 InitEnv;
 Samfreq := 22;
 clrscr;
 Test_systemspeed;
 CloseCursor;
 interprete_commandline;
 if {(Nummods = 0) and} not repeatmode then begin;
   textcolor(15);
   textbackground(1);
   clrscr;
   Nummods := 1;
   modd[1] := OpenWin('*.MOD;*.VOC','Lancer un fichier de musique');
   {select_fichier('*.?o?','*.?o?','','S‚lection de fichiers son');}
   if modd[1] = 'xxxx' then begin;
     clrscr;
		 writeln('Vous avez donc d‚j… un fichier son !');
     SimpleCur;
     halt(0);
   end;
 end;
 for i := 1 to Nummods do begin;
   if pos('.',modd[i]) = 0 then modd[i] := modd[i]+'.mod';
 end;
 Init_The_Mod;
 stereo := false;
 next_song := random(Nummods)+1;
 textcolor(lightgray);
 textbackground(black);
 write_sbconfig;
 writeln;
 writeln;
 write('            ENTREE pour continuer ...');
 readln;
{ repeat}
   if repeatmode then begin;
     textcolor(15);
     textbackground(1);
     clrscr;
     modd[1] := OpenWin('*.MOD;*.VOC','Lancer un fichier de musique');
{     modd[1] := select_fichier('*.?o?','*.?o?','','');}
     if modd[1] = 'xxxx' then next_song := 255
     else Play_Sound(modd[1]);
   end else
     Play_Sound(modd[next_song]);
{   if next_song <> 255 then next_song := random(Nummods)+1;
 until next_song = 255;}
 SimpleCur;
{ textmode(3);}
 DoneLuxeVideo;
 DoneSystems;
end.

