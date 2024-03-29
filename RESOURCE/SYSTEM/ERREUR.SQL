CREATE TABLE Erreur (
   ID       WORD PRIMARY KEY,
   MessageF VARCHAR
);

CREATE INDEX;

INSERT INTO Erreur VALUES (0x0000,'Aucune erreur n''est apparue');
INSERT INTO Erreur VALUES (0x0001,'Num�ro de fonction invalide');
INSERT INTO Erreur VALUES (0x0002,'Fichier introuvable');
INSERT INTO Erreur VALUES (0x0003,'Chemin introuvable');
INSERT INTO Erreur VALUES (0x0004,'Trop de fichiers ouverts simultan�ment');
INSERT INTO Erreur VALUES (0x0005,'Acc�s refus�');
INSERT INTO Erreur VALUES (0x0006,'Handle inconnu');
INSERT INTO Erreur VALUES (0x0007,'Bloc de contr�le de la m�moire d�truit');
INSERT INTO Erreur VALUES (0x0008,'M�moire disponible insuffisante');
INSERT INTO Erreur VALUES (0x0009,'Adresse de m�moire incorrecte');
INSERT INTO Erreur VALUES (0x000A,'Environnement incorrecte');
INSERT INTO Erreur VALUES (0x000B,'Format invalide');
INSERT INTO Erreur VALUES (0x000C,'Code d''acc�s incorrecte');
INSERT INTO Erreur VALUES (0x000D,'Donn�es incorrecte');
INSERT INTO Erreur VALUES (0x000F,'Lecteur (unit�) inconnu');
INSERT INTO Erreur VALUES (0x0010,'Tentative de destruction du r�pertoire courant');
INSERT INTO Erreur VALUES (0x0011,'P�riph�riques diff�rentes');
INSERT INTO Erreur VALUES (0x0012,'Plus d''autre fichier');
INSERT INTO Erreur VALUES (0x0013,'Support prot�g� contre l''�criture');
INSERT INTO Erreur VALUES (0x0014,'P�riph�rique inconnu');
INSERT INTO Erreur VALUES (0x0015,'P�riph�rique pas pr�te');
INSERT INTO Erreur VALUES (0x0016,'Instruction inconnue');
INSERT INTO Erreur VALUES (0x0017,'Erreur CRC');
INSERT INTO Erreur VALUES (0x0018,'Largeur de donn�es incorrecte');
INSERT INTO Erreur VALUES (0x0019,'Recherche infructueuse');
INSERT INTO Erreur VALUES (0x001A,'Type de p�riph�rique inconnu');
INSERT INTO Erreur VALUES (0x001B,'Secteur introuvable');
INSERT INTO Erreur VALUES (0x001C,'Imprimante: Plus de papier');
INSERT INTO Erreur VALUES (0x001D,'Erreur d''�criture');
INSERT INTO Erreur VALUES (0x001E,'Erreur de lecture');
INSERT INTO Erreur VALUES (0x001F,'Erreur g�n�rale');
INSERT INTO Erreur VALUES (0x0020,'Erreur de partage de ressource');
INSERT INTO Erreur VALUES (0x0021,'Violation du verrouillage');
INSERT INTO Erreur VALUES (0x0022,'Changement de disque invalide');
INSERT INTO Erreur VALUES (0x0023,'FCB non disponible');
INSERT INTO Erreur VALUES (0x0024,'D�passement du tampon des ressources');
INSERT INTO Erreur VALUES (0x0025,'Pays: Code de page invalide');
INSERT INTO Erreur VALUES (0x0026,'Impossible de compl�ter l''op�ration fichier (manque d''entr�e)');
INSERT INTO Erreur VALUES (0x0027,'Espace disque insuffisant');
INSERT INTO Erreur VALUES (0x0032,'R�seau: Appel r�seau insupportable');
INSERT INTO Erreur VALUES (0x0033,'R�seau: Ordinateur distant ne r�pondant pas');
INSERT INTO Erreur VALUES (0x0034,'R�seau: Duplication du nom dans le r�seau');
INSERT INTO Erreur VALUES (0x0035,'R�seau: Nom du r�seau introuvable');
INSERT INTO Erreur VALUES (0x0036,'R�seau: R�seau occup�');
INSERT INTO Erreur VALUES (0x0037,'R�seau: P�riph�rique r�seau inexistante');
INSERT INTO Erreur VALUES (0x0038,'R�seau: Commande Bios r�seau trop grande');
INSERT INTO Erreur VALUES (0x0039,'R�seau: Erreur mat�rielle de l''adapteur r�seau');
INSERT INTO Erreur VALUES (0x003A,'R�seau: R�ponse invalide du r�seau');
INSERT INTO Erreur VALUES (0x003B,'R�seau: Erreur inattendue du r�seau');
INSERT INTO Erreur VALUES (0x003C,'R�seau: Adapteur incompatible');
INSERT INTO Erreur VALUES (0x003D,'Queue d''impression pleine');
INSERT INTO Erreur VALUES (0x003E,'Queue d''impression encore pleine');
INSERT INTO Erreur VALUES (0x003F,'Fichier d''impression effac�');
INSERT INTO Erreur VALUES (0x0040,'R�seau: Nom de r�seau effac�');
INSERT INTO Erreur VALUES (0x0041,'R�seau: Acc�s refus�');
INSERT INTO Erreur VALUES (0x0042,'R�seau: Type de p�riph�rique r�seau incorrecte');
INSERT INTO Erreur VALUES (0x0043,'R�seau: Nom de r�seau introuvable');
INSERT INTO Erreur VALUES (0x0044,'R�seau: Nom de r�seau trop grand');
INSERT INTO Erreur VALUES (0x0045,'R�seau: Session de Bios r�seau trop grand');
INSERT INTO Erreur VALUES (0x0046,'R�seau: Arr�t temporaire');
INSERT INTO Erreur VALUES (0x0047,'R�seau: Appel r�seau introuvable');
INSERT INTO Erreur VALUES (0x0048,'R�seau: Arr�t d''impression ou de redirection');
INSERT INTO Erreur VALUES (0x0049,'R�seau: Logiciel r�seau non install�/Version r�seau invalide');
INSERT INTO Erreur VALUES (0x004A,'R�seau: Adapteur ferm� inattendu/Extimation expir�');
INSERT INTO Erreur VALUES (0x004B,'R�seau: Mot de passe expir�');
INSERT INTO Erreur VALUES (0x004C,'R�seau: Tentative de branchement invalide en ce moment');
INSERT INTO Erreur VALUES (0x004D,'R�seau: Exc�de la limite disque dans la station de travail');
INSERT INTO Erreur VALUES (0x004E,'R�seau: Pas de branchement dans la station de travail');
INSERT INTO Erreur VALUES (0x0050,'Fichier d�j� existant');
INSERT INTO Erreur VALUES (0x0052,'Impossible de cr�er un r�pertoire');
INSERT INTO Erreur VALUES (0x0053,'Erreur sur Interruption 24h (Erreur critique)');
INSERT INTO Erreur VALUES (0x0054,'Hors structure (trop de redirections)');
INSERT INTO Erreur VALUES (0x0055,'Redirection dupliqu�e');
INSERT INTO Erreur VALUES (0x0056,'Mot de passe invalide');
INSERT INTO Erreur VALUES (0x0057,'Param�tre invalide');
INSERT INTO Erreur VALUES (0x0058,'R�seau: Erreur d''�criture sur une p�riph�rique r�seau');
INSERT INTO Erreur VALUES (0x0059,'R�seau: Fonction non support� par le r�seau');
INSERT INTO Erreur VALUES (0x005A,'R�seau: Les composants syst�me requis ne sont pas install�');
INSERT INTO Erreur VALUES (0x0064,'CD-ROM: Erreur totalement inconnu');
INSERT INTO Erreur VALUES (0x0065,'CD-ROM: Pas pr�t');
INSERT INTO Erreur VALUES (0x0066,'CD-ROM: La m�moire EMS n''est pas d''une longueur valide');
INSERT INTO Erreur VALUES (0x0067,'CD-ROM: Le format CD-ROM n''est pas High Sierra ou ISO-9660');
INSERT INTO Erreur VALUES (0x0068,'CD-ROM: La porte est ouverte');
INSERT INTO Erreur VALUES (0x0080,'EMS: Erreur interne dans l''EMM (peut indiquer une image m�moire incorrecte dans le pilote)');
INSERT INTO Erreur VALUES (0x0081,'EMS: Mauvais fonctionnement dans la partie mat�rielle de la m�moire �tendue');
INSERT INTO Erreur VALUES (0x0082,'EMS: EMM occup�');
INSERT INTO Erreur VALUES (0x0083,'EMS: Handle invalide');
INSERT INTO Erreur VALUES (0x0084,'EMS: Fonction ind�finie');
INSERT INTO Erreur VALUES (0x0085,'EMS: Les handles sont �puis�s');
INSERT INTO Erreur VALUES (0x0086,'EMS: Erreur dans la sauvegarde ou la restitution de la pagination');
INSERT INTO Erreur VALUES (0x0087,'EMS: La demande d''allocation a sp�cifi� plus de pages que celles se trouvant physiquement allou�e');
INSERT INTO Erreur VALUES (0x0088,'EMS: La demande d''allocation a sp�cifi� plus de pages que le nombre disponible. Aucune page n''a �t� allou�e');
INSERT INTO Erreur VALUES (0x0089,'EMS: Aucune page n''a �t� allou�e');
INSERT INTO Erreur VALUES (0x008A,'EMS: La page logique demand�e est en dehors des pages autoris�es par le handle');
INSERT INTO Erreur VALUES (0x008B,'EMS: Page physiquement ill�gale dans la demande de pagination');
INSERT INTO Erreur VALUES (0x008C,'EMS: La zone de sauvegarde de l''�tat mat�riel de page de pagination est plein');
INSERT INTO Erreur VALUES (0x008D,'EMS: La sauvegarde du contexte de pagination a �chou�. La zone de sauvegarde est d�j� remplie');
INSERT INTO Erreur VALUES (0x008E,'EMS: La restitution du contexte de pagination a �chou�. La zone de sauvegarde est vide');
INSERT INTO Erreur VALUES (0x008F,'EMS: Param�tre de sous-fonction non d�fini');
INSERT INTO Erreur VALUES (0x0090,'EMS: Type d''attribut non d�fini');
INSERT INTO Erreur VALUES (0x0091,'EMS: Caract�ristique non support�e');
INSERT INTO Erreur VALUES (0x0092,'EMS: Les m�moires source et destination ont les m�mes handles et se chevauchent. Le d�placement demand� a �t� effectu�, mais une partie de la zone source a �t� �cras�e');
INSERT INTO Erreur VALUES (0x0093,'EMS: La longueur sp�cifi�e de la zone source ou destination sp�cifi�e est sup�rieur � la longueur autoris�e');
INSERT INTO Erreur VALUES (0x0094,'EMS: Une zone de m�moire conventionnelle se trouve � la m�me adresse qu''une zone de m�moire �tendue');
INSERT INTO Erreur VALUES (0x0095,'EMS: Le d�placement sp�cifi� est en dehors de la page logique');
INSERT INTO Erreur VALUES (0x0096,'EMS: Longueur de zone sup�rieure � 1 Mo');
INSERT INTO Erreur VALUES (0x0097,'EMS: Les zones de m�moire source et destination ont les m�mes handles et se chevauchent. L''�change ne peut �tre effectu�');
INSERT INTO Erreur VALUES (0x0098,'EMS: Type des m�moires source et destination non d�fini');
INSERT INTO Erreur VALUES (0x009A,'EMS: La pagination altern� ou l''initialisation de registres altern� ou l''initialisation de registres DMA est support�e, mais l''initialisation du registre altern� sp�cifi� n''est pas possible');
INSERT INTO Erreur VALUES (0x009B,'EMS: La pagination altern� ou l''initialisation de registres DMA est support�e, mais tous les registres altern�s initialis�s sont actuellement allou�s');
INSERT INTO Erreur VALUES (0x009C,'EMS: Les cartes altern�es ou la d�finition de registres DMA n''est pas support�e, et le registre altern� est diff�rent de 0');
INSERT INTO Erreur VALUES (0x009D,'EMS: La pagination altern� ou l''initialisation de registres DMA sont support�s, mais la d�finition du registre DMA sp�cifi� n''est pas d�finie ou autoris�e');
INSERT INTO Erreur VALUES (0x009E,'EMS: Les canaux DMA d�di�s ne sont pas autoris�s');
INSERT INTO Erreur VALUES (0x009F,'EMS: Les canaux DMA d�di�s sont autoris�s, mais le canal DMA sp�cifi� n''est pas autoris�');
INSERT INTO Erreur VALUES (0x00A0,'EMS: Le handle dont le nom est sp�cifi� n''est pas trouv�');
INSERT INTO Erreur VALUES (0x00A1,'EMS: Un handle du m�me nom existe');
INSERT INTO Erreur VALUES (0x00A2,'EMS: Rotation d''adresse m�moire: l''adresse de base d''une zone source ou destination additonn�e � la longueur d�passe 1 Mo');
INSERT INTO Erreur VALUES (0x00A3,'EMS: Un pointeur invalide a �t� pass� � la fonction, ou le contenu d''un tableau source a �t� �cras�');
INSERT INTO Erreur VALUES (0x00A4,'EMS: L''acc�s � la fonction est refus� par le syst�me d''exploitation');
INSERT INTO Erreur VALUES (0x00B0,'XMS: Fonction non impl�ment�e');
INSERT INTO Erreur VALUES (0x00B1,'XMS: Pilote de p�riph�rique VDISK d�tect�');
INSERT INTO Erreur VALUES (0x00B2,'XMS: Erreur A20');
INSERT INTO Erreur VALUES (0x00BE,'XMS: Erreur g�n�rale du pilote XMM');
INSERT INTO Erreur VALUES (0x00BF,'XMS: Erreur fatale');
INSERT INTO Erreur VALUES (0x00C0,'XMS: La m�moire HMA n''existe pas');
INSERT INTO Erreur VALUES (0x00C1,'XMS: La m�moire HMA est en cours d''utilisation');
INSERT INTO Erreur VALUES (0x00C2,'XMS: DX inf�rieur � /HMAMIN=param�tre');
INSERT INTO Erreur VALUES (0x00C3,'XMS: M�moire HMA non allou�e');
INSERT INTO Erreur VALUES (0x00C4,'XMS: Ligne A20 toujours valid�e');
INSERT INTO Erreur VALUES (0x00D0,'XMS: Toute la m�moire �tendue est allou�e');
INSERT INTO Erreur VALUES (0x00D1,'XMS: Plus de handles EMM');
INSERT INTO Erreur VALUES (0x00D2,'XMS: Handle invalide');
INSERT INTO Erreur VALUES (0x00D3,'XMS: Handle source invalide');
INSERT INTO Erreur VALUES (0x00D4,'XMS: D�placement source invalide');
INSERT INTO Erreur VALUES (0x00D5,'XMS: Handle destination invalide');
INSERT INTO Erreur VALUES (0x00D6,'XMS: D�placement de destination invalide');
INSERT INTO Erreur VALUES (0x00D7,'XMS: Longueur invalide');
INSERT INTO Erreur VALUES (0x00D8,'XMS: Recouvrement invalide dans une requ�te MOVE');
INSERT INTO Erreur VALUES (0x00D9,'XMS: Erreur de parit�');
INSERT INTO Erreur VALUES (0x00DA,'XMS: Bloc non verrouill�');
INSERT INTO Erreur VALUES (0x00DB,'XMS: Bloc verrouill�');
INSERT INTO Erreur VALUES (0x00DC,'XMS: D�passement dans le compteur de verrou');
INSERT INTO Erreur VALUES (0x00DD,'XMS: Erreur de verrou');
INSERT INTO Erreur VALUES (0x00E0,'XMS: Plus petit UMB disponible');
INSERT INTO Erreur VALUES (0x00E1,'XMS: Aucun UMB n''est disponible');
INSERT INTO Erreur VALUES (0x00E2,'XMS: Num�ro de segement UMB invalide');
INSERT INTO Erreur VALUES (0x00FE,'Erreur de cr�ation de fichier');
INSERT INTO Erreur VALUES (0x00FF,'Fin de fichier d�j� atteint');
INSERT INTO Erreur VALUES (0x0101,'Erreur interne RLL');
INSERT INTO Erreur VALUES (0x0102,'Manque de m�moire lors d''une allocation de fonction RLL');
INSERT INTO Erreur VALUES (0x0103,'Lib�ration interdite de m�moire en zone inf�rieur du tas');
INSERT INTO Erreur VALUES (0x0104,'Erreur d''allocation dans la lib�ration du tas');
INSERT INTO Erreur VALUES (0x0120,'L''imprimante n''est pas pr�te');
INSERT INTO Erreur VALUES (0x0121,'Ressource M�moire: Tentative de lib�ration d''une m�moire inexistante');
INSERT INTO Erreur VALUES (0x0122,'Ressource M�moire: Tentative de lecture dans une m�moire inexistante');
INSERT INTO Erreur VALUES (0x0123,'Ressource M�moire: Tentative d''�criture dans une m�moire inexistante');
INSERT INTO Erreur VALUES (0x0124,'Ressource M�moire: Tentative de d�placement du pointeur de tas dans une m�moire inexistante');
INSERT INTO Erreur VALUES (0x0125,'Ressource M�moire: Tentative de lecture du pointeur de tas dans une m�moire inexistante');
INSERT INTO Erreur VALUES (0x0126,'Ressource M�moire: Tentative de lecture dans une zone de m�moire en �criture');
INSERT INTO Erreur VALUES (0x0127,'Ressource M�moire: Tentative d''utilisation d''un Handle inexistant');
INSERT INTO Erreur VALUES (0x0128,'Ressource M�moire: Tentative d''�criture dans une zone de m�moire en lecture');
INSERT INTO Erreur VALUES (0x012D,'Teste de d�marrage: Le clavier ne r�pond pas � l''initialisation logiciel ou ne r�agit pas');
INSERT INTO Erreur VALUES (0x012E,'Teste de d�marrage: L''utilisation syst�me indique un erreur clavier ou l''unit� syst�me est verrouill�');
INSERT INTO Erreur VALUES (0x012F,'Teste de d�marrage: Clavier ou erreur de la carte m�re');
INSERT INTO Erreur VALUES (0x0130,'Teste de d�marrage: Le CMOS ne correspond pas au syst�me');
INSERT INTO Erreur VALUES (0x0131,'Vid�o: Impossible de cr�er un tampon pour le curseur');
INSERT INTO Erreur VALUES (0x0132,'Vid�o: Impossible de charger les fonctions en m�moire');
INSERT INTO Erreur VALUES (0x0133,'Vid�o: Syst�me vid�o non-initialis�');
INSERT INTO Erreur VALUES (0x0134,'Vid�o: Fichier de palette introuvable');
INSERT INTO Erreur VALUES (0x0135,'Vid�o: Impossible de charger la police en m�moire');
INSERT INTO Erreur VALUES (0x0141,'Fen�tre Primitive: Impossible d''effectuer un sauvegarde de l''arri�re plan en mode graphique');
INSERT INTO Erreur VALUES (0x0142,'Fen�tre Primitive: Impossible d''effectuer un sauvegarde de l''arri�re plan en mode texte');
INSERT INTO Erreur VALUES (0x0151,'Traitement de donn�e: Erreur de syntaxe');
INSERT INTO Erreur VALUES (0x0152,'Traitement de donn�e: Retour sans avoir �t� appell�');
INSERT INTO Erreur VALUES (0x0153,'Traitement de donn�e: Fin de donn�es');
INSERT INTO Erreur VALUES (0x0154,'Traitement de donn�e: Appel de fonction interdite');
INSERT INTO Erreur VALUES (0x0155,'Teste de d�marrage: Remplacer le clavier');
INSERT INTO Erreur VALUES (0x0156,'Teste de d�marrage: Remplacer le c�ble de l''interface du clavier');
INSERT INTO Erreur VALUES (0x0157,'Teste de d�marrage: Remplacer la carte d''extension ou le c�ble du clavier');
INSERT INTO Erreur VALUES (0x0158,'Traitement de donn�e: Indice inf�rieur incorrecte');
INSERT INTO Erreur VALUES (0x0159,'Traitement de donn�e: Tentative de modifi� la taille d''un format fixe');
INSERT INTO Erreur VALUES (0x015A,'Traitement de donn�e: Division par 0');
INSERT INTO Erreur VALUES (0x015B,'Traitement de donn�e: Instruction directe interdite');
INSERT INTO Erreur VALUES (0x015C,'Traitement de donn�e: Type de donn�e incompatible');
INSERT INTO Erreur VALUES (0x015D,'Traitement de donn�e: Fin de l''espace du cha�ne de texte Pascal');
INSERT INTO Erreur VALUES (0x015E,'Traitement de donn�e: Cha�ne trop longue');
INSERT INTO Erreur VALUES (0x015F,'Traitement de donn�e: Formule trop complexe');
INSERT INTO Erreur VALUES (0x0160,'Traitement de donn�e: Impossible de poursuivre les m�canismes');
INSERT INTO Erreur VALUES (0x0161,'Traitement de donn�e: Donn�e de fichier erron�');
INSERT INTO Erreur VALUES (0x0162,'Traitement de donn�e: Op�ration d�j� en cours');
INSERT INTO Erreur VALUES (0x0163,'Traitement de donn�e: Erreur de num�ro de dispositif');
INSERT INTO Erreur VALUES (0x0164,'Traitement de donn�e: Erreur d''entr�e/sortie');
INSERT INTO Erreur VALUES (0x0165,'Traitement de donn�e: Traitement de donn�e inad�quoit');
INSERT INTO Erreur VALUES (0x0166,'Traitement de donn�e: Traitement d''op�ration dans un ordre illogique');
INSERT INTO Erreur VALUES (0x0167,'Traitement de donn�e: Manque de m�moire');
INSERT INTO Erreur VALUES (0x0168,'Traitement de donn�e: D�passement de capacit�');
INSERT INTO Erreur VALUES (0x0169,'Traitement de donn�e: Param�tre inconnue');
INSERT INTO Erreur VALUES (0x016D,'Teste de d�marrage: Remplacer le clavier');
INSERT INTO Erreur VALUES (0x016E,'Teste de d�marrage: Remplacer le c�ble de l''interface clavier');
INSERT INTO Erreur VALUES (0x016F,'Teste de d�marrage: Remplacer la carte d''extension ou le c�ble clavier');
INSERT INTO Erreur VALUES (0x0170,'Mot de passe invalide');
INSERT INTO Erreur VALUES (0x0171,'�diteur: Fichier introuvable/impossible d''ouvrir le fichier texte');
INSERT INTO Erreur VALUES (0x0172,'�diteur: Erreur de lecture de la taille du fichier');
INSERT INTO Erreur VALUES (0x0173,'�diteur: Erreur de lecture du fichier texte');
INSERT INTO Erreur VALUES (0x0174,'�diteur: Fichier trop gros pour �tre charg� en m�moire');
INSERT INTO Erreur VALUES (0x0175,'Erreur d''�criture du Journal de Bord');
INSERT INTO Erreur VALUES (0x0176,'Nombre de ligne insuffisant pour effectuer un tri');
INSERT INTO Erreur VALUES (0x0177,'Num�ro de page invalide');
INSERT INTO Erreur VALUES (0x0178,'Num�ro de page inexistant');
INSERT INTO Erreur VALUES (0x0179,'Erreur dans l''�change d''information');
INSERT INTO Erreur VALUES (0x017A,'Marge gauche et droite non d�fini');
INSERT INTO Erreur VALUES (0x0191,'Teste de d�marrage: �chec de la m�moire vid�o, du teste de la fr�quence horizontal ou vid�o du syst�me monochrome');
INSERT INTO Erreur VALUES (0x0198,'Teste de d�marrage: L''utilisateur indique que l''affichage des attributs vid�o �choue sur le syst�me monochrome');
INSERT INTO Erreur VALUES (0x0301,'APM: Fonction d�sactiv�');
INSERT INTO Erreur VALUES (0x0302,'APM: Interface d�j� dans le processus');
INSERT INTO Erreur VALUES (0x0303,'APM: Interface d�connect�');
INSERT INTO Erreur VALUES (0x0305,'APM: Mode 16-bits d''interface d�j� �tablie');
INSERT INTO Erreur VALUES (0x0309,'APM: Identificateur non reconnu');
INSERT INTO Erreur VALUES (0x0360,'APM: Incapable d''entr�e dans la requ�te demand�');
INSERT INTO Erreur VALUES (0x03FF,'Probl�me avec ce mode');
INSERT INTO Erreur VALUES (0x0FFA,'Trop de fichier ouvert simultan�ment');
INSERT INTO Erreur VALUES (0x0FFB,'Fichier ou r�pertoire d�j� effac�');
INSERT INTO Erreur VALUES (0x0FFC,'Impossible de monter le volume');
INSERT INTO Erreur VALUES (0x0FFD,'Impossible de modifier l''attribut de cette entr�e');
INSERT INTO Erreur VALUES (0x0FFE,'Impossible de modifier l''attribut du fichier');
INSERT INTO Erreur VALUES (0x0FFF,'Destination de copie invalide');
INSERT INTO Erreur VALUES (0x1000,'Impossible de renommer le nom de votre fichier');
INSERT INTO Erreur VALUES (0x1001,'Impossible de renommer le volume');
INSERT INTO Erreur VALUES (0x1002,'Source � imprimer non d�finit');
INSERT INTO Erreur VALUES (0x1003,'Information sur le pays non disponible');
INSERT INTO Erreur VALUES (0x1004,'Impossible de changer de pays! Seul l''application sera affect�');
INSERT INTO Erreur VALUES (0x1005,'Manque de ressource');
INSERT INTO Erreur VALUES (0x1101,'Probl�me d''ajustement du contr�leur clavier');
INSERT INTO Erreur VALUES (0x1181,'Cette machine ne dispose pas de m�moire sur pile �CMOS�');
INSERT INTO Erreur VALUES (0x1200,'Impossible d''effectuer cette op�ration avec votre mat�riel');
INSERT INTO Erreur VALUES (0x1201,'Une carte de son Sound Blaster minimum est r�clam�');
INSERT INTO Erreur VALUES (0x1202,'Vous n''avez pas de carte de son install�, seulement votre haut-parleur de base mono de votre PC');
INSERT INTO Erreur VALUES (0x1301,'Image du pointeur de souris trop gros');
INSERT INTO Erreur VALUES (0x1302,'Aucune souris d�tect�');
INSERT INTO Erreur VALUES (0x1401,'Disquette prot�g�e contre l''�criture');
INSERT INTO Erreur VALUES (0x1402,'Erreur de piste');
INSERT INTO Erreur VALUES (0x1403,'Une erreur a interrompu le formatage');
INSERT INTO Erreur VALUES (0x1404,'Le format demand� ne peut �tre utilis� sur ce lecteur');
INSERT INTO Erreur VALUES (0x1405,'Cette unit� n''est pas une unit� de disquette');
INSERT INTO Erreur VALUES (0x1406,'D�sol�! Impossible de stationner votre/vos disque(s) dur');
INSERT INTO Erreur VALUES (0x1407,'Disque dur introuvable!');
INSERT INTO Erreur VALUES (0x1408,'Erreur de lecteur en voulant acc�der au secteur de d�marrage!');
INSERT INTO Erreur VALUES (0x1409,'Impossible d''ouvrir le fichier');
INSERT INTO Erreur VALUES (0x1500,'D�sol� votre carte vid�o ne supporte pas le standard VESA');
INSERT INTO Erreur VALUES (0x1501,'Mode vid�o non support�e');
INSERT INTO Erreur VALUES (0x1502,'Aucun mode vid�o ne permet l''affichage d�sirez');
INSERT INTO Erreur VALUES (0x1503,'Taille de l''�cran insuffisante pour l''application demand�');
INSERT INTO Erreur VALUES (0x1504,'Mode graphique requis');
INSERT INTO Erreur VALUES (0x1505,'Ligne d''image trop grande');
INSERT INTO Erreur VALUES (0x1506,'Image � copier vide');
INSERT INTO Erreur VALUES (0x1601,'Cette option est seulement disponible avec les microprocesseurs Cyrix');
INSERT INTO Erreur VALUES (0x2001,'Format de fichier image inconnue');
INSERT INTO Erreur VALUES (0x2002,'Le format d''image de recherche n''a pas �t� trouv�');
INSERT INTO Erreur VALUES (0x2003,'Fichier introuvable');
INSERT INTO Erreur VALUES (0x2004,'Ent�te du fichier invalide pour ce format');
INSERT INTO Erreur VALUES (0x2005,'Ligne trop grande');
INSERT INTO Erreur VALUES (0x2006,'Manque de m�moire');
INSERT INTO Erreur VALUES (0x2007,'L''image n''a pas de suivant');
INSERT INTO Erreur VALUES (0x2008,'Fin manquante');
INSERT INTO Erreur VALUES (0x2009,'Mauvais code de taille');
INSERT INTO Erreur VALUES (0x200A,'Mauvais code');
INSERT INTO Erreur VALUES (0x200B,'Annuler par l''utilisateur');
INSERT INTO Erreur VALUES (0x200C,'Index introuvable');
INSERT INTO Erreur VALUES (0x200D,'Donn�e invalide');
INSERT INTO Erreur VALUES (0x200E,'Taille invalide');
INSERT INTO Erreur VALUES (0x200F,'Impossible de cr�er le fichier');
INSERT INTO Erreur VALUES (0x2010,'Format non support�e');
INSERT INTO Erreur VALUES (0x2011,'Donn�e trop grosse');
INSERT INTO Erreur VALUES (0x2012,'Couleur incompatible');
INSERT INTO Erreur VALUES (0x2013,'Impossible de lire les partitions');
 /* Erreur de compilateur: Message d'erreur */
