# Load the scripts
Write-Host -NoNewline "DWP:> Loading DWProfile scripts ..."
Try {
  $ProfilePath = Split-Path $profile
  
  Get-ChildItem $ProfilePath\DWProfile | ForEach { . $ProfilePath\DWProfile\$_ }
  Write-Host "OK!"
} Catch {
  Write-Host "FAILED!"
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

# Start tracking modules/scripts
$Global:DWPLoaded = @()

# Configure user credentials
Write-Host -NoNewline "DWP:> Configuring user credentials ... "
Try {
  Set-Credentials
  $Global:DWPLoaded = $Global:DWPLoaded + "Credentials"
  Write-Host "OK!"
} Catch {
  Write-Host "FAILED!"
}

# Load PowerShell Modules
Write-Host "DWP:> Loading PS Modules ..."
Load-Modules

#Write-Host "DWP:> Connecting Exchange."
#Connect-Exchange

# Load custom scripts
# Load custom alias
# Start logging (not sure if we need this)
# 

Display-MOTD
