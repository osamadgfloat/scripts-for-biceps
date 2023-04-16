# az vm access update -n ${virtualMachine.name} -g ${resourceGroup().name} --enable-vm-access --reset-remote-desktop


$ProgressPreference = 'SilentlyContinue'; Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile .\AzureCLI.msi; Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet'; Remove-Item .\AzureCLI.msi

az upgrade

winget install -e --id Microsoft.Bicep

winget install Microsoft.DotNet.DesktopRuntime.7

Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

choco install -y nvm

nvm install 16.20.0

npm install --global --production windows-build-tools