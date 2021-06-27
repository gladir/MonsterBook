'D‚monstrateur de Menu
'Tous droits r‚serv‚s par les Chevaliers de Malte
'Programmeur: Sylvain Maltais
'SCREEN LUXE
Menu "^F^ichier"
 Item "^O^uvre",&HF000,0,"Ouvre quelque chose..."
 Item "^S^auve",&HF001
 Item "^Q^uitter",&HF002,11520,"C'est la sortie!"
Menu "^R^echerche"
Menu "^C^ommande"
Menu "^O^ption"
Menu "F^e^netre"
Menu "^I^nfo"
Menu "^A^ide"
FillBox(0,0)-(WIDTH-1,NUMYTEXTS-1),&H19,CHR$(29)
View Menu
K%=ReadKey