INSERT INTO Erreur VALUES (10001,''';'' attendu');
INSERT INTO Erreur VALUES (10002,'''{'' attendu');
INSERT INTO Erreur VALUES (10003,'''}'' attendu');
INSERT INTO Erreur VALUES (10004,'''['' attendu');
INSERT INTO Erreur VALUES (10005,''']'' attendu');
INSERT INTO Erreur VALUES (10006,'''('' attendu');
INSERT INTO Erreur VALUES (10007,''')'' attendu');
INSERT INTO Erreur VALUES (10008,'''*'' attendu');
INSERT INTO Erreur VALUES (10009,'Nombre attendu');
INSERT INTO Erreur VALUES (10010,'''>'' attendu');
INSERT INTO Erreur VALUES (10011,'''"'' attendu');
INSERT INTO Erreur VALUES (10012,'''.'' attendu');
INSERT INTO Erreur VALUES (10013,'�num�ration attendu');
INSERT INTO Erreur VALUES (10014,'Nombre de l''instruction �ARRAY� attendu');
INSERT INTO Erreur VALUES (10015,'Fin de fonction attendu');
INSERT INTO Erreur VALUES (10016,'Fin de source attendu');
INSERT INTO Erreur VALUES (10017,'Fin de cha�ne de caract�res attendu');
INSERT INTO Erreur VALUES (10018,'Fin de commentaire attendu');
INSERT INTO Erreur VALUES (10019,'Fin de commande attendu');
INSERT INTO Erreur VALUES (10020,'Fin d''argument attendu');
INSERT INTO Erreur VALUES (10021,'Type de variable attendu');
INSERT INTO Erreur VALUES (10022,'Nom de variable attendu');
INSERT INTO Erreur VALUES (10023,'Directive attendu');
INSERT INTO Erreur VALUES (10024,'Nom de l''instruction �typedef� attendu');
INSERT INTO Erreur VALUES (10025,'Nom de l''inclusion de fichier attendu');
INSERT INTO Erreur VALUES (10026,'Nom de la directive conditionnel �IF� attendu');
INSERT INTO Erreur VALUES (10027,'Nom de la directive conditionnel �IFDEF� attendu');
INSERT INTO Erreur VALUES (10028,'Nom de la directive conditionnel �IFNDEF� attendu');
INSERT INTO Erreur VALUES (10029,'Instruction �WHILE� attendu');
INSERT INTO Erreur VALUES (10030,'Instruction �BEGIN� attendu');
INSERT INTO Erreur VALUES (10031,'Nom attendu');
INSERT INTO Erreur VALUES (10032,'Valeur attendu');
INSERT INTO Erreur VALUES (10033,'Type attendu');
INSERT INTO Erreur VALUES (10034,'Instruction �OF� attendu');
INSERT INTO Erreur VALUES (10035,'�tiquette attendu');
INSERT INTO Erreur VALUES (10036,'Nom de programme attendu');
INSERT INTO Erreur VALUES (10037,'Nom d''unit� attendu');
INSERT INTO Erreur VALUES (10038,'Nom de constante attendu');
INSERT INTO Erreur VALUES (10039,'Instruction �END� attendu');
INSERT INTO Erreur VALUES (10040,''':'' attendu');
INSERT INTO Erreur VALUES (10041,'''='' attendu');
INSERT INTO Erreur VALUES (10042,'�_CF� attendu...');
INSERT INTO Erreur VALUES (10043,'Identificateur attendu');
INSERT INTO Erreur VALUES (10044,'''<'' attendu');
INSERT INTO Erreur VALUES (10045,'''+'' attendu');
INSERT INTO Erreur VALUES (10046,'''-'' attendu');
INSERT INTO Erreur VALUES (10047,''','' attendu');
INSERT INTO Erreur VALUES (10048,'''THEN'' attendu');
INSERT INTO Erreur VALUES (10049,'Duplication d''expression');
INSERT INTO Erreur VALUES (10050,'Duplication d''�num�ration');
INSERT INTO Erreur VALUES (10051,'Variable de la structure dupliqu�');
INSERT INTO Erreur VALUES (10052,'Duplication de d�finition d''unit�');
INSERT INTO Erreur VALUES (10053,'Variable dupliqu�');
INSERT INTO Erreur VALUES (10054,'Instruction ''AS'' attendu');
INSERT INTO Erreur VALUES (10055,'''TO'' attendu');
INSERT INTO Erreur VALUES (10056,'Ctrl+Break enfonc�');
INSERT INTO Erreur VALUES (10057,'Variable introuvable');
INSERT INTO Erreur VALUES (10058,'�NEXT� sans �FOR�');
INSERT INTO Erreur VALUES (10059,'''#'' attendu');
INSERT INTO Erreur VALUES (10060,'Appel de fonction invalide');
INSERT INTO Erreur VALUES (10061,'''$'' attendu');
INSERT INTO Erreur VALUES (10062,'Trop de ''GOSUB''');
INSERT INTO Erreur VALUES (10063,'Instruction �RETURN� sans instruction �GOSUB�');
INSERT INTO Erreur VALUES (10064,'Instruction �WHILE� sans instruction �WEND�');
INSERT INTO Erreur VALUES (10065,'�WEND� mal plac�');
INSERT INTO Erreur VALUES (10066,'Image trop grosse');
INSERT INTO Erreur VALUES (10067,'Duplication d''�tiquette!');
INSERT INTO Erreur VALUES (10068,'Constante dupliqu�');
INSERT INTO Erreur VALUES (10069,'Nombre invalide');
INSERT INTO Erreur VALUES (10070,'Utilise un mot r�serv� PASCAL comme variable');
INSERT INTO Erreur VALUES (10071,'Identificateur �ITEM� attendu');
INSERT INTO Erreur VALUES (10072,'�TRUE� attendu');
INSERT INTO Erreur VALUES (10073,'Appel externe attendu');
INSERT INTO Erreur VALUES (10074,'Identificateur valide attendu');
INSERT INTO Erreur VALUES (10075,'Nombre attendu');
INSERT INTO Erreur VALUES (10076,'Nombre entre 1 et 9 attendu');
INSERT INTO Erreur VALUES (10080,'�num�ration vide');
INSERT INTO Erreur VALUES (10081,'Structure vide');
INSERT INTO Erreur VALUES (10096,'Trop de r�pertoire dans l''ent�te');
INSERT INTO Erreur VALUES (10097,'Trop de message d''attention');
INSERT INTO Erreur VALUES (10098,'Identificateur inconnue');
INSERT INTO Erreur VALUES (10099,'Type inconnu');
INSERT INTO Erreur VALUES (10100,'Erreur de syntaxe');
INSERT INTO Erreur VALUES (10101,'Erreur de nombre');
INSERT INTO Erreur VALUES (10102,'Erreur de syntaxe d''un enregistrement');
INSERT INTO Erreur VALUES (10124,'�PROGRAM� mal plac�');
INSERT INTO Erreur VALUES (10125,'�NEXT� mal plac�');
INSERT INTO Erreur VALUES (10126,'�ELSE� mal plac�');
INSERT INTO Erreur VALUES (10127,'�BEGIN� mal plac�');
INSERT INTO Erreur VALUES (10128,'Directive conditionnel mal plac�');
INSERT INTO Erreur VALUES (10129,'Fin de symbole mal plac�');
INSERT INTO Erreur VALUES (10130,'�;� mal plac�');
INSERT INTO Erreur VALUES (10131,'�UNIT� mal plac�');
INSERT INTO Erreur VALUES (10132,'�USES� mal plac�');
INSERT INTO Erreur VALUES (10133,'�INTERFACE� mal plac�');
INSERT INTO Erreur VALUES (10134,'�IMPLEMENTATION� mal plac�');
INSERT INTO Erreur VALUES (10135,'�INITIALIZATION� mal plac�');
INSERT INTO Erreur VALUES (10136,'�FINALIZATION� mal plac�');
INSERT INTO Erreur VALUES (10139,'Trop de boucle');
INSERT INTO Erreur VALUES (10140,'Nombre trop grand');
INSERT INTO Erreur VALUES (10141,'Type incompatible');
INSERT INTO Erreur VALUES (10150,'Instruction pour 80186');
INSERT INTO Erreur VALUES (10151,'Instruction pour 80286');
INSERT INTO Erreur VALUES (10152,'Instruction coprocesseur math�matique 80287');
INSERT INTO Erreur VALUES (10153,'Instruction pour 80386');
INSERT INTO Erreur VALUES (10154,'Instruction coprocesseur math�matique 80387');
INSERT INTO Erreur VALUES (10180,'D�passement d''index');
INSERT INTO Erreur VALUES (10198,'Unit� introuvable');
INSERT INTO Erreur VALUES (10199,'Fichier non ouvert');
INSERT INTO Erreur VALUES (10200,'Fichier introuvable');
INSERT INTO Erreur VALUES (10201,'Impossible de cr�er le fichier');
INSERT INTO Erreur VALUES (10202,'Erreur de lecture du fichier');
INSERT INTO Erreur VALUES (10254,'Manque de m�moire');
INSERT INTO Erreur VALUES (10255,'Erreur interne');
INSERT INTO Erreur VALUES (10256,'Erreur de param�tre(s) interne');
INSERT INTO Erreur VALUES (10401,'Fichier ressource non sp�cifi�');
 /* Erreur SQL et de donn�es */
INSERT INTO Erreur VALUES (10701,'Erreur de traitement SQL');
INSERT INTO Erreur VALUES (10702,'Base de donn�es trop grande');
INSERT INTO Erreur VALUES (10703,'Manque de �DATA�');
INSERT INTO Erreur VALUES (10704,'�FROM� attendu');
INSERT INTO Erreur VALUES (10705,'Nom de la table attendu');
INSERT INTO Erreur VALUES (10706,'Commande non reconnue');
 /* Erreur de format */
INSERT INTO Erreur VALUES (15001,'Aucun renseignement sur le �MP3�');
INSERT INTO Erreur VALUES (15002,'Erreur d''impression dans un fichier');
INSERT INTO Erreur VALUES (15003,'Police de caract�res introuvable');
INSERT INTO Erreur VALUES (15004,'Erreur de structure de fichier');
INSERT INTO Erreur VALUES (15005,'Fichier corrompu');
INSERT INTO Erreur VALUES (15006,'Ent�te de fichier invalide');
INSERT INTO Erreur VALUES (15007,'Donn�es du fichier invalide');
INSERT INTO Erreur VALUES (15008,'Pas de "Samples" dans le fichier sonore');
INSERT INTO Erreur VALUES (15009,'Aucune police de caract�res n''a �t� trouv�');
INSERT INTO Erreur VALUES (15010,'Technique de compression inconnue');
 /* Erreur de compression du format de fichier ZIP */
INSERT INTO Erreur VALUES (16001,'Erreur CRC');
INSERT INTO Erreur VALUES (16002,'Probl�me d''�criture');
INSERT INTO Erreur VALUES (16003,'Probl�me de lecture');
INSERT INTO Erreur VALUES (16004,'Fichier ZIP');
INSERT INTO Erreur VALUES (16005,'Abord� par l''utilisateur');
INSERT INTO Erreur VALUES (16006,'Format non support�');
INSERT INTO Erreur VALUES (16007,'Encryptage');
INSERT INTO Erreur VALUES (16008,'Erreur dans l''utilisation');
INSERT INTO Erreur VALUES (16009,'Erreur interne');
INSERT INTO Erreur VALUES (16010,'Plus d''item');
INSERT INTO Erreur VALUES (16011,'Fichier');
INSERT INTO Erreur VALUES (16012,'Aucun ZIP trouv�');
INSERT INTO Erreur VALUES (16013,'Ent�te trop large');
INSERT INTO Erreur VALUES (16014,'Erreur d''ouverture de fichier');
INSERT INTO Erreur VALUES (16100,'Erreur s�rieuse');
INSERT INTO Erreur VALUES (16500,'Param�tres attendu');
 /* Erreur interface */
INSERT INTO Erreur VALUES (20001,'Erreur de lecture du Bureau');
INSERT INTO Erreur VALUES (20002,'Impossible d''�diter le Bureau');
INSERT INTO Erreur VALUES (20003,'Journal de bord introuvable');
INSERT INTO Erreur VALUES (20004,'�Passe� avant un �Copie�');
INSERT INTO Erreur VALUES (20005,'�Copie� incompatible');
INSERT INTO Erreur VALUES (20006,'Aucun fichier correspondant trouv�');
INSERT INTO Erreur VALUES (20007,'Impossible de cr�er un fichier de bureau');
INSERT INTO Erreur VALUES (20008,'Fonctionnalit� non disponible dans ce contexte');
INSERT INTO Erreur VALUES (20009,'Confirmation invalide! Veuillez retaper le mot de passe car ils ne sont pas identitique');
INSERT INTO Erreur VALUES (20010,'Nombre de copie d''impression invalide');
INSERT INTO Erreur VALUES (20011,'Impossible de renommer votre nom de r�pertoire');
INSERT INTO Erreur VALUES (20012,'Vous n''avez pas de fen�tre ouverte');
INSERT INTO Erreur VALUES (20013,'Mod�le d''application introuvable');
INSERT INTO Erreur VALUES (20014,'Recherche infructueuse');
INSERT INTO Erreur VALUES (20015,'Commande invalide');
INSERT INTO Erreur VALUES (20016,'Cha�ne de caract�res introuvable');
INSERT INTO Erreur VALUES (20017,'Proc�dure introuvable');
INSERT INTO Erreur VALUES (20101,'Taille du presse-papier trop gros');
INSERT INTO Erreur VALUES (20102,'Impossible d''ouvrir le Presse-Papier');
INSERT INTO Erreur VALUES (20103,'Le Presse-Papier n''est pas disponible. Ex�cuter cette fonction � l''int�rieur d''une session Windows-DOS');
INSERT INTO Erreur VALUES (20104,'Syst�me vid�o secondaire inexistant. Impossible d''effectuer une analyse');
 /* Erreur d'installation d'interface */
INSERT INTO Erreur VALUES (21001,'Probl�me d''enregistrement de l''�AUTOEXEC.BAT�');
INSERT INTO Erreur VALUES (21002,'Probl�me de lecture de l''�AUTOEXEC.BAT�! Op�ration de modification abandonner');
INSERT INTO Erreur VALUES (21003,'Non disponible dans cette distribution');
 /* Appel d'application externe */
INSERT INTO Erreur VALUES (22001,'Compilateur associ�e introuvable');
INSERT INTO Erreur VALUES (22002,'Programme de liaison introuvable');
INSERT INTO Erreur VALUES (22003,'Programme de traitement introuvable');
INSERT INTO Erreur VALUES (22004,'Erreur de sortie de liaison');
INSERT INTO Erreur VALUES (22005,'Erreur de sortie du compilateur');
INSERT INTO Erreur VALUES (22006,'Conversion associ�e introuvable');
 /* Erreur application */
INSERT INTO Erreur VALUES (31001,'Trop de num�ro de t�l�phone');
INSERT INTO Erreur VALUES (31002,'Plus de place pour une nouvelle personne dans l''agenda');
INSERT INTO Erreur VALUES (31003,'Plus de place pour une nouvelle personne dans la base de donn�es');
INSERT INTO Erreur VALUES (31004,'Personne introuvable');
INSERT INTO Erreur VALUES (31101,'Palette non-support�e');
INSERT INTO Erreur VALUES (31102,'Point en dehors des limites permises');
INSERT INTO Erreur VALUES (31201,'Demande incoh�rente. Une seule page existe');
INSERT INTO Erreur VALUES (31301,'Image introuvable ou incompr�hensible');
INSERT INTO Erreur VALUES (31501,'Impossible d''enregistrer le titre');
