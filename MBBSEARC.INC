{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                                                                  �
 �  Malte Genesis - Bureautique/Module de Recherche pour l'릁iteur  �
 �          Edition Chantal pour Mode R괻l/IV - Version 1.0;        �
 �            Edition Ad둳e pour Mode R괻l/V - Version 1.0          �
 �                             1997/01/01                           �
 �                                                                  �
 �        Tous droits r굎erv굎 par les Chevaliers de Malte (C)      �
 �                                                                  �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Description
 袴袴袴袴袴�

  Cette unit� contient les proc괺ures et fonctions pour la recherche,
 remplacement  et les bo똳es de dialogues � cette effet pour un texte
 d'objet 췊ditorApp� ainsi que celle de 췝iewAscii�.
}

Unit MBBSearc;

{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}
                                INTERFACE
{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}

{$DEFINE BureauVersion}
{$DEFINE Bureau}

{$I MBSearch.Inc}

{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}
BEGIN
 System.FillChar(LastSearch,SizeOf(LastSearch),0);
END.