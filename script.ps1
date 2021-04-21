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

$path = "C:\temp\ScriptRessource" 
If(!(test-path $path))
{
New-Item -ItemType Directory -Force -Path $path
}

if (!(Get-ChildItem -Path $path -Recurse -Include *.csv))
{
#Get-LocalUser | Select-Object FullName,PasswordChangeableDate,PasswordExpires,UserMayChangePassword,PasswordRequired,PasswordLastSet,LastLogon | Export-Csv -Path $path\resultats.csv -NoTypeInformation -Encoding "UTF8" 
Get-LocalUser  | Export-Csv -Path $path\resultats.csv -NoTypeInformation -Encoding "UTF8" 
}

