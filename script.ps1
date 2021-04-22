# _____           _       _                                      _          _ _ 
#/  ___|         (_)     | |                                    | |        | | |
#\ `--.  ___ _ __ _ _ __ | |_   _ __   _____      _____ _ __ ___| |__   ___| | |
# `--. \/ __| '__| | '_ \| __| | '_ \ / _ \ \ /\ / / _ \ '__/ __| '_ \ / _ \ | |
#/\__/ / (__| |  | | |_) | |_  | |_) | (_) \ V  V /  __/ |  \__ \ | | |  __/ | |
#\____/ \___|_|  |_| .__/ \__| | .__/ \___/ \_/\_/ \___|_|  |___/_| |_|\___|_|_|
#                  | |         | |                                              
#                  |_|         |_|                                              

if ([System.Diagnostics.EventLog]::Exists('Application') -and [System.Diagnostics.EventLog]::SourceExists("AcountSecurity"))
{
Write-Output "Application déjà lancée."
}
else
{
New-EventLog -LogName Application -Source "AcountSecurity"
}

$path = "C:\temp\ScriptRessource"
$old = $path+"\old.csv"
$new = $path+"\new.csv"
If(!(Test-path $path))
{
    New-Item -ItemType Directory -Force -Path $path
}

if (!(Test-Path $old))
{
    #Get-LocalUser | Select-Object FullName,PasswordChangeableDate,PasswordExpires,UserMayChangePassword,PasswordRequired,PasswordLastSet,LastLogon | Export-Csv -Path $path\resultats.csv -NoTypeInformation -Encoding "UTF8" 
    Get-LocalUser  | Export-Csv -Path $old -NoTypeInformation -Encoding "UTF8"
}
else 
{
    #Get-LocalUser  | Export-Csv -Path $new -NoTypeInformation -Encoding "UTF8"
    $ocsv = Import-CSV  $old -Delimiter ","
    $ncsv = Import-CSV  $new -Delimiter ","
    $res = Compare-Object -ReferenceObject $ocsv -DifferenceObject $ncsv -Property Fullname
    if($res){
        Write-Output "Différence trouvé"
        Write-EventLog -LogName Application -Source "AcountSecurity" -EntryType Warning -EventId 666 -Message "New local acount detected."
    }
    else 
    {
    Write-Output "Pas de diff"
    }
    #Remove-Item -Path $old
    #Rename-Item -Path $new -NewName $old
}
#$ocsv | Format-Table
#$ncsv | Format-Table
#Compare-Object -ReferenceObject $ocsv -DifferenceObject $ncsv -Property Fullname
