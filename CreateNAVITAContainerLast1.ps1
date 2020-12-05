remove-module navcontainerhelper 
remove-module BCcontainerhelper 
install-module navcontainerhelper -force
get-command -Module navcontainerhelper
Write-NavContainerHelperWelcomeText

Publish-NavContainerApp -containerName "test" -appFile "c:\temp\my.app" -skipVerification -sync -install


New-NavContainer -accept_eula -containerName "test" -auth NavUserPassword -imageName "microsoft/dynamics-nav"



Publish-NavContainerApp -containerName "test" -appFile "c:\temp\my.app" -skipVerification -sync -install

Import-ObjectsToNavContainer -containerName "test" -objectsFile "C:\temp\mysolution.fob" -sqlCredential $databaseCredential

Import-NavContainerLicense -containerName test -licenseFile "https://www.dropbox.com/s/abcdefghijkl/my.flf?dl=1"


New-NavContainerNavUser -containerName test -Credential $navcredential


#Get-BcContainerEventLog -containerName NAV2018ITA to retrieve a snapshot of the event log from the container
#Get-BcContainerDebugInfo -containerName NAV2018ITA to get debug information about the container
#Enter-BcContainer -containerName NAV2018ITA to open a PowerShell prompt inside the container
#Remove-BcContainer -containerName NAV2018ITA to remove the container again
#docker logs NAV2018ITA to retrieve information about URL's 




$imageName = "microsoft/dynamics-nav:2018-it"
$containerName = "NAV2018ITA"
$license = "C:\lic\lic.flf"


$securePassword = ConvertTo-SecureString -String "P@ssword1" -AsPlainText -Force
$navcredential = New-Object System.Management.Automation.PSCredential -argumentList "admin", (ConvertTo-SecureString -String "P@ssword1" -AsPlainText -Force)

if ($navcredential -eq $null -or $navcredential -eq [System.Management.Automation.PSCredential]::Empty) {
    $navcredential = get-credential -UserName "admin" -Message "Enter NAV Super User Credentials"
}


#$hostFolder = "c:\temp\navdbfiles"
#$databaseCredential = New-Object System.Management.Automation.PSCredential -argumentList "sa", (ConvertTo-SecureString -String "P@ssword1" -AsPlainText -Force)
#$dbPassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($databaseCredential.Password))
#$dbserverid = docker run -d -e sa_password="$dbPassword" -e ACCEPT_EULA=Y -v "${hostFolder}:C:/temp" microsoft/mssql-server-windows-express
#$databaseServer = $dbserverid.SubString(0,12)
#$databaseInstance = ""
#$databaseName = "Demo Database NAV (11-0)"
#$databaseServerInstance = @{ $true = "$databaseServer\$databaseInstance"; $false = "$databaseServer"}["$databaseInstance" -ne ""]
#$RelocateData = New-Object Microsoft.SqlServer.Management.Smo.RelocateFile("${databaseName}_Data", "c:\temp\${databaseName}_Data.mdf")
#$RelocateLog = New-Object Microsoft.SqlServer.Management.Smo.RelocateFile("${databaseName}_Log", "c:\temp\${databaseName}_Log.ldf")
#Restore-SqlDatabase -ServerInstance $databaseServerInstance -Database $databaseName -BackupFile "C:\temp\$databaseName.bak" -Credential $databaseCredential -RelocateFile @($RelocateData,$RelocateLog)


$additionalParameters = @("--publish 8080:8080",
                          "--publish 443:443", 
                          "--publish 7046-7049:7046-7049")


New-NavContainer -accept_eula `
                 -useSSL `
                 -containerName $containerName `
                 -auth NavUserPassword `
                 -imageName $imageName `
                 -credential $navcredential `
                 -additionalParameters $additionalParameter `
                 -includeCSIDE `
                 -doNotExportObjectsToText `
                 #-licenseFile $license

                



#Get-BcContainerEventLog -containerName NAV2018ITA to retrieve a snapshot of the event log from the container
#Get-BcContainerDebugInfo -containerName NAV2018ITA to get debug information about the container
#Enter-BcContainer -containerName NAV2018ITA to open a PowerShell prompt inside the container
#Remove-BcContainer -containerName NAV2018ITA to remove the container again
#docker logs NAV2018ITA to retrieve information about URL's again






