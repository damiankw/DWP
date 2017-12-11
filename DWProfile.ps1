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

# Configure user credentials
Write-Host -NoNewline "DWP:> Configuring user credentials ... "
Try {
  Set-Credentials
  Write-Host "OK!"
} Catch {
  Write-Host "FAILED!"
}

# Load PowerShell Modules
Write-Host "DWP:> Loading PS Modules ..."
Load-Modules

# Connect O365
Write-Host -NoNewline "DWP:> Connecting to Office 365 ... "
Try {
  Connect-Office365
  Write-Host "OK!"
} Catch {
  Write-Warning "FAILED!"
}


# Load custom scripts
# Load custom alias
# Start logging (not sure if we need this)
# 
