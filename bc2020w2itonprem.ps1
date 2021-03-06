$containerName = 'bc2020w2iton'
$password = 'P@ssw0rd'
$securePassword = ConvertTo-SecureString -String $password -AsPlainText -Force
$credential = New-Object pscredential 'admin', $securePassword
$auth = 'UserPassword'
$artifactUrl = Get-BcArtifactUrl -type 'Onprem' -country 'it' -select 'Latest'
$licenseFile = 'C:\lic\lic.flf'

New-BcContainer `
    -accept_eula `
    -containerName $containerName `
    -credential $credential `
    -auth $auth `
    -artifactUrl $artifactUrl `
    -imageName 'bc2020w2iton' `
    -multitenant:$false `
    -assignPremiumPlan `
    -licenseFile $licenseFile `
    -dns '8.8.8.8' `
    -memoryLimit 4G `
    -useSSL `
    -shortcuts Desktop