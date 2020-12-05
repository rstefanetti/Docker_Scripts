
#ARTIFACTS LIST
Write-Host -ForegroundColor Yellow "Get all ITA NAV and Business Central artifact urls"
Get-BCArtifactUrl -type OnPrem -country "it" -select All


Write-Host -ForegroundColor Yellow "Get all IT sandbox artifact urls"
Get-BCArtifactUrl -type Sandbox -country "it" -select All



#ONPREM LIST

#SANDBOX LIST


