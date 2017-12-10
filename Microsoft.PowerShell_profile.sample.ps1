# Your Standard login
$USR_STD = "DOMAIN\username"

# Your Administrator login
$USR_ADM = "DOMAIN\admusername"

# Your Office 365 login
$USR_365 = "admin@address.com.au"

# Your email address
$USR_EML = "email@address.com.au"

Split-Path $profile | foreach { . $_\DWProfile.ps1 }