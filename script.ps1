# _____           _       _                                      _          _ _ 
#/  ___|         (_)     | |                                    | |        | | |
#\ `--.  ___ _ __ _ _ __ | |_   _ __   _____      _____ _ __ ___| |__   ___| | |
# `--. \/ __| '__| | '_ \| __| | '_ \ / _ \ \ /\ / / _ \ '__/ __| '_ \ / _ \ | |
#/\__/ / (__| |  | | |_) | |_  | |_) | (_) \ V  V /  __/ |  \__ \ | | |  __/ | |
#\____/ \___|_|  |_| .__/ \__| | .__/ \___/ \_/\_/ \___|_|  |___/_| |_|\___|_|_|
#                  | |         | |                                              
#                  |_|         |_|                                              

#On test si l'événement est déjà lancé
if ([System.Diagnostics.EventLog]::Exists('Application') -and [System.Diagnostics.EventLog]::SourceExists("AcountSecurity"))
{
Write-Output "Application déjà lancée."
}
else
{
#On ajoute un object de type "EventLog" avec le nom "AcountSecurity"
New-EventLog -LogName Application -Source "AcountSecurity"
}

$path = "C:\Temp\ScriptRessource"
$old = $path+"\old.csv"
$new = $path+"\new.csv"

#Si le dossier "C:\Temp\ScriptRessource" n'existe pas, alors...
If(!(Test-path $path))
{
    #On le créer
    New-Item -ItemType Directory -Force -Path $path
}

#Si le fichier "C:\Temp\ScriptRessource\old.csv" n'existe pas, alors...
if (!(Test-Path $old))
{
    #On exporte une première fois la liste des utilisateurs dans un format CSV avec le nom old.csv
    Get-LocalUser | Export-Csv -Path $old -NoTypeInformation -Encoding "UTF8"
}
else 
{
    #On exporte la liste des utilisateurs dans un format CSV avec le nom "new.csv"
    Get-LocalUser  | Export-Csv -Path $new -NoTypeInformation -Encoding "UTF8"
    #On importe les 2 CSV
    $ocsv = Import-CSV  $old -Delimiter ","
    $ncsv = Import-CSV  $new -Delimiter ","
    #On compare les 2 CSV, puis on stocke la différence dans une variable
    $res = Compare-Object -ReferenceObject $ocsv -DifferenceObject $ncsv -Property Fullname
    #Si il y a une différence, alors...
    if($res){
        #On crée une alerte de type "Warning" avec l'identifiant 666, visible dans l'observateur d'événements
        Write-EventLog -LogName Application -Source "AcountSecurity" -EntryType Warning -EventId 666 -Message "Modification des comptes détecté."
        #On remplace l'ancien fichier par le nouveau        
        Remove-Item -Path $old
        Rename-Item -Path $new -NewName $old
    }
}
