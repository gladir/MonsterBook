{ Structures sp‚cifique … l'‚diteur de traitement de texte.
}

Unit Editex;

INTERFACE

Uses Systex;

Const
 MarkEnd:Boolean=True;    { Marqueur de fin }
 Rules:Boolean=True;      { RŠgles d'‚diteur }
 ViewOutZone:Boolean=True;{ Autorise la visualisation de la zone en marge }
 PathResource:PChr=NIL;   { R‚pertoire par d‚faut des ressources }
 PathPas:PChr=NIL;        { R‚pertoire par d‚faut des sources Pascal }
 PathFortran:PChr=NIL;    { R‚pertoire par d‚faut des sources Fortran }
 PathForth:PChr=NIL;      { R‚pertoire par d‚faut des sources Forth }
 PathEuphoria:PChr=NIL;   { R‚pertoire par d‚faut des sources Euphoria }
 PathCobol:PChr=NIL;      { R‚pertoire par d‚faut des sources Cobol }
 PathC:PChr=NIL;          { R‚pertoire par d‚faut des sources C/C++ }
 PathBas:PChr=NIL;        { R‚pertoire par d‚faut des sources Basic }
 PathAsm:PChr=NIL;        { R‚pertoire par d‚faut des sourcse Assembleur }
 PathAda:PChr=NIL;        { R‚pertoire par d‚faut des sources Ada }
 PathGat:PChr=NIL;        { R‚pertoire par d‚faut des documents de format GAT }

  {Code de macro d'‚diteur}
 macCtrlRight=#$01;       { Effectue un combinaison de touche ®Ctrl+Right¯ }
 macDecFS=#$02;           { D‚cr‚mentation de la taille du fichier }
 macDecFS2=#$03;          { D‚cr‚mentation de deux de la taille du fichier }
 macDel=#$04;             { Effectue une touche ®Delete¯ }
 macDn=#$05;              { Effectue une touche ®Down¯ }
 macEnd=#$06;             { Effectue une touche ®End¯ }
 macHome=#$07;            { Effectue une touche ®Home¯ }
 macIncFS=#$08;           { Incr‚mentation de la taille du fichier }
 macIncFS2=#$09;          { Incr‚mentation de deux de la taille du fichier }
 macLeft=#$0A;            { Effectue une touche ®Left¯ }
 macPutCurrLn=#$0B;       { Affiche la ligne courante }
 macPXG0=#$0C;            { Initialise … 0 la variable ®PXG¯ }
 macRight=#$0D;           { Effectue une touche ®Right¯ }
 macSetModified=#$0E;     { Fixe le drapeau de modification … VRAI }
 macUp=#$0F;              { Effectue une touche ®Up¯ }
 macUpdateInfo=#$10;      { Mise … jour des informations }
 macUpdateLn=#$11;        { Mise … jour des lignes }
 macUpdateScr=#$12;       { Mise … jour de l'‚cran. }


Type
 SearchDataMode=(sdFind,sdReplace);

 SearchDataRec=Record
  Mode:SearchDataMode;
  Data,NewData:String;
  CaseSensitive,WholeWdOnly,RegularExpression,PromptOnReplace:Boolean;
  Direction:(sdForward,sdBackward);
  Scope:(sdGlobal,sdSelTxt);
  Origin:(sdFromCur,sdEntireScope);
  ChgAll:Boolean;
 End;

 SearchInfo=Record
  Len:Word;
  Last:SearchDataRec;
 End;

IMPLEMENTATION

END.