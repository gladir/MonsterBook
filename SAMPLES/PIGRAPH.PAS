Program MonteCarloGraphique;

Uses Adele,Systex,Systems,Video,Goldnaxe,Numerix;

Var x,y,r,xp,yp:Word; {Coordonn‚es des points}
    Cpt,              {Cpt compte les lancers}
    CptIn:LongInt;    {CptIn compte les coups dans la cible}
    Dx,Dy:Real;

BEGIN
 InitSystems(suIsabel);
 SetVideoMode(vmGrf640x480c256);
 x:=200;y:=400;r:=400;
 _SetKr(Yellow);                 {Affichage en couleur jaune}
 _PutRect(x,y-r,x+r,y);
 _Arc(x,y-r,270,360,r);          {Dessine l'arc de cercle de rayon r}
 CptIn:=0;Cpt:=0;                {Initialise les compteurs}
  {Cpt=MaxLongInt ‚vite que Cpt ne devienne trop grand}
 While Not(KeyPress or(Cpt=MaxLongInt))do Begin
  Dx:=Random;                    {Choix au hasard de Dx î [0,1[}
  Dy:=Random;                    {Choix au hasard de Dy î [0,1[}
  xp:=x+Trunc(Dx*r);             {x du point trouv‚ au hasard}
  yp:=y-r+Trunc(Dy*r);           {y du point trouv‚ au hasard}
  Inc(Cpt);                      {Un point de plus}
  If Dx*Dx+Dy*Dy<1Then Begin     {Ce point appartient-il au ¬ de cercle?}
   Inc(CptIn);                   {On augmente le compteur}
   SetPixel(xp,yp,LightGreen);   {Affiche le point}
  End
   Else
  SetPixel(xp,yp,LightRed);      {Affiche le point en rouge clair}
  PutTxtXY(5,24,'ã = '+RealStr2(4*(CptIn/Cpt),9,7),Yellow);
 End;
 ReadKey;                        {Attend qu'une touche soit enfonc‚e}
END.