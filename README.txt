# _____           _       _                                      _          _ _ 
#/  ___|         (_)     | |                                    | |        | | |
#\ `--.  ___ _ __ _ _ __ | |_   _ __   _____      _____ _ __ ___| |__   ___| | |
# `--. \/ __| '__| | '_ \| __| | '_ \ / _ \ \ /\ / / _ \ '__/ __| '_ \ / _ \ | |
#/\__/ / (__| |  | | |_) | |_  | |_) | (_) \ V  V /  __/ |  \__ \ | | |  __/ | |
#\____/ \___|_|  |_| .__/ \__| | .__/ \___/ \_/\_/ \___|_|  |___/_| |_|\___|_|_|
#                  | |         | |                                              
#                  |_|         |_|                                              

Auteurs : Schalss Martin, Louazel Yoann


- - - - - - - - - DESCRIPTION - - - - - - - -

Ce script PowerShell liste les utilisateurs locaux de la machine sur laquelle il est lancé.
Le dossier de destination de la liste des utilisateurs se trouve dans le répertoire : C:\Temp\ScriptRessource

A chaque modification de la liste, une alerte est créée, visible dans l'observateur d'événement -> Journaux Windows -> Application

    Source : AcountSecurity
    Evenement : 666
    Niveau : Avertissement
    General : New local acount detected.


- - - - - - - - - PREREQUIS - - - - - - - - -

Afin de garantir le bon fonctionnement de ce script, il est nécessaire de le lancer en mode administrateur.
Il est également recommandé de le lancé au démarrage de Windows, dans le Le planificateur de tâches, pour une exécution automatique.

Voir ce lien : https://akril.net/execution-programmee-dun-script-powershell/


Il est également possible d'automatiser le lancement de ce script via une GPO :

Pour exécuter un script PowerShell via une stratégie de groupes (GPO)
Il vous suffit de créer votre GPO, de la connecter à la bonne OU qui vous intéresse puis de vous diriger dans l’une des sections suivantes :

 *   Computer Configuration > Policies > Windows Settings > Scripts (Startup/Shutdown), si vous souhaitez que votre script s’exécute lors du démarrage ou de l’arrêt de votre serveur / machine ;
 *   User Configuration > Policies > Windows Settings > Scripts (Logon/Logoff), si vous souhaitez que votre script s’exécute lors de la connexion ou déconnexion d’un utilisateur.

Il suffit de cliquez sur le bouton “Add” et de sélectionner le script qui vous intéresse.

Voir : https://akril.net/execution-de-script-powershell-via-une-gpo/
