{Style.Inc}

{$IFNDEF __Style}
 {$DEFINE __Style}

Type
  { Type de d�claration pour la face de param�tre �TextFace� }
 StyleItem=(bold,italic,underline,outline,shadow,condense,extend);
 Style=Set Of StyleItem;

{$ENDIF}