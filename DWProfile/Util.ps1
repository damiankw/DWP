# Set a new password in the system
Function Set-Password () {
  # Get the password from the user and push it into a variable
  Read-Host "Enter Password" -AsSecureString | ConvertFrom-SecureString | ForEach { $Global:TmpPass = $_ }

  # Set the Environment Variable in the system
  [Environment]::SetEnvironmentVariable( "USR_PW", $Global:TmpPass, [System.EnvironmentVariableTarget]::User )

  # Set to local Environment Variables (as the above resets to $Null)
  $env:USR_PW = $Global:TmpPass

  # Remove the temporary password storage
  Remove-Variable Global:TmpPass

  Write-Host "DWP:> Password has been updated. Re-Initialising Credentials ..."

  Set-Credentials
}

# Set up the credential variables
Function Set-Credentials () {
  $Global:USR_ADM = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $Global:USR_ADM,($($env:USR_PW) | ConvertTo-SecureString)
  $Global:USR_STD = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $Global:USR_STD,($($env:USR_PW) | ConvertTo-SecureString)
  $Global:USR_365 = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $Global:USR_EML,($($env:USR_PW) | ConvertTo-SecureString)
}


# Open up dsa.msc as Administrator
Function AD () {
  Start-Process PowerShell -Credential $USR_ADM -ArgumentList “Start-Process -FilePath $env:SystemRoot\System32\mmc.exe -WorkingDirectory $PSHOME -ArgumentList $env:SystemRoot\System32\dsa.msc -Verb RunAs” > tmp.txt
}

# Print out the MOTD
Function Display-MOTD () {
  Clear-Host
  Write-Host ("     --------------------------------------------------------------------------------------------------------------")
  Write-Host ("     |                                                                                                            |")
  Write-Host ("     |      '/yo///+++y        +N.       'mmho///ommmm:    -/smmmm.    ommmd//        dy       :+dmmms   :+do/    |")
  Write-Host ("     |     /NMs     'hm       -MMd       'Ms    -NMMN:       /yMMMd   .hNMMm         yMM+        hsMMMm.   h.     |")
  Write-Host ("     |    +MMM/      '+      .dMMMs      'o    +MMMm.        /o+MMM+  h.NMMm        +NMMM-       h':NMMN/  h.     |")
  Write-Host ("     |    NMMM/             'h.yMMM/         'yMMMy'         /o dMMN.++ NMMm       :s.NMMm'      h' 'hMMMy'h.     |")
  Write-Host ("     |    NMMM/  .......'   y- 'mMMN.       .dMMM+           /o -MMMdh  NMMm      .h  :MMMh      h'   +MMMmd.     |")
  Write-Host ("     |    oMMM/  .-hMMM/'  oy+++oNMMm'     :NMMN:    sh      /o  oMMM.  NMMm     'ho+++hMMMo     h'    -mMMM.     |")
  Write-Host ("     |     +NM+    yMMN.  /s     /MMMy    oMMMd.   'sMh      /o   mMo   NMMm     y-     hMMM-    h'     'hMM.     |")
  Write-Host ("     |      '+ho++ody/' /omo/'  :/dNNNo/ oNNNm+//+smNNs    -/yh+- -d  //mNNm//'/yd+:   /oNNNd/-:+mo/.     +M.     |")
  Write-Host ("     |                                                                                                            |")
  Write-Host ("     --------------------------------------------------------------------------------------------------------------")
}

# Load the required modules
Function Load-Modules() {
  Load-Module-Check ActiveDirectory
  Load-Module-Check Hyper-V
  Load-Module-Check GroupPolicy
  Load-Module-Check Asshole
}

Function Load-Module-Check($Module) {
  $ErrorActionPreference = "Stop";
  Write-Host -NoNewline "DWP:> Loading $Module Module ... "

  Try {
    Import-Module $Module | Out-Null
    Write-Host "OK!"
  } Catch {
    Write-Warning "FAILED!"
  }

  $ErrorActionPreference = "Continue";
}

Function Connect-Office365() {
  $ErrorActionPreference = "Stop";
  $Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $Global:USR_365 -Authentication Basic -AllowRedirection
  Import-PSSession $Session
  $ErrorActionPreference = "Continue";
}