{\Source\Chantal\Library\System\AppleII\Defs.Inc}

{Nom des programmeurs
 様様様様様様様様様様

  Randy W. Spurlock (30 janvier 1988)
  Sylvain Maltais


 Description
 様様様様様�

  Cette fichier contient les constantes utilis�s par l'APPLE ][ avec micro-
 processeur 65C02 ainsi que la d�finition de �mulateur potentiel pour celui
 ci.
}

Const
 StackSize=$1000;  { D�fintion de la taille de pile de l'�mulateur}
 RamSize=$1000;	   { Taille de la RAM de l'Apple ][ en multiple de 16 (64 Ko)}
 StackTop=$1FF;	   { Valeur par d�faut du top de la pile du 65C02}
 Filler=$0;	   { La valeur d'effaceur d'octet}
 SlotMax=$8;	   { Nombre de slot d'expansion}
 HardwarePage=$C0; { Nombre de page mat�riel}
 PageSize=$100;	   { Taille de page m�moire du 65C02 en octets}

{陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�}
{	 D�finition des adresses de vecteurs d'interruptions du 65C02       }
{陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�}
 IrqVector=$FFFE;  { Adresse du vecteur d'interruption de l'IRQ}
 BrkVector=$FFFE;  { Adresse du vecteur d'interruption du BRK}
 RstVector=$FFFC;  { Adresse du vecteur d'interruption du RESET}
 NmiVector=$FFFA;  { Adresse du vecteur d'interruption du NMI}
 AbtVector=$FFF8;  { Adresse du vecteur d'interruption de l'ABORT}

{陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�}
{    D�finition de l'octet des drapeaux du micro-processeur 65C02           }
{                                                                           }
{  敖堕堕堕堕堕堕堕�                                                        }
{  �7�6�5�4�3�2�1�0�                                                        }
{  逝疎疎疎疎疎疎疎�                                                        }
{   � � � � � � � 青> Drapeau de retenu (0 = Pas retenu, 1 = retenu)        }
{   � � � � � � 青陳> Drapeau de mode (0 = Binaire, 1 = Decimal [BCD])      }
{   � � � � � 青陳陳> Drapeau d'interruption (0=Pas masquable, 1=Masquable) }
{   � � � � 青陳陳陳> Drapeau d�bordement (0=Pas d�bordement, 1=d�borde)    }
{   � � � 青陳陳陳陳> Drapeau d'arr�t (0 = Mat�riel, 1 = Logiciel)          }
{   � � 青陳陳陳陳陳> Drapeau r�serv� (Utilis� pour l'�mulation d'arr�t)    }
{   � 青陳陳陳陳陳陳> Drapeau de z�ro (0 = Pas z�ro, 1 =z�ro)               }
{   青陳陳陳陳陳陳陳> Drapeau de n�gatif (0 = Positif, 1 = Negatif)         }
{陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�}
 CpuC=$01;	   { Drapeau de retenue du CPU (carry)}
 CpuM=$02;	   { Drapeau de mode du CPU}
 CpuI=$04;	   { Drapeau d'interruption inactive du CPU}
 CpuV=$08;	   { Drapeau de d�bordement du CPU (overflow)}
 CpuB=$10;	   { Drapeau d'arr�t du CPU (break)}
 CpuR=$20;	   { Drapeau r�serv� du CPU }
 CpuZ=$40;	   { Drapeau de z�ro du CPU}
 CpuN=$80;	   { Drapeau de n�gatif du CPU}

{陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�}
{    D�finition de l'octet des drapeaux du syst�me Apple ][                 }
{                                                                           }
{  敖堕堕堕堕堕堕堕�                                                        }
{  �7�6�5�4�3�2�1�0�                                                        }
{  逝疎疎疎疎疎疎疎�                                                        }
{   � � � � � � � 青陳陳�> Type vid�o (0 = CGA, 1 = EGA)                    }
{   � � � � � � 青陳陳陳�> Type de moniteur (0 = CGA, 1 = EGA)              }
{   � � � � � 青陳陳陳陳�> �tat d'interruption (0 = Normal, 1 = Rafistol�)  }
{   � � � � 青陳陳陳陳陳�> �tat vid�o (0 = Normal, 1 = Initialis�e)         }
{   � � � 青陳陳陳陳陳陳�> �tat clavier (0 = Normal, 1 = Entr�e)            }
{   � � 青陳陳陳陳陳陳陳�> ***** R�serv� *****                              }
{   � 青陳陳陳陳陳陳陳陳�> ***** R�serv� *****                              }
{   青陳陳陳陳陳陳陳陳陳�> ***** R�serv� *****                              }
{陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�}
 EgaType=$01;	   { Syst�me vid�o de type EGA}
 EgaDisplay=$02;   { Type de moniteur de type EGA}
 Patched=$04;	   { Les interruptions ont besoin d'un rebricolage}
 Initialized=$08;  { La video a besoin d'initialisation}
 Input=$10;	   { Le clavier est en mode entr�e}

{陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�}
{    D�finition de l'octet des drapeaux du syst�me vid�o                    }
{                                                                           }
{  敖堕堕堕堕堕堕堕�                                                        }
{  �7�6�5�4�3�2�1�0�                                                        }
{  逝疎疎疎疎疎疎疎�                                                        }
{   � � � � � � � 青陳陳�> Mode vid�o	  (0 = Texte,  1 = Graphiques)      }
{   � � � � � � 青陳陳陳�> Num�ro de page (0 = Page 1, 1 = Page 2)          }
{   � � � � � 青陳陳陳陳�> R�solution	  (0 = Basse,  1 = Haute)           }
{   � � � � 青陳陳陳陳陳�> Mixage de Mode (0 = Normal, 1 = Mixage)          }
{   � � � 青陳陳陳陳陳陳�> Mode vid�o     (1 = Texte,  0 = Graphiques)      }
{   � � 青陳陳陳陳陳陳陳�> Num�ro de page (1 = Page 1, 0 = Page 2)          }
{   � 青陳陳陳陳陳陳陳陳�> R�solution	  (1 = Basse,  0 = Haute)           }
{   青陳陳陳陳陳陳陳陳陳�> Mixage de Mode (1 = Normal, 0 = Mixage)          }
{陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�}
 VideoMode=$01;		{ Drapeau de bit de test du mode vid�o}
 PageNumber=$02;	{ Drapeau de bit de test du nombre de page}
 Resolution=$04;	{ Drapeau de bit de test de la r�solution}
 MixedMode=$08;		{ Drapeau de bit de test du mixage de mode}
 VideoInv=$10;		{ Drapeau invers� de bit de test du mode vid�o}
 PageInv=$20;		{ Drapeau invers� de bit de test du nombre de page}
 ResInv=$40;		{ Drapeau invers� de bit de test de la r�solution}
 MixedInv=$80;		{ Drapeau invers� de bit de test du mixage de mode}

{陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�}
{    D�finition de l'octet des drapeaux d'�mulation syst�me                 }
{                                                                           }
{  敖堕堕堕堕堕堕堕�                                                        }
{  �7�6�5�4�3�2�1�0�                                                        }
{  逝疎疎疎疎疎疎疎�                                                        }
{   � � � � � � � 青陳陳�> R�qu�te du syst�me en cours                      }
{   � � � � � � 青陳陳陳�> R�initialisation d'interruption syst�me en cours }
{   � � � � � 青陳陳陳陳�> ***** R�serv� ***** (maquette d'interruption)    }
{   � � � � 青陳陳陳陳陳�> ***** R�serv� ***** (maquette d'interruption)    }
{   � � � 青陳陳陳陳陳陳�> ***** R�serv� ***** (maquette d'interruption)    }
{   � � 青陳陳陳陳陳陳陳�> ***** R�serv� ***** (maquette d'interruption)    }
{   � 青陳陳陳陳陳陳陳陳�> ***** R�serv� ***** (maquette d'interruption)    }
{   青陳陳陳陳陳陳陳陳陳�> ***** R�serv� ***** (maquette d'interruption)    }
{陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�}
 SysRequest=$01;	{ Interruption de requ�te du syst�me}
 SysReset=$02;		{ R�initialisation d'interruption syst�me en cours}
 IntRequest=$FF;	{ Teste pour n'importe quel interrutpion en cours}

{陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�}
{    D�finition de l'octet des drapeaux de la carte de langage              }
{                                                                           }
{  敖堕堕堕堕堕堕堕�                                                        }
{  �7�6�5�4�3�2�1�0�                                                        }
{  逝疎疎疎疎疎疎疎�                                                        }
{   � � � � � � � 青陳陳�> �criture active                                  }
{   � � � � � � 青陳陳陳�> ***** R�serv� *****                              }
{   � � � � � 青陳陳陳陳�> ***** R�serv� *****                              }
{   � � � � 青陳陳陳陳陳�> ***** R�serv� *****                              }
{   � � � 青陳陳陳陳陳陳�> ***** R�serv� *****                              }
{   � � 青陳陳陳陳陳陳陳�> ***** R�serv� *****                              }
{   � 青陳陳陳陳陳陳陳陳�> ***** R�serv� *****                              }
{   青陳陳陳陳陳陳陳陳陳�> Lecture active (Langage en RAM)                  }
{陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�}
 WriteEnable=$01;	{ Drapeau d'�criture activ� de la carte de langage}
 ReadEnable=$80;	{ Drapeau de lecture activ� de la carte de langage}

{陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�}
{    D�finition de l'octet des drapeaux des unit�s disquettes               }
{                                                                           }
{  敖堕堕堕堕堕堕堕�                                                        }
{  �7�6�5�4�3�2�1�0�                                                        }
{  逝疎疎疎疎疎疎疎�                                                        }
{   � � � � � � � 青�> Type de disquette (0 = 16, 1 = 13)                   }
{   � � � � � � 青陳�> Protection en �criture (0 = �crivablek, 1 = Prot�g�) }
{   � � � � � 青陳陳�> Disquette pr�sente (0 = Pas disque, 1 = pr�sent)     }
{   � � � � 青陳陳陳�> �tat du moteur (0 = �teint, 1 = allumer)             }
{   � � � 青陳陳陳陳�> Mode de contr�le mode (0 = Entr�e, 1 = Sortie)       }
{   � � 青陳陳陳陳陳�> Piste modifi� (0 = Non-modifi�, 1 = Modifi�)         }
{   � 青陳陳陳陳陳陳�> Tampon valide (0 = Invalide, 1 = Valide)             }
{   青陳陳陳陳陳陳陳�> ***** R�serv� *****                                  }
{陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�}
 OldStyle=$01;		{ Drapeau de vieux type de disque (13 Sectors par piste)}
 WriteProtect=$02;	{ Drapeau de protection contre l'�criture}
 DiskPresent=$04;	{ Drapeau de disque pr�sent}
 MotorOn=$08;		{ Drapeau du moteur de l'unit� disquette allum�}
 OutputMode=$10;	{ Drapeau du mode de contr�le}
 TrackModified=$20;	{ Drapeau de modification de piste de l'unit� disquette}
 BufferValid=$40;	{ Drapeau de validation du tampon de la piste du disque}

{陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�}
{    D�finition de l'octet des drapeaux des �tats du clavier                }
{                                                                           }
{  敖堕堕堕堕堕堕堕�                                                        }
{  �7�6�5�4�3�2�1�0�                                                        }
{  逝疎疎疎疎疎疎疎�                                                        }
{   � � � � � � � 青陳�> �tat de la touche Shift (0 = rel�ch�, 1 = Enfonc�) }
{   � � � � � � 青陳陳�> �tat de la touche Ctrl (0 = rel�ch�, 1 = Enfonc�)  }
{   � � � � � 青陳陳陳�> �tat de la touche Alt (0 = rel�ch�, 1 = Enfonc�)   }
{   � � � � 青陳陳陳陳�> ***** Reserv� *****                                }
{   � � � 青陳陳陳陳陳�> ***** Reserv� *****                                }
{   � � 青陳陳陳陳陳陳�> �tat de la touche ScrollLock (1 = Barr�/actif)     }
{   � 青陳陳陳陳陳陳陳�> �tat de la touche NumLock (1 = Barr�/actif)        }
{   青陳陳陳陳陳陳陳陳�> �tat de la touche CapsLock (1 = Barr�/actif)       }
{陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�}
 ScrollLocked=$20;	   { ScrollLock actif (Mode de mise � jour sp�cial)}
 TypeSpecial=ScrollLocked; { Special update mode in effect}
 NumLocked=$40;		   { NumLock actif (mode manette de jeux)}
 JoyMode=NumLocked;	   { Mode manette de jeux actif}
 CapsLocked=$80;	   { CapsLock actif (Tous en majuscules)}
 Shifted=$01;		   { L'�tat de la touche Shift est enfonc�}
 Ctrled=$02;	  	   { L'�tat de la touche Ctrl est enfonc�}
 Alted=$04;	 	   { L'�tat de la touche Alt est enfonc�}
 Affected=CapsLocked;      { Affectation de l'�tat du CapsLock}
 NotAffected=$00;	   { Pas de d'affectation de l'�tat du CapsLock}

{陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�}
{	D�finition de couleur CGA                                           }
{                                                                           }
{	Num�ro couleur          Nom de la couleur                           }
{	様様様様様様�           様様様様様様様様�                           }
{	     0			Noir                                        }
{	     1			Bleu                                        }
{	     2			Vert                                        }
{	     3			Cyan                                        }
{	     4			Rouge                                       }
{	     5			Magenta                                     }
{	     6			Brun                                        }
{	     7			Blanc                                       }
{	     8			Gris                                        }
{	     9			Bleu clair                                  }
{	     A			Vert clair                                  }
{	     B			Cyan clair                                  }
{	     C			Rouge clair                                 }
{	     D			Magenta clair                               }
{	     E			Jaune                                       }
{	     F			Blanc gras                                  }
{陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�}
 Black=$00;	   { Couleur 00h - Noire}
 Blue=$01;	   { Couleur 01h - Bleu}
 Green=$02;	   { Couleur 02h - Vert}
 Cyan=$03;	   { Couleur 03h - Cyan}
 Red=$04;	   { Couleur 04h - Rouge}
 Magenta=$05;	   { Couleur 05h - Magenta}
 Brown=$06;	   { Couleur 06h - Brun}
 White=$07;	   { Couleur 07h - Blanc}
 Gray=$08;	   { Couleur 08h - Gris}
 LightBlue=$09;	   { Couleur 09h - Bleu clair}
 LightGreen=$0A;   { Couleur 0Ah - Vert clair}
 LightCyan=$0B;	   { Couleur 0Bh - Cyan clair}
 LightRed=$0C;	   { Couleur 0Ch - Rouge clair}
 LightMagenta=$0D; { Couleur 0Dh - Magenta clair}
 Yellow=$0E;	   { Couleur 0Eh - Jaune}
 IntenseWhite=$0F; { Couleur 0Fh - Blanc gras}

{陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�}
{       D�finition des valeurs des caract�res ASCII                         }
{陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�}
 Null=$00;	{ Code ASCII pour le nul}
 Bell=$07;	{ Code ASCII pour un "beep" }
 BS=$08;	{ Code ASCII pour le BackSpace}
 HT=$09;	{ Code ASCII pour la tabulation horizontal}
 LF=$0A;	{ Code ASCII pour le changement de ligne}
 VT=$0B;	{ Code ASCII pour la tabulation vertical}
 FF=$0C;	{ Code ASCII pour le changement de page/efface l'�cran}
 CR=$0D;	{ Code ASCII pour le retour de chariot}
 Space=' ';     { Caract�re d'espace}
 Comma=',';     { Caract�re de virgule}
 SemiColon=';'; { Caract�re de point-virgule}
 Plus='+';      { Caract�re de signe de plus}
 Minus='-';     { Caract�re de signe de moins}
 Equal='=';     { Caract�re de signe d'�galit�}
 Asterisk='*';  { Caract�re d'asterisque}
 Point='.';     { Caract�re de point d�cimal}
 Period='.';    { Caract�re de point}
 Slash='/';     { Caract�re de barre oblique}
 BackSlash='\'; { Caract�re de barre oblique invers�}
