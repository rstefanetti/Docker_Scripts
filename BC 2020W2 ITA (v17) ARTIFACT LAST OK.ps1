# *** PRE-REQUIREMENTS FOR CONTAINERS ON WINDOWS SERVER 2019
# *** WINDOWS SERVER 2019 - CONTAINERS FEATURE
Install Containers
Install-WindowsFeature -Name Containers
Uninstall-WindowsFeature Windows-Defender
Restart-Computer -Force
  
# *** DOCKER MODULES - Install, update and Run Docker Service
uninstall-Module -Name DockerMsftProvider 
uninstall-Package -Name docker 
Install-Module -Name DockerMsftProvider -Repository PSGallery -Force
Install-Package -Name docker -ProviderName DockerMsftProvider -Force
Install-Package -Name Docker -ProviderName DockerMsftProvider -Update -Force

# *** DOCKER START
Stop-Service Docker
Start-Service Docker

# *** TEST DOCKER PULL *** 
#docker pull microsoft/dotnet-samples:dotnetapp-nanoserver-1809

...IF YOU ARE OK!



# *** BCCONTAINER BC17ITAONPREMISE
# *** REMOVE BCContainer ***
# remove-BcContainer -containerName bc17itaOP
# uninstall-module BCcontainerhelper -force

install-module BCcontainerhelper -force 

#Variables
$containerName = 'bc17ita'  #LOWERCASE NAME
$password = '$Pass@ord!'
$securePassword = ConvertTo-SecureString -String $password -AsPlainText -Force
$credential = New-Object pscredential 'admin', $securePassword
$auth = 'UserPassword'
$artifactUrl = Get-BcArtifactUrl -type 'onprem' -country 'it' -select 'Latest'  
$licenseFile = 'C:\LIC\Lic.flf'

#Publish Minimal Ports - normal and SSL
#$additionalParameters = @("--publish 8080:8080",
#                          "--publish 443:443", 
#                          "--publish 7046-7049:7046-7049")


# *** CREATE BC17 ITA CONTAINER
New-BcContainer `
    -accept_eula `
    -useSSL `
    -containerName $containerName `
    -credential $credential `
    -auth $auth `
    -artifactUrl $artifactUrl `
    -imageName $containerName `
    -multitenant:$false `
    -assignPremiumPlan `
    -licenseFile $licenseFile `
    -dns '8.8.8.8' `
    -memoryLimit 4G `
    -updateHosts 
    #-additionalParameters $additionalParameters `   #Publish Ports

     
# *** RUN DOCKER IMAGE - MANUAL STARTING
#docker run -e accept_eula=Y -m 4G bc17itaOP



#ARTIFACTS LIST
Write-Host -ForegroundColor Yellow "Get all ITA NAV and Business Central artifact urls"
Get-BCArtifactUrl -type OnPrem -country "it" -select All

Write-Host -ForegroundColor Yellow "Get all IT sandbox artifact urls"
Get-BCArtifactUrl -type Sandbox -country "it" -select All