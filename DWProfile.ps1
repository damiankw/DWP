# Load the scripts
Write-Host -NoNewline "DWP:> Loading DWProfile scripts ..."
Try {
  $ProfilePath = Split-Path $profile
  
  Get-ChildItem $ProfilePath\DWProfile | ForEach { . $ProfilePath\DWProfile\$_ }
} Catch {
  Write-Host "ERROR!"
} Finally {
  Write-Host "OK!"
}

Write-Host -NoNewline "DWP:> Checking password environment variable ..."
If ($env:USR_PW -eq $null) {
  Write-Host " ERROR!"
  Write-Host "> You have not yet configured your password."
  Write-Host "> In order to generate your passwords, please use Set-Password."

  Exit
} Else {
  Write-Host "OK!"
}

Write-Host "DWP:> Loading PS Modules ..."

Load-Modules
# Load PowerShell Modules
Import-module ActiveDirectory
Import-Module Hyper-V
Import-Module GroupPolicy
Import-Module ServerManager

# Load DWProfile Core Scripts


# Load custom scripts
# Load custom alias
# Start logging (not sure if we need this)
# 
