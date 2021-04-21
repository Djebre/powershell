# _____           _       _                                      _          _ _ 
#/  ___|         (_)     | |                                    | |        | | |
#\ `--.  ___ _ __ _ _ __ | |_   _ __   _____      _____ _ __ ___| |__   ___| | |
# `--. \/ __| '__| | '_ \| __| | '_ \ / _ \ \ /\ / / _ \ '__/ __| '_ \ / _ \ | |
#/\__/ / (__| |  | | |_) | |_  | |_) | (_) \ V  V /  __/ |  \__ \ | | |  __/ | |
#\____/ \___|_|  |_| .__/ \__| | .__/ \___/ \_/\_/ \___|_|  |___/_| |_|\___|_|_|
#                  | |         | |                                              
#                  |_|         |_|                                              

param ([string]$processname, [string]$arguments, [switch]$hidden = $false)

$psi = new-object System.Diagnostics.ProcessStartInfo
$psi.FileName = $processname
$psi.Arguments = $arguments

if ($hidden)
{
$psi.WindowStyle = hidden
}





Write-Output "Sc"
Get-LocalUser| Select-Object Name

#Export-Csv C:\Users\mscha\Desktop\Aubin\resultats.csv -Encoding "UTF8"
