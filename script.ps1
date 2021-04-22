# _____           _       _                                      _          _ _ 
#/  ___|         (_)     | |                                    | |        | | |
#\ `--.  ___ _ __ _ _ __ | |_   _ __   _____      _____ _ __ ___| |__   ___| | |
# `--. \/ __| '__| | '_ \| __| | '_ \ / _ \ \ /\ / / _ \ '__/ __| '_ \ / _ \ | |
#/\__/ / (__| |  | | |_) | |_  | |_) | (_) \ V  V /  __/ |  \__ \ | | |  __/ | |
#\____/ \___|_|  |_| .__/ \__| | .__/ \___/ \_/\_/ \___|_|  |___/_| |_|\___|_|_|
#                  | |         | |                                              
#                  |_|         |_|                                              


#Get-LocalUser | Where-Object PrincipalSource


#Get-LocalUser| Select-Object Name
#Get-LocalUser | Export-Csv C:\Users\mscha\Desktop\Aubin\resultats.csv -NoTypeInformation -Encoding "UTF8" 

#TODO: check si l'event existe deja
New-EventLog -LogName Application -Source "AcountSecurity"

$path = "C:\temp\ScriptRessource"
$old = "C:\temp\ScriptRessource\old.csv"
$new = "C:\temp\ScriptRessource\new.csv"
If(!(test-path $path))
{
    New-Item -ItemType Directory -Force -Path $path
}

if (!(Test-Path $old))
{
    #Get-LocalUser | Select-Object FullName,PasswordChangeableDate,PasswordExpires,UserMayChangePassword,PasswordRequired,PasswordLastSet,LastLogon | Export-Csv -Path $path\resultats.csv -NoTypeInformation -Encoding "UTF8" 
    Get-LocalUser  | Export-Csv -Path $old -NoTypeInformation -Encoding "UTF8" 
}else {
    Get-LocalUser  | Export-Csv -Path $new -NoTypeInformation -Encoding "UTF8"
    $ocsv = Import-CSV $old -Delimiter ";"
    $ncsv = Import-CSV $path\new.csv -Delimiter ";"
    if( $null -ne (Compare-Object -ReferenceObject $ocsv -DifferenceObject $ncsv -Property "Name") ){
        Write-EventLog -LogName Application -Source "AcountSecurity" -EntryType Warning -EventId 666 -Message "New local acount detected"
    }
    Rename-Item -Path $new -NewName $old
}
